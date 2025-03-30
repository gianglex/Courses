# H1 Sniff

## x) Tiivistys

- Wireshark on johtava verkon kuuntelu- ja analysointityökalu. 
- Wiresharkilla voi tallentaa liikennettä ja tarkastella tietoja.
- Tietoja voi suodattaa Display filttereillä.
- Network interface on melkein kuten verkkokortti, se ei kuitenkaan välttämättä ole fyysinen.
- Tyypillisesti Network interfacen etuliite identifioi sen tyyppiä: en = wired ethernet, wl = wlan, lo = loopback adapter.

## a) Debianin asennus

<img src="https://github.com/user-attachments/assets/762076dd-1a69-4bb3-b86e-201325c399a9" width="500"> <br/>

## b) Virtuaalikoneen internet-yhteyden katkaisu

Suljin internet-yhteyden käyttöjärjestelmän yläpalkista klikkaamalla verkkoyhteyksien kuvaketta ja valitsemalla ```Disconnect```

<img src="https://github.com/user-attachments/assets/19ddc58e-47eb-436d-ac4a-c97b35756bbe" width="500"> <br/>

Tämän jälkeen kokeilin verkkoyhteyden toimivuutta pingaamalla CloudFlaren (1.1.1.1) ja Googlen (8.8.8.8) nimipalvelimiin. 

```ping 1.1.1.1```

```ping 8.8.8.8```

<img src="https://github.com/user-attachments/assets/b2290d1e-37b1-4fce-8fed-a6c860f2c0a0" width="500"> <br/>

Sillä pingit osoitteisiin eivät toimineet, pystyin toteamaan että internet-yhteys oli onnistuneesti katkaistu. 

Internet-yhteyden palautettuani käytin vielä uudelleen ```ping``` -komentoa todetakseni yhteyden palanneen. 

<img src="https://github.com/user-attachments/assets/b6298463-de52-4042-9704-93714c6b56b2" width="500"> <br/>

## c) Wireshark & d) TCP/IP

