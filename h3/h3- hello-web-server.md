# H3 - Hello Web Server

### Päälaitteen tiedot

Windows 11 Home, 23H2  
AMD 7950X, alikellotettu  
32GB DDR5 @6000Mhz  
RTX3080, alikellotettu  
Kotiverkossa

### Virtuaalikoneen tiedot

OS: Debian GNU/Linux 12 (bookworm) x86_64  
Host: VirtualBox 1.2  
Kernel: 6.1.0-30-amd64  
Shell: bash 5.2.15  
DE: Xfce 4.18  
Terminal: xfce4-terminal  
CPU: AMD Ryzen 9 7950X (8) @ 4.294GHz  
GPU: 00:02.0 VMware SVGA II Adapter  
Memory: 7941MiB  


## Apache: Name-based Virtual Host lyhyesti

IP-based virtual host käyttää yhteyden IP-osoitetta päätelläkseen oikean virtual hostin. 

Name-based virtual hostingissa hostname on osana HTTP headeriä, mikä mahdollistaa useamman hostin käyttämisen samalla IP-osoitteella. 

Name-based virtual hosting vähentää IP-osoitteiden kysyntää. 



## Apache web-palvelimen luonti ja verkkopalvelimen luonti

Aloitin asentamalla Apache2:n komennolla 

```sudo apt-get install apache2```   
</br>
<img src="https://github.com/user-attachments/assets/fd31a583-b76e-4ad8-b74f-63ee67ec3542" width="500"> <br/>


Tämän jälkeen loin index.html tiedoston /var/www/html/ hakemistoon ja tarkastin vielä että se sisältää tekstin komennoilla. 

```echo "Default"|sudo tee /var/www/html/index.html```   
</br>
<img src="https://github.com/user-attachments/assets/548d992a-7332-49c9-b8a5-78bc42bb42f5" width="500"> <br/>

```cat /var/www/html/index.html```   
</br>
<img src="https://github.com/user-attachments/assets/7668e031-9cd2-48e0-a357-eeefec5c300f" width="500"> <br/>


Loin tämän jälkeen vielä .conf tiedoston verkkosivulleni komennolla

```sudoedit /etc/apache2/sites-available/giang.example.com.conf```   
</br>
<img src="https://github.com/user-attachments/assets/5bbaa36e-2748-4c19-9327-0f033877ab31" width="500"> <br/>

.conf tiedostoon tuli alla oleva teksti: 
```
<VirtualHost *:80>
 ServerName giang.example.com
 ServerAlias www.giang.example.com
 DocumentRoot /home/giang/public-sites/giang.example.com
 <Directory /home/giang/public-sites/giang.example.com>
   Require all granted
 </Directory>
</VirtualHost>
```   
</br>
<img src="https://github.com/user-attachments/assets/d984ed99-fad1-4483-829b-62d68bce2eed" width="500"> <br/>


Aktivoin tämän jälkeen sivun ja käynnistin Apache2:n uudelleen komennoilla

```sudo a2ensite giang.example.com```
</br>

```sudo systemctl restart apache2```   
</br>
<img src="https://github.com/user-attachments/assets/5ba79826-f196-48f2-aeca-6ed0c45e2281" width="500"> <br/>

Tämän jälkeen tarkastin vielä mitkä sivustot ovat kytketty päälle komennolla
```ls /etc/apache2/sites-enabled/```   
</br>

Sillä siellä oli ```giang.example.com.conf``` lisäksi ```000-default.conf```, pitää ```000-default.conf``` kytkeä pois päältä ja uudelleenkäynnistää apache2

```sudo a2dissite 000-default.conf```
</br>

```sudo systemctl restard apache2```
</br>

<img src="https://github.com/user-attachments/assets/070cfe1e-7e0b-4c5e-9967-103d4baa41c9" width="500"> <br/>


