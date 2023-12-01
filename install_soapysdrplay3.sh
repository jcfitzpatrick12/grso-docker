#clone the repo
git clone https://github.com/pothosware/SoapySDRPlay3
#cd into the cloned repo
cd SoapySDRPlay3

#make a build directory
mkdir build

#cd into the build directory
cd build

#run the modified cmake command [and those subsequent] according to https://wiki.gnuradio.org/index.php/CondaInstall in gnuradio in conda environments.
cmake -G Ninja -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX -DCMAKE_PREFIX_PATH=$CONDA_PREFIX -DLIB_SUFFIX="" ..      
cmake --build .
cmake --build . --target install
