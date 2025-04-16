# h3 Infraa koodina

## x) Lue ja tiivistä.
- Voit hallita suurta määrää daemoneita CMS:llä (Configuration management system)
- Package-file-service:llä voit säädellä mm.:
  - ohjelman asennusta
  - konfiguraatiotiedoston korvaamista
  - daemonin uudelleenkäynnistä uuden konfiguraation käyttöönottamiseksi
- Esimerkiksi ssh voidaan konfiguroida ```init.sls``` -tiedoston avulla avaamaan tietty portti. 

## Vagrantfilen päivitys 

Ketchup: ```sudo salt 'lettuce' state.apply yessir```

<img src="https://github.com/user-attachments/assets/f0ffe1ad-5398-4680-8118-9488baa62d8f" width="500"> <br/>

a) Apache easy mode. Asenna Apache, korvaa sen testisivu ja varmista, että demoni käynnistyy.
Ensin käsin, vasta sitten automaattisesti.
Kirjoita tila sls-tiedostoon.
pkg-file-service
Tässä ei tarvita service:ssä watch, koska index.html ei ole asetustiedosto
b) SSHouto. Lisää uusi portti, jossa SSHd kuuntelee.
Jos käytät Vagrantia, muista jättää portti 22/tcp auki - se on oma yhteytesi koneeseen. SSHd:n asetustiedostoon voi tehdä yksinkertaisesti kaksi "Port" riviä, molemmat portit avataan.
Löydät oikean asetuksen katsomalla SSH:n asetustiedostoa
Nyt tarvitaan service-watch, jotta demoni käynnistetään uudelleen, jos asetustiedosto muuttuu masterilla
c) Vapaaehtoinen, haastavahko tässä vaiheessa: Asenna ja konfiguroi Apache ja Name Based Virtual Host. Sen tulee näyttää palvelimen etusivulla weppisivua. Weppisivun tulee olla muokattavissa käyttäjän oikeuksin, ilman sudoa.
d) Vapaaehtoinen, haastava: Caddy. Asenna Caddy tarjoilemaan weppisivua. Weppisivun tulee näkyä palvelimen etusivulla (localhost). HTML:n tulee olla jonkun käyttäjän kotihakemistossa, ja olla muokattavissa normaalin käyttäjän oikeuksin, ilman sudoa.
e) Vapaaehtoinen, haastava: Nginx. Asenna Nginx (lausutaan engine-X) tarjoilemaan weppisivua. Weppisivun tulee näkyä palvelimen etusivulla (localhost). HTML:n tulee olla jonkun käyttäjän kotihakemistossa, ja olla muokattavissa normaalin käyttäjän oikeuksin, ilman sudoa.
f) Vapaaehtoinen, haastava: PostgreSQL. Asenna PostgreSQL-tietokannanhallintajärjestelmä. Anna jollekin käyttäjälle oma tietokanta. Osoita testillä, että se toimii.
Vinkit

Ensin käsin, sitten automaattisesti
Testaa
Alkutilanne (taikurin hihat tyhjät)
Käsin tehty ja toimii
Poistettu käsin tehty ennen automaatiota
Yksi tilafunktio (esim. file) sls-tiedostossa
Lopputilanne, osat
Lopputesti - mitä käyttäjä tekisi
/etc/ssh/sshd_config
Port: 1234
nc -vz localhost 1234
ssh -p 1234 foo@localhost
echo "Hei"|sudo tee /var/www/html/index.html # ainoa tilanne sudotella html-sivua
Omat asetustiedostot
Kun teet käsin, saat siitä mallin asetustiedostolle (masterin /srv/salt/foo/bar.cfg)
Esimerkkidokumenteissa olevat demonien asetustiedostot tuskin toimivat juuri omassa järjestelmässä

## Ajankäyttö 
Aikaa kului: 
- Tiivistelmään ~15min
- Vagrantfile informaation haku, päivitys ja dokumentaatio ~h
- Varsinaiseen tekemiseen ~min
- Dokumentointiin ja raportointiin ~h


## Lähteet: 
Karvinen, T. 2025. Palvelinten Hallinta.   
https://terokarvinen.com/palvelinten-hallinta/   
Tehtävänanto.   

Karvinen, T. 2018. Pkg-File-Service – Control Daemons with Salt – Change SSH Server Port.    
https://terokarvinen.com/2018/04/03/pkg-file-service-control-daemons-with-salt-change-ssh-server-port/    
Tehtävä x.    
