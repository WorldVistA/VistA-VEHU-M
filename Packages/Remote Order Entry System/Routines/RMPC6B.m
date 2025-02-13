RMPC6B ;DDC/KAW-RMPF*1.1*6 - AUDIOTONE [ 06/24/93  1:41 PM ]
 ;;1.1;RMPF;**6**;June 24, 1993
 W !!,"AUDIOTONE"
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
 G ^RMPC6C
MODEL ;;Audiotone models
 ;;XT
 ;;AVATAR
 ;;SEMI-SECRET
 ;;SECRET
 ;;MICRO
BAT ;;Batteries
 ;;ZA10
 ;;ZA13
 ;;ZA312
COMP ;;Components
 ;;OUTPUT POT;LP;12.75;12.75;12.75;12.75;12.75
 ;;LOW POT;LFP;12.75;12.75;12.75;12.75;12.75
 ;;HIGH POT;HFP;12.75;12.75;12.75;12.75;12.75
 ;;RPA POT;RPC;21.25;21.25;21.25;21.25;21.25
 ;;SCREW SET VC;SSVC;12.75;12.75;12.75;12.75;12.75
 ;;GAIN POT;GP;12.75;12.75;12.75;12.75;12.75
 ;;PP ULTRA HIGH;UHF;42.5;42.5;42.5;42.5;42.5
 ;;CROS;CROS;42.5
 ;;BICROS;BICROS;59.5
 ;;TELE-COIL;TC/S;17;17;17;17;17
 ;;NOISE SWITCH;NRS;17;17;17;17;17
 ;;HYPOALLERGENIC SHELL;HYPO;17;17;17;17;17
 ;;REMOVAL HANDLE;RH;8.5;8.5;8.5;8.5;8.5
 ;;FLEX CANAL;FLEX;17;17;17;17
