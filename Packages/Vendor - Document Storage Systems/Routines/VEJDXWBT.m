VEJDXWBT ;DSS/SGM - RPC BROKER TESTER  ;
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This program supports a RPC used by developers to test any
 ;RPC call
 ;
TEST(VEJD,VEJDN,INCL) ;  RPC: VEJD XWB RPC TESTER
 ;  This will return data about any RPC
 ;  VEJDN - Req - name or record number (ien or ifn) of a RPC
 ;   INCL - Opt - Boolean - deafault to 0
 ;          If 1, then include comments from routine
 ;  Return to RPC
 ;    VEJD(1) = tag ^ routine ^ return value type
 ;        (2) = Seq# ^ Input Parameter name ^ Type ^ Max length ^ Req
 ;    (2...n) - there will be a separate row for each input parameter
 ;      (n+1) = !TEXT
 ;      (n+m) = all the description text will follow the !TEXT line
 ;Note: there may be no input parameter rows
 ;If problems or error, return VEJD(1) := -1^message
 ;
 N A,B,I,J,T,X,Y,Z,DIERR,FILE,ROU,TAG,VEJDA,VEJDER,VEJDT,VEJDX,VIEN
 I $G(VEJDN)="" D ERR(1) Q
 S VIEN=$$FIND1^DIC(8994,,"AOQ",VEJDN,"B",,"VEJDER")
 I $D(DIERR) D ERR(0) Q
 S VIEN=VIEN_",",FILE=8994
 D GETS^DIQ(FILE,VIEN,"**",,"VEJDX","VEJDER")
 I $D(DIERR) D ERR(0) Q
 ;  move input params to vejdt
 S X=0 F  S X=$O(VEJDX(8994.02,X)) Q:X=""  D
 .S T=$NA(VEJDX(8994.02,X))
 .S Z=@T@(.01) Q:Z=""
 .S A=U_Z F B=.02,.03,.04,.05 S A=A_U_@T@(B)
 .S J=0,VEJDT(Z)=A
 .F B=0:0 S B=$O(@T@(1,B)) Q:'B  S J=J+1,VEJDT(Z,J)=@T@(1,B)
 .K VEJDX(8994.02,X)
 .Q
 M VEJDA=VEJDX(FILE,VIEN) K VEJDX
 S ROU=VEJDA(.03),TAG=VEJDA(.02)
 I ROU="" D ERR(2) Q
 S X=$T(@(TAG_U_ROU)) I X="" D ERR(3) Q
 I X'["(" D ERR(4) Q
 S J=1,VEJD(1)=TAG_U_ROU_U_VEJDA(.04)
 S Y=$P($TR($P($P(X,"(",2),")"),",",U),U,2,999)
 I Y'="" F I=1:1:$L(Y,U) D
 .S Z=$P(Y,U,I) S:Z'="" J=J+1,VEJD(J)=I_U_Z_U_$P($G(VEJDT(Z)),U,3,6)
 .Q
 S J=J+1,VEJD(J)="!TEXT"
 D PRT
 Q
 ;
ERR(A) ;
 N X,NM
 S NM="RPC "_$S($D(VEJDA(.01)):VEJDA(.01),1:$G(VEJDN))
 I A=1 S X="No RPC name or RPC ien received"
 I A=2 S X=NM_" has no routine defined"
 I A=3 S X="For "_NM_", "_TAG_U_ROU_" does not exist"
 I A=4 S X="For "_NM_", "_TAG_U_ROU_" does not appear as a valid for a RPC"
 I 'A S X=$$MSG^DSICFM01("V",,,,"VEJDER")
 S VEJD(1)="-1^"_X
 Q
 ;
