# H3 Fuzzy

## x) Lue & Tiivistä
- Asennus:
  - ```git clone https://github.com/ffuf/ffuf```
  - ```cd ffuf```
  - ```go get```
  - ```go build```
- Ffufia voidaan hyödyntää hakemistojen etsintään. Esimerkiksi: ```ffuf -w /path/to/vhost/wordlist -u https://target -H "Host: FUZZ" -fs 4242```
- Virtual hostien löytämisessä voidaan käyttää ```-fs``` -parametria suodattamaan vakiovastauksia. Esimerkiksi: ```ffuf -w /path/to/vhost/wordlist -u https://target -H "Host: FUZZ" -fs 4242```
- Ffuf soveltuu myös GET -parametrien löytämiseen:
  - Kun halutaan löytää parametrin nimi: ```ffuf -w /path/to/paramnames.txt -u https://target/script.php?FUZZ=test_value -fs 4242```
  - Kun halutaan löytää parametrin arvo: ```ffuf -w /path/to/values.txt -u https://target/script.php?valid_name=FUZZ -fc 401```
- Ffufilla voidaan myös fuzzata POST metodien arvoja: ```ffuf -w /path/to/postdata.txt -X POST -d "username=admin\&password=FUZZ" -u https://target/login.php -fc 401```
- Käyttämällä ```-maxtime``` -parametria, voidaan asettaa maksimiaika fuzzaukselle.
- Kun Ffuf käynnistyy, se tarkastaa ensin onko konfiguraatiotiedostoa saatavilla.. 
 

## a) Fuzzzz. Ratkaise dirfuz-1 artikkelista Karvinen 2023: Find Hidden Web Directories - Fuzz URLs with ffuf.

