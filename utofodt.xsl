<?xml version="1.0" encoding="UTF-8"?>

<!-- $Id: utofodt.xsl,v 0.8 2014/03/20 20:30:17 pj Exp pj $ -->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
  xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
  xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
  xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
  xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
  xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
  xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
  xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
  xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
  xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
  xmlns:math="http://www.w3.org/1998/Math/MathML"
  xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
  xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
  xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0"
  xmlns:ooo="http://openoffice.org/2004/office"
  xmlns:ooow="http://openoffice.org/2004/writer"
  xmlns:oooc="http://openoffice.org/2004/calc"
  xmlns:dom="http://www.w3.org/2001/xml-events"
  xmlns:xforms="http://www.w3.org/2002/xforms"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:rpt="http://openoffice.org/2005/report"
  xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:grddl="http://www.w3.org/2003/g/data-view#"
  xmlns:tableooo="http://openoffice.org/2009/table"
  xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0"
  xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0"
  xmlns:css3t="http://www.w3.org/TR/css3-text/"
>
<xsl:output encoding="UTF-8" indent="yes"/>

<!-- metadatas -->
<xsl:template match="DA"></xsl:template>
<xsl:template match="DD"></xsl:template>
<xsl:template match="DF"></xsl:template>
<xsl:template match="DG"></xsl:template>
<xsl:template match="DK"></xsl:template>
<xsl:template match="DS"></xsl:template>
<xsl:template match="DT"></xsl:template>

<!-- headings -->
<xsl:template match="H1">
  <text:h>
      <xsl:attribute name="text:style-name">Heading_1</xsl:attribute>
      <xsl:attribute name="text:outline-level">1</xsl:attribute>
      <xsl:apply-templates/>
  </text:h>
</xsl:template>
<xsl:template match="H2">
  <text:h>
      <xsl:attribute name="text:style-name">Heading_2</xsl:attribute>
      <xsl:attribute name="text:outline-level">2</xsl:attribute>
      <xsl:apply-templates/>
  </text:h>
</xsl:template>
<xsl:template match="H3">
  <text:h>
      <xsl:attribute name="text:style-name">Heading_3</xsl:attribute>
      <xsl:attribute name="text:outline-level">3</xsl:attribute>
      <xsl:apply-templates/>
  </text:h>
</xsl:template>
<xsl:template match="H4">
  <text:h>
      <xsl:attribute name="text:style-name">Heading_4</xsl:attribute>
      <xsl:attribute name="text:outline-level">4</xsl:attribute>
      <xsl:apply-templates/>
  </text:h>
</xsl:template>

<!-- paragraphs -->
<xsl:template match="PP">
  <text:p text:style-name="Text_body"><xsl:apply-templates/></text:p>
</xsl:template>
<xsl:template match="PQ">
  <text:p text:style-name="Text_quotation"><xsl:apply-templates/></text:p>
</xsl:template>
<xsl:template match="PB">
  <text:p text:style-name="Text_left_indent"><xsl:apply-templates/></text:p>
</xsl:template>
<xsl:template match="PL">
  <text:p text:style-name="Text_left_align"><xsl:apply-templates/></text:p>
</xsl:template>
<xsl:template match="PR">
  <text:p text:style-name="Text_right_align"><xsl:apply-templates/></text:p>
</xsl:template>
<xsl:template match="PC">
  <text:p text:style-name="Text_centered"><xsl:apply-templates/></text:p>
</xsl:template>
<xsl:template match="PX">
  <text:p text:style-name="Text_example">
	  <xsl:call-template name="lines"/>
  </text:p>
</xsl:template>

<!--
	 Add line-break element at the end of each line, cf:
	 https://stackoverflow.com/questions/9446487/xslt-take-line-by-line-from-the-text-of-some-element
