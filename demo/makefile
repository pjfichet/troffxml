# Where to find utroff xsl stylesheet
XSLDIR=../
# Prexml binary
PREXML=../prexml
# postxml binary
POSTXML=../postxml
# heirloom nroff 
NROFF=/opt/utroff/bin/nroff -Tlocale

all: test.html test.fodt

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
	@rm -f test.xml test.html test.fodt

