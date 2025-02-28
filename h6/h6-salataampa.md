# H6 - Salataampa

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

## x) Lue & Tiivistä

- Let's Encryptin ja ACME-protokollan tavoite on mahdollistaa HTTPS käyttöönotto automatisoimalla sertifikaatin hankinnan
- ```lego``` komentoa käytettäessä ```--http``` -option käyttäminen olemassaolevalle palvelimelle vaatii lisäksi ```http.webroot``` -option käyttöä 
- SSL-konfiguraatio vaatii vähintään alla olevat direktiivit: 

```
LoadModule ssl_module modules/mod_ssl.so

Listen 443
<VirtualHost *:443>
    ServerName www.example.com
    SSLEngine on
    SSLCertificateFile "/path/to/www.example.com.cert"
    SSLCertificateKeyFile "/path/to/www.example.com.key"
</VirtualHost>
  ```

## a) Let's Encrypt TLS Sertifikaatti

### Alkutoimet

Aloitin jälleen kirjautumalla palvelimelleni. 

```ssh giang@giangle.fi```

Tämän jälkeen käynnistin apachen vielä uudelleen varmistaakseni, jotta kaikki tekemäni aiemmin tekemäni muutokset ovat aktiivisena ja sivusto toimii kuten sen pitääkin. 

```sudo systemctl restart apache```

Käytettyäni ylläolevaa komentoa, sain virheilmoituksen:

```Failed to restart apache.service: Unit apache.service not found. ```

Virheilmoituksen saatuani tajusin tarkastaa antamani komennon uudelleen, ja siitä puuttuikin lopusta yksi kirjain (2). 

```sudo systemctl restart apache2```

<img src="https://github.com/user-attachments/assets/56aba661-21d8-4fb7-81dd-1c44fed3d7c4" width="500"> <br/>   

Apachen uudelleenkäynnistyksen jälkeen tarkastin vielä, että verkkosivuni toimii oletetusti menemällä selaimella sivulleni giangle.fi. Varmistin vielä, että sivu ei käytä välimuistissa olevaa sivua päivittämällä sivun uudelleen pikanäppäimellä CTRL + Shift + R

<img src="https://github.com/user-attachments/assets/33ce1d4f-ac7a-4001-b278-e47de9a7bb82" width="500"> <br/>   

### Lego, testisertifikaatin luonti staging -ympäristöön & toimivan sertifikaatin luonti

Tämän jälkeen siirryin asentamaan lego -ohjelman ja ```lego``` -kansion ```/home/giang/```. 

```sudo apt-get install lego```

```cd```

```mkdir lego```

Asennettuani ohjelman, siirryin tekemään testisertifikaattia Let's Encryptin Staging -ympäristöön. 

```lego --server=https://acme-staging-v02.api.letsencrypt.org/directory --accept-tos --email="giang.le@iki.fi" --domains="giangle.fi" --domains="www.giangle.fi" --http --http.webroot="/home/giang/public-sites/giangle.fi/" --path="/home/giang/lego/" --pem run```

<img src="https://github.com/user-attachments/assets/09110fbe-3003-4306-92e9-e23bce1479ed" width="500"> <br/>   

Komennon suorittamisen jälkeen näytti omaan silmääni siltä, että sertifikaatin hankinta onnistui. Tarkastin vielä find komennolla, että sertikaatin luonti tosiaan onnistui: 

```find /home/giang/lego/```

<img src="https://github.com/user-attachments/assets/17e28f8d-f48d-4ed9-8152-1ca8e13d6b1f" width="500"> <br/>   

Sertifikaattitiedostot olivat tosiaan luotu, joten olin onnistuneesti luonut Staging ympäristöön testisertifikaatit. Sillä nämä olivat vasta Staging ympäristöä varten luodut sertifikaatit, uudelleennimesin ```lego``` -kansion ```old-lego``` ja loin uuden ```lego``` -kansion tilalle. Tarkastin myös välissä ja lopussa ```ls``` -komennolla, että muutokset tapahtuivat. 

```mv -n lego oldlego```

```ls```

```mkdir lego```

```ls```

<img src="https://github.com/user-attachments/assets/09126e97-c800-4af5-b69a-4128766d7116" width="500"> <br/>   


