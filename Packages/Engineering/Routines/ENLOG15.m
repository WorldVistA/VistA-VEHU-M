ENLOG15 ;(WASH ISC)/DH-Confirm Selections from LOG1 ;8-28-91
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 W @IOF
 W !!,"In the conversion of data from LOG1 to AEMS/MERS, the order of",!,"precedence will be:"
 W !!,"Data Element",?25,"Preferred Source"
 W !,"==== =======",?25,"========= ======"
 W !,"CMR .................... ",$S($D(EN("CMR")):"LOG1",1:"AEMS/MERS")
 W !,"USE STATUS ............. ",$S($D(EN("USE")):"LOG1",1:"AEMS/MERS")
 W !,"OWNERSHIP .............. ",$S($D(EN("OWN")):"LOG1",1:"AEMS/MERS")
 W !,"PURCHASE ORDER ......... ",$S($D(EN("PO")):"LOG1",1:"AEMS/MERS")
 W !,"ACQUISITION DATE ....... ",$S($D(EN("AD")):"LOG1",1:"AEMS/MERS")
 W !,"COST ................... ",$S($D(EN("COST")):"LOG1",1:"AEMS/MERS")
 W !,"LIFE EXPECTANCY ........ ",$S($D(EN("LE")):"LOG1",1:"AEMS/MERS")
 W !,"REPLACEMENT DATE ....... ",$S($D(EN("RD")):"LOG1",1:"AEMS/MERS")
 W !,"CATEGORY STOCK NUMBER .. ",$S($D(EN("CSN")):"LOG1",1:"AEMS/MERS")
 W !,"SERIAL NUMBER .......... ",$S($D(EN("SN")):"LOG1",1:"AEMS/MERS")
 W !,"ACQUISITION SOURCE ..... ",$S($D(EN("SORC")):"LOG1",1:"AEMS/MERS")
 W !!
CNFRM W !,"Is this correct" S %=1 D YN^DICN G:%=0 CNFRM K:%'=1 EN
 Q
 ;ENLOG15
