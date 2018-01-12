AXAPCHU ;WPB/JLTP ; PATCH UTILITY ROUTINE ; 20-JUL-98
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
PHON(X) ;------ Return Office Phone ------
 S X(1)=+X,X(2)=$P(X,";",2) S:X(2)="" X(2)="VA(200,"
 I X(2)="XMB(3.8," S X=+$P($G(^XMB(3.8,X(1),0)),U,7)
 Q $P($G(^VA(200,+X,.13)),U,2)
PGR(X) ;------ Return Pager ------
 S X(1)=+X,X(2)=$P(X,";",2) S:X(2)="" X(2)="VA(200,"
 I X(2)="XMB(3.8," S X=+$P($G(^XMB(3.8,X(1),0)),U,7)
 S X=$G(^VA(200,+X,.13))
 S X=$S($P(X,U,7)]"":"V "_$P(X,U,7),$P(X,U,8)]"":"D "_$P(X,U,8),1:"")
 Q X
DOM ;------ Set Up Domain Info ------
 S DOM(1)="TEST.WEST-PALM.MED.VA.GOV"
 S DOM(2)="INNOVATION.DOMAIN.GOV"
 S DOM=^XMB("NAME"),DOM(0)=$S(DOM=DOM(1):"TEST",1:"LIVE")
 Q
PPR(PRSN,PKG,R) ;------ Person/Package Relationship ------
 ; INPUT
 ; PRSN = POINTER TO 200
 ; PKG  = POINTER TO 548260
 ; R    = RELATIONSHIP 1:PRIM PROG;2:SECOND PROG;3:PRIM ADP;4:SECOND ADP
 ; RETURN
 ; 1 = TRUE, 0 = FALSE
 Q 1
 N COOL,ROOT,X,Y
 S COOL=0,PRSN=+$G(PRSN),PKG=+$G(PKG),R=+$G(R) I R<1!(R>4) Q COOL
 S R=R+2,X=$P($G(^AXA(548260,U,0)),U,R),ROOT=$P(X,";",2)
 I ROOT="VA(200,",PRSN=+X S COOL=1
 I ROOT="XMB(3.8," D
 .S Y=0 F  S Y=$O(^XMB(3.8,+X,1,Y)) Q:'Y  I +^(Y,0)=PRSN S COOL=1 Q
 Q COOL
ST(DA) ;------ Compute Patch Status ------
 N LIVE,OK,TEST,X
 S X=$G(^AXA(548261,+$G(DA),2))
 S TEST=$P(X,U,1),LIVE=$P(X,U,3),OK=$P(X,U,5),OLD=$P(X,U,7)
 S X=$P($G(^AXA(548260.1,+OLD,0)),U)
 I X=""!($D(AXAPCH("FROM"))) S X=$S(TEST&LIVE:"COMPLETE",LIVE:"IN LIVE ONLY",OK:"OK FOR LIVE",TEST:"IN TEST",1:"NEW")
 S Y=$O(^AXA(548260.1,"B",X,0))
 Q Y_U_X
SU(Y,X) ;------ Manually Update Status ------
 N DA,DIE,DR
 S DIE="^AXA(548261,",DA=Y,DR="2.07///"_X
 D ^DIE Q
