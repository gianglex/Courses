# H1 - Kybertappoketju

## x) Tiivistys

- Kuuntelin Herrasmieshakkerien ensimmäisen jakson.
   - Jaksossa käytiin läpi lyhyesti Mikko Hyppösen ja Tomi Tuomisen historiaa ja miten he olivat päätyneet kyberturvallisuuden pariin.
   - Tämän lisäksi käytiin läpi (vuonna 2019) ajankohtaisia uutisia.
   - Jakson Hovimestarin suositukset: Badrap.io, Youtube-dl, Curve ja Gentleman's gazette. 
- Intelligence-Driven Computer Network Defense Informed by Analysis of Adversary Campaigns and Intrusion Kill Chains
   - Tappoketju on systemaattinen prosessi kohdistaa ja hyökätä vastapuolelle saadakseen aikaan halutun vaikutuksen.
   - Verkkohyökkäyksessä nämä voidaan jakaa seuraaviin osiin: Reconnaissance (tiedustelu), Weaponization (aseistus), Delivery (toimitus), Exploitation (hyödyntäminen), Installation (asentaminen), Command and Control (käske ja hallitse) sekä Actions on Objectives (toiminta kohteessa). 
- The Art of Hacking: 4.3 Surveying Essential Tools for Active Reconnaissance
   - Porttiskannaustyökaluja: Nmap (https://nmap.org/), Masscan (https://github.com/robertdavidgraham/masscan), UDPProtoScanner (https://github.com/CiscoCXSecurity/udp-proto-scanner/)
   - Web-applikaatioiden priorisointiin: EyeWitness (https://github.com/ChrisTruncer/EyeWitness)
   - Verkkohaavoittuvuuksien skannaukseen: OpenVAS, Nessus, Nexpose, Qualys, Nmap
   - Webhaavoittuvuuksien skannaukseen: Nikto, WPScan, SQLMap, Burp Suite, Zed Attack Proxy
- KKO 2003:36
   - A oli tehnyt porttiskannauksen OPK osuuskunnan tietojärjestelmään ilman lupaa. 
   - Skannaus ei ollut läpäissyt palomuuria.
   - Hovioikeus katsoi, että A oli syyllistynyt tietomurron yritykseen.
   - Hovioikeus arvioi, että A oli aiheuttanut osuuskunnalle 20 000 ja yhtiölle 55 000 markan määräisen vahingon.
   - Korkein oikeus ylläpiti hovioikeuden päätöksen.

 
## a) Kalin asennus

![a1](https://github.com/user-attachments/assets/687940f2-a9fd-4ce8-b069-253a62c28c6e)

## b) Irrota Kali-virtuaalikone verkosta. Todista testein, että kone ei saa yhteyttä Internetiin (esim. 'ping 8.8.8.8')

Aloitin internetin irroittamisen netistä Kalin ylävalikon oikeasta laidasta painamalla Verkko -kuvaketta ja valitsemalla ```Disconnect```. 

![b1](https://github.com/user-attachments/assets/eb92e3de-1ed1-49b5-8e7f-57732c52fe01)

Tämän jälkeen ruudulle ilmestyi vielä viesti siitä, että verkkoyhteys oli katkaistu. 

![b2](https://github.com/user-attachments/assets/99e529e3-a120-4827-8cf6-ecbe97c34858)

Varmistin vielä lopuksi, että internet-yhteys on tosiaan pois päältä pingaamalla osoitteisiin 1.1.1.1 (CloudFlare) ja 8.8.8.8 (Google). 

```ping 1.1.1.1```

```ping 8.8.8.8```

![b3](https://github.com/user-attachments/assets/9708dac5-8392-4bbd-95da-1aabf46842d1)

Testi varmisti, että verkko tosiaan pois päältä. 

## c) Porttiskannaa 1000 tavallisinta tcp-porttia omasta koneestasi (nmap -T4 -A localhost). Selitä komennon paramterit. Analysoi ja selitä tulokset. 

```nmap -T4 -A localhost```

![c1](https://github.com/user-attachments/assets/1532ae41-311c-4ac2-9bfe-03d020315049)

Parametrit ja niiden selitteet: 
```-T4``` Timing, säätää skannauksen ajoitusta. Vaihtoehtoina T0-5, 0 hitain ja 5 nopein. 

```-A``` Aggressive, komennossa käytetään agressiivista skannausta. Agressiivinen skannaus sisältää ```-o``` (OS Detection), ```-sC``` (Script Scanning), ```-sV``` (Version Detection) ja ```--traceroute``` (Network Path/Hop Discovery). (https://nmap.org/book/man-briefoptions.html)

```localhost``` Scannauksen kohde. 


Tulokset: 

```
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-31 03:58 EEST
mass_dns: warning: Unable to determine any DNS servers. Reverse DNS is disabled. Try using --system-dns or specify valid servers with --dns-servers
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000024s latency).
Other addresses for localhost (not scanned): ::1
All 1000 scanned ports on localhost (127.0.0.1) are in ignored states.
Not shown: 1000 closed tcp ports (reset)
Too many fingerprints match this host to give specific OS details
Network Distance: 0 hops

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.99 seconds
```

Skannaus ei siis löytänyt DNS palvelimia, 1000 skannattua porttia ja tcp porttia olivat ```Ignored``` -tilassa ja käyttöjärjestelmän tietoja ei löytynyt. 

## d) Asenna kaksi vapaavalintaista demonia ja skannaa uudelleen. Analysoi ja selitä erot.

Päätin asentaa apache2:n sekä openssh-server:n. Palautin verkkoyhteyden takaisin Kaliin demonien asennuksen ajaksi ja ajoin asennuskomennot.  

```sudo apt-get install -y apache2```

```sudo apt-get install -y openssh-server```

Tämän jälkeen käynnistin demonit: 

```sudo systemctl start apache2```

```sudo systemctl start ssh```

Normaalisti olisin myös asettanut nämä käynnistymään automaattisesti komennolla ```sudo systemctl enable apache2```, mutta asensin nämä tällä kertaa vain testausta varten. 

Lopuksi tarkastin vielä, että demonit olivat käynnissä: 

```systemctl status apache2```

```systemctl status ssh```

![d1](https://github.com/user-attachments/assets/a927d7f8-15f9-4bae-9c0e-eedc547aee60)

![d2](https://github.com/user-attachments/assets/f11fc96e-71fd-40d3-bc07-9196a5163488)

Lopuksi vielä ennen nmap:n uudelleenajoa, irrotin jälleen Kalin internetistä ja varmistin että yhteys internetiin on pois päältä. 

![d3](https://github.com/user-attachments/assets/07e341ac-32d7-4fa8-99c2-c873cb1abd71)

![d4](https://github.com/user-attachments/assets/093ccb8e-7eb7-4309-b91c-5286dfeef4a6)

```nmap -T4 -A localhost```

```
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-31 04:54 EEST
mass_dns: warning: Unable to determine any DNS servers. Reverse DNS is disabled. Try using --system-dns or specify valid servers with --dns-servers
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000019s latency).
Other addresses for localhost (not scanned): ::1
Not shown: 998 closed tcp ports (reset)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 9.9p2 Debian 1 (protocol 2.0)
| ssh-hostkey: 
|   256 dd:c6:0e:0b:fa:e8:76:a7:71:82:c3:d7:6e:60:24:43 (ECDSA)
|_  256 99:d0:62:9b:2a:a1:67:1c:09:cf:c6:01:42:f1:a9:b0 (ED25519)
80/tcp open  http    Apache httpd 2.4.63 ((Debian))
|_http-title: Apache2 Debian Default Page: It works
|_http-server-header: Apache/2.4.63 (Debian)
Device type: general purpose
Running: Linux 2.6.X|5.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32 cpe:/o:linux:linux_kernel:5 cpe:/o:linux:linux_kernel:6
OS details: Linux 2.6.32, Linux 5.0 - 6.2
Network Distance: 0 hops
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 8.03 seconds
```

![d5](https://github.com/user-attachments/assets/cd46e6cb-ac55-4bde-8190-61d66a16055b)

Tällä kertaa skannauksesta selvisi aiemmasta skannauksesta poiketen mm: ssh-hostkeyt, avoimia portteja (22/tcp ja 80/tcp) sekä käyttöjärjestelmän tiedot. 

## e) Asenna Metasploitable 2 virtuaalikoneeseen
## f) Tee koneiden välille virtuaaliverkko. Jos säätelet VirtualBoxista
Kali saa yhteyden Internettiin, mutta sen voi laittaa pois päältä
Kalin ja Metasploitablen välillä on host-only network, niin että porttiskannatessa ym. koneet on eristetty intenetistä, mutta ne saavat yhteyden toisiinsa
Vaihtoehtoisesti voit tehdä molempien koneiden asennuksen ja virtuaaliverkon vagrantilla. Silloin molemmat koneet samaan Vagrantfile:n.
## g) Etsi Metasploitable porttiskannaamalla (nmap -sn). Tarkista selaimella, että löysit oikean IP:n - Metasploitablen weppipalvelimen etusivulla lukee Metasploitable.
## h) Porttiskannaa Metasploitable huolellisesti ja kaikki portit (nmap -A -T4 -p-). Poimi 2-3 hyökkääjälle kiinnostavinta porttia. Analysoi ja selitä tulokset näiden porttien osalta.

## Ajankäyttö: 



## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

Spotify. s.a. Herrasmieshakkerit.    
https://open.spotify.com/show/0aIOiWdD5TCTHurBjCq08Q    
Tehtävä x.    

Hutchins, EM et al. 2011. Intelligence-Driven Computer Network Defense Informed by Analysis of Adversary Campaigns and Intrusion Kill Chains.    
https://lockheedmartin.com/content/dam/lockheed-martin/rms/documents/cyber/LM-White-Paper-Intel-Driven-Defense.pdf    
Tehtävä x.    

Santos, O et al. s.a. The Art of Hacking.    
https://learning.oreilly.com/videos/the-art-of/9780135767849/9780135767849-SPTT_04_00/    
Tehtävä x.    

Finlex. 2003. KKO 2003:36.    
https://finlex.fi/fi/oikeuskaytanto/korkein-oikeus/ennakkopaatokset/2003/36    
Tehtävä x.    

Nmap. s.a. Options Summary.    
https://nmap.org/book/man-briefoptions.html    
Tehtävä c. 
