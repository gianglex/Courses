# H2 - Soitto kotiin

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

## a) Hello Vagrant! Osoita jollain komennolla, että Vagrant on asennettu (esim tulostaa vagrantin versionumeron). 

Olin aiemmin jo asentanut Vagrantin sekä VirtualBoxin tietokoneelleni. Todensin Vagrantin version vielä komennolla ```vagrant --version```


![a1](https://github.com/user-attachments/assets/45466285-c71a-4267-b223-57042a895fc7)


## b) Linux Vagrant. Tee Vagrantilla uusi Linux-virtuaalikone.

Aloitin ensin menemällä Command Promptissa polkuun ```C:\Vagrant\PH1``` 

```cd C:\Vagrant\PH1``` 

Tämän aloitin luomaan uutta Debian/Bookworm64 virtuaalikonetta Vagrantin avulla komennolla 

```vagrant init debian/bookworm64```

![b1](https://github.com/user-attachments/assets/126a2173-cd48-48fa-bda5-52edfcbda1d6)

Komento loi uuden Vagrantfile -konfigurointitiedoston tiedostopolkuun, jota muokkaamalla voi säätää vagrantin luomien virtuaalikoneiden määrää ja/tai tarkempia speksejä. 

Tässä tehtävässä sen muokkaaminen oli kuitenkin vielä tarpeetonta sillä tarkoituksena on vain luoda uusi virtuaalikone. 

Kun Vagrantfile oli luotuna, käytinn ```vagrant up``` -komentoa käynnistääkseni virtuaalikoneen luontiprosessin. Komento luo uudenn virtuaalikoneen Vagrantfile:n perusteella ja sen jälkeen käynnistää sen. 

```vagrant up```

![b2](https://github.com/user-attachments/assets/a6fa272e-848e-40b6-b106-401d3492f7d4)

Tämän jälkeen yhdistin vielä luotuun virtuaalikoneeseen komennolla ```vagrant ssh```. 

```vagrant ssh```

![b3](https://github.com/user-attachments/assets/29d97c52-5367-4c24-810a-abc9db71eeb8)

Kone yhdistyi onnistuneesti uudeen virtuaalikoneeseen. Ajoin lopuksi vielä muutaman komennon todentaakseni vielä mihin koneeseen olin yhdistettynä ja mikä IP sille oli asetettu. 

```whoami```

```hostname -I```

![b4](https://github.com/user-attachments/assets/4d860834-b0e2-4686-aa56-76d243849489)

Tämä jälkeen en enää tarvinnut konetta, joten poistuin ssh yhteydestä ```exit``` -komennolla ja poistin lopuksi vielä luodun (ja nyt tarpeettoman) virtuaalikoneen. 

```exit```

![b5](https://github.com/user-attachments/assets/bd740852-40b0-44a9-875c-63038ca1c60d)

```vagrant destroy```

![b6](https://github.com/user-attachments/assets/6636f553-3a9d-4df5-8111-213e0c843c6b)


## c) Linux verkko Vagrantilla

Muokkasin edellisessä tehtävässä luomaani Vagrantfileä luomaan useampan virtuaalikoneen. Päätin luoda suoraan tehtävässä vaadittavat verkkoyhteydet sekä Master-Minion linkitykset Vagrantfileen. 

```notepad Vagrantfile```

Komento avaa ```Vagrantfile```:n notepad:lle muokattavaksi. Loin alla olevan skriptin teron esimerkkien avulla 

```
# -*- mode: ruby -*-
# vi: set ft=ruby :


$pokemon = <<POKEMON
sudo apt-get update
sudo apt-get -qy install salt-minion
echo "master: 192.168.33.100" > /etc/salt/minion
sudo service salt-minion restart
echo "Pokedex entry created. Added to Ash's team at 192.168.33.100"
POKEMON

$trainer = <<TRAINER
sudo apt-get update
sudo apt-get -qy install salt-master
echo "Ash ready to become Pokemon Master"
TRAINER

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"  # Changed box to Debian Bookworm

  # Salt Master - Ash
  config.vm.define "Ash", primary: true do |ash|
    ash.vm.provision :shell, inline: $trainer
    ash.vm.network "private_network", ip: "192.168.33.100"
    ash.vm.hostname = "Ash"
  end

  # Pokemon 1 - Salaattimon (Bulbasaur)
  config.vm.define "Salaatti" do |salaatti|
    salaatti.vm.provision :shell, inline: $pokemon
    salaatti.vm.network "private_network", ip: "192.168.33.101"
    salaatti.vm.hostname = "Salaatti"
  end

  # Pokemon 2 - Charmander
  config.vm.define "Charmander" do |charmander|
    charmander.vm.provision :shell, inline: $pokemon
    charmander.vm.network "private_network", ip: "192.168.33.102"
    charmander.vm.hostname = "Charmander"
  end

  # Pokemon 3 - Squirtle
  config.vm.define "Squirtle" do |squirtle|
    squirtle.vm.provision :shell, inline: $pokemon
    squirtle.vm.network "private_network", ip: "192.168.33.103"
    squirtle.vm.hostname = "Squirtle"
  end
end
```

Yritin tämän jälkeen laittaa kokonaisuuden päälle 

```vagrant up```

Virtuaalikoneiden asentuessa huomasin ```Ash: E: Unable to locate package salt-master``` -viestin, joka olikin jo viime viikon tehtävistä tuttu. 

![c1](https://github.com/user-attachments/assets/67c4bc12-b517-4faa-bc82-df44bc3998b4)

Viestin perusteella ymmärsin, että Vagrantfilessa olevaa asennusskriptiä täytyy vielä hieman muokata. Arvelinkin jo skriptiä tehdessä, että viime viikolla vastaan tullut ongelma todennäköisesti toistuu jälleen. Tämä johtuu siis siitä ettei Debian/Bookwormin oletuspaketinhallintaan kuulu salt. 

Koska tiesin etteivät juuri käynnistämäni virtuaalikoneet kuitenkaan toimi halutusti ilman testaustakin, ajoin ne suoraan alas. 

```vagrant destroy -f``` (-f, jottei joka virtuaalikoneen poiston yhteydessä kysytä erikseen varmistusta)

![c2](https://github.com/user-attachments/assets/fe7dd52f-3fcb-4b37-b55f-7b82969210bc)

Tämän jälkeen lisäsin skriptiini vielä tarvittavat muutokset :

```
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
```

Vagrantfile v2: 

```
# -*- mode: ruby -*-
# vi: set ft=ruby :


$pokemon = <<POKEMON
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get -qy install salt-minion
echo "master: 192.168.33.100" > /etc/salt/minion
sudo service salt-minion restart
echo "Pokedex entry created. Added to Ash's team at 192.168.33.100"
POKEMON

$trainer = <<TRAINER
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get -qy install salt-master
echo "Ash ready to become Pokemon Master"
TRAINER

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"  # Changed box to Debian Bookworm

  # Salt Master - Ash
  config.vm.define "Ash", primary: true do |ash|
    ash.vm.provision :shell, inline: $trainer
    ash.vm.network "private_network", ip: "192.168.33.100"
    ash.vm.hostname = "Ash"
  end

  # Pokemon 1 - Salaattimon (Bulbasaur)
  config.vm.define "Salaatti" do |salaatti|
    salaatti.vm.provision :shell, inline: $pokemon
    salaatti.vm.network "private_network", ip: "192.168.33.101"
    salaatti.vm.hostname = "Salaatti"
  end

  # Pokemon 2 - Charmander
  config.vm.define "Charmander" do |charmander|
    charmander.vm.provision :shell, inline: $pokemon
    charmander.vm.network "private_network", ip: "192.168.33.102"
    charmander.vm.hostname = "Charmander"
  end

  # Pokemon 3 - Squirtle
  config.vm.define "Squirtle" do |squirtle|
    squirtle.vm.provision :shell, inline: $pokemon
    squirtle.vm.network "private_network", ip: "192.168.33.103"
    squirtle.vm.hostname = "Squirtle"
  end
end
```

Lisäsin nämä sekä trainer (master) ja pokemon (minion) skriptien ensimmäiseksi, jottei tarvitse ajaa kahta kertaa ```sudo apt-get update``` -komentoa. 

Ajoin jälleen uudelleen virtuaalikoneet päälle. 

```vagrant up```

Pian sainkin näytölle alla oleva viestin. 

```
Ash: /tmp/vagrant-shell: line 2: curl: command not found
Ash: /tmp/vagrant-shell: line 3: curl: command not found
```

![c3](https://github.com/user-attachments/assets/f9069cf5-8989-4438-9c03-9fb50b2fc8d9)


Tämä siis tarkoittaa, ettei tässä ollut valmiiksi asennettuna curlia joten aiemmin lisäämäni ```curl``` -komennot eivät voineet tietenkään mennä läpi. 
Ei auta siis muu kuin lisätä skripti asentamaan curl ennen niiden käyttöä. 

Tuhosin jälleen virtuaalikoneet. 

```vagrant destroy -f```

Tällä kertaa lisäsin skriptien alkuun. Tämän iteroinnin yhteyteen joudun lisäämään toisen ```sudo apt-get update```, jotta curlin asennuksessa käytetään uusinta versiota. 

```
sudo apt-get update
sudo apt-get -qy install curl
```

Vagrantfile v3: 

```
# -*- mode: ruby -*-
# vi: set ft=ruby :


$pokemon = <<POKEMON
sudo apt-get update
sudo apt-get -qy install curl
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get -qy install salt-minion
echo "master: 192.168.33.100" > /etc/salt/minion
sudo service salt-minion restart
echo "Pokedex entry created. Added to Ash's team at 192.168.33.100"
POKEMON

$trainer = <<TRAINER
sudo apt-get update
sudo apt-get -qy install curl
mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources
sudo apt-get update
sudo apt-get -qy install salt-master
echo "Ash ready to become Pokemon Master"
TRAINER

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"  # Changed box to Debian Bookworm

  # Salt Master - Ash
  config.vm.define "Ash", primary: true do |ash|
    ash.vm.provision :shell, inline: $trainer
    ash.vm.network "private_network", ip: "192.168.33.100"
    ash.vm.hostname = "Ash"
  end

  # Pokemon 1 - Salaattimon (Bulbasaur)
  config.vm.define "Salaatti" do |salaatti|
    salaatti.vm.provision :shell, inline: $pokemon
    salaatti.vm.network "private_network", ip: "192.168.33.101"
    salaatti.vm.hostname = "Salaatti"
  end

  # Pokemon 2 - Charmander
  config.vm.define "Charmander" do |charmander|
    charmander.vm.provision :shell, inline: $pokemon
    charmander.vm.network "private_network", ip: "192.168.33.102"
    charmander.vm.hostname = "Charmander"
  end

  # Pokemon 3 - Squirtle
  config.vm.define "Squirtle" do |squirtle|
    squirtle.vm.provision :shell, inline: $pokemon
    squirtle.vm.network "private_network", ip: "192.168.33.103"
    squirtle.vm.hostname = "Squirtle"
  end
end
```

Lähdin taas kokeilemaan uutta versiotani Vagrantfilestä: 

```vagrant up```

Virtuaalikoneet näyttivät tällä kertaa nyt ainakin päällepäin pyörähtävän käyntiin ilman odottamattomia ilmoituksia. 

Yhdistin ensin Ash:iin (master). 

```vagrant ssh Ash```

Tämän jälkeen loin yksinkertaisen loopin, ettei minun tarvitse jokaista konetta pingata yksitellen testatakseni kaikkia vaan voin ajaa saman loopin jokaisella koneella. 

```
for ip in 192.168.33.100 192.168.33.101 192.168.33.102 192.168.33.103; do
  ping -c 2 "$ip"
done
```

```exit```

![c4](https://github.com/user-attachments/assets/77b15ccf-6d89-4e71-b74f-9793bee4021d)


Kun tämä onnistui odotetusti, poistuin yhdeydestä ```exit```-komennolla ja toistin saman testin muilla virtuaalikoneilla. 



```vagrant ssh Salaatti```

```
for ip in 192.168.33.100 192.168.33.101 192.168.33.102 192.168.33.103; do
  ping -c 2 "$ip"
done
```

```exit```

![c5](https://github.com/user-attachments/assets/e18a50c7-be49-4f43-b383-3f9b04129aaa)


```vagrant ssh Charmander```

```
for ip in 192.168.33.100 192.168.33.101 192.168.33.102 192.168.33.103; do
  ping -c 2 "$ip"
done
```

```exit```

![c6](https://github.com/user-attachments/assets/b14ad70b-4580-4cb4-a6d5-272a0c8ff91f)


```vagrant ssh Squirtle```

```
for ip in 192.168.33.100 192.168.33.101 192.168.33.102 192.168.33.103; do
  ping -c 2 "$ip"
done
```

```exit```

![c7](https://github.com/user-attachments/assets/13a93c1d-cb5e-4f2b-b74f-685504daa70b)

## d) Herra-orja verkossa

Kun olin testannut, että kaikki koneet saavat pingattua toisiansa (ja lisäksi itseänsä). Kirjauduin takaisinn masteriin (Ash), jotta voin hyväksyä Minion-avaimet. Nämä minioneihin nämä asetettiin jo Vagrantfilen alustuksessa, joten ei tarvinnut enää erikseen käydä jokaiselle minion-koneelle käydä näitä asettamassa. 

Jos kuitenkin haluaisi niin tehdä niin sen voisi alla olevasti: 

```vagrant ssh Minion01```

```sudoedit /etc/salt/minion```

```
master:10.0.0.1 #masterin IP-osoite
id: Minion01 #minionin tunniste
```

Eli siis seuraavaksi tavoitteeni yhdistää masteriin (Ash) ja hyväksyä Minioneiden avaimet. 

```vagrant ssh Ash``` - masteriin yhdistäminen

```sudo salt-key -A``` - avainten hyväksyntä

Kuitenkin käyttäessäni komentoa ```sudo salt-key -A```, sain vastaukseksi ```The key glob '*' does not match any unaccepted keys.```. En ollut täysin varma miksei näitä löytynyt, joten lähdin selvittämään vikaa listaamalla ensin avaimet jos vaikka jostain kumman syystä nämä olivatkin jo hyväksyttyinä. 

```sudo salt-key -L``` - avainten listaus

```
Accepted Keys:
Denied Keys:
Unaccepted Keys:
Rejected Keys:
```

Avaimia ei löytynyt, joten pohdiskelin voisiko johtua vaan siitä että koneet olivat olleet taustalla käynnissä jo jonkin aikaa. Päätin sammuttaa ja käynnistää koneet uudelleen, josko sillä ratkeaisi ongelma. 

```vagrant halt```

```vagrant up```

Koneen käynnistyttyä uudelleen, yhdistin jälleen masteriin (Ash) ja yritin hyväksyä avaimet. 

```vagrant ssh Ash```

```sudo salt-key -A```

```y```

Avaimet löytyvätkin tällä kertaa ja hyväksyin ne. 

![d2](https://github.com/user-attachments/assets/1fe3d586-977b-4149-9944-e55371de8aae)

Lopuksi kokeilin vielä 

```sudo salt '*' test.ping```

![d3](https://github.com/user-attachments/assets/f7bc44c8-dd71-4a01-887d-b0653ecb40a7)


## e) Kokeile vähintään kahta tilaa verkon yli (viisikosta: pkg, file, service, user, cmd)

Kokeilin lopuksi vielä muutamaa komentoa testatakseni tilojen toimivuutta. 

```sudo salt '*' cmd.run 'whoami'```

![ee1](https://github.com/user-attachments/assets/76ddb663-4db8-4874-a0c7-126ab03f17f5)

```sudo salt '*' service.status salt-minion```

![ee2](https://github.com/user-attachments/assets/5a5d004d-bb4d-45e1-a958-a4f21a37ad62)

```sudo salt '*' state.single pkg.installed curl```

![ee3](https://github.com/user-attachments/assets/30238c51-9a9c-464d-b880-2515dfb4917d)

## init.sls

Lähdin vielä lopuksi kokeilemaan infraa koodina. Aloitin luomalla ```init.sls``` tiedoston polkuun ```/srv/salt/oma/```

```cd /srv/```

```sudo mkdir salt```

```cd salt```

```sudo mkdir oma```

```cd oma```

```sudoedit init.sls```

Lisäsin alla olevan sisällön, joka tarkastaa että salt-minion on päällä sekä että curl, bash-completion ja tree ovat asennettuina. 

```
salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: true
    - start: true

install-curl:
  pkg.installed:
    - name: curl

install-bash-completion:
  pkg.installed:
    - name: bash-completion

install-tree:
  pkg.installed:
    - name: tree
```

Lopuksi ajoin luomani tilan. 

```sudo salt '*' state.apply oma```

![f1](https://github.com/user-attachments/assets/b31079ad-cb70-4ec4-9db1-6f8207d9a3fc)


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

