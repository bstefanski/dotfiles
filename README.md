# dotfiles


## arch

Update package list:

```
pacman -Qqen > arch/pkglist.txt
pacman -Qqm > arch/pkglist-aur.txt
```

Installing official packages:

```
pacman -S < arch/pkglist.txt
```

Installing AUR packages:

```
aurman -S --noconfirm < arch/pkglist-aur.txt
```

## ruby

Update rubygems:

```
gem update --system
```

Update gems:

```
gem update
```

Update a gem list:

```
gem list --local --no-version --no-verbose > ruby/gem-list.txt
```

Install gems from the `gem-list.txt`:

```
cat ruby/gem-list.txt | xargs gem install
```

Update rvm:

```
rvm get stable
```

## js

Update packages:

```
npm update -g
```

Update a package list:

```
npm list -g -depth 0 | sed '1d' | cut -d ' ' -f 2 | cut -d '@' -f 1 > npm/package-list.txt
```

Install packages from the `package-list.txt`:

```
cat npm/package-list.txt | sudo xargs npm -g install
```
