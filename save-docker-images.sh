#!/bin/bash

# Read configuration file
CONFIG_FILE="images.config"

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file $CONFIG_FILE not found."
    exit 1
fi

# Pull images listed in the config file
while IFS='=' read -r repository tag; do
    # Remove leading and trailing whitespace
    repository=$(echo "$repository" | tr -d '[:space:]')
    tag=$(echo "$tag" | tr -d '[:space:]')

    # Pull the Docker image
    docker pull "$repository:$tag"

    # Save the Docker image to a tar file
    docker save -o "${repository}_${tag}.tar" "$repository:$tag"

    echo "Image $repository:$tag saved to ${repository}_${tag}.tar"
done < "$CONFIG_FILE"
