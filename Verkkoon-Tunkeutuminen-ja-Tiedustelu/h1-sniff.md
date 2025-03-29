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


![b1](https://github.com/user-attachments/assets/19ddc58e-47eb-436d-ac4a-c97b35756bbe)



## Lähteet
Karvinen, T. 2025. Wireshark - Getting Started.    
https://terokarvinen.com/wireshark-getting-started/    
Tehtävät x ja b.    

Karvinen, T. 2025. Network Interface Names on Linux.    
https://terokarvinen.com/network-interface-linux/    
Tehtävä x.    
