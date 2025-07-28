# pb

**pb** is a copy and paste command wrapper for X11, Wayland, Termux (Android), and macOS modeled on macOS [`pbcopy`](https://ss64.com/mac/pbcopy.html) and [`pbpaste`](https://ss64.com/mac/pbpaste.html).
It is written in POSIX shell.

I am not a current Mac user, but I found `pbcopy` and `pbpaste` the best common names for these commands.
They are concise, memorable, and don't conflict with [POSIX `paste`](https://en.wikipedia.org/wiki/Paste_(Unix)).

## Usage

The `copy` or `paste` argument isn't necessary when you start the program as `pbcopy` or `pbpaste`.

```none
Usage: pb (copy|paste) [-h] [-V] [-p <pasteboard>]

  -h, --help
          Print this help and exit

  -V, --version
          Print version and exit

  -p, -pboard, --pboard <pasteboard>
          Specify the pasteboard:
            - macOS: 'general', 'ruler', etc.
            - Termux: 'clipboard'
            - Wayland: 'clipboard', 'primary'
            - X11: 'clipboard', 'primary', 'secondary'
```

## Requirements

pb requires access to clipboard utilities;
which ones, depends on your environment:

- macOS: `pbcopy` and `pbpaste` (built in)
- Termux: [`termux-api`](https://wiki.termux.com/wiki/Termux:API) (provides `termux-clipboard-get` and `termux-clipboard-set`)
- Wayland: [`wl-clipboard`](https://github.com/bugaevc/wl-clipboard) (provides `wl-copy` and `wl-paste`)
- X11: [`xsel`](https://github.com/kfish/xsel)

Install missing dependencies using your package manager:

```shell
# Debian/Ubuntu
# Wayland
apt install wl-clipboard
# X11
apt install xsel

# FreeBSD
# Wayland
pkg install wl-clipboard
# X11
pkg install xsel

# Termux
# 1. Install the Termux:API app.
# 2. Install the package in Termux:
pkg install termux-api
```

## Installation

You may need to add `~/.local/bin/` to `PATH`.

```shell
install -d ~/.local/bin/
install pb ~/.local/bin/
cd ~/.local/bin/
ln -s pb pbcopy
ln -s pb pbpaste
```

## License

MIT.
