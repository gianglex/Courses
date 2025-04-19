# h4 Pkg-file-service

## x) Lue ja tiivistä.
- Voit hallita suurta määrää daemoneita CMS:llä (Configuration management system)
- Package-file-service:llä voit säädellä mm.:
  - ohjelman asennusta
  - konfiguraatiotiedoston korvaamista
  - daemonin uudelleenkäynnistä uuden konfiguraation käyttöönottamiseksi
- Esimerkiksi ssh voidaan konfiguroida ```init.sls``` -tiedoston avulla avaamaan tietty portti. 

## a) Apache easy mode. Asenna Apache, korvaa sen testisivu ja varmista, että demoni käynnistyy.

Aloitin jälleen poistamalla olemassaolevat virtuaalikoneet ja luomalla uudet tilalle. 

```vagrant destroy```

<img src="https://github.com/user-attachments/assets/94a60329-577c-41ac-a6ed-edf845bfb09c" width="500"> <br/>

Käytän tässä jälleen aiemmin luomaani vagrantfileä virtuaalikoneiden pohjana: 

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

```vagrant up```

Virtuaalikoneet näyttäyvät käynnistyneen onnistuneesti. Tarkastin kuitenkin vielä tarkastamalla ketchupilla (Master), että minionit ovat lähettäneet avainpyynnöt ja ne ovat onnistuneesti hyväksyttyjä. 

```vagrant ssh ketchup```

```sudo salt-key -L```

<img src="https://github.com/user-attachments/assets/24df7f0c-2a9c-4b5d-a071-b2a01710008d" width="500"> <br/>

Lopuksi vielä toinen tarkastus, että komennot menevät läpi. 

```salt '*' cmd.run 'whoami'```

<img src="https://github.com/user-attachments/assets/618720c0-1420-4129-8fc0-d845e129693a" width="500"> <br/>

Kaikki näyttäisivät ainakin päällepäin olevan kunnossa. 

Aloitan asentamalla curlin, sillä aion testata sillä verkkosivujen toimivuutta. 

```sudo apt-get install -y curl```

Alkuun tietysti tarkastetaan taikurin hihat. 

```curl localhost```

<img src="https://github.com/user-attachments/assets/f0274549-b7b6-460e-8717-4ab289890102" width="500"> <br/>

