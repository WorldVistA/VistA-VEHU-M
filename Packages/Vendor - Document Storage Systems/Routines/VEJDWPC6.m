VEJDWPC6 ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**12**;Dec 17, 1997
 ;ORQ12 ; slc/dcm - Get patient orders in context ;4/10/97  07:09
GET(IFN,NEWD,DETAIL,ACTOR) ; -- Setup TMP array
 ; IFN=ifn of order
 ; NEWD=3rd subscript in ^TMP("ORR",$J, node (ORLIST)
 ; DETAIL=see description in ^ORQ1
 ;
 N X0,X3,X4,X6,TXT,STAT,START,DG,STOP,ENTERD
 S ORLST=ORLST+1,^TMP("ORGOTIT",$J,IFN)=""
 I '$G(DETAIL) S ^TMP("ORR",$J,NEWD,ORLST)=IFN_$S($G(ACTOR):";"_ACTOR,1:"") Q
 S X0=^OR(100,IFN,0),X3=$G(^(3)),X4=$G(^(4)),X6=$G(^(6))
 S DG=$P(X0,U,11),DG=$P($G(^ORD(100.98,+DG,0)),U,3)
 S STAT=$S($P(X3,U,3):$P(^ORD(100.01,$P(X3,U,3),0),U,1,2),1:"") ;.01^abbr
 S ENTERD=$P(X0,U,7),START=$P(X0,U,8),STOP=$P(X0,U,9)
 ; S FLAGREA=$P(X6,U,7)
 S ^TMP("ORR",$J,NEWD,ORLST)=IFN_$S($G(ACTOR):";"_ACTOR,1:"")_U_DG_U_ENTERD_U_START_U_STOP_U_STAT
 D TEXT(.TXT,IFN) M ^TMP("ORR",$J,NEWD,ORLST,"TX")=TXT
 Q
 ;
TEXT(ORTX,ORIFN,WIDTH) ; -- Returns text of order ORIFN in ORTX(#)
 N OR0,OR3,OR6,X,Y,FIRST,ORI,ORJ,DLG,ORX,ORACT
 K ORTX S:'$G(WIDTH) WIDTH=244
 S ORACT=$P(ORIFN,";",2),ORIFN=+ORIFN S:'ORACT ORACT=1
 S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR6=$G(^(6)),FIRST=+$O(^(1,0))
 S ORTX=1,ORTX(1)=$S($P(OR0,U,14)=$O(^DIC(9.4,"C","OR",0)):">>",1:"")
 S ORX=$G(^OR(100,ORIFN,8,ORACT,0)),X=$$ACTION($P(ORX,U,2)) D:$L(X) ADD
 I $P(ORX,U,2)="NW",$P(OR3,U,11),'$G(ORIGVIEW) D  ; Changed or Renewed
 . I $P(OR3,U,11)=2 S X="Renew" D ADD Q
 . N ORIG S ORIG=+$P(OR3,U,5) Q:'ORIG  Q:$P(OR3,U,11)'=1
 . S X="Change" D ADD S ORI=0
 . F  S ORI=$O(^OR(100,ORIG,1,ORI)) Q:ORI'>0  S X=$G(^(ORI,0)) S:$E(X,1,3)=">> " X=$E(X,4,999) D ADD
 . S X=" to" D ADD
T1 S ORI=0 F  S ORI=$O(^OR(100,ORIFN,1,ORI)) Q:ORI'>0  S X=$G(^(ORI,0)) S:(FIRST=ORI)&($E(X,1,3)=">> ") X=$E(X,4,999) D:$L(X) ADD
 S DLG=$P(OR0,U,5) K Y I DLG,$P(DLG,";",2)["101.41",$D(^ORD(101.41,+DLG,9)) X ^(9) I $L($G(Y)) S X=Y D ADD ; additional text
 ; I $P(OR3,U,11)=2 S X="(Renewal)" D ADD
 I $P(ORX,U,4)=2 S X="*UNSIGNED*" D ADD
 I $P(ORX,U,2)="DC"!("^1^13^"[(U_$P(OR3,U,3)_U)),$L(OR6) S X=" <"_$S($L($P(OR6,U,5)):$P(OR6,U,5),$P(OR6,U,4):$P($G(^ORD(100.03,+$P(OR6,U,4),0)),U),1:"")_">" D:$L(X)>3 ADD ; DC Reason
 I $D(XQAID),$G(ORFLG)=12 S ORX=$G(^OR(100,ORIFN,8,ORACT,3)) I $P(ORX,U) S X=" Flagged "_$$DATETIME($P(ORX,U,3))_$S($P(ORX,U,4):" by "_$$NAME($P(ORX,U,4)),1:"")_": "_$P(ORX,U,5) D ADD ; Flagged - show in FUP
 Q
 ;
LAST(CODE) ; -- Return DA of last occurence of CODE action
 N DA
 I '$L($G(CODE)) S DA=$O(^OR(100,ORIFN,8,"A"),-1) ; last entry
 E  S DA=$O(^OR(100,ORIFN,8,"C",CODE,"?"),-1) ; last CODE entry
 Q DA
 ;
ACTION(X) ; -- Returns text of action X
 N Y
 S Y=$S(X="DC":"Discontinue",X="HD":"Hold",X="FL":"Flag",X="UF":"Unflag",1:"")
 Q Y
 ;
DATETIME(X) ; -- Returns date/time in format 00/00/00@00:00am
 N Y,D,T,T1,Z
 S D=$P(X,"."),T=$E($P(X,".",2)_"0000",1,4),T1=$E(T,1,2),Z="AM"
 S:T1>12 T1=T1-12,Z="PM"
 S Y=$E(D,4,5)_"/"_$E(D,6,7)_"/"_(1700+$E(D,1,3))_"@"_T1_":"_$E(T,3,4)_Z
 Q Y
 ;
NAME(X) ; -- Returns name as Lname,F
 N Y,Z S Z=$P($G(^VA(200,+X,0)),U) Q:Z="" ""
 S Y=$P(Z,",")_"," F I=$F(Z,","):1:$L(Z) I $E(Z,I)'=" " S Y=Y_$E(Z,I) Q
 S Y=$$LOWER^VALM1(Y) ; mixed case
 Q Y
 ;
ADD ; -- Add text X to ORTX()
 N I,Y S Y=$L(ORTX(ORTX))
 I $E(X)=" ",Y S ORTX=ORTX+1,ORTX(ORTX)="",Y=0,X=$E(X,2,999) ;new line
 I $L(ORTX(ORTX)_" "_X)'>WIDTH S ORTX(ORTX)=ORTX(ORTX)_$S(Y:" ",1:"")_X Q
 F I=1:1:$L(X," ") S:$L(ORTX(ORTX)_" "_$P(X," ",I))>WIDTH ORTX=ORTX+1,Y=0 S ORTX(ORTX)=$G(ORTX(ORTX))_$S(Y:" ",1:"")_$P(X," ",I),Y=1
 Q
