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

## Debianin asennus VirtualBoxiin

Aloitin lataamalla uusimman Debian version (https://cdimage.debian.org/debian-cd/current-live/amd64/iso-hybrid/). Versioksi valikoitui '<em>debian-live-12.9.0-amd64-xfce.iso</em>'

Lisäsin VirtualBoxiin uuden koneen valitsemalla ylävalikosta '<em>Machine</em>' ja '<em>New</em>'

![k1](https://github.com/user-attachments/assets/c5750b3f-219d-4598-8825-7f29e40c6b7f)

Valitsemani asetukset asennuksessani: 
Name: Debian01
Type: Linux
Subtype: Debian
Version: Debian (64bit)
Base memory: 4096MB
Processors 4 CPU
Harddisk: 50,00 GB
En muuttanut Uninstalled Install -asetuksia 

![k2](https://github.com/user-attachments/assets/730a77be-92ea-4f07-9255-83482b4c1fa2)
![k3](https://github.com/user-attachments/assets/42c5f047-e7cb-42be-8462-6fb0cfd02258)
![k4](https://github.com/user-attachments/assets/3e52a92b-a74e-4444-906a-b8623a50933f)
![k5](https://github.com/user-attachments/assets/e4cc2499-632f-4ef4-aa2f-8f21a415763d)
![k6](https://github.com/user-attachments/assets/2e4f158e-3e95-4321-85d3-d8d967340106)

## Virtuaalikoneen käynnistys, Debianin Live ja testaus

Käynnistin virtuaalikoneen painamalla '<em>Start</em>'

Virtuaalikoneen käynnistyessä virtuaalikoneeseen tuli teksti '<em>No bootable medium found!</em>' sekä ponnahdusikkuna '<em>The virtual machine failed to boot...</em>

![k7](https://github.com/user-attachments/assets/2f569720-b0bf-4df3-867b-34d425b22ece)

Valitsin ponnahdusikkunassani lataamani Debian -tiedoston ja valitsin '<em>Mount and Retry Boot</em>', jonka jälkeen pääsin Boot Menuun ja valitsin '<em>Live system (amd64)</em>' päästäkseni testaamaan Linux versiotani. 

![k8](https://github.com/user-attachments/assets/cfa4119e-fa23-4604-a1a7-e66476852b0b)

![k9](https://github.com/user-attachments/assets/b2937d75-f3f0-4575-994f-b82a66eb4317)

Dokumentoitaessani asennusprosessia samanaikaisesti. Oli Linuxiin tullut kirjautumisikkuna, johon en tiennyt käyttäjätunnusta enkä salasanaa. 

![k10](https://github.com/user-attachments/assets/acabaf6f-b5ba-4167-8cef-0820f8d391c4)

Kokeiltuani muutamaa tyypillistä käyttäjätunnus ja salasana yhdistelmää (admin/admin, admin/password, user/password, user/user) käännyin hakemaan tietoa Googlen avulla ja vastaani tuli sivu, jossa oli mainittuna user/live (https://stackoverflow.com/questions/58885785/debian-10-install-what-is-default-account-and-password) millä pääsin takaisin työpöydälle. 

Jatkoin testaamalla virtuaalikoneen toimivuutta avaamalla selaimen ja menemällä sivulle '<em>terokarvinen.com</em>'

![k11](https://github.com/user-attachments/assets/1ee6aed6-f861-4a01-8259-0a8bc2adbc10)

Kun olin saanut testattua selaimen toimivuuden, suljin selaimen ja jatkoin Debianin asennukseen käynnistämällä työpöydältä '<em>Install Debian</em>'

## Debianin asennus virtuaalikoneelle

![k12](https://github.com/user-attachments/assets/baa93b31-0366-4d41-a11d-0153b7638c4d)

Valitsin asennukseeni alla olevat asetukset: 

Language: American English

Region: Europe / Zone: Helsinki

Keyboard Model: Generic 105-key PC / Finnish / Default

Erase disk / [  ] Encrypt system / Boot loader location: Master Boot Record

Name: Giang Le / username: giang / Computer name: VBOX-G / <em>salasanani</em>

![k13](https://github.com/user-attachments/assets/e0edfc6d-9550-4b30-aea6-b00f52b8a945)

![k14](https://github.com/user-attachments/assets/624c237a-ed65-4200-91bc-3f89bac8e7fe)

![k15](https://github.com/user-attachments/assets/98de257f-fa1d-4ed3-9870-58c960d3ec04)

![k16](https://github.com/user-attachments/assets/5b3adc8f-5100-459d-b4bf-8a67042c86d4)

![k17](https://github.com/user-attachments/assets/d862d243-e5ca-4365-b676-f47b4b380efb)

Lopuksi '<em>Summary</em>' -sivulta valitsin '<em>Install</em>'

![k18](https://github.com/user-attachments/assets/2b83e52c-98c2-42cc-af01-4ab5444b5008)

Asennuksen lopuksi käynnistin asennusvalikosta virtuaalikoneen uudelleen. Ja pääsin kirjautumisikkunaan

![k19](https://github.com/user-attachments/assets/d7b9bd05-1edf-4a81-8617-95d49c08de10)

Kirjauduttuani sisään pääsin asennetun Debianin työpöydälle. Testasin vielä virtuaalikoneen toiminnan käynnistämällä selaimen ja menemällä googlen kautta Debianin sivuille. 

![k20](https://github.com/user-attachments/assets/e49bcdad-1a82-405e-a8ec-f772ea504d1f)

![k21](https://github.com/user-attachments/assets/b44f41df-286c-40c9-9aa7-9d86a75263bb)



## Lähteet

Karvinen, T. 2006. Raportin kirjoittaminen. 
https://terokarvinen.com/2006/raportin-kirjoittaminen-4/
Käytetty raportin kirjoittamisesta -tehtävässä. 

Free Software Foundation, s.a. What is Free Software? 
https://www.gnu.org/philosophy/free-sw.html
Käyettty vapaan ohjelman neljästä vapaudesta -tehtävässä. 

Karvinen, T. 2024. Install Debian on Virtualbox. 
https://terokarvinen.com/2021/install-debian-on-virtualbox/
Käytetty Linuxin asennus virtuaalikoneeseen -tehtävässä
