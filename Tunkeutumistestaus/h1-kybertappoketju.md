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

 
## a) Kali

![a1](https://github.com/user-attachments/assets/687940f2-a9fd-4ce8-b069-253a62c28c6e)

## b) Irrota Kali-virtuaalikone verkosta

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

Aloitin lataamalla Metasploitable 2 virtuaalikoneen (osoitteesta: https://www.vulnhub.com/entry/metasploitable-2,29/). 

Tämän jälkeen purin metasploitable-linux-2.0.0.zip tiedoston omaan kansioonsa (C:\...\Download\Metasploitable2-Linux\). 

Tämän jälkeen VirtualBoxin valikosta valitsin ```New``` -vaihtoehdon. 

Alla vielä pääasialliset tiedot asennuksesta: 

```
- Name and Operating System
   - Name: Metasploitable
   - Folder: C:\...\VirtualBox VMs
   - Type: Linux
   - Subtype: Other Linux
   - Version: Other Linux (64-bit)
- Hardware
   - Base memory: 512 MB
   - Processors: 1 CPU
- Hard Disk
   - Use an Existing Virtual Hard Disk File
   - Metasploitable.vmdk ((C:\...\Download\Metasploitable2-Linux\Metasploitable.vmdk)
```


## f) Host-only virtuaaliverkko VirtualBoxissa

Menin ylävalikosta File -> Tools -> Network Manager

![e1](https://github.com/user-attachments/assets/ed488198-bf34-4b29-9126-cf949e2a4225)

Kävin tarkastamassa asetuksista jo olemassa olevan Host-Only verkkoadapterini. 

![e2](https://github.com/user-attachments/assets/c1f91b17-5393-47e5-96ab-9c3691b3d658)

Tämän jälkeen lisäsin Kalille toisen verkkoadapterin, johon liitin Host-only adapterin. 

![e3](https://github.com/user-attachments/assets/3bb08637-9e4a-49d2-963d-65b0ec2977bd)

Metasploitille muutin sen olemassaolevan Adapter 1:n Host-only adapteriin, sillä en tahdo päästä Metasploitilla internettiin. 

![e4](https://github.com/user-attachments/assets/f5dc1ebb-f6f1-4f3f-a7ae-64b773b36cc3)

Käynnistin vielä Metasploitable2:n katsoakseni, että asennus onnistui. 

![e5](https://github.com/user-attachments/assets/4865a38e-8fa7-45b2-85d9-ca6ef8809dae)

Ja sehän toimi odotetusti ja pääsin kirjautumaan sisään (msfadmin:msfadmin)

pingeillä, että toimivatko verkkoyhteydet halutusti: Kali pääsee tarvittaessa internettiin sekä molemmat koneet saavat yhteyden toisiinsa. 

Kali: ```ping 1.1.1.1```

Kali: ```ping 8.8.8.8```

![e6](https://github.com/user-attachments/assets/b1ba810f-6e70-4406-ae31-ae942422740b)

Internet-yhteys toimi odotetusti ja tarkastin vielä verkkoadapterien tilan: Kalista löytyy AMD 79C97x (Host-only) sekä Intel 82540EM (internet) adapterit. 

![e7](https://github.com/user-attachments/assets/38eaf637-8eca-44f9-9ccd-bfce95dba67d)

Metasploitable2: ```ping 1.1.1.1```

Metasploitable2: ```ping 8.8.8.8```

![e8](https://github.com/user-attachments/assets/b126284b-03ab-49b9-9f19-4bb652b5d9a9)

Kuten halusinkin, Metasploit ei saa yhteyttä internettiin. 

## g) Etsi Metasploitable porttiskannaamalla (nmap -sn)

Vaihdoin Kalin adapterin AMD 79C97x:ään (Host-only) ja testasin sen jälkeen jälleen ping komennolla internet-yhteyttä. 

Kali: ```ping 1.1.1.1```

![g1](https://github.com/user-attachments/assets/b1ef0930-2b84-401d-bb13-11ea646755b1)

Tämän jälkeen ajoin komennon, kohteeksi valikoitui ```192.168.56.0```, sillä olin asettanut aiemmin Host-only verkon osoitteeksi ```192.168.56.1```.  

![g2](https://github.com/user-attachments/assets/609c108e-e736-4c99-8294-bfb64c32a541)

Kali: ```nmap -sn 192.168.56.0/24```

```
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-31 06:30 EEST
mass_dns: warning: Unable to determine any DNS servers. Reverse DNS is disabled. Try using --system-dns or specify valid servers with --dns-servers
Nmap scan report for 192.168.56.1
Host is up (0.00017s latency).
MAC Address: 0A:00:27:00:00:28 (Unknown)
Nmap scan report for 192.168.56.100
Host is up (0.00011s latency).
MAC Address: 08:00:27:7F:A4:8C (PCS Systemtechnik/Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.56.102
Host is up (0.00015s latency).
MAC Address: 08:00:27:26:45:0B (PCS Systemtechnik/Oracle VirtualBox virtual NIC)
Nmap scan report for 192.168.56.101
Host is up.
Nmap done: 256 IP addresses (4 hosts up) scanned in 1.86 seconds
```

Skannauksella näyttäisi löytyvan osoitteet 192.168.56.1, 192.168.56.100, 192.168.56.101 ja 192.168.56.102. 

Kävin osoitteet läpi vielä ```curl``` -komennolla ja ```192.168.56.102``` näyttäisi olleen Metasploitablen oikea osoite. 

```curl 192.168.56.102```

![g3](https://github.com/user-attachments/assets/664ae313-9228-4524-8114-d1d87722b84f)

## h) Porttiskannaa Metasploitable huolellisesti ja kaikki portit (nmap -A -T4 -p-). Poimi 2-3 hyökkääjälle kiinnostavinta porttia. Analysoi ja selitä tulokset näiden porttien osalta.

```nmap -A -T4 -p- 192.168.56.102```

```
Starting Nmap 7.95 ( https://nmap.org ) at 2025-03-31 06:43 EEST
mass_dns: warning: Unable to determine any DNS servers. Reverse DNS is disabled. Try using --system-dns or specify valid servers with --dns-servers
Stats: 0:00:43 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
Service scan Timing: About 96.67% done; ETC: 06:44 (0:00:01 remaining)
Nmap scan report for 192.168.56.102
Host is up (0.00018s latency).
Not shown: 65505 closed tcp ports (reset)
PORT      STATE SERVICE     VERSION
21/tcp    open  ftp         vsftpd 2.3.4
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to 192.168.56.101
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      vsFTPd 2.3.4 - secure, fast, stable
|_End of status
|_ftp-anon: Anonymous FTP login allowed (FTP code 230)
22/tcp    open  ssh         OpenSSH 4.7p1 Debian 8ubuntu1 (protocol 2.0)
| ssh-hostkey: 
|   1024 60:0f:cf:e1:c0:5f:6a:74:d6:90:24:fa:c4:d5:6c:cd (DSA)
|_  2048 56:56:24:0f:21:1d:de:a7:2b:ae:61:b1:24:3d:e8:f3 (RSA)
23/tcp    open  telnet      Linux telnetd
25/tcp    open  smtp        Postfix smtpd
|_ssl-date: 2025-03-31T03:46:15+00:00; -1s from scanner time.
|_smtp-commands: metasploitable.localdomain, PIPELINING, SIZE 10240000, VRFY, ETRN, STARTTLS, ENHANCEDSTATUSCODES, 8BITMIME, DSN
| ssl-cert: Subject: commonName=ubuntu804-base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is no such thing outside US/countryName=XX
| Not valid before: 2010-03-17T14:07:45
|_Not valid after:  2010-04-16T14:07:45
| sslv2: 
|   SSLv2 supported
|   ciphers: 
|     SSL2_DES_192_EDE3_CBC_WITH_MD5
|     SSL2_RC4_128_WITH_MD5
|     SSL2_RC4_128_EXPORT40_WITH_MD5
|     SSL2_RC2_128_CBC_EXPORT40_WITH_MD5
|     SSL2_DES_64_CBC_WITH_MD5
|_    SSL2_RC2_128_CBC_WITH_MD5
53/tcp    open  domain      ISC BIND 9.4.2
| dns-nsid: 
|_  bind.version: 9.4.2
80/tcp    open  http        Apache httpd 2.2.8 ((Ubuntu) DAV/2)
|_http-server-header: Apache/2.2.8 (Ubuntu) DAV/2
|_http-title: Metasploitable2 - Linux
111/tcp   open  rpcbind     2 (RPC #100000)
| rpcinfo: 
|   program version    port/proto  service
|   100000  2            111/tcp   rpcbind
|   100000  2            111/udp   rpcbind
|   100003  2,3,4       2049/tcp   nfs
|   100003  2,3,4       2049/udp   nfs
|   100005  1,2,3      42844/tcp   mountd
|   100005  1,2,3      52133/udp   mountd
|   100021  1,3,4      36492/tcp   nlockmgr
|   100021  1,3,4      40192/udp   nlockmgr
|   100024  1          33515/tcp   status
|_  100024  1          42262/udp   status
139/tcp   open  netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp   open  netbios-ssn Samba smbd 3.0.20-Debian (workgroup: WORKGROUP)
512/tcp   open  exec        netkit-rsh rexecd
513/tcp   open  login
514/tcp   open  shell       Netkit rshd
1099/tcp  open  java-rmi    GNU Classpath grmiregistry
1524/tcp  open  bindshell   Metasploitable root shell
2049/tcp  open  nfs         2-4 (RPC #100003)
2121/tcp  open  ftp         ProFTPD 1.3.1
3306/tcp  open  mysql       MySQL 5.0.51a-3ubuntu5
| mysql-info: 
|   Protocol: 10
|   Version: 5.0.51a-3ubuntu5
|   Thread ID: 8
|   Capabilities flags: 43564
|   Some Capabilities: Support41Auth, SupportsCompression, ConnectWithDatabase, SwitchToSSLAfterHandshake, Speaks41ProtocolNew, SupportsTransactions, LongColumnFlag
|   Status: Autocommit
|_  Salt: H1[X)a/b##(=;Rg0YO`v
3632/tcp  open  distccd     distccd v1 ((GNU) 4.2.4 (Ubuntu 4.2.4-1ubuntu4))
5432/tcp  open  postgresql  PostgreSQL DB 8.3.0 - 8.3.7
|_ssl-date: 2025-03-31T03:46:15+00:00; -1s from scanner time.
| ssl-cert: Subject: commonName=ubuntu804-base.localdomain/organizationName=OCOSA/stateOrProvinceName=There is no such thing outside US/countryName=XX
| Not valid before: 2010-03-17T14:07:45
|_Not valid after:  2010-04-16T14:07:45
5900/tcp  open  vnc         VNC (protocol 3.3)
| vnc-info: 
|   Protocol version: 3.3
|   Security types: 
|_    VNC Authentication (2)
6000/tcp  open  X11         (access denied)
6667/tcp  open  irc         UnrealIRCd
6697/tcp  open  irc         UnrealIRCd
8009/tcp  open  ajp13       Apache Jserv (Protocol v1.3)
|_ajp-methods: Failed to get a valid response for the OPTION request
8180/tcp  open  http        Apache Tomcat/Coyote JSP engine 1.1
|_http-favicon: Apache Tomcat
|_http-server-header: Apache-Coyote/1.1
|_http-title: Apache Tomcat/5.5
8787/tcp  open  drb         Ruby DRb RMI (Ruby 1.8; path /usr/lib/ruby/1.8/drb)
33027/tcp open  java-rmi    GNU Classpath grmiregistry
33515/tcp open  status      1 (RPC #100024)
36492/tcp open  nlockmgr    1-4 (RPC #100021)
42844/tcp open  mountd      1-3 (RPC #100005)
MAC Address: 08:00:27:26:45:0B (PCS Systemtechnik/Oracle VirtualBox virtual NIC)
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6
OS details: Linux 2.6.9 - 2.6.33
Network Distance: 1 hop
Service Info: Hosts:  metasploitable.localdomain, irc.Metasploitable.LAN; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
| smb-security-mode: 
|   account_used: guest
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
| smb-os-discovery: 
|   OS: Unix (Samba 3.0.20-Debian)
|   Computer name: metasploitable
|   NetBIOS computer name: 
|   Domain name: localdomain
|   FQDN: metasploitable.localdomain
|_  System time: 2025-03-30T23:46:06-04:00
|_nbstat: NetBIOS name: METASPLOITABLE, NetBIOS user: <unknown>, NetBIOS MAC: <unknown> (unknown)
|_smb2-time: Protocol negotiation failed (SMB2)
|_clock-skew: mean: 59m58s, deviation: 2h00m00s, median: -1s

TRACEROUTE
HOP RTT     ADDRESS
1   0.18 ms 192.168.56.102

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 139.61 seconds
```

Valitsin nämä portit hyökkääjälle mielenkiintoisiksi: ```21/tcp ftp```, ```23/tcp telnet``` ja ```3306/tcp mysql```. 

```
21/tcp    open  ftp         vsftpd 2.3.4
| ftp-syst: 
|   STAT: 
| FTP server status:
|      Connected to 192.168.56.101
|      Logged in as ftp
|      TYPE: ASCII
|      No session bandwidth limit
|      Session timeout in seconds is 300
|      Control connection is plain text
|      Data connections will be plain text
|      vsFTPd 2.3.4 - secure, fast, stable
|_End of status
|_ftp-anon: Anonymous FTP login allowed (FTP code 230)
```

FTP pisti silmään varsinkin ```Anonymous FTP login allowed``` takia. 
Yhteydet toimivat myös selkokielisinä (plaintext) eli niitä on helppo kaapata ja lukea. 
Nopealla haulla ohjelman ```vsftpd 2.3.4``` versiossa on Backdoor Command Execution -exploit. 

```23/tcp    open  telnet      Linux telnetd```

Telnet pisti silmään, sillä on jo pidempään pidetty tietoturvattomana vaihtoehtoja. Mm. Herrasmieshakkeri-podcastissä puhuttiin telnetistä "myrkkynä". 

```
3306/tcp  open  mysql       MySQL 5.0.51a-3ubuntu5
| mysql-info: 
|   Protocol: 10
|   Version: 5.0.51a-3ubuntu5
|   Thread ID: 8
|   Capabilities flags: 43564
|   Some Capabilities: Support41Auth, SupportsCompression, ConnectWithDatabase, SwitchToSSLAfterHandshake, Speaks41ProtocolNew, SupportsTransactions, LongColumnFlag
|   Status: Autocommit
|_  Salt: H1[X)a/b##(=;Rg0YO`v
```

MySQL vaikutti kiinnostavalta, sillä SQL-injektio on yksi yleisimmistä tietoturvariskeistä. Esim. OWASP Top10 nimesi injektiot kolmanneksi vuonna 2021 ja ensimmäiseksi vuonna 2017. 
MySQL 5.0.51a-3 haulla löytyi mm. priviledge escalation exploit. 


## Ajankäyttö: 

- Materiaalien lukemiseen, kuuntelemiseen ja tiivistämiseen n. 2h. 
- Tehtäviin n. 2h. 
- Raportointiin ja dokumentointiin n. 2h. 

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

VulnHub. s.a. Metasploitable 2.    
https://www.vulnhub.com/entry/metasploitable-2,29/    
Tehtävä e.    

Rapid7. s.a. VSFTPD v2.3.4 Backdoor Command Execution.    
https://www.rapid7.com/db/modules/exploit/unix/ftp/vsftpd_234_backdoor/    
Tehtävä h.    

OWASP. s.a. OWASP Top10.    
https://owasp.org/Top10/    
Tehtävä h.    

Exploit Database. s.a. MySQL (Linux) - Database Privilege Escalation.    
https://www.exploit-db.com/exploits/23077    
Tehtävä h.    
