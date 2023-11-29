# gbo-docker

## Introduction
**gbo-docker** is a containerized solution designed for running the gnuradio-burst-observer application. This setup utilizes an Ubuntu-based Docker container, encapsulating the application, GNU Radio, and the SoapySDRplay3 plugin within a controlled Conda environment. This approach ensures a consistent, isolated, and portable environment for the application, facilitating easier management and deployment.

## Features
- **Containerized Environment**: Simplifies deployment and management.
- **Isolated GNU Radio and SoapySDRplay3 Plugin**: Minimizes dependency conflicts.
- **Ubuntu-Based Container**: Provides a stable and familiar Linux environment.
- **Conda Environment**: Enhances package management and ease of setup.

## Prerequisites
Before installing `gbo-docker`, ensure Docker is installed on your system. Docker can be downloaded and installed from [Docker's official website](https://docs.docker.com/get-docker/).
It is also necessary that the SDRplay API is installed on your host system (https://www.sdrplay.com/api/). Short bash script to automate this to come.

## Installation

1. **Clone the Repository**:
   Begin by cloning the `gbo-docker` repository to your local machine:
   
``` git clone https://github.com/jcfitzpatrick12/gbo-docker.git ```

2. **Navigate to the Repository Directory**:
Change into the directory of the cloned repository:

``` cd gbo-docker ```

3. **Build the Docker Image**:
Build the Docker image using the following command:

``` docker build -t grim . ```

This command builds the Docker image and tags it as `grim`.

4. **Run the Container**:
Once the image is built, run the container with:

``` bash run_grim ```


## Usage
After installation, access and utilize the gnuradio-burst-observer application within the Docker container.

## Contributing
Contributions to `gbo-docker` are welcome. If you have suggestions or improvements, please open an issue or submit a pull request on the GitHub repository.

## License
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the [LICENSE](LICENSE) file for details.
(
