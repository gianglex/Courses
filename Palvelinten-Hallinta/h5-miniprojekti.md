# h5 Miniprojekti

## Moduulien pohjustus

Päätin luoda miniprojektini lokien keräykseen liittyen. Lokien luonteen vuoksi keräys-moduuli ei ole idempotentti, sillä samalta koneelta voidaan haluta kerätä samoja lokeja useamman kerran. 

Sillä demoa varten tarvitsen myös demo-ympäristön, päätin luoda lisäksi toisen idempotentin moduulin, joka luo testiympäristön moduulin testaamista varten. 

Aloitin miettimällä moduuleille toimintalogiikan. 

Lokienkeräys: 
- Luo kansion X. 
- Etsii ja kerää halutut lokitiedostot kansioon X. 
- Pakkaa kansion X tiedostoksi. 
- Lähettää paketoidun kansion masterille.
- Poistaa kansion X. 

Ympäristö: 
- Vagrantfile, jolla testiympäristön koneet luodaan. 
  - Ympäristö asentaa valmiiksi masteriin ja minioneihin saltit. 
- Salt-state, joka asentaa lokeja luovan ohjelman. 
- Käynnistää palvelut ja tarvittaessa ajaa muutaman komennon ohjelmilla, jotta lokitiedostot muodostuvat. 

## Lokienkeräys

Alkuun piti miettiä miten toimintalogiikan osaset saadaan käytännössä ajettua manuaalisesti. 

### Kansion luonti 

```mkdir``` -komennolla saadaan luotua kansio. 

```mkdir KOPIOINTIHAKEMISTO```

### Tiedostojen keräys

