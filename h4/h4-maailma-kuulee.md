# H4 - Maailma kuulee

### Päälaitteen tiedot

Windows 11 Home, 23H2  
AMD 7950X, alikellotettu  
32GB DDR5 @6000Mhz  
RTX3080, alikellotettu  
Kotiverkossa

### Virtuaalikoneen tiedot

OS: Debian GNU/Linux 12 (bookworm) x86_64  
Host: VirtualBox 1.2  
Kernel: 6.1.0-30-amd64  
Shell: bash 5.2.15  
DE: Xfce 4.18  
Terminal: xfce4-terminal  
CPU: AMD Ryzen 9 7950X (8) @ 4.294GHz  
GPU: 00:02.0 VMware SVGA II Adapter  
Memory: 7941MiB  

## x) Lue & Tiivistä

- Virtuaalipalvelinten ja domainien tarjonta on kilpailtu ala.
- Palveluita voi ostaa monilta eri tarjoajilta (mm. Digital Ocean, Linode, Gandi)
- On tärkeää käyttää aina vahvoja salasanoja
- On tärkeää sulkea root ja päivittää ohjelmistot

## a) Virtuaalipalvelimen vuokraus
Valitsin palveluntarjoajakseni Digital Oceanin, jonka saa veloituksetta GitHub Education paketissa. 

Rekisteröinnin jälkeen aloitin luomaan uutta Droplettia. 

<img src="https://github.com/user-attachments/assets/bd40ffd4-15f4-4a47-ad7e-c3d0c59f2015" width="500"> <br/>


Palvelimeni sijainniksi valitsin Frankfurtin, sillä se oli vaihtoehdoista minua maantieteellisesti lähimpänä EU:n sisällä oleva vaihtoehto. 

<img src="https://github.com/user-attachments/assets/3e8d8aa4-78fa-43dc-90fa-94d4869dd980" width="500"> <br/>


Käyttöjärjestelmäksi valikoitui Debian 12 x64. 

<img src="https://github.com/user-attachments/assets/f8211cdf-81ad-4f50-86e0-6f42aa5b990f" width="500"> <br/>

Virtuaalipalvelimen prosessoriksi valitsin halvimman mahdollisen: Jaettu CPU, 1 CPU / 512MB RAM / 10GB SSD. Kurssin tarpeisiin tämän pitäisi olla riittävä. 

<img src="https://github.com/user-attachments/assets/0d900d63-17de-44e3-b872-2bcae3719dc4" width="500"> <br/>

Lisäpalveluna myytävää levytilaa ja varmuuskopiointivaihtoehdon jätin tilaamatta. 

<img src="https://github.com/user-attachments/assets/f4d8a9fa-5a8f-41e0-ab8f-bc92fbb85506" width="500"> <br/>

Lopuksi valitsin vielä autetikointivaihtoehdoksi SSH-avaimen salasanan sijasta ja valitsin SSH avaimeksi OpenSSH:lla luomani avaimen. 

<img src="https://github.com/user-attachments/assets/f1bf5450-08f0-4f03-b044-1445821dfb3f" width="500"> <br/>

Luotuani dropletin, näkyi se valmiina 

### OpenSSH-Clientin asennus & SSH avainparin luonti

Asensin ensin OpenSSH:n komennolla ```sudo apt-get install openssh-client```

<img src="https://github.com/user-attachments/assets/958cca52-61fa-46e9-9b20-088e6f0b2388" width="500"> <br/>


Tämän jälkeen loin avainparin komennolla ```ssh-keygen```

<img src="https://github.com/user-attachments/assets/5099c04e-78b5-4c7b-b29d-f754e4bf0930" width="500"> <br/>

Luomani avainparin julkista avainta pääsin tarkastelemaan komennolla ```cat ~/.ssh/id_rsa.pub```

<img src="https://github.com/user-attachments/assets/d3c239de-db36-4704-95ab-730ddee45164" width="500"> <br/>


## b) Virtuaalipalvelimen alkutoimet

### Uuden käyttäjän luonti ja SSH-yhteys uuteen käyttäjään

Aloitin ensin yhdistämällä virtuaalipalvelimelleni komennolla ```ssh root@164.92.200.216```
![b1](https://github.com/user-attachments/assets/551d4a45-ec8e-485a-bae1-ac47a5bc6a55)

Ensimmäisenä aloitin luomalla uuden käyttäjän komennolla ```sudo adduser giang```
![b2](https://github.com/user-attachments/assets/1ebebe4d-df03-4860-b368-faa64e054ef5)

Lisäsin tämän jälkeen vielä käyttäjän sudo-ryhmään ja adm-ryhmään komennolla ```sudo adduser giang sudo``` ja ```sudo adduser giang adm```
![b3](https://github.com/user-attachments/assets/01286afb-5309-4e6e-a520-d5eda7d193ec)

Tämän jälkeen ryhdyin testaamaan toimiiko luomani käyttäjä. Poistuin ensin SSH yhteydestä komennolla ```exit``` ja yhdistämällä tämän jälkeen uudella käyttäjälläni ```ssh giang@164.92.200.216```
![b4](https://github.com/user-attachments/assets/bd397096-a190-4afb-835f-8d23fa0ac0cf)

En päässyt yhdistämään luomalleni käyttäjälleni, sillä luomani käyttäjä ei tunnistanut SSH-avaintani. Otin jälleen yhteyden root:n avulla palvelimelleni, jotta saan kopioitua .ssh kansion uudelle käyttäjälleni. Käytin .ssh kansion kopioimiseen komentoa ```cp -n -r /root/.ssh /home/giang/```, joka kopioi .ssh kansion rootilta käyttäjän giang kotihakemistoon. 
![b5](https://github.com/user-attachments/assets/269ee547-a5bd-47c1-be11-ade2872416e6)

Navigoin seuraavaksi hakemistoon ```/home/giang/``` ja tarkastin vielä kopioidun kansion komennolla ```ls -al``` 
![b6](https://github.com/user-attachments/assets/4d040f1b-6633-4539-bcda-d396b15f9e22)


Kopioitu .ssh kansion omistaa edelleen root, joten muutin kansion omistajan komennolla ```chown giang.giang .ssh -R``` ja tarkastin uudelleen kansion omistajuuden komennolla ```ls -al``` 
![b7](https://github.com/user-attachments/assets/10cf8f2c-bc88-4125-aa55-8878dc898bcd)

Tämän jälkeen testasin jälleen yhdistämistä uudelle käyttäjälle ensin poistumalla komennolla ```exit``` ja yhdistämällä tämän jälkeen uudella käyttäjälläni ```ssh giang@164.92.200.216```
![b8](https://github.com/user-attachments/assets/e1f8b4cc-5953-4431-86ff-41ed138141e1)

## c) Webpalvelimen asennus virtuaalipalvelimelle