-->
<xsl:template name="lines">
  <xsl:param name="pText" select="."/>
  <xsl:if test="string-length($pText)">
	<xsl:value-of select="substring-before(concat($pText, '&#xA;'), '&#xA;')"/>
    <text:line-break/>
    <xsl:call-template name="lines">
      <xsl:with-param name="pText" select="substring-after($pText, '&#xA;')"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>



<!-- lists -->
<xsl:template match="PLIST">
  <text:list text:style-name="List"><xsl:apply-templates/></text:list>
</xsl:template>
<xsl:template match="PI">
  <text:list-item><text:p text:style-name="Text_list"><xsl:apply-templates/></text:p></text:list-item>
</xsl:template>

<!-- notes -->
<xsl:template match="NN">
  <xsl:param name="num"><xsl:value-of select="@num"/></xsl:param>
  <!-- Note Top -->
  <xsl:for-each select="//NT[@num=$num]">
    <text:note>
      <xsl:attribute name="text:id">ftn<xsl:value-of select="@num"/></xsl:attribute>
      <xsl:attribute name="text:note-class">footnote</xsl:attribute>
      <text:note-citation><xsl:value-of select="@num"/></text:note-citation>
      <text:note-body>
        <text:p>
          <xsl:attribute name="text:style-name">Footnote</xsl:attribute>
          <xsl:apply-templates/>
        </text:p>
      </text:note-body>
    </text:note>
  </xsl:for-each>
  <!-- Footnote -->
  <xsl:for-each select="//NS[@num=$num]">
    <text:note>
      <xsl:attribute name="text:id">ftn<xsl:value-of select="@num"/></xsl:attribute>
      <xsl:attribute name="text:note-class">footnote</xsl:attribute>
      <text:note-citation><xsl:value-of select="@num"/></text:note-citation>
      <text:note-body>
        <text:p>
          <xsl:attribute name="text:style-name">Footnote</xsl:attribute>
          <xsl:apply-templates/>
        </text:p>
      </text:note-body>
    </text:note>
  </xsl:for-each>
  <!-- End Note -->
  <xsl:for-each select="//NB[@num=$num]">
    <text:note>
      <xsl:attribute name="text:id">ftn<xsl:value-of select="@num"/></xsl:attribute>
      <xsl:attribute name="text:note-class">footnote</xsl:attribute>
      <text:note-citation><xsl:value-of select="@num"/></text:note-citation>
      <text:note-body>
        <text:p>
          <xsl:attribute name="text:style-name">Footnote</xsl:attribute>
          <xsl:apply-templates/>
        </text:p>
      </text:note-body>
    </text:note>
  </xsl:for-each>
</xsl:template>

<xsl:template match="NT"></xsl:template>
<xsl:template match="NS"></xsl:template>
<xsl:template match="NB"></xsl:template>

<!-- fonts -->
<xsl:template match="B">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:text>B</xsl:text>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:if test="ancestor::C">C</xsl:if>
  <xsl:if test="ancestor::A">A</xsl:if>
  <xsl:if test="ancestor::U">U</xsl:if>
  <xsl:if test="ancestor::L">L</xsl:if>
  <xsl:if test="ancestor::F">F</xsl:if>
  <xsl:if test="ancestor::M">M</xsl:if>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="I">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:text>I</xsl:text>
  <xsl:if test="ancestor::C">C</xsl:if>
  <xsl:if test="ancestor::A">A</xsl:if>
  <xsl:if test="ancestor::U">U</xsl:if>
  <xsl:if test="ancestor::L">L</xsl:if>
  <xsl:if test="ancestor::F">F</xsl:if>
  <xsl:if test="ancestor::M">M</xsl:if>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="C">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:text>C</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="A">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:text>A</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="U">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:text>U</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="L">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:text>L</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="F">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:text>F</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="M">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:if test="ancestor::B">B</xsl:if>
  <xsl:if test="ancestor::I">I</xsl:if>
  <xsl:text>M</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<!-- ugrind fonts -->
