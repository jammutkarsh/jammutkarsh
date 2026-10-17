# dotfiles

Bash | ZSH | Raycast | macOS

```
zsh/      zshrc, aliases.zsh, uc_custom.zsh-theme
git/      gitconfig
bin/      small CLI scripts (added to PATH by zshrc)
raycast/  Raycast script commands
```

```sh
./install.sh               # packages, oh-my-zsh + plugins, symlinks (macOS or Linux)
./install.sh --links-only  # symlinks only
```

Existing `~/.zshrc` / `~/.gitconfig` are moved to `*.bak.<timestamp>`.
Raycast: add `raycast/` as a script directory.
