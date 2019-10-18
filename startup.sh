
#!/bin/bash

docker-compose -f ./docker-compose.yml kill
docker-compose -f ./docker-compose.yml up -d
#docker-compose down

# -d run the container as a background service of the machine
#docker-compose up -d
