# H6 - Salataampa

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

- Let's Encryptin ja ACME-protokollan tavoite on mahdollistaa HTTPS käyttöönotto automatisoimalla sertifikaatin hankinnan
- ```lego``` komentoa käytettäessä ```--http``` -option käyttäminen olemassaolevalle palvelimelle vaatii lisäksi ```http.webroot``` -option käyttöä 
- SSL-konfiguraatio vaatii vähintään alla olevat direktiivit: 

```
LoadModule ssl_module modules/mod_ssl.so

Listen 443
<VirtualHost *:443>
    ServerName www.example.com
    SSLEngine on
    SSLCertificateFile "/path/to/www.example.com.cert"
    SSLCertificateKeyFile "/path/to/www.example.com.key"
</VirtualHost>
  ```

## a) Let's Encrypt TLS Sertifikaatti

### Alkutoimet

Aloitin jälleen kirjautumalla palvelimelleni. 

```ssh giang@giangle.fi```

Tämän jälkeen käynnistin apachen vielä uudelleen varmistaakseni, jotta kaikki tekemäni aiemmin tekemäni muutokset ovat aktiivisena ja sivusto toimii kuten sen pitääkin. 

```sudo systemctl restart apache```

Käytettyäni ylläolevaa komentoa, sain virheilmoituksen:

```Failed to restart apache.service: Unit apache.service not found. ```

Virheilmoituksen saatuani tajusin tarkastaa antamani komennon uudelleen, ja siitä puuttuikin lopusta yksi kirjain (2). 

```sudo systemctl restart apache2```

![a1](https://github.com/user-attachments/assets/56aba661-21d8-4fb7-81dd-1c44fed3d7c4)

Apachen uudelleenkäynnistyksen jälkeen tarkastin vielä, että verkkosivuni toimii oletetusti menemällä selaimella sivulleni giangle.fi. Varmistin vielä, että sivu ei käytä välimuistissa olevaa sivua päivittämällä sivun uudelleen pikanäppäimellä CTRL + Shift + R

![a2](https://github.com/user-attachments/assets/33ce1d4f-ac7a-4001-b278-e47de9a7bb82)

### 



## Lähteet: 
Karvinen, T. 2025. Linux Palvelimet 2025 alkukevät.   
https://terokarvinen.com/linux-palvelimet/   
Tehtävänanto.   

Let's Encrypt. How it works.    
https://letsencrypt.org/how-it-works/   
Tehtävä x.    

GitHub/LEGO. Obtain a certificate.    
https://go-acme.github.io/lego/usage/cli/obtain-a-certificate/index.html#using-an-existing-running-web-server    
Tehtävä x. 

Apache HTTP server project. s.a. SSL/TLS Strong Encryption: How-To.    
https://httpd.apache.org/docs/2.4/ssl/ssl_howto.html#configexample   
Tehtävä x. 

