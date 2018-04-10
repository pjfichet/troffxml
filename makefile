# Packaging directory
DESTDIR=
# Prefix directory
PREFIX=/opt/utroff
# Where to place binaries
BINDIR=$(PREFIX)/bin
# Where to place libraries
MANDIR=$(PREFIX)/man
# Library directory
LIBDIR=$(PREFIX)/lib
# XSL directory
XSLDIR=$(LIBDIR)/xsl

# Install binary
INSTALL = /usr/bin/install
# C compiler
CC=gcc
# compilier flags
CFLAGS=-O
# Compiler warning
WARN=-Wall
# Support for locale specific character 
EUC=-DEUC
# Linker flags
LDFLAGS=
# Additionnal libraries to link with
LIBS=
# C preprocessor flags.
# Use -D_GNU_SOURCE for Linux with GNU libc.
# Use -D_INCLUDE__STDC_A1_SOURCE for HP-UX.
CPPFLAGS=-D_GNU_SOURCE
# Strip
STRIP=strip -s -R .comment -R .note

BIN=prexml postxml
MAN=troffxml.1 prexml.1 postxml.1
XSL=utmac.ott utofodt.xsl utohtml.xsl


all: $(BIN) troffxml.1

clean:
	rm -rf $(BIN) troffxml.1

%.1 %.7: %.man
	sed -e "s|@BINDIR@|$(BINDIR)|g" \
		-e "s|@XSLDIR@|$(XSLDIR)|g" $< > $@

postxml.1 prexml.1: troffxml.1
	ln -s $< $@


$(DESTDIR)$(BINDIR) \
$(DESTDIR)$(XSLDIR) \
$(DESTDIR)$(MANDIR)/man1:
	test -d $@ || mkdir -p $@

$(DESTDIR)$(MANDIR)/man1/%: % $(DESTDIR)$(MANDIR)/man1
	$(INSTALL) -c -m 644 $(@F) $@

$(DESTDIR)$(MANDIR)/man1/prexml.1 \
$(DESTDIR)$(MANDIR)/man1/postxml.1: $(DESTDIR)$(MANDIR)/man1/troffxml.1
	-cd $(DESTDIR)$(MANDIR)/man1/ && ln -s troffxml.1 $(@F)

$(DESTDIR)$(BINDIR)/%: % $(DESTDIR)$(BINDIR)
	$(INSTALL) -c $(@F) $@

$(DESTDIR)$(XSLDIR)/%: % $(DESTDIR)$(XSLDIR)
	$(INSTALL) -c -m 644 $(@F) $@

install: $(BIN:%=$(DESTDIR)$(BINDIR)/%) $(MAN:%=$(DESTDIR)$(MANDIR)/man1/%) $(XSL:%=$(DESTDIR)$(XSLDIR)/%)

uninstall:
	rm $(BIN:%=$(DESTDIR)$(BINDIR)/%)
	rmdir $(DESTDIR)$(BINDIR)
	rm $(MAN:%=$(DESTDIR)$(MANDIR)/man1/%)
	rmdir $(DESTDIR)$(MANDIR)/man1 $(DESTDIR)$(MANDIR)
	rm $(XSL:%=$(DESTDIR)$(XSLDIR)/%)
	rmdir $(DESTDIR)$(XSLDIR) $(DESTDIR)$(LIBDIR)


