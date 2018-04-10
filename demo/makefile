# Formatting text with Troff

# Where to find utroff xsl stylesheet
XSLDIR=/home/pj/dev/var/troffxml
# Prexml binary
PREXML=/home/pj/dev/bin/prexml
# postxml binary
POSTXML=/home/pj/dev/bin/postxml
# heirloom nroff 
NROFF=/usr/local/ucb/bin/nroff -Tlocale

all: troffxml.html troffxml.fodt

%.xml: %.tr
	@echo "Generating $@"
	@$(PREXML) < $< | $(NROFF)  | $(POSTXML) > $@

%.html: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utohtml.xsl $< > $@

%.fodt: %.xml
	@echo "Generating $@"
	@xsltproc $(XSLDIR)/utofodt.xsl $< > $@

clean:
	@rm -f troffxml.html troffxml.xml troffxml.fodt

