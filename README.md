# vivaldi-autoinject-custom-js-ui

To manually add custom javascript modifications to
the **vivaldi** web browser one needs to do the
following:

- Add the javascript file to vivaldis resource directory (on arch this is `/opt/vivaldi/resources/vivaldi`)
- Add an entry in the windows.html (pre vivaldi 6.2: browser.html) file in the same directory.

This is not too complicated, but I have noticed
that when **vivaldi** is being updated, the
`windows.html` file is overwritten, meaning that
step 2 needs to be repeated after every update.  

It also gets a bit messy to manage multiple mods.  

If `vivaldi-autoinject-custom-js-ui` is launched
without any command line arguments, it will update
the `windows.html` file to include all javascript
files located in `PREFIX/share/vivaldi-UI-js`,
(*PREFIX defaults to:* `/usr`). The
**vivaldi-UI-js/** directory is automatically
created by the script when new mods are added.

Any files with `.js` extension passed as arguments
will get added or updated.  

## installation

If you use **Arch Linux** you can get
**vivaldi-autoinject-custom-js-ui** from
[AUR](https://aur.archlinux.org/packages/vivaldi-autoinject-custom-js-ui/).

The AUR package will also install a pacman hook that
will execute the script whenever vivaldi is updated.

---


Use the Makefile to do a systemwide installation
of both the script and the manpage.  

(*configure the installation destination in the Makefile, if needed*)  

By default the generated and installed script will have
the shbang: `#!/bin/bash` , this can be configured by
using the `SHBANG` make macro. ( `make SHBANG='#!/usr/bin/env bash'` )

```
$ git clone https://github.com/budlabs/vivaldi-autoinject-custom-js-ui.git
$ cd vivaldi-autoinject-custom-js-ui
# make install
$ vivaldi-autoinject-custom-js-ui -v
vivaldi-autoinject-custom-js-ui - version: 2020.11.22.7
updated: 2020-11-22 by budRich
```

## usage
```
vivaldi-autoinject-custom-js-ui [OPTIONS] [FILE...]
-h, --help             | Show help and exit
-l, --list             | Prints all installed js modifications
-r, --remove  FILENAME | Remove FILENAME
-v, --version          | Show version and exit
```
