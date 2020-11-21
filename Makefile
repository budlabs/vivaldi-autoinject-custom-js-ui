PROGNM  ?= vivaldi-autoinject-custom-js-ui
PREFIX  ?= /usr
BINDIR  ?= $(PREFIX)/bin
SHRDIR  ?= $(PREFIX)/share
MANDIR  ?= $(SHRDIR)/man/man1

MANPAGE  = $(PROGNM).1

.PHONY: install
install: $(PROGNM).out
	install -d  $(DESTDIR)$(BINDIR)

	install -m755 $(PROGNM).out  $(DESTDIR)$(BINDIR)/$(PROGNM)
	install -Dm644 $(MANPAGE)    -t $(DESTDIR)$(MANDIR)
	install -Dm644 LICENSE       -t $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)

	rm $(PROGNM).out

$(PROGNM).out: $(PROGNM)
	m4 -DPREFIX=$(PREFIX) $< >$@

.PHONY: uninstall
uninstall:
	rm $(DESTDIR)$(BINDIR)/$(PROGNM)
	rm $(DESTDIR)$(MANDIR)/$(MANPAGE)
	rm -rf $(DESTDIR)$(SHRDIR)/licenses/$(PROGNM)
