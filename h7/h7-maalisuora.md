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


### Java

Koska en enää tässä vaiheessa muistanut java-ohjelman nimestä muuta kuin openjdk, aloitin hakemalla oikeaa ohjelmaa apt-cachesta. 

```apt-cache search openjdk```

Tulleista vaihtoehdoista openjdk-17-jdk kuulosti tutuimmalta, joten asensin sen. 

```sudo apt-get install openjdk-17-jdk```

Olinkin jo aiemmin asentanut sen virtuaalikoneelleni, joten Linux pyrki päivittämään ohjelman ja antoi sanoman ```openjdk-17-jdk is already the newest version (17.0.14+7-1~deb12u1)```

