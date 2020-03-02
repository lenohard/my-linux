#/bin/bash

#count  the files in a directory
## list all installed packages, sort by package size or time
#      List all explicitly installed packages: pacman -Qe.
#    List all explicitly installed native packages (i.e. present in the sync database) that are not direct or optional dependencies: pacman -Qent.
#    List all foreign packages (typically manually downloaded and installed): pacman -Qm.
#    List all native packages (installed from the sync database(s)): pacman -Qn.
#    List packages by regex: pacman -Qs regex.
#    List packages by regex with custom output format: expac -s "%-30n %v" regex (needs expac).


#    To list the download size of several packages (leave packages blank to list all packages):
alias pacsize='expac -s -H "M" "%-20n %m" | sort -rhk 2 | less '

#To list explicitly installed packages not in base nor base-devel with size and description:
alias pacnbase='expac -H "M" "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqen | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'

#clean to save space


# edited du to list dirs and sort by size in resverse order, then output with less
dus () {
    if [ -z "$1" ]
    then
        echo "-Parameter #1 is zero length"
    else
        # echo "-Parameter #1 is \"$1\""
        du -xhd1 "$1" | sort -rh | less
    fi
}
