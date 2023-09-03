
To manually add custom javascript modifications to
the **vivaldi** web browser one needs to do the
following:

- Add the javascript file to vivaldis resource directory (on arch this is `/opt/vivaldi/resources/vivaldi`)
- Add an entry in the window.html (pre vivaldi 6.2: browser.html) file in the same directory.

This is not too complicated, but I have noticed
that when **vivaldi** is being updated, the
`window.html` file is overwritten, meaning that
step 2 needs to be repeated after every update.  

It also gets a bit messy to manage multiple mods.  

If `vivaldi-autoinject-custom-js-ui` is launched
without any command line arguments, it will update
the `window.html` file to include all javascript
files located in `PREFIX/share/vivaldi-UI-js`,
(*PREFIX defaults to:* `/usr`). The
**vivaldi-UI-js/** directory is automatically
created by the script when new mods are added.

Any files with `.js` extension passed as arguments
will get added or updated.  

