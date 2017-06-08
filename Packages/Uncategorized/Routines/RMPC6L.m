RMPC6L ;DDC/KAW-RMPF*1.1*6 - OTICON [ 06/24/93  1:44 PM ]
 ;;1.1;RMPF;**6**;June 24, 1993
 W !!,"OTICON"
 F IX=1:1:5 S MD=$P($T(MODEL+IX),";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0))
 .I 'MP W !!,MD," does not exist in file 791811.  Components not added." Q
 .F IY=1:1 S ST=$T(COMP+IY) Q:ST=""  D
 ..S CS=$P(ST,";",IX+4) Q:CS=""
 ..S CP=$E($P(ST,";",3),1,30),CD=$P(ST,";",4),(CA,CX)=""
 ..F  S CA=$O(^RMPF(791811.2,"B",CP,CA)) Q:'CA  I $P(^RMPF(791811.2,CA,0),"^",3)=CD S CX=CA Q
 ..I 'CX W !!,CP," component not added." Q
 ..D SET1^RMPC6 W "."
 .F IZ=1:1:3 S ST=$T(BAT+IZ) D
 ..S BT=$P(ST,";",3)
 ..S BP=$O(^RMPF(791811.3,"B",BT,0)) I 'BP W !!,BT," battery not added." Q
 ..D SET2^RMPC6 W "."
 G ^RMPC6M
MODEL ;;Oticon Models
 ;;COMMUNICARE-F
 ;;COMMUNICARE-L
 ;;COMMUNICARE-H
 ;;COMMUNICARE-C
 ;;COMMUNICARE-M
BAT ;;Batteries
 ;;ZA10
 ;;ZA13
 ;;ZA312
COMP ;;Components
 ;;BATT COND IND;BCI;16.02;16.02;16.02
 ;;NOISE SUPPRESSOR SWITCH;NSS;16.02;16.02;16.02
 ;;POWER SERVICE PACK;PSP;35.6
 ;;TELECOIL;TC;19.58;19.58;19.58
