# H5 Kohti omaa treeniä

## x) Lue & Tiivistä
- Deviant Ollam. All About Implantable RFID: Is Cyborgification Right for YOU?
  - Esityksessä kerrottiin yleisesti RFID:n toimintamekaniikasta.
  - RFID kulunvalvonta koostuu usein useammasta eri valmistajien osista, jotka toimivat yhdessä kulunvalvonnassa.
  - RFID:t voidaan jakaa kolmeen ryhmään low frequency (LF), high frequency (HF) ja ultra-high frequence (UHF)
  - Tyypillisesti ihon alle otettavat RFID:t ovat LF tai HF.
  - LF-tekniikka on suhteellisen vanhaa, huonosti suojattuja ja niiden toiminta yksinkertaisia.
  - HF-tekniikka on uudempaa, paremmin suojattuja ja niillä on enemmän toimintoja kuin LF-tekniikalla.
  - RFID implantin asentaminen ihon alle on suhteellisen yksinkertainen ja nopea toimenpide. 

## a) Lippuvalmistelu

Valmistelin koneeni lipunryöstöä varten. Pääosin virtuaalikoneellani oli jo tarvittavat työkalut, sillä Kalin mukana tulevat lähes kaikki tarvitsemani työkalut. Alla vielä miten ratkoisin mainittuja kysymyksiä: 
- amd64 binnäärit
  - Asensin tätä varten Ghidran virtuaalikoneelleni.
- Netti
  - Virtuaalikoneestani pääsee nettiin ja siitä saa tarvittaessa katkaistua verkkoyhteyden.
- Tiedostojen tarkastus
  - Virtuaalikoneellani ei ole mitään luottamuksellisia tietoja.
- Muistiinpanot
  - Koneellani ei ole ylimääräisiä muistiinpanoja vaan tarvittaessa löydän tarvitsemani materiaalit netistä.
- Paikallinen tekoäly
  - En usko tarvitsevani paikallista tekoälyä, eikä läppärini tehot muutenkaan jaksaisi purskuttaa tarpeeksi tehokkaasti tekoälyä. 

## b) HackTheBox/Crocodile. 

Päätin tehdä tehtävää varten HackTheBoxin Crocodile moduulin. 

Aloitin luomalla VPN yhteyden HTB:n OpenVPN tiedoston avulla ja käynnistin maalikoneen Spawn Machine nappulasta. 

### What Nmap scanning switch employs the use of default scripts during a scan?

Aloitin ajamalla nmapin 

```sudo nmap -sC -sV 10.129.254.51```

<img src="https://github.com/user-attachments/assets/f0b5e3e9-dfba-480d-9571-bec3671ec5ff" width="500"> <br/>

```-sC``` tarkoittaa script scannia. 

```-sV``` tarkoittaa service/version detectionia. 

Flag: **-sC**

### What service version is found to be running on port 21?

Tämä löytyi edellisestä portti skannauksesta. 

Flag: **vsftpd 3.0.3**

### What FTP code is returned to us for the "Anonymous FTP login allowed" message?

Tämäki löytyi aiemmasta skannauksesta. 

Flag: **230**

### After connecting to the FTP server using the ftp client, what username do we provide when prompted to log in anonymously?

Tämäkin samasta portskannista. 

Flag: **Anonymous**

### After connecting to the FTP server anonymously, what command can we use to download the files we find on the FTP server?

Yhdistetään koneeseen ftp komennolla ja tunnusta kysyttäessä, kirjadutaan Anonymous tunnuksella. 

```ftp 10.129.254.51```

Päästyämme sisään voimme selvittää halutun komennon käyttämällä ```help``` -komentoa

```help```

<img src="https://github.com/user-attachments/assets/5e5a87d6-c146-4cb3-b9e5-54a8cddb391a" width="500"> <br/>

Flag: **get**

### What is one of the higher-privilege sounding usernames in 'allowed.userlist' that we download from the FTP server?

Käyttämällä ```ls``` -komentoa voimme nähdä mitä tiedostoja on saatavilla. Kun tiedämme tiedostot ladataan nämä ```get``` -komennolla. 

```ls```

```get allowed.userlist```

```get allowed.userlist.passwd```

```cat allowed.userlist```

```cat allowed.userlist.passwd```

<img src="https://github.com/user-attachments/assets/6ecc47d1-b89d-4ee4-9115-57044c1f32a7" width="500"> <br/>

Flag: **admin**

### What version of Apache HTTP Server is running on the target host?

Yritetään kirjautua päästä sisään saaduilla käyttäjätunnuksilla. 

```ftp 10.129.254.51```

Valitettavasti millään annetuista tunnuksista ei päästy kirjautumaa sisään. 

<img src="https://github.com/user-attachments/assets/b7f25732-7876-4629-afe0-37d888aef853" width="500"> <br/>

Apachen versio löytyy kuitenkin aiemmasta nmapistä. 

Flag: **Apache httpd 2.4.41**

### What switch can we use with Gobuster to specify we are looking for specific filetypes?

Sillä kyseessä web server, käydään ensin katsomassa miltä sivusto näyttää. 

<img src="https://github.com/user-attachments/assets/4796762e-361f-40ae-8ead-5d81c13519ad" width="500"> <br/>

Luin [gobusterin dokumentaatiota](https://github.com/OJ/gobuster) selvittääkseni kysymyksen. 

Flag: **-x**

### Which PHP file can we identify with directory brute force that will provide the opportunity to authenticate to the web service?

Käytetään gobusteria selvittääksemme halutun php tiedoston. 

```gobuster dir --url http://10.129.254.51/ --wordlist /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt -x php```

<img src="https://github.com/user-attachments/assets/b7bbdde8-0f61-426f-af4f-8a878f54b504" width="500"> <br/>

Flag: **login.php**

### Submit root flag

Mennään selaimella osoitteeseen ```10.129.254.51/login.php``` kokeilemaan aiemmassa tehtävässä saamiamme tunnuksia. 

<img src="https://github.com/user-attachments/assets/189fbe37-e543-4012-bebc-1daf131a991b" width="500"> <br/>

Flag: **c7110277ac44d78b6a9fff2232434d16**


## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 2h
- Tehtäviin ja materiaalien lukemiseen n. 1h. 
- Raportointiin ja dokumentointiin n. 1h. 

## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

Deviant Ollam. 2024. All About Implantable RFID: Is Cyborgification Right for YOU?    
https://www.youtube.com/watch?v=3EFKJ9KaWGY    
Tehtävä x.    

HackTheBox. s.a. Crocodile.    
https://app.hackthebox.com/starting-point    
Tehtävä b.    

GitHub. s.a. Gobuster.    
https://github.com/OJ/gobuster    
Tehtävä b.    
