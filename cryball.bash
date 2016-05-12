#!/bin/bash

echoerr() {
    echo "$@" 1>&2;
}

# Check if at least two arguments are passed.
if [ "$#" -lt 2 ]; then
    echoerr "error: incorrect list of arguments"
    exit 1
fi

EMBEDDED_LIB_PATH=/opt/crystal/embedded/lib/

case "$1" in
    "install")
        # Install bootstrapping crystal toolchain.
        curl http://dist.crystal-lang.org/apt/setup.sh | sudo bash
        sudo apt-get install -y crystal
        # Install required dependencies.
        sudo apt-get install -y make g++ llvm-3.6 libedit-dev lib32z1-dev
        # Clone the latest codebase snapshot.
        git clone https://github.com/crystal-lang/crystal.git $2
        # Build the snapshot of crystal compiler.
        cd $2
        export LIBRARY_PATH=${EMBEDDED_LIB_PATH}
        make
        # Create alias for snapshot crystal compiler.
        SCRIPT_DIR_PATH=$( cd $(dirname $0) ; pwd -P )
        SCRIPT_NAME=`basename $0`
        echo "alias shcrystal=\"${SCRIPT_DIR_PATH}/${SCRIPT_NAME} execute $2\"" >> $HOME/.bashrc
    ;;
    "update")
        cd $2
        # Check if there have been updates that arrived from repository.
        git pull | grep "Already up-to-date."
        if [[ ! $? -eq 0 ]]; then
            export LIBRARY_PATH=${EMBEDDED_LIB_PATH}
            make
        fi
    ;;
    "execute")
        export LIBRARY_PATH=${EMBEDDED_LIB_PATH}
        $2/.build/crystal "${@:3}"
    ;;
    *)
        echoerr "error: unknown command"
        exit 2
    ;;
esac