#!/bin/bash

for i in {1..100}; do
    rm -f /tmp/test$i.msk
    for j in {1..100}; do
        echo "class Test${i}x${j}{a: Int}" >> /tmp/test$i.msk;
    done;
done;

echo "fun main() { Test42x42{a => 42 } }" >> /tmp/test1.msk
