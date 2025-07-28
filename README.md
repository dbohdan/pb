# pb

**pb** is a copy and paste command wrapper for X11, Wayland, Termux (Android), and macOS modeled on macOS [`pbcopy`](https://ss64.com/mac/pbcopy.html) and [`pbpaste`](https://ss64.com/mac/pbpaste.html).
It is written in POSIX shell.

I am not a current Mac user, but I found `pbcopy` and `pbpaste` the best common names for these commands.
They are concise, memorable, and don't conflict with [POSIX `paste`](https://en.wikipedia.org/wiki/Paste_(Unix)).

## Usage

The `copy` or `paste` argument isn't necessary when the program is called `pbcopy` or `pbpaste`.

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

## Installation

You may need to add `~/.local/bin/` to `PATH`.

```shell
install pb ~/.local/bin/
cd ~/.local/bin/
ln -s pb pbcopy
ln -s pb pbpaste
```

## License

MIT.
