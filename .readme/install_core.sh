# written for archlinux/pacman

CORELIST="$(cat ~/.readme/core | tr '\n' ' ')"
GROUPSLIST="$(cat ~/.readme/groups | tr '\n' ' ')"

PKGLIST="$GROUPSLIST $CORELIST"

echo "---core/group---"
echo "$PKGLIST"
sudo -k  pacman -S $PKGLIST --needed

#-----------------------------------------------------------------------

git -C Packages/pkgaur/ pull
AURLIST="$(cat ~/.readme/aur)"
AURVERSIONLIST=""

while read -r line
do
	AURVERSIONLIST+="$(find ~/Packages/pkgaur/core -name "$line*") "
done <<< "$AURLIST"

echo "---aur---"
echo "$(echo $AURLIST | sed 's/\n/ /g')"
sudo -k pacman -U $AURVERSIONLIST --needed
