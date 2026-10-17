# dotfiles

Bash | ZSH | Raycast | macOS

```
zsh/      zshrc, aliases.zsh, uc_custom.zsh-theme
git/      gitconfig
bin/      small CLI scripts (added to PATH by zshrc)
raycast/  Raycast script commands
```

Setup:

```sh
ln -sf $PWD/zsh/zshrc ~/.zshrc
ln -sf $PWD/git/gitconfig ~/.gitconfig
ln -sf $PWD/zsh/uc_custom.zsh-theme ~/.oh-my-zsh/custom/themes/uc_custom.zsh-theme
```

Raycast: add `raycast/` as a script directory.
