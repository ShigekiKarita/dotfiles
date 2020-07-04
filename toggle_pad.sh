#!/bin/bash

state=$(xinput list-props "$1" | grep Enabled | tail -c 2)

if [ $state = 1 ]; then
    xinput disable "$1"
else
    xinput enable "$1"
fi