<xsl:template match="codeK">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:text>codeK</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="codeV">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:text>codeV</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="codeC">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:text>codeC</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>

<xsl:template match="codeS">
  <text:span>
    <xsl:attribute name="text:style-name">
  <xsl:text>codeS</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </text:span>
</xsl:template>


<!-- root -->
<xsl:template match="UTMAC">
<office:document
  office:version="1.2"
  office:mimetype="application/vnd.oasis.opendocument.text">
<!-- metadatas -->
<office:meta>
  <dc:title><xsl:value-of select="DT"/></dc:title>
  <meta:creation-date><xsl:value-of select="DD"/></meta:creation-date>
  <meta:generator><xsl:value-of select="DG"/></meta:generator>
  <dc:description>Author: <xsl:value-of select="DA"/></dc:description>
  <meta:keyword><xsl:value-of select="DK"/></meta:keyword>
  <dc:subject><xsl:value-of select="DS"/></dc:subject>
  <dc:title><xsl:value-of select="DT"/></dc:title>
</office:meta>

<!-- default things -->
<office:font-face-decls>

 <!-- font R, B and I -->
 <style:font-face style:name="Linux Libertine"
   svg:font-family="&apos;Linux Libertine&apos;"
   style:font-family-generic="roman"
   style:font-pitch="variable"/>

 <!-- font C -->
 <style:font-face style:name="Linux Libertine G:smcp=1&amp;lnum=1"
   svg:font-family="&apos;Linux Libertine G:smcp=1&apos;"
   style:font-family-generic="roman"
   style:font-adornments="Normal"
   style:font-pitch="variable"/>

 <!-- font A -->
 <style:font-face style:name="Linux Libertine G:smcp=1&amp;lnum=1&amp;c2sc=1"
   svg:font-family="&apos;Linux Libertine G:smcp=1&amp;lnum=1&amp;c2sc=1&apos;"
   style:font-family-generic="roman"
   style:font-adornments="Normal"
   style:font-pitch="variable"/>

 <!-- font U -->
 <style:font-face style:name="Linux Libertine G:sups=1"
   svg:font-family="&apos;Linux Libertine G:sups=1&apos;"
   style:font-family-generic="roman"
   style:font-adornments="Normal"
   style:font-pitch="variable"/>

 <!-- font L -->
 <style:font-face style:name="Linux Libertine G:sinf=1"
   svg:font-family="&apos;Linux Libertine G:sinf=1&apos;"
   style:font-family-generic="roman"
   style:font-adornments="Normal"
   style:font-pitch="variable"/>

 <!-- TODO: font F -->
 <style:font-face style:name="Linux Libertine"
   svg:font-family="&apos;Linux Libertine&apos;"
   style:font-family-generic="roman"
   style:font-adornments="Normal"
   style:font-pitch="variable"/>

 <!-- font M -->
 <style:font-face style:name="Linux Libertine Mono"
   svg:font-family="&apos;Linux Libertine Mono&apos;"
   style:font-family-generic="roman"
   style:font-adornments="Normal"
   style:font-pitch="variable"/>

</office:font-face-decls>


<office:styles>

 <style:default-style style:family="paragraph">
  <style:paragraph-properties fo:hyphenation-ladder-count="no-limit"
   style:text-autospace="ideograph-alpha"
   style:punctuation-wrap="hanging"
   style:line-eak="strict"
   style:tab-stop-distance="1.251cm"
   style:writing-mode="page"/>
  <style:text-properties style:use-window-font-color="true"
   style:font-name="Linux Libertine" 
   fo:font-size="12pt"
   fo:language="fr"
   fo:country="FR"
   style:letter-kerning="true"
   fo:hyphenate="false"
   fo:hyphenation-remain-char-count="2"
   fo:hyphenation-push-char-count="2"/>
 </style:default-style>

 <style:style style:name="Standard"
  style:family="paragraph"
  style:class="text"/>

