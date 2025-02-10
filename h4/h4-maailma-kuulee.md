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


### OpenSSH-Clientin asennus & SSH avainparin luonti

Asensin ensin OpenSSH:n komennolla ```sudo apt-get install openssh-client```

<img src="https://github.com/user-attachments/assets/958cca52-61fa-46e9-9b20-088e6f0b2388" width="500"> <br/>


Tämän jälkeen loin avainparin komennolla ```ssh-keygen```

<img src="https://github.com/user-attachments/assets/5099c04e-78b5-4c7b-b29d-f754e4bf0930" width="500"> <br/>

Luomani avainparin julkista avainta pääsin tarkastelemaan komennolla ```cat ~/.ssh/id_rsa.pub```

<img src="https://github.com/user-attachments/assets/d3c239de-db36-4704-95ab-730ddee45164" width="500"> <br/>


## b) Virtuaalipalvelimen alkutoimet


## c) Webpalvelimen asennus virtuaalipalvelimelle

