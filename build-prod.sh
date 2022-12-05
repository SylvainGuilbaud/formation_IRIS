env=production
# env=development 
# docker-compose -f docker-compose-$env.yml -p formation-iris down --rmi all
BUILDKIT_PROGRESS=plain docker-compose -f docker-compose-$env.yml -p formation-iris build --no-cache