# Use an Ubuntu image
FROM ubuntu:latest

# Setting environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0
# Set the SDRplay API download path
ENV CONDA_BUILD_SDRPLAY_API=/tmp

#### INSTALLING RELEVANT PACKAGES ###

# Run the barebones stuff to install gnuradio and to get the GUI up and running
# wget for downloading the API, udev, libudev-dev, sudo
RUN apt-get update -y && \
    apt-get install -y wget udev libudev-dev sudo bash libgtk-3-dev x11-apps expect git cmake

#### CONDA INSTALLATION ####
# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh
RUN bash /miniconda.sh -b -p /miniconda
ENV PATH="/miniconda/bin:${PATH}"

# Change the directory to home
WORKDIR /home

# Clone the gnuradio_burst_observer repository
RUN git clone https://github.com/jcfitzpatrick12/gnuradio_burst_observer.git

# Change working directory to the cloned gnuradio_burst_observer repository [where the environment.yml is located]
WORKDIR /home/gnuradio_burst_observer
# Create the Conda environment from the environment.yml file
RUN conda env create -f environment.yml

# Initialize Conda for bash shell
RUN conda init bash

# Add Conda initialization to bashrc (for interactive shells)
RUN echo "source activate gbo-env" >> ~/.bashrc

# Update PATH (optional if you plan to use 'conda run')
ENV PATH /opt/conda/envs/gbo-env/bin:$PATH

#### INSTALL THE SDRPLAY OOT MODULE FOR GNURADIO ####

#change the working directory to where the API is
WORKDIR /tmp/sdrplay_api-3.07.1

# Copy expect script into image [auto accepts the licence agreement]
COPY ./install_RSP_API ./install_RSP_API

# Make the script executable, and run it
RUN chmod +x ./install_RSP_API && \
	./install_RSP_API
	

#clean up
RUN rm install_RSP_API
	
#change the working directory to where the API is
WORKDIR /tmp

# Copy expect script into image [auto accepts the licence agreement]
COPY ./install_soapysdrplay3 ./install_soapysdrplay3

# Make the script executable
RUN chmod +x ./install_soapysdrplay3

# Clone the repository
RUN /bin/bash -c "source activate gbo-env && ./install_soapysdrplay3"

#clean up
RUN rm install_soapysdrplay3

WORKDIR /home
