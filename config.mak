NAME         := vivaldi-autoinject-custom-js-ui
VERSION      := 2023.09.05.1
UPDATED      := 2023-09-05
CREATED      := 2020-11-21
AUTHOR       := budRich
CONTACT      := github.com/budlabs/vivaldi-autoinject-custom-js-ui
USAGE        := vivaldi-autoinject-custom-js-ui [OPTIONS] [FILE...]
DESCRIPTION  := manage custom js UI mods for the vivaldi web browser
ORGANISATION := budlabs
LICENSE      := BSD-2-Clause
MONOLITH     := _$(NAME)

.PHONY: install uninstall manpage readme

MANPAGE_DEPS =                       \
	$(CACHE_DIR)/help_table.txt        \
	$(DOCS_DIR)/description.md         \
	$(CACHE_DIR)/copyright.txt

manpage_section = 1
MANPAGE = $(NAME).$(manpage_section)

manpage: $(MANPAGE)
readme:  README.md

$(MANPAGE): config.mak $(MANPAGE_DEPS) 
	@$(info making $@)
	uppercase_name=$(NAME)
	uppercase_name=$${uppercase_name^^}
	{
		# this first "<h1>" adds "corner" info to the manpage
		echo "# $$uppercase_name "           \
				 "$(manpage_section) $(UPDATED)" \
				 "$(ORGANISATION) \"User Manuals\""

		# main sections (NAME|OPTIONS..) should be "<h2>" (##), sub (###) ...
	  printf '%s\n' '## NAME' \
								  '$(NAME) - $(DESCRIPTION)'

		echo "## USAGE"
		echo '`$(USAGE)`  '
		cat $(DOCS_DIR)/description.md
		echo "## OPTIONS"
		sed 's/^/    /g' $(CACHE_DIR)/help_table.txt

		printf '%s\n' '## CONTACT' \
			"Send bugs and feature requests to:  " "$(CONTACT)/issues"

		printf '%s\n' '## COPYRIGHT'
		cat $(CACHE_DIR)/copyright.txt

	} | go-md2man > $@

README_DEPS =                        \
	$(CACHE_DIR)/help_table.txt        \
	$(DOCS_DIR)/readme_installation.md \
	$(DOCS_DIR)/description.md         

README.md: $(README_DEPS)
	@$(making $@)
	{
	  echo "# $(NAME)"
	  cat $(DOCS_DIR)/description.md
	  echo "## installation"
	  cat $(DOCS_DIR)/readme_installation.md
	  echo "## usage"
	  echo '```'
	  echo '$(USAGE)'
	  cat "$(CACHE_DIR)/help_table.txt"
	  echo '```'
	} > $@

installed_manpage   := \
	$(DESTDIR)$(PREFIX)/share/man/man$(manpage_section)/$(MANPAGE)

$(CACHE_DIR)/_$(NAME).out: $(MONOLITH)
	m4 -DPREFIX=$(PREFIX) $< >$@

install: $(CACHE_DIR)/_$(NAME).out $(MANPAGE)
	install -Dm755 $(CACHE_DIR)/_$(NAME).out  $(DESTDIR)$(PREFIX)/bin/$(NAME)
	install -Dm644 $(MANPAGE)                 $(installed_manpage)

uninstall:
	[[ -f $(DESTDIR)$(PREFIX)/bin/$(NAME) ]] && rm $(DESTDIR)$(PREFIX)/bin/$(NAME)
	[[ -f $(installed_manpage) ]] && rm $(installed_manpage)
