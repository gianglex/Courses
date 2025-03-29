# H1 Sniff

h1 Sniff
x) Lue ja tiivistä. (Tässä x-alakohdassa ei tarvitse tehdä testejä tietokoneella, vain lukeminen tai kuunteleminen ja tiivistelmä riittää. Tiivistämiseen riittää muutama ranskalainen viiva.)
Karvinen 2025: Wireshark - Getting Started
Karvinen 2025: Network Interface Names on Linux
a) Linux. Asenna Debian tai Kali Linux virtuaalikoneeseen. (Tätä alakohtaa ei poikkeuksellisesti tarvitse raportoida, jos sinulla ei ole mitään ongelmia. Jos on mitään haasteita, tee täsmällinen raportti)
b) Ei voi kalastaa. Osoita, että pystyt katkaisemaan ja palauttamaan virtuaalikoneen Internet-yhteyden.
c) Wireshark. Asenna Wireshark. Sieppaa liikennettä Wiresharkilla. (Vain omaa liikennettäsi. Voit käyttää tähän esimerkiksi virtuaalikonetta).
d) Oikeesti TCP/IP. Osoita TCP/IP-mallin neljä kerrosta yhdestä siepatusta paketista. Voit selityksen tueksi laatikoida ne ruutukaappauksesta.
e) Mitäs tuli surffattua? Avaa surfing-secure.pcap. Tutustu siihen pintapuolisesti ja kuvaile, millainen kaappaus on kyseessä. Tässä siis vain lyhyesti ja yleisellä tasolla. Voit esimerkiksi vilkaista, montako konetta näkyy, mitä protokollia pistää silmään. Määrästä voit arvioida esimerkiksi pakettien lukumäärää, kaappauksen kokoa ja kestoa.
f) Mitä selainta käyttäjä käyttää? surfing-secure.pcap
g) Minkä merkkinen verkkokortti käyttäjällä on? surfing-secure.pcap
h) Millä weppipalvelimella käyttäjä on surffaillut? surfing-secure.pcap
Huonoja uutisia: yhteys on suojattu TLS-salauksella.
i) Analyysi. Sieppaa pieni määrä omaa liikennettäsi. Analysoi se, eli selitä mahdollisimman perusteellisesti, mitä tapahtuu. (Tässä pääpaino on siis analyysillä ja selityksellä, joten liikennettä kannattaa ottaa tarkasteluun todella vähän - vaikka vain pari pakettia. Gurut huomio: Selitä myös mielestäsi yksinkertaiset asiat.)

## x) Tiivistys

- Wireshark on johtava verkon kuuntelu- ja analysointityökalu. 
- Wiresharkilla voi tallentaa liikennettä ja tarkastella tietoja.
- Tietoja voi suodattaa Display filttereillä.
- Network interface on melkein kuten verkkokortti, se ei kuitenkaan välttämättä ole fyysinen.
- Tyypillisesti Network interfacen etuliite identifioi sen tyyppiä: en = wired ethernet, wl = wlan, lo = loopback adapter.

## a) Debianin asennus

![a1](https://github.com/user-attachments/assets/762076dd-1a69-4bb3-b86e-201325c399a9)

## b) Virtuaalikoneen internet-yhteyden katkaisu

Suljin internet-yhteyden käyttöjärjestelmän yläpalkista klikkaamalla verkkoyhteyksien kuvaketta ja valitsemalla ```Disconnect```

![b1](https://github.com/user-attachments/assets/19ddc58e-47eb-436d-ac4a-c97b35756bbe)

Tämän jälkeen kokeilin verkkoyhteyden toimivuutta pingaamalla CloudFlaren (1.1.1.1) ja Googlen (8.8.8.8) nimipalvelimiin. 

```ping 1.1.1.1```
```ping 8.8.8.8```

![b2](https://github.com/user-attachments/assets/b2290d1e-37b1-4fce-8fed-a6c860f2c0a0)

Sillä pingit osoitteisiin eivät toimineet, pystyin toteamaan että internet-yhteys oli onnistuneesti katkaistu. 

## c) Wireshark & d) TCP/IP

[omaliikenne.zip](https://github.com/user-attachments/files/19515728/omaliikenne.zip)

Liitteenä siepattu oma liikenteeni. 

TCP/IP:n neljä kerrosta ja kuvassa olevat vastineet: 
- Application layer: Transport Layer Security (TLS)
- Transport layer: Transmission Control Protocol (TCP)
- Internet layer: Internet Protocol Version 4 (IPv4)
- Link layer: Ethernet II

![c1](https://github.com/user-attachments/assets/a59bf1c1-b5a6-4515-9363-876ce315cda4)

## e) Surfing-secure.pcap alkuvilkaisu

- Kaappauksessa 283 framea. 

![e1](https://github.com/user-attachments/assets/90ac8f6b-db49-4a4b-97c8-654bd8544140)

- Liikenne näyttäisi pääosin olevan DNS, TCP ja TLS protokollan liikennettä. 

- Nopeasti tarkastelemalla ensimmäistä ja viimeistä framea saa selville kuinka pitkään kaappausta on tehty. 
   - Frame 1: Mar 28, 2025 17:28:09.043495000 EET
   - Frame 283: Mar 28, 2025 17:28:16.579175000 EET
   - Kaappaus on siis kestänyt vain 7 sekuntia. 

![e2](https://github.com/user-attachments/assets/f456dd54-f2a1-4ba1-bf55-fa6d57e66313)

![e3](https://github.com/user-attachments/assets/1010d3c7-c964-4ecb-b204-4b9b585138bf)

- Tutkailemalla keskusteluita voidaan myös nähdä mistä IP-osoitteista ja mihin IP-osoitteisiin on ollut liikennettä.  

![e4](https://github.com/user-attachments/assets/438ce58a-4714-4130-94e1-8e9072232117)

![e5](https://github.com/user-attachments/assets/4fd705d0-b0c2-459a-a8c5-bdb88581c441)

- Käyttäjä näyttäisi käyneen ainakin google.com:ssa ja terokarvinen.com:ssa.

![e6](https://github.com/user-attachments/assets/cbc6a7b8-bd93-415f-ace6-98327a7ae9ff)


## f), g), h) Surfing-secure.pcap kysymykset

- Mitä selainta käyttäjä käyttää?
   - 

- Minkä merkkinen verkkokortti käyttäjällä on?
   - 

- Millä weppipalvelimella käyttäjä on surffaillut?
   - 

## i) Analyysi omasta liikenteestä


## Lähteet
Karvinen, T. 2025. Wireshark - Getting Started.    
https://terokarvinen.com/wireshark-getting-started/    
Tehtävät x ja b.    

Karvinen, T. 2025. Network Interface Names on Linux.    
https://terokarvinen.com/network-interface-linux/    
Tehtävä x.    
