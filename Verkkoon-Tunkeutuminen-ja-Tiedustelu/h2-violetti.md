# H2 Lempiväri: Violetti

## x) Pyramid of Pain & Diamond Model
- Pyramid of Pain kuvaa kuinka paljon vaikeampaa hyökkäys on toteuttaa kun hyökkääjältä estetään indikaattorien osoittamia hyökkäysväyliä.
- Pyramid of Painin tavoitteena on tehdä hyökkäyksestä niin hankalaa, että hyökkääjälle on mielekkäämpää lopettaa hyökkäys kuin yrittää löytää vaihtoehtoisia keinoja hyökätä.
- Diamond model on kyberhyökkäysten analysointiin ja tutkimiseen käytetty viitekehys, jonka avulla neljän pääalueen (hyökkääjän, uhrin, infrastruktuurin ja kyvykkyyksien/työkalujen) välisiä suhteita ja vuorovaikutuksia voidaan kartoittaa.
- Diamond model:n taustalla on ajatus siitä, että jokaista kyberhyökkäystä voidaan tutkailla mallin ja sen taustalla olevan perusväitteen (aksiooman) avulla. Ks. Diamond Model Axioms (https://www.activeresponse.org/diamond-model-axioms/)

## a) Apache log. Asenna Apache-weppipalvelin paikalliselle virtuaalikoneellesi. Surffaa palvelimellesi salaamattomalla HTTP-yhteydellä, http://localhost . Etsi omaa sivulataustasi vastaava lokirivi. Analysoi yksi tällainen lokirivi, eli selitä sen kaikki kohdat. 

Asensin ensin Apache2:n ja käynnistin Apache2:n. 

```sudo apt-get install apache2```

```sudo systemctl start apache2```

Tämän jälkeen menin selaimella osoitteeseen ```localhost```, jonka tämän jälkeen tarkastin lokin. 

```sudo tail -10 /var/log/apache2/access.log```

```
127.0.0.1 - - [06/Apr/2025:22:49:37 +0300] "GET / HTTP/1.1" 200 3380 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
127.0.0.1 - - [06/Apr/2025:22:49:37 +0300] "GET /icons/openlogo-75.png HTTP/1.1" 200 6040 "http://localhost/" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
127.0.0.1 - - [06/Apr/2025:22:49:37 +0300] "GET /favicon.ico HTTP/1.1" 404 487 "http://localhost/" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
```

![a1](https://github.com/user-attachments/assets/80245e3f-d01d-46f5-99db-8efffd2fca22)

```127.0.0.1```: Pyynnön lähettäjän IP-osoite. 

```-```: Clientin identiteetti, esim. käyttäjänimi. Ei ollut lähetetty tässä pyynnössä. 

```-```: Autentikoidun käyttäjän nimi, esim. käyttäjänimi. Pyynnössä ei autentikointitietoja. 

```[06/Apr/2025:22:49:37 +0300]```: Pyynnön ajankohta. 

```GET```: Pyynnön metodi. 

```/```: Pyydetty resurssi. 

```HTTP/1.1```: HTTP-protokollan versio. 

```200```: HTTP statuskoodi. 200 = Success. 

```3380```: Vastauksen koko tavuina. 

```"-"```: Lähde/referoija. Jos esimerkiksi ohjattu muualta. 

```"Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"```: User-Agent, eli selaimen ja käyttöjärjestelmän tiedot. 

## b) ja c) Nmapped & Skriptit. Porttiskannaa oma weppipalvelimesi käyttäen localhost-osoitetta ja 'nmap -A' päällä. Selitä tulokset. 

Aloitin irroittamalla koneen verkosta. 

![b1](https://github.com/user-attachments/assets/ed4ec28c-b65b-4e85-9727-cf4c4c2786eb)

Tämän jälkeen tein porttiskannauksen localhost -osoitteeseen ja porttiin 80. 

```sudo nmap -T4 -vv -A -p 80 localhost```

Komennon parametrit vielä avattuna: 

```-T4```: Timing, eli skannauksen nopeus/ajoitus. Vaihtoehtoina T0-T5. 0 on hitain ja 5 nopein. 

```-vv```: Verbosity, eli kuinka paljon tietoa ja yksityiskohtia ilmoitetaan. -v = normal, -vv = very verbose, -vvv = extremely verbose. 

```-A```: Agressiivinen skannaus. "Agressiivinen skannaus sisältää ```-o``` (OS Detection), ```-sC``` (Script Scanning), ```-sV``` (Version Detection) ja ```--traceroute``` (Network Path/Hop Discovery)". Lainattu omaa vastaustani toisen kurssin tehtävästä: ([h1-kybertappoketju](https://github.com/gianglex/Courses/blob/main/Tunkeutumistestaus/h1-kybertappoketju.md#c-porttiskannaa-1000-tavallisinta-tcp-porttia-omasta-koneestasi-nmap--t4--a-localhost-selit%C3%A4-komennon-paramterit-analysoi-ja-selit%C3%A4-tulokset)

```-p 80```: Portin valinta, tässä portti 80. 

```localhost```: Skannauksen kohde. Tässä localhost. 

Skannauksen tulokset: 

```
Starting Nmap 7.93 ( https://nmap.org ) at 2025-04-06 23:45 EEST
NSE: Loaded 155 scripts for scanning.
NSE: Script Pre-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
Warning: Hostname localhost resolves to 2 IPs. Using 127.0.0.1.
mass_dns: warning: Unable to determine any DNS servers. Reverse DNS is disabled. Try using --system-dns or specify valid servers with --dns-servers
Initiating SYN Stealth Scan at 23:45
Scanning localhost (127.0.0.1) [1 port]
Discovered open port 80/tcp on 127.0.0.1
Completed SYN Stealth Scan at 23:45, 0.03s elapsed (1 total ports)
Initiating Service scan at 23:45
Scanning 1 service on localhost (127.0.0.1)
Completed Service scan at 23:45, 6.03s elapsed (1 service on 1 host)
Initiating OS detection (try #1) against localhost (127.0.0.1)
NSE: Script scanning 127.0.0.1.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.03s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
Nmap scan report for localhost (127.0.0.1)
Host is up, received localhost-response (0.000030s latency).
Other addresses for localhost (not scanned): ::1
Scanned at 2025-04-06 23:45:15 EEST for 8s

PORT   STATE SERVICE REASON         VERSION
80/tcp open  http    syn-ack ttl 64 Apache httpd 2.4.62 ((Debian))
|_http-title: Apache2 Debian Default Page: It works
|_http-server-header: Apache/2.4.62 (Debian)
| http-methods: 
|_  Supported Methods: HEAD GET POST OPTIONS
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
TCP/IP fingerprint:
OS:SCAN(V=7.93%E=4%D=4/6%OT=80%CT=%CU=33232%PV=N%DS=0%DC=L%G=N%TM=67F2E7E3%
OS:P=x86_64-pc-linux-gnu)SEQ(SP=FF%GCD=1%ISR=10D%TI=Z%CI=Z%II=I%TS=A)OPS(O1
OS:=MFFD7ST11NW7%O2=MFFD7ST11NW7%O3=MFFD7NNT11NW7%O4=MFFD7ST11NW7%O5=MFFD7S
OS:T11NW7%O6=MFFD7ST11)WIN(W1=FFCB%W2=FFCB%W3=FFCB%W4=FFCB%W5=FFCB%W6=FFCB)
OS:ECN(R=Y%DF=Y%T=40%W=FFD7%O=MFFD7NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+
OS:%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)
OS:T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A
OS:=Z%F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%D
OS:F=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=4
OS:0%CD=S)

Uptime guess: 22.862 days (since Sat Mar 15 02:03:38 2025)
Network Distance: 0 hops
TCP Sequence Prediction: Difficulty=255 (Good luck!)
IP ID Sequence Generation: All zeros

NSE: Script Post-scanning.
NSE: Starting runlevel 1 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
NSE: Starting runlevel 2 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
NSE: Starting runlevel 3 (of 3) scan.
Initiating NSE at 23:45
Completed NSE at 23:45, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 8.33 seconds
           Raw packets sent: 23 (1.822KB) | Rcvd: 44 (3.068KB)
```

Alla omasta mielestäni muutamia tärkeimpiä kohtia: 

```NSE: Loaded 155 scripts for scanning.```: NSE (= nmap scripting engine) latasi 155 skriptiä skannausta varten. 

```Warning: Hostname localhost resolves to 2 IPs. Using 127.0.0.1.```: Localhost johti kahteen eri IP-osoitteeseen. Käytettiin osoitetta ```127.0.0.1```. 

```|_http-server-header: Apache/2.4.62 (Debian)```: HTTP-server-header:n perusteella kyseessä Apache versio 2.4.62. 

```|_  Supported Methods: HEAD GET POST OPTIONS```: Apachen tukemia metodeja ovat mm. HEAD, GET, POST ja OPTIONS. 

```OS details: Linux 2.6.32```: Käyttöjärjestelmänä Linux versio 2.6.32. 

## d) Jäljet lokissa. Etsi weppipalvelimen lokeista jäljet porttiskannauksesta (NSE eli Nmap Scripting Engine -skripteistä skannauksessa). Löydätkö sanan "nmap" isolla tai pienellä? Selitä osumat. Millaisilla hauilla tai säännöillä voisit tunnistaa porttiskannauksen jostain muusta lokista, jos se on niin laaja, että et pysty lukemaan itse kaikkia rivejä?

Käytin ```cat``` -komentoa saadakseni koko lokin, sillä arvelin ettei siellä voi olla niin paljon tavaraa tällä hetkellä. 

```sudo cat /var/log/apache2/access.log```

```
127.0.0.1 - - [06/Apr/2025:22:49:37 +0300] "GET / HTTP/1.1" 200 3380 "-" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
127.0.0.1 - - [06/Apr/2025:22:49:37 +0300] "GET /icons/openlogo-75.png HTTP/1.1" 200 6040 "http://localhost/" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
127.0.0.1 - - [06/Apr/2025:22:49:37 +0300] "GET /favicon.ico HTTP/1.1" 404 487 "http://localhost/" "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
127.0.0.1 - - [06/Apr/2025:23:45:21 +0300] "GET / HTTP/1.0" 200 10975 "-" "-"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET /nmaplowercheck1743972323 HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET /robots.txt HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET / HTTP/1.1" 200 10975 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "PROPFIND / HTTP/1.1" 405 519 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET /.git/HEAD HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "POST /sdk HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "PROPFIND / HTTP/1.1" 405 519 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "POST / HTTP/1.1" 200 10975 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET / HTTP/1.0" 200 10975 "-" "-"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "JRHH / HTTP/1.1" 501 494 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "PROPFIND / HTTP/1.1" 405 519 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET /HNAP1 HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET /evox/about HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET / HTTP/1.1" 200 10975 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET /favicon.ico HTTP/1.1" 404 451 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "OPTIONS / HTTP/1.1" 200 181 "-" "Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET / HTTP/1.0" 200 10975 "-" "-"
127.0.0.1 - - [06/Apr/2025:23:45:23 +0300] "GET / HTTP/1.1" 200 10956 "-" "-"
```

Mikäli loki olisi niin laaja, ettei sitä voisi lukea kokonaisuudessaan, voisi käyttää grep komentoa hyödyksi. Esimerkiksi 

```sudo cat /var/log/apache2/access.log | grep nmap```


## e) Wire sharking. Sieppaa verkkoliikenne porttiskannatessa Wiresharkilla. Huomaa, että localhost käyttää "Loopback adapter" eli "lo". Tallenna pcap. Etsi kohdat, joilla on sana "nmap" ja kommentoi niitä. Jokaisen paketin jokaista kohtaa ei tarvitse analysoida, yleisempi tarkastelu riittää.

Avasin toiseen työpöytään Wiresharkin terminaalin kautta käyttämällä komentoa ```wireshark``` ja valitsin tallennuksen kohteeksi ```Loopback: lo``` -adapterin, minkä jälkeen liikenteen sieppaus alkoi.  

```sudo nmap -T4 -vv -A -p 80 localhost```

Kun skannaus oli ohi, palasin takaisin Wiresharkkiin ja lopetin sieppauksen. 

Hakeakseni kohtia, joissa on sama ```nmap``` laitoin sen Wiresharkin display filteriksi ```frame contains "nmap"```

![e1](https://github.com/user-attachments/assets/aa387f4b-fd77-49c3-b5e8-5d56ef5fdcab)

Tarkastelin hetken aikaa frameja Wiresharkissa ja huomasin, että pääosin ```nmap``` oli frameissa User Agentin sisällä. 

![e2](https://github.com/user-attachments/assets/ad048ac8-b59a-4b9f-a16d-18e6f9a63bbc)

Halusin vielä saada hieman selkeämmän ja helposti luettavamman kokonaiskuvan, joten tallensin sieppauksen (nimellä nmap.pcapng) ja asensin vielä tsharkin (Wiresharkin CLI-version).  

```sudo apt-get install tshark```

```tshark -r nmap.pcapng -Y 'frame contains "nmap"'```

![e3](https://github.com/user-attachments/assets/e16542fe-8752-4b1d-8107-6a1305448643)

```
$ tshark -r nmap.pcapng -Y 'frame contains "nmap"'
   93 7.567136092    127.0.0.1 → 127.0.0.1    HTTP 222 GET /.git/HEAD HTTP/1.1 
   95 7.567185295    127.0.0.1 → 127.0.0.1    HTTP 237 GET /nmaplowercheck1743975795 HTTP/1.1 
   97 7.567199441    127.0.0.1 → 127.0.0.1    HTTP 213 GET / HTTP/1.1 
   99 7.567292501    127.0.0.1 → 127.0.0.1    HTTP 217 OPTIONS / HTTP/1.1 
  101 7.567320925    127.0.0.1 → 127.0.0.1    HTTP 217 OPTIONS / HTTP/1.1 
  109 7.567364276    127.0.0.1 → 127.0.0.1    HTTP 228 PROPFIND / HTTP/1.1 
  111 7.567381177    127.0.0.1 → 127.0.0.1    HTTP 679 POST /sdk HTTP/1.1 
  115 7.567397248    127.0.0.1 → 127.0.0.1    HTTP 275 OPTIONS / HTTP/1.1 
  121 7.567435609    127.0.0.1 → 127.0.0.1    HTTP 228 PROPFIND / HTTP/1.1 
  123 7.567457961    127.0.0.1 → 127.0.0.1    HTTP 371 POST / HTTP/1.1  (application/x-www-form-urlencoded)
  127 7.567476757    127.0.0.1 → 127.0.0.1    HTTP 223 GET /robots.txt HTTP/1.1 
  197 7.572287445    127.0.0.1 → 127.0.0.1    HTTP 223 GET /evox/about HTTP/1.1 
  199 7.572339943    127.0.0.1 → 127.0.0.1    TCP 214 50504 → 80 [PSH, ACK] Seq=1 Ack=1 Win=65536 Len=148 TSval=1978778217 TSecr=1978778215
  201 7.572357135    127.0.0.1 → 127.0.0.1    HTTP 247 PROPFIND / HTTP/1.1 
  203 7.572368507    127.0.0.1 → 127.0.0.1    HTTP 274 OPTIONS / HTTP/1.1 
  217 7.572670833    127.0.0.1 → 127.0.0.1    HTTP 218 GET /HNAP1 HTTP/1.1 
  219 7.572703945    127.0.0.1 → 127.0.0.1    HTTP 224 GET /favicon.ico HTTP/1.1 
  245 7.573815037    127.0.0.1 → 127.0.0.1    HTTP 275 OPTIONS / HTTP/1.1 
  247 7.573841897    127.0.0.1 → 127.0.0.1    HTTP 213 GET / HTTP/1.1 
  262 7.575189858    127.0.0.1 → 127.0.0.1    HTTP 274 OPTIONS / HTTP/1.1 
  272 7.575748975    127.0.0.1 → 127.0.0.1    HTTP 277 OPTIONS / HTTP/1.1 
  282 7.576205425    127.0.0.1 → 127.0.0.1    HTTP 276 OPTIONS / HTTP/1.1 
  292 7.576695252    127.0.0.1 → 127.0.0.1    HTTP 278 OPTIONS / HTTP/1.1 
  302 7.577178758    127.0.0.1 → 127.0.0.1    HTTP 278 OPTIONS / HTTP/1.1 
  312 7.577573217    127.0.0.1 → 127.0.0.1    HTTP 276 OPTIONS / HTTP/1.1 
```

Tästä näkeekin selkeämmin jo sen, että nmap mm. kokeilee HTTP:n erilaisia metodeja (GET, OPTIONS, PROPFIND, POST, GET). 

## f) Net grep. Sieppaa verkkoliikenne 'ngrep' komennolla ja näytä kohdat, joissa on sana "nmap".

Aloitin ensin sieppauksen komennolla 

```sudo ngrep -d lo -i nmap```

Tämän jälkeen siirryin toiseen terminaaliin ajamaan porttiskannauksen. 

```sudo nmap -T4 -vv -A -p 80 localhost```

Porttiskannauksen alettua ngreppiin alkoi ilmestyä siepattua liikennettä: 

```
$ sudo ngrep -d lo -i nmap
interface: lo (127.0.0.0/255.0.0.0)
filter: ((ip || ip6) || (vlan && (ip || ip6)))
match (JIT): nmap
#############################################################################################
T 127.0.0.1:34592 -> 127.0.0.1:80 [AP] #93
  POST / HTTP/1.1..Connection: close..Content-Length: 88..Host: localhost..Content-Type: application/x-www-form-urlencoded..User-Agent: Mozi
  lla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.html)....<methodCall> <methodName>system.listMethods</methodName> <p
  arams></params> </methodCall>                                                                                                             
##
T 127.0.0.1:34604 -> 127.0.0.1:80 [AP] #95
  GET / HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.
  html)....                                                                                                                                 
####
T 127.0.0.1:34616 -> 127.0.0.1:80 [AP] #99
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: HEAD..User-Agent: Mozilla/5.0 (compatible; Nmap Scr
  ipting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                   
##
T 127.0.0.1:34620 -> 127.0.0.1:80 [AP] #101
  GET /.git/HEAD HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/
  book/nse.html)....                                                                                                                        
##
T 127.0.0.1:34630 -> 127.0.0.1:80 [AP] #103
  GET /nmaplowercheck1743977539 HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; ht
  tps://nmap.org/book/nse.html)....                                                                                                         
##
T 127.0.0.1:34646 -> 127.0.0.1:80 [AP] #105
  PROPFIND / HTTP/1.1..Connection: close..Depth: 0..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nma
  p.org/book/nse.html)....                                                                                                                  
##
T 127.0.0.1:34652 -> 127.0.0.1:80 [AP] #107
  POST /sdk HTTP/1.1..Connection: close..Content-Length: 441..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; h
  ttps://nmap.org/book/nse.html)....<soap:Envelope xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-
  instance" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Header><operationID>00000001-00000001</operationID></soap:Header><s
  oap:Body><RetrieveServiceContent xmlns="urn:internalvim25"><_this xsi:type="ManagedObjectReference" type="ServiceInstance">ServiceInstance
  </_this></RetrieveServiceContent></soap:Body></soap:Envelope>                                                                             
##
T 127.0.0.1:34656 -> 127.0.0.1:80 [AP] #109
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/
  nse.html)....                                                                                                                             
##
T 127.0.0.1:34668 -> 127.0.0.1:80 [AP] #111
  PROPFIND / HTTP/1.1..Connection: close..Depth: 0..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nma
  p.org/book/nse.html)....                                                                                                                  
########
T 127.0.0.1:34670 -> 127.0.0.1:80 [AP] #119
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/
  nse.html)....                                                                                                                             
#########
T 127.0.0.1:34684 -> 127.0.0.1:80 [AP] #128
  GET /robots.txt HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org
  /book/nse.html)....                                                                                                                       
#####################################################################
T 127.0.0.1:34700 -> 127.0.0.1:80 [AP] #197
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: GET..User-Agent: Mozilla/5.0 (compatible; Nmap Scri
  pting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                    
##
T 127.0.0.1:34714 -> 127.0.0.1:80 [AP] #199
  GET /HNAP1 HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book
  /nse.html)....                                                                                                                            
##
T 127.0.0.1:34718 -> 127.0.0.1:80 [AP] #201
  HPPL / HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse
  .html)....                                                                                                                                
##
T 127.0.0.1:34728 -> 127.0.0.1:80 [AP] #203
  PROPFIND / HTTP/1.1..Connection: close..Content-Length: 0..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; ht
  tps://nmap.org/book/nse.html)..Depth: 1....                                                                                               
#######
T 127.0.0.1:34738 -> 127.0.0.1:80 [AP] #210
  GET / HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org/book/nse.
  html)....                                                                                                                                 
########
T 127.0.0.1:34744 -> 127.0.0.1:80 [AP] #218
  GET /evox/about HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.org
  /book/nse.html)....                                                                                                                       
########################
T 127.0.0.1:34750 -> 127.0.0.1:80 [AP] #242
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: POST..User-Agent: Mozilla/5.0 (compatible; Nmap Scr
  ipting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                   
#############
T 127.0.0.1:34756 -> 127.0.0.1:80 [AP] #255
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: PUT..User-Agent: Mozilla/5.0 (compatible; Nmap Scri
  pting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                    
##
T 127.0.0.1:34758 -> 127.0.0.1:80 [AP] #257
  GET /favicon.ico HTTP/1.1..Connection: close..Host: localhost..User-Agent: Mozilla/5.0 (compatible; Nmap Scripting Engine; https://nmap.or
  g/book/nse.html)....                                                                                                                      
###############
T 127.0.0.1:34766 -> 127.0.0.1:80 [AP] #272
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: DELETE..User-Agent: Mozilla/5.0 (compatible; Nmap S
  cripting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                 
##########
T 127.0.0.1:34772 -> 127.0.0.1:80 [AP] #282
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: TRACE..User-Agent: Mozilla/5.0 (compatible; Nmap Sc
  ripting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                  
##########
T 127.0.0.1:34782 -> 127.0.0.1:80 [AP] #292
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: OPTIONS..User-Agent: Mozilla/5.0 (compatible; Nmap 
  Scripting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                
##########
T 127.0.0.1:34792 -> 127.0.0.1:80 [AP] #302
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: CONNECT..User-Agent: Mozilla/5.0 (compatible; Nmap 
  Scripting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                
##########
T 127.0.0.1:34794 -> 127.0.0.1:80 [AP] #312
  OPTIONS / HTTP/1.1..Connection: close..Host: localhost..Access-Control-Request-Method: PATCH..User-Agent: Mozilla/5.0 (compatible; Nmap Sc
  ripting Engine; https://nmap.org/book/nse.html)..Origin: example.com....                                                                  
##########################
```

## g) Agentti. Vaihda nmap:n user-agent niin, että se näyttää tavalliselta weppiselaimelta.

Päätin vaihtaa user-agenttini googlesta löytämääni tyypilliseen user-agent:iin ```Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.10 Safari/605.1.1```. 

Aloitin user-agentin muokkaamisen avaamalla tiedoston ```http.lua```

```sudoedit /usr/share/nmap/nselib/http.lua```

Tämän jälkeen ensin kopioin olemassaolevan rivin ja lisäsin sen eteen ```--```, jotta voin palauttaa myöhemmin halutessani oletusasetukset. Sen jälkeen lisäsin haluamani User-agentin uudeksi oletus user-agentiksi. 

![g1](https://github.com/user-attachments/assets/03b6394e-a7a9-4e38-893e-4763dc19093a)

## h) Pienemmät jäljet. Porttiskannaa weppipalvelimesi uudelleen localhost-osoitteella. Tarkastele sekä Apachen lokia että siepattua verkkoliikennettä. Mikä on muuttunut, kun vaihdoit user-agent:n? Löytyykö lokista edelleen tekstijono "nmap"?

Tarkastellessani siepattua verkkoliikennettä ngrepistä, tuli enää yksi nmap:stä mainitseva sieppaus

```
T 127.0.0.1:45788 -> 127.0.0.1:80 [AP] #103
  GET /nmaplowercheck1743979083 HTTP/1.1..Connection: close..User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.1
  5 (KHTML, like Gecko) Version/17.10 Safari/605.1.1..Host: localhost....      
```

Myöskin apache2:n lokeissa ainoa teoreempi ```nmap``` on sama GET pyyntö. 

```sudo cat /var/log/apache2/access.log | grep -i nmap```

```
127.0.0.1 - - [07/Apr/2025:01:38:03 +0300] "GET /nmaplowercheck1743979083 HTTP/1.1" 404 451 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.10 Safari/605.1.1"
```

## i) Hieman vaikeampi: LoWeR ChEcK. Poista skritiskannauksesta viimeinenkin "nmap" -teksti. Etsi löytämääsi tekstiä /usr/share/nmap -hakemistosta ja korvaa se toisella. Tee porttiskannaus ja tarkista, että "nmap" ei näy isolla eikä pienellä kirjoitettuna Apachen lokissa eikä siepatussa verkkoliikenteessä. (Tässä tehtävässä voit muokata suoraan lua-skriptejä /usr/share/nmap alta, 'sudoedit'. Muokatun version paketoiminen siis rajataan ulos tehtävästä.)

Häivyttääkseni viimeisenkin ```nmap``` -tekstin, menin polkuun ```/usr/share/nmap``` ja etsin tiedostoa, jossa voisi olla maininta ```nmaplowercheck```

```cd /usr/share/nmap```

```grep -ir "nmaplowercheck"```

![i1](https://github.com/user-attachments/assets/0542de2a-8752-42d4-8ef5-0bf38a1aa1d6)

Haku tuotti tulosta: ```nselib/http.lua```, eli kansiossa ```nselib``` on tiedosto ```http.lua```, jonka sisällä on viimeinen maininta ```nmap```:sta

```sudoedit nselib/http.lua```

Tiedostosta löytyi ```nmap``` maininnat vielä, joten muokkasin niistä maininnat pois. 

![i2](https://github.com/user-attachments/assets/2cf68179-bb7b-4608-9efc-abaa5f2919fd)

![i3](https://github.com/user-attachments/assets/206c3a92-3006-4a71-8194-d36edcb38977)

Tämän jälkeen käynnistin uudelleen porttiskannauksen. 

```sudo nmap -T4 -vv -A -p 80 localhost```

Tarkastelin lopuksi uudelleen vielä ngrep:n sekä apache2:n lokit, joista ei kummastakaan enää löytynyt uusia ilmoituksia. 

![i4](https://github.com/user-attachments/assets/4fa61273-47d5-44d0-b1d2-49f2530e406b)

Putkitin Apache2:n lokien tarkastelun loppuun ```| tail -1```, sillä jos onnistuin niin uusimmassa porttiskannauksesta ei pitäisi olla jäänyt jälkiä ja siellä näkyvä loki on edellisistä skannauksista. 

```sudo cat /var/log/apache2/access.log | grep nmap | tail -1```

![i5](https://github.com/user-attachments/assets/738f9264-7887-40d7-a169-4930c6f64d07)

Lokista näkyvä merkintä oli jo tullut aiemmista skannauksista, joten olin onnistunut piilottamaan viimeiseinkin ```nmap``` tekstin. 

## Ajankäyttö
- Tiivistelmiin n. 1h.
- Tehtäviin n. 3h.
- Raportointiin ja dokumentointiin n. 2h. 

## Lähteet
Karvinen, T. 2025. Verkkoon tunkeutuminen ja tiedustelu.    
https://terokarvinen.com/verkkoon-tunkeutuminen-ja-tiedustelu/    
Tehtävänanto.    

Bianco, D.J. 2014. Pyramid of Pain.    
https://detect-respond.blogspot.com/2013/03/the-pyramid-of-pain.html    
Tehtävä x.    

Caltagirone et al. 2013. The Diamond Model of Intrusion Analysis.    
https://www.threatintel.academy/wp-content/uploads/2020/07/diamond-model.pdf    
Tehtävä x.    

Goss, A. 2024. The Diamond Model: Simple Intelligence-Driven Intrusion Analysis.    
https://kravensecurity.com/diamond-model-analysis/    
Tehtävä x.    

Caltagirone, S. 2016. The Laws of Cyber Threat: Diamond Model Axioms.    
https://www.activeresponse.org/diamond-model-axioms/    
Tehtävä x.   

Le, G. 2025. Kybertappoketju.    
https://github.com/gianglex/Courses/blob/main/Tunkeutumistestaus/h1-kybertappoketju.md    
Tehtävä b.    

Nmap. s.a. Detect Nmap Scans.    
https://nmap.org/book/nmap-defenses-detection.html    
Tehtävä d.    