Curl ei yhdistä localhostille, sillä apache ei ole asennettuna. Seuraavaksi siis asensin apache:n, korvasin oletussivun, asetin sen käynnistymään koneen uudelleen käynnistyessä ja käynnistin sen. [Virkistin hieman Apache2 muistiani aiemmalla kurssilla tehdyllä raportillani. ](https://github.com/gianglex/Courses/blob/main/Linux-Palvelimet/h3-hello-web-server.md)

```sudo apt-get install -y apache2```

```echo "Korvattu 19.04.2025"|sudo tee /var/www/html/index.html```

```sudo systemctl enable apache2 --now```

Lopuksi vielä kokeilin, että aloitussivu on korvattu. 

```curl localhost```

<img src="https://github.com/user-attachments/assets/252aa858-0795-42b8-bcaa-bc531e512489" width="500"> <br/>

Tämä toimiikin odotetusti. Tästä siis voidaan päätellä kutakuinkin .sls tiedostolle vaadittavat toiminnot. 

```sudo apt-get install -y curl``` --> pkg.installed

```sudo apt-get install -y apache2``` --> pkg.installed

```echo "Korvattu 19.04.2025"|sudo tee /var/www/html/index.html``` --> file.managed

```sudo systemctl enable apache2 --now``` --> service.running

Tästä muodostinkin lopullisen .sls tiedoston. 

```sudo mkdir /srv/salt/```

```sudo mkdir /srv/salt/apache2```

```sudoedit /srv/salt/apache2/init.sls```

```
curl:
  pkg.installed

apache2:
  pkg.installed

apache2_service:
  service.running:
    - name: apache2
    - enable: True

index_html:
  file.managed:
    - name: /var/www/html/index.html
    - contents: |
        Korvattu 19.04.2025
```

.sls tiedoston muodostettuani ajoin sen minioneilla. 

```sudo salt '*' state.apply apache2```

<img src="https://github.com/user-attachments/assets/6a5e7bdc-04ef-46b8-9cfa-719eafe21fe2" width="500"> <br/>

Jostain syystä komennon ajaminen kahdelle koneista, mutta kolmatta ajaessa salt meni jostain syystä jumiin. Käynnistin virtuaalikoneet uudelleen korjatakseni ongelman. 

```exit```

```vagrant halt```

```vagrant up```

```sudo salt '*' state.apply apache2```

<img src="https://github.com/user-attachments/assets/f1cdb763-fe17-4219-9d3d-b815d58b76db" width="500"> <br/>

Kaikki näyttäisivät asentuneen jo edellisellä käskyllä, pienestä yskimisestä huolimatta. 

```sudo salt '*' cmd.run 'curl localhost'```

<img src="https://github.com/user-attachments/assets/f7114434-54de-46f6-a06a-29d07f6d12de" width="500"> <br/>

Luomani .sls tiedosto näyttäisi asentaneen kaikille virtuaalikoneille apache2:n, muokanneen oletussivun sekä käynnistäneen apache2:n onnistuneesti. 

Kokeilin vielä lopuksi yhdellä koneista erikseen varmistuakseni toiminnan. 

```vagrant ssh lettuce```

```curl localhost```

<img src="https://github.com/user-attachments/assets/4e0ffa77-7103-4794-89e5-a8a6b6540d3c" width="500"> <br/>

## b) SSHouto. Lisää uusi portti, jossa SSHd kuuntelee.

Testasin alkuun, että portilla 8888 ei saa yhteyttä minionilla. 

```ssh -p 8888 vagrant@192.168.33.101```

<img src="https://github.com/user-attachments/assets/93494dab-0c98-4eab-b73e-ebe9a8bbc671" width="500"> <br/>

Sillä yhteydestä kieltäydyttiin, totesin että portti oli pois käytöstä. Tämän jälkeen tarkastelin mitkä asetukset ovat aktiivisena masterissa ja sen jälkeen muokkasin sshd:n konffitiedostoa sen perusteella. 

```grep -vE '^\s*#|^\s*$' /etc/ssh/sshd_config```

<img src="https://github.com/user-attachments/assets/1d6b8125-e581-4ca3-bd7a-c9884b6e9951" width="500"> <br/>

```
Include /etc/ssh/sshd_config.d/*.conf
PasswordAuthentication no
KbdInteractiveAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
ClientAliveInterval 120
UseDNS no
```

Lisäsin tämän jälkeen #Port 22 tilalle vain haluamani portit, eli portin 22 ja 8888. 

```sudoedit /etc/ssh/sshd_config```

```
# Lines omitted for brevity
Port 22
Port 8888
# Lines omitted for brevity
```

```grep -vE '^\s*#|^\s*$' /etc/ssh/sshd_config```

<img src="https://github.com/user-attachments/assets/f0ab4246-3739-4db1-bccc-a9729fd54125" width="500"> <br/>

```
Include /etc/ssh/sshd_config.d/*.conf
Port 22
Port 8888
PasswordAuthentication no
KbdInteractiveAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
ClientAliveInterval 120
UseDNS no
```

Käynnistin lopuksi vielä sshd:n uudelleen. 

```sudo systemctl status sshd```

Tämän jälkeen lähdin luomaan sshd:lle omaa .sls tiedostoa. 

```sudo mkdir /srv/salt/sshd```

```sudoedit /srv/salt/sshd/init.sls```

```
openssh-server:
  pkg.installed

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://sshd/sshd_config

sshd:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config
```

Lopuksi kopioidaan vielä masterilta sshd:n konffitiedosto /srv/salt/sshd/ -kansioon, jotta se voidaan jakaa minioneille. 

```sudo cp /etc/ssh/sshd_config /srv/salt/sshd/sshd_config```

Lopuksi ajoin luodun tilan minioneilla.  

```sudo salt '*' state.apply sshd```

<img src="https://github.com/user-attachments/assets/41a559f2-cf5b-4396-951b-dcaf18af8bfb" width="500"> <br/>

Komento näyttäisi tehneen haluama muutokset. Seuraavaksi vielä tarkastan yksittäiseltä virtuaalikoneelta muutokset. 

```vagrant ssh lettuce```

```grep -vE '^\s*#|^\s*$' /etc/ssh/sshd_config```

<img src="https://github.com/user-attachments/assets/1aeefe00-30bd-4cce-93d4-120e04185144" width="500"> <br/>

Muutokset olivat siis onnistuneesti tulleet läpi. 

Viimeiseksi kokeilin vielä yhteyttä portin 8888 avulla. 

```ssh -p 8888 vagrant@192.168.33.101```

<img src="https://github.com/user-attachments/assets/b9a6b913-f6e0-4f20-98ad-7e04be9e6e9b" width="500"> <br/>

Vaikka avaimesta kieltäydyttiinkin, muodostui kuitenkin yhteys (toisin kuin alkutilanteessa) eli pystyin toteamaan portin olevan auki. 

## c) Vapaaehtoinen, haastavahko tässä vaiheessa: Asenna ja konfiguroi Apache ja Name Based Virtual Host. Sen tulee näyttää palvelimen etusivulla weppisivua. Weppisivun tulee olla muokattavissa käyttäjän oikeuksin, ilman sudoa.

a) tehtävässä oltiinkin asennettu jo apache, joten jatkoin siitä mihin jäätiin. Tarkoituksena saada nyt giangtesti.fi toimimaan, ensin masterilla sitten minioneilla. Käytin tässäkin hyödykseni [aiempaa raporttiani](https://github.com/gianglex/Courses/blob/main/Linux-Palvelimet/h3-hello-web-server.md). 

```curl giangtesti.fi```

<img src="https://github.com/user-attachments/assets/d4bd3bb7-2498-4cc3-84f6-30cc40ee851a" width="500"> <br/>

Hihat jälleen tyhjänä. Aletaan luomaan masterille esimerkkisivuja. 

```mkdir /home/vagrant/public-sites/```

```mkdir /home/vagrant/public-sites/giangtesti.fi```

Verkkosivun luonti:

```nano /home/vagrant/public-sites/giangtesti.fi/index.html```

```Testisivu 20.4.2025```

.conf tiedoston luonti: 

```sudoedit /etc/apache2/sites-available/giangtesti.fi.conf```

```
<VirtualHost *:80>
 ServerName giangtesti.fi
 ServerAlias www.giangtesti.fi
 DocumentRoot /home/vagrant/public-sites/giangtesti.fi
 <Directory /home/vagrant/public-sites/giangtesti.fi>
   Require all granted
 </Directory>
</VirtualHost>
```

Sivuston aktivointi ja apache2:n uudelleenkäynnistys. 

```sudo a2ensite giangtesti.fi```

```sudo systemctl restart apache2```

```hosts``` -tiedoston muokkaus yhteyden muodostusta varten. Lisätty giangtesti.fi:lle oma rivi. 

```sudoedit /etc/hosts```

```
127.0.0.1       localhost
127.0.0.2       bookworm
::1             localhost ip6-localhost ip6-loopback
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters

127.0.1.1 ketchup ketchup
127.0.0.1       giangtesti.fi
```

Lopuksi vielä testaus, että sivu toimii odotetusti. 

```curl giangtesti.fi```

<img src="https://github.com/user-attachments/assets/b8ad1928-0e1e-4cd2-8333-8554f077be16" width="500"> <br/>

Koonti vielä siitä mitä kaikkea huomioonotettavaa tehtiin: 

```/home/vagrant/public-sites/giangtesti.fi/index.html``` --> file.managed

```/etc/apache2/sites-available/giangtesti.fi.conf``` --> file.managed

```a2ensite giangtesti.fi``` --> cmd.run

```/etc/hosts``` --> file.managed

Sitten olemassaolevan .sls tiedoston muokkaukseen. 

```sudoedit /srv/salt/apache2/init.sls```

```
curl:
  pkg.installed

apache2:
  pkg.installed

apache2_service:
  service.running:
    - name: apache2
    - enable: True
    - watch:
      - file: /etc/apache2/sites-available/giangtesti.fi.conf

/etc/apache2/sites-available/giangtesti.fi.conf:
  file.managed:
    - source: salt://apache2/giangtesti.fi.conf
    - user: root
    - group: root
    - mode: '644'

giangtesti.fi-enabled:
  cmd.run:
    - name: a2ensite giangtesti.fi.conf
    - unless: "a2query -s giangtesti.fi"
    - require:
      - file: /etc/apache2/sites-available/giangtesti.fi.conf
    - watch_in:
      - service: apache2_service

/home/vagrant/public-sites:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/public-sites/giangtesti.fi:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/public-sites/giangtesti.fi/index.html:
  file.managed:
    - source: salt://apache2/index.html
    - user: vagrant
    - group: vagrant
    - mode: '755'

giangtesti.fi-hosts:
  file.append:
    - name: /etc/hosts
    - text: "127.0.0.1 giangtesti.fi"
```

Jouduin .sls tiedostoa muokatessani tarkastamaan luotujen kansioiden oikeudet ja [kääntämään ne numeraalisiksi](https://www2.math.uconn.edu/~vince/MathDoc/GSGuide/s1-navigating-chmodnum.html), sillä [salt ei tue symbolisia oikeusmerkintojä](https://github.com/saltstack/salt/discussions/67519). 

Käytännössä tarkastin ne ```ls -la``` -komennolla ja asetin vastaavat oikeudet init.sls tiedostoon. 

```
$ ls -la /home/vagrant/public-sites/
total 12
drwxr-xr-x 3 vagrant vagrant 4096 Apr 19 21:14 .
drwxr-xr-x 6 vagrant vagrant 4096 Apr 19 21:13 ..
drwxr-xr-x 2 vagrant vagrant 4096 Apr 19 21:15 giangtesti.fi
```

Lopuksi vielä piti kopioida tiedostot kansioon, jonka minionit näkevät: 

```sudo cp /home/vagrant/public-sites/giangtesti.fi/index.html /srv/salt/apache2/index.html```

```sudo cp /etc/apache2/sites-available/giangtesti.fi.conf /srv/salt/apache2/giangtesti.fi.conf```

Lopuksi vielä tarkastus, että kaikki tarvittavat tiedostot ovat kansiossa. 

```ls -la /srv/salt/apache2```

<img src="https://github.com/user-attachments/assets/58f3cbe6-5c81-4324-a458-80a56da0593e" width="500"> <br/>

Sitten lähdetään ajamaan muokattua ```init.sls``` -tiedostoa. 

```sudo salt '*' state.apply apache2```

Homma näytti menevän onnistuneesti maaliin. 

<img src="https://github.com/user-attachments/assets/1678a7e2-995b-4973-9a59-a2335f06b4f6" width="500"> <br/>

```sudo salt '*' cmd.run 'curl giangtesti.fi'```

<img src="https://github.com/user-attachments/assets/1cb395c1-0d6e-404c-8a1e-595cc8c7b637" width="500"> <br/>

Näyttäisi toimivan halutulla tavalla. Lopuksi todensin vielä, että sivua voi muokata ilman ```sudo``` -oikeuksia. 

```vagrant ssh lettuce```

```nano /home/vagrant/public-sites/giangtesti.fi/index.html```

```
Testisivu 20.4.2025
Ilman sudoa
```

```curl giangtesti.fi```

<img src="https://github.com/user-attachments/assets/98dae6e7-f330-4d92-9f0f-669fa13bad6b" width="500"> <br/>

## Ajankäyttö 
Aikaa kului: 
- Tiivistelmään ~15min
- Tehtävien tekemiseen ja tiedon hakemiseen ~3h
- Dokumentointiin ja raportointiin ~2h


## Lähteet: 
Karvinen, T. 2025. Palvelinten Hallinta.   
https://terokarvinen.com/palvelinten-hallinta/   
Tehtävänanto.   

Karvinen, T. 2018. Pkg-File-Service – Control Daemons with Salt – Change SSH Server Port.    
https://terokarvinen.com/2018/04/03/pkg-file-service-control-daemons-with-salt-change-ssh-server-port/    
Tehtävä x, a, c.    

Le, G. 2025. H3-Hello-Web-Server.    
https://github.com/gianglex/Courses/blob/main/Linux-Palvelimet/h3-hello-web-server.md    
Tehtävä a.    

GitHub. s.a. salt.states.file should support relative/symbolic modes.    
https://github.com/saltstack/salt/discussions/67519    
Tehtävä c.    

Red Hat Linux 7.1. s.a. Changing Permissions With Numbers.    
https://www2.math.uconn.edu/~vince/MathDoc/GSGuide/s1-navigating-chmodnum.html    
Tehtävä c.    

Salt Project. s.a. salt.states.file.    
https://docs.saltproject.io/en/3006/ref/states/all/salt.states.file.html    
Tehtävä c.    

Salt Project. s.a. salt.states.service.    
https://docs.saltproject.io/en/3006/ref/states/all/salt.states.service.html    
Tehtävä c.    

Salt Project. s.a. salt.states.cmd.    
https://docs.saltproject.io/en/3006/ref/states/all/salt.states.cmd.html 
Tehtävä c.    
