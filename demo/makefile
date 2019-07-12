PREFIX=$(HOME)/.local
BINDIR=$(PREFIX)/bin
LIBDIR=$(PREFIX)/share
XSLDIR=$(LIBDIR)/xslt
PREXML=$(BINDIR)/prexml
POSTXML=$(BINDIR)/postxml
NROFF=groff -k -Tutf8 -M./


all: test.html test.fodt

%.xml: %.tr
	@echo "Generating $@"
	@$(PREXML) < $< | $(NROFF) -mux | $(POSTXML) > $@

%.html: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utohtml.xsl $< > $@

%.fodt: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utofodt.xsl $< > $@

clean:
	@rm -f test.xml test.html test.fodt

