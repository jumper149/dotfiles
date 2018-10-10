#!/bin/bash

function imap_call {
	offlineimap
	
	# i3blocks
	pkill --signal SIGRTMIN+24 i3blocks
}

(imap_call)&

# i3blocks
pkill --signal SIGRTMIN+24 i3blocks
