#!/bin/bash

# Install bootstrapping crystal toolchain.
curl http://dist.crystal-lang.org/apt/setup.sh | bash
apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54
echo "deb http://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
apt-get install crystal
# Install development required packages.
apt-get install make
wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key|sudo apt-key add -
# Set LLVM bound to 3.5 release.
apt-get install clang-3.5 lldb-3.5
apt-get install libz-dev libedit-dev
