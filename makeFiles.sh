#!/bin/bash

mkdir -p $1

for i in {1..1000}; do
    rm -f /tmp/test$i.msk
    for j in {1..1000}; do
        echo "class Test${i}x${j}{a: Int}" >> "$1/test$i.skml";
    done;
done;

echo "fun main() { Test42x42{a => 42 } }" >> "$1/test1.skml"
