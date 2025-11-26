function chrome() {
  local chrome_path='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

  case "$1" in
    debug)
      local port="${2:-9222}"
      "$chrome_path" \
        --remote-debugging-port="$port" \
        --user-data-dir="/tmp/chrome-debug-$port" &
      echo "Chrome debug mode launched on port $port"
      echo "Connection URL: chrome://inspect or http://localhost:$port"
      ;;
    *)
      "$chrome_path" "$@" &
      ;;
  esac
}
