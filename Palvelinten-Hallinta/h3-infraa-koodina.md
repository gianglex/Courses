# h3 Infraa koodina

## x) Lue ja tiivistä.
- ```/srv/salt/``` on kansio, joka jaetaan kaikille orjille.
- Init.sls tiedosto luodaan esimerkiksi ```/srv/salt/hello/``` -kansioon
- Komennolla ```sudo salt-call --local state.apply hello``` voidaan ajaa ```/srv/salt/hello/init.sls``` -tiedoston komennot
- Oletuskieli saltilla on YAML.
- YAML perussääntöjä:
   - Data on strukturoitu ```key: value``` -pareina.
   - Kaikki key:t ja ominaisuudet ovat merkkikokoriippuvaisia.
   - Tabulaattori on kielletty, vain välilyönnit käyvät.
   - Kommentit alkavat #-merkillä
- YAML on organisoitu blokkirakenteeseen.
- Sisennykset asettavat kontekstin, joten ominaisuudet ja listat pitää sisentää.
- Kaksi välilyöntiä on standardi. 

## Vagrantfilen päivitys 

Aloitin poistamalla viime kerralla luomani virtuaalikoneet, joita en vielä poistanut viime käytön jälkeen. 

<img src="https://github.com/user-attachments/assets/b32fb984-aed7-48e0-841b-d71a9b978020" width="500"> <br/>

Tämän jälkeen muokkasin viimeksi tekemääni Vagrantfileä annettujen vinkkien pohjalta: 

- Relevantit komennot muutettu ```systemctl``` -komennoiksi. Esim. ```sudo systemctl enable salt-master --now```
- Muutettu ```salt-archive-keyring.pgp``` ja ```salt.sources``` ```heredoc``` -komentoon verkosta lataamisen sijasta. 
- ```curl``` asennus poistettu, sillä aiempi muutos poisti tarpeen ```curl``` -komennolle
- Lisätty automaattinen minioneiden hyväksyntä masteriin ```echo "auto_accept: True" | sudo tee -a /etc/salt/master```
- Nimet muokattu tekijänoikeusystävällisemmiksi. 

Muokattu Vagrantfile:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

$mon = <<'MON'
mkdir -p /etc/apt/keyrings
sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp > /dev/null <<'EOF'
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
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
sudo apt-get update
sudo apt-get -qy install salt-minion
echo "master: 192.168.33.100" > /etc/salt/minion
sudo systemctl enable salt-minion --now
sudo systemctl restart salt-minion
echo "Burger filling added. Added to accompany Ketchup at 192.168.33.100"
MON

$trainer = <<'TRAINER'
mkdir -p /etc/apt/keyrings
sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp > /dev/null <<'EOF'
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
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
sudo apt-get update
sudo apt-get -qy install salt-master
echo "auto_accept: True" | sudo tee -a /etc/salt/master
sudo systemctl enable salt-master --now
sudo systemctl restart salt-master
echo "Ketchup ready to become Burger"
TRAINER

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"  # Changed box to Debian Bookworm

  # Salt Master - Ketchup
  config.vm.define "ketchup", primary: true do |ketchup|
    ketchup.vm.provision :shell, inline: $trainer
    ketchup.vm.network "private_network", ip: "192.168.33.100"
    ketchup.vm.hostname = "ketchup"
  end

  # Mon 1 - Lettuce
  config.vm.define "lettuce" do |lettuce|
    lettuce.vm.provision :shell, inline: $mon
    lettuce.vm.network "private_network", ip: "192.168.33.101"
    lettuce.vm.hostname = "lettuce"
  end

  # Mon 2 - Tomato
  config.vm.define "tomato" do |tomato|
    tomato.vm.provision :shell, inline: $mon
    tomato.vm.network "private_network", ip: "192.168.33.102"
    tomato.vm.hostname = "tomato"
  end

  # Mon 3 - Mustard
  config.vm.define "mustard" do |mustard|
    mustard.vm.provision :shell, inline: $mon
    mustard.vm.network "private_network", ip: "192.168.33.103"
    mustard.vm.hostname = "mustard"
  end
