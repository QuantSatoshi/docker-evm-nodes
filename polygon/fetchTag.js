const https = require('https');
const fs = require('fs');

async function webhook(text) {
  // read .env file
  const envFileContent = fs.readFileSync(__dirname + '/.env', 'utf8');
  const webhookMatcher = envFileContent.match(/SLACK_WEBHOOK_PATH=(.*)\n/);
  const SLACK_WEBHOOK_PATH = process.env.SLACK_WEBHOOK_PATH || webhookMatcher && webhookMatcher[1];
  if (!SLACK_WEBHOOK_PATH) {
    console.log(`skip webhook due to no process.env.SLACK_WEBHOOK_PATH`);
    return;
  }

  console.log(`SLACK_WEBHOOK_PATH`, SLACK_WEBHOOK_PATH)

  const postData = JSON.stringify({
    text: text,
  });

  var options = {
    hostname: 'hooks.slack.com',
    port: 443,
    path: '/services/' + SLACK_WEBHOOK_PATH,
    method: 'POST',
    headers: {
      'Content-Type': 'application/application/json',
    }
  };

  var req = https.request(options, (res) => {
    console.log('webhook statusCode:', res.statusCode);

    res.on('data', (d) => {
      process.stdout.write(d);
    });
  });

  req.on('error', (e) => {
    console.error(e);
  });

  req.write(postData);
  req.end();
}

async function fetchTag() {
  const fileName = __dirname + '/docker-compose.yml';
  const dockerCompose = fs.readFileSync(fileName, 'utf8');
  const currentTagMatch = dockerCompose.match(/image: 0xpolygon\/bor:(.*)/i);
  // console.log(`currentTag`, dockerCompose.substring(currentTag, 10))
  const currentTag = currentTagMatch[1].replace('-amd64', '');
  console.log(`currentTag`, currentTag);
  https.get('https://hub.docker.com/v2/namespaces/0xpolygon/repositories/bor/tags', res => {
    let data = [];
    const headerDate = res.headers && res.headers.date ? res.headers.date : 'no response date';
    console.log('Status Code:', res.statusCode);

    res.on('data', chunk => {
      data.push(chunk);
    });

    res.on('end', () => {
      const res = JSON.parse(Buffer.concat(data).toString());
      let foundMyTag = false;
      let webhookSent = false;
      for (let r of res.results) {
        console.log("tag", r.name, `date`, r.last_updated);
        if (r.name!== 'latest') {
          if (r.name.includes(currentTag)) {
            console.log(`foundMyTag`, r.name);
          } else if (!foundMyTag) {
            console.log(`got other tag name=${r.name}`);
            if (!webhookSent) {
              webhookSent = true;
              webhook(`got possible new tag ${r.name}`);
            }

          }
        }
      }

    });
  }).on('error', err => {
    console.log('Error: ', err.message);
  });
}

fetchTag();
