# H2 Lempiväri: Violetti

## x) Pyramid of Pain & Diamond Model
- Pyramid of Pain kuvaa kuinka paljon vaikeampaa hyökkäys on toteuttaa kun hyökkääjältä estetään indikaattorien osoittamia hyökkäysväyliä.
- Pyramid of Painin tavoitteena on tehdä hyökkäyksestä niin hankalaa, että hyökkääjälle on mielekkäämpää lopettaa hyökkäys kuin yrittää löytää vaihtoehtoisia keinoja hyökätä.
- Diamond model on kyberhyökkäysten analysointiin ja tutkimiseen käytetty viitekehys, jonka avulla neljän pääalueen (hyökkääjän, uhrin, infrastruktuurin ja kyvykkyyksien/työkalujen) välisiä suhteita ja vuorovaikutuksia voidaan kartoittaa.
- Diamond model:n taustalla on ajatus siitä, että jokaista kyberhyökkäystä voidaan tutkailla mallin ja sen taustalla olevan perusväitteen (aksiooman) avulla. Ks. Diamond Model Axioms (https://www.activeresponse.org/diamond-model-axioms/)

## a) Apache log. Asenna Apache-weppipalvelin paikalliselle virtuaalikoneellesi. Surffaa palvelimellesi salaamattomalla HTTP-yhteydellä, http://localhost . Etsi omaa sivulataustasi vastaava lokirivi. Analysoi yksi tällainen lokirivi, eli selitä sen kaikki kohdat. (Jos Apache ei ole kovin tuttu, voit tätä tehtävää varten vain asentaa sen ja testata oletusweppisivulla. Eli ei tarvitse tehdä omia kotisvuja tms.)

Asensin ensin Apache2:n 

```sudo apt-get install apache2```

Tämän jälkeen menin selaimella osoitteeseen ```localhost``` ja tämän jälkeen tarkastin lokin. 

```sudo tail -10 /var/log/apache2/access.log```






## b) Nmapped. Porttiskannaa oma weppipalvelimesi käyttäen localhost-osoitetta ja 'nmap -A' päällä. Selitä tulokset. (Pelkkä http-portti 80/tcp riittää)


## c) Skriptit. Mitkä skriptit olivat automaattisesti päällä, kun käytit "-A" parametria? (Näkyy avoimien porttinumeroiden alta, http-blah, http-blöh...).


## d) Jäljet lokissa. Etsi weppipalvelimen lokeista jäljet porttiskannauksesta (NSE eli Nmap Scripting Engine -skripteistä skannauksessa). Löydätkö sanan "nmap" isolla tai pienellä? Selitä osumat. Millaisilla hauilla tai säännöillä voisit tunnistaa porttiskannauksen jostain muusta lokista, jos se on niin laaja, että et pysty lukemaan itse kaikkia rivejä?


## e) Wire sharking. Sieppaa verkkoliikenne porttiskannatessa Wiresharkilla. Huomaa, että localhost käyttää "Loopback adapter" eli "lo". Tallenna pcap. Etsi kohdat, joilla on sana "nmap" ja kommentoi niitä. Jokaisen paketin jokaista kohtaa ei tarvitse analysoida, yleisempi tarkastelu riittää.


## f) Net grep. Sieppaa verkkoliikenne 'ngrep' komennolla ja näytä kohdat, joissa on sana "nmap".


## g) Agentti. Vaihda nmap:n user-agent niin, että se näyttää tavalliselta weppiselaimelta.


## h) Pienemmät jäljet. Porttiskannaa weppipalvelimesi uudelleen localhost-osoitteella. Tarkastele sekä Apachen lokia että siepattua verkkoliikennettä. Mikä on muuttunut, kun vaihdoit user-agent:n? Löytyykö lokista edelleen tekstijono "nmap"?


## i) Hieman vaikeampi: LoWeR ChEcK. Poista skritiskannauksesta viimeinenkin "nmap" -teksti. Etsi löytämääsi tekstiä /usr/share/nmap -hakemistosta ja korvaa se toisella. Tee porttiskannaus ja tarkista, että "nmap" ei näy isolla eikä pienellä kirjoitettuna Apachen lokissa eikä siepatussa verkkoliikenteessä. (Tässä tehtävässä voit muokata suoraan lua-skriptejä /usr/share/nmap alta, 'sudoedit'. Muokatun version paketoiminen siis rajataan ulos tehtävästä.)


## j) Vapaaehtoinen, vaikea: Invisible, invincible. Etsi jokin toinen nmap:n skripti, jonka verkkoliikenteessä esiintyy merkkijono "nmap" isolla tai pienellä. Muuta nmap:n koodia niin, että tuo merkkijono ei enää näy verkkoliikenteessä.

## Ajankäyttö
- Tiivistelmiin n. 1,5h.
- 

## Lähteet
Karvinen, T. 2025. Verkkoon tunkeutuminen ja tiedustelu.    
https://terokarvinen.com/verkkoon-tunkeutuminen-ja-tiedustelu/    
Tehtävänanto.    

Bianca, DJ. 2014. Pyramid of Pain. 
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

x) Lue ja vastaa lyhyesti kysymyksiin. Tässä alakohdassa x ei tällä kertaa tarvitse lukea artikkeleita kokonaan, ei tarvitse tiivistää niitä, eikä tehdä testejä koneella.
Selitä tuskan pyramidin idea 1-2 virkkeellä. Bianco 2013: Pyramid of Pain. (Katso eritoten pyramidin kuvaa.)
Selitä timanttimallin (Diamond Model) idea 1-2 virkkeellä. Tekijä esittelee sen aika juhlallisesti, voit myös etsiä yksinkertaisempia artikkeleita hakukoneella tai kelata suoraan timantin kuvaan. Caltagirone et al 2013: Diamond Model
a) Apache log. Asenna Apache-weppipalvelin paikalliselle virtuaalikoneellesi. Surffaa palvelimellesi salaamattomalla HTTP-yhteydellä, http://localhost . Etsi omaa sivulataustasi vastaava lokirivi. Analysoi yksi tällainen lokirivi, eli selitä sen kaikki kohdat. (Jos Apache ei ole kovin tuttu, voit tätä tehtävää varten vain asentaa sen ja testata oletusweppisivulla. Eli ei tarvitse tehdä omia kotisvuja tms.)
b) Nmapped. Porttiskannaa oma weppipalvelimesi käyttäen localhost-osoitetta ja 'nmap -A' päällä. Selitä tulokset. (Pelkkä http-portti 80/tcp riittää)
c) Skriptit. Mitkä skriptit olivat automaattisesti päällä, kun käytit "-A" parametria? (Näkyy avoimien porttinumeroiden alta, http-blah, http-blöh...).
d) Jäljet lokissa. Etsi weppipalvelimen lokeista jäljet porttiskannauksesta (NSE eli Nmap Scripting Engine -skripteistä skannauksessa). Löydätkö sanan "nmap" isolla tai pienellä? Selitä osumat. Millaisilla hauilla tai säännöillä voisit tunnistaa porttiskannauksen jostain muusta lokista, jos se on niin laaja, että et pysty lukemaan itse kaikkia rivejä?
e) Wire sharking. Sieppaa verkkoliikenne porttiskannatessa Wiresharkilla. Huomaa, että localhost käyttää "Loopback adapter" eli "lo". Tallenna pcap. Etsi kohdat, joilla on sana "nmap" ja kommentoi niitä. Jokaisen paketin jokaista kohtaa ei tarvitse analysoida, yleisempi tarkastelu riittää.
f) Net grep. Sieppaa verkkoliikenne 'ngrep' komennolla ja näytä kohdat, joissa on sana "nmap".
g) Agentti. Vaihda nmap:n user-agent niin, että se näyttää tavalliselta weppiselaimelta.
h) Pienemmät jäljet. Porttiskannaa weppipalvelimesi uudelleen localhost-osoitteella. Tarkastele sekä Apachen lokia että siepattua verkkoliikennettä. Mikä on muuttunut, kun vaihdoit user-agent:n? Löytyykö lokista edelleen tekstijono "nmap"?
i) Hieman vaikeampi: LoWeR ChEcK. Poista skritiskannauksesta viimeinenkin "nmap" -teksti. Etsi löytämääsi tekstiä /usr/share/nmap -hakemistosta ja korvaa se toisella. Tee porttiskannaus ja tarkista, että "nmap" ei näy isolla eikä pienellä kirjoitettuna Apachen lokissa eikä siepatussa verkkoliikenteessä. (Tässä tehtävässä voit muokata suoraan lua-skriptejä /usr/share/nmap alta, 'sudoedit'. Muokatun version paketoiminen siis rajataan ulos tehtävästä.)
j) Vapaaehtoinen, vaikea: Invisible, invincible. Etsi jokin toinen nmap:n skripti, jonka verkkoliikenteessä esiintyy merkkijono "nmap" isolla tai pienellä. Muuta nmap:n koodia niin, että tuo merkkijono ei enää näy verkkoliikenteessä.
