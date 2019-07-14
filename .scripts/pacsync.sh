#!/bin/bash

CORELIST="$(cat ~/.readme/core | grep -v '^#' | grep -v '^$' | tr '\n' ' ')"
COREDEPLIST="$(cat ~/.readme/core | grep '^#' | grep -v '^$' | cut --delimiter=' ' --field='2' | tr '\n' ' ')"

GROUPSLIST="$(cat ~/.readme/groups | tr '\n' ' ')"

echo "---core---"
echo "$CORELIST"
echo ""

echo "---coredep---"
echo "$COREDEPLIST"
echo ""

echo "---groups---"
echo "$GROUPSLIST"
echo ""

#-----------------------------------------------------------------------

echo "Syncing 'pkgaur'-Repository."
git -C ~/Packages/pkgaur/ pull

AURLIST="$(cat ~/.readme/aur | grep -v '^#' | grep -v '^$')"
AURDEPLIST="$(cat ~/.readme/aur | grep '^#' | grep -v '^$' | cut --delimiter=' ' --field='2')"

echo "---aur---"
echo "$(echo $AURLIST | tr '\n' ' ')"
echo ""

echo "---aurdep---"
echo "$(echo $AURDEPLIST | tr '\n' ' ')"
echo ""

AURVERSIONLIST=""
while read line ; do
	AURVERSIONLIST+="$(find ~/Packages/pkgaur/core -name "$line*") " || exit 10
done <<< "$AURLIST"

AURDEPVERSIONLIST=""
while read line ; do
	AURDEPVERSIONLIST+="$(find ~/Packages/pkgaur/core -name "$line*") " || exit 11
done <<< "$AURDEPLIST"

#-----------------------------------------------------------------------

function callPacman {
    echo "Calling pacman."

    sudo --remove-timestamp

    sudo pacman -Syu &&
    sudo pacman -S $CORELIST --asexplicit --needed &&
    sudo pacman -S $COREDEPLIST --asdeps --needed &&

    #sudo pacman -S $GROUPSLIST --needed

    sudo pacman -U $AURVERSIONLIST --needed &&
    sudo pacman -U $AURDEPVERSIONLIST --needed &&

    echo "Called pacman succesfully."

    return 0
}

callPacman || exit 1
