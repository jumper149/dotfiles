#! /usr/bin/env python2
from subprocess import check_output

def get_pass(account):
    return check_output("gpg --quiet --for-your-eyes-only --no-tty --decrypt ~/.password-store/mail/" + account + ".gpg", shell=True).splitlines()[0]
