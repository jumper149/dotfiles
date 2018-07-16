# written for archlinux/pacman

CORELIST="$(cat ~/.readme/core | tr '\n' ' ')"
GROUPSLIST="$(cat ~/.readme/groups | tr '\n' ' ')"

PKGLIST="$GROUPSLIST $CORELIST"

sudo pacman -S $PKGLIST --needed
