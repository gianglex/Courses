# H3 Aaltoja harjaamassa

## x) Lue & Tiivistä
- Universal Radio Hacker SDR Tutorial on 433 MHz radio plugs
  - Signaalia kuunnellessa täytyy asettaa valittu frekvenssi poikkemaan frekvenssin huipusta.
  - Signaalin kuuntelemiseksi täytyy valita ensin oikea modulaatio (videossa ASK), jonka jälkeen voi kokeilla parametrien automaattista tunnistusta.
  - Bit length:n tunnistus usein menee väärin, joten kannattaa verrata bit length:iä varsinaiseen lähetykseen. Pituuksien pitäisi olla suhteellisen samankokoisia. 
  - Tämän jälkeen voi vielä varmistaa, että bittien koko täsmää lähetykseen (Signal view = Analog). Mikäli se täsmää, voidaan sitä korjata säätämällä Error tolerancea.
  - Lopuksi voi vielä siirtyä Signal view = Demodulated ja säätää signaalin raja-arvoa täsmäämään signaaliin.
- Decode 433.92 MHz weather station data
  - rtl_433 on työkalu, jolla voi dekoodata eri taajuuksilla olevien laitteiden lähetyksiä.
  - On olemassa myös [tietokanta](https://triq.org/explorer/), rtl_433 tukemista dekoodereista.
  - Universal Radio Hackerin (URH) avulla voi nauhoittaa, analysoida, muokata ja uudelleenlähettää mitä tahansa signaalia.
- Decoding ASK/OOK_PPM Signals with URH and rtl_433
  - Avaa tiedosto URH:lla
  - Vaihda Signal View Spectrogrammiin
  - Maalaa signaali ja oikealla hiirinäppäimellä valitse Apply Band Filter
  - Aseta bit length ja error tolerance pieneksi
  - Määrittele signaalin pituus
  - Aseta pause threshold, jotta URH jakaa signaalit
  - Käytä analysointi-välilehteä signaalin dekoodaamiseen ja muuta signaali heksadesimaaliin
  - Hyödynnä aiemmin kerättyä tietoa signaalin dekoodaamiseen rtl_433:n avulla

## a) WebSDR. Etäkäytä WebSDR-ohjelmaradiota, joka on kaukana sinusta ja kuuntele radioliikennettä. Radioliikenne tulee siepata niin, että radiovastaanotin on joko eri maassa tai vähintään 400 km paikasta, jossa teet tätä tehtävää. Käytä esimerkkinä julkista, suurelle yleisölle tarkoitettua viestiä, esimerkiksi yleisradiolähetystä. Kerro löytämäsi taajuus, aallonpituus ja modulaatio. Kuvaile askeleet ja ota ruutukaappaus. (Tehtävässä ei saa ilmaista sellaisen viestin sisältöä tai olemassaoloa, joka ei ole tarkoitettu julkiseksi. Voit sen sijaan kuvailla, miten sait julkisen radiolähetyksen kuulumaan kaiuttimistasi. Julkisten, esimerkiksi yleisradiolähetysten sisältöä saa tietysti kuvailla.)

b) rtl_433. Asenna rtl_433 automaattista analyysia varten. Kokeile, että voit ajaa sitä. './rtl_433' vastaa "rtl_433 version 25.02 branch..."

c) Automaattinen analyysi. Mitä tässä näytteessä tapahtuu? Mitä tunnisteita (id yms) löydät? Converted_433.92M_2000k.cs8. Analysoi näyte 'rtl_433' ohjelmalla.

d) Too compex 16? Olet nauhoittanut näytteen 'urh' -ohjelmalla .complex16s-muodossa. Muunna näyte rtl_433-yhteensopivaan muotoon ja analysoi se. Näyte Recorded-HackRF-20250411_183354-433_92MHz-2MSps-2MHz.complex16s

e) Ultimate. Asenna URH, the Ultimate Radio Hacker.

f) Yleiskuva. Kuvaile näytettä yleisesti: kuinka pitkä, millä taajuudella, milloin nauhoitettu? Miltä näyte silmämääräisesti näyttää?

g) Bittistä. Demoduloi signaali niin, että saat raakabittejä. Mikä on oikea modulaatio? Miten pitkä yksi raakabitti on ajassa? Kuvaile tätä aikaa vertaamalla sitä johonkin. (Monissa singaaleissa on line encoding, eli lopullisia bittejä varten näitä "raakabittejä" on vielä käsiteltävä)

h) Vapaaehtoinen: Sdr++. Kokeile sdr++ -sovellusta ja esittele sillä jokin "hei maailma" -tyyppinen esimerkki.

i) Vapaaehtoinen, vaikeahko: GNU Radio. Asenne GNU Radio ja tee sillä yksinkertainen "Hei maailma".



```
```

<img src="
" width="500"> <br/>


## Ajankäyttö
- Tiivistelmiin n. 1h.
- Tehtäviin n. 
- Raportointiin ja dokumentointiin n. 

## Lähteet
Karvinen, T. 2025. Verkkoon tunkeutuminen ja tiedustelu.    
https://terokarvinen.com/verkkoon-tunkeutuminen-ja-tiedustelu/    
Tehtävänanto.    
