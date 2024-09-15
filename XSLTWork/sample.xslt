<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"    
                xmlns:math="http://www.w3.org/2005/xpath-functions/math"    
                exclude-result-prefixes="xs math"  version="3.0">                
                    
    <xsl:template match="/"> 
        <Records>
            <xsl:variable name="x">
                <xsl:copy>
                    <xsl:apply-templates select="json-to-xml(.)/*"/>
                </xsl:copy>
            </xsl:variable>
            <!-- Pass the variable $x as a parameter to the next template -->
        <xsl:apply-templates select="$x" mode="process-x">
                <xsl:with-param name="x" select="$x"/>
            </xsl:apply-templates>
        </Records>
    </xsl:template>
    
    <xsl:template match="array" xpath-default-namespace="http://www.w3.org/2005/xpath-functions" mode="process-x">        
        <xsl:param name="x"/>
        <xsl:apply-templates select="map" mode="process-x">
            <xsl:with-param name="x" select="$x"/>
        </xsl:apply-templates>        
    </xsl:template>    
    
    <xsl:template match="map" xpath-default-namespace="http://www.w3.org/2005/xpath-functions" mode="process-x">
        <xsl:param name="x"/>       
        <xsl:for-each select="$x/response/orgs"> 
            <Record>            
                <xsl:apply-templates select="*" mode="process-x">
                    <xsl:with-param name="x" select="$x"/>
                </xsl:apply-templates>           
            </Record>        
        </xsl:for-each>
    </xsl:template>   
    
    <xsl:template match="*[@key]" xpath-default-namespace="http://www.w3.org/2005/xpath-functions" mode="process-x">  
        <xsl:param name="x"/>         
        <xsl:element name="{@key}">
            <xsl:apply-templates mode="process-x">
                <xsl:with-param name="x" select="$x"/>
            </xsl:apply-templates>            
        </xsl:element>        
    </xsl:template>

</xsl:stylesheet>
