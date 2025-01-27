# H2 - Komentaja Pingviini

## Command Line Basics -lyhyesti

Linux:n ja BSD:sn käyttämä CLI on ollut olemassa jo ennen internettiä. Se on kätevä, nopea ja helposti automatisoitavissa. 

```pwd``` ja ```ls``` -komennot ovat tärkeitä komentoja kun liikutaan hakemistoissa. 

Pienimmän käyttöoikeuden periaatteen mukaan komennot tulisi suorittaa aina pienimmällä mahdollisella käyttöoikeudella. 

```$ man komento``` näyttää komennon käyttöohjeen. 


## Micron asennus

1. Aloitin päivittämällä listan saatavilla olevista paketeista komennolla ```$ sudo apt-get update```
2. Tämän jälkeen asensin Micro-tekstieditorin komennolla ```$ sudo apt-get -y install micro```
3. Olin jo aiemmin asentanut Micro-tekstieditorin, joten Linux ilmoitti minulle että Linux on jo uusimmassa saatavilla olevassa versiossa.

<img src="https://github.com/user-attachments/assets/ae47292c-01fc-489b-8a59-471d69bce91d" width="500"> <br/>

## Komentoriviohjelmien asennus

1. Valitsin komentoriviohjelmikseni btop:n, googler:n ja neofetch:n.
2. Varmistin ennen asennusta ensin ```$ apt-cache search``` komennolla, että ohjelmat löytyvät pakettihakemistosta.
3. Tämän jälkeen asensin kaikki kolme ohjelmaa komennolla  ```$ sudo apt-get -y install btop googler neofetch```

<img src="https://github.com/user-attachments/assets/4ec22c16-2878-4f3a-91cc-b6188e53dff2" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/1961fd0f-c499-4ff1-a546-2adb018b1b88" width="500"> <br/>


### btop

Btop ohjelman käyttötarkoituksena on helpottaa järjestelmän monitorointia. Ohjelma mm. näyttää CPU:n, muistin ja levytilan statusta ja käyttöä. 

<img src="https://github.com/user-attachments/assets/56cfa1af-8263-48d3-abf2-162dce2dc0af" width="500"> <br/>

### googler

Googler ohjelman tarkoituksena on mahdollistaa googlen käyttö komentorivissä. En valitettavasti saanut yrityksistä huolimatta googleria toimimaan. 

<img src="https://github.com/user-attachments/assets/ea8a16a9-2858-41a5-95cb-9660d9c88488" width="500"> <br/>

Tarkastin ensin komennolla ```$ googler --version``` ohjelman version. GitHubissa oli ohjelmasta uudempi versio v4.3.2., joten poistin ohjelman komennolla ```$ sudo apt purge googler```

<img src="https://github.com/user-attachments/assets/19642a68-5fc3-4340-9f1b-9ee95c5ce90e" width="500"> <br/>

Tämän jälkeen asensin ohjeiden mukaisesti standalone-version komennolla ```$ sudo curl -o /usr/local/bin/googler https://raw.githubusercontent.com/jarun/googler/v4.3.2/googler && sudo chmod +x /usr/local/bin/googler``` ja päivitin sen vielä komennolla ```$ sudo googler -u```

<img src="https://github.com/user-attachments/assets/1d9f8481-2cb6-4566-a0d9-3a4565c6451e" width="500"> <br/>

Kokeilin tämän jälkeen vielä kerran käyttää ohjelmaa, mutta ohjelma ei edelleenkään toiminut odotetusti. 

<img src="https://github.com/user-attachments/assets/8b5a4cbd-3acf-4ac7-8c7f-66d6f4639d23" width="500"> <br/>


### neofetch

Neofetchin tarkoituksena on näyttää käyttöjärjestelmän ja tietokoneen tietoja selkeällä ja helposti luetttvalla muodolla. Tätä voidaan käyttää mm. debuggauksessa hyödyksi kun kysytään apua, jolloin toiset käyttävät voivat nähdä helposti käytössä olevan järjestelmän tietoja. 

<img src="https://github.com/user-attachments/assets/6b662a90-dd74-4c8d-af47-a841e5b317ca" width="500"> <br/>


