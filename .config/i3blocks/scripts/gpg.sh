#!/bin/bash

gpg --pinentry-mode "cancel" --decrypt ~/.password-store/test/test.gpg &> /dev/null && echo "GPG" && exit 0

exit 0