<!-- headings -->
 <style:style style:name="Heading"
  style:family="paragraph"
  style:parent-style-name="Standard"
  style:next-style-name="Text_body"
  style:class="text">
  <style:paragraph-properties fo:margin-top="0.423cm"
   fo:margin-bottom="0.212cm"
   fo:keep-with-next="always"/>
  <style:text-properties fo:font-size="14pt"/>
 </style:style>

 <style:style style:name="Heading_1"
  style:display-name="Heading 1"
  style:family="paragraph"
  style:parent-style-name="Heading"
  style:next-style-name="Text_body"
  style:default-outline-level="1"
  style:class="text">
  <style:paragraph-properties fo:text-align="center"
   style:justify-single-word="false"/> 
  <style:text-properties fo:font-size="20pt"
   fo:font-style="italic"
   fo:font-weight="bold"/>
 </style:style>

 <style:style style:name="Heading_2"
  style:display-name="Heading 2"
  style:family="paragraph"
  style:parent-style-name="Heading"
  style:next-style-name="Text_body"
  style:default-outline-level="2"
  style:class="text">
 <style:paragraph-properties fo:text-align="center"
   style:justify-single-word="false"/> 
  <style:text-properties fo:font-size="16pt"
   fo:font-style="italic"
   fo:font-weight="bold"/>
 </style:style>

 <style:style style:name="Heading_3"
  style:display-name="Heading 3"
  style:family="paragraph"
  style:parent-style-name="Heading"
  style:next-style-name="Text_body"
  style:default-outline-level="3"
  style:class="text">
  <style:text-properties fo:font-size="14pt"
   fo:font-style="italic"
   fo:font-weight="bold"/>
 </style:style>

 <style:style style:name="Heading_4"
  style:display-name="Heading 4"
  style:family="paragraph"
  style:parent-style-name="Heading"
  style:next-style-name="Text_body"
  style:default-outline-level="4"
  style:class="text">
  <style:paragraph-properties fo:margin-top="0.10cm"
   fo:margin-bottom="0.10cm"/>
  <style:text-properties fo:font-size="12pt"
   fo:font-style="italic"
   fo:font-weight="bold"/>
 </style:style>

<!-- paragraphs -->
 <style:style style:name="Text_body"
  style:display-name="Text body"
  style:family="paragraph"
  style:parent-style-name="Standard"
  style:class="text">
  <style:paragraph-properties fo:margin-top="0.10cm"
   fo:text-align="justify"
   fo:text-indent="0.5cm"
   fo:margin-bottom="0.10cm"/>
 </style:style>

 <style:style style:name="Text_quotation"
  style:display-name="Text quotation"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:class="text">
 <style:paragraph-properties
  fo:margin="100%"
  fo:margin-left="2cm"
  fo:margin-right="0cm"
  fo:text-indent="0cm"
  style:auto-text-indent="false"/>
 </style:style>

 <style:style style:name="Text_left_align"
  style:display-name="Text left align"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:class="text">
 <style:paragraph-properties
  fo:text-align="left"
  fo:margin="100%"
  fo:margin-left="2cm"
  fo:margin-right="0cm"
  fo:text-indent="0cm"
  style:auto-text-indent="false"/>
 </style:style>

 <style:style style:name="Text_right_align"
  style:display-name="Text right align"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:class="text">
 <style:paragraph-properties
  fo:text-align="right"
  fo:margin="100%"
  fo:margin-left="2cm"
  fo:margin-right="0cm"
  fo:text-indent="0cm"
  style:auto-text-indent="false"/>
 </style:style>

 <style:style style:name="Text_left_indent"
  style:display-name="Text left indent"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:class="text">
 <style:paragraph-properties
  fo:margin="100%"
  fo:margin-left="2cm"
  fo:margin-right="0cm"
  fo:text-indent="-2cm"
  style:auto-text-indent="false"/>
 </style:style>

 <style:style style:name="Text_centered"
  style:display-name="Text centered"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:class="text">
 <style:paragraph-properties
  fo:text-align="center"
  fo:margin="100%"
  fo:margin-left="2cm"
  fo:margin-right="2cm"
  fo:text-indent="0cm"
  style:auto-text-indent="false"/>
 </style:style>

 <style:style style:name="Text_example"
  style:display-name="Text example"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:class="html">
 <style:paragraph-properties
  fo:text-align="start"
  fo:margin="100%"
  fo:margin-left="2cm"
  fo:margin-right="2cm"
  fo:text-indent="0cm"
  style:justif-single-word="false"
  style:auto-text-indent="false"
  style:font-name="Linux Libertine Mono"
  style:font-pitch="fixed"
  fo:font-style="normal"
  fo:font-size="10pt"/>
 </style:style>

