### 2023.09.02

The arch pacman hookfile is not part of this
repository anymore, it is instead included in the AUR
package. One major benefit with this is that Arch users
installing from aur, will also have the hook removed
if they uninstall the package. It also actually fixes
an issue for everyone #1 .  

Vivaldi have changed the name of the file that we needed
to modify, from browser.html -> window.html . A test
checking the version of vivaldi is now performed
to correctly predict the name of the file to be modified.

This release is also a rewrite and reorganisation of the
code, previously development happened on the "dev" branch
and required a not available build system. Now the "next" branch,  
which is also the default, is where development happens,
and "master" is on the commit where releases happens.  

Thanks to @pncolvr and @coordinatio for helping out with this
release!
