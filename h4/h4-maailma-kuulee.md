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


Palvelimeni sijainniksi valitsin Frankfurtin, sillä se oli vaihtoehdoista minua maantieteellisesti lähimpänä EU:n sisällä oleva vaihtoehto. 


Käyttöjärjestelmäksi valikoitui Debian 12 x64. 

Virtuaalipalvelimen prosessoriksi valitsin halvimman mahdollisen: Jaettu CPU, 1 CPU / 512MB RAM / 10GB SSD. Kurssin tarpeisiin tämän pitäisi olla riittävä. 

Lisäpalveluna myytävää levytilaa ja varmuuskopiointivaihtoehdon jätin tilaamatta. 

Lopuksi valitsin vielä autetikointivaihtoehdoksi SSH-avaimen salasanan sijasta. 




## b) Virtuaalipalvelimen alkutoimet


## c) Webpalvelimen asennus virtuaalipalvelimelle

