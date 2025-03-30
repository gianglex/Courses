# H1 - Kybertappoketju

x) Lue/katso/kuuntele ja tiivistä. (Tässä x-alakohdassa ei tarvitse tehdä testejä tietokoneella, vain lukeminen tai kuunteleminen ja tiivistelmä riittää. Tiivistämiseen riittää muutama ranskalainen viiva.)
Herrasmieshakkerit (RSS) tai Darknet Diaries (RSS) , yksi vapaavalintainen jakso jommasta kummasta. Voi kuunnella myös lenkillä, pyykiä viikatessa tms. Siisti koti / hyvä kunto kaupan päälle.
Hutchins et al 2011: Intelligence-Driven Computer Network Defense Informed by Analysis of Adversary Campaigns and Intrusion Kill Chains, chapters Abstract, 3.2 Intrusion Kill Chain.
€ Santos et al: The Art of Hacking (Video Collection): 4.3 Surveying Essential Tools for Active Reconnaissance. Sisältää porttiskannauksen. 5 videota, yhteensä noin 20 min.
KKO 2003:36.
a) Asenna Kali virtuaalikoneeseen. (Jos asennuksessa ei ole mitään ongelmia tai olet asentanut jo aiemmin, tarkkaa raporttia tästä alakohdasta ei tarvita. Kerro silloin kuitenkin, mikä versio ja millä asennustavalla. Jos on ongelmia, niin tarkka ja toistettava raportti).
b) Irrota Kali-virtuaalikone verkosta. Todista testein, että kone ei saa yhteyttä Internetiin (esim. 'ping 8.8.8.8')
c) Porttiskannaa 1000 tavallisinta tcp-porttia omasta koneestasi (nmap -T4 -A localhost). Selitä komennon paramterit. Analysoi ja selitä tulokset.
d) Asenna kaksi vapaavalintaista demonia ja skannaa uudelleen. Analysoi ja selitä erot.
e) Asenna Metasploitable 2 virtuaalikoneeseen
f) Tee koneiden välille virtuaaliverkko. Jos säätelet VirtualBoxista
Kali saa yhteyden Internettiin, mutta sen voi laittaa pois päältä
Kalin ja Metasploitablen välillä on host-only network, niin että porttiskannatessa ym. koneet on eristetty intenetistä, mutta ne saavat yhteyden toisiinsa
Vaihtoehtoisesti voit tehdä molempien koneiden asennuksen ja virtuaaliverkon vagrantilla. Silloin molemmat koneet samaan Vagrantfile:n.
g) Etsi Metasploitable porttiskannaamalla (nmap -sn). Tarkista selaimella, että löysit oikean IP:n - Metasploitablen weppipalvelimen etusivulla lukee Metasploitable.
h) Porttiskannaa Metasploitable huolellisesti ja kaikki portit (nmap -A -T4 -p-). Poimi 2-3 hyökkääjälle kiinnostavinta porttia. Analysoi ja selitä tulokset näiden porttien osalta.

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

 
