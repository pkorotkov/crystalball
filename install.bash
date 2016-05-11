#!/bin/bash

# Set the directory path of this script.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install bootstrapping crystal toolchain.
curl http://dist.crystal-lang.org/apt/setup.sh | sudo bash
sudo apt-get install -y crystal

# Clone the latest codebase snapshot.
git clone https://github.com/manastech/crystal.git

# Install required dependencies.
sudo apt-get install -y \
make \
g++ \
llvm-3.6 \
libedit-dev \
lib32z1-dev

# Build the snapshot crystal compiler.
cd ./crystal/
export LIBRARY_PATH=/opt/crystal/embedded/lib/
make

# Put an updater to the crystal snapshot directory.
# wget https://github.com/pkorotkov/crystalball/raw/master/update.bash
chmod +x $SCRIPT_DIR/update.bash

# Add $CRYSTAL environment variable. 
echo 'export CRYSTAL="$HOME/crystal/.build/crystal"' >> $HOME/.bashrc