end
```

Vagrantfilen sisällä toistuvat saltin asennukseen tarvittavien ```salt-archive-keyring.pgp``` ja ```salt.sources``` -tiedostojen luontilitanjat tekevät tiedoston lukemisesta liian sekavaa, joten yhdistin niiden luonnin omaan skriptiinsä. 
Tämä ei tässä tiedostossa vielä haittaisi, mutta mikäli luotavia konetyyppejä olisi enemmän kuin kaksi (trainer ja mon) niin toisto olisi liian sekavaa luettavaksi. 

Muutokset: 

- Eriytetty saltin dependenssiens (```salt-archive-keyring.pgp``` ja ```salt.sources```) luonti omaksi ```$salt``` -skriptiksi.
- Lisätty luotu ```$salt``` -skripti ajettavaksi ennen ```$mon``` tai ```$trainer``` -skriptejä. 
- Lisätty muutamia statusviestejä väliin skriptin seuraamisen helpottamiseksi. 

Lopullinen Vagrantfile:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

$salt = <<'SALT'
echo "Initializing SALT to install salt dependencies"
mkdir -p /etc/apt/keyrings
sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp > /dev/null <<'EOF'
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
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

Aloitin virtuaalikoneiden luonnin tämän jälkeen ja tarkastin vielä, että avaimet masteriin tulivat automaattisesti hyväksytyiksi. 

```vagrant up```

```vagrant ssh ketchup```

```sudo salt-key -L```

<img src="https://github.com/user-attachments/assets/33fc9587-6894-4d2d-82e6-3c39be8bcc79" width="500"> <br/>

Koneet näyttäisivät asentuneen halutulla tavalla ja avaimet tulivat automaattisesti hyväksytyksi. 

Käytin Vagrantfilen muokkaamiseen hyödyksi mm. : 
- [Hashicorp / Vagrant / Shell Provisioner v2.4.3](https://developer.hashicorp.com/vagrant/docs/provisioning/shell)
- [Wikipedia / Here Document](https://en.wikipedia.org/wiki/Here_document)
- [The Linux Documentation Project / Here Documents](https://tldp.org/LDP/abs/html/here-docs.html)

## a) Hei infrakoodi! Kokeile paikallisesti (esim 'sudo salt-call --local') infraa koodina. Kirjota sls-tiedosto, joka tekee esimerkkitiedoston /tmp/ -kansioon.

Jatkoin tehtäviin jo kirjautuneena masteriin (ketchup). 

Sillä kyseiseen tuoreeseen virtuaalikoneeseen ei oltu vielä asennettu salt-minionia, aloitin asentamalla sen. Tämän pitäisi toimia suoraan sillä salt-dependenssit ovat jo asennettuna valmiiksi (ks. Vagrantfile). 

Tein jo edellisen tehtävän aikana init.sls tiedoston (ks. [gianglex/h2-soitto-kotiin](https://github.com/gianglex/Courses/blob/main/Palvelinten-Hallinta/h2-soitto-kotiin.md#initsls)), joten seurasin samaa kaavaa tälläkin kertaa. 

```sudo apt-get install salt-minion```

```sudo mkdir /srv/salt/```

```sudo mkdir /srv/salt/examplefile/```

```sudoedit /srv/salt/examplefile/init.sls```

Init.sls

```
create_example_file:
  file.managed:
    - name: /tmp/example
    - contents: example content
```

<img src="https://github.com/user-attachments/assets/b8ad3ae9-f82c-415c-8b73-0b71cc30d7d4" width="500"> <br/>

Sitten tarkastin ensin, ettei tiedostoa ole olemassa. 

```cat /tmp/example```

<img src="https://github.com/user-attachments/assets/ecefd87f-51d2-48dc-b1a7-38bac96fd0d5" width="500"> <br/>

```sudo salt-call --local state.apply examplefile```

<img src="https://github.com/user-attachments/assets/7eb59ce4-7c85-4c84-b8bd-d98e9a7e8332" width="500"> <br/>

Lopuksi vielä tarkastin, että tiedosto oli nyt luotuna. 

```cat /tmp/example```

<img src="https://github.com/user-attachments/assets/b8fbaf1b-b606-401d-aae6-62ebc8856702" width="500"> <br/>

Komento oli odotetusti luonut tiedoston. 

## b) Aja esimerkki sls-tiedostosi verkon yli orjalla.

Päätin ajaa komennon ```lettuce``` -minionilla. 

Ketchup: ```sudo salt 'lettuce' state.apply examplefile```

<img src="https://github.com/user-attachments/assets/42ea5423-8ed9-4489-b387-98319d79a0c0" width="500"> <br/>

Tämän jälkeen kävin tarkastamassa eri ikkunalla onko tiedosto luotuna. 

Lettuce: ```vagrant ssh lettuce```

Lettuce: ```cat /tmp/example```

<img src="https://github.com/user-attachments/assets/3b95b5b8-1caa-40bc-8b15-86d49d6c722d" width="500"> <br/>

Tiedosto löytyi minionin päästä, joten päätin lopuksi ajaa vielä masterilla komennon uudelleen kaikille minioneille

Ketchup: ```sudo salt '*' state.apply examplefile```

<img src="https://github.com/user-attachments/assets/ece4d416-8957-49f3-a9b0-2d1002bc32b5" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/3de077c5-71b4-4d7a-a386-f4fcc790b3d2" width="500"> <br/>

Homma rullasi odotetusta ja muistakin koneista löytyi haluttu tiedosto. 

## c) Tee sls-tiedosto, joka käyttää vähintään kahta eri tilafunktiota näistä: package, file, service, user. Tarkista eri ohjelmalla, että lopputulos on oikea. Osoita useammalla ajolla, että sls-tiedostosi on idempotentti.

Palasin masterille (Ketchup) luomaan uutta .sls tiedostoa tehtävää varten (Salt documentaatio: [salt.states.file](https://docs.saltproject.io/en/3006/ref/states/all/salt.states.file.html), [salt.states.user](https://docs.saltproject.io/en/3006/ref/states/all/salt.states.user.html), [salt.states.pkg](https://docs.saltproject.io/en/3006/ref/states/all/salt.states.pkg.html)): 

Ketchup: ```sudo mkdir /srv/salt/yessir```

Ketchup: ```sudoedit /srv/salt/yessir/init.sls```

```
install_curl:
  pkg.installed:
    - name: curl

