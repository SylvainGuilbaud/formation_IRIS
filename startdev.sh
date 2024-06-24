#env=production
env=development
docker compose -f docker-compose-$env.yml up -d 