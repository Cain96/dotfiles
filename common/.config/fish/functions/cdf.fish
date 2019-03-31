# http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal/
function cdf
    set -l target (osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    if test -d "$target"
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    end
end
