#! /bin/sh

# Determine if we're copying or pasting.
cmd=$(basename "$0")
action='paste'
if [ "$cmd" = pbcopy ]; then
    action='copy'
fi

# Program version.
version='0.1.0'

usage() {
    cat <<EOF
Usage: $cmd [options]

    -p, (-)-pboard <pasteboard>   specify the pasteboard (macOS: 'general', 'ruler', etc.; Wayland: 'clipboard', 'primary'; X11: 'clipboard', 'primary', 'secondary')
    -V, --version                 print version and exit
    -h, --help                    print this help and exit
EOF
}

# Default pasteboard.
pboard=clipboard

# Parse the optional `-pboard` flag.
while [ $# -gt 0 ]; do
    case "$1" in
    -p | -pboard | --pboard)
        shift
        if [ $# -eq 0 ]; then
            echo "$cmd: missing argument for '-pboard'" >&2
            exit 2
        fi

        pboard=$1
        shift
        ;;

    -h | --help)
        usage
        exit 0
        ;;

    -V | --version)
        echo "$cmd version $version"
        exit 0
        ;;

    -*)
        echo "$cmd: unknown option: $1" >&2
        echo "Use '$cmd --help' for usage." >&2
        exit 2
        ;;

    *)
        break
        ;;
    esac
done

pboard_lc=$(printf "%s" "$pboard" | tr '[:upper:]' '[:lower]:')

# Select platform.
if command -v pbcopy >/dev/null 2>&1 && [ "$(uname)" = Darwin ]; then
    # macOS
    if [ "$action" = copy ]; then
        exec pbcopy -pboard "$pboard"
    else
        exec pbpaste -pboard "$pboard"
    fi

elif [ -n "$WAYLAND_DISPLAY" ] && command -v wl-copy >/dev/null 2>&1; then
    # Wayland
    case "$pboard_lc" in
    clipboard)
        wl_flag=''
        ;;

    primary)
        wl_flag='--primary'
        ;;

    *)
        echo "$cmd: invalid pasteboard '$pboard' for Wayland ('clipboard' and 'primary' are supported)" >&2
        exit 2
        ;;
    esac

    if [ "$action" = copy ]; then
        exec wl-copy $wl_flag
    else
        exec wl-paste $wl_flag
    fi

elif [ -n "$DISPLAY" ] && command -v xsel >/dev/null 2>&1; then
    # X11

    case "$pboard_lc" in
    clipboard)
        xsel_flag='--clipboard'
        ;;

    primary)
        xsel_flag='--primary'
        ;;

    secondary)
        xsel_flag='--secondary'
        ;;

    *)
        echo "$cmd: invalid pasteboard '$pboard' for X11 ('clipboard', 'primary', and 'secondary' are supported)" >&2
        exit 2
        ;;
    esac

    if [ "$action" = copy ]; then
        exec xsel "$xsel_flag" --input
    else
        exec xsel "$xsel_flag" --output
    fi

else
    echo "$cmd: no supported clipboard utility found (pbcopy, wl-copy, or xsel)" >&2
    exit 1
fi
