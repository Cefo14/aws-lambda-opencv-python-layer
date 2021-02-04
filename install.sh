# Install Amazon Docker Official Image
docker pull amazonlinux

# Run Dock File
DOCKER_IMAGE="aws-lambda-opencv-python-layer:latest"
docker build --tag=$DOCKER_IMAGE .

# Fetch Layers
DOCKER_CONTAINER="aws-lambda-opencv-python-layer-container"
docker run --name $DOCKER_CONTAINER $DOCKER_IMAGE
docker cp $DOCKER_CONTAINER:/packages/cv2-python37.zip .
docker cp $DOCKER_CONTAINER:/packages/cv2-python38.zip .

# Remove Container
docker container stop $DOCKER_CONTAINER
docker container rm $DOCKER_CONTAINER

# Remove Image
docker rmi $DOCKER_IMAGE
