AXAPCHS ;WPB/JLTP/GBH ; INCOMING PATCH RECEIVER SERVER ; 15-JUL-98
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
 N BUILD,COMPLYDT,DA,DOM,DIC,DIE,DLAYGO,DR,DRS,MTYPE,NMSP,NOTES
 N PPP,PPV,PRIO,PSUB,ROUTINE,SEQ,TVER
 D DOM^AXAPCHU K NOTES S NOTES=0
 S MTYPE=$$PARS(XMZ) I 'MTYPE Q
 I '$$UNIQ(DESIG) Q
 S DA=$$NEW(DESIG) Q:DA<0
 S DRS=".02^NMSP^.03^BUILD^.04^TVER^.07^DT^.08^COMPLYDT^2.07^STAT^"
 S DRS=DRS_".17^PSUB^.18^SEQ^.21^PRIO^"
 S DRS=DRS_$S(DOM(0)="TEST":.19,1:.2)_U_"XMZ"
 S DR=$$BLD(DRS) S DIE=DIC D ^DIE
 I $D(ROUTINE) D ROU,MAP,MODS K ROUTINE
 S PPP=$O(^AXA(548260,"C",NMSP,0)) I 'PPP D
 .D NOTE("WARNING! NO CORRESPONDING PACKAGE FOR NAMESPACE "_NMSP)
 .D NOTE("Check PATCH PACKAGE File (#548260).")
 I PPP S PPV=$P($G(^AXA(548260,PPP,0)),U,17) I +$P(DESIG,"*",2)'=+PPV D
 .D NOTE("WARNING! CURRENT PACKAGE VERSION IS "_PPV)
 .D NOTE("THIS PATCH IS FOR VERSION "_$P(DESIG,"*",2))
 I PPP D
 .N PA,PP,SA,SP,PPF
 .S PPF=548260,PA=$$GET1^DIQ(PPF,PPP,"PRIMARY ADPAC")
 .S PP=$$GET1^DIQ(PPF,PPP,"PRIMARY PROGRAMMER")
 .S SA=$$GET1^DIQ(PPF,PPP,"SECONDARY ADPAC")
 .S SP=$$GET1^DIQ(PPF,PPP,"SECONDARY PROGRAMMER")
 .D NOTE(" ")
 .D NOTE("Primary Programmer: "_PP),NOTE("Primary Adpac: "_PA)
 .D NOTE("Secondary Programmer: "_SP),NOTE("Secondary Adpac: "_SA)
 .D NOTE(" ")
 I NOTES S X=$$ENT^XMA2R(XMZ,"NOTES",.NOTES,"","WPB PATCHMAN") K NOTES
 D FORWARD
 D XMZ^AXAPCHS1(DESIG,XMZ) ;Send Message # To Other Account
 Q
PARS(M) ;------ Parse Message & Determine Type ------
 ; Return Value
 ; 0 - Unknown
 ; 1 - Released KIDS Patch
 ; 2 - Test KIDS Patch
 ; 3 - Released Message Only
 ; 4 - Test Message Only
 ; 
 S SUBJ=$P(^XMB(3.9,M,0),U),(REL,KIDS,TEST,DONE)=0,STAT="NEW"
 S REL=SUBJ?.E1"Released "1.4A1"*"1.5ANP1"*"1.3N.E
 S L=0 F  S L=$O(^XMB(3.9,M,2,L)) Q:'L  S X=$G(^(L,0)) D  Q:DONE
 .S X=$TR(X,$C(34),"")
 .I X["$KID" S KIDS=1,BUILD=$P(X,"$KID ",2)
 .I 'KIDS,X["Designation: " S DESIG=$P(X,"Designation: ",2) D
 ..S NMSP=$P(DESIG,"*"),VER=$P(DESIG,"*",2)
 .I 'KIDS,X["Subject:" S PSUB=$E($P(X,"Subject:",2),1,40) D
 ..F  Q:PSUB=""  Q:$E(PSUB)'=" "  S PSUB=$E(PSUB,2,99)
 .I 'KIDS,X["SEQ #" S SEQ=+$P(X,"SEQ #",2)
 .I 'KIDS,X["Compliance Date:" S COMPLYDT=$P(X,"Compliance Date: ",2)
 .I 'KIDS,X["Priority: " S PRIO=$P(X,"Priority: ",2)
 .I 'KIDS,X["Status: Under Development" D
 ..S TVER=$P(SUBJ,"*",3)
 ..F  Q:TVER=""  Q:$E(TVER)'?1N  S TVER=$E(TVER,2,99)
 ..F  Q:TVER=""  Q:$E(TVER)?1N  S TVER=$E(TVER,2,99)
 ..F  Q:$E(TVER,$L(TVER))'=" "  S TVER=$E(TVER,1,$L(TVER)-1)
 ..S TEST=1
 .I KIDS,$E(X,1,3)="RTN",$L(X,",")=2 S ROUTINE($P($P(X,",",2),")"))=""
 I KIDS,REL Q 1
 I KIDS,TEST Q 2
 I REL Q 3
 I TEST Q 4
 Q 0
NEW(X) ;------ Force New Patch Entry ------
 S DIC="^AXA(548261,",DIC(0)="L",DLAYGO=548261 K DD,DO D FILE^DICN
 Q +Y
BLD(X) ;------ Build DR String ------
 N I,F,V,Y
 S Y=""
 F I=1:2 Q:$P(X,U,I)=""  D
 .S F=$P(X,U,I),V=$P(X,U,I+1)
 .I $G(@V)]"" S Y=Y_F_"///^S X="_V_";"
 Q Y
