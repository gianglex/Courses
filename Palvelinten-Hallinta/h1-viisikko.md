# H1 - Viisikko

## x) Lue ja tiivistä. 
- Salt:a käytetään tyypillisesti hallinnoimaan suuria määriä minion-koneita verkon yli.
- Tärkeimmät state-funktiot ovat: pkg, file, service, user ja cmd. 
- Minion-koneita voi ohjata vaikka ne ovat NAT:n tai palomuurin takana.
- Salt:n käyttöjärjestelmälle asentamisen jälkeen täytyy vielä:
  - Konfiguroida Salt master ja slave
  - Aloittaa master ja minion palvelut
  - Hyväksyä minion-avaimet
  - Verifioida salt asennus
  - Asentaa riippuvuudet
- Raportin on oltava toistettava, täsmällinen, helppolukuinen ja sen on viitattava lähteisiinsä. 

## a) Asenna Debian 12-Bookworm virtuaalikoneeseen. 

<img src="https://github.com/user-attachments/assets/f616ce15-774a-4bdd-bfdf-1f82743c338c" width="500"> <br/>


## b) Asenna Salt (salt-minion) Linuxille (uuteen virtuaalikoneeseesi).

Seurasin Salt project:n ohjeita Salt-minionin asentamiseen. 

Keyrings-polun luonti

```mkdir -p /etc/apt/keyrings```    

Julkisen avaimen lataus

```curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp```    

Salt:n apt repon konfigurointi jotta esim apt-get install osaa etsiä oikeasta paikasta salt-minion ohjelman

```curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources```    

Paketinhallinnan päivitys uuden apt repon konfiguroinnin jälkeen

```sudo apt-get update```   

Varsinainen Salt-minionin asennus. 

```sudo apt-get -y install salt-minion```   

Lopuksi vielä version tarkastus asennuksesn varmentamiseksi. 

```sudo salt-call --version```   

<img src="https://github.com/user-attachments/assets/7e50230d-8998-43ea-b2ce-edfe7db01553" width="500"> <br/>


## c) Saltin tärkeimmät tilafunktiot

### pkg


<img src="https://github.com/user-attachments/assets/1950252a-a8c9-4dcd-a82e-2976ab82a051" width="500"> <br/>

```sudo salt-call --local -l info state.single pkg.installed bash-completion```

Komennolla pyritään tilanteeseen, jossa minion-koneessa on asennettuna bash-completion. 

Bash-completion oli jo asennettuna koneeseen, joten komento palautti että varmistus tehty onnistuneesti. 

```pkg.installed``` -osio tarkoittaa pyrkimystä tilanteeseen, jossa paketti on asennettuna. Jos esimerkiksi tilalla olisi ```pkg.removed```, olisi tästä koneessa poistettu asennettu bash-completion. 

### file

<img src="https://github.com/user-attachments/assets/2b43d9ec-a496-44d0-ae81-f38552c3efa1" width="500"> <br/>

```sudo salt-call --local -l info state.single file.managed /tmp/gettothechopa contents="hasta la vista baby"```

Komennolla pyritään tilanteeseen, jossa ```gettothechopa``` -tiedosto on olemassa ja sisältää tekstin ```hasta la vista baby```. 

```file.managed``` -osio tarkoittaa että komento pyrkii siihen että tiedosto on olemassa ja ```contents="hasta la vista baby"```-osiolla pyritään siihen että se lisäksi sisältää tekstin ```hasta la vista baby```.
Toisaalta käyttämällä ```file.absent``` voitaisiin pyrkiä siihen, että tiedostoa ei ole tai jos on olemassa niin se pyrittäisiin poistamaan. 

### service

<img src="https://github.com/user-attachments/assets/a4b9168c-d2ed-4444-9742-010571ab0bec" width="500"> <br/>

```sudo salt-call --local -l info state.single service.running apache2 enable=True```

