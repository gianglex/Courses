# H7 - Maalisuora

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

## a) Hello world

Koska tiesin tehtävän vaativan uusien ohjelmien lataamista, aloitin päivittämällä pakettilistaukseni. 

```sudo apt-get update```

<img src="https://github.com/user-attachments/assets/eed0e5f4-3a30-41f4-b9ac-0e8cd4f54e27" width="500"> <br/>  

### Java

Koska en enää tässä vaiheessa muistanut java-ohjelman nimestä muuta kuin openjdk, aloitin hakemalla oikeaa ohjelmaa apt-cachesta. 

```apt-cache search openjdk```

<img src="https://github.com/user-attachments/assets/55930304-0be2-446b-9f7d-4eb9ee6735bb" width="500"> <br/>  

Tulleista vaihtoehdoista openjdk-17-jdk kuulosti tutuimmalta, joten asensin sen. 

```sudo apt-get install openjdk-17-jdk```

<img src="https://github.com/user-attachments/assets/7ba629a2-7b05-45df-998f-84b121b2b7e4" width="500"> <br/>  

Olinkin jo aiemmin asentanut sen virtuaalikoneelleni, joten Linux pyrki päivittämään ohjelman ja antoi sanoman ```openjdk-17-jdk is already the newest version (17.0.14+7-1~deb12u1)```

Aloitin ohjelman tekemisen luomalla uuden ```HelloWorld.java``` tiedoston, jonka sisään on tarkoituksena kirjoittaa ohjelma tulostamaan "Hello World". 

<img src="https://github.com/user-attachments/assets/2f41fb2e-dfe3-4eb1-bf5f-4c8741ce8215" width="500"> <br/>  

Tiedostoon kirjoitin yksinkertaisen koodin, jonka tarkoituksena on tulostaa ```Hello World```

```
public class HelloWorld {
	public static void main (String[] args) {
		System.out.println("Hello World");
	}
}
```

<img src="https://github.com/user-attachments/assets/97f777ac-549f-41bc-ad24-fb68a3c56f5e" width="500"> <br/>  


Tallennettuani tiedoston, loin siitä ```javac``` -komennolla .class tiedoston. 
```javac HelloWorld.java```

Kun .class tiedosto oli luotu, ajoin tiedostot ```java``` -komennolla.
```java HelloWorld```

Ajettuani ohjelman, tulosti ohjelma tekstin ```Hello World``` eli ohjelma toimi halutusti. 

<img src="https://github.com/user-attachments/assets/caf6fa4a-f898-4ec2-a56e-6504b4a42b8e" width="500"> <br/>  


### Python

Tiesin että Debian asennukseeni on integroitu jo valmiiksi python3, mutta tarkastin asian vielä varmuuden vuoksi pyytämällä sen versiotiedot 

```python3 --version```

<img src="https://github.com/user-attachments/assets/39a50e1e-edea-4ef9-82bd-bcfbae099711" width="500"> <br/>  

Tämän jälkeen loin HelloWorld.py -tiedoston. 

```micro HelloWorld.py```

Tiedostoon kirjoitin jälleen yksinkertaisen koodin, jonka tarkoituksena tulostaa Hello World. 

```print("Hello World")```

<img src="https://github.com/user-attachments/assets/0e1e028b-813d-45f5-8256-0cafbb4bb730" width="500"> <br/>  

Tämän jälkeen ajoin ohjelman ```python3``` -komennolla. 

```python3 HelloWorld.py```

Ohjelma tulosti jälleen terminaaliin tekstin Hello World, joten ohjelma toimi halutusti. 

<img src="https://github.com/user-attachments/assets/769f6bc3-9edf-4478-be54-087f7d7bafed" width="500"> <br/>  


### Lua

Valitsin kolmanneksi kieleksi Lua, mutta en tienny paketin tarkkaa nimeä joten lähdin hakemaan sitä ```apt-cache search``` -komennolla

```apt-cache search lua5```

<img src="https://github.com/user-attachments/assets/1444e964-637d-4181-91b8-920e9d0e8b5c" width="500"> <br/>  

Haku antoi todella monta tulosta, joten halusin tarkentaa vielä hakuani. En muistanut enää millä lisäkomennoilla sain tarkennettua hakuani, joten tarkastin komennon manuaalin. 

```man apt-cache```

Manuaalin perusteella päätin lisätä komentoon loppuun ```--names-only```

```apt-cache search lua5 --names-only```

Tuloksia tuli edelleen paljon, joten lähdin käymään niitä läpi hyödyntäenn ```less``` komentoa. 

```apt-cache search lua5 --names-only | less```

Löysin lopulta listasta haluamani paketin, joten asensin sen. 

