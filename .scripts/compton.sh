#!/usr/bin/env bash

pgrep "compton" && killall "compton" && exit 0

compton -b