Komennolla pyritään tilanteeseen, jossa apache2 olisi käynnissä. Johtuen siitä että apache2:sta ei ollut asennettuna, ei ohjelma pystynyt käynnistämään sitä. Tämän takia komento palautti ```Failed:    1``` sillä haluttuun lopputulokseen ei päästy. 
Vastakkaisella ```~service.dead apache2 enable=False``` -komennolla olisi saatu aikaisesksi ```Succeeded: 0``` vaikka ohjelma ei olisi ollut asennettuna, sillä haluttuun lopputulokseen (apache2 ei käynnissä) oltaisiin päästy. 

### user

<img src="https://github.com/user-attachments/assets/4d62aee5-f08f-4589-b64a-263ac0dc5e2a" width="500"> <br/>

```sudo salt-call --local -l info state.single user.absent eiteroatanne```

Komennolla pyritään tilanteeseen, jossa käyttäjää ```eiteroatanne``` ei ole järjestelmässä. Sillä käyttäjää ei ollut olemassa, ei sitä myöskään tarvinnut luoda. 
Vastakkaisella ```user.present``` -osiolla ```user.absent``` -osion sijasta, olisi järjestelmä luonut uuden käyttäjän ```eiteroatanne```. 


### cmd

<img src="https://github.com/user-attachments/assets/e169c98c-224b-4b18-b306-958478c7f231" width="500"> <br/>

```sudo salt-call --local -l info state.single cmd.run 'touch /tmp/touchy' creates="/tmp/touchy"```

Komennon osio ```cmd.run 'touch /tmp/touchy'``` -osio tarkoittaa, että pyritään ajamaan komento ```touch /tmp/touchy```. 
Osiolla ```creates="/tmp/touchy"``` pyritään signaloimaan tavoitetilaa (= määrittelemään idempotenssia), eli tilannetta jossa /tmp/touchy on jo luotuna. Eli uudelleenajettaessa komentoa, tiedoston aikaleima ei päivity. 


## d) Idempotentti. 

Idempotenssi tarkoittaa käytännössä sitä, että samaa komentoa tai käskyä voisi ajaa loputtomasti ja lopputulos olisi silti sama kuin ensimmäisen ajon jälkeen, sillä tavoitetila on jo saavutettu. 


Ensimmäisellä ajokerralla: 

```sudo salt-call --local -l info state.single pkg.installed micro```

<img src="https://github.com/user-attachments/assets/53791153-1f32-45e0-bc27-843c75fd2eca" width="500"> <br/>

Seuraavilla (n > 1) ajokerroilla:

```sudo salt-call --local -l info state.single pkg.installed micro```

<img src="https://github.com/user-attachments/assets/376001e0-a9a6-4823-b5c1-1c65218a8a5a" width="500"> <br/>

Kuten esimerkistä näkee, ensimmäisellä kerralla komento asentaa micron, mutta seuraavilla kerroilla ei muutoksia enää tapahdu riippumatta siitä kuinka monta kertaa sitä ajaa. 


## Ajankäyttö 
Aktiivistä Linuxin käyttöä ~30min-1h. Raportin kirjoittamiseen ja yleiseen dokumentointiin ~2h. 


## Lähteet: 
Karvinen, T. 2025. Palvelinten Hallinta.   
https://terokarvinen.com/palvelinten-hallinta/   
Tehtävänanto.   

Karvinen, T. 2021. Run Salt Command Locally.    
https://terokarvinen.com/2021/salt-run-command-locally/   
Tehtävät x, a, b, c, d.    

Karvinen, T. 2018. Salt Quickstart – Salt Stack Master and Slave on Ubuntu Linux.    
https://terokarvinen.com/2018/03/28/salt-quickstart-salt-stack-master-and-slave-on-ubuntu-linux/   
Tehtävät x, a, b, c, d.    

Karvinen, T. 2006. Raportin kirjoittaminen.    
https://terokarvinen.com/2006/06/04/raportin-kirjoittaminen-4/   
Tehtävät x, a, b, c, d.    

Salt Project. s.a. Salt install guide for Linux (DEB).    
https://docs.saltproject.io/salt/install-guide/en/latest/topics/install-by-operating-system/linux-deb.html   
Tehtävät x, a, b, c, d.    