Tämän jälkeen ajoin saman ```lego``` -komennon kuin aiemmin, mutta ilman ```--server=https://acme-staging-v02.api.letsencrypt.org/directory``` -osaa luodakseni sertifikaatin.  

```lego --accept-tos --email="giang.le@iki.fi" --domains="giangle.fi" --domains="www.giangle.fi" --http --http.webroot="/home/giang/public-sites/giangle.fi/" --path="/home/giang/lego/" --pem run```

<img src="https://github.com/user-attachments/assets/d9ac6f64-b49e-4f17-84dd-64c9049cf1b3" width="500"> <br/>   

Palautunut viesti näytti onnistuneelta sertifikaatin luonnilta, joten tarkastin jälleen ```find``` -komennolla, että sertifikaatti on luotuna. 

```find /home/giang/lego/```

<img src="https://github.com/user-attachments/assets/bf324cca-8253-4999-8d2f-14c112547d56" width="500"> <br/>   

### .conf tiedoston muokkaus ja 443-portin avaus palomuuriin

Sertifikaatin luonnin jälkeen vuorossa on SSL:n käyttöönotto ja sivuston .conf tiedoston muokkaus. Aloitin ottamalla käyttöön apachen SSL-moduulin ja sen jälkeen käynnistämällä apachen uudelleen. 

```sudo a2enmod ssl```

```sudo systemctl restart apache2```

Sen jälkeen muokkasin sivuston .conf -tiedostoa ottaakseni. 

```micro /etc/apache2/sites-available/giangle.fi.conf```


Uudeksi .conf tiedoston sisällöksi muodostui: 

```
<VirtualHost *:80>
 ServerName giangle.fi
 ServerAlias www.giangle.fi
 DocumentRoot /home/giang/public-sites/giangle.fi
 <Directory /home/giang/public-sites/giangle.fi>
   Require all granted
 </Directory>
</VirtualHost>

<VirtualHost *:443>
 ServerName giangle.fi
 ServerAlias www.giangle.fi
 DocumentRoot /home/giang/public-sites/giangle.fi
 <Directory /home/giang/public-sites/giangle.fi>
   Require all granted
 </Directory>

 SSLEngine On
 SSLCertificateFile '/home/giang/lego/certificates/giangle.fi.crt'
 SSLCertificateKeyFile '/home/giang/lego/certificates/giangle.fi.key'

</VirtualHost>
```

Muokatessani .conf tiedostoa alle tuli ilmoitus, että tiedosto 'readonly' ja tallentaessa tiedostoa kysyi micro-editori vielä erikseen haluanko tallentaa käyttäen sudo-oikeuksia. 

<img src="https://github.com/user-attachments/assets/51e4783e-c457-4d7e-a9a8-4f38b9166bcd" width="500"> <br/>   

<img src="https://github.com/user-attachments/assets/6d48bcb8-dd05-4d7a-b3df-3a911b3d0fbf" width="500"> <br/>   


Käynnistin tämän jälkeen apachen uudelleen ja kokeilin testasin muokattua .conf tiedostoa configtest:llä. 

```sudo systemctl restart apache2```

```sudo apache2ctl configtest```

<img src="https://github.com/user-attachments/assets/544b4309-7ed4-4ba3-a270-7228242dd4d7" width="500"> <br/>   

Tein vielä reiän palomuuriin ja tarkastin sen jälkeen vielä palomuurin statuksen. 

```sudo ufw allow 443/tcp```

```sudo ufw status```

<img src="https://github.com/user-attachments/assets/b7b0dd7d-2662-4bc2-82a0-a4bedea29c24" width="500"> <br/>   

Lopuksi tarkastin, että sivusto toimii odotetusti menemällä selaimella sivulleni https:// etuliitteen kanssa (https://giangle.fi/). Toimiva sivu ja varmenne olivatkin siellä vastassa. 

<img src="https://github.com/user-attachments/assets/2b069b43-5d86-4905-9477-f28f011ede89" width="500"> <br/>   


## b) SSL Test

