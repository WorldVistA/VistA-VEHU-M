RMPC8L ;DDC/MAB-RMPF*1.1*8 - OTICON [ 09/27/93  9:15 AM ]
 ;;1.1;RMPF;**8**;Sept 21, 1993
 W !!,"OTICON"
 F IX=1:1:2 S TMD=$T(MODEL+IX),MD=$P(TMD,";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0)) Q:'MP
 .S BT="ZA13"
 .S BP=$O(^RMPF(791811.3,"B",BT,0)) I 'BP W !!,BT," battery not added." Q
 .D SET2^RMPC8 W "."
 F IX=3:1:5 S MD=$P($T(MODEL+IX),";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0)) Q:'MP
 .S (CP,CD)="ASP",(CA,CX)="",CS=53.40
 .F  S CA=$O(^RMPF(791811.2,"B",CP,CA)) Q:'CA  I $P(^RMPF(791811.2,CA,0),"^",3)=CD S CX=CA Q
 .I 'CX W !!,CP," component not added."
 .I CX D SET1^RMPC8 W "."
 G ^RMPC8I
MODEL ;;Oticon Models
 ;;P400;188.00
 ;;P420;200.00
 ;;COMMUNICARE-H
 ;;COMMUNICARE-F
 ;;COMMUNICARE-L
