# Core plugins built into mise (don't need to be installed)
readonly -a MISE_CORE_PLUGINS=(
  node
  deno
  python
  ruby
)

# Get all available plugins (including core plugins)
_mise_get_all_plugins() {
  { mise plugin list --all 2>/dev/null; printf '%s\n' "${MISE_CORE_PLUGINS[@]}"; } | sort -u
}

# Select a plugin name using fzf
_mise_select_plugin() {
  local query="${1:-}"
  if [ -n "$query" ]; then
    _mise_get_all_plugins | fzf --query "$query"
  else
    _mise_get_all_plugins | fzf
  fi
}

# Get installed versions for a tool
_mise_get_installed_versions() {
  local name="$1"
  mise list "$name" 2>/dev/null | awk '{print $2}' | sort --version-sort -r
}

# Get current version for a tool
_mise_get_current_version() {
  local name="$1"
  mise list "$name" 2>/dev/null | awk '$3 != "" {print $2; exit}'
}

# Select version for installation (shows all available versions with [installed] marker)
_mise_select_version_for_install() {
  local name="$1"
  local query="${2:-}"
  local installed=$(_mise_get_installed_versions "$name")

  if [ -n "$query" ]; then
    mise ls-remote "$name" 2>/dev/null | sort --version-sort -r | while read v; do
      if printf '%s\n' "$installed" | grep -qFx "$v"; then
        echo "[installed] $v"
      else
        echo "$v"
      fi
    done | fzf --query "$query" | sed 's/^\[installed\] //'
  else
    mise ls-remote "$name" 2>/dev/null | sort --version-sort -r | while read v; do
      if printf '%s\n' "$installed" | grep -qFx "$v"; then
        echo "[installed] $v"
      else
        echo "$v"
      fi
    done | fzf | sed 's/^\[installed\] //'
  fi
}

# Select version for use (shows installed versions with [current] and [installed] markers)
_mise_select_version_for_use() {
  local name="$1"
  local query="${2:-}"
  local current=$(_mise_get_current_version "$name")

  if [ -n "$query" ]; then
    _mise_get_installed_versions "$name" | while read v; do
      if [ "$v" = "$current" ]; then
        echo "[current] $v"
      else
        echo "[installed] $v"
      fi
    done | fzf --query "$query" | sed 's/^\[.*\] //'
  else
    _mise_get_installed_versions "$name" | while read v; do
      if [ "$v" = "$current" ]; then
        echo "[current] $v"
      else
        echo "[installed] $v"
      fi
    done | fzf | sed 's/^\[.*\] //'
  fi
}

# Install a new tool version using mise and fzf
mi() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(_mise_select_plugin "$LBUFFER")
  else
    name=$1
  fi
  if [ -n "$name" ]; then
    local version=$(_mise_select_version_for_install "$name" "$LBUFFER")
    if [ -n "$version" ]; then
      mise install $name@$version
    fi
  fi
}

# Switch to a new tool version using mise and fzf
mu() {
  local name
  if [[ $# -eq 0 ]]; then
    name=$(_mise_select_plugin)
  else
    name=$1
  fi
  if [ -n "$name" ]; then
    local version=$(_mise_select_version_for_use "$name" "$LBUFFER")
    if [ -n "$version" ]; then
      mise use --global $name@$version
    fi
  fi
}
