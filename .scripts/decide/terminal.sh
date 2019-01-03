#!/bin/bash

OLD_PS3="$PS3"
PS3=" `tput setaf 11``tput bold`>`tput sgr0` "

select decision in $@
do
	echo "$decision"
	break
done

PS3="$OLD_PS3"
