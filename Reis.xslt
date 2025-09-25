<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Функция для проверки содержит ли строка подстроку -->
	<xsl:template name="contains-string">
		<xsl:param name="str"/>
		<xsl:param name="substr"/>
		<xsl:choose>
			<xsl:when test="contains($str, $substr)">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:output method="html" indent="yes" />

	<xsl:template match="/Reisid">

		<!-- Сначала получим все Reis с transport, где есть 'lennuk' -->
		<xsl:variable name="filteredReis" select="Reis[contains(translate(@transport, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'), 'lennuk')]" />

		<!-- Сортируем по kestus -->
		<xsl:variable name="sortedReis">
			<xsl:for-each select="$filteredReis">
				<xsl:sort select="Lennuinfo/Kestus" data-type="number" order="ascending"/>
				<xsl:copy-of select="." />
			</xsl:for-each>
		</xsl:variable>

		<!-- Для перебора отсортированных записей надо использовать exslt или xsl 2.0, но для простоты сделаем так: -->
		<xsl:variable name="reisList" select="for $r in $filteredReis order by number($r/Lennuinfo/Kestus) return $r" xmlns:xs="http://www.w3.org/2001/XMLSchema" />

		<html>
			<body>
				<table border="1" cellpadding="5" cellspacing="0" style="border-collapse:collapse; width: 100%;">
					<thead>
						<tr style="background-color:#ddd;">
							<th>Sihtkoht</th>
							<th>Transport</th>
							<th>Reisi info</th>
							<th>Kontakt</th>
							<th>Kogumaksumus</th>
						</tr>
					</thead>
					<tbody>
						<xsl:for-each select="$filteredReis">
							<xsl:sort select="number(Lennuinfo/Kestus)" data-type="number" order="ascending" />
							<xsl:variable name="rowColor">
								<xsl:choose>
									<xsl:when test="position() mod 2 = 1">#ffffff</xsl:when>
									<xsl:otherwise>#f0f0f0</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<tr bgcolor="{$rowColor}">
								<td>
									<h1>
										<xsl:value-of select="@sihtkoht" />
									</h1>
								</td>
								<td>
									<xsl:value-of select="@transport" />
								</td>
								<td>
									<ul>
										<li>
											Lennujaam: <xsl:value-of select="Lennuinfo/Lennujaam" />
										</li>
										<li>
											Hind:
											<xsl:choose>
												<!-- если kestus > 3, выделяем желтым -->
												<xsl:when test="number(Lennuinfo/Kestus) &gt; 3">
													<span style="background-color:yellow;">
														<xsl:value-of select="Lennuinfo/Hind" />
													</span>
												</xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="Lennuinfo/Hind" />
												</xsl:otherwise>
											</xsl:choose>
										</li>
										<li>
											Kestus: <xsl:value-of select="Lennuinfo/Kestus" />
										</li>
									</ul>
								</td>
								<td>
									<ul style="background-color:yellow; padding:5px;">
										<li>
											Nimi: <xsl:value-of select="Kontakt/Nimi" />
										</li>
										<li>
											Keel: <xsl:value-of select="Kontakt/Keel" />
										</li>
										<li>
											Email: <xsl:value-of select="Kontakt/Email" />
										</li>
									</ul>
								</td>
								<td>
									<!-- К примеру, считаем сумму с условными значениями: -->
									<xsl:variable name="hindVal" select="number(Lennuinfo/Kestus) * 10" />
									<xsl:variable name="transportVal">
										<xsl:choose>
											<xsl:when test="contains(@transport, 'lennuk')">100</xsl:when>
											<xsl:otherwise>50</xsl:otherwise>
										</xsl:choose>
									</xsl:variable>
									<xsl:variable name="majutusVal" select="50" />
									<xsl:variable name="ekskursioonidVal" select="30" />
									<xsl:variable name="muudKuludVal" select="20" />
									<xsl:value-of select="$hindVal + $transportVal + $majutusVal + $ekskursioonidVal + $muudKuludVal" />
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</body>
		</html>

	</xsl:template>

</xsl:stylesheet>
