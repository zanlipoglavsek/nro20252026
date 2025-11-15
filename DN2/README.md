Izmed treh uporabljenih metod, je bila najhitrejša uporaba funkcije `griddedInterpolant`, sledila je lastna metoda interpolacije, ki je približno red velikosti počasnejša (je iterativna metoda, zato je čas odvisen tudi od lokacije točke), še za red velikosti počasnejša, pa je interpolacija z uporabo `scatteredInterpolant`.

Ker imamo strukturirano mrežo, funkcija `griddedInterpolant` hitro najde sosednja vozlišča in vrednosti v njih, saj je optimizirana za take strukture.
