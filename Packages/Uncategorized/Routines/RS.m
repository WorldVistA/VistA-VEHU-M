RS ;TIED TERMINAL ACCESS TO VAN;12/21/88  11:48 AM
 R !!,"UCI: ",UCI:DTIME Q:UCI=""!($T=0)!(UCI["^")  I UCI="?" D HELP G RS
 I "SUP,OLD,TST,XXX"'[UCI W !,*7,UCI," NOT AVAILABLE" G RS
 I UCI="SUP" D SUP^%ZALB
 I UCI="OLD" D OLD^%ZALB
 I UCI="TST" D TST^%ZALB
 I UCI="XXX" D XXX^%ZALB
 W !!,$ZU(0)
 W !! F I=1:1:5 W !,$T(@I)
 R:30 !!,"Option: ",X I X'>0!(X'<6) Q
 D @X K X G RS
1 ; Routine Save (%RS)
 D ^%RS Q
2 ; First Line List (%FL)
 D ^%FL Q
3 ; Routine Search (%RSE)
 D ^%RSE Q
4 ; Routine Select (%RSEL)
 D ^%RSEL Q
5 ; Routine Directory (%RD)
 D ^%RD Q
HELP ;
 S $ZT="OHOH"
 F II=1:1 W !,$ZU(II)
 Q
OHOH ;
 S $ZT="" Q
 
