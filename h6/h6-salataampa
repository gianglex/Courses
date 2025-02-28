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
