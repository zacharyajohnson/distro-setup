#!/bin/sh

number="$(od -vAn -N4 -tu4 /dev/urandom)"
if [ $((number % 2)) -eq 0 ]; then
        echo 'heads'
else
        echo 'tails'
fi
