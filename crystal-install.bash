#!/bin/bash

# Install bootstrapping crystal toolchain.
curl http://dist.crystal-lang.org/apt/setup.sh | bash
apt-key adv --keyserver keys.gnupg.net --recv-keys 09617FD37CC06B54
echo "deb http://dist.crystal-lang.org/apt crystal main" > /etc/apt/sources.list.d/crystal.list
apt-get install -y crystal
# Install development required packages.
apt-get install -y make
wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -
# Set LLVM bound to 3.5 release.
apt-get install -y clang-3.5 lldb-3.5
apt-get install -y libgmp3-dev zlib1g-dev libedit-dev libxml2-dev libssl-dev libyaml-dev libreadline-dev
echo 'export LIBRARY_PATH="/opt/crystal/embedded/lib"' > /etc/profile.d/crystal.sh
echo 'export CRYSTAL="$HOME/crystal/.build/crystal"' >> /etc/profile.d/crystal.sh
