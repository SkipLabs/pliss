#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir $1
cp "$SCRIPT_DIR/projectGenericMakefile" $1/Makefile
cd $1 && ln -s "$SCRIPT_DIR/lib" && ln -s "$SCRIPT_DIR/stdlib"
cp "$SCRIPT_DIR/hello.sk" $1
