#!/bin/bash

pgrep "compton" && killall "compton" && exit 0

compton -b
