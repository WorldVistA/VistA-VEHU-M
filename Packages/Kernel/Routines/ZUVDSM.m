ZU ;GFT/SF ; 13DEC84 17:11 ;TIE ALL TERMINALS EXCEPT CONSOLE TO THIS ROUTINE!!
 ;4.23
 ;FOR DSM/VX......ZUVDSM....=>%ZUVDSM
 S DEV=$N(^%ZIS(1,"C",$I,0))
 W !!,"DEVICE   ",$S(+DEV>1:DEV,1:$I),"     $I  ",$I,!
 S $ZT="ERR^ZUVDSM" K DEV G ^XUS
 ;
ERR ;
 U $I W !!,$ZE
 D C^XUS I $ZE["<INTERRUPT>" H
 ;
 S %EH=+$H,%ETM=$P(%EH,",",2),%UCI=$P($ZC(%UCI),",",1) S ^%ERTRAP(%UCI,%EH,%ETM)=$ZE,IO="ERTRAP"
 O IO:NEWVERSION U IO ZW  S EZIO=$ZIO,^%ERTRAP(%UCI,%EH,%ETM,"VMS")=EZIO C IO
 I $P(EZIO,";",2)>1000 S EZIO=$P(EZIO,";",1),%SPAWN="PURGE/KEEP=500 "_EZIO D ^%SPAWN
 HALT
