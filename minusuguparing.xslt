<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <!-- Ключ для группировки по месту жительства -->
    <xsl:key name="inimesed-elukoht" match="inimene" use="elukoht"/>

    <xsl:template match="/">
		<strong>Kõik andmed tabelina</strong>
		<table border="3">
			<tr>
				<th>Vanemad</th>
				<th>Nimed</th>
				<th>Lapsevanema vanus</th>
				<th>Sünniaasta</th>
				<th>Vanus (2025)</th>
				<th>Eluhoht</th>
				<th>Laste arv</th>
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
						<xsl:value-of select="2025 - @saasta"/>
					</td>
					<td>
						<xsl:value-of select="elukoht"/>
					</td>
					<td>
						<xsl:value-of select="count(lapsed/inimene)"/>
					</td>
				</tr>

			</xsl:for-each>
		</table>
		
		<strong>Inimeste arv elukoha järgi:</strong>
        <table border="1" cellpadding="5">
            <tr>
                <th>Elukoht</th>
                <th>Inimeste arv</th>
            </tr>
            <!-- Выбираем уникальные места жительства -->
			<!--generate-id() funktsioon XSLT-s loob iga XML-sõlme jaoks unikaalse identifikaatori, mida kasutatakse näiteks korduvate elementide eristamiseks ja grupeerimiseks.-->
			<!--key XSLT-s võimaldab luua indeksi, et kiiresti leida XML-sõlmi teatud väärtuse alusel, näiteks elemente, millel on kindel atribuut või alam-element.-->
            <xsl:for-each select="//inimene[generate-id() = generate-id(key('inimesed-elukoht', elukoht)[1])]">
                <tr>
                    <td>
                        <xsl:value-of select="elukoht"/>
                    </td>
                    <td>
                        <xsl:value-of select="count(key('inimesed-elukoht', elukoht))"/>
                    </td>
                </tr>
            </xsl:for-each>
        </table>
		
		<br/>
		<strong>Inimesed lähevad punaseks, kui nende nimes on e- või i-täht.</strong>
		<br/>
		<strong>Inimese rakk muutub kollaseks, kui tal on vähemalt kaks last.</strong>
		<br/>

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

        <br/>

        

    </xsl:template>
</xsl:stylesheet>
