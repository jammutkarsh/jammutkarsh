# dotfiles

Bash | ZSH | macOS | Linux

```
zsh/      zshrc, aliases.zsh, uc_custom.zsh-theme
git/      gitconfig
bin/      small CLI scripts (added to PATH by zshrc)
```

```sh
./install.sh               # packages, oh-my-zsh + plugins, symlinks (macOS or Linux)
./install.sh --links-only  # symlinks only
```

Existing `~/.zshrc` / `~/.gitconfig` are moved to `*.bak.<timestamp>`.
