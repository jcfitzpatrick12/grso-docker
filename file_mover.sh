#!/bin/bash

# Define source and destination directories
source_dir="/usr/local/lib/x86_64-linux-gnu"
dest_dir="/usr/lib/x86_64-linux-gnu"

# Files to move
file1="libgnuradio-sdrplay3.so"
file2="libgnuradio-sdrplay3.so.3.11.0git"
file3="libgnuradio-sdrplay3.so.v3.11.0.1git-2-gd7ab7ce0"

# Move files
mv "$source_dir/$file1" "$dest_dir"
mv "$source_dir/$file2" "$dest_dir"
mv "$source_dir/$file3" "$dest_dir"

echo "Files moved successfully."

