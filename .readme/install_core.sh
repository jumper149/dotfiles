# written for archlinux/pacman

CORELIST="$(cat ~/.readme/core | tr '\n' ' ')"
GROUPSLIST="$(cat ~/.readme/groups | tr '\n' ' ')"

PKGLIST="$GROUPSLIST $CORELIST"

echo $PKGLIST
sudo pacman -S $PKGLIST --needed