PRT ;  expects VEJDA,VEJDT arrays and J as defined above
 ;  Sets formatted RPC description in VEJD(sub) = text
 N I,X,Y,Z,DIWF,DIWL,DIWR,SEQ,SP,VAR,VEJ,VEJI,VEJJ
 S $P(SP," ",80)="",SEQ=0,VEJJ=J
 S DIWL=1,DIWR=80,DIWF="N" K ^UTILITY($J)
 S X=$E("RPC: "_$G(VEJDA(.01))_SP,1,38)
 S Y=$G(VEJDA(.02))_U_VEJDA(.03) S:Y=U Y=""
 S X=$E(X_Y_SP,1,58)_"Type: "_$G(VEJDA(.04)) D ^DIWP
 S DIWF="I3",VEJI=0
 F  S VEJI=$O(VEJDA(1,VEJI)) Q:'VEJI  S X=VEJDA(1,VEJI) D ^DIWP
 S DIWF="N"
 S X=" " D ^DIWP S X="Return Parameter:" D ^DIWP
 S DIWF="I3",VEJI=0
 F  S VEJI=$O(VEJDA(3,VEJI)) Q:'VEJI  S X=VEJDA(3,VEJI) D ^DIWP
 S DIWF="N"
 S X=" " D ^DIWP S X="Input Parameters:" D ^DIWP S X=" " D ^DIWP
 F VEJ=2:1 S Z=$G(VEJD(VEJ)) Q:'Z  D
 .S VAR=$P(Z,U,2),SEQ=+Z
 .S X=$E($J(SEQ,3)_"  "_VAR_SP,1,34)
 .S X=$E(X_"Max: "_$P(Z,U,4)_SP,1,44)
 .S X=$E(X_"Req: "_$P(Z,U,5)_SP,1,53)
 .S X=X_"Type: "_$P(Z,U,3) D ^DIWP
 .S Y=$P(VEJD(VEJ),U,6) I Y'=SEQ D
 ..S X="   Note file 8994 Seq# = "_Y_".  Actual Seq# = "_SEQ D ^DIWP
 ..Q
 .F VEJI=1:1 Q:'$D(VEJDT(VAR,VEJI))  S X=$E(SP,1,6)_VEJDT(VAR,VEJI) D ^DIWP
 .S X=" " D ^DIWP
 .Q
 I +$G(INCL),$G(VEJDA(.03))'="" D PRT1
 S Y=+$G(^UTILITY($J,"W",1))
 I Y F I=1:1:Y S VEJJ=VEJJ+1,VEJD(VEJJ)=^UTILITY($J,"W",1,I,0)
 K ^UTILITY($J)
 Q
 ;
PRT1 ;  get comments from routine
 N I,X,Y,Z,LINE,ROU,VFR,VTO
 D RLOAD^VEJDSGM1(.ROU,VEJDA(.03)) Q:'$D(ROU)
 S DIWF="N"
 S X=" " D ^DIWP S $P(LINE,"-",80)="",X=LINE D ^DIWP
 S X="   Routine Comments prior to first executable line:" D ^DIWP
 S X="   "_$E(LINE,1,50) D ^DIWP S TO=0
 F VEJI=3:1 S X=$G(ROU(VEJI,0)) Q:$E(X,1,2)'=" ;"  D ^DIWP S VTO=VEJI
 S VEJI=0
 F I=1:1 Q:'$D(ROU(I))  I $P($P(ROU(I,0)," "),"(")=VEJDA(.02) S VEJI=I Q
 I VEJI D
 .S X=" " D ^DIWP
 .S X="   Line tag plus any comment lines before & after line tag"
 .D ^DIWP S X="   "_$E(LINE,1,55) D ^DIWP
 .F I=VEJI-1:-1 Q:'$D(ROU(I,0))  Q:$E($P(ROU(I,0)," ",2))'=";"
 .S VFR=$S(I'>TO:VEJI,I<3:VEJI,1:I+1),VTO=VEJI
 .F I=VEJI+1:1 Q:'$D(ROU(I,0))  Q:$E($P(ROU(I,0)," ",2))'=";"
 .S VTO=$S('$D(ROU(I,0)):I,1:I-1)
 .F VEJI=VFR:1:VTO S X=ROU(VEJI,0) D ^DIWP
 .Q
 Q
 ;RPC: VEJD DD INFO
 ;FILE = FILENUMBER
 ;RETURNS: FIELD#^LABEL^TYPE^POINTER^FIELD LENGTH^DESCRIPTION^HELP-PROMPT"
 ;If type="POINTER", then the POINTER field will be FILE#:FILE NAME
DDINFO(AXY,FILE) N VEJDDAT,VEJDMES,VEJDRTN K AXY
 I '$D(^DD(FILE)) S AXY(0)="FILE #"_FILE_", DOES NOT EXIST" Q
 D FIELDS^VEJDDDR1(.VEJDRTN,FILE)
 S LBL="" F  S LBL=$O(VEJDRTN(LBL)) Q:LBL=""  D
 . S X=VEJDRTN(LBL),FIELD=+VEJDRTN(LBL),ATTRBS="LABEL;TYPE;POINTER;FIELD LENGTH;HELP-PROMPT"
 . D FIELD^DID(FILE,FIELD,"",ATTRBS,"VEJDDAT","VEJDMES")
 . S I=FIELD S AXY(I)=+VEJDRTN(LBL) D
 . I VEJDDAT("TYPE")="POINTER",$G(VEJDDAT("POINTER"))'="" S @("X=$G(^"_VEJDDAT("POINTER")_0_"))") S VEJDDAT("POINTER")=+$P(X,"^",2)_":"_$P(X,"^")
 . N J S J="" F J=1:1:$L(ATTRBS,";") S X=$P(ATTRBS,";",J),AXY(I)=AXY(I)_"^"_VEJDDAT(X)
 Q
