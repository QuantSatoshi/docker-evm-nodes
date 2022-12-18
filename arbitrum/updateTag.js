const axios = require("axios");
const fs = require('fs');

async function updateTag() {
  const res = await axios.get('https://hub.docker.com/v2/namespaces/offchainlabs/repositories/nitro-node/tags');
  const latestTag = res.data.results[0].name;
  console.log(`got latestTag`, latestTag);
  if (latestTag) {
    const fileName = __dirname + '/docker-compose.yml';
    fs.readFile(fileName, 'utf8', function (err,data) {
      if (err) {
        return console.log(err);
      }
      const result = data.replace(/image: offchainlabs\/(.*)\n/, `image: offchainlabs/nitro-node:${latestTag}\n`);
      fs.writeFile(fileName, result, 'utf8', function (err) {
        if (err) return console.log(err);
        console.log(`tag updated to ${latestTag}`);
      });
    });
  }
}

updateTag();
