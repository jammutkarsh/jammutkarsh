#!/usr/bin/env bash
# Sets up this machine (macOS or Linux): packages, oh-my-zsh + plugins, symlinks.
# Idempotent. `./install.sh --links-only` skips everything except the symlinks.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
LINKS_ONLY=0
SUDO=sudo
[[ $EUID -eq 0 ]] && SUDO=
[[ "${1:-}" == "--links-only" ]] && LINKS_ONLY=1

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarn:\033[0m %s\n' "$*" >&2; }

# link <src> <dst>: symlink, moving any existing real file aside
link() {
	mkdir -p "$(dirname "$2")"
	if [[ (-e $2 || -L $2) && "$(readlink "$2" 2>/dev/null || true)" != "$1" ]]; then
		mv "$2" "$2.bak.$(date +%s)"
		warn "backed up existing $2"
	fi
	ln -sfn "$1" "$2"
}

install_packages() {
	local extras=(atuin difftastic yq)
	case "$OS" in
	Darwin)
		if ! command -v brew >/dev/null; then
			log "Installing Homebrew"
			/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
			eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv)"
		fi
		log "Installing packages (brew)"
		brew install git gh git-lfs fzf "${extras[@]}"
		;;
	Linux)
		log "Installing packages"
		if command -v apt-get >/dev/null; then
			$SUDO apt-get update && $SUDO apt-get install -y zsh git curl fzf gh git-lfs
		elif command -v dnf >/dev/null; then
			$SUDO dnf install -y zsh git curl fzf gh git-lfs
		elif command -v pacman >/dev/null; then
			$SUDO pacman -S --needed --noconfirm zsh git curl fzf github-cli git-lfs
		else
			warn "no supported package manager (apt/dnf/pacman); install zsh git curl fzf gh git-lfs yourself"
		fi
		if command -v brew >/dev/null; then
			brew install "${extras[@]}"
		else
			warn "not installed (no brew): ${extras[*]}"
		fi
		;;
	*) warn "unsupported OS: $OS" ;;
	esac
}

install_omz() {
	if [[ ! -d $HOME/.oh-my-zsh ]]; then
		log "Installing oh-my-zsh"
		RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
			"$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	fi
	local plugins="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins" p
	for p in zsh-autosuggestions zsh-syntax-highlighting; do
		[[ -d $plugins/$p ]] || git clone --depth 1 "https://github.com/zsh-users/$p" "$plugins/$p"
	done
}

if ((!LINKS_ONLY)); then
	install_packages
	install_omz
fi

log "Linking dotfiles"
link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
link "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"
if [[ -d $HOME/.oh-my-zsh ]]; then
	link "$DOTFILES/zsh/uc_custom.zsh-theme" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/uc_custom.zsh-theme"
else
	warn "oh-my-zsh not found, skipped theme link"
fi

if ((!LINKS_ONLY)); then
	command -v git-lfs >/dev/null && git lfs install
	if [[ "$(basename "${SHELL:-}")" != zsh ]] && command -v zsh >/dev/null; then
		log "Setting zsh as login shell"
		chsh -s "$(command -v zsh)" || warn "chsh failed; run it yourself"
	fi
fi

log "Done. Open a new terminal."