<img src="https://github.com/user-attachments/assets/3e5bdd5b-8d19-4e3b-a368-7ee9bbb2e602" width="500"> <br/>  

```sudo apt-get install lua5.4```

<img src="https://github.com/user-attachments/assets/3a8ad78a-08d1-49e6-9d45-d0cee5f5a130" width="500"> <br/>  

Tämän jälkeen jälkeen loin taas tuttuun tapaan uuden tiedoston ```HelloWorld.lua```

```micro HelloWorld.lua```

Tiedostoon kirjoitin jälleen yksinkertaisen koodin, jonka tarkoituksena tulostaa Hello World. 

```print("Hello World")```

<img src="https://github.com/user-attachments/assets/6fa1bc9d-01ca-45ba-8ed8-2d11526b4fe8" width="500"> <br/>  

Ajoin lopuksi ohjelman lua -komennolla ja ohjelma tulosti jälleen ```Hello World```. 

<img src="https://github.com/user-attachments/assets/6b3d22d4-493a-4b88-afc9-e7f7f42ece96" width="500"> <br/>  

## c) Oman komento Linux

Aloitin komennon luonnin luomalla ensin tiedoston ```timenow```

```micro timenow```

Lisäsin alla olevan skriptin luomaani tiedostoon, joka kertoo tämänhetkisen päivämäärän ja kellonajan.  

```
#!/usr/bin/bash
echo Time is now:
date +"%d-%m-%y  %T"
```

Tallennettua tiedoston kokeilin, että kirjoittamani skripti toimii halutusti ```bash``` -komennolla. 

```bash timenow```

<img src="https://github.com/user-attachments/assets/ba4c4c3e-e559-4158-b371-0c088ddf3bf9" width="500"> <br/>  

Tämän jälkeen tarkastin komennolla ```ls -l``` komennolla luomani tiedoston oikeudet. 

```ls -l```

<img src="https://github.com/user-attachments/assets/cb9075f7-ea4e-4768-8a6a-7eaeebb8e27f" width="500"> <br/>  

Jotta muutkin käyttäjät pystyisivät käyttää komentoa, lisäsin tiedostolle ```chmod``` -komennolla execute oikeudet käyttäjäryhmille (user, group, others). 

```chmod ugo+x timenow```

Tämän jälkeen tarkastin vielä uudelleen tiedoston oikeudet. 

<img src="https://github.com/user-attachments/assets/bde1e8f2-51a1-40e1-bf5b-f8cfdeefc9a2" width="500"> <br/>  

Tämän jälkeen kopioin komennon /usr/bin/ kansioon, jotta komentoa voidaan käyttää pelkällä komennon nimellä. Sisällytin komentoon -v (verbose), jotta näen että tiedosto on kopioitunut. 

```sudo cp -v timenow /usr/local/bin/```

<img src="https://github.com/user-attachments/assets/aed8e95d-94a1-4812-ad6f-3ad294bebd52" width="500"> <br/>  

Lopuksi kokeilin ajaa uuden komentoni pelkällä ```timenow``` -komennolla. 

```timenow```

<img src="https://github.com/user-attachments/assets/46545455-a3f5-4521-82de-411093f6b002" width="500"> <br/>  

Komento palautti kellonajan, joten uusi komentoni toimii halutusti. 

Jotta pystyisin testaamaan komentoa toisella käyttäjällä, piti minun ensin luoda uusi käyttäjä ja vaihtaa toiselle käyttäjälle. 

```sudo adduser giangtest```

```su giangtest```

<img src="https://github.com/user-attachments/assets/e32625a6-19d6-4260-b0a4-f6cabbcdaccd" width="500"> <br/>  

Vaihdettuani käyttäjää, kokeilin uudella käyttäjällä ```timenow``` -komentoa. 

```timenow```

<img src="https://github.com/user-attachments/assets/e26ae842-3aa4-4647-8298-e7a73e31120b" width="500"> <br/>  

Toinen käyttäjä pystyi käyttämään komentoa, joten uusi komentoni toimi haluamallani tavalla myös muilla käyttäjillä. 



d) Ratkaise vanha arvioitava laboratorioharjoitus soveltuvin osin.


## Lähteet: 
Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.   
https://terokarvinen.com/linux-palvelimet/   
Tehtävänanto.   

Karvinen, T. 2018. Hello World Python3, Bash, C, C++, Go, Lua, Ruby, Java – Programming Languages on Ubuntu 18.04.    
https://terokarvinen.com/2018/hello-python3-bash-c-c-go-lua-ruby-java-programming-languages-on-ubuntu-18-04/    
Tehtävä a.    

Snapshooter. s.a. How to Create and Manage User on Linux    
https://snapshooter.com/learn/linux/create-and-manage-users   
Tehtävä c.    