[omaliikenne.zip](https://github.com/user-attachments/files/19515728/omaliikenne.zip)

Liitteenä siepattu oma liikenteeni. 

TCP/IP:n neljä kerrosta ja kuvassa olevat vastineet: 
- Application layer: Transport Layer Security (TLS)
- Transport layer: Transmission Control Protocol (TCP)
- Internet layer: Internet Protocol Version 4 (IPv4)
- Link layer: Ethernet II

<img src="https://github.com/user-attachments/assets/a59bf1c1-b5a6-4515-9363-876ce315cda4" width="500"> <br/>

## e) Surfing-secure.pcap alkuvilkaisu

Kaappauksessa 283 framea. 

<img src="https://github.com/user-attachments/assets/90ac8f6b-db49-4a4b-97c8-654bd8544140" width="500"> <br/>

Liikenne näyttäisi pääosin olevan DNS, TCP ja TLS protokollan liikennettä. 

Nopeasti tarkastelemalla ensimmäistä ja viimeistä framea saa selville kuinka pitkään kaappausta on tehty. 
   - Frame 1: Mar 28, 2025 17:28:09.043495000 EET
   - Frame 283: Mar 28, 2025 17:28:16.579175000 EET
   - Kaappaus on siis kestänyt vain ~7,5 sekuntia. 

<img src="https://github.com/user-attachments/assets/f456dd54-f2a1-4ba1-bf55-fa6d57e66313" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/1010d3c7-c964-4ecb-b204-4b9b585138bf" width="500"> <br/>

Tutkailemalla keskusteluita voidaan myös nähdä mistä IP-osoitteista ja mihin IP-osoitteisiin on ollut liikennettä.  

<img src="https://github.com/user-attachments/assets/438ce58a-4714-4130-94e1-8e9072232117" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/4fd705d0-b0c2-459a-a8c5-bdb88581c441" width="500"> <br/>

Käyttäjä näyttäisi käyneen ainakin google.com:ssa (frame 1) ja terokarvinen.com:ssa (frame 19).

<img src="https://github.com/user-attachments/assets/cbc6a7b8-bd93-415f-ace6-98327a7ae9ff" width="500"> <br/>


## f), g), h) Surfing-secure.pcap kysymykset

### f) Mitä selainta käyttäjä käyttää?
Selaimen selvittäminen olikin tehtävässä tyypillistä hankalampaa, sillä liikenne oli pääosin salattua ja usein selaintiedot selviävät HTTP protokollan tietoja tutkailemalla. Esimerkkikuva toisesta .pcap tallenteesta, josta HTTP liikennettä löytyi.
     
<img src="https://github.com/user-attachments/assets/c59f1451-6935-45ae-97d7-72bc2a8a203f" width="500"> <br/>

Päätin kuitenkin tutkailla tarkemmin vielä tallennetta NetworkMinerin avulla, jonka käytöstä minulla oli jo aiempaa kokemusta. Tutkailin NetworkMinerilla tallenteessa olevia parametreja (arvoja) ja huomasin toistuvan JA3 Hash:n (b5001237acdf006056b409cc433726b0) frameilla 32, 35, 108 ja 121. Nämä kaikki olivat Wiresharkissa sanomalla Client Hello ja ovat osa TLS Handshakea. (Lue: https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/)

<img src="https://github.com/user-attachments/assets/d6fcfc5b-44b9-40ea-8639-3d5a011db82a" width="500"> <br/>

JA3 fingerprintin avulla voidaan siis tunnistaa ohjelmia (ja varsinkin haittaohjelmia). (Lue: https://www.peakhour.io/learning/fingerprinting/what-is-ja3-fingerprinting/)

<img src="https://github.com/user-attachments/assets/e66d7f94-8760-4e32-a915-c70b2196e50a" width="500"> <br/>

Tämän jälkeen hyödynsin ja3.zone -sivustoa, joka on TLS Fingerprint tietokanta, ja hain tietokannasta framessa olleen JA3 hash:n (b5001237acdf006056b409cc433726b0) ja käytetty selain löytyi: Firefox. Huomiona 2 kpl (1kpl Chrome, 1kpl Chromium) tietokannassa olleesta 99:stä merkinnästä oli jotain muuta kuin Firefox, joten 100% varmuutta ei voi tästä olettaa. 

<img src="https://github.com/user-attachments/assets/0ae7fa64-ac64-4286-b5c3-1f6b55bb4f10" width="500"> <br/>

### g) Minkä merkkinen verkkokortti käyttäjällä on?
Tutkailemalla minkä tahansa framen Ethernet II -osiota, voidaan selvittää käyttäjän verkkokortti. Tässä tapauksessa se on RealTekU. 
 
<img src="https://github.com/user-attachments/assets/d5d3b887-555c-4d27-9a9f-ecdc243f39c3" width="500"> <br/>

### h) Millä weppipalvelimella käyttäjä on surffaillut?
Asettamalla display filteriin ```dns.qry.name``` saadaan suodatettua esille pelkästään DNS-kyselyt, joista selviää että käyttäjä käynyt google.com:ssa sekä terokarvinen.com:ssa. Muut kyselyt liittyivät goatcounter.com ja gc.zgo.at, jotka näyttäisi liittyvän terokarvinen.com:n sivustoanalytiikkaan GoatCounteriin (https://www.goatcounter.com/). 

<img src="https://github.com/user-attachments/assets/4487f2c7-d60f-40b5-814c-3e2b441c6814" width="500"> <br/>


## i) Analyysi omasta liikenteestä
- Päätin käyttää tehtävässä c tallentamaani kaappausta, tarkemmin ottaen ensimmäistä 12:sta framea tehtävän rajaamiseksi. 

<img src="https://github.com/user-attachments/assets/1fbb1a34-356e-4e53-9a7c-4ab3f28f9bff" width="500"> <br/>

- Frame 1 saapunut: Mar 29, 2025 06:37:21.175854000 EET
- Frame 12 saapunut: Mar 29, 2025 06:37:26.193131000 EET
- Kyseessä ollut ping komento, eli joka toinen frame ollut ```Echo (ping) request``` ja joka toinen ```Echo (ping) reply```
- Kyseessä ollut ping komennon sekvenssit 7 - 12.
- Protokollana toiminut ICMP (Internet Control Message Protocol), tarkemmin ottaen ICMPv4.
- Pingit lähteneet osoitteesta ```10.0.2.15``` (minun IP) ja menneet osoitteeseen ```1.1.1.1``` (Cloudflare).
- Verkkokorttina toiminut ```PcsCompu_a0:ec:a1 (08:00:27:a0:ec:a1)```

## Ajankäyttö

- Debianin asennukseen ~30min.
- Tehtäviin ~2h, josta noin suurin osa ajasta selaimen selvittämiseen. 
- Raporttiin ~2h. 

## Lähteet
Karvinen, T. 2025. Wireshark - Getting Started.    
https://terokarvinen.com/wireshark-getting-started/    
Tehtävät x ja b.    

Karvinen, T. 2025. Network Interface Names on Linux.    
https://terokarvinen.com/network-interface-linux/    
Tehtävä x.    

Wireshark. s.a. Building Display Filter Expressions.    
https://www.wireshark.org/docs/wsug_html_chunked/ChWorkBuildDisplayFilterSection.html    
Tehtävät c - i. 

Cloudflare. s.a. What happens in a TLS handshake? | SSL handshake.    
https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/    
Tehtävä f.    

Peakhour. s.a. What is JA3 Fingerprinting?    
https://www.peakhour.io/learning/fingerprinting/what-is-ja3-fingerprinting/    
Tehtävä f.    

Goatcounter. s.a. Goatcounter.    
https://www.goatcounter.com/    
Tehtävä h.    