PCHST(P,ST,V,SW,C,A) ;----- Return Patches of Specific Status ------
 ; P = IFN of Person or Package (or 0 for ALL) (Required)
 ; ST = Status String - String of Desired Status Codes (Required)
 ; V = Variable for Array of Return Values (Required - Pass by Reference)
 ; SW = 0 to screen by Person, 1 by Package (Default = Person)
 ; C = Capacity(ies) if by person (1=PP, 2=SP, 3=PA, 4=SA)
 ; A = Adding to current list (Don't kill current selections)
 ; Strings Parsed by Comma for ST and C
 ; Result 1=Success, 0=Not
 ; Array returned in V unless count >200, then ^TMP($J,"PCH",
 N STI,STAT,PATCH,COOL,COUNT
 I $P(ST,U)="ONE" S COUNT=1,PATCH=$P(ST,U,2) D  Q 1
 .S ^TMP($J,"PCH",COUNT,0)=^AXA(548261,PATCH,0)
 .S ^TMP($J,"PCH",COUNT,1)=PATCH
 .S ^TMP($J,"PCH",COUNT,2)=^AXA(548261,PATCH,2)
 S P=$G(P),SW=+$G(SW)
 I $G(ST)="" S V(0)=0,V("ERR")="Invalid Status String" Q 0
 I 'SW,$G(C)="" S V(0)=0,V("ERR")="Missing Capacity" Q 0
 I '$G(A) K ^TMP($J,"PCH"),V S COUNT=0
 F STI=1:1:$L(ST,",") S STAT=$P(ST,",",STI) D
 .Q:STAT=""
 .S PATCH="" F  S PATCH=$O(^AXA(548261,"ASTAT",STAT,PATCH)) Q:'PATCH  D
 ..S COOL=$S(P=0:1,SW:$$PKG(PATCH,P),1:$$PRSN(PATCH,P,C)) Q:'COOL
 ..Q:'$$CURVER(PATCH)
 ..S ^(0)=$G(^TMP($J,"PCH",0))+1,COUNT=^(0)
 ..S ^TMP($J,"PCH",COUNT,0)=^AXA(548261,PATCH,0)
 ..S ^TMP($J,"PCH",COUNT,1)=PATCH
 ..S ^TMP($J,"PCH",COUNT,2)=^AXA(548261,PATCH,2)
 I COUNT'>200 M V=^TMP($J,"PCH")
 Q 1
CURVER(P) ;------ Current Version? ------
 S P=$G(^AXA(548261,+$G(P),0)),D=$P(P,U),NS=$P(P,U,2),PV=+$P(D,"*",2)
 S PKG=$O(^AXA(548260,"C",NS,0)),PK0=$G(^AXA(548260,+PKG,0))
 S PKV=+$P(PK0,U,$S($$ACCT="LIVE":17,1:18)) S SAME=(PV=PKV)!(PV=999)
 Q SAME
PKG(PATCH,PKG) ;------ Is Patch In One of These Packages ------
 N COOL,I,X
 S COOL=0,X=$P($G(^AXA(548261,+PATCH,0)),U,2)
 F I=1:1:$L(PKG,",") D
 .I $P($G(^AXA(548260,+$P(PKG,",",I),0)),U,2)=X S COOL=1 Q
 Q COOL
PRSN(PATCH,PERSON,CAPACITY) ;------- Patch Belong to Person? ------
 N COOL,CAP,I,MGI,PC,PCH0,PKG,PKG0,PKGI,X,Y
 S COOL=0,PCH0=$G(^AXA(548261,+PATCH,0)),PKG=$P(PCH0,U,2)
 S PKGI=0 F  S PKGI=$O(^AXA(548260,"C",PKG,PKGI)) Q:'PKGI  D
 .S PKG0=$G(^AXA(548260,PKGI,0))
 .F I=1:1:$L(CAPACITY,",") S CAP=$P(CAPACITY,",",I) D  Q:COOL
 ..S PC=CAP+2 S X=$P(PKG0,U,PC)
 ..I $P(X,";",2)="VA(200," S:+X=PERSON COOL=1 Q
 ..I $P(X,";",2)="XMB(3.8," D
 ...S MGI=0 F  S MGI=$O(^XMB(3.8,+X,1,MGI)) Q:'MGI  S Y=+$G(^(MGI,0)) D
 ....I Y=PERSON S COOL=1
 Q COOL
INSTQ ;------ Queue Installed Update ------
 N ZTQUEUED,ZTSK,ZTRTN,ZTIO,ZTDESC,ZZTDTH,ZTSAVE
 S ZTRTN="INSTU^AXAPCHU",ZTDESC="Update Patch File"
 S ZTDTH=$H,ZTIO="",ZTSAVE("DA")="" D ^%ZTLOAD Q
INSTU ;------ Update Patch File Installed Field ------
 D DOM S DR=$S(DOM(0)="TEST":2.01,DOM(0)="LIVE":2.03,1:"")
 S:DR]"" DR=DR_"///TODAY"
 Q:'$G(DA)  S SUB=$G(^XPD(9.7,DA,2)) Q:SUB=""  S SUB30=$E(SUB,1,30)
 S (DA,Y)=0 F  S Y=$O(^AXA(548261,"ASUB",SUB30,Y)) Q:'Y  D  Q:DA
 .I $P($G(^AXA(548261,Y,1)),U)=SUB S DA=Y
 I DA S DIE="^AXA(548261," D ^DIE
 Q
ACCT() ;------ Which Acct Are We In ------
 N DOM D DOM Q DOM(0)
WHO() ;------ Who Is Updating ------
 I $G(AXAPCH),$G(WHO)]"" Q WHO
 Q $P($G(^VA(200,+$G(DUZ),0)),U)
R(DA,S) ;------ Reply To Patch Message With Status Change ------
 ; X=ZERO NODE OF PATCH
 ; S=NEW STATUS
 N DESIG,SX,XMZ,XMTEXT,XMY,XMSUB,XMDUZ,XMDUN,TEXT,X,Y
 Q:$$ACCT^AXAPCHU()'="LIVE"  Q:$D(AXAPCH("QUIET"))
 S X=$G(^AXA(548261,+$G(DA),0)),SX=$P($G(^AXA(548260.1,+S,0)),U)
 S DESIG=$P(X,U),XMZ=+$P(X,U,20)
 Q:'$D(^XMB(3.9,XMZ,0))
 F X=1:1 S Y=$P($T(STATUS+X),";;",2) Q:Y=""  I SX=$P(Y,U) D  Q
 .S Y=$P(Y,U,2)
 I Y="" Q
 S TEXT(1,0)="Patch "_DESIG_Y
 S TEXT(2,0)="by "_$$WHO()
 S X=$$ENT^XMA2R(XMZ,"Status Change",.TEXT,"","WPB PATCHMAN")
 Q
STATUS ;
 ;;IN TEST^ has been installed in TEST
 ;;OK FOR LIVE^ has been approved for installation in LIVE
 ;;COMPLETE^ has been installed in LIVE
 ;;IN LIVE ONLY^ has been installed in LIVE but is not in TEST
 ;;WRONG VERSION^ marked as WRONG VERSION
 ;;ON HOLD^ placed ON HOLD
 ;;NOT NEEDED^ marked as NOT NEEDED
 ;;CANCELLED^ has been CANCELLED
 ;;