<!-- lists -->
 <style:style style:name="Text_list"
  style:family="paragraph"
  style:parent-style-name="Text_body"
  style:list-style-name="List"/>

 <text:list-style style:name="List">
  <text:list-level-style-bullet
    text:level="1"
		text:style-name="Bullet_symbol"
		text:bullet-char="–">
    <style:list-level-properties
      text:list-level-position-and-space-mode="label-alignment">
    <style:list-level-label-alignment
      text:label-followed-by="listtab"
      text:list-tab-stop-position="2cm"
      fo:text-indent="-0.635cm"
      fo:margin-left="2cm"/>
    </style:list-level-properties>
   </text:list-level-style-bullet>
  </text:list-style>
 
 <style:style style:name="Bullet_symbol"
  style:display-name="Bullet symbol"
  style:family="text">
  </style:style>

<!-- footnotes -->
 <style:style style:name="Footnote_symbol"
  style:display-name="Footnote Symbol"
  style:family="text"/>

 <style:style style:name="Footnote_anchor"
  style:display-name="Footnote anchor"
  style:family="text">
  <style:text-properties style:text-position="super 58%"/>
 </style:style>

 <style:style style:name="Footnote"
  style:family="paragraph"
  style:parent-style-name="Standard"
  style:class="extra">
  <style:paragraph-properties fo:margin="100%"
   fo:margin-left="0.598cm"
   fo:margin-right="0cm"
   fo:text-indent="-0.598cm"
   style:auto-text-indent="false"
   text:number-lines="false"
   text:line-number="0"/>
  <style:text-properties fo:font-size="10pt"/>
 </style:style>

 <text:notes-configuration text:note-class="footnote"
  text:citation-style-name="Footnote_symbol"
  text:citation-body-style-name="Footnote_anchor"
  style:num-format="1"
  text:start-value="0"
  text:footnotes-position="page"
  text:start-numbering-at="document"/>
  <text:notes-configuration text:note-class="endnote"
    style:num-format="i"
    text:start-value="0"/>

