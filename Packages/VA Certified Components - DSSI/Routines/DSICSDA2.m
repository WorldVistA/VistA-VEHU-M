DSICSDA2 ;DSS/TPA - INTERFACE TO SCHED REDESIGN
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This routine should only be invoked by the DSICSDA routine
 ;
 ;DBIA#  Supported Reference
 ;-----  -------------------------------------------
 ;4433   $$SDAPI^SDAMA301
 ;10040  direct global read of file 44, fields .01;3
 ;10103  $$FMTE^XLFDT
 ;
GET(DSIC,INPUT) ; RPC: DSIC SD GET 
 N I,J,X,Y,Z,DFN,DSICIN,DSICL,DSIDFN,DSIDIV,DSIFILT,DSISTOP,DSIX,END,FLDS
 N MAX,NOKILL,RET,ROOT,SORT,START,STATUS,STOP,TYPE
 S DSIC=$NA(^TMP("DSIC",$J)) K @DSIC
 Q:'$$INIT  S DSIX=$$SDAPI^SDAMA301(.DSICIN)
 I 'DSIX S @DSIC@(1)="-1^No appointments found"
 E  D RETURN:DSIX>0,ERROR:DSIX<0
 K ^TMP($J)
 Q
 ;
 ;----------  subroutines  ----------
DATE() Q $$FMTE^XLFDT(Y,"5Z")
 ;
ERR(X) ;
 ;;You must send at least one clinic or patient name
 ;;No starting date received
 ;;No ending date received
 S:RET=1 RET="-1^"
 S:+X=X X=$P($T(ERR+X),";",3) S RET=RET_X_"; "
 Q
 ;
ERROR ; process error global
 S X="" F I=0:0 S I=$O(@ROOT@(I)) Q:'I  S X=X_^(I)_"; "
 S @DSIC@(1)="-1^"_X
 Q
 ;
INIT ;  initialize variable
 ;;N A S A=$P(DATA(14),";",2) S:A="" A=$P(DATA(13),";",3) I A'="",$D(DSISTOP(A))
 ;;I ";"_STATUS_";"[$P(DATA(3),";")
 ;;I CIEN S Y=+$P($G(^SC(CIEN,0)),U,4) I Y,$D(DSIDIV(Y))
 ;  DSIFILT() will be set up to do additional filtering of return data
 ;  if necessary.  It will consist or executable M code expecting value
 ;  to be evaluated to be contained in X.
 N CNT,FLDX S CNT=0,RET=""
 S ROOT=$NA(^TMP($J,"SDAMA301")),STOP=$P(ROOT,")")_","
 K ^TMP($J)
 S X=$$PARSE^DSICSDA0 I +X=-1 S @DSIC@(1)=X Q 0
 S X=$O(DSIDFN(0)),Y=$O(DSICL(0))
 I 'X,'Y D ERR(1) Q 0
 I X S CNT=CNT+1,DSICIN(4)="DSIDFN("
 I Y S CNT=CNT+1,DSICIN(2)="DISCL("
 S:$G(FLDS)="" FLDS="1;2;3;4;8;12"
 S X=";"_FLDS_";",FLDX=FLDS
 I +FLDS'=1 S FLDX="1;"_FLDX
 I X'[";2;" S FLDX=FLDX_";2"
 I X'[";4;" S FLDX=FLDX_";4"
 I $D(DSISTOP) D
 .I X'[";13;" S FLDX=FLDX_";13"
 .I X'[";14;" S FLDX=FLDX_";14"
 .Q
 S DSICIN("FLDS")=FLDX
 I +$G(MAX) S DSICIN("MAX")=MAX
 I $G(STATUS)="" S STATUS="R;I;NT"
 S NOKILL=$G(NOKILL,0) I 'NOKILL K @DSIC
 S:'$G(SORT) SORT=3
 I 'START D ERR(2)
 I 'END D ERR(3)
 S CNT=CNT+1,DSICIN(1)=START_";"_END
 S X=0
 I $D(DSISTOP) D
 .I CNT<3 S CNT=CNT+1,DSICIN(13)="DSISTOP("
 .E  S X=X+1,DSIFILT(X)=$P($T(INIT+1),";",3,99)
 .Q
 I CNT<3 S DSICIN(3)=STATUS
 E  S X=X+1,DSIFILT(X)=$P($T(INIT+2),";",3,99)
 I $D(DSIDIV) S X=X+1,DSIFILT(X)=$P($T(INIT+3),";",3,99)
 Q 1
 ;
RETURN ;  process return array - may do additional filtering
 N APPT,CIEN,CNAME,CNT,DATA,DFN,NEG,ROOTX,PAT,SORT1,SORT2,VAL
 S ROOTX=$$SORT
 F I=1:1:$L(FLDS,";") S X=$P(FLDS,";",I) S:X FLDS(X)=""
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  S Z=@ROOT D
 .K DATA F I=1:1:23 S DATA(I)=$P(Z,U,I)
 .F I=1,9,11,16,17,19,20,21 S Y=+DATA(I) S:Y $P(DATA(I),";",2)=$$DATE
 .;  comments stored on "C" node subtree
 .S Z=$Q(@ROOT)
 .I Z'="",$QS(Z,$QL(Z))="C" S ROOT=Z,DATA(6)=@Z
 .;  set subscript variables in ROOTX
 .S APPT=DATA(1)*NEG
 .S CIEN=+DATA(2),CNAME=$P(DATA(2),";",2) S:CNAME="" CNAME=" "
 .S DFN=+DATA(4),PAT=$P(DATA(4),";",2) S:PAT="" PAT=" "
 .;  if additional filters, Xecute
 .S Z=1 I $D(DSIFILT) D  Q:'Z
 ..F I=0:0 S I=$O(DSIFILT(I)) Q:'I  X DSIFILT(I) E  S Z=0 Q
 ..Q
 .S CNT=1+$O(@ROOTX@("A"),-1)
 .S VAL="" F I=0:0 S I=$O(FLDS(I)) Q:'I  S $P(VAL,U,I)=DATA(I)
 .S @ROOTX=VAL
 .Q
 I '$D(@DSIC) S @DSIC@(1)="-1^No appointments found"
 Q
 ;
SORT() ;
 S NEG=$S(SORT=2!(SORT=6):-1,1:1)
 I SORT<3 Q "^TMP(""DSIC"",$J,1,PAT,APPT,CNT)"
 I SORT=3 Q "^TMP(""DSIC"",$J,PAT,CNAME,APPT,CNT)"
 I SORT=4 Q "^TMP(""DSIC"",$J,PAT,CIEN,APPT,CNT)"
 I SORT>4,SORT<7 Q "^TMP(""DSIC"",$J,1,DFN,APPT,CNT)"
 I SORT=7 Q "^TMP(""DSIC"",$J,DFN,CNAME,APPT,CNT)"
 I SORT=8 Q "^TMP(""DSIC"",$J,DFN,CIEN,APPT,CNT)"
 I SORT=9 Q "^TMP(""DSIC"",$J,1,CNAME,APPT,CNT)"
 I SORT=10 Q "^TMP(""DSIC"",$J,CNAME,PAT,APPT,CNT)"
 I SORT=11 Q "^TMP(""DSIC"",$J,CNAME,DFN,APPT,CNT)"
 I SORT=12 Q "^TMP(""DSIC"",$J,CIEN,PAT,APPT,CNT)"
 Q "^TMP(""DSIC"",$J,CNAME,PAT,APPT,CNT)"
