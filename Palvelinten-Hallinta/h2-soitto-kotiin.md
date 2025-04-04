# H2 - Soitto kotiin
<img src="
" width="500"> <br/>
```
```

## x) Lue ja tiivistä. 
- Tärkeitä vagrant komentoja ovat:
   - ```vagrant init```: luo uuden vagrant ympäristön
   - ```vagrant up```: käynnistää virtuaalikoneen
   - ```vagrant halt```: sulkee virtuaalikoneen
   - ```vagrant destroy```: tuhoaa vagrantin virtuaalikoneet (ja niissä olevat tiedostot)
   - ```vagrant ssh```: luo SSH yhteyden virtuaalikoneeseen
- Tärkeitä Salt-Minion komentoja ovat:
   - ```master$ hostname -I```: tulostaa koneen (masterin) ip-osoitteen
   - ```master$ sudo salt-key -A```: hyväksyy kaikki odottavat minion-avaimet
   - ```slave$ sudoedit /etc/salt/minion```: avaa minionin konfigurointitiedoston
   - ```slave$ sudo systemctl restart salt-minion.service```: potkaisee salt-minion demonia (jotta muutetut asetukset astuvat voimaan)
- Minionien hallintaan käytettäviä komentoja:
   - ```master$ sudo salt '*' cmd.run 'hostname -I'```: ajaa ```hostname -I```-komennon kaikilla minioneilla ja palauttaa niiden IP-osoitteet
   - ```master$ sudo salt '*' grains.items```: hakee minioneiden järjestelmätiedot
   - ```master$ sudo salt '*' grains.item virtual```: hakee spesifin järjestelmätiedon minioneista (tässä ```virtual``` eli näyttää onko kyseessä fyysinen vai virtuaalinen kone)
   - ```master$ sudo salt '*' pkg.install httpie```: asentaa minioneihin tietyn paketin (tässä ```httpie```)
- Oman salt state:n luonti
   - ```$ sudo mkdir -p /srv/salt/hello```: kansion luonti uutta/uusia salt-state -tiedostoja varten
   - ```$ sudoedit /srv/salt/hello/init.sls```: ```:init.sls```: tiedoston luonti. Ajettaessa ```state.apply hello```-komentoa, haetaan ensimmäisenä ```hello``` -kansiossa olevaa ```init.sls``` -tiedostoa.
   - ```$ sudo salt '*' state.apply hello```: Luodun salt state:n käyttöönotto.
- Top.sls: 
   - ```top.sls``` (```sudoedit /srv/salt/top.sls```) määrittelee mitä statea milläkin minionilla ajetaan.
   - ```$ sudo salt '*' state.apply``` käytetään määritellyn top.sls:n ajamiseen, jolloin ei tarvitse erikseen määritellä mitä halutaan ajaa ja millä minionilla.
   - Esimerkki top.sls:
     ```
     base:
       '*':
         - hello
       'A*':
         - ryhmaa
       'B':
         - ryhmab
     ```

## a) Hello Vagrant! Osoita jollain komennolla, että Vagrant on asennettu (esim tulostaa vagrantin versionumeron). Jos et ole vielä asentanut niitä, raportoi myös Vagrant ja VirtualBox asennukset. (Jos Vagrant ja VirtualBox on jo asennettu, niiden asennusta ei tarvitse tehdä eikä raportoida uudelleen.)


## b) Linux Vagrant. Tee Vagrantilla uusi Linux-virtuaalikone.


## c) Kaksin kaunihimpi. Tee kahden Linux-tietokoneen verkko Vagrantilla. Osoita, että koneet voivat pingata toisiaan.


## d) Herra-orja verkossa. Demonstroi Salt herra-orja arkkitehtuurin toimintaa kahden Linux-koneen verkossa, jonka teit Vagrantilla. Asenna toiselle koneelle salt-master, toiselle salt-minion. Laita orjan /etc/salt/minion -tiedostoon masterin osoite. Hyväksy avain ja osoita, että herra voi komentaa orjakonetta.


## e) Kokeile vähintään kahta tilaa verkon yli (viisikosta: pkg, file, service, user, cmd)




## Ajankäyttö 


## Lähteet: 
Karvinen, T. 2025. Palvelinten Hallinta.   
https://terokarvinen.com/palvelinten-hallinta/   
Tehtävänanto.   

Karvinen, T. 2021. Two Machine Virtual Network With Debian 11 Bullseye and Vagrant.     
https://terokarvinen.com/2021/two-machine-virtual-network-with-debian-11-bullseye-and-vagrant/    
Tehtävä x.    

Karvinen, T. 2018. Salt Quickstart – Salt Stack Master and Slave on Ubuntu Linux.    
https://terokarvinen.com/2018/salt-quickstart-salt-stack-master-and-slave-on-ubuntu-linux/    
Tehtävä x.    

Karvinen, T. 2023. Salt Vagrant - automatically provision one master and two slaves.    
https://terokarvinen.com/2023/salt-vagrant/#infra-as-code---your-wishes-as-a-text-file/    
Tehtävä x.    

Madhok, N. 2015. GitHub SaltStack CheatSheet.    
https://github.com/saltstack/salt/wiki/Cheat-Sheet    
Tehtävä x.    

