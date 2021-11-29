{- Funktion artikel gibt den Artikelstamm zurück
    Artikelnummer (Int)
    Artikelbezeichnung (String)
    Kategorie (String)
    Preis (Float)
    Einzelkosten (Float) -}
artikel :: [(Int,String,String,Float,Float)]
artikel = [(1,"Hamburger","Hauptgericht",8,6),(2,"Cheeseburger","Hauptgericht",9,6.5),(3,"Chickenburger","Hauptgericht",8.5,6.5),(4,"Pommes frites","Beilage",3,2),(5,"Wedges","Beilage",3.5,2),(6,"Cola","Getraenk",2.5,1),(7,"Eistee","Getraenk",2,1),(8,"Wasser","Getraenk",1.5,0.5)]

{- Funktion pacht gibt die Pacht pro Monat zurück
    Monat (Int,Int) definiert mit Jahr und Monat
    Pacht (Float) -}
pacht :: [((Int,Int),Float)]
pacht = [((2020,1),1200),((2020,2),1200),((2020,3),1200),((2020,4),1400),((2020,5),1400),((2020,6),1400)]

{- Funktion loehne gibt die Löhne pro Monat zurück
    Monat (Int,Int) definiert mit Jahr und Monat
    Löhne (Float) -}
loehne :: [((Int,Int),Float)]
loehne = [((2020,1),2000),((2020,2),1900),((2020,3),2000),((2020,4),1800),((2020,5),1800),((2020,6),1800)]

{- Funktion buchungen gibt die Einzelbuchungen aus der Kasse zurück
    Datum (Int,Int,Int) definiert mit Jahr, Monat und Tag
    Zeit (Int,Int) definiert mit Stunde und Minute
    Artikelnummer (Int) -}
buchungen :: [((Int,Int,Int),(Int,Int),Int)]

{-
  Aufgabe 1
	Funktion anzahl gibt die Anzahl des Artikels am mitgegebenen Datum zurück
	Datum (Int, Int, Int) definiert mit Jahr, Monat und Tag
	Artikel String
-}
-- Example: anzahl (2020,6,30) "Hauptgericht"
anzahl :: (Int,Int,Int) -> String -> Int
anzahl datum "*" = length(filterBuchungenNachDatum datum)
anzahl datum suchartikel = length(filterBuchungenNachArtikel(filterBuchungenNachDatum datum) (filterArtikelNachArtikelbezeichnung suchartikel))

{-
  Aufgabe 2
	Funktion umsatz liefert den Umsatz der verkauften Artikel zurück
	Datum (Int,Int,Int) definiert mit Jahr, Monat und Tag
	Artikel String
-}
-- Example: umsatz (2020,6,30) "Hauptgericht"
umsatz :: (Int,Int,Int) -> String -> Float
umsatz datum artikelbezeichnung =
  let preise = erzeugeBuchungenListe (filterBuchungenNachArtikel (filterBuchungenNachDatum datum) (gefilterteArtikel)) gefilterteArtikel True
      gefilterteArtikel =
        if artikelbezeichnung == "*"
          then artikel
          else filterArtikelNachArtikelbezeichnung artikelbezeichnung
    in if preise == []
      then 0
      else foldr1 (+) (preise)

{-
  Aufgabe 3
	Funktion gewinn liefert den Gewinn (Umsatz abzüglich der Einzel-& Gemeinkosten) zurück
	Datum (Int, Int, Int) definiert mit Jahr, Monat und Tag
	Artikel String
-}
-- gewinn (2020,6,30) "Hauptgericht"
gewinn :: (Int,Int,Int) -> String -> Float
gewinn datum artikelbezeichnung =
  let umsatzP = umsatz datum artikelbezeichnung
      kostenP = einzelkostenHilf datum artikelbezeichnung
      anzahlP = fromIntegral (anzahl datum artikelbezeichnung)
      gemeinkostenP = artikelGemeinkosten (datumZuJahrMonat datum)
    in umsatzP - kostenP - anzahlP * gemeinkostenP

