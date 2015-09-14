#!/bin/bash

# Install bootstrapping crystal toolchain.
curl http://dist.crystal-lang.org/apt/setup.sh | sudo bash
sudo apt-get install -y crystal

# Clone the latest codebase snapshot.
git clone https://github.com/manastech/crystal.git

# Install required dependencies.
sudo apt-get install -y make g++ llvm-3.6 libbsd-dev libedit-dev libevent-core-2.0-5 libevent-extra-2.0-5 libevent-openssl-2.0-5 libevent-pthreads-2.0-5 libevent-dev libgc-dev libpcl1 libpcl1-dev libunwind8 libunwind8-dev libgmpxx4ldbl libgmp-dev libxml2-dev libyaml-dev libreadline6-dev lib32z1-dev

# Build the snapshot crystal compiler.
cd crystal/
make

# Add $CRYSTAL environment variable. 
echo 'export CRYSTAL="$HOME/crystal/.build/crystal"' >> $HOME/.bashrc
