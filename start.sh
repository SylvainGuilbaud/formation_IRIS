#env=production
env=development
docker compose -f docker-compose-$env.yml up -d 

docker compose -f docker-compose-development.yml up -d 