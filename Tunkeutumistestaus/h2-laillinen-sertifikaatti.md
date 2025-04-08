# H2 Täysin Laillinen Sertifikaatti

## x) Tiivistys
- A01:2021 – Broken Access Control
   - Broken access control oli vuoden 2021 OWASP:n kriittisin turvallisuusriski.
   - Access controllin pettäminen tyypillisesti johtaa luvattomaan tiedon paljastumiseen, muokkaamiseen tai tuhoutumiseen.
   - Yleisimpiä haavoittuvuuksia ovat mm.: vähimmän oikeuden periaatteen loukkaus, pääsynvalvonnan ohitus, IDOR, API-kutsujen pääsynvalvonnan pettäminen, oikeuksien laajennus. 
- A10:2021 – Server-Side Request Forgery (SSRF)
   - SSRF oli vuoden 2021 OWASP:n 10. kriittisin turvallisuusriski.
   - SSRF voi johtaa sisäverkkoon pääsyyn, tietovuotoihin tai muihin ulkopuolisilta rajoitettuihin asioihin pääsyyn.
   - Haavoittuvuus esiintyy, kun web-applikaatio yrittää hakea resurssia validoimatta käyttäjän antamaa URL:a.
- Insecure Direct Object References (IDOR)
   - IDOR haavoittuvuudessa hyväksikäytetään tilannetta, jossa sovellus käyttää käyttäjän antamaa syötettä hakiessaan tietoja.
   - IDOR voi johtaa tietojen vuotamiseen.
- Path traversal
   - Path traversal haavoittuvuus mahdollistaa hyökkääjälle tiedostojen lukemisen ja muokkaamisen palvelimelta.
   - Tapahtuu usein, silloin kun käyttäjän syötteitä ei validoida. 
- Server-Side Request Forgery (SSRF)
   - SSRF -haavoittuvuudessa palvelin saadaan tekemään pyyntöjä hyökkääjän haluamiin paikkoihin.
   - SSRF:n avulla voidaan päästä sisäisiin järjestelmiin tai palvelimen tekemiä pyyntöjä voidaan käyttää muutoin hyväksi. 
- Cross-Site Scripting (XSS)
   - XSS -haavoittuvuudessa hyökkääjä voi ajaa haluttua koodia muiden käyttäjien selaimissa.
   - Voidaan jakaa kolmeen tyyppiin: reflected XSS, stored XSS, DOM-based XSS. 
- Server-Side Template Injection (SSTI)
   - Haavoittuvuudessa hyökkääjä pystyy syöttämään kuormansa (payload) palvelimella oleviin pohjiin, joita lopulta ajetaan palvelimen puolelta. 
   - SSTI voi johtaa pääsyn koko infrastruktuuriin. 


## Ajankäyttö: 

- Materiaalien lukemiseen, kuuntelemiseen ja tiivistämiseen n. 2h. 
- Tehtäviin n. 2h. 
- Raportointiin ja dokumentointiin n. 2h. 

## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

OWASP. 2021. A01:2021 – Broken Access Control.    
https://owasp.org/Top10/A01_2021-Broken_Access_Control/    
Tehtävä x.    

OWASP. 2021. A01:2021 – Broken Access Control.    
https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_%28SSRF%29/    
Tehtävä x.    

PortSwigger. s.a. Insecure direct object references (IDOR).    
https://portswigger.net/web-security/access-control/idor    
Tehtävä x.    

PortSwigger. s.a. Path traversal.    
https://portswigger.net/web-security/file-path-traversal    

PortSwigger. s.a. Server-side request forgery (SSRF).    
https://portswigger.net/web-security/ssrf    
Tehtävä x.    

PortSwigger. s.a. Cross-site scripting.    
https://portswigger.net/web-security/cross-site-scripting
Tehtävä x.    

PortSwigger. s.a. Server-side template injection.    
https://portswigger.net/web-security/server-side-template-injection    
Tehtävä x.    
