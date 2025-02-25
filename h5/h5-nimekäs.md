# H5 - Nimekäs

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

## a) Julkinen nimi verkkopalvelimelle

Minulla oli jo valmiiksi olemassa oleva domain HostingPalvelusta (https://www.hostingpalvelu.fi/) aiempia projektejani varten. Domainille oli lisäksi domainparkki-palvelu, jolla domaineja pystyy hallinnoimaan. Kokonaisuudessaan ei ollut palveluista edullisin, mutta en nähyt myöskään suurta hyötyä lähteä tekemään domainin siirtoa toiselle palveluntarjoajalle. 

Hostingpalvelun domainpalvelusta pääsi cPanel hallintapaneeliin. 

<img src="https://github.com/user-attachments/assets/ebf1a9c7-91e5-43bb-98ee-8a4581a528d0" width="500"> <br/>


Hallintapaneelista pääsin muokkaamaan DNS-tietueet giangle.fi:lle, josta ohjasin giangle.fi:n verkkopalvelimeni IP-osoitteelle. 

<img src="https://github.com/user-attachments/assets/90b45774-4848-4fb7-be48-57228e3f0f64" width="500"> <br/>

Testasin vielä että menemällä osoitteeseen giangle.fi, ohjaa sivusto samalla sivuille kuin 164.92.200.216


## b & c) Name-based virtual host & alasivut

Aloitin luomalla palvelimelleni uuden Name-based virtual hostin komennolla: 

```sudoedit /etc/apache2/sites-available/giangle.fi.conf```   

Lisäsin uuteen .conf tiedostoon alla olevat tiedot: 

```
<VirtualHost *:80>
 ServerName giangle.fi
 ServerAlias www.giangle.fi
 DocumentRoot /home/giang/public-sites/giangle.fi
 <Directory /home/giang/public-sites/giangle.fi>
   Require all granted
 </Directory>
</VirtualHost>
```

<img src="https://github.com/user-attachments/assets/0ca87c0a-2275-4784-a034-279afea8339c" width="500"> <br/>


Luotuani .conf tiedoston, loin vielä kansiot polkuun jotka .conf tiedostossa mainitsin poluksi. 

```cd```

```mkdir public-sites```

```cd public-sites```

```mkdir giangle.fi```

```cd giangle.fi```


Tämän jälkeen loin ```index.html``` tiedoston giangle.fi-kansioon komennolla ```nano index.html```, johon lisäsin tekstiksi vain ```24.2. Testisivu``` jotta pystyin testaamaan sivun toiminnan. 

Luotuani index.html -tiedoston, testasin sen toimintaa komennolla ```curl giangle.fi```, joka palautti jo tutuksi tulleen 403 Forbidden sivun. 

<img src="https://github.com/user-attachments/assets/21b8cbaf-d07f-4e07-bf56-f04a19d0830d" width="500"> <br/>

403 Forbidden sivun aiheuttavan vian selvittämiseksi käytin seuraavaksi komentoa ```sudo tail -1 /var/log/apache2/error.log``` 

<img src="https://github.com/user-attachments/assets/a994fc6c-359e-4b86-b8f3-ec3e3f70b39d" width="500"> <br/>

Haettuani virheviestiä googlesta (https://stackoverflow.com/questions/25190043/apache-permissions-are-missing-on-a-component-of-the-path) päättelin syyn johtuvan puuttuvista oikeuksista virheilmoituksen ja lukemieni viestien pohjalta. 

Käytin vielä komentoa ```ls -la /home/giang/public-sites/``` tarkastellakseni oikeuksia ennen niiden muokkaamista. 

<img src="https://github.com/user-attachments/assets/65252c13-82bf-48be-b0b9-9008d0c0ae23" width="500"> <br/>

Tämän jälkeen käytin komentoa ```chmod go+x /home/giang/``` lisääkseni ryhmille group (g) ja others (o) execute (+x) -oikeudet ja tarkastin uudelleen kansion oikeuksia. 

<img src="https://github.com/user-attachments/assets/29dc8225-88b5-49a5-9344-f61f7dab758d" width="500"> <br/>

Oikeuksien muuttamisen jälkeen käytin uudelleen vielä ```curl giangle.fi``` testatakseni sivun toimivuutta ja sivu lähtikin toivotusti toimimaan. 

<img src="https://github.com/user-attachments/assets/3c2c2e70-ffef-45c0-8f4c-2cc6db6f7d2a" width="500"> <br/>

Sivun toimiessa odotetusti muokkasin nykyisen index.html:n ja loin kaksi uutta alasivua (blog.html ja projects.html). Sivujen sisällöksi muodostui erittäin yksinkertainen HTML kokonaisuus, jossa pääasialliseksi sisällöksi muodostui otsikko sekä linkitys toisiinsa. 

```
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Index</title>
  </head>
  <body>
    <main>
        <h1>Index</h1>
    </main>
  </body>
  <nav>
   <a href="blog.html">Blog</a>
   <a href="projects.html">Projects</a>
</html>
```

## d) Alidomainien luonti

Loin luomalle sivulleni vielä uudet alidomaimet cPanel -hallintapaneelissa. Loin alidomainit cname.giangle.fi sekä testi.giangle.fi. 

<img src="https://github.com/user-attachments/assets/d5c6854a-aa57-48ea-b18d-f50169715aa7" width="500"> <br/>   

## e) host & dig

Aloitin kokeilemalla komentoa ```dig google.com```, joka ei kuitenkaan toiminut, sillä ohjelmaa ei oltu vielä asennettu Linuxilleni, joten asensin puuttuvan ohjelman komennolla ```sudo apt-get install dnsutils```

<img src="https://github.com/user-attachments/assets/08e6fed9-6bae-4f5d-b9df-68d13bc069d7" width="500"> <br/>   

```
$ host cname.giangle.fi
cname.giangle.fi is an alias for giangle.fi.
giangle.fi has address 164.92.200.216
```

```
$ dig cname.giangle.fi any

; <<>> DiG 9.18.33-1~deb12u2-Debian <<>> cname.giangle.fi any
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 22842
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;cname.giangle.fi.		IN	ANY

;; ANSWER SECTION:
cname.giangle.fi.	264	IN	CNAME	giangle.fi.
giangle.fi.		264	IN	A	164.92.200.216

;; Query time: 3 msec
;; SERVER: 10.0.2.3#53(10.0.2.3) (TCP)
;; WHEN: Mon Feb 24 17:43:58 EET 2025
;; MSG SIZE  rcvd: 75
```

Hain tarkoituksella cname.giangle.fi:tä nähdäkseni miten host ja dig komento reagoivat osoitteeseen, jolle määritelty cname-tietue. Molemmat komennot näyttävät sen, että kyseessä cname-tietue sekä näyttävät giangle.fi:n osoitteen. 

```
$ dig hs.fi any

; <<>> DiG 9.18.33-1~deb12u2-Debian <<>> hs.fi any
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 44547
;; flags: qr rd ra; QUERY: 1, ANSWER: 18, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;hs.fi.				IN	ANY

;; ANSWER SECTION:
hs.fi.			51	IN	A	108.156.22.8
hs.fi.			51	IN	A	108.156.22.61
hs.fi.			78193	IN	NS	ns-678.awsdns-20.net.
hs.fi.			86233	IN	MX	0 hs-fi.mail.protection.outlook.com.
hs.fi.			52	IN	AAAA	2600:9000:2368:5e00:b:5b2c:9f40:93a1
hs.fi.			898	IN	SOA	ns-1635.awsdns-12.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
hs.fi.			52	IN	AAAA	2600:9000:2368:da00:b:5b2c:9f40:93a1
hs.fi.			52	IN	AAAA	2600:9000:2368:e400:b:5b2c:9f40:93a1
hs.fi.			52	IN	AAAA	2600:9000:2368:4e00:b:5b2c:9f40:93a1
hs.fi.			78193	IN	NS	ns-1635.awsdns-12.co.uk.
hs.fi.			52	IN	AAAA	2600:9000:2368:ac00:b:5b2c:9f40:93a1
hs.fi.			52	IN	AAAA	2600:9000:2368:2200:b:5b2c:9f40:93a1
hs.fi.			51	IN	A	108.156.22.54
hs.fi.			52	IN	AAAA	2600:9000:2368:be00:b:5b2c:9f40:93a1
hs.fi.			78193	IN	NS	ns-1461.awsdns-54.org.
hs.fi.			78193	IN	NS	ns-83.awsdns-10.com.
hs.fi.			52	IN	AAAA	2600:9000:2368:ca00:b:5b2c:9f40:93a1
hs.fi.			51	IN	A	108.156.22.97

;; Query time: 3 msec
;; SERVER: 10.0.2.3#53(10.0.2.3) (TCP)
;; WHEN: Mon Feb 24 17:44:43 EET 2025
;; MSG SIZE  rcvd: 568

```

Hain vertailuksi hs.fi:n ja hs.fi:llä huomaa useamman A-tietueen lisäksi mm. MX (mail exchage), AAAA (IPv6), NS (name server record) sekä SOA (start of authority) -tietueet. 


## Lähteet: 
Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.   
https://terokarvinen.com/linux-palvelimet/   
Tehtävänanto.   

Karvinen, T. 2018. Name Based Virtual Hosts on Apache.    
https://terokarvinen.com/2018/04/10/name-based-virtual-hosts-on-apache-multiple-websites-to-single-ip-address/   
Tehtävä b&c.    

Apache HTTP server project. s.a. Name-based Virtual Host Support.   
https://httpd.apache.org/docs/2.4/vhosts/name-based.html   
Tehtävä b&c.   

Stackoverflow. s.a. Apache - Permissions are missing on a component of the path.    
https://stackoverflow.com/questions/25190043/apache-permissions-are-missing-on-a-component-of-the-path/    
Tehtävä b. 

Nords Digital Media. s.a. Mitä ovat DNS-tietueet?    
https://www.nords.fi/blogi/mita-ovat-dns-tietueet    
Tehtävä e.    

Ioflood. 2023. Unearth DNS Info with Dig: Linux Networking Guide    
https://ioflood.com/blog/dig-linux-command/    
Tehtävä e.    

Cloudflare. s.a. What is a DNS SOA record?    
https://www.cloudflare.com/learning/dns/dns-records/dns-soa-record/    
Tehtävä e.     
