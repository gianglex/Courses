# H1 - Linux Virtuaalikoneen luonti VirtualBoxilla

## Huomioita raportin kirjoittamisesta

- Toistettavuus
- Täsmällisyys
- Helppolukuisuus
- Lähdeviittaus

## Free Software Foundation - Vapaan ohjelman (free software) neljä vapautta

Vapaus käyttää ohjelmaa vapaasti haluamaansa tarkoitukseen. 

Vapaus tutkia miten ohjelma toimii sekä muokata sitä haluamallaan tavalla. 

Vapaus levittää ohjelmaa muiden auttamista varten. 

Vapaus levittää sinun muokkaamaa versiota ohjelmasta muille. 

## Linuxin asennus virtuaalikoneeseen

### Päälaitteen tiedot

Windows 11 Home, 23H2  
AMD 7950X, alikellotettu  
32GB DDR5 @6000Mhz  
RTX3080, alikellotettu  
Kotiverkossa

### Debianin asennus VirtualBoxiin

Aloitin lataamalla uusimman Debian version (https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/). Versioksi valikoitui '<em>debian-live-12.9.0-amd64-xfce.iso</em>'

Lisäsin VirtualBoxiin uuden koneen valitsemalla ylävalikosta '<em>Machine</em>' ja '<em>New</em>'

<img src="https://github.com/user-attachments/assets/c5750b3f-219d-4598-8825-7f29e40c6b7f" width="300">

Valitsemani asetukset asennuksessani: 

Name: Debian01  
Type: Linux  
Subtype: Debian  
Version: Debian (64bit)  
Base memory: 4096MB  
Processors 4 CPU  
Harddisk: 50,00 GB  
En muuttanut Unattended Install -asetuksia 

<img src="https://github.com/user-attachments/assets/730a77be-92ea-4f07-9255-83482b4c1fa2" width="500">  <br/>
<img src="https://github.com/user-attachments/assets/42c5f047-e7cb-42be-8462-6fb0cfd02258" width="500">  <br/>
<img src="https://github.com/user-attachments/assets/3e52a92b-a74e-4444-906a-b8623a50933f" width="500">  <br/>
<img src="https://github.com/user-attachments/assets/e4cc2499-632f-4ef4-aa2f-8f21a415763d" width="500">  <br/>
<img src="https://github.com/user-attachments/assets/2e4f158e-3e95-4321-85d3-d8d967340106" width="500">  <br/>
  

### Virtuaalikoneen käynnistys, Debian Live ja testaus

Käynnistin virtuaalikoneen painamalla '<em>Start</em>'

Virtuaalikoneen käynnistyessä virtuaalikoneeseen tuli teksti '<em>No bootable medium found!</em>' sekä ponnahdusikkuna '<em>The virtual machine failed to boot...</em>'

<img src="https://github.com/user-attachments/assets/2f569720-b0bf-4df3-867b-34d425b22ece" width="500"> <br/>

Valitsin ponnahdusikkunassani lataamani Debian -tiedoston ja valitsin '<em>Mount and Retry Boot</em>', jonka jälkeen pääsin Boot Menuun ja valitsin '<em>Live system (amd64)</em>' päästäkseni testaamaan Linux versiotani. 

<img src="https://github.com/user-attachments/assets/cfa4119e-fa23-4604-a1a7-e66476852b0b" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/b2937d75-f3f0-4575-994f-b82a66eb4317" width="500"> <br/>

Dokumentoitaessani asennusprosessia samanaikaisesti. Oli Linuxiin tullut kirjautumisikkuna, johon en tiennyt käyttäjätunnusta enkä salasanaa. 

<img src="https://github.com/user-attachments/assets/acabaf6f-b5ba-4167-8cef-0820f8d391c4" width="500"> <br/>