Kokeilin tämän jälkeen mennä Firefox-selaimella localhost sivulle (http://localhost) tarkastaakseni että toimivatko sivuni

<img src="https://github.com/user-attachments/assets/2919c6b3-2e14-4471-a0dd-c00539f1ad12" width="500"> <br/>

Sivustoni kuitenkin antoi 403 Forbidden koodia, joten kävin tarkastamassa mitä error.log näyttää. 

```sudo tail -1 /var/log/apache2/error.log```

Error.logissa oli polku /home/giang/public-sites, joten tarkastin vielä polun komennolla

```ls /home/giang/public-sites```
<img src="https://github.com/user-attachments/assets/d18466cc-28b9-40f6-9461-2e3435832b01" width="500"> <br/>


ls-komennon antaman virhekoodin perusteella osasin päätellä, että kansiota johon .conf tiedosto viittaa ei ole olemassa, joten loin puuttuvan kansion

```mkdir /home/giang/public-sites/giang.example.com/```

<img src="https://github.com/user-attachments/assets/3f03d563-1362-4da4-969c-f2510297d2b3" width="500"> <br/>

Palasin tämän jälkeen takaisin selaimeen ja päivitin sivun (shift + sivun päivitys). Sillä sivu antoi edelleen 403 koodia, palasin tarkastamaan error.logia. Error.login perusteella pystyin päättelemään, että minulta puuttui vielä ```index.html``` tiedosto joten loin sen

```sudo tail -1 /var/log/apache2/error.log```

```micro /home/giang/public-sites/giang.example.com/index.html```

<img src="https://github.com/user-attachments/assets/45d34a90-b30d-406e-be28-4ba07bf24095" width="500"> <br/>

Palasin tämän jälkeen tarkistamaan toimiiko sivu 

<img src="https://github.com/user-attachments/assets/3976e09b-d6bc-4822-ae08-bb0836b76854" width="500"> <br/>



## Lokien tulkinta

Kävin tämän jälkeen ensin tarkastamassa mitä apachen lokitiedostoja löytyy komennolla 

```sudo ls /var/log/apache2/```
</br>

Ja sitten tarkastin error.log:n sisällön komennolla   

```sudo tail /var/log/apache2/error.log```
</br>

<img src="https://github.com/user-attachments/assets/2c1be2f8-51fb-4c35-9d03-a54d6e3fbb85" width="500"> <br/>



Lopuksi tarkastin vielä access.log:n sisällön komennolla   

```sudo tail /var/log/apache2/access.log```
</br>

<img src="https://github.com/user-attachments/assets/986b54e1-2338-4ec8-8442-5152ae7391a8" width="500"> <br/>

### access.log:n tulkinta

Tulkitaan seuraavaksi access.log:ssa olevaa viimeistä kahta riviä: 

<img src="https://github.com/user-attachments/assets/e799ee32-0655-4e42-8331-a2c104008ef0" width="500"> <br/>

```
127.0.0.1 - - [30/Jan/2025:00:31:31 +0200] "GET / HTTP/1.1" 200 289 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
127.0.0.1 - - [30/Jan/2025:00:31:31 +0200] "GET /favicon.ico HTTP/1.1" 404 487 "http://localhost/" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
```

```127.0.0.1``` <-- Pyynnön lähettäjän IP-osoite   
```-``` pyynnön lähettäjän nimi, tyypillisesti pidetään tyhjänä   
```-``` pyynnön lähettäjän userid   
```[30/Jan/2025:00:31:31 +0200]``` pyynnön aika ja päivämäärä   
```"GET / HTTP/1.1"``` pyynnön tyyppi ja pyydetty resurssi   
```200``` HTTP status koodi. HTTP koodi 200 = OK   
```289``` palautetun objektin koko   
```"-"``` viittaus, josta pyyntö lähtenyt   
```"Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"``` identiointi, jonka selain lähettää palvelimelle

Merkittävimmät erot ensimmäisen ja toisen rivin välillä: 

```"GET /favicon.ico HTTP/1.1"``` poiteken aiempaan ```/``` selain pyytää ```favicon.ico``` tiedostoa   
```404``` poiketen aiempaan ```200```-koodiin, HTTP status koodi ```404``` tarkoittaa että pyydettyä tietoa ei löytynyt   
```"http://localhost/"``` poiketen aiempaan ```-```, tällä pyynnöllä on viite ```http://localhost/```   



## Uuden sivun hattu.example.com luonti ja asettaminen palvelimen etusivuksi

Luodaan ensin taas uusi .conf tiedosto hattu.example.com:a varten.   

```sudoedit /etc/apache2/sites-available/hattu.example.com.conf```
</br>

<img src="https://github.com/user-attachments/assets/77347517-b6c5-4efe-81b3-4764439e5d28" width="500"> <br/>

Lisäsin luotuun .conf tiedostoon alla olevan tekstin: 
```
<VirtualHost *:80>
 ServerName hattu.example.com
 ServerAlias www.hattu.example.com
 DocumentRoot /home/giang/public-sites/hattu.example.com
 <Directory /home/giang/public-sites/hattu.example.com>
   Require all granted
 </Directory>
</VirtualHost>
```
</br>

<img src="https://github.com/user-attachments/assets/d0f60630-bc17-4a58-9fd3-22c33d7aa202" width="500"> <br/>


Aktivoin tämän jälkeen sivun ja käynnistin Apache2:n uudelleen komennoilla

```sudo a2ensite hattu.example.com```
</br>

```sudo systemctl restart apache2```   
</br>

Tämän jälkeen tarkastin vielä mitkä sivut ovat apachessa aktivoituna. 

```ls /etc/apache2/sites-enabled/```
</br>

<img src="https://github.com/user-attachments/assets/633c9a1e-7073-4761-ac29-62671a75f45c" width="500"> <br/>

Vastauksen perusteella pystyin päättelemään, että hattu.example.comin lisäksi aktiivisena on myös giang.example.com joten deaktivoin giang.example.comin ja uudelleenkäynnistin jälleen apachen. 

```sudo a2dissite giang.example.com```
</br>

```sudo systemctl restart apache2```   
</br>

<img src="https://github.com/user-attachments/assets/c41f7caa-ca9f-447e-8582-fc5bf19b119d" width="500"> <br/>

Tiesin etten ollut vielä luonut vaadittua index.html sivua uudelle verkkosivulle, joten loin uuden polun ja index.html tiedoston sinne. 



```micro /home/giang/public-sites/hattu.example.com/```
</br>

```micro /home/giang/public-sites/hattu.example.com/index.html```
</br>

<img src="https://github.com/user-attachments/assets/48760bab-5f37-4541-90ae-f8f20fbf1985" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/78477efc-20e9-45ad-9f69-85530296eba9" width="500"> <br/>

Tämän jälkeen palasin testaamaan verkkosivua (http://localhost), joka toimi odotetusti. 

<img src="https://github.com/user-attachments/assets/9ddf05d9-92a0-46db-a65b-3010e990c384" width="500"> <br/>

## curl ja curl -I

```curl``` komennolla voidaan hakea URL-osoitteita. 

```curl -I``` komennolla haetaan URL-osoitteista vain Response headerit. 

Esimerkki response headereitä ovat mm.:
```HTTP/1.1 200 OK``` kertoo HTTP version, HTTP statuskoodin sekä statuksen tekstin   
```Date``` nimensä mukaisesti kertoo päivämäärän ja ajan   
```Server``` kertoo palvelimen tyypin   
```Content-Type``` kertoo sisällön tyypin   

<img src="https://github.com/user-attachments/assets/cc6dbe0f-7d0d-412b-87ff-6d5c0a07b8a4" width="500"> <br/>


## Lähteet: 
Apache HTTP server project. s.a. Name-based Virtual Host Support.   
https://httpd.apache.org/docs/2.4/vhosts/name-based.html   
Tiivistelmä.   

Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.   
https://terokarvinen.com/linux-palvelimet/   
Tehtävänanto.   

Karvinen, T. 2018. Name Based Virtual Hosts on Apache.    
https://terokarvinen.com/2018/04/10/name-based-virtual-hosts-on-apache-multiple-websites-to-single-ip-address/   
Tiivistelmä ja tehtävä a.    

Loggly. s.a. Linux Logging Basics.    
https://www.loggly.com/ultimate-guide/linux-logging-basics/   
Tehtävä b.    

Fitzpatrick S. 2020. Understanding Apache Access Log: View, locate and analyze.    
https://www.sumologic.com/blog/apache-access-log/   
Tehtävä b.    

Umbraco. s.a. What are HTTP status codes?   
https://umbraco.com/knowledge-base/http-status-codes/   
Tehtävä b.    

APIdog. s.a. Curl -i Command.    
https://apidog.com/articles/curl-i-command/   
Tehtävä f.    
