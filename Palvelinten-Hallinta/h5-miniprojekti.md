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

Aloitin salt state tiedoston pohjustamisen tekemällä ensin lokienkeräyksen manuaalisesti osa osalta. 

### Kansion luonti 

```mkdir``` -komennolla saadaan luotua kansio. 

```mkdir testtmp```

### Tiedostojen keräys

```find``` -komennolla voidaan hakea tiedostoja ([find dokumentaatio](https://www.geeksforgeeks.org/find-command-in-linux-with-examples/)). Antamalla komennolle halutut parametrit saadaan komento hakemaan lokitiedostot koneelta. Osa lokeista vaatii sudon, joten ajetaan sudona. 

```sudo find / -type f -name "*.log"```

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

### .sls tiedoston luonti lokien keräykselle

Lokienkeräys: 
- Luo kansion X. 
- Etsii ja kerää halutut lokitiedostot kansioon X. 
- Pakkaa kansion X tiedostoksi. 
- Lähettää paketoidun kansion masterille.
- Poistaa kansion X. 


## Testiympäristön luominen

Käytin testiympäristön luontiin pohjana aiemmin luomaani Vagrantfileä ([h4](https://github.com/gianglex/Courses/blob/main/Palvelinten-Hallinta/h4-pkg-file-service.md)). 

Vagrantfile lyhyesti: 
- Luo masterin ja 3 minionia.
- Asentaa näihin salt-masterin masteriin ja salt-minionin minioneille. 

```bash
# -*- mode: ruby -*-
# vi: set ft=ruby :

$salt = <<'SALT'
echo "Initializing SALT to install salt dependencies"
mkdir -p /etc/apt/keyrings
sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp > /dev/null <<'EOF'
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQGNBGPazmABDAC6qc2st6/Uh/5AL325OB5+Z1XMFM2HhQNjB/VcYbLvcCx9AXsU
eaEmNPm6OY3p5+j8omjpXPYSU7DUQ0lIutuAtwkDMROH7uH/r9IY7iu88S6w3q89
bgbnqhu4mrSik2RNH2NqEiJkylz5rwj4F387y+UGH3aXIGryr+Lux9WxfqoRRX7J
WCf6KOaduLSp9lF4qdpAb4/Z5yExXtQRA9HULSJZqNVhfhWInTkVPw+vUo/P9AYv
mJVv6HRNlTb4HCnl6AZGcAYv66J7iWukavmYKxuIbdn4gBJwE0shU9SaP70dh/LT
WqIUuGRZBVH/LCuVGzglGYDh2iiOvR7YRMKf26/9xlR0SpeU/B1g6tRu3p+7OgjA
vJFws+bGSPed07asam3mRZ0Y9QLCXMouWhQZQpx7Or1pUl5Wljhe2W84MfW+Ph6T
yUm/j0yRlZJ750rGfDKA5gKIlTUXr+nTvsK3nnRiHGH2zwrC1BkPG8K6MLRluU/J
ChgZo72AOpVNq9MAEQEAAbQ5U2FsdCBQcm9qZWN0IFBhY2thZ2luZyA8c2FsdHBy
b2plY3QtcGFja2FnaW5nQHZtd2FyZS5jb20+iQHSBBMBCAA8FiEEEIV//dP5Hq5X
eiHWZMu8gXPXaz8FAmPazmACGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheA
AAoJEGTLvIFz12s/yf0L/jyP/LfduA4DwpjKX9Vpk26tgis9Q0I54UerpD5ibpTA
krzZxK1yFOPddcOjo+Xqg+I8aA+0nJkf+vsfnRgcpLs2qHZkikwZbPduZwkNUHX7
6YPSXTwyFlzhaRycwPtvBPLFjfmjjjTi/aH4V/frfxfjH/wFvH/xiaiFsYbP3aAP
sJNTLh3im480ugQ7P54ukdte2QHKsjJ3z4tkjnu1ogc1+ZLCSZVDxfR4gLfE6GsN
YFNd+LF7+NtAeJRuJceXIisj8mTQYg+esTF9QtWovdg7vHVPz8mmcsrG9shGr+G9
iwwtCig+hAGtXFAuODRMur9QfPlP6FhJw0FX/36iJ2p6APZB0EGqn7LJ91EyOnWv
iRimLLvlGFiVB9Xxw1TxnQMNj9jmB1CA4oNqlromO/AA0ryh13TpcIo5gbn6Jcdc
fD4Rbj5k+2HhJTkQ78GpZ0q95P08XD2dlaM2QxxKQGqADJOdV2VgjB2NDXURkInq
6pdkcaRgAKme8b+xjCcVjLkBjQRj2s5gAQwAxmgflHInM8oKQnsXezG5etLmaUsS
EkV5jjQFCShNn9zJEF/PWJk5Df/mbODj02wyc749dSJbRlTY3LgGz1AeywOsM1oQ
XkhfRZZqMwqvfx8IkEPjMvGIv/UI9pqqg/TY7OiYLEDahYXHJDKmlnmCBlnU96cL
yh7a/xY3ZC20/JwbFVAFzD4biWOrAm1YPpdKbqCPclpvRP9N6nb6hxvKKmDo7MqS
uANZMaoqhvnGazt9n435GQkYRvtqmqmOvt8I4oCzV0Y39HfbCHhhy64HSIowKYE7
YWIujJcfoIDQqq2378T631BxLEUPaoSOV4B8gk/Jbf3KVu4LNqJive7chR8F1C2k
eeAKpaf2CSAe7OrbAfWysHRZ060bSJzRk3COEACk/UURY+RlIwh+LQxEKb1YQueS
YGjxIjV1X7ScyOvam5CmqOd4do9psOS7MHcQNeUbhnjm0TyGT9DF8ELoE0NSYa+J
PvDGHo51M33s31RUO4TtJnU5xSRb2sOKzIuBABEBAAGJAbYEGAEIACAWIQQQhX/9
0/kerld6IdZky7yBc9drPwUCY9rOYAIbDAAKCRBky7yBc9drP8ctC/9wGi01cBAW
BPEKEnfrKdvlsaLeRxotriupDqGSWxqVxBVd+n0Xs0zPB/kuZFTkHOHpbAWkhPr+
hP+RJemxCKMCo7kT2FXVR1OYej8Vh+aYWZ5lw6dJGtgo3Ebib2VSKdasmIOI2CY/
03G46jv05qK3fP6phz+RaX+9hHgh1XW9kKbdkX5lM9RQSZOof3/67IN8w+euy61O
UhNcrsDKrp0kZxw3S+b/02oP1qADXHz2BUerkCZa4RVK1pM0UfRUooOHiEdUxKKM
DE501hwQsMH7WuvlIR8Oc2UGkEtzgukhmhpQPSsVPg54y9US+LkpztM+yq+zRu33
gAfssli0MvSmkbcTDD22PGbgPMseyYxfw7vuwmjdqvi9Z4jdln2gyZ6sSZdgUMYW
PGEjZDoMzsZx9Zx6SO9XCS7XgYHVc8/B2LGSxj+rpZ6lBbywH88lNnrm/SpQB74U
4QVLffuw76FanTH6advqdWIqtlWPoAQcEkKf5CdmfT2ei2wX1QLatTs=
=ZKPF
-----END PGP PUBLIC KEY BLOCK-----
EOF
sudo tee /etc/apt/sources.list.d/salt.sources > /dev/null <<'EOF'
X-Repolib-Name: Salt Project
Description: Salt has many possible uses, including configuration management.
  Built on Python, Salt is an event-driven automation tool and framework to deploy,
  configure, and manage complex IT systems. Use Salt to automate common
  infrastructure administration tasks and ensure that all the components of your
  infrastructure are operating in a consistent desired state.
  - Website: https://saltproject.io
  - Public key: https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public
Enabled: yes
Types: deb
URIs: https://packages.broadcom.com/artifactory/saltproject-deb
Signed-By: /etc/apt/keyrings/salt-archive-keyring.pgp
Suites: stable
Components: main
EOF
echo "SALT finished. Salt dependencies installed"
SALT

$mon = <<'MON'
echo "Initializing MON"
sudo apt-get update
sudo apt-get -qy install salt-minion
echo "master: 192.168.33.100" > /etc/salt/minion
sudo systemctl enable salt-minion --now
sudo systemctl restart salt-minion
echo "Burger filling added. Added to accompany Ketchup at 192.168.33.100"
echo "MON finished"
MON

$trainer = <<'TRAINER'
echo "Initializing TRAINER"
sudo apt-get update
sudo apt-get -qy install salt-master
echo "auto_accept: True" | sudo tee -a /etc/salt/master
sudo systemctl enable salt-master --now
sudo systemctl restart salt-master
echo "Ketchup ready to become Burger"
echo "TRAINER finished"
TRAINER

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  # Salt Master - Ketchup
  config.vm.define "ketchup", primary: true do |ketchup|
    ketchup.vm.provision :shell, inline: "#{$salt}\n#{$trainer}"
    ketchup.vm.network "private_network", ip: "192.168.33.100"
    ketchup.vm.hostname = "ketchup"
  end

  # Mon 1 - Lettuce
  config.vm.define "lettuce" do |lettuce|
    lettuce.vm.provision :shell, inline: "#{$salt}\n#{$mon}"
    lettuce.vm.network "private_network", ip: "192.168.33.101"
    lettuce.vm.hostname = "lettuce"
  end

  # Mon 2 - Tomato
  config.vm.define "tomato" do |tomato|
    tomato.vm.provision :shell, inline: "#{$salt}\n#{$mon}"
    tomato.vm.network "private_network", ip: "192.168.33.102"
    tomato.vm.hostname = "tomato"
  end

  # Mon 3 - Mustard
  config.vm.define "mustard" do |mustard|
    mustard.vm.provision :shell, inline: "#{$salt}\n#{$mon}"
    mustard.vm.network "private_network", ip: "192.168.33.103"
    mustard.vm.hostname = "mustard"
  end
end
```

Muokkasin testiympäristöä varten [h4](https://github.com/gianglex/Courses/blob/main/Palvelinten-Hallinta/h4-pkg-file-service.md):ssa luomaani apachen salt state tiedostoa, jotta se toimisi ilman ylimääräisiä tiedostoja.  
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
