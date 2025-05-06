# H4 RFID

## a) Evilginx2 

### Asenus

Aloitin asenuksen tarkastamalla että minulla on virtuaalikoneella dependenssit asennettuna. 

```go version```

![a1](https://github.com/user-attachments/assets/623e3880-3a14-4a3b-846d-efc0a9733f96)

```git --version```

![a2](https://github.com/user-attachments/assets/00023a35-b6e9-4537-be04-85ae520df4fd)

```make --version```

![a3](https://github.com/user-attachments/assets/a8913a6a-f1ab-460b-9c38-d938deada35a)

```gcc --version```

![a4](https://github.com/user-attachments/assets/7f58aec9-c11a-4a0a-ab62-0547e4d1f21a)

Tämän jälkeen kloonassin [evilginx repon](https://github.com/kgretzky/evilginx2)

```git clone https://github.com/kgretzky/evilginx3.git```

![a5](https://github.com/user-attachments/assets/b20659b8-0bed-4ec8-bc28-bb70961218a7)

Siirryin kloonatun repon kansioon ja kompilasin evilginx:n.

```cd evilginx2```

```make```

![a6](https://github.com/user-attachments/assets/b1e28e5c-96bb-46e1-a1fe-a1455037f696)

Siirryin ```build``` -kansioon ja käynnistin evilginxin. 

```cd build```

```sudo ./evilginx```

<img src="https://github.com/user-attachments/assets/a278a7b9-5055-43ce-8676-627ad4bf7069" width="500"> <br/>

### Evilginx konfiguraatio

Tämän jälkeen halusin konfiguroida evilginxin lokaalille MITM hyökkäykselle. Aloitin lisäämällä ```/etc/hosts``` -tiedostoon feikkidomainia varten ohjauksen

```echo "127.0.0.1   local.example.com" | sudo tee -a /etc/hosts```

Tämän jälkeen loin kansion sertifikaatille ja loin sertifikaatin. Sertifikaatin luonnissa täytin vain common name kohtaan halutun domainin nimen

```mkdir certificates```

```cd certificates```

```openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 365 -nodes```

Asetin evilginxille phislettien sijainnin. 

```sudo ./evilginx -p /home/tunkt/evilginx2/phishlets```

En saanut evilginxiä tästä vaiheesta enää konfiguroitua pidemmälle. Ymmärtääkseni repossa on vain evilginx3, joka ei tue natiivisti lokaalia ajoa. 


b) Mininet SYN flood

Aloitin luomalla mininet topologian. 

```sudo mn --topo single,2 --mac --switch ovsk --controller remote```

![c1](https://github.com/user-attachments/assets/7431e6ed-c984-4413-8b4f-051032e93446)

Tarkastin sen jälkeen vielä luodun verkon. 

```nodes```

![c2](https://github.com/user-attachments/assets/a1899bad-3a90-4b40-be63-d432d18ff8a0)

Lopuksi laukaisin SYN flood hyökkäykssen h1:ltä h2:lle. 

```h1 bash```

```hping3 -S --flood -p 80 10.0.0.2```

![c3](https://github.com/user-attachments/assets/2704b9d1-806f-4f0b-a616-04d657dab441)

Lopetin hyökkäyksen lopuksi CTRL+C:llä. 



## Lähteet
Iso-Anttila, L. 2025. Haaga-Helia Moodle. Verkkoon tunkeutuminen ja tiedustelu - ICI013AS3A-3001 / 5. Laboratorio- ja simulaatioympäristöt hyökkäyksissä
https://hhmoodle.haaga-helia.fi/course/view.php?id=42566&section=1#tabs-tree-start    
Tehtävänanto.    

GitHub. s.a. Evilginx 3.0.    
https://github.com/kgretzky/evilginx2    
Tehtävä 1.    

Mininet Walkthrough. s.a. Mininet Walkthrough.     
https://mininet.org/walkthrough/    
Tehtävä 2.    
