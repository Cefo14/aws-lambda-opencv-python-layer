FROM amazonlinux

WORKDIR /

# Update Packages
RUN yum update -y

# Install Main Dependences
RUN yum install gcc openssl-devel bzip2-devel libffi-devel wget tar gzip zip make -y

# Install Python 3.7.9
RUN wget https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz
RUN tar -xzvf Python-3.7.9.tgz
WORKDIR /Python-3.7.9
RUN ./configure --enable-optimizations
RUN make install

WORKDIR /

# Install Python 3.8.7
RUN wget https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz
RUN tar -xzvf Python-3.8.7.tgz
WORKDIR /Python-3.8.7
RUN ./configure --enable-optimizations
RUN make install

# Install Python Packages
# https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html#configuration-layers-path

# Define Python Requirements
RUN mkdir /packages
RUN echo "opencv-python" >> /packages/requirements.txt

# Install Packages For Python 3.7
RUN mkdir -p /packages/opencv-python-3.7/python/lib/python3.7/site-packages
RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip install -r /packages/requirements.txt -t /packages/opencv-python-3.7/python/lib/python3.7/site-packages

# Install Packages For Python 3.8
RUN mkdir -p /packages/opencv-python-3.8/python/lib/python3.8/site-packages
RUN python3.8 -m pip install --upgrade pip
RUN python3.8 -m pip install -r /packages/requirements.txt -t /packages/opencv-python-3.8/python/lib/python3.8/site-packages

# Create Zip Files For Lambda Layer Deployment

# Create Zip For Python 3.7
WORKDIR /packages/opencv-python-3.7/
RUN zip -r9 /packages/cv2-python37.zip .
RUN rm -rf /packages/opencv-python-3.7/

# Create Zip For Python 3.8
WORKDIR /packages/opencv-python-3.8/
RUN zip -r9 /packages/cv2-python38.zip .
RUN rm -rf /packages/opencv-python-3.8/
