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

## a) WebSDR. Etäkäytä WebSDR-ohjelmaradiota, joka on kaukana sinusta ja kuuntele radioliikennettä. 

Aloitin menemällä osoitteeseen WebSDR:n sivuille (http://websdr.org/). Selaimena käytin Chromea (```Version 135.0.7049.85 (Official Build) (64-bit)```) Valitsin ensimmäisenä kanavan Kreikassa olevaan kanavaan: ```SDR Station by SV3YY in RIO GREECE```.

![a1](https://github.com/user-attachments/assets/4747c7fb-fd4d-4844-b33a-5c4c51e2e2e0)

Sivuille mentyäni tuli esille ponnahdusikkuna, jota painamalla äänet lähtivät kuulumaan. Nappulan painamisen tarve johtuu siitä, että selain estää sivustoja laittamasta ääniä automaattisesti päälle. 

![a2](https://github.com/user-attachments/assets/dcdb70fa-0f92-4334-9334-008a15eae4a8)

Alkuun kuului vain kohinaa. 

![a3](https://github.com/user-attachments/assets/1b4edb9c-ea92-4539-bbaf-fe19e0d129c0)

Siirsin tämän jälkeen valintaani (klikkaamalla) toiselle frekvenssille, jossa näkyi enemmän aktiivisuutta (punaista): 

![a4](https://github.com/user-attachments/assets/25aa6b62-cd24-4f8d-943d-6183908f878c)

Frekvenssi: ```7175,21kHz``` 

Modulaatio: ```LSB```

Aallonpituus: ```40m```

Nyt alkoikin kuulumaan jo puhetta, vaikka siitä saikin hieman huonosti selvää. Yritin hienosäätää frekvenssiä, mutta puhe oli edelleen epäselvää. Selkeästi radiolla puhuivat englantia aksentilla sekä jotain mahdollisesti kreikankielistä kieltä. Radiosta kuului jonkin verran ```Thank you thank you sir``` ja ```thank you mister and madam XX, my friend``` sekä oletettavasti saneltiin radioon laivan tunnusta tai vastaavaa: ```Alpha```, ```Tango```, ```Charlie```, ym. 

Päätin tämän jälkeen vielä vaihtaa toiseen maahan. Tällä kertaa Utahissa olevaan asemaan: ```Northern Utah WebSDR, Corinne, Utah, U.S.A.```

![aa1](https://github.com/user-attachments/assets/e46bd46c-39d5-4f25-a57d-0c820d30bd1e)

Avautui sivu, jossa pystyi valita eri antenneista. Päätin valita ensimmäisen ```WebSDR1 ("Yellow") - Covers the 2200, 630, 160, 80/75, 60 and 40 meter amateur bands, AM broadcast, the 120, and 60 meter shortwave broadcast bands and the 1750 meter LowFER band```.

![aa2](https://github.com/user-attachments/assets/1c35ee72-1ced-4519-b5a1-0c5cdeecf285)

Täytyi ensin jälleen aktivoida sivulle äänet. 

![aa3](https://github.com/user-attachments/assets/6c2b7097-58ae-4dd1-a1a8-c0bd07dd7398)

Säädin jälleen hieman aikaa frekvenssiä kunnes sain selvästi äänen kuuluviin. 

![aa4](https://github.com/user-attachments/assets/2da8649e-cb6a-4a9b-ac7b-cbb53569f7ba)

Frekvenssi: ```1160,00kHz``` 

Modulaatio: ```AM```

Aallonpituus: ```AM-160M-120M```

Kanava oli kuului hyvin, eikä siellä ollut juurikaan kohinaa. Kanava oli selkeästi jokin Utahin julkinen radiokanava, jossa uutisissa oli jokin haastattelu menossa (ja hetki sen jälkeen pitkä liuta mainoksia). Radiossa myöhemmin mainittiin myös radiokanavan nimi: Utah KSL. 

Kävin vielä lopuksi googlaamassa ja kuulemani kanava varmistuikin KSL:ksi. 

![aa5](https://github.com/user-attachments/assets/ec80fc96-2832-4bc4-bab3-6a44bc9297f9)

## b) rtl_433. Asenna rtl_433 automaattista analyysia varten. 

Aloitin asentamalla rtl_433:n. Vinkkien perusteella ajattelin, että asennus täytyy tehdä manuaalisesti mutta sivuilla (https://github.com/merbanan/rtl_433) olikin maininta Debianille asentamisesta apt-getin avulla. 

```apt-get install rtl-433```

Rtl_433 asentuikin hyvin ilman ylimääräistä säätöä. 

Kokeilin ensin ajaa vinkkien perusteella komennolla ```./rtl_433```, mutta ajattelinkin ettei se toimi silloin kun rtl_433 asennetaan apt-getin kautta. 

```./rtl_433```

```./rtl-433```

```rtl-433```

```rtl_433```

Lähdin sitten kokeilemaan vaihtoehtoisia (ja todennäisimpiä) komentoja kunnes oikea löytyi: ```rtl_433```. 

![b1](https://github.com/user-attachments/assets/947c5139-e805-4c10-99b3-89395c81cba1)

```rtl_433 version 22.11 (2022-11-19) inputs file rtl_tcp RTL-SDR SoapySDR```

Paketinhallinnasta löytynyt versio olikin vanhempi, joten kävin loppujen lopuksi kuitenkin lataamassa uudemman version GitHubista (https://github.com/merbanan/rtl_433/releases). 

Versioksi valikoitui: ```rtl_433-soapysdr-openssl3-Linux-amd64-25.02.zip```

Ladattuani tiedoston jatkoin purkamaan ```.zip``` -tiedoston. 

```cd Downloads/```

```unzip rtl_433-soapysdr-openssl3-Linux-amd64-25.02.zip ```

Siirsin sen vielä kotihakemistoon helpottaakseni sen käyttöä tulevaisuudessa. 

```mv rtl_433 /home/vtunk/rtl_433```

Ajoin lopuksi ohjelman nähdäkseni sen version. Tällä kertaa arvelin jo ennakkoon että ./tiedostonimi toimii. 

```./rtl_433```

![b2](https://github.com/user-attachments/assets/b57479b4-13c1-4eb8-986d-c875a8345aab)

Versio täsmää uusimpaan. 

## c) Automaattinen analyysi. Mitä tässä näytteessä tapahtuu? Mitä tunnisteita (id yms) löydät? Converted_433.92M_2000k.cs8. Analysoi näyte 'rtl_433' ohjelmalla.

Tein automaattisen analyysin rtl_433:lla. 

```./rtl_433 -r Converted_433.92M_2000k.cs8```

![c1](https://github.com/user-attachments/assets/53f69bf3-408d-4073-a68f-5e246e9751ef)

Tulostus oli pitempi, joten alla vielä automaattisen analyysin tulos:

```
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.083284s
model     : KlikAanKlikUit-Switch                  id        : 8785315
Unit      : 0            Group Call: No            Command   : Off           Dim       : No
Dim Value : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.083284s
model     : Proove-Security                        House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.083284s
model     : Nexa-Security House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.163125s
model     : KlikAanKlikUit-Switch                  id        : 8785315
Unit      : 0            Group Call: No            Command   : Off           Dim       : No
Dim Value : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.163125s
model     : Proove-Security                        House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.163125s
model     : Nexa-Security House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.242956s
model     : KlikAanKlikUit-Switch                  id        : 8785315
Unit      : 0            Group Call: No            Command   : Off           Dim       : No
Dim Value : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.242956s
model     : Proove-Security                        House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.242956s
model     : Nexa-Security House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.383568s
model     : KlikAanKlikUit-Switch                  id        : 8785315
Unit      : 0            Group Call: No            Command   : Off           Dim       : No
Dim Value : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.383568s
model     : Proove-Security                        House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.383568s
model     : Nexa-Security House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
```

Näytteessä näyttäisi olevan kolme eri signaalia: ```KlikAanKlikUit-Switch```, ```Proove-Security``` ja ```Nexa-Security```. Nämä kaikki näyttäisivät olleen lähetettyinä samanaikaisesti yhdessä nipussa, joten tutkaillaan yhtä nippua. 

```
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.083284s
model     : KlikAanKlikUit-Switch                  id        : 8785315
Unit      : 0            Group Call: No            Command   : Off           Dim       : No
Dim Value : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.083284s
model     : Proove-Security                        House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.083284s
model     : Nexa-Security House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
```

```KlikAanKlikUit-Switch```    
```time      : @0.083284s```: Aikaleima nauhoituksen aloituksesta    
```model     : KlikAanKlikUit-Switch```: rtl433:n tunnistama laitteen malli    
```id        : 8785315```: Kohdelaitteen tunniste/ID    
```Unit      : 0```: Mihin laitteeseen kohdistettu    
```Group Call: No```: Lähetetty vain kohdelaitteelle    
```Command   : Off```: Käsky sammuttaa laite    
```Dim       : No```: Ei himmennystä    
```Dim Value : 0```: Himmennyksen voimakkuus (0, sillä himmennys ei käytössä)    

Sillä Proove-Security ja Nexa-Security olivat sisällöltään identtisiä selitän vain toisen. 

```Proove-Security```

```time      : @0.083284s```: Aikaleima
```model     : Proove-Security```: Laitteen malli
```House Code: 8785315```: Kohdelaitteen tunniste/ID. Kyseessä nimen perusteella kodin turvajärjestelmä, joten ID = House Code. 
```Channel   : 3```: Mihin kanavaan kohdistettu    
```State     : OFF```: Laitteen nykyinen tila
```Unit      : 3```: Mihin laitteeseen kohdistettu    
```Group     : 0```: Mihin ryhmään kohdistettu


## d) Too complex 16? Olet nauhoittanut näytteen 'urh' -ohjelmalla .complex16s-muodossa. Muunna näyte rtl_433-yhteensopivaan muotoon ja analysoi se. Näyte Recorded-HackRF-20250411_183354-433_92MHz-2MSps-2MHz.complex16s

Lähdin uudelleennimeämään ladattua tiedostoa oikeaan formaattiin: 

```mv Recorded-HackRF-20250411_183354-433_92MHz-2MSps-2MHz.complex16s RF_433.92M_2000k.cs16```

Lähdin tämän jälkeen kokeilemaan tiedoston analysoimista. 

```./rtl_433 RF_433.92M_2000k.cs16 ```

![d1](https://github.com/user-attachments/assets/96f6b8c7-dcc3-4cd9-be33-ed2fbbc68325)

Tämä ei lähtenyt vielä toimimaan, joten aloitin lukemaan rtl433:n dokumentaatiota. Sivulla IQ_Formats (https://github.com/merbanan/rtl_433/blob/master/docs/IQ_FORMATS.md) löytyi esimerkki, jossa oli sama frekvenssi mutta eri sample rate. Muutin tämän perusteella tiedostonimeä vielä uudelleen ja kokeilin uudelleen ajaa rtl433:n analysointia. 

```mv RF_433.92M_2000k.cs16 RF_433.92M_1000k.cs16```

```./rtl_433 RF_433.92M_1000k.cs16```

![d2](https://github.com/user-attachments/assets/f4b19f0c-5036-4d0d-8ce8-5383ea7bf3a6)

```
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.242955s
model     : KlikAanKlikUit-Switch                  id        : 8785315
Unit      : 0            Group Call: No            Command   : Off           Dim       : No            Dim Value : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.242955s
model     : Proove-Security                        House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
time      : @0.242955s
model     : Nexa-Security House Code: 8785315
Channel   : 3            State     : OFF           Unit      : 3             Group     : 0
```

Kyseessä näyttäisivät olevan samat lähettimet kuin viimeksikin. 

## e) Ultimate. Asenna URH, the Ultimate Radio Hacker.

```sudo apt-get -y install pipx```

```pipx install urh```

```pipx ensurepath```

Tämän jälkeen suljin ja avasin terminaalin. 

```urh```

## f) Yleiskuva. Kuvaile näytettä yleisesti: kuinka pitkä, millä taajuudella, milloin nauhoitettu? Miltä näyte silmämääräisesti näyttää?



## g) Bittistä. Demoduloi signaali niin, että saat raakabittejä. Mikä on oikea modulaatio? Miten pitkä yksi raakabitti on ajassa? Kuvaile tätä aikaa vertaamalla sitä johonkin. (Monissa singaaleissa on line encoding, eli lopullisia bittejä varten näitä "raakabittejä" on vielä käsiteltävä)



## h) Vapaaehtoinen: Sdr++. Kokeile sdr++ -sovellusta ja esittele sillä jokin "hei maailma" -tyyppinen esimerkki.



## i) Vapaaehtoinen, vaikeahko: GNU Radio. Asenne GNU Radio ja tee sillä yksinkertainen "Hei maailma".



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

GitHub. s.a. Merbanan/rtl_433    
https://github.com/merbanan/rtl_433/
Tehtävä b.    

GitHub. s.a. Merbanan/rtl_433/IQ Formats  
https://github.com/merbanan/rtl_433/blob/master/docs/IQ_FORMATS.md
Tehtävä d.    
