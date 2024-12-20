RMPJ6 ;DDC/KAW-RMPF*1.1*9 - PHONAK [ 09/27/94  7:58 AM ]
 ;;1.1;RMPF;**9**;SEP 27, 1994
 W !!,"PHONAK"
 F IX=1:1:12 S MD=$P($T(MODEL+IX),";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0))
 .I 'MP W !!,MD," does not exist in file 791811.  Components not added." Q
 .K ^RMPF(791811,MP,101),^(102),^("I")
 .F IY=1:1 S ST=$T(COMP+IY) Q:ST=""  D
 ..S CS=$P(ST,";",IX+4) Q:CS=""
 ..S CP=$E($P(ST,";",3),1,30),CD=$P(ST,";",4),(CA,CX)=""
 ..F  S CA=$O(^RMPF(791811.2,"B",CP,CA)) Q:'CA  I $P(^RMPF(791811.2,CA,0),"^",3)=CD S CX=CA Q
 ..I 'CX W !!,CP," component not added." Q
 ..D SET1^RMPJ W "."
 .F IZ=1:1:5 S ST=$T(BAT+IZ) D
 ..S BT=$P(ST,";",3),BX=$P(ST,";",IX+3) Q:'BX
 ..S BP=$O(^RMPF(791811.3,"B",BT,0)) I 'BP W !!,BT," battery not added." Q
 ..D SET2^RMPJ W "."
 G ^RMPJ7
MODEL ;;Phonak Models
 ;;9100 AF
 ;;9100 AF-P
 ;;9100 AF-SC
 ;;9100 KAMP
 ;;9300 AF
 ;;9300 AF-SC
 ;;9300 KAMP
 ;;9800 AF
 ;;9800 AF-SC
 ;;9800 KAMP
 ;;9900 AF
 ;;9900 OEC
BAT ;;Batteries
 ;;ZA10;;;;;1;;;1;;;1;1
 ;;ZA13;1;1;1;1
 ;;ZA312;1;;1;1;1;1;1;1;1;1
 ;;S13;1;1;1;1
 ;;S312;1;;1;1;1;1;1;1;1;1
COMP ;;Components
 ;;ACTIVE HIGH CUT;AHC;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25
 ;;ACTIVE LOW CUT;ALC;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25
 ;;BICROS;BICROS;54;54;54;54;54;54;54;54;54;54;54;54
 ;;CLEAR SHELL;CLEAR;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5
 ;;CROS;CROS;54;54;54;54;54;54;54;54;54;54;54;54
 ;;GAIN CONTROL;GAIN;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25
 ;;NOISE SWITCH;NS;22.5;22.5;22.5;22.5;22.5;22.5;22.5;22.5;22.5;22.5;22.5;22.5
 ;;OUTPUT CONTROL;LP;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25;11.25
 ;;SCREW SET VC;SSVC;8.21;8.21;8.21;8.21;8.21;8.21;8.21;8.21;8.21;8.21;8.21;8.21
 ;;SOFT COTE;SOFT;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5;13.5
 ;;TELECOIL;TC;16.46;16.46;16.46;16.46;16.46;16.46;16.46;16.46;16.46;16.46;16.46;16.46