```find``` -komennolla voidaan hakea tiedostoja ([find dokumentaatio](https://www.geeksforgeeks.org/find-command-in-linux-with-examples/)). Antamalla komennolle halutut parametrit saadaan komento hakemaan lokitiedostot koneelta. Osa lokeista vaatii sudon, joten ajetaan sudona. 

```sudo find HAKEMISTO -type f -name "*.log"```

![a1](https://github.com/user-attachments/assets/4a8cce28-1d7a-4d20-966f-66dfdf227988)

Sillä tämä tulostaa myös virheilmoitukset (Kuvassa ```find: ‘/run/user/1000/doc’: Permission denied```), lisätään komennon loppuun vielä ```2>/dev/null```, jonka avulla saadaan virheilmoitukset poistettua tulostuksesta. 

```sudo find / -type f -name "*.log 2>/dev/null"```

![a2](https://github.com/user-attachments/assets/9dd3c1ce-1656-495e-a64a-f1eac5110d0d)

Muokataan vielä aiempaa komentoa, jotta löydetyt tiedostot saadaan kopiointua kohdekansioon. ```cp``` -komento kopioi tiedostot. Komennossa jokaiselle findin löytämälle ```.log``` tiedostolle ajetaann ```cp``` -komento. 

```sudo find / -type f -name "*.log" -exec cp --parents {} /home/phallinta/testtmp/ \; 2>/dev/null```

Tarkastetaan lopuksi vielä, että kohdetiedostot kopioituivat kohdekansioon

```sudo find /home/phallinta/testtmp/```

![a3](https://github.com/user-attachments/assets/3af2cda7-0823-4268-bdf4-f606af36411a)

### Kansion pakkaus

```tar``` -komennolla voidaan pakata tiedostot ([tar dokumentaatio](https://www.geeksforgeeks.org/tar-command-linux-examples/)). 

```tar -czf /home/phallinta/testtmp.tar.gz -C /home/phallinta/testtmp/ .```

Lopuksi tarkastetaan vielä, että pakattu tiedosto tosiaan muodostui. 

```ls```

![a4](https://github.com/user-attachments/assets/59a7f1ef-7049-4190-80ae-fd4f284716de)

### Tiedoston lähetys

Tiedostoja saadaan lähetettyä minionilta masterille ajamalla masterista ```salt '*' cp.push KOHDETIEDOSTO``` ([salt.modules.cp dokumentaatio](https://docs.saltproject.io/en/3006/ref/modules/all/salt.modules.cp.html)). 
Masterille lähetetyt tiedostot saapuvat master-koneella oletuksena hakemistoon ```/var/cache/salt/master/minions/minion-id/files/```

Testataan tämän toimintaa aiemmin luomassani Vagrant -ympäristössä. 

```vagrant up```

Vagrantin käynnistyttyä avaan oman terminaali-ikkunat masterille ja minionille. 

Master: ```vagrant ssh ketchup```

Minion: ```vagrant ssh lettuce```

Muokataan masterin konfiguraatiota, jotta tiedostojen lähettäminen masterille sallitaan, ja käynnistetään salt-master uudelleen jotta muokatut asetukset tulevat voimaan. 

Master: ```sudoedit /etc/salt/master```

```file_recv: True```
```file_recv_size_max: 1000```

![b1](https://github.com/user-attachments/assets/97a69632-23ab-4343-8e05-868d7a386d34)

Master: ```sudo systemctl restart salt-master```

Luodaan minionille testitiedosto ja pusketaan se masterille. 

Minion: ```touch /home/vagrant/test.txt```

![b2](https://github.com/user-attachments/assets/eed1df63-9655-4241-a650-dff871843b71)

Master: ```sudo salt 'lettuce' cmd.run 'salt-call cp.push /home/vagrant/test.txt'```

![b3](https://github.com/user-attachments/assets/a74a1f1e-a6e8-4e6f-96c2-4a800c95763d)

Tarkastetaan vielä, että tiedosto tuli perille. 

Master: ```find /var/cache/salt/master/minions/lettuce/```

![b4](https://github.com/user-attachments/assets/a7b4e8ab-ac05-4da3-83f3-5ee7c4c4b854)

### Kansion poistaminen. 

Tiedostot saadaan poistettua ```-rm``` komennolla ([rm dokumentaatio](https://www.geeksforgeeks.org/rm-command-linux-examples/)). 

Tarkastetaan ensin tilanne, ajetaan komento ja tarkastetaan, että ovat poistuneet. 

```ls```

```sudo rm -rf /home/phallinta/testtmp/```

```ls```

![a5](https://github.com/user-attachments/assets/6d7fbc05-e893-4f28-a3f3-24bdbc21c902)

## Testiympäristön luominen

Muokkasin testiympäristöä varten [h4](https://github.com/gianglex/Courses/blob/main/Palvelinten-Hallinta/h4-pkg-file-service.md):ssa luomaani apachen salt state tiedostoa. 
Apachen asennuksen lisäksi loin testiympäristöön muutaman lokitiedoston .log päätteellä, jotta lokienkeräys saisi lisää kerättävää. 

State lyhyesti: 
- Asentaa curl:n ja apache2:n
- Luo verkkosivun ja käynnnistää apache2:n
- Muokkaa host -tiedostoa
- Ajaa curlin kun apache käynnistyy uudelleen
- Luo muutaman lokitiedoston

```yaml
curl:
  pkg.installed

apache2:
  pkg.installed

apache2_service:
  service.running:
    - name: apache2
    - enable: True
    - watch:
      - file: /etc/apache2/sites-available/exampleenvironment.com.conf

/etc/apache2/sites-available/exampleenvironment.com.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '644'
    - contents: |
        <VirtualHost *:80>
          ServerName exampleenvironment.com
          ServerAlias www.exampleenvironment.com
          DocumentRoot /home/vagrant/public-sites/exampleenvironment.com
          <Directory /home/vagrant/public-sites/exampleenvironment.com>
            Require all granted
          </Directory>
        </VirtualHost>

exampleenvironment.com-enabled:
  cmd.run:
    - name: a2ensite exampleenvironment.com.conf
    - unless: "a2query -s exampleenvironment.com"
    - require:
      - file: /etc/apache2/sites-available/exampleenvironment.com.conf
    - watch_in:
      - service: apache2_service

/home/vagrant/public-sites:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/public-sites/exampleenvironment.com:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/public-sites/exampleenvironment.com/index.html:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: '755'
    - contents: |
        Test page for test environment

exampleenvironment.com-hosts:
  file.append:
    - name: /etc/hosts
    - text: "127.0.0.1 exampleenvironment.com"

curl_localhost:
  cmd.run:
    - name: curl localhost
    - onlyif: test -f /etc/apache2/sites-enabled/exampleenvironment.com.conf
    - onchanges:
      - service: apache2_service

/home/vagrant/fakelogs:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/fakelogs/fake.log:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: '644'
    - contents: |
        # I'm a fake log. Collect me.
        Fakers gonna fake. 

/home/vagrant/fakelogs/fake2.log:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: '644'
    - contents: |
        # I'm a fake log2. Collect me.
        They see me fakin, they hatin. 
```

## .sls tiedoston luonti lokien keräykselle



## Ajankäyttö 
Aikaa kului: 
- Tiivistelmään ~15min
- Tehtävien tekemiseen ja tiedon hakemiseen ~3h
- Dokumentointiin ja raportointiin ~2h

```bash
file_recv: True
file_recv_size_max: 1000
```

## Lähteet: 
Karvinen, T. 2025. Palvelinten Hallinta.   
https://terokarvinen.com/palvelinten-hallinta/   
Tehtävänanto.   

Geeksforgeeks. 2025. How to Find a File in Linux | Find Command. 
https://www.geeksforgeeks.org/find-command-in-linux-with-examples/
Find dokumentaatio. 

Geeksforgeeks. 2025. How to Compress Files in Linux | Tar Command. 
https://www.geeksforgeeks.org/tar-command-linux-examples/
Tar -dokumentaatio. 

The Salt Project. s.a. Salt.modules.cp. 
https://docs.saltproject.io/en/3006/ref/modules/all/salt.modules.cp.html
Salt.modules.cp. -dokumentaatio. 

Le, G. 2025. h4 Pkg-file-service. 
https://github.com/gianglex/Courses/blob/main/Palvelinten-Hallinta/h4-pkg-file-service.md
Pohja testiympäristölle. 
