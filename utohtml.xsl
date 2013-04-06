<?xml version="1.0" encoding="UTF-8"?>

<!-- $Id: utohtml.xsl,v 0.6 2013/04/04 09:07:50 pj Exp pj $ -->

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<xsl:output
	method="html"
	 encoding="UTF-8"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	indent="yes"/>
<!-- <xsl:strip-space elements="*"/> -->
<xsl:preserve-space elements="PX"/>


<!-- metadatas -->
<xsl:template match="DA"></xsl:template>
<xsl:template match="DD"></xsl:template>
<xsl:template match="DG"></xsl:template>
<xsl:template match="DF"></xsl:template>
<xsl:template match="DK"></xsl:template>
<xsl:template match="DS"></xsl:template>
<xsl:template match="DT"></xsl:template>

<!-- headers -->
<xsl:template match="H1">
  <h1><xsl:apply-templates/></h1>
</xsl:template>
<xsl:template match="H2">
  <h2><xsl:apply-templates/></h2>
</xsl:template>
<xsl:template match="H3">
  <h3><xsl:apply-templates/></h3>
</xsl:template>
<xsl:template match="H4">
  <h4><xsl:apply-templates/></h4>
</xsl:template>

<!-- paragraphs -->
<xsl:template match="PC">
  <p class="centered"><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="PL">
  <p class="leftextended"><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="PP">
  <p><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="PQ">
  <blockquote><xsl:apply-templates/></blockquote>
</xsl:template>
<xsl:template match="PR">
  <p class="rightalign"><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="PX">
  <pre><xsl:apply-templates/></pre>
</xsl:template>

<!-- lists -->
<xsl:template match="PLIST">
  <ul><xsl:apply-templates/></ul>
</xsl:template>
<xsl:template match="PI">
  <li><xsl:apply-templates/></li>
</xsl:template>

<!-- notes -->
<xsl:template match="N">
  <span class="U"><a>
    <xsl:attribute name="name">N<xsl:value-of select="@num"/></xsl:attribute>
    <xsl:attribute name="href">#N<xsl:value-of select="@num"/></xsl:attribute>
    <xsl:value-of select="@num"/>
  </a></span>
</xsl:template>
<xsl:template match="NT"></xsl:template>
<xsl:template match="NS"></xsl:template>
<xsl:template match="NB"></xsl:template>

<!-- inline, index, links -->
<xsl:template match="LA">
  <acronym>
	<xsl:attribute name="title"><xsl:value-of select="@name"/></xsl:attribute>
	<xsl:apply-templates/>
  </acronym>
</xsl:template>
<xsl:template match="LC"></xsl:template>
<xsl:template match="LD"></xsl:template>
<xsl:template match="LE"></xsl:template>
<xsl:template match="LI"></xsl:template>
<xsl:template match="LK">
 <a>
    <xsl:attribute name="name"><xsl:value-of select="@num"/></xsl:attribute>
	<xsl:apply-templates/>
  </a>
</xsl:template>
<xsl:template match="LL">
  <a>
	<xsl:attribute name="href"><xsl:value-of select="@name"/></xsl:attribute>
	<xsl:apply-templates/>
  </a>
</xsl:template>
<xsl:template match="LM">
  <a>
	<xsl:attribute name="mailto"><xsl:value-of select="@name"/></xsl:attribute>
	<xsl:apply-templates/>
  </a>
</xsl:template>
<xsl:template match="LN"></xsl:template>
<xsl:template match="LH"></xsl:template>
<xsl:template match="LO"></xsl:template>
<xsl:template match="LS"></xsl:template>
<xsl:template match="LT"></xsl:template>
<xsl:template match="LU">
  <a>
	<xsl:attribute name="href"><xsl:value-of select="@name"/></xsl:attribute>
	<xsl:apply-templates/>
  </a>
</xsl:template>
<xsl:template match="LM">
  <a>
	<xsl:attribute name="mailto"><xsl:value-of select="@name"/></xsl:attribute>
	<xsl:apply-templates/>
  </a>
</xsl:template>

<!-- fonts -->
<xsl:template match="F">
  <span>
    <xsl:attribute name="class"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- root -->
<xsl:template match="UTMAC">
<html>
<head>
  <xsl:choose>
    <xsl:when test="//DT">
      <title><xsl:value-of select="DT"/></title>
    </xsl:when>
    <xsl:otherwise>
      <title>Utroff</title>
    </xsl:otherwise>
  </xsl:choose>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <xsl:for-each select="DG">
    <meta>
      <xsl:attribute name="name">generator</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
  <xsl:for-each select="DA">
    <meta>
      <xsl:attribute name="name">author</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
  <xsl:for-each select="DD">
    <meta>
      <xsl:attribute name="name">date</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
  <xsl:for-each select="DF">
    <meta>
      <xsl:attribute name="name">filename</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
  <xsl:for-each select="DI">
    <meta>
      <xsl:attribute name="name">Id</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
  <xsl:for-each select="DK">
    <meta>
      <xsl:attribute name="name">keywords</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
  <xsl:for-each select="DS">
    <meta>
      <xsl:attribute name="name">subject</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="."/></xsl:attribute>
    </meta>
  </xsl:for-each>
<link rel="stylesheet" href="style.css" type="text/css" media="screen"/>
</head>

<body>
  <!-- top notes -->
    <div class="content" id="top">
    <xsl:if test="//NT">
      <div class="top">
        <xsl:for-each select="//NT">
          <p>
            <a>
              <xsl:attribute name="href">T<xsl:value-of select="@num"/></xsl:attribute>
            </a>
        		<xsl:text>) </xsl:text>
            <xsl:apply-templates/>
          </p>
        </xsl:for-each>
      </div>
    </xsl:if>

    <xsl:apply-templates/>

    <!-- notes -->
	  <xsl:if test="//NS">
		  <hr/>
      <div class="notes">
      <h3>Notes</h3>
      <xsl:for-each select="//NS">
        <p>
          <a>
            <xsl:attribute name="name">NN<xsl:value-of select="@num"/></xsl:attribute>
            <xsl:attribute name="href">#N<xsl:value-of select="@num"/></xsl:attribute>
            <xsl:value-of select="@num"/>
          </a>
          <xsl:text>) </xsl:text>
          <xsl:apply-templates/>
        </p>
      </xsl:for-each>
      </div>
    </xsl:if>

    <!-- bottom notes -->
    <xsl:if test="//NB">
      <div class="bottom">
        <xsl:for-each select="//NB">
          <p>
            <a>
              <xsl:attribute name="href">B<xsl:value-of select="@num"/></xsl:attribute>
            </a>
            <xsl:text>) </xsl:text>
            <xsl:apply-templates/>
          </p>
        </xsl:for-each>
      </div>
    </xsl:if>

  </div>
</body>
</html>
</xsl:template>

</xsl:stylesheet>