<!-- fonts -->
  <!-- default fonts -->
 <style:style style:name="R" style:family="text">
  <style:text-properties style:font-name="Linux Libertine" fo:font-style="normal"/>
 </style:style>
 <style:style style:name="B" style:family="text">
  <style:text-properties style:font-name="Linux Libertine" fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="I" style:family="text">
  <style:text-properties style:font-name="Linux Libertine" fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BI" style:family="text">
  <style:text-properties style:font-name="Linux Libertine" fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>

  <!-- font A acronym -->
 <style:style style:name="A" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1&amp;c2sc=1" fo:font-style="normal"/>
 </style:style>
 <style:style style:name="BA" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1&amp;c2sc=1" fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="IA" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1&amp;c2sc=1" fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BIA" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1&amp;c2sc=1" fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>

  <!-- font C small caps -->
 <style:style style:name="C" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1" fo:font-style="normal"/>
 </style:style>
 <style:style style:name="BC" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1" fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="IC" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1" fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BIC" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:smcp=1&amp;lnum=1" fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>

  <!-- Font F final glyphs -->
 <style:style style:name="F" style:family="text">
  <style:text-properties fo:font-style="normal"/>
 </style:style>
 <style:style style:name="BF" style:family="text">
  <style:text-properties fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="IF" style:family="text">
  <style:text-properties fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BIF" style:family="text">
  <style:text-properties fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>

  <!-- font U superscript -->
 <style:style style:name="U" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sups=1" fo:font-style="normal"/>
 </style:style>
 <style:style style:name="BU" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sups=1" fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="IU" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sups=1" fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BIU" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sups=1" fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>


  <!-- font L downscript -->
 <style:style style:name="L" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sinf=1" fo:font-style="normal"/>
 </style:style>
 <style:style style:name="BL" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sinf=1" fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="IL" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sinf=1" fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BIL" style:family="text">
  <style:text-properties style:font-name="Linux Libertine G:sinf=1" fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>

  <!-- font M monospace -->
 <style:style style:name="M" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-style="normal"/>
 </style:style>
 <style:style style:name="BM" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-weight="bold"/>
 </style:style>
 <style:style style:name="IM" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-style="italic"/>
 </style:style>
 <style:style style:name="BIM" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-weight="bold" fo:font-style="italic"/>
 </style:style>

 <!-- font K, V, C, S code and ugrind fonts -->
 <!-- code keyword -->
 <style:style style:name="codeK" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-style="bold"/>
 </style:style>
 <!-- code variable -->
 <style:style style:name="codeV" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-style="normal"/>
 </style:style>
 <!-- code comment -->
 <style:style style:name="codeC" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-style="normal"/>
 </style:style>
 <!-- code string -->
 <style:style style:name="codeS" style:family="text">
  <style:text-properties style:font-name="Linux Libertine Mono" fo:font-style="italic"/>
 </style:style>


 <text:linenumbering-configuration text:number-lines="false"
  text:offset="0.499cm"
  style:num-format="1"
  text:number-position="left"
  text:increment="5"/>

</office:styles>

<office:automatic-styles>

 <style:page-layout style:name="pm1">
  <style:page-layout-properties fo:page-width="21.00cm"
   fo:page-height="29.7cm"
   style:num-format="1"
   style:print-orientation="portrait"
   fo:margin="3cm"
   fo:margin-top="2cm"
   fo:margin-bottom="3cm"
   fo:margin-left="3cm"
   fo:margin-right="3cm"
   style:writing-mode="lr-tb"
   style:footnote-max-height="0cm">
   <style:footnote-sep style:width="0.018cm"
    style:distance-before-sep="0.101cm"
    style:distance-after-sep="0.101cm"
    style:line-style="solid"
    style:adjustment="left"
    style:rel-width="25%"
    style:color="#000000"/>
  </style:page-layout-properties>
   <style:header-style/>
   <style:footer-style/>
 </style:page-layout>

</office:automatic-styles>

<office:master-styles>
 <style:master-page style:name="Text_body" style:page-layout-name="pm1"/>
</office:master-styles>

<office:body>

<office:text>
 <text:sequence-decls>
  <text:sequence-decl text:display-outline-level="0" text:name="Illustration"/>
  <text:sequence-decl text:display-outline-level="0" text:name="Table"/>
  <text:sequence-decl text:display-outline-level="0" text:name="Text"/>
  <text:sequence-decl text:display-outline-level="0" text:name="Drawing"/>
 </text:sequence-decls>

<!-- content -->
  <xsl:for-each select="//NT">
    <text:p text:style-name="Text_right_align">
    <xsl:apply-templates/>
    </text:p>
  </xsl:for-each>

<xsl:apply-templates/>

  <xsl:for-each select="//NB">
    <text:p text:style-name="Text_right_align">
    <xsl:apply-templates/>
    </text:p>
  </xsl:for-each>
<!-- end of content -->

</office:text>
</office:body>
</office:document>

</xsl:template>

</xsl:stylesheet>
