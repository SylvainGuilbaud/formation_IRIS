#!/bin/bash
# terminal.sh
# This script launches the IRIS terminal inside the IRISHealth Docker container.
# Ensure the Docker container is running before executing this script.
# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Docker is not running. Please start Docker and try again."
    exit 1
fi
# set the environment variable for the name of the container from the first parameter is exists, otherwise use the default name from the .env settings
# Check if the container name is provided as an argument
if [ -z "$1" ]; then
    echo "No container name provided. Using default name from .env settings."
    # Default container name
    # You can change this to your actual default container name
    # If you have a .env file, you can source it to get the default container name
    CONTAINER_NAME=$(grep -o '(?<=^CONTAINER_NAME=).*' .env | head -n 1)
    # If the .env file does not exist or does not contain CONTAINER_NAME, use a default value
    if [ -z "$CONTAINER_NAME" ]; then
        CONTAINER_NAME="formation-IRIS"
    fi
# If a container name is provided as an argument, use it
elif [[ "$1" == "--help" || "$1" == "-h" ]]; then
    echo "Usage: $0 [container_name]"
    echo "If no container name is provided, the script will use the default name from .env settings."
    exit 0
else
    CONTAINER_NAME="$1"
fi  

# Check if the container is running
if ! docker ps --filter "name=$CONTAINER_NAME" --filter "status=running" | grep -q "$CONTAINER_NAME"; then
    echo "Container '$CONTAINER_NAME' is not running. Please start the container and try again."
    exit 1
fi  
# If the container is running, proceed to launch the IRIS terminal
echo "Launching IRIS terminal in container '$CONTAINER_NAME'..."
echo "You can exit the IRIS terminal by typing 'h' or 'halt'."
echo "Note: The script will not exit until you exit the IRIS terminal session."
echo "You can interact with the IRIS terminal as needed."

# Launch IRIS terminal inside the container
docker exec -it "$CONTAINER_NAME" iris session IRIS || {
    echo "Failed to launch IRIS terminal. Please check if the container is running and try again."
    exit 1
}