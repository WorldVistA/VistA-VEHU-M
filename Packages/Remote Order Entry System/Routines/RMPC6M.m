RMPC6M ;DDC/KAW-RMPF*1.1*6 - MAICO [ 06/24/93  1:45 PM ]
 ;;1.1;RMPF;**6**;June 24, 1993
 W !!,"MAICO"
 F IX=1:1:10 S MD=$P($T(MODEL+IX),";",3) D
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
 G ^RMPC6N
END Q
MODEL ;;Maico Models
 ;;FULL CONCHA-A
 ;;FULL CONCHA-D
 ;;LOW PROFILE-A
 ;;LOW PROFILE-D
 ;;HALF SHELL-A
 ;;HALF SHELL-D
 ;;CANAL-A
 ;;CANAL-D
 ;;MINI CANAL-A
 ;;MINI CANAL-D
BAT ;;Batteries
 ;;ZA10
 ;;ZA13
 ;;ZA312
COMP ;;Components
 ;;ANTI-FEEDBACK CIRCUIT;ANTI;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;BICROS;BICROS;31.98;31.98;31.98;31.98;31.98;31.98;31.98;31.98;31.98;31.98
 ;;COMPRESSION;COMP;;12.3;;12.3;;12.3;;12.3;;12.3
 ;;CROS;CROS;23.78;23.78;23.78;23.78;23.78;23.78;23.78;23.78;23.78;23.78
 ;;E-COMPOUND SHELL;ESHELL;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;GAIN CONTROL;GAIN;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;HI CUT TONE;HC;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;LOW CUT TONE CONTROL;LCTC;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;NOISE REDUCTION SWITCH;NSS;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;OUTPUT CONTROL;LP;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3;12.3
 ;;TELEPHONE COIL;TC;16.4;16.4;16.4;16.4;16.4;16.4;16.4;16.4;16.4;16.4
