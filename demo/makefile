# Formatting text with Troff

# Default macro
M=ul

# Prefix directory
PREFIX=/opt/utroff
# Where to find heirloom troff binaries 
BINDIR=$(PREFIX)/bin
# Where to find heirloom troff libraries
LIBDIR=$(PREFIX)/lib
# Where to find utroff xsl stylesheet
XSLDIR=$(LIBDIR)/xsl
# Where to find utmac macros
MACDIR=$(LIBDIR)/tmac
# Where to find troff and OTF fonts
TROFFONTS = $(LIBDIR)/font/:/usr/share/fonts/OTF/

# Where to find Heirloom tools
# Heirloom troff
TROFF=$(BINDIR)/troff
# Heirloom nroff
NROFF=$(BINDIR)/nroff
# Heirloom dpost
DPOST=$(BINDIR)/dpost
# Heirloom tbl
TBL=$(BINDIR)/tbl
# Heirloom eqn
EQN=$(BINDIR)/eqn

# Where to find Utroff tools
# Utroff refer
REFER=$(BINDIR)/refer
# Utroff soelim
SOELIM=$(BINDIR)/soelim
# Utroff ugrind
UGRIND=$(BINDIR)/ugrind
# Utroff prexml
PREXML=$(BINDIR)/prexml
# Utroff postxml
POSTXML=$(BINDIR)/postxml
# Locale utmac macro file
UTMAC=$(MACDIR)/u-locale


TROFFMACS=$(MACDIR)/
export TROFFONTS
export TROFFMACS
export UTMAC

all: troffxml.html troffxml.fodt

%.xml: %.tr
	@echo "Generating $@"
	@$(PREXML) < $< | $(NROFF) -Tlocale -mux | $(POSTXML) > $@

%.html: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utohtml.xsl $< > $@

%.fodt: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utofodt.xsl $< > $@

clean:
	@rm -f *.xml *.html *.fodt

