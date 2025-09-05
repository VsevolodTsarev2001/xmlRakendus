<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
		
		<strong>Näitame kõik nimed </strong>
		<ul>
			<xsl:for-each select="//inimene">
				<xsl:sort select ="@saasta" order="descending"/>
				<!--descending - suuremast väiksemani-->
				<!--ascending - väiksemast suuremani-->
				<li>
					<xsl:value-of select="nimi"/>
					,
					<xsl:value-of select="@saasta"/>
					:
					<i>
						<xsl:value-of select="concat(nimi, ', ', @saasta, '.')"/>
					</i>
					, vanus:
					<xsl:value-of select="2025-@saasta"/>
					,
					<xsl:value-of select="elukoht"/>
				</li>

			</xsl:for-each>
		</ul>
		
		<strong>Kõik andmed tabelina</strong>
		<table border="3">
			<tr>
				<th>Nimi</th>
				<th>Laps</th>
				<th>Lapsevanema vanus</th>
				<th>Sünniaasta</th>
				<th>Vanus (2025)</th>
				<th>Eluhoht</th>
			</tr>
			<xsl:for-each select="//inimene">
				<xsl:sort select ="@saasta" order="descending"/>
				<!--descending - suuremast väiksemani-->
				<!--ascending - väiksemast suuremani-->
				<tr >
					<xsl:attribute name="style">
						<xsl:if test="count(lapsed/inimene) &gt;= 2">background-color:yellow</xsl:if>
					</xsl:attribute>
					<td>
						<xsl:choose>
							<xsl:when test="contains(../../nimi, 'e') or contains(../../nimi, 'i')">
								<span style="color:red">
									<xsl:value-of select="../../nimi"/>
								</span>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="../../nimi"/>
							</xsl:otherwise>
						</xsl:choose>
					</td>
					<td>
						<xsl:value-of select="nimi"/>
						
					</td>
					<td>
						<xsl:value-of select="../../@saasta - @saasta"/>
					</td>
					<td>
						<xsl:value-of select="@saasta"/>
					</td>
					<td>
						<xsl:value-of select="2025-@saasta"/>
					</td>
					<td>
						<xsl:value-of select="elukoht"/>
					</td>
				</tr>

			</xsl:for-each>
		</table>
		<strong>Minu oma ülesanne: Leia kõik inimesed, kellel on lapselapsed, ja kirjuta nende nimed koos lapselaste arvuga.</strong>
		<table border="1" cellpadding="5">
			<tr>
				<th>Nimi</th>
				<th>Lapselaste arv</th>
			</tr>

			<xsl:for-each select="//inimene">
				<xsl:variable name="lapselapsed" select="count(lapsed/inimene/lapsed/inimene)"/>
				<xsl:if test="$lapselapsed &gt; 0">
					<tr>
						<td>
							<xsl:value-of select="nimi"/>
						</td>
						<td>
							<xsl:value-of select="$lapselapsed"/>
						</td>
					</tr>
				</xsl:if>
			</xsl:for-each>

		</table>
    </xsl:template>
</xsl:stylesheet>
