#!/bin/bash

if [ -x "$(command -v natpmpc)" ] ; then
    while [ True ]; do
        clear
        natpmpc -a 1 0 tcp 60 -g 10.2.0.1 && natpmpc -a 1 0 udp 60 -g 10.2.0.1 || echo "Error running natpmpc command..."
        sleep 45
    done
else
    echo "Missing \"natpmpc\". Aborting."
    exit 1
fi
