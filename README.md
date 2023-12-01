# gbo-docker

## Introduction
**gbo-docker** is a containerised environment designed for running the gnuradio_burst_observer application (https://github.com/jcfitzpatrick12/gnuradio_burst_observer). This setup utilizes an Ubuntu-based Docker container, encapsulating GNU Radio and the SoapySDRplay3 plugin within a controlled Conda environment. This approach ensures a consistent, isolated, and portable environment for the application, facilitating easier management and deployment. 

## Features
- **Containerized Environment**: Simplifies deployment and management.
- **Isolated GNU Radio and SoapySDRplay3 Plugin**: Minimizes dependency conflicts.
- **Ubuntu-Based Container**: Provides a stable and familiar Linux environment.
- **Conda Environment**: Enhances package management and ease of setup.
- **Mounted Volume**: Persistent storage in the /home directory inside the container using a mounted volume.

## Prerequisites
- Ubuntu.
- Before installing `gbo-docker`, ensure Docker is installed on your system. Docker can be downloaded and installed from [Docker's official website](https://docs.docker.com/get-docker/).
- Ensure you have git and wget installed locally.

## Installation

1. **Clone the Repository**:
Begin by cloning the `gbo-docker` repository to your local machine:
   
``` git clone https://github.com/jcfitzpatrick12/gbo-docker.git ```

2. **Install the SDRplay 3.x Linux API locally**:
Download the SDRPlay 3.x Linux API.

```wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.07.1.run``` [in your preferred directory]

Make the file executable and run it.

```chmod +x ./SDRplay_RSP_API-Linux-3.07.1.run && ./SDRplay_RSP_API-Linux-3.07.1.run```

4. **Navigate to the Repository Directory**:
Change into the directory of the cloned repository:

``` cd gbo-docker ```

4. **Build the Docker Image**:
Build the Docker image using the following command:

``` docker build -t grim . ```

This command builds the Docker image and tags it as `grim`.

5. **Run the Container**:
Once the image is built, run the container with:

``` bash run_grim ```

6. **Clone the Repository [optional]**:
Now inside the container, clone the gnuradio_burst_observer repo:

```git clone https://github.com/jcfitzpatrick12/gnuradio_burst_observer.git```


## Usage
After installation, run ```gnuradio-companion``` to access gnuradio-companion. 

## Contributing
Contributions to `gbo-docker` are welcome. If you have suggestions or improvements, please open an issue or submit a pull request on the GitHub repository.

## Improvements to Come
- Support for Raspberry Pi.

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the [LICENSE](LICENSE) file for details.
(
