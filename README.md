# grso-docker: GNU Radio for Solar Observation 

## Introduction
```grso-docker``` is a containerised environment designed for running the ```gnuradio_burst_observer``` application [linked here](https://github.com/jcfitzpatrick12/gnuradio_burst_observer). This setup utilizes an Ubuntu-based Docker container, encapsulating GNU Radio and the SoapySDRplay3 plugin within a controlled Conda environment. This approach ensures a consistent, isolated, and portable environment for the application, facilitating easier management and deployment. 

## Features
- **Containerized Environment**: Simplifies deployment and management.
- **Conda Environment**: Minimizes dependency conflicts and ease of setup.
- **Mounted Volume**: Persistent storage in the ```/home``` directory inside the container using a mounted volume.

## Supported Operating Systems

This project is tested to be compatible with the following operating systems:

- Ubuntu 22.04.3

It may also work on other Linux distributions and other Ubuntu versions. However, full compatibility is not guaranteed for operating systems other than the ones listed above.

## Prerequisites
- Ensure Docker is installed on your system. Docker can be downloaded and installed from [Docker's official website](https://docs.docker.com/get-docker/).
- Ensure you have git and wget installed locally by running ```sudo apt install git wget```.

## Installation

1. **Install the SDRplay 3.x Linux API locally**:
Run the following command to install the API:

```wget https://www.sdrplay.com/software/SDRplay_RSP_API-Linux-3.07.1.run``` [in your preferred directory]

Make the file executable and run it.

```chmod +x ./SDRplay_RSP_API-Linux-3.07.1.run && ./SDRplay_RSP_API-Linux-3.07.1.run```

2. **Clone the ```grso-docker``` Repository**:
Begin by cloning the `grso-docker` repository to your local machine:
   
``` git clone https://github.com/jcfitzpatrick12/grso-docker.git ```

3. **Navigate to the Repository Directory**:
Change into the directory of the cloned repository:

``` cd grso-docker ```

4. **Build the Docker Image**:
Build the Docker image using the following command:

``` docker build -t grim . ```

This command builds the Docker image and tags it as `grim`.

5. **Run the Container**:
Once the image is built, run the container with:

``` bash run_grim.sh ```

6. **Clone the ```gnuradio_burst_observer``` Repository [optional]**:
Now inside the container, clone the ```gnuradio_burst_observer``` repository. **Make sure to be in your ```/home``` directory!**. This is because we mount a persistent volume to the ```\home``` directory inside the container. This allows storage in this directory to be persistent outwith the lifecycle of the container.

```git clone https://github.com/jcfitzpatrick12/gnuradio_burst_observer.git```


## Usage
After installation, run ```gnuradio-companion``` to access gnuradio-companion. 

## Contributing
Contributions to `grso-docker` are welcome. If you have suggestions or improvements, please open an issue or submit a pull request on the GitHub repository.

## Improvements to Come
- Support for Raspberry Pi.

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the [LICENSE](LICENSE).
