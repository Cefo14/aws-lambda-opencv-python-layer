# AWS Lambda Opencv Python Layer
Create an AWS Lambda Layer using Python and Openv\
This project is based on [lambda-opencv](https://github.com/awslabs/lambda-opencv), fixes a bug in Docker installation and adds a bash install file

## Requirements  
1. Install [Docker](https://docs.docker.com/)

## Steps
1. Clone this repository
2. In your console go to the path where you stored the repository
3. Run from the terminal ```sh install.sh```

**If you do not want to use the sh file, you can follow these steps on the console**

```
# Install Amazon Docker Official Image
docker pull amazonlinux

# Run Dock File
docker build --tag=aws-lambda-opencv-python-layer:latest .

# Fetch Layers
docker run --name aws-lambda-opencv-python-layer-container aws-lambda-opencv-python-layer:latest
docker cp aws-lambda-opencv-python-layer-container:/packages/cv2-python37.zip .
docker cp aws-lambda-opencv-python-layer-container:/packages/cv2-python38.zip .

# Remove Container
docker container stop aws-lambda-opencv-python-layer-container
docker container rm aws-lambda-opencv-python-layer-container

# Remove Image
docker rmi aws-lambda-opencv-python-layer:latest
```

**This will generate two zip files in the repository folder, one layer for python 3.7 and one for 3.8.\
You just need to upload it from the portal or through the aws cli.**

**And... that's it :)**