Aloitin asentamalla ensin Ffuf:n [Ffuf/readme.md:n](https://github.com/ffuf/ffuf/blob/master/README.md) ohjeiden pohjalta. 

```git clone https://github.com/ffuf/ffuf```

```cd ffuf```

Sillä kalissa ei ollut esiasennettuna go:ta, asensin sen välissä. 

```sudo apt-get install golang-go```

```go get```

```go build```

Lopuksi tarkastin vielä ffuf:n version tarkastaakseni, että asennus onnistui. 

```ffuf -version```

![a1](https://github.com/user-attachments/assets/3b24432b-f74c-4c32-a3ab-bbc027698a6d)

Tämän jälkeen latasin ```dirfuzt-0``` -ohjeiden pohjalta jo ennakkoon [Seclists Common.txt -sanakirjan](https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt) sekä ```dirfuzt-1``` -haasteen. 

```wget https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt```

```wget https://terokarvinen.com/2023/fuzz-urls-find-hidden-directories/dirfuzt-1```

<img src="https://github.com/user-attachments/assets/f77a46f8-4ec8-4ea1-87f9-678c246c88c2" width="500"> <br/>

Loupksi käynnistin ```dirfuzt-1``` -binäärin. 

```chmod ugo+x dirfuzt-1```

```./dirfuzt-1```

![a3](https://github.com/user-attachments/assets/f9b862da-4957-439d-81e1-3b2833c56de7)

Binääri antoi urlikseen ```http://127.0.0.2:8000```, jonka kävin vielä katsomassa firefoxin avulla. 

<img src="https://github.com/user-attachments/assets/94470936-47a2-4202-8bfe-ddb8f4655a9d" width="500"> <br/>

Sillä binääri jää pyörimään terminaaliin jossa se käynnistettiin, avaan uuden terminaalin toiseen työpöytään. 

Sitten fuzzaukseen. Päätin aloittaa fuzzaamalla sanalistan avulla mahdollisia polkuja. 
Ohjeissa oli jo maininta, että binääristä pitäisi löytyä kaksi sivua: ```Admin page``` ja ```Version control related page```. 

```ffuf -w common.txt -u http://127.0.0.2:8000/FUZZ```

<img src="https://github.com/user-attachments/assets/993b425b-fbe8-42cb-85ed-fdcdb63c2c33" width="500"> <br/>

Näyttäisi tämän perusteella, että ns. väärä polkukin antaa vastauksena takaisin HTTP statuskoodin 200 (= OK). Sillä nämä sivut olivat pääosin samankokoisia ```Size: 154```, päätin lähteä suodattamaan pois sivukoon perusteella. 

```ffuf -w common.txt -u http://127.0.0.2:8000/FUZZ -fs 154```

<img src="https://github.com/user-attachments/assets/0a1d63b8-2b8c-494b-ac23-43b1d49980c7" width="500"> <br/>

```
.git/config             [Status: 200, Size: 178, Words: 6, Lines: 11, Duration: 0ms]
.git                    [Status: 301, Size: 41, Words: 3, Lines: 3, Duration: 0ms]
.git/HEAD               [Status: 200, Size: 178, Words: 6, Lines: 11, Duration: 1ms]
.git/index              [Status: 200, Size: 178, Words: 6, Lines: 11, Duration: 1ms]
.git/logs/              [Status: 200, Size: 178, Words: 6, Lines: 11, Duration: 1ms]
render/https://www.google.com [Status: 301, Size: 64, Words: 3, Lines: 3, Duration: 0ms]
wp-admin                [Status: 200, Size: 182, Words: 6, Lines: 11, Duration: 0ms]
:: Progress: [4746/4746] :: Job [1/1] :: 0 req/sec :: Duration: [0:00:00] :: Errors: 0 ::
```

Tästä tulikin ulos hallittavissa oleva määrä vaihtoehtoja. HTTP statuskoodilla 301 oli kaksi vaihtoehtoa: [HTTP 301 = Moved Permanently](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes). 

Tarkastettuani sivut oikeat vastaukset löytyivät: 

Admin: 
```127.0.0.2:8000/wp-admin```

Flag: **FLAG{tero-wpadmin-3364c855a2ac87341fc7bcbda955b580}**

<img src="https://github.com/user-attachments/assets/02ca4814-4d16-441d-a14a-057066ed0df9" width="500"> <br/>

.git (kaikki näistä antavat saman lipun):

```127.0.0.2:8000/.git/config```

```127.0.0.2:8000/.git```

```127.0.0.2:8000/.git/HEAD```

```127.0.0.2:8000/.git/index```

```127.0.0.2:8000/.git/logs/```

Flag: **FLAG{tero-git-3cc87212bcd411686a3b9e547d47fc51}**

<img src="https://github.com/user-attachments/assets/d7934ea1-1131-4c5f-afb0-a85de1e08402" width="500"> <br/>

Kävin lopuksi vielä sammuttamassa binäärin, joka oli toisessa terminaalissa vielä pyörimässä. 

```CTRL + Z```

## b) Fuff me. Asenna FuffMe-harjoitusmaali. Karvinen 2023: Fuffme - Install Web Fuzzing Target on Debian

Aloitin FuffMe-harjoitusmaalin asennuksen hieman soveltaen [ohjeita](https://terokarvinen.com/2023/fuffme-web-fuzzing-target-debian/), sillä minulla oli jo valmiiksi asennettuna sekä git että ffuf. 

```sudo apt-get install docker.io```

```git clone https://github.com/adamtlangley/ffufme```

```cd ffufme```

```sudo docker build -t ffufme .``` (Huom. piste lopussa on tarpeellinen)

```sudo docker run -d -p 80:80 ffufme```

```curl localhost```

<img src="https://github.com/user-attachments/assets/343babf9-cb1e-4cc2-8a94-f96c2a31486a" width="500"> <br/>

Sillä curl palautti vastauksen, tiesin että docker konttini oli toimii kuten pitääkin. Kävin kuitenkin vielä katsomassa selaimella osoitteesta ```localhost``` miltä se näyttää sitä uteliaisuudesta. 

<img src="https://github.com/user-attachments/assets/3fbb4c5c-c5aa-4fe9-aba5-aac1de4809cd" width="500"> <br/>

## c) Basic Content Discovery

Tämän jälkeen aloitin käymään tehtäviä läpi ohjeiden perusteella. 

<img src="https://github.com/user-attachments/assets/e7475ccb-adf2-43fb-a6aa-28e4d4d7ad96" width="500"> <br/>

```ffuf -w common.txt -u http://localhost/cd/basic/FUZZ```

<img src="https://github.com/user-attachments/assets/3f679d81-eec5-480d-8d08-2699231524e4" width="500"> <br/>

Sieltä ne halutut ```class``` ja ```development.log``` löytyivätkin. 

```curl http://localhost/cd/basic/class```

```curl http://localhost/cd/basic/development.log```

<img src="https://github.com/user-attachments/assets/ddf1bb5b-581b-4b42-91b4-3bd624828b0e" width="500"> <br/>

## d) Content Discovery With Recursion

<img src="https://github.com/user-attachments/assets/7400f72c-ce33-4983-96ca-aa69734cdb04" width="500"> <br/>

```ffuf -w common.txt -recursion -u http://localhost/cd/recursion/FUZZ```

<img src="https://github.com/user-attachments/assets/2e414d41-a905-44b8-9a02-be1fecddd6c1" width="500"> <br/>

Haluttu polku löytyi ```http://localhost/cd/recursion/admin/users/``` sekä siellä oleva tiedosto ```96```

```curl http://localhost/cd/recursion/admin/users/96```

<img src="https://github.com/user-attachments/assets/3d455ff6-e689-4667-9490-5c5f14c3a00a" width="500"> <br/>


## e) Content Discovery With File Extensions

<img src="https://github.com/user-attachments/assets/749d45a7-2fb1-4a5e-8df2-085fd15686cc" width="500"> <br/>

```ffuf -w common.txt -e .log -u http://localhost/cd/ext/logs/FUZZ```

<img src="https://github.com/user-attachments/assets/9e950423-a2d8-40cd-8c1d-a2c5839a9221" width="500"> <br/>

Haluttu tiedosto: ```users.log```

```curl http://localhost/cd/ext/logs/users.log```

<img src="https://github.com/user-attachments/assets/03300d38-902e-4e5a-9167-200465eea612" width="500"> <br/>

## f) No 404 Status

<img src="https://github.com/user-attachments/assets/17ed8e17-e80c-4f56-a772-8ffe4b362ffd" width="500"> <br/>

```ffuf -w common.txt -u http://localhost/cd/no404/FUZZ```

<img src="https://github.com/user-attachments/assets/ad638a87-ec64-41b0-81ed-fe2eb7f87149" width="500"> <br/>

```ffuf -w common.txt -u http://localhost/cd/no404/FUZZ -fs 669```

<img src="https://github.com/user-attachments/assets/67ff5381-7de9-42a3-8fdc-a683449f253b" width="500"> <br/>

Haluttu tiedosto: ```secret```

```curl http://localhost/cd/ext/no404/secret```

<img src="https://github.com/user-attachments/assets/d7abcbd4-32a0-48ac-9e1c-78a555bc77e9" width="500"> <br/>

## g) Param Mining

<img src="https://github.com/user-attachments/assets/71b9934f-37ff-4279-9222-a91c7d4d4e1d" width="500"> <br/>

Tätä tehtävää varten kävin lataamasssa SecLististä [parametreille oman listan burp-parameter-names.txt](https://github.com/danielmiessler/SecLists/blob/master/Discovery/Web-Content/burp-parameter-names.txt).  

```ffuf -w burp-parameter-names.txt -u http://localhost/cd/param/data?FUZZ=1```

<img src="https://github.com/user-attachments/assets/a10dfd29-5834-4a4a-82d7-0f91b909e0a2" width="500"> <br/>

Haluttu parametri: ```debug```

```curl http://localhost/cd/param/data?debug=1```

<img src="https://github.com/user-attachments/assets/fa1645a8-4340-4ddf-9a8f-f1cd0821fa92" width="500"> <br/>

## h) Rate Limited

<img src="https://github.com/user-attachments/assets/93569a58-48bf-4141-8bdd-f54506b364b4" width="500"> <br/>

```ffuf -w common.txt -u http://localhost/cd/rate/FUZZ -mc 200,429```

<img src="https://github.com/user-attachments/assets/b9138bb0-eebd-48e3-a760-71e4c126ebfa" width="500"> <br/>

Odotetusti erroria tuli

```ffuf -w common.txt -t 5 -p 0.1 -u http://localhost/cd/rate/FUZZ -mc 200,429```

<img src="https://github.com/user-attachments/assets/6e204650-36b6-4e07-b53b-05202dc8c967" width="500"> <br/>

Haluttu tiedosto: oracle

curl http://localhost/cd/rate/oracle

<img src="https://github.com/user-attachments/assets/a00838ff-b847-40ab-8870-a881faad75fd" width="500"> <br/>

## i) Subdomains - Virtual Host Enumeration

<img src="https://github.com/user-attachments/assets/8be81722-fbff-4203-9af4-a03560718a2e" width="500"> <br/>

Latasin jälleen uuden listan[combined_subdomains.txt](https://github.com/danielmiessler/SecLists/blob/master/Discovery/DNS/combined_subdomains.txt) tätä varten

```ffuf -w combined_subdomains.txt -H "Host: FUZZ.ffuf.me" -u http://localhost```

<img src="https://github.com/user-attachments/assets/c7408e55-db74-45df-8f3c-94fb1268fb36" width="500"> <br/>

Tässä tuli jälleen älytön määrä ilmoituksia, joten filtteröinti käyttöön. 

```ffuf -w combined_subdomains.txt -H "Host: FUZZ.ffuf.me" -u http://localhost -fs 1495```

<img src="https://github.com/user-attachments/assets/09db1a43-202a-4bff-9f5e-5f40eef83207" width="500"> <br/>

Haluttu subdomainin nimi: redhat


## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 30min. 
- Tehtäviin n. 1h. 
- Raportointiin ja dokumentointiin n. 2h. 

## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

joohoi. s.a. GitHub/ffuf.     
https://github.com/ffuf/ffuf/blob/master/README.md    
Tehtävä x.    

Karvinen, T. 2023. Find Hidden Web Directories - Fuzz URLs with ffuf.    
https://terokarvinen.com/2023/fuzz-urls-find-hidden-directories/    
Tehtävä a.    

Wikipedia. s.a. List of HTTP status codes.        
https://en.wikipedia.org/wiki/List_of_HTTP_status_codes    
Tehtävä a.    

Fuffme - Install Web Fuzzing Target on Debian.     
https://terokarvinen.com/2023/fuffme-web-fuzzing-target-debian/    
Tehtävä b.    

danielmiessler. s.a. GitHub/SecLists.    
https://github.com/danielmiessler/SecLists/    
Tehtävät c-i.  
