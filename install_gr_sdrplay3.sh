#clone the repo
git clone https://github.com/fventuri/gr-sdrplay3.git
# git clone https://github.com/jcfitzpatrick12/gr-sdrplay3.git
# clone the branch containing the hot fix for issue https://github.com/fventuri/gr-sdrplay3/issues/31
# git clone -b 3.9-fix_tuner2_frequency_for_independent_rx https://github.com/fventuri/gr-sdrplay3.git
#cd into the cloned repo
cd gr-sdrplay3
#built the OOT module
mkdir build && cd build && cmake .. && make
sudo make install

