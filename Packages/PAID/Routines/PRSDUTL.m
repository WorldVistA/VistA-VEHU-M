PRSDUTL ;HISC/GWB-PAID DOWNLOAD UTILITY SUB-ROUTINES ;8/4/94  11:22
 ;;3.5;PAID;;Jan 26, 1995
SEPIND ;Separation Ind
 S SEPNAME=$P(^PRSPC(IEN,0),U,1),TL=$P(^PRSPC(IEN,0),U,8)
 S CCORG=$P(^PRSPC(IEN,0),U,49)
 S SEPIND="" S:$D(^PRSPC(IEN,1)) SEPIND=$P(^PRSPC(IEN,1),U,33)
 I DATA="Y" D
 .I TL'="",TYPE'="E" S $P(^PRSPC(IEN,0),U,8)="" K ^PRSPC("ATL"_TL,SEPNAME,IEN)
 .I CCORG'="" K ^PRSPC("ACC",CCORG,IEN)
 I DATA="N" D
 .I CCORG'="" S ^PRSPC("ACC",CCORG,IEN)=""
 .I TYPE="E",SEPIND="Y" D
 ..I $D(^PRSPC(IEN,"ANNUAL")) F P=2,3,4,5,6,7,9,10,11,12,13,14 S $P(^PRSPC(IEN,"ANNUAL"),U,P)=""
 ..I $D(^PRSPC(IEN,"LWOP")) F P=2,3,5,6,7,8,9,11 S $P(^PRSPC(IEN,"LWOP"),U,P)=""
 ..K ^PRSPC(IEN,"BAYLOR"),^PRSPC(IEN,"COMP")
 ..K ^PRSPC(IEN,"MILITARY"),^PRSPC(IEN,"SICK")
 K SEPNAME,TL,CCORG,SEPIND,P Q