{-
  Aufgabe 4
	Funktion top/flop.. liefert den höchsten/niedrigsten Anzahl, Umsatz oder Gewinn zurück + Artikel
	Datum (Int,Int) definiert mit Jahr & Monat
-}
-- Example topAnzahl (2020,6), flopAnzahl (2020,6), topUmsatz (2020,6), ...
topAnzahl :: (Int,Int) -> (String,Int)
topAnzahl datum = sortiereAbsteigend(listAlleArtikelMonat anzahl datum)

flopAnzahl :: (Int,Int) -> (String,Int)
flopAnzahl datum = sortiereAufsteigend(listAlleArtikelMonat anzahl datum)

topUmsatz :: (Int,Int) -> (String,Float)
topUmsatz datum = sortiereAbsteigend(listAlleArtikelMonat umsatz datum)

flopUmsatz :: (Int,Int) -> (String,Float)
flopUmsatz datum = sortiereAufsteigend(listAlleArtikelMonat umsatz datum)

topGewinn :: (Int,Int) -> (String,Float)
topGewinn datum = sortiereAbsteigend(listAlleArtikelMonat gewinn datum)

flopGewinn :: (Int,Int) -> (String,Float)
flopGewinn datum = sortiereAufsteigend(listAlleArtikelMonat gewinn datum)



-- Hilfsfunktionen, etc.

-- Filtern der Buchungen nach Artikel.
filterBuchungenNachArtikel :: [((Int,Int,Int),(Int,Int),Int)] -> [(Int,String,String,Float,Float)] -> [((Int,Int,Int),(Int,Int),Int)]
filterBuchungenNachArtikel tempBuchungen tempArtikel = filter(filterBuchungenNachArtikelHilfe tempArtikel) tempBuchungen

-- Filterfunktion für das Filtern der Buchungen nach Artikel. Artikelnummer muss übereinstimmen
filterBuchungenNachArtikelHilfe :: [(Int,String,String,Float,Float)] -> ((Int,Int,Int),(Int,Int),Int) -> Bool
filterBuchungenNachArtikelHilfe [] _ = False
filterBuchungenNachArtikelHilfe ((artikelnummer,_,_,_,_):xs) (datum,uhrzeit,nummer)
  | artikelnummer == nummer = True
  | otherwise = filterBuchungenNachArtikelHilfe xs (datum,uhrzeit,nummer)

-- Filter der Buchungen nach Datum. Bei Tag=0 nach ganzem Monat filtern
filterBuchungenNachDatum :: (Int,Int,Int) -> [((Int,Int,Int),(Int,Int),Int)]
filterBuchungenNachDatum (jahr,monat,0) = filter(\((jahrP,monatP,_),_,_) -> jahr == jahrP && monat == monatP) buchungen
filterBuchungenNachDatum (jahr,monat,tag) = filter(\((jahrP,monatP,tagP),_,_) -> jahr == jahrP && monat == monatP && tag == tagP) buchungen

-- Filter Artikelliste nach übereinstimmender Artikelbezeichnung und Kaztegorie + Fehlerbehandlung
filterArtikelNachArtikelbezeichnung :: String -> [(Int,String,String,Float,Float)]
filterArtikelNachArtikelbezeichnung suche =
  let gefilterterArtikel = filter(\(_,artikelbezeichnung,kategorie,_,_) -> artikelbezeichnung == suche || kategorie == suche) artikel
	in case() of
	  _| gefilterterArtikel == [] -> error "Artikel konnte nicht gefunden werden, versuchen Sie es doch mit bspw. 'Hamburger'"
		| otherwise -> gefilterterArtikel

-- Berechnung Gemeinkosten monatlich
monatlicheGemeinkosten :: (Int,Int) -> [((Int,Int),Float)] -> Float
monatlicheGemeinkosten (jahr,monat) pachtOloehne =
  let gefilterteGemeinkosten = (filter(\((jahrP,monatP),_) -> jahr == jahrP && monat == monatP) pachtOloehne)
  in if gefilterteGemeinkosten == [] 
    then 0.0
    else snd(gefilterteGemeinkosten !! 0)

-- Berechnung der Gemeinkosten durch Addition von Pachtkosten sowie Lohnkosten
gemeinkostenHilf :: (Int,Int) -> Float
gemeinkostenHilf datum = 
  let pachtkosten = monatlicheGemeinkosten datum pacht
      lohnkosten = monatlicheGemeinkosten datum loehne
  in pachtkosten + lohnkosten

-- Berechnung Gemeinkosten 
artikelGemeinkosten :: (Int,Int) -> Float
artikelGemeinkosten datum =
  let monGemeinkosten = gemeinkostenHilf datum
      monAnzahl = fromIntegral(anzahl (fst(datum),snd(datum),0) "*")
  in if monAnzahl == 0
    then error "Es gibt keine Anzahl -> Kein Dividieren durch Null"
    else monGemeinkosten / monAnzahl

-- Berechnung der Einzelkosten Gesamt durch Falten (reduce) der Liste von Kosten
einzelkostenHilf :: (Int,Int,Int) -> String -> Float
einzelkostenHilf datum artikelbezeichnung =
  let ek = erzeugeBuchungenListe (filterBuchungenNachArtikel (filterBuchungenNachDatum datum) (gefilterteArtikel)) gefilterteArtikel False
      gefilterteArtikel =
        if artikelbezeichnung == "*"
        then artikel
        else filterArtikelNachArtikelbezeichnung artikelbezeichnung
    in if ek == []
      then 0
      else foldr1 (+) (ek)

-- Liefert Kosten oder Preise (preisOKosten (Bool)) als Liste von Floats zurück
erzeugeBuchungenListe :: [((Int,Int,Int),(Int,Int),Int)] -> [(Int,String,String,Float,Float)] -> Bool -> [Float]
erzeugeBuchungenListe tempBuchungen tempArtikel preisOkosten = map (preisOkostenHilfe tempArtikel) tempBuchungen
  where
    preisOkostenHilfe :: [(Int,String,String,Float,Float)] -> ((Int,Int,Int),(Int,Int),Int) -> Float
    preisOkostenHilfe [] _ = 0.0
    preisOkostenHilfe ((artikelnummer,_,_,preis,kosten):xs) (datum,uhrzeit,nummer)
      | artikelnummer == nummer && preisOkosten == False = kosten
      | artikelnummer == nummer && preisOkosten == True = preis
      | otherwise = preisOkostenHilfe xs (datum,uhrzeit,nummer)

-- Konvertiert Tupel, um nur noch jahr und monat in Tupel zu haben
datumZuJahrMonat :: (Int,Int,Int) -> (Int,Int)
datumZuJahrMonat (jahr,monat,tag) = (jahr,monat)

-- Mapping Artikel
listAlleArtikelMonat :: ((Int,Int,Int) -> String -> a) -> (Int,Int) -> [(String,a)]
listAlleArtikelMonat myFunc (jahr,monat) =
  let convertTuple (_,artikelbezeichnung,_,_,_) = (artikelbezeichnung, myFunc (jahr,monat,0) artikelbezeichnung)
	in map convertTuple artikel

-- sortiere Funktion für das Falten. groesserKleiner (Bool) für Auswahl
sortiere :: Ord a => Bool -> (String,a) -> (String,a) -> (String,a)
sortiere groesserKleiner (nameA,valueA) (nameB,valueB)
  | groesserKleiner == True && valueA > valueB = (nameA,valueA)
  | groesserKleiner == True && valueA <= valueB = (nameB,valueB)
  | groesserKleiner == False && valueA < valueB = (nameA,valueA)
  | groesserKleiner == False && valueA >= valueB = (nameB,valueB)

-- sortiereAufsteigend durch Falten der Liste
sortiereAufsteigend :: Ord a => [(String,a)] -> (String,a)
sortiereAufsteigend xs = foldl1(sortiere False) xs

-- sortiereAbsteigend durch Falten der Liste
sortiereAbsteigend :: Ord a => [(String,a)] -> (String,a)
sortiereAbsteigend xs = foldl1(sortiere True) xs