## Filesystem Hierarchy Standard (FHS) 

```/``` on root-hakemisto. Kaikki tiedostot ovat root hakemiston alla. 

```/home/``` sisältää kaikkien käyttäjien kotihakemistot. 

```/home/giang/``` on giang-käyttähän kotihakemisto. Tämä on ainoa paikka, minne käyttäjä ```giang``` voi pysyvästi tallentaa tietoa. 

```/etc/``` sisältää kaikki järjestelmän asetukset. 

```/media/``` sisältää kaikki irroitettavat mediat, kuten esim. CD:t tai USB-tikut. 

```/var/log/``` sisältää kaikki järjestelmän lokitiedostot. 

<img src="https://github.com/user-attachments/assets/455d0f61-b5e0-4e43-a0c1-064120e55c5f" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/da022d5f-40df-4f6f-b3dd-d42aa586b302" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/787b448c-1864-40e0-bdc5-9f6daf5efe65" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/0b611fa8-2bf2-4a20-b9f2-f328d48dd681" width="500"> <br/>

## grep

Grep:n käyttö kannattaa aloittaa katsomalla grep:n manuaalia. Käytin tähän komentoa ```man grep|less``` jossa ```man grep``` -komento on putkitettu ```less```-komennon kanssa, jolloin käyttöohje saadaan helposti luettavampaan muotoon. 

```less```-komentoa käytettäessä voidaan navigoida lukemista seuraavasti: ```välilyönti``` = seuraava sivu, ```b``` = edellinen sivu, ```/``` = haku, ```q``` = poistuminen. 

<img src="https://github.com/user-attachments/assets/51a2c4cd-248b-4e50-93a6-af614ca13e22" width="500"> <br/>



```$ grep -R 'kala' LinuxPalvelimet/``` -komennolla hain sanaa kala ```LinuxPalvelimet/``` hakemistosta

<img src="https://github.com/user-attachments/assets/10c97d44-4449-46a6-8435-e2327b3ef310" width="500"> <br/>

```$ grep -r -i 'KOIRA' /home/``` -komennolla hain sanaa KOIRA /home/-hakemistosta ja sen alikansioista. ```-i``` -komento teki mahdolliseksi hakea sanaa välittämättä pienistä ja isoista kirjaimista. 

<img src="https://github.com/user-attachments/assets/82275225-5dca-436f-871c-8a706291c4d1" width="500"> <br/>


## List Hardware / lshw

Käytin ```$ sudo lshw -short -sanitize``` -komentoa listatakseni tietokoneeni raudan. Kuitenkin komentoa ei löytynyt, joten tiesin että lshw pitää vielä asentaa ennen käyttöä. 

Asentaakseni Linuxiin lshw:n käytin komentoa ```$ sudo apt-get install lshw```

<img src="https://github.com/user-attachments/assets/3b4d0860-9e2f-4d00-9f77-4c7c415d1361" width="500"> <br/>

Tämän jälkeen käyttäessäni  ```$ sudo lshw -short -sanitize``` -komentoa uudelleen, listasi terminaali tietokoneeni raudan. 

<img src="https://github.com/user-attachments/assets/02ba4e9a-7877-494b-ba14-9d87790da1ee" width="500"> <br/>


## Lähteet

Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.  
https://terokarvinen.com/linux-palvelimet/  
Tehtävänanto. 

Karvinen, T. s.a. Command Line Basics Revisited
https://terokarvinen.com/2020/command-line-basics-revisited/?fromSearch=command%20line%20basics%20revisited
Tehtävä x. 

Snedddon, J. 2023. 10 Best Command Line Apps for Ubuntu. 
https://www.omgubuntu.co.uk/2021/11/best-command-line-tools-ubuntu-linux
Tehtävä b. 

GibHub. s.a. Btop.
https://github.com/aristocratos/btop
Tehtävä b. 

GitHub. s.a. Googler. 
https://github.com/jarun/googler
Tehtävä b. 

GitHub. s.a. Neofetch. 
https://github.com/dylanaraps/neofetch
Tehtävä b. 
