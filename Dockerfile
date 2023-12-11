# Use an Ubuntu image
FROM ubuntu:22.04

# Setting environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0

#Set GBOPARENTPATH as the parent directory of the package
ENV GBOPARENTPATH /home/grso

ENV PYTHONPATH "${PYTHONPATH}:/home/grso"

#### INSTALLING RELEVANT PACKAGES ###

# Run the barebones stuff to install gnuradio and to get the GUI up and running
# wget for downloading the API, udev, libudev-dev, sudo
RUN apt-get update -y && \
    apt-get install -y wget sudo bash libgtk-3-dev x11-apps expect git swig cmake gnuradio python3-pip


# Change the directory to tmp
WORKDIR /tmp

# Copy expect script into image [the script will run the API .run and auto accepts the licence agreement]
COPY ./install_RSP_API.sh ./install_RSP_API.sh

#download the installation file and run the installation using the above copied script
RUN wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.07.1.run && \
	chmod +x ./install_RSP_API.sh && \
	./install_RSP_API.sh
	
#clean up
RUN rm install_RSP_API.sh

# Now copy the script which will install fventuri's gr-sdrplay3 OOT module
COPY ./install_gr_sdrplay3.sh ./install_gr_sdrplay3.sh

# Make the script executable
RUN chmod +x ./install_gr_sdrplay3.sh && ./install_gr_sdrplay3.sh

#clean up
RUN rm install_gr_sdrplay3.sh

WORKDIR /tmp

#Perform the file moving correction [known bug for gr-sdrplay3 installations on ubuntu]
COPY ./file_mover.sh ./file_mover.sh

RUN chmod +x ./file_mover.sh && ./file_mover.sh

RUN echo ""

WORKDIR /home

# clone the grso repo [gnuradio for solar observations] and pip install the required packages
RUN git clone https://github.com/jcfitzpatrick12/grso.git && \
	cd grso && \
	pip install -r requirements.txt
	
	
#ready to go!
WORKDIR /home
	

























