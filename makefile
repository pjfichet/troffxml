# Packaging directory
DESTDIR=
# Prefix directory
PREFIX=/usr/local
# Where to place binaries
BINDIR=$(PREFIX)/bin
# Where to place libraries
MANDIR=$(PREFIX)/man
# Library directory
LIBDIR=$(PREFIX)/share/
# XSL directory
XSLDIR=$(LIBDIR)/troffxml


# C compiler
CC=cc
# compilier flags
CFLAGS=-Wall -O
# Linker flags
LDFLAGS=
BINS=prexml postxml

XSLT=utmac.ott utofodt.xsl utohtml.xsl

all: $(BINS) troffxml.1

clean:
	rm -rf $(BINS) $(BINS:%=%.o) troffxml.1

%.o: %.c
	$(CC) -c $(CFLAGS) $<
%: %.o
	$(CC) -o $@ $< $(LDFLAGS)

%.1 %.7: %.man
	sed -e "s|@BINDIR@|$(BINDIR)|g" \
		-e "s|@XSLDIR@|$(XSLDIR)|g" $< > $@

$(DESTDIR)$(BINDIR)/%: %
	test -d $(DESTDIR)$(BINDIR) || mkdir -p $(DESTDIR)$(BINDIR)
	install -c $< $@

$(DESTDIR)$(XSLDIR)/%: %
	test -d $(DESTDIR)$(XSLDIR) || mkdir -p $(DESTDIR)$(XSLDIR)
	install -c -m 644 $< $@

$(DESTDIR)$(MANDIR)/man1/troffxml.1: troffxml.1
	test -d $(DESTDIR)$(MANDIR)/man1 || mkdir -p $(DESTDIR)$(MANDIR)/man1
	install -c -m 644 $< $@
	cd $(DESTDIR)$(MANDIR)/man1 && ln -s troffxml.1 prexml.1
	cd $(DESTDIR)$(MANDIR)/man1 && ln -s troffxml.1 postxml.1

install: $(BINS:%=$(DESTDIR)$(BINDIR)/%)  \
		$(XSLT:%=$(DESTDIR)$(XSLDIR)/%) \
		$(DESTDIR)$(MANDIR)/man1/troffxml.1

uninstall:
	rm -f $(BINS:%=$(DESTDIR)$(BINDIR)/%)
	rm -f $(XSLT:%=$(DESTDIR)$(XSLDIR)/%)
	rm -f $(DESTDIR)$(MANDIR)/man1/troffxml.1
	rm -f $(DESTDIR)$(MANDIR)/man1/prexml.1
	rm -f $(DESTDIR)$(MANDIR)/man1/postxml.1

