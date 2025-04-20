# H4 Leviämässä

## x) Lue & Tiivistä
- Cracking Passwords with Hashcat
   - Järjestelmät eivät tallenna (ainakaan pitäisi) alkuperäisiä salasanoja vaan hasheja.
   - Hashaus on yksisuuntainen funktio.
   - Voidaan kuitenkin kokeilla millä salasanalla muodostuu sama hash. 
   - Hashcat tarvitsee hash-tyypin toimiakseen. 
- Crack File Password With John
   - John the ripper pystyy sanakirja-hyökkäyksellä murtamaan encryptoidun salasanan. 
   - Sanakirja hyökkäys ei toimi vahvoihin salasanoihin.
   - Suojattuja zip tiedostoja vastaan voidaan hyökätä hyökkäämällä sen hashiin. 
- Security Penetration Testing The Art of Hacking Series LiveLessons: Lesson 6
   - Salasanan suojaamien vaatii sen suojaamista sekä varastossa että kun sitä ollaan lähettämässä verkon yli.
   - Monet käyttävät oletussalasanoja tai samaa salasanaa kaikkiin laitteisiin.
   - Hyökkäysten ensimmäinen tavoite on tunnistaa validit käyttäjät, jonka jälkeen voidaan hyökätä salasanan kimppuun.
   - Hashaus ei ole encryptaamista, mutta sitä voidaan käyttää salasanojen suojaamiseen.
   - Hashaamiseen tulisi käyttää aina suolaa (salt).
   - Nykyään salasanoja on helpompi murtaa. 
- File-Format Exploits
   - File-format exploit ovat haavoittuvuuksia, jotka sijaitsevat lukijoissa (esim. Adobe PDF reader).
   - Nämä luottavat siihen, että käyttäjä avaa saastuneen tiedoston haavoittuvalla lukijalla.
   - Saastunutta tiedostoa voidaan esimerkiksi jakaa vastaanottajan sähköpostiin. 
- Understanding Active Directory
   - Active Directory on palvelu/työkalu, joka helpottaa käyttäjien, ryhmien, laitteiden ja käytänteiden hallintaa. 
   - Active Directoryn ollessa päällä, käyttäjien täytyy liittyä kyseiseen Windows toimialueelleseen toimiakseen.
   - Active Directorya määrittäessä, pitää sille luoda ```forest```, joka määrittelee sen loogisen turvallisuusrajan. 






```
```

<img src="
" width="500"> <br/>


## Ajankäyttö: 

- Materiaalien lukemiseen ja tiivistämiseen n. 
- Tehtäviin n. h. 
- Raportointiin ja dokumentointiin n. h. 

## Lähteet: 

Karvinen, T. 2025. Tunkeutumistestaus.    
https://terokarvinen.com/tunkeutumistestaus/    
Tehtävänanto.    

Karvinen, T. 2022. Cracking Passwords with Hashcat.     
https://terokarvinen.com/2022/cracking-passwords-with-hashcat/    
Tehtävä x.    

Karvinen, T. 2023. Crack File Password With John.     
https://terokarvinen.com/2023/crack-file-password-with-john/   
Tehtävä x.    

Santos, O et al. 2017. The Art of Hacking Series LiveLessons. Lesson 6: Hacking User Credentials.     
https://www.oreilly.com/videos/security-penetration-testing/9780134833989/9780134833989-sptt_00_06_00_00/    
Tehtävä x.    

Kennedy, D et al. 2025. Metasploit, 2nd Edition. Chapter 9: Client-side attacks.    
https://www.oreilly.com/library/view/metasploit-2nd-edition/9798341620032/xhtml/chapter9.xhtml#:-:text=File-Format%20Exploits    
Tehtävä x.    

Singh, G. 2024. The Ultimate Kali Linux Book - Third Edition. Chapter 12: Understanding Active Directory.     
https://www.oreilly.com/library/view/the-ultimate-kali/9781835085806/Text/Chapter_12.xhtml#_idParaDest-272    
Tehtävä x.    


