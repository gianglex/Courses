# H4 RFID

## 1. Tarkastele käytössäsi olevia RFID tuotteita, mieti miten hyvin olet suojautunut RFID urkinnalta?
Mieleeni tulevat ensimmäisenä työpaikan kulkulätkä, pankkikortti sekä puhelin. Pidän usein kulkulätkää taskussa tai työpaikalla kaulassa. 
Urkinta voi tietysti tapahtua vaikka kulkulätkä olisi lähelläni. Kulkulätkää en jätä valvomatta vaan pidän sitä mukanani vain kun sitä tarvitsen. Tietenkään tämä ei estä esimerkiksi kulkulätkän urkintaa jos joku esimerkiksi työmatkalla tulee lähelle pyrkimyksenä urkkia. 

Pankkikorttia pidän lompakossa, joka ei ole RFID -suojattu. Optiimitilanteessa kortti olisi aina RFID -suojatussa kotelossa kun se ei ole käytössä. 

Puhelimessani pidän NFC:tä päällä vain silloin kun sitä aktiivisesti käytän, muuten puhelimen NFC on pois päältä. Myöskään puhelimessani olevat pankkikortit eivät toimi ellei minulla ole oikeaa sovellusta päällä. 

## 2. Tutustu APDU komentojen rakenteeseen (voit käyttää tekoälyä tutustumiseen)

APDU eli (Smart card) Application Protocol Data Unit -komennot voidaan jakaa kahteen kategoriaan. Command APDU:un ja response APDU:un. 

Command APDU:t pääsääntöisesti ovat lukijalta kortille lähetettäviä komentoja. Niissä on pakollinen 4 tavuinen header sekä 0-65535 tavua dataa. 

Command APDU:n datakentät ovat: 
| Kenttä | Pituus (tavuina) | Selite |
| ------------- | ------------- | ------------- |
| CLA | 1 | Luokka |
| INS | 1 | Komento |
| P1 | 1 | 	Parametri 1 |
| P2 | 1 | 	Parametri 2 |
| Lc | 0, 1, 3 | Määrittelee lähetettävien tavujen määrän |
| Command data | Nc | Data |
| Le | 0, 1, 2 tai 3 | Vastauksen odotettu pituus |


Response APDU:t ovat taas pääsääntöisesti kortilta lukijalle lähetettäviä komentoja. Niissä on pakollinen 2 tavuinen statusdata sekä 0-65536 tavua dataa. 

Respond APDU:n datakentät ovat:
| Kenttä | Pituus (tavuina) | Selite |
| ------------- | ------------- | ------------- |
| Response data | 1 | Vastauksen data |
| SW1-SW2 | 2 | Status / Tilakoodi |


## 3. Tutki ja kerro minkä mielenkiintoisen RFID hakkerointi uutiset löysit. (Vinkki, useimmat liittyvät henkilökortteihin)

Suurin osa löytämistäni uutisista liittyivät kulkukortteihin. Varsinkin hotellien avainkorttien murtamisesta löytyi useampikin uutinen, mikä johtunee siitä että ne ovat huonosti suojattuja jos ovat ylipäätänsäkään suojattuja. 
Yksi mielenkiintoisista uutisista liittyi F-Securen löydökseen, jossa he olivat saaneet luotua master-keyn ovien avaamiseen. 

Löysin mm. nämä uutiset:

Hackers build a 'Master Key' that unlocks millions of Hotel rooms    
https://thehackernews.com/2018/04/hacking-hotel-master-key.html    

Hardware Backdoor Discovered in RFID Cards Used in Hotels and Offices Worldwide    
https://thehackernews.com/2024/08/hardware-backdoor-discovered-in-rfid.html    

New RFID Attack Opens the Door    
https://www.darkreading.com/cyber-risk/new-rfid-attack-opens-the-door    

Major Backdoor in Millions of RFID Cards Allows Instant Cloning    
https://www.securityweek.com/major-backdoor-in-millions-of-rfid-cards-allows-instant-cloning/    

## Lähteet

Iso-Anttila, L. 2025. Haaga-Helia Moodle. Verkkoon tunkeutuminen ja tiedustelu - ICI013AS3A-3001 / 4. NFC ja RFID.    
https://hhmoodle.haaga-helia.fi/course/view.php?id=42566&section=1#tabs-tree-start    
Tehtävänanto.    

Wikipedia. s.a. Smart card application protocol data unit.    
https://en.wikipedia.org/wiki/Smart_card_application_protocol_data_unit    
Tehtävä 2.    

CardLogix. s.a. Application Protocol Data Unit (APDU).     
https://www.cardlogix.com/glossary/apdu-application-protocol-data-unit-smart-card/    
Tehtävä 2.    
