# DHBW_Haskell_Restaurant
Ein Projekt des fünften Semesters an der DHBW Mosbach in der Vorlesung *Funktionale Programmierung*.
Teilnehmer:
- Luca Schirmbrand
- Niel Rohling
- Simon Bestler
## Aufgaben:
### Aufgabe 1: Die Anzahl:
#### Aufgabenstellung:
 Die erste Funktion, die Sie implementieren sollen, heißt "anzahl". Signatur:
**anzahl  ::  (Int,Int,Int) -> String -> Int**
Die Funktion liefert die Anzahl verkaufter Artikel mit folgenden Filtern:

*Parameter 1:* Datum. Hier wird Jahr, Monat und Tag geliefert. Der Tag ist optional. Wenn Tag=0 übergeben wird, dann soll die Anzahl des gesamten Monats zurückgegeben werden. Fehlerbehandlung: Sie müssen nicht prüfen, ob das Datum plausibel ist. Wenn hier z.B. der 31.02. abgerufen wird, dann geben Sie Anzahl 0 zurück.

*Parameter 2*:
 Artikelbezeichnung oder Kategorie: In diesem String kann sich entweder eine Artikelbezeichnung wie "Hamburger" oder eine Kategorie wie "Hauptgericht" übergeben werden. Es kann auch "\*" übergeben werden. In dem Fall werden alle Artikel summiert. Wenn der Text im Artikelstamm nicht gefunden wird und auch nicht "\*" entspricht, soll eine entsprechende Fehlermeldung erscheinen.
#### Beispiel: 
---> *anzahl :: (2020,6,25) "Hauptgericht"*
### Aufgabe 2: Der Umsatz:
#### Aufgabenstellung:
Die zweite Funktion heißt "umsatz". Signatur:
**umsatz :: (Int,Int,Int) -> String -> Float**
Die Funktion liefert den Umsatz der verkauften Artikel. Beim Umsatz zählt nur der Preis, keine Kosten. Es gelten dieselben Filterregeln wie bei der Anzahl.
#### Beispiel:
---> *umsatz (2020,6,30) "Hauptgericht"*
### Aufgabe 3: Der Gewinn
#### Aufgabenstellung:
Die dritte Funktion heißt "gewinn". Signatur:
**gewinn :: (Int,Int,Int) -> String -> Float**
Die Funktion liefert den Gewinn, also den Umsatz abzüglich der Einzel- sowie Gemeinkosten. Es gelten dieselben Filterregeln wie bei der Anzahl. Die Gemeinkosten werden auf die Gesamtanzahl verkaufter Artikel gleichmäßig verteilt. Beispielrechnung: Es werden in einem Monat 300 Hamburger, 200 Cheeseburger, 100 Chckenburger, 300 Cola und 100 Wasser verkauft. Das sind in Summe 1000 verkaufte Artikel. Dem stehen Löhne und Pacht von in Summe 2000€ entgegen. Das bedeutet, dass jeder Hamburger, Cheeseburger, Chickenburger, Cola und Wasser je 2 € Gemeinkosten tragen müssen.
#### Beispiel:
---> *gewinn (2020,6,25) "Hauptgericht"*

### Aufgabe 4: Die Top-/Flop-Analyse

Schließlich sollen die folgenden Funktionen implementiert werden:
**topAnzahl :: (Int,Int) -> (String,Int,Float)
flopAnzahl :: (Int,Int) -> (String,Int,Float)
topUmsatz :: (Int,Int) -> (String,Float,Float)
flopUmsatz :: (Int,Int) -> (String,Float,Float)
topGewinn :: (Int,Int) -> (String,Float,Float)
flopGewinn :: (Int,Int) -> (String,Float,Float)**

Es handelt sich also um eine Top-/Flop-Analyse von Anzahl, Umsatz und Gewinn. Top: Ausgabe des stärksten Artikels; Flop: Ausgabe des schwächsten Artikels. Eingabeparameter ist Jahr und Monat, in der Ausgabe ist die Artikelbeschreibung und der Wert, also die Anzahl, der Umsatz oder der Gewinn dieses Artikels in diesem Monat. Zuletzt wird noch ein weiterer Float ausgegeben. Dabei handelt es sich um den prozentuellen Anteil im betreffenden Monat. Die anteilige Anzahl wird daher mit "Anzahl des Artikels in dem Monat"/"Gesamtanzahl verkaufter Artikel in dem Monat" berechnet. Umsatz und Gewinn analog. Darstellung ist z.B: "0.25" für 25 %.
#### Beispiel:
---> *topAnzahl (2020,6)*
---> *flopAnzahl (2020,6)*
---> *topUmsatz (2020,6)*
---> *flopUmsatz (2020,6)*
---> *topGewinn(2020,6)*
---> *flopGewinn(2020,6)*