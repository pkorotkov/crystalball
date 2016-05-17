#!/bin/bash

echoerr() {
    echo "$@" 1>&2;
}

# Check if at least two arguments are passed.
if [ "$#" -lt 1 ]; then
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
        # Go to installation directory.
        cd $2
        # Build the snapshot of crystal compiler.
        export LIBRARY_PATH=${EMBEDDED_LIB_PATH}
        make
        # Create alias for snapshot crystal compiler.
        SCRIPT_DIR_PATH=$( cd $(dirname $0) ; pwd -P )
        SCRIPT_NAME=`basename $0`
        echo "export SHCRYSTAL_DIR_PATH=$2" >> $HOME/.bashrc
        echo "alias shcrystal=\"${SCRIPT_DIR_PATH}/${SCRIPT_NAME} execute $2\"" >> $HOME/.bashrc
    ;;
    "update")
        cd ${SHCRYSTAL_DIR_PATH}
        # Check if there have been updates that arrived from repository.
        git pull | grep "Already up-to-date."
        if [[ ! $? -eq 0 ]]; then
            export LIBRARY_PATH=${EMBEDDED_LIB_PATH}
            make
        fi
    ;;
    "execute")
        export LIBRARY_PATH=${EMBEDDED_LIB_PATH}
        ${SHCRYSTAL_DIR_PATH}/.build/crystal "${@:2}"
    ;;
    *)
        echoerr "error: unknown command"
        exit 2
    ;;
esac
