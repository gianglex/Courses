# H4 Leviämässä

## x) Lue & Tiivistä
- Cracking Passwords with Hashcat
   - Järjestelmät eivät tallenna (ainakaan pitäisi) alkuperäisiä salasanoja vaan hasheja.
   - Hashaus on yksisuuntainen funktio.
   - Voidaan kuitenkin kokeilla millä salasanalla muodostuu sama hash. 
   - Hashcat tarvitsee hash-tyypin toimiakseen. 
- Crack File Password With John
   - John the ripper pystyy sanakirja-hyökkäyksellä murtamaan encryptoidun salasanan. 
   - Sanakirja hyökkäys ei toimi vahvoihin salasanoihin.
   - Suojattuja zip tiedostoja vastaan voidaan hyökätä hyökkäämällä sen hashiin. 
- Security Penetration Testing The Art of Hacking Series LiveLessons: Lesson 6
   - Salasanan suojaamien vaatii sen suojaamista sekä varastossa että kun sitä ollaan lähettämässä verkon yli.
   - Monet käyttävät oletussalasanoja tai samaa salasanaa kaikkiin laitteisiin.
   - Hyökkäysten ensimmäinen tavoite on tunnistaa validit käyttäjät, jonka jälkeen voidaan hyökätä salasanan kimppuun.
   - Hashaus ei ole encryptaamista, mutta sitä voidaan käyttää salasanojen suojaamiseen.
   - Hashaamiseen tulisi käyttää aina suolaa (salt).
   - Nykyään salasanoja on helpompi murtaa. 
- File-Format Exploits
   - File-format exploit ovat haavoittuvuuksia, jotka sijaitsevat lukijoissa (esim. Adobe PDF reader).
   - Nämä luottavat siihen, että käyttäjä avaa saastuneen tiedoston haavoittuvalla lukijalla.
   - Saastunutta tiedostoa voidaan esimerkiksi jakaa vastaanottajan sähköpostiin. 
- Understanding Active Directory
   - Active Directory on palvelu/työkalu, joka helpottaa käyttäjien, ryhmien, laitteiden ja käytänteiden hallintaa. 
   - Active Directoryn ollessa päällä, käyttäjien täytyy liittyä kyseiseen Windows toimialueelleseen toimiakseen.
   - Active Directorya määrittäessä, pitää sille luoda ```forest```, joka määrittelee sen loogisen turvallisuusrajan. 


## a) Asenna Hashcat ja testaa sen toiminta murtamalla esimerkkisalasana.

Aloitin asentamalla hashcatin

```bash
sudo apt-get install -y hashcat
```

Loin tämän jälkeen kansion hashcatille, jossa aion työskennellä. 

```bash
mkdir hashcat
```

```bash
cd hashcat
```