ROU ;------ Hard Set Routine Multiple ------
 N X,C
 S X="",C=0 F  S X=$O(ROUTINE(X)) Q:X=""  D
 .S C=C+1,^AXA(548261,DA,100,C,0)=X
 .S ^AXA(548261,DA,100,"B",X,C)=""
 .S ^AXA(548261,"R",X,DA,C)=""
 S ^AXA(548261,DA,100,0)="^548261.01^"_C_U_C
 Q
MAP ;------ Check For Mapped Routines ------
 Q:^%ZOSF("OS")'["DSM"
 N I,MAPI,R,UCI,VOL,X
 X ^%ZOSF("UCI") S UCI=$P(Y,","),VOL=$P(Y,",",2)
 D MAPI^AXARMAP(UCI,VOL,0)
 S X="" F  S X=$O(MAPI(X)) Q:X=""  K:'$D(ROUTINE(X)) MAPI(X)
 I $O(MAPI(""))="" Q
 D NOTE(" ")
 D NOTE("WARNING! THIS PATCH CONTAINS MAPPED ROUTINES"),NOTE(" ")
 S (R,X,I)="" F  S R=$O(MAPI(R)) Q:R=""  D
 .S I=I+1 I I>8 D NOTE(X) S X="",I=1
 .S X=X_R_$E("         ",$L(R)+1,9)
 D NOTE(X)
 Q
MODS ;------ Check For Local Mods ------
 N I,MOD,R,X,Y
 S X="" F  S X=$O(ROUTINE(X)) Q:X=""  D
 .S Y=0 F  S Y=$O(^AXA(548071,"F","R."_X,Y)) Q:'Y  D
 ..Q:$P(^AXA(548071,Y,0),U,11)  ;Mod is retired
 ..S V=$P($G(^AXA(548071,Y,0)),U,4) S:V]"" X=X_" (Ver "_V_")"
 ..S MOD(X)=""
 I $O(MOD(""))="" Q
 D NOTE(" ")
 D NOTE("WARNING! THIS PATCH CONTAINS LOCALLY MODIFIED ROUTINES")
 D NOTE(" ")
 S (R,X,I)="" F  S R=$O(MOD(R)) Q:R=""  D
 .S I=I+1 I I>3 D NOTE(X) S X="",I=1
 .S X=X_R_$E("                  ",$L(R)+1,25)
 D NOTE(X)
 Q
NOTE(X) ;------ Add To NOTES Array ------
 S NOTES=NOTES+1
 S NOTES(NOTES,0)=X
 Q
UNIQ(X) ;------ Make Sure Patch Is Unique ------
 S UNIQ=1
 S DA=0 F  S DA=$O(^AXA(548261,"B",X,DA)) Q:'DA  D
 .S Y=$P($G(^AXA(548261,+DA,0)),U,4) I Y]"" S PREV(Y)=DA
 .I Y=$G(TVER) S UNIQ=0 Q
 I UNIQ D
 .S PREVHI=$O(PREV(""),-1)
 .I $S('PREVHI:0,'TEST:1,TVER>PREVHI:1,1:0) S X=PREV(PREVHI),Z=XMZ D SUPER
 Q UNIQ
SUPER ;------ Notify OF Superceeded Test Version ------
 I DOM(0)'="LIVE" Q  ; Only Notify In Production
 N XMZ,XMTEXT,XMY,XMSUB,XMDUZ,XMDUN,XMB,REPLY,OLDMES
 D SU^AXAPCHU(+X,"SUPERCEEDED")
 S X=$G(^AXA(548261,+X,0)) I X="" Q
 S OLDMES=$P(X,U,20)
 S REPLY(1,0)=DESIG_" Test Version "_PREVHI_" superceeded by "_$S('TEST:"Released Version.",1:"Version "_$G(TVER)_".")
 S REPLY(2,0)="New Message #"_Z
 S X=$$ENT^XMA2R(OLDMES,"Superceeded",.REPLY,"","WPB PATCHMAN")
 Q
FORWARD ;------ Forward To ADPACS ------
 N I,P,X,XMY,Y
 F I=0:0 S I=$O(^AXA(548260,"C",NMSP,I)) Q:'I  D
 .S X=$G(^AXA(548260,I,0))
 .F P=5,6 I $P(X,U,P) S Y=$P(X,U,P) D
 ..I $P(Y,";",2)="VA(200," S XMY(+Y)="" Q
 ..I $P(Y,";",2)="XMB(3.8," S Y=$P($G(^XMB(3.8,+Y,0)),U) I Y]"" S XMY("G."_Y)=""
 I $D(XMY) S (XMDUZ,XMDUN)="WPB PATCHMAN" D ENT1^XMD
 Q
