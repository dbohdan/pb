#! /bin/sh

# Determine if we're copying or pasting.
cmd=$(basename "$0")
action='copy'
if [ "$cmd" = pbpaste ]; then
    action='paste'
fi

# Default pasteboard.
pboard=clipboard

# Parse the optional `-pboard` flag.
while [ $# -gt 0 ]; do
    case "$1" in
    -pboard)
        shift
        if [ $# -eq 0 ]; then
            echo "$cmd: missing argument for '-pboard'" >&2
            exit 2
        fi

        pboard=$1
        shift
        ;;

    -*)
        echo "$cmd: unknown option: $1" >&2
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
