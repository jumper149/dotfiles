#!/bin/bash

# logout
gpg --pinentry-mode "cancel" --decrypt ~/.password-store/test/test.gpg && gpgconf --reload gpg-agent && exit 0

# login
gpg --decrypt ~/.password-store/test/test.gpg && exit 0
