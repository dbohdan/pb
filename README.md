# pb

**pb** is a copy and paste command wrapper for X11, Wayland, Termux (Android), and macOS modeled on macOS [`pbcopy`](https://ss64.com/mac/pbcopy.html) and [`pbpaste`](https://ss64.com/mac/pbpaste.html).
It is written in POSIX shell.

I am not a current Mac user, but I found `pbcopy` and `pbpaste` the best common names for these commands.
They are concise, memorable, and don't conflict with [POSIX `paste`](https://en.wikipedia.org/wiki/Paste_(Unix)).

## Installation

You may need to add `~/.local/bin/` to `PATH`.

```shell
cp pb ~/.local/bin/pbpaste
cd ~/.local/bin/
ln -s pbpaste pbcopy
```

## License

MIT.
