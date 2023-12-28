# Use an Ubuntu image
FROM ubuntu:22.04

# Setting environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0

#Set GBOPARENTPATH as the parent directory of the package
ENV GRSOPARENTPATH /home/grso

#add grso to the python path so we can import modules properly
ENV PYTHONPATH "${PYTHONPATH}:/home/grso"

#### INSTALLING RELEVANT PACKAGES ###

# Install the required packages for the installation
RUN apt-get update -y && \
    apt-get install -y wget sudo bash libgtk-3-dev x11-apps expect git swig cmake gnuradio python3-pip cron nano


#### INSTALLING THE RSP API ####

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

#### INSTALLING THE gr-sdrplay3 OOT MODULE ####

# Now copy the script which will install fventuri's gr-sdrplay3 OOT module
COPY ./install_gr_sdrplay3.sh ./install_gr_sdrplay3.sh

# Make the script executable
RUN chmod +x ./install_gr_sdrplay3.sh && ./install_gr_sdrplay3.sh

#clean up
RUN rm install_gr_sdrplay3.sh


#### FIXING A KNOWN BUG WITH gr-sdrplay3 OOT MODULE ON UBUNTU ####
WORKDIR /tmp

#Perform the file moving correction [known bug for gr-sdrplay3 installations on ubuntu]
COPY ./file_mover.sh ./file_mover.sh

RUN chmod +x ./file_mover.sh && ./file_mover.sh

#### INSTALLING GRSO APPLICATION ####
WORKDIR /home

# clone the grso repo [gnuradio for solar observations] and pip install the required packages
RUN git clone https://github.com/jcfitzpatrick12/grso.git && \
	cd grso && \
	pip install -r requirements.txt

#### AUTOMATING CRON JOBS STARTING #####
WORKDIR /tmp

# Copy your cron job file into the container
COPY ./grso_cron_jobs /etc/cron.d/grso_cron_jobs

# Set appropriate permissions [read and write for you, other users can only read]
RUN chmod 0644 /etc/cron.d/grso_cron_jobs

#run the custom cron jobs [i.e. add the custom cron jobs to crontab]
RUN crontab /etc/cron.d/grso_cron_jobs

##### Initiate some scripts to run on start up of the container

# Copy the start script into the container
COPY ./start.sh ./start.sh

# Give execution rights on the start script
RUN chmod +x ./start.sh

#set the workdir to be home, and initiate the startup script
WORKDIR /home

# Run the start script as the default command
CMD ["/tmp/start.sh"]

























