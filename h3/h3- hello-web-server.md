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


## Apache: Name-based Virtual Host Support

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

conf tiedostoon tuli alla oleva teksti: 
```
<VirtualHost *:80>
 ServerName giang.example.com
 ServerAlias www.giang.example.com
 DocumentRoot /home/xubuntu/publicsites/giang.example.com
 <Directory /home/xubuntu/publicsites/giang.example.com>
   Require all granted
 </Directory>
</VirtualHost>
```   
</br>
<img src="https://github.com/user-attachments/assets/19f19883-561e-42c5-9ee6-fdd644162ec0" width="500"> <br/>

Aktivoin tämän jälkeen sivun ja käynnistin Apache2:n uudelleen komennoilla

```sudo a2ensite giang.example.com```
</br>

```sudo systemctl restart apache2```   
</br>
<img src="https://github.com/user-attachments/assets/5ba79826-f196-48f2-aeca-6ed0c45e2281" width="500"> <br/>

Kokeilin tämän jälkeen mennä Firefox-selaimella localhost sivulle (http://localhost) tarkastaakseni että sivuni toimii)
<img src="https://github.com/user-attachments/assets/94751d6c-0068-4898-b22b-a6e0a9a5280b" width="500"> <br/>

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

## hattu.example.com luonti ja asettaminen palvelimen oletussivuksi




a) Testaa, että weppipalvelimesi vastaa localhost-osoitteesta. Asenna Apache-weppipalvelin, jos se ei ole jo asennettuna.
b) Etsi lokista rivit, jotka syntyvät, kun lataat omalta palvelimeltasi yhden sivun. Analysoi rivit (eli selitä yksityiskohtaisesti jokainen kohta ja numero, etsi tarvittaessa lähteitä).
c) Etusivu uusiksi. Tee uusi name based virtual host. Sivun tulee näkyä suoraan palvelimen etusivulla http://localhost/. Sivua pitää pystyä muokkaamaan normaalina käyttäjänä, ilman sudoa. Tee uusi, laita vanhat pois päältä. Uusi sivu on hattu.example.com, ja tämän pitää näkyä: asetustiedoston nimessä, asetustiedoston ServerName-muuttujassa sekä etusivun sisällössä (esim title, h1 tai p).
e) Tee validi HTML5 sivu.
f) Anna esimerkit 'curl -I' ja 'curl' -komennoista. Selitä 'curl -I' muutamasta näyttämästä otsakkeesta (response header), mitä ne tarkoittavat.
m) Vapaaehtoinen, suosittelen tekemään: Hanki GitHub Education -paketti.
o) Vapaaehtoinen, vaikea: Laita sama tietokone vastaamaan kahdellla eri sivulla kahdesta eri nimestä. Eli kaksi weppisiteä samalla koneelle, esim. foo.example.com ja bar.example.com. Voit simuloida nimipalvelun toimintaa hosts-tiedoston avulla.
