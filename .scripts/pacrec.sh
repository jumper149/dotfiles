#!/usr/bin/env bash

# recompiles packages in $HOME/Packages/recompile and copies them to $HOME/Packages/pkgaur/core

CURRENT_DIR="`pwd`"

cd "$HOME/Packages/recompile"

function compile {
        PKG_NAME="$1"
        cd "$PKG_NAME"

        makepkg --nobuild || return 1

        PKG_VER="`grep "^pkgver=[0-9a-Z.:]*$" PKGBUILD | cut -d"=" -f2`"
        PKG_REL="`grep "^pkgrel=[0-9]*$" PKGBUILD | cut -d"=" -f2`"

        CUR_VER="`pacman -Q $PKG_NAME | cut -d" " -f2`"
        CUR_REL="`echo "$CUR_VER" | cut -d"-" -f2`"
        CUR_VER="`echo "$CUR_VER" | cut -d"-" -f1`"

        if [[ "$PKG_VER" == "$CUR_VER" ]]
        then
                NEW_REL="`expr "$CUR_REL" + 1 `"
                sed -i "s/^pkgrel=[0-9]*$/pkgrel=${NEW_REL}/g" PKGBUILD
        else
                NEW_REL="$PKG_REL"
        fi

        makepkg
        
        cp $PKG_NAME-$PKG_VER-$PKG_REL-* ../../pkgaur/core/

        cd ..
}


for pkg_dir in *
do
        compile "$pkg_dir"
done

cd "$CURRENT_DIR"