create_example_user:
  user.present:
    - name: exampleuser
    - shell: /bin/bash
    - home: /home/exampleuser
    - createhome: True

create_example_file:
  file.managed:
    - name: /tmp/captainsorders
    - contents: |
        Yes sir!
```

<img src="https://github.com/user-attachments/assets/0a06030a-2984-4c02-952e-6bb65b2c40b9" width="500"> <br/>

Tämän jälkeen ajoin jälleen luodun ```init.sls``` tiedoston. 

Ketchup: ```sudo salt 'lettuce' state.apply yessir```

<img src="https://github.com/user-attachments/assets/c4cec276-d490-4594-b2f9-cc093b1f78cf" width="500"> <br/>

Komento näytti onnistuneen odotetusti, mutta kävin vielä tarkastamassa. 

Lettuce: ```curl google.com```

<img src="https://github.com/user-attachments/assets/6bb515d5-00bd-45f1-aa26-4186b24f57f4" width="500"> <br/>

Lettuce: ```ls -la /home/exampleuser/```

<img src="https://github.com/user-attachments/assets/916f2c1d-eb15-40bf-bab6-153f5fcbf1f3" width="500"> <br/>

Lettuce: ```cat /tmp/captainsorders```

<img src="https://github.com/user-attachments/assets/e03b3764-0f81-4a8b-9563-acb545c8cee0" width="500"> <br/>

Kaikki näyttivät menneen init.sls tiedoston mukaisesti. 

Palasin vielä masterille (Ketchup) ajamaan saman komennon muutaman kerran todetakseni, että tiedosto on idempotentti. 

Ketchup: ```sudo salt 'lettuce' state.apply yessir```

Ketchup: ```sudo salt 'lettuce' state.apply yessir```

<img src="https://github.com/user-attachments/assets/f0ffe1ad-5398-4680-8118-9488baa62d8f" width="500"> <br/>



## Ajankäyttö 
Aikaa kului: 
- Tiivistelmään ~30min
- Vagrantfile informaation haku, päivitys ja dokumentaatio ~2h
- Varsinaiseen tekemiseen ~30min
- Dokumentointiin ja raportointiin ~1h


## Lähteet: 
Karvinen, T. 2025. Palvelinten Hallinta.   
https://terokarvinen.com/palvelinten-hallinta/   
Tehtävänanto.   

Karvinen, T. 2024. Hello Salt Infra-as-Code.    
https://terokarvinen.com/2024/hello-salt-infra-as-code/    
Tehtävä x.    

Salt Project. s.a. Rules of YAML.    
https://docs.saltproject.io/salt/user-guide/en/latest/topics/overview.html#rules-of-yaml    
Tehtävä x.    

Hashicorp. s.a. Shell Provisioner v2.4.3.    
https://developer.hashicorp.com/vagrant/docs/provisioning/shell    
Vagrantfile.    

Wikipedia. s.a. Here document.    
https://en.wikipedia.org/wiki/Here_document    
Vagrantfile.    

The Linux Documentation Project. s.a. Here Documents.    
https://tldp.org/LDP/abs/html/here-docs.html    
Vagrantfile.    

Salt Project. s.a. How Do I Use Salt States?    
https://docs.saltproject.io/en/3006/topics/tutorials/starting_states.html    
Tehtävä a-c.    

Salt Project. s.a. salt.states.file    
https://docs.saltproject.io/en/3006/ref/states/all/salt.states.file.html    
Tehtävä a-c.    

Salt Project. s.a. salt.states.user    
https://docs.saltproject.io/en/3006/ref/states/all/salt.states.user.html    
Tehtävä a-c.    

Salt Project. s.a. salt.states.pkg    
https://docs.saltproject.io/en/3006/ref/states/all/salt.states.pkg.html    
Tehtävä a-c.    
