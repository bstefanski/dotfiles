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
