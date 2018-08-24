# written for archlinux/pacman

CORELIST="$(cat ~/.readme/core | tr '\n' ' ')"
GROUPSLIST="$(cat ~/.readme/groups | tr '\n' ' ')"

PKGLIST="$GROUPSLIST $CORELIST"

sudo pacman -S $PKGLIST --needed

#-----------------------------------------------------------------------

AURLIST="$(cat ~/.readme/aur)"
AURVERSIONLIST=""

while read -r line
do
	AURVERSIONLIST+="$(find ~/Packages/pkgaur/core -name "$line*") "
done <<< "$AURLIST"

sudo pacman -U $AURVERSIONLIST --needed
