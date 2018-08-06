#!/bin/bash

# logout
gpg --pinentry-mode "cancel" --decrypt ~/.password-store/test/test.gpg && gpgconf --reload gpg-agent && pkill --signal SIGRTMIN+20 i3blocks && exit 0

# login
gpg --decrypt ~/.password-store/test/test.gpg && pkill --signal SIGRTMIN+20 i3blocks && exit 0
