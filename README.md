# dotfiles

## atom

Update a package list:

```bash
apm list --installed --bare > atom/package-list.txt
```

Install packages from the `package-list.txt`:

```bash
apm install --packages-file atom/package-list.txt
```

## ruby

Update rubygems:

```bash
gem update --system
```

Update gems:

```bash
gem update
```

Update a gem list:

```bash
gem list --local --no-version --no-verbose > ruby/gem-list.txt
```

Install gems from the `gem-list.txt`:

```bash
gem install < ruby/gem-list.txt
```

Update rvm:

```bash
rvm get stable
```

## js

Update packages:

```bash
npm update -g
```

Update a package list:

```bash
npm list -g -depth 0 | sed '1d' | cut -d ' ' -f 2 | cut -d '@' -f 1 > npm/package-list.txt
```

Install packages from the `package-list.txt`:

```bash
npm install -g < npm/package-list.txt
```
