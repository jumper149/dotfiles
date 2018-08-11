#!/bin/bash

pgrep "screenkey" && killall "screenkey" && exit 0

screenkey
