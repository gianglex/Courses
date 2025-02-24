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




a) Nimi. Laita julkinen nimi osoittamaan omaan koneeseesi. (Siis vastaava kuin terokarvinen.com. Nimen saattaa saada myös ilmaiseksi Github Education -paketilla. Suosittelen hankkimaan oikean nimen, mutta jos välttämättä haluat, voit myös simuloida nimen toimintaa paikallisesti hosts-tiedoston avulla.)
b) Based. Laita Name Based Virtual Host näkymään uudessa nimessäsi. Kotisvuja pitää pystyä muokkaamaan ilman pääkäyttäjän oikeuksia.
c) Kotisivu. Tee vähintään kolmen erillisen alasivun (esim. index.html, blog.html, projects.html) kotisivu ja kopioi se näkymään palvelimellesi. Sivujen muokkaamisen pitää onnistua ilman pääkäyttäjän oikeuksia, niiden kopioiminen pääkäyttäjänä testisivun paikalle ei käy. Kotisivujen ei tarvitse olla hienoja, mutta niiden tulee olla validia HTML:ää ja linkittää toisiinsa.
d) Alidomain. Tee kaksi uutta alidomainia, jotka osoittava omaan koneeseesi. Esimerkiksi palvelu on example.com -> linuxkurssi.example.com. Alidomainit ovat tyypillisesti ilmaisia, kun sinulla on päädomain (example.com). Tässä tehtävässä riittää, että alidomainit avaavat saman sivun kuin päädomain. (Vapaaehtoinen bonus: Tee toinen alidomain A-tietueella ja toinen CNAME-tietueella. Vapaaehtoinen bonus: tee alidomainiin oma erillinen name based virtual host.)
e) Tutki jonkin nimen DNS-tietoja 'host' ja 'dig' -komennoilla. Käytä kumpaakin komentoa kaikkiin nimiin ja vertaa tuloksia. Katso man-sivulta, miten komennot toimivat - esimerkiksi miten 'dig' näyttää kaikki kentät. Analysoi tulokset, keskity nimipalvelimelta tulleisiin kenttiin (dig näyttää paljon muutakin tietoa). Etsi tarvittaessa uusia lähteitä haastaviin kohtiin. Sähköpostin todentamiseen liittyvät SPF ja DMARC -tietojen yksityiskohdat on jätetty vapaaehtoiseksi lisätehtäväksi. Tutkittavat nimet:
Oma domain-nimesi. Vertaa tuloksia nimen vuokraajan (namecheap.com, name.com...) weppiliittymässä näkyviin asetuksiin.
Jonkin pikkuyrityksen, kerhon tai yksittäisen henkilön weppisivut. (Ei kuitenkaan kurssikaverin tällä viikolla vuokrattua nimeä).
Jonkin suuren ja kaikkien tunteman palvelun tiedot.
f) Vapaaehtoinen bonus: Aakkossalaattia sähköpostiin. Etsi palvelu, jonka DNS-tiedoissa on SPF ja DMARC. Selitä näiden kenttien osat ja vaikutukset yksityiskohtaisesti. Voit halutessasi käyttää tulkinnan apuna jotain ohjelmaa tai palvelua, kunhan selität ja tulkitset lopputuloksen myös itse.


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