Kävin testaamassa vielä SSL Labsin SSL-testillä sivuani (https://www.ssllabs.com/ssltest/)

<img src="https://github.com/user-attachments/assets/b11b194e-08ce-4672-8421-77ad2dfe31f1" width="500"> <br/>   


## Automaattinen sertifikaatin uusiminen

Kokeilin ensin että uusimiskomentoni toimii odotetusti eikä anna virhettä. 

```lego --accept-tos --email="giang.le@iki.fi" --domains="giangle.fi" --domains="www.giangle.fi" --http --http.webroot="/home/giang/public-sites/giangle.fi/" --path="/home/giang/lego/" --pem renew```

<img src="https://github.com/user-attachments/assets/c73ab3fe-b1e9-446b-b4ab-ae1e9e2cd8ef" width="500"> <br/>  

Tämän jälkeen avasin crontab:n. 

```sudo crontab -e```

<img src="https://github.com/user-attachments/assets/cb7ce8b8-ddcf-4dfc-a3a0-98e80253ef71" width="500"> <br/>  

Valitsin satunnaisen uusimisajan komennolle (```25 4 * * *```) eli joka päivä klo 4:25 ja lisäsin loppuun vielä ```&& systemctl restart apache2```, jotta apache käynnistyisi uudelleen aina uusimisyrityksen jälkeen. 

```25 4 * * * lego --accept-tos --email="giang.le@iki.fi" --domains="giangle.fi" --domains="www.giangle.fi" --http --http.webroot="/home/giang/public-sites/giangle.fi/" --path="/home/giang/lego/" --pem renew && systemctl restart apache2```

<img src="https://github.com/user-attachments/assets/b0dbc0a0-8707-4e75-a61c-7864fcea0cb6" width="500"> <br/>  

Testatakseni, että asettamani komento toimii odotetustia muokkasin crontabin niin, että se alkaisi pian muokkauksen jälkeen. Kello oli 20:55, joten muokkasin crontabiin 56 * * * * ja odotin muutaman minuutin. 

```56 * * * * lego --accept-tos --email="giang.le@iki.fi" --domains="giangle.fi" --domains="www.giangle.fi" --http --http.webroot="/home/giang/public-sites/giangle.fi/" --path="/home/giang/lego/" --pem renew && systemctl restart apache2```

Kun muutama minuutti oli kulunut tarkastin cron:n logit ja vielä apache:n statuksen, jotta näen milloin apache käynnistynyt uudelleen. 

```tail -3 /var/log/cron.log```

<img src="https://github.com/user-attachments/assets/acbec994-6627-4f49-9510-e83966dd343a" width="500"> <br/>  

```sudo systemctl status apache2```

<img src="https://github.com/user-attachments/assets/52a2ae53-8741-473a-b0a2-edff9114723c" width="500"> <br/>  

Sillä ajastus toimi odotetusti, muutin ajastuksen takaisin haluamaani uusimisaikaan. 

```sudo crontab -e```

```25 4 * * * lego --accept-tos --email="giang.le@iki.fi" --domains="giangle.fi" --domains="www.giangle.fi" --http --http.webroot="/home/giang/public-sites/giangle.fi/" --path="/home/giang/lego/" --pem renew && systemctl restart apache2```


## Lähteet: 
Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.   
https://terokarvinen.com/linux-palvelimet/   
Tehtävänanto.   

Let's Encrypt. How it works.    
https://letsencrypt.org/how-it-works/   
Tehtävä x & a.    

GitHub/LEGO. Obtain a certificate.    
https://go-acme.github.io/lego/usage/cli/obtain-a-certificate/index.html#using-an-existing-running-web-server    
Tehtävä x & a. 

Apache HTTP server project. s.a. SSL/TLS Strong Encryption: How-To.    
https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html#configexample   
Tehtävä x & a. 

SSL Labs. SSL Server Test.    
https://www.ssllabs.com/ssltest/    
Tehtävä b. 

Hostinger. What Is a Cron Job: Understanding Cron Syntax and How to Configure Cron Jobs. 
https://www.hostinger.com/tutorials/cron-job    
Cron. 

Phoenixnap. How to Create and Set Up a Cron Job in Linux. 
https://phoenixnap.com/kb/set-up-cron-job-linux
Cron. 
