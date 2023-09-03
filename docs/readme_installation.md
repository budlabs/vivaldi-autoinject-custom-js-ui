
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

