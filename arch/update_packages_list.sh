#!/bin/sh

pacman -Qqen > pkglist.txt
pacman -Qqm > pkglist-aur.txt
