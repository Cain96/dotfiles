# dotfiles

This repository manages dotfiles using [chezmoi](https://www.chezmoi.io/).

## Setup

### Initial Setup

1. Install chezmoi:

```bash
# macOS (Homebrew)
brew install chezmoi
```

2. Initialize this repository as the source directory:

```bash
chezmoi init --source ~/workspace/github.com/Cain96/dotfiles
```

3. Apply the configuration files:

```bash
chezmoi apply
```

### Setup on Existing Machine

If chezmoi is already installed:

```bash
chezmoi init --source ~/workspace/github.com/Cain96/dotfiles
chezmoi apply
```

## Usage

### Editing Configuration Files

To edit files managed by chezmoi:

```bash
chezmoi edit <file-path>
```

Examples:
```bash
chezmoi edit ~/.zshrc
chezmoi edit ~/.config/nvim/init.lua
```

### Adding New Files

To add a new dotfile under chezmoi management:

```bash
chezmoi add <file-path>
```

Example:
```bash
chezmoi add ~/.bashrc
```

### Applying Changes

To apply changes from the repository to your home directory:

```bash
chezmoi apply
```

### Checking Changes

To check the difference between your home directory and the source directory:

```bash
chezmoi diff
```

## File Structure

This repository follows chezmoi's standard naming conventions:

- `dot_*` → Files placed at `~/*`
- `dot_*/` → Directories placed at `~/*/`
- `run_once_*.sh.tmpl` → Scripts executed once during `chezmoi apply`

Examples:
- `dot_zshrc` → `~/.zshrc`
- `dot_config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `dot_Brewfile` → `~/.Brewfile`

## Run Once Scripts

The repository includes run-once scripts that are executed automatically during `chezmoi apply`:

1. **`run_once_001_setup-brew.sh.tmpl`** - Sets up and updates Homebrew (macOS only)
2. **`run_once_002_install-brewfile.sh.tmpl`** - Installs packages from Brewfile (macOS only)
3. **`run_once_003_install-languages.sh.tmpl`** - Installs programming languages and tools from `~/.config/mise/config.toml` using mise, and sets up safe-chain (macOS only)
4. **`run_once_004_install-tools.sh.tmpl`** - Installs additional tools (confirm-pam, similarity-ts, git-sequential-stage) using cargo and go (macOS only)

These scripts run only once per machine and are macOS-specific.

## Reference Links

- [chezmoi Official Website](https://www.chezmoi.io/)
