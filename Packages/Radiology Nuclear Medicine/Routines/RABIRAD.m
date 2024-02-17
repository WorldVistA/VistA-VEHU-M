RABIRAD ;HIOFO/SM - BI-RADS processing ; Sep 25, 2023@08:38:32
 ;;5.0;Radiology/Nuclear Medicine;**97,206**;Mar 16, 1998;Build 8
 Q
EN1() ;called from ^DD(78.3,0,"ID","WRITE") node
 ;p206/KLM - ** Deprecated **display file 78.3's EXPRESSION's external form from file 757.01
 ;Display file 78.3's DISPLAY TEXT field which replaced the EXPRESSION field.
 ; IA 1571
 ; ^(0) is ^RA(78.3,-,0)
 N RAX,RAY,RA2
 S RA2=$P(^(0),U,2) ;fld 2 description
 ;S RAX=$$GET1^DIQ(757.01,+$P(^(0),U,6),.01) ;**Deprecated** Ext. expression fld 6
 ;p206/KLM - EXPRESSION is now in DISPLAY TEXT field 100 (Y defined in FM)
 S RAX=$$GET1^DIQ(78.3,Y,100)
 I RAX'="" D  ;assume field 6 has data only for BIRADS records
 .S RAY="("_RAX_")"
 .Q
 E  D  ;display Description only for iens 1200 thru 1202
 .S RA2=$S((Y>1199)&(Y<1203):RA2,1:"")
 .S RAY=$S(RA2="":"",1:"("_RA2_")")
 Q RAY
 ;
CKREQ ; check if case requires at least one BIRAD code
 N RA732,RACPT,RAPROC
 S RABIREQ=0 ;=0 not require birad, =1 require birad
 S RAPROC=$P(RA7003,U,2)
 S RACPT=$P(^RAMIS(71,RAPROC,0),U,9)
 S RA732=$O(^RA(73.2,"B",RACPT,0)) Q:RA732=""
 I $P(^RA(73.2,RA732,0),U,8)="Y",$P(^(0),U,4)="MAMMOGRAPHY",$P(^(0),U,3)="IMAGING" S RABIREQ=1
 Q
 ;
CKDATA ;check if case has any BIRAD data
 Q:'RABIREQ
 N RAX,RAX2,RAX3
 S RABIENS="^" ;string of IENS that are BIRAD codes
 S RABIDAT=0 ;=0 no birad data, =1 has birad in either prim. or sec. diag
 ; find birad iens after ien 1099, look for:
 ; piece 1 has "BI-RADS CATEGORY" and field 100 has data
 S RAX=1099
 ;p206 - Remove field 6 dependency, use field 100
 F  S RAX=$O(^RA(78.3,RAX)) Q:'RAX  S RAX2=$G(^(RAX,0)),RAX3=$G(^RA(78.3,RAX,1)) I $P(RAX2,U)["BI-RADS CATEGORY",RAX3]"" S RABIENS=RABIENS_RAX_"^"
 I RABIENS[("^"_$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,13)_"^") S RABIDAT=1 Q
 S RAX=0
 F  S RAX=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX","B",RAX)) Q:'RAX  I RABIENS[("^"_RAX_"^") S RABIDAT=1 Q
 I 'RABIDAT D WARN
 Q
WARN ;
 I RAFIRST W !!?5,"This exam cannot reach the 'COMPLETE' status until a BI-RADS code is entered.",!
 E  W !!?5,"This case requires a BI-RADS code.  It either had a BI-RADS code ",!?5,"that was deleted or never had one.  Please use this option to ",!?5,"re-enter a BI-RADS code.",!
 Q
ASK() ;
 S DIR(0)="Y",DIR("A")="Do you want to re-edit diagnostic codes "
 S DIR("B")="NO" D ^DIR K DIR
 Q Y
