provision-mainnet:
	docker compose --env-file .env.mainnet.example -f docker-compose.yaml -f ./addons/docker-compose.provisioner.yaml up -d provisioner --build --remove-orphans
init-mainnet:
	docker compose --env-file .env.mainnet.example -f docker-compose.yaml up -d mongo injective-core --build --remove-orphans
eventprovider-mainnet:
	docker compose --env-file .env.mainnet.example -f docker-compose.yaml up -d indexer-eventprovider-process indexer-eventprovider-api --build --remove-orphans
relayer-mainnet:
	docker compose --env-file .env.mainnet.example -f docker-compose.yaml up -d mongo injective-core indexer-exchange-process indexer-exchange-api indexer-chronos-process indexer-chronos-api --build --remove-orphans
reload-mainnet:
	docker compose --env-file .env.mainnet.example -f docker-compose.yaml up -d mongo injective-core indexer-exchange-process indexer-exchange-api indexer-chronos-process indexer-chronos-api --build --remove-orphans
destroy-mainnet:
	docker compose --env-file .env.mainnet.example -f docker-compose.yaml down


provision-testnet:
	docker compose --env-file .env.testnet.example -f docker-compose.yaml -f ./addons/docker-compose.provisioner.yaml up -d provisioner --build --remove-orphans
init-testnet:
	docker compose --env-file .env.testnet.example -f docker-compose.yaml up -d mongo injective-core --build --remove-orphans
eventprovider-testnet:
	docker compose --env-file .env.testnet.example -f docker-compose.yaml up -d indexer-eventprovider-process indexer-eventprovider-api --build --remove-orphans
relayer-testnet:
	docker compose --env-file .env.testnet.example -f docker-compose.yaml up -d mongo injective-core indexer-exchange-process indexer-exchange-api indexer-chronos-process indexer-chronos-api --build --remove-orphans
reload-testnet:
	docker compose --env-file .env.testnet.example -f docker-compose.yaml up -d mongo injective-core indexer-exchange-process indexer-exchange-api indexer-chronos-process indexer-chronos-api --build --remove-orphans
destroy-testnet:
	docker compose --env-file .env.testnet.example -f docker-compose.yaml down

#Loggers/debugging
follow-core:
	docker logs injective-core -f
follow-mongo:
	docker logs mongo -f
follow-chronos-api:
	docker logs indexer-chronos-api -f
follow-chronos-process:
	docker logs indexer-chronos-process -f
follow-exchange-api:
	docker logs indexer-exchange-api -f
follow-exchange-process:
	docker logs indexer-exchange-process -f
follow-eventprovider-api:
	docker logs indexer-eventprovider-api -f
follow-eventprovider-process:
	docker logs indexer-eventprovider-process -f
