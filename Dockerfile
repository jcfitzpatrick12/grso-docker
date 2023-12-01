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

# Change the directory to tmp
WORKDIR /tmp

# Copy expect script into image [auto accepts the licence agreement]
COPY ./environment.yml ./environment.yml

# Create the Conda environment from the environment.yml file
RUN conda env create -f environment.yml

#remove the file 
RUN rm environment.yml

# Initialize Conda for bash shell
RUN conda init bash

# Add Conda initialization to bashrc (for interactive shells)
RUN echo "source activate gbo-env" >> ~/.bashrc

# Update PATH (optional if you plan to use 'conda run')
ENV PATH /opt/conda/envs/gbo-env/bin:$PATH

# Set PYTHONPATH to include /home/gnuradio_burst_observer
ENV PYTHONPATH="/home/gnuradio_burst_observer:${PYTHONPATH}"

#Set GBOPARENTPATH as the parent directory of the package
ENV GBOPARENTPATH /home/gnuradio_burst_observer


#### INSTALL THE SDRPLAY OOT MODULE FOR GNURADIO ####	

#change the working directory to where the API is
WORKDIR /tmp/sdrplay_api-3.07.1

# Copy expect script into image [auto accepts the licence agreement]
COPY ./install_RSP_API.sh ./install_RSP_API.sh

# Make the script executable, and run it
RUN chmod +x ./install_RSP_API.sh && \
	./install_RSP_API.sh
	
#clean up
RUN rm install_RSP_API.sh
	
#change the working directory to where the API is
WORKDIR /tmp

# Copy expect script into image [auto accepts the licence agreement]
COPY ./install_soapysdrplay3.sh ./install_soapysdrplay3.sh

# Make the script executable
RUN chmod +x ./install_soapysdrplay3.sh

# Clone the repository
RUN /bin/bash -c "source activate gbo-env && ./install_soapysdrplay3.sh"

#clean up
RUN rm install_soapysdrplay3.sh


WORKDIR /home

