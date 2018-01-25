RMPC6 ;DDC/KAW-POST-INIT FOR ROES PATCH RMPF*1.1*6-AHS;;07/02/93  9:14 AM
 ;;1.1;RMPF;**6**;June 24, 1993
 W !!,"Adding components and batteries to models."
 W !!,"AUTHORIZED HEARING SYSTEMS"
 F IX=1:1:5 S MD=$P($T(MODEL+IX),";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0))
 .I 'MP W !!,MD," does not exist in file 791811.  Components not added." Q
 .F IY=1:1 S ST=$T(COMP+IY) Q:ST=""  D
 ..S CS=$P(ST,";",IX+4) Q:CS=""
 ..S CP=$E($P(ST,";",3),1,30),CD=$P(ST,";",4),(CA,CX)=""
 ..F  S CA=$O(^RMPF(791811.2,"B",CP,CA)) Q:'CA  I $P(^RMPF(791811.2,CA,0),"^",3)=CD S CX=CA Q
 ..I 'CX W !!,CP," component not added." Q
 ..D SET1 W "."
 .F IZ=1:1:3 S ST=$T(BAT+IZ) D
 ..S BT=$P(ST,";",3)
 ..S BP=$O(^RMPF(791811.3,"B",BT,0)) I 'BP W !!,BT," battery not added." Q
 ..D SET2 W "."
 G ^RMPC6A
SET1 I '$D(^RMPF(791811,MP,101,0)) S ^RMPF(791811,MP,101,0)="^791811.0101PA"
 Q:$D(^RMPF(791811,MP,101,"B",CX))
 S DIC="^RMPF(791811,"_MP_",101,",X=CX,DIC(0)="L",DLAYGO=791811
 S DIC("DR")=".02////"_CS,DA(1)=MP K DD,DO D FILE^DICN K DLAYGO
 I Y=-1 W !!,MD," not added."
 Q
SET2 I '$D(^RMPF(791811,MP,102,0)) S ^RMPF(791811,MP,102,0)="^791811.0102PA"
 Q:$D(^RMPF(791811,MP,102,"B",BP))
 S DIC="^RMPF(791811,"_MP_",102,",X=BP,DIC(0)="L",DLAYGO=791811
 S DA(1)=MP K DD,DO D FILE^DICN K DLAYGO
 I Y=-1 W !!,BP," not added."
 Q
MODEL ;;Authorized Hearing Systems Models
 ;;ALPHA FS
 ;;ALPHA LP
 ;;ALPHA HS
 ;;ALPHA CA
 ;;ALPHA MC
BAT ;;Batteries
 ;;ZA10
 ;;ZA13
 ;;ZA312
COMP ;;AHS Components
 ;;AUTO GAIN CONTROL INPUT;AGCI;16.8;16.8;16.8;16.8;16.8
 ;;AUTO GAIN CRTL INPUT/POT;AGCIP;27.72;27.72;27.72;27.72;27.72
 ;;BICROS;BICROS;37.8
 ;;CANAL RESONANCE CIRCUIT;CRC;12.6;12.6;12.6;12.6;12.6
 ;;CANAL RESONANCE CIRCUIT/POT;CRCP;23.52;23.52;23.52;23.52;23.52
 ;;CROS;CROS;29.4
 ;;CRYSTAL CLEAR;CC;31.08;31.08;31.08;31.08;31.08
 ;;CRYSTAL CLEAR ASP;CCASP;31.08;31.08;31.08;31.08
 ;;CRYSTAL CLEAR ASP/POT;CCASPP;42;42;42;42
 ;;CRYSTAL CLEAR COMPRESSION;CCC;31.08;31.08;31.08;31.08
 ;;CRYSTAL CLEAR COMPRESS/POT;CCCP;42;42;42;42
 ;;CRYSTAL CLEAR ECD;ECD;31.08;31.08;31.08;31.08
 ;;CRYSTAL CLEAR ECU;ECU;31.08;31.08;31.08;31.08
 ;;CRYSTAL CLEAR POWER;CCP;33.6;33.6;33.6;33.6
 ;;CRYSTAL CLEAR SUPER POWER;CCSP;33.6;33.6;33.6;33.6
 ;;DIRECT AUDIO INPUT;DAI;29.4;29.4
 ;;FEEDBACK REDUCTION CIRCUIT;FRC;8.4;8.4;8.4;8.4;8.4
 ;;FEEDBACK REDUCTION CIRC/POT;FRCP;19.32;19.32;19.32;19.32;19.32
 ;;GAIN CONTROL POT;GAIN;10.92;10.92;10.92;10.92;10.92
 ;;HF CONTROL POT;HC;10.92;10.92;10.92;10.92;10.92
 ;;HYPOALLERGENIC SHELL;CLEAR;8.4;8.4;8.4;8.4;8.4
 ;;K-AMP HI FIDELITY AID;KAMP;83.16;83.16;83.16;83.16
 ;;THRESHOLD KNEE POINT;TK POT;10.92;10.92;10.92;10.92
 ;;LF CONTROL POT;LCTC;10.92;10.92;10.92;10.92;10.92
 ;;LOW DRAIN CIRCUIT;LD;16.8;16.8;16.8;16.8;16.8
 ;;MPO CONTROL POT;MPO;10.92;10.92;10.92;10.92;10.92
 ;;NOISE SUPPRESSION SWITCH;NSS;12.6;12.6;12.6
 ;;PUSH PULL;PP;16.8;16.8;16.8;16.8
 ;;PUSH PULL W/ DUAL RECEIVER;PPDR;33.6
 ;;SCREW SET VC;SSVC;10.92;10.92;10.92;10.92;10.92
 ;;SOFT CANAL;SOFT;8.4;8.4;8.4
 ;;TELEPHONE COIL WITH SWITCH;TC/S;12.6;12.6;12.6
 ;;TELE  COIL W/BOOSTER & SWITCH;TC/BS;16.8;16.8;16.8