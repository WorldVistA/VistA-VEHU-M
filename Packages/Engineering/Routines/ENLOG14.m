ENLOG14 ;(WASH ISC)/DH-Identify Fields to be Taken from LOG1 ;8-28-91
 ;;;;
 ;CLASS 3 SOFTWARE - Not officially supported by the ISC's
 W @IOF,!,"DATA EXTRACTION FROM LOG1 TO AEMS/MERS"
 W !!,"Your answers to the following questions will determine which data elements",!,"from LOG1 will OVERWRITE data elements in AEMS/MERS."
 W !!,"Note that if a selected data element DOES NOT EXIST for a particular record",!,"in LOG1 but DOES EXIST for the corresponding record in AEMS/MERS, then the"
 W !,"AEMS/MERS data WILL NOT be deleted."
EN K EN S EN=""
CMR W !!,"Should CMR be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 CMR S:%=1 EN("CMR")=""
USE W !,"Should USE STATUS be taken from LOG1" S %=2 D YN^DICN G:%<0 ABORT G:%=0 USE S:%=1 EN("USE")=""
OWN W !,"Should OWNERSHIP be taken from LOG1" S %=2 D YN^DICN G:%<0 ABORT G:%=0 OWN S:%=1 EN("OWN")=""
PO W !,"Should PURCHASE ORDER be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 PO S:%=1 EN("PO")=""
AD W !,"Should ACQUISITION DATE be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 AD S:%=1 EN("AD")=""
COST W !,"Should COST be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 COST S:%=1 EN("COST")=""
LE W !,"Should LIFE EXPECTANCY be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 LE S:%=1 EN("LE")=""
RD W !,"Should REPLACEMENT DATE be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 RD S:%=1 EN("RD")=""
CSN W !,"Should CATEGORY STOCK NUMBER be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 CSN S:%=1 EN("CSN")=""
SN W !,"Should SERIAL NUMBER be taken from LOG1" S %=2 D YN^DICN G:%<0 ABORT G:%=0 SN S:%=1 EN("SN")=""
SORC W !,"Should ACQUISITION SOURCE be taken from LOG1" S %=1 D YN^DICN G:%<0 ABORT G:%=0 SORC S:%=1 EN("SORC")=""
 D ^ENLOG15
 Q  ;Return to ENLOG10
 ;
ABORT K EN ;Will halt conversion
 Q  ;Return to ENLOG10
 ;ENLOG14