![a1](https://github.com/user-attachments/assets/309a56c0-0b58-4cea-aac6-64c808f2c9ef)

Latasin tämän jälkeen sanakirjan, jota aion käyttää salasanojen murtamiseen (tässä tapauksessa [SecLists/Passwords/Leaked-Databases/rockyou.txt.tar.gz](https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz)). Sillä tiedosto oli .tar.gz muodossa, purin pakkauksen sekä poistin alkuperäisen tiedoston. 

```bash
wget https://github.com/danielmiessler/SecLists/raw/0b739a3b00ec90f14fb1bb9a06841feffa1561f1/Passwords/Leaked-Databases/rockyou.txt.tar.gz
```

```bash
tar xf rockyou.txt.tar.gz
```

```bash
rm rockyou.txt.tar.gz
```

![a2](https://github.com/user-attachments/assets/4f268376-e79f-4749-8861-091313df6045)

Tämän jälkeen loin esimerkkihashin murtamista varten. Varmistin että käyttämäni sana varmasti löytyy sanakirjasta poimimalla satunnaisesta rivistä sanasanan. Jotta en näe käyttämääni sanaa, putkitin perään ```sha1sum``` -komennon. 

```bash
awk 'NR==1337 {printf "%s", $0}' rockyou.txt | sha1sum
```

```bash
82eeba1f2783a67ccb954e1fe51e2ee863084784
```

Lisäsin tehtävän loppuun lyhyen selityksen awk:sta ja tarkemman selityksen käytetystä komennosta, jos awk ei ole aiemmin tuttu. 

Seuraavaksi tunnistetaan mitä moodia pitää käyttää hashin purkamiseksi

```bash
hashid -m 82eeba1f2783a67ccb954e1fe51e2ee863084784
```

![a3](https://github.com/user-attachments/assets/d958e05b-2b5f-46fe-9637-77a987ff668a)

```SHA-1 [Hashcat Mode: 100]``` on siis tulos, joka täytyy ottaa huomioon. Hyvä huomata, että hashcat ehdottaa useampaa moodia. Muista vaihtoehdoista ei tässä tapauksesta tarvitse tässä välittää, sillä tiesimme käytetyn hash funktion jo ennakkoon. 

```bash
hashcat -m 100 '82eeba1f2783a67ccb954e1fe51e2ee863084784' rockyou.txt -o tulos
```

![a4](https://github.com/user-attachments/assets/26f477ac-dc84-459f-949a-009e88771e67)

Lopuksi tarkastetaan minkä salasanan hashcat löysi

```bash
cat tulos 
```

![a5](https://github.com/user-attachments/assets/9a13fdb7-48cf-4e7e-88d9-58edc779687d)

```bash
82eeba1f2783a67ccb954e1fe51e2ee863084784:ramirez
```

Salasana näyttäisi olevan ```ramirez```, joten tarkastetaan vielä lopuksi oliko se alunperin käytetty salasana tulostamalla rivin 1337 sana. 

```bash
awk 'NR==1337' rockyou.txt
```

![a6](https://github.com/user-attachments/assets/eba3f510-1225-4efa-8474-e408d720dd92)

hashcat näyttäisi selvittäneen oikean salasanan onnistuneesti. 


### awk

Awk on tekstin prosessointiin ja suodatukseen käytetty työkalu. Sen avulla tekstiä voidaan suodattaa/prosessoida tavalla, mihin grep ei tyypillisesti sovellu (esim. suodattamaan määrireltyä aikaväliä tai muuttamaan suodatettua tietoa)

Lyhyt selitys vielä, jos ```awk``` -komento ei ole tuttu:     
```awk``` = työkalun nimi    
```NR==1337``` = Number of Record eli rivi 1337    
```{printf "%s", $0}``` = Print string, tässä tapauksessa halutaan pelkästään sana. Ilman tätä mukaan saattaisi tulla rivin lopussa oleva rivinvaihto. Mikäli tarkoituksena voin tulostaa valittu rivi, ei tätä tarvita mutta emme halua hashiin mukaan rivinvaihtoa.    
```rockyou.txt``` = kohdetiedosto, jolle suodatus tehdään    

Aiemmassa tehtävässä oleellista on, että rivinvaihto sisällyttäminen johtaa eri hashiin. 

```bash
awk 'NR==1337' rockyou.txt | sha1sum
efba0ddb75787cf6bf8734ea741152879bc62dd0
```

```bash
awk 'NR==1337 {printf "%s", $0}' rockyou.txt | sha1sum
82eeba1f2783a67ccb954e1fe51e2ee863084784
```

```bash
echo -n "ramirez" | sha1sum
82eeba1f2783a67ccb954e1fe51e2ee863084784
```


## c) Asenna John the Ripper ja testaa sen toiminta murtamalla jonkin esimerkkitiedoston salasana.

Siirryin John the Ripperin asennukseen. Ohjeistan poiketen, asensin john the ripperin ```apt-get```:llä sillä se löytyi Kalin paketinhallinnasta. 

```bash
apt-cache search 'john the ripper'
```

![c1](https://github.com/user-attachments/assets/45dd3ab7-cffa-4c62-ba40-ab0a323c61a3)

```bash
sudo apt-get install 'john'
```

![c2](https://github.com/user-attachments/assets/0f6867ef-4a9a-4cc0-95cd-78a3becd95e8)

Se olikin jo valmiiksi asennettuna Kaliin. Loin ensin kansion John the Ripperille sekä esimerkkitiedoston. 

```bash
mkdir jtr
```

```bash
cd jtr
```

```bash
echo "crackishellofadrug" > secret
```

Tämän jälkeen pakkasin tiedoston salasanalla. Käytän tässä hyödykseni aiemmin lataamaani rockyou.txt:ä. Ensin kopioin sen kuitenkin hashcat kansiosta nykyisesen kansiooni. 

```bash
cp /home/tunkt/hashcat/rockyou.txt /home/tunkt/jtr/rockyou.txt
```

```bash
zip -P "$(awk 'NR==5555 {printf "%s", $0}' rockyou.txt)" secret.zip secret
```

Lopuksi tarkastan vielä, etten pysty sitä purkamaan. 

```bash
unzip secret.zip
```

![c3](https://github.com/user-attachments/assets/71b5a965-47a7-4adb-a1c0-bf8920829278)

Purkaminen vaatii siis salasanan, jota minulla ei vielä ole. 

Luodaan .zip tiedostosta hash, jota voidaan yrittää John the Ripperin avulla murtaa. 

```bash
zip2john secret.zip > secret.zip.hash
```

```bash
cat secret.zip.hash
```

![c4](https://github.com/user-attachments/assets/a785907b-bb22-4741-93ad-31d8fb902346)

Nyt kun tiedostosta onnistuneesti luotu hash, joidaan aloittaa sen murtaminen John the Ripperillä. 


```bash
john secret.zip.hash
```

![c5](https://github.com/user-attachments/assets/884e38fb-9a10-4f1a-a97c-48725204f00e)

Salasana näyttäisi olevan John the Ripperin mukaan ```katelynn```, joten tarkastetaan vielä lopuksi oliko sanasana oikein. 

```bash
awk 'NR==5555' rockyou.txt
```

![c6](https://github.com/user-attachments/assets/d7817d31-effa-48ce-9bf4-3ee772c3695b)

John the Ripper näyttäisi antaneen oikean salasanan ```katelynn```. 


## e) Tiedosto. Tee itse tai etsi verkosta jokin salakirjoitettu tiedosto, jonka saat auki. Murra sen salaus. (Jokin muu formaatti kuin aiemmissa alakohdissa kokeilemasi).



```bash

```

```bash

```

```bash

```

## f) Tiiviste. Tee itse tai etsi verkosta salasanan tiiviste, jonka saat auki. Murra sen salaus. (Jokin muu formaatti kuin aiemmissa alakohdissa kokeilemasi. Voit esim. tehdä käyttäjän Linuxiin ja murtaa sen salasanan.)



## g) Tee msfvenom-työkalulla haittaohjelma, joka soittaa kotiin (reverse shell). Ota yhteys vastaan metasploitin multi/handler -työkalulla.
Haittaohjelma ei saa olla automaattisesti leviävä. Msfvenom tekee tyypillisillä asetuksilla ohjelman, joka avaa reverse shellin, kun sen ajaa, mutta joka ei leviä eikä tee muutenkaan mitään itsestään.
Raporttiin riittävät pelkät komennot ja raportti haitakkeen tekemisestä, itse binääriä ei ole pakko laittaa verkkoon. Mikäli laitat binäärin verkkoon, pakkaa se salakirjoitettuun zip-pakettiin ja laita salasanaksi "infected". Latauslinkin yhteydessä on oltava selkeä varoitus siitä, että kyseessä on haittaohjelma (malware), jota ei tule ajaa tuotantokoneilla. Salasanan voit halutessasi kertoa varoitusten yhteydessä.
Palvelimen päässä pitää olla reikä tulimuurissa. Reverse shell tarkoittaa, että palvelin on hyökkäyskoneella.



```
```

<img src="
" width="500"> <br/>


## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 2h
- Tehtäviin n. h. 
- Raportointiin ja dokumentointiin n. h. 

## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

Karvinen, T. 2022. Cracking Passwords with Hashcat.     
https://terokarvinen.com/2022/cracking-passwords-with-hashcat/    
Tehtävä x.    

Karvinen, T. 2023. Crack File Password With John.     
https://terokarvinen.com/2023/crack-file-password-with-john/   
Tehtävä x.    

Santos, O et al. 2017. The Art of Hacking Series LiveLessons. Lesson 6: Hacking User Credentials.     
https://www.oreilly.com/videos/security-penetration-testing/9780134833989/9780134833989-sptt_00_06_00_00/    
Tehtävä x.    

Kennedy, D et al. 2025. Metasploit, 2nd Edition. Chapter 9: Client-side attacks.    
https://www.oreilly.com/library/view/metasploit-2nd-edition/9798341620032/xhtml/chapter9.xhtml#:-:text=File-Format%20Exploits    
Tehtävä x.    

Singh, G. 2024. The Ultimate Kali Linux Book - Third Edition. Chapter 12: Understanding Active Directory.     
https://www.oreilly.com/library/view/the-ultimate-kali/9781835085806/Text/Chapter_12.xhtml#_idParaDest-272    
Tehtävä x.    

GitHub. s.a. SecLists/Passwords/Leaked-Databases/rockyou.txt.tar.gz    
https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz    
Tehtävät a, c.    