Kokeiltuani muutamaa tyypillistä käyttäjätunnus ja salasana yhdistelmää (admin/admin, admin/password, user/password, user/user) käännyin hakemaan tietoa Googlen avulla ja vastaani tuli sivu, jossa oli mainittuna user/live (https://stackoverflow.com/questions/58885785/debian-10-install-what-is-default-account-and-password) millä pääsin takaisin työpöydälle. 

Jatkoin testaamalla virtuaalikoneen toimivuutta avaamalla selaimen ja menemällä sivulle '<em>terokarvinen.com</em>'

<img src="https://github.com/user-attachments/assets/1ee6aed6-f861-4a01-8259-0a8bc2adbc10" width="500"> <br/>

Kun olin saanut testattua selaimen toimivuuden, suljin selaimen ja jatkoin Debianin asennukseen käynnistämällä työpöydältä '<em>Install Debian</em>'

### Debianin asennus ja testaus

<img src="https://github.com/user-attachments/assets/baa93b31-0366-4d41-a11d-0153b7638c4d" width="500"> <br/>

Valitsin asennukseeni alla olevat asetukset: 

Language: American English  
Region: Europe / Zone: Helsinki  
Keyboard Model: Generic 105-key PC / Finnish / Default  
Erase disk / [  ] Encrypt system / Boot loader location: Master Boot Record  
Name: Giang Le / username: giang / Computer name: VBOX-G / <em>salasanani</em>


<img src="https://github.com/user-attachments/assets/e0edfc6d-9550-4b30-aea6-b00f52b8a945" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/624c237a-ed65-4200-91bc-3f89bac8e7fe" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/98de257f-fa1d-4ed3-9870-58c960d3ec04" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/5b3adc8f-5100-459d-b4bf-8a67042c86d4" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/d862d243-e5ca-4365-b676-f47b4b380efb" width="500"> <br/>

Lopuksi '<em>Summary</em>' -sivulta valitsin '<em>Install</em>'

<img src="https://github.com/user-attachments/assets/2b83e52c-98c2-42cc-af01-4ab5444b5008" width="500"> <br/>

Asennuksen lopuksi käynnistin asennusvalikosta virtuaalikoneen uudelleen. Ja pääsin kirjautumisikkunaan

<img src="https://github.com/user-attachments/assets/d7b9bd05-1edf-4a81-8617-95d49c08de10" width="500"> <br/>

Kirjauduttuani sisään pääsin asennetun Debianin työpöydälle. Testasin vielä virtuaalikoneen toimintaa käynnistämällä selaimen ja menemällä googlen kautta Debianin sivuille. 

<img src="https://github.com/user-attachments/assets/e49bcdad-1a82-405e-a8ec-f772ea504d1f" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/b44f41df-286c-40c9-9aa7-9d86a75263bb" width="500"> <br/>

### Päivitysten ja palomuurin asennus

Tämän jälkeen avasin terminaalin ja päivitin package-listan komennolla ```sudo apt-get update```

<img src="https://github.com/user-attachments/assets/12d66ea5-3d28-4eaf-a6cf-2059190cbf66" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/b5f23569-c790-4805-8020-7bcc3d305c6e" width="500"> <br/>

Tämän jälkeen päivitin ohjelmat komennolla ```sudo apt-get -y dist-upgrade```

<img src="https://github.com/user-attachments/assets/d929bce6-9367-4385-a6ea-e134e68c8254" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/b6c6126a-b775-4629-bb71-b4d9ca088e9e" width="500"> <br/>

Jatkoin asentamalla palomuurin komennolla ```apt-get -y install ufw```

<img src="https://github.com/user-attachments/assets/c6f54428-b75f-4c2a-85a6-06808e50964e" width="500"> <br/>

Kun komento ei toiminut halutulla tavalla, tarkastin uudelleen antamani komennon. Antamani komento ei toiminut, sillä komennon alusta puuttui ```sudo ``` joten yritin uudelleen komennolla ```sudo apt-get -y install ufw```

<img src="https://github.com/user-attachments/assets/09d18954-9ece-45a7-abf4-65b66abb2322" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/e6c07b9a-8626-4c40-b7eb-4d2bda331e3c" width="500"> <br/>

Tämän jälkeen laitoin palomuurin vielä päälle komennolla ```sudo ufw enable```

<img src="https://github.com/user-attachments/assets/694da6ca-e710-471a-a8e2-ebc6f1fbd5be" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/92ac4a8e-68d1-4718-990a-8f16777161d8" width="500"> <br/>

Palomuurin käynnistyksen jälkeen suljin terminaalin ja tein lopuksi uudelleenkäynnistyksen valitsemalla ensin '<em>Applications</em>' -valikon -> '<em>Log Out</em>' -> '<em>Restart</em>'

<img src="https://github.com/user-attachments/assets/bd881514-9fab-4851-876e-c95f448a30b7" width="500"> <br/>

<img src="https://github.com/user-attachments/assets/7fe4b7c9-1452-4b9e-ae84-54138b6552b6" width="500"> <br/>


### Levytilan tarkastaminen terminaalista

Voit tarkastaa Linuxilla nykyisen levytilan ja sen käytön käynnistämällä terminaalin ja kirjoittamalla terminaaliin ```df -h```

<img src="https://github.com/user-attachments/assets/4ee5fe9a-9491-4cdd-8683-9f416fc5ca7d" width="500"> <br/>

### Internetyhteyedn testaaminen ping-komennolla terminaalista

Voit testata Linuxilla internet yhteyttäsi yrittämällä yhdistää google.com:iin. Avaa terminaali ja kirjoita terminaaliin ```ping -c 4 google.com```

<img src="https://github.com/user-attachments/assets/d6f8d1d5-140b-4d02-b48a-9e3ff06f8381" width="500"> <br/>

## Muita huomioita

Kokonaisuudessaan asennusprosessi alkoi 17.01.2025 kello 17:30 ja päättyi samana päivänä kello 19:00. Dokumentointi tapahtui sekä asennuksen aikana että sen jälkeen. Dokumentoinnissa käytetty hyödyksi githubin dokumentaatiota. 

## Lähteet

Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.  
https://terokarvinen.com/linux-palvelimet/  
Tehtävänanto   

Karvinen, T. 2006. Raportin kirjoittaminen.   
https://terokarvinen.com/2006/raportin-kirjoittaminen-4/  
Käytetty raportin kirjoittamisesta -tehtävässä.   

Free Software Foundation, s.a. What is Free Software?   
https://www.gnu.org/philosophy/free-sw.html  
Käyettty vapaan ohjelman neljästä vapaudesta -tehtävässä.   

Karvinen, T. 2024. Install Debian on Virtualbox.   
https://terokarvinen.com/2021/install-debian-on-virtualbox/  
Käytetty Linuxin asennus virtuaalikoneeseen -tehtävässä  

Stackoverlow. 2019. Debian 10 install what is default account and password?.   
https://stackoverflow.com/questions/58885785/debian-10-install-what-is-default-account-and-password  
Käytetty Linuxin asennus virtuaalikoneeseen -tehtävässä  

GitHub. s.a. Quickstart for writing on GitHub.  
https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/quickstart-for-writing-on-github  
Käytetty dokumentaatiossa. 
