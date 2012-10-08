<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<!-- <xsl:strip-space elements="*"/> -->

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
  <code><xsl:apply-templates/></code>
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
  <p class="example"><xsl:apply-templates/></p>
</xsl:template>

<!-- lists -->
<xsl:template match="LI">
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

<!-- fonts -->
<xsl:template match="F">
  <span>
    <xsl:attribute name="class"><xsl:value-of select="@name"/></xsl:attribute>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<!-- root -->
<xsl:template match="HLM">
<html>
<head>
  <title><xsl:value-of select="DT"/></title>
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
            <xsl:attribute name="name">N<xsl:value-of select="@num"/></xsl:attribute>
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
