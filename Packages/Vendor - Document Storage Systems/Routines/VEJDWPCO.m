VEJDWPCO ;wpb/gbh - routine modified for dental GUI;8/2/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**27**;Dec 17, 1997
 ;ORCHTAB ;SLC/MKB-Build Chart tab listings ;4/17/97  10:36
 ;
DATETIME(X,LF) ;
 N D,T,Y,YR,TM S D=$P(X,"."),T=$P(X,".",2) I D="" Q ""
 I 'D Q $E($$FTDATE^ORCD(X),1,11) ; free text
 S Y=$E(D,4,5)_"/"_$E(D,6,7),YR=1700+$E(D,1,3),TM=""
 I T S:$L(T)<4 T=T_$E("0000",1,4-$L(T)) S TM=$E(T,1,2)_":"_$E(T,3,4)
 I '$G(LF) S Y=Y_"/"_$E(YR,3,4)_$S(TM:" "_TM,1:"") ;not Order Long Format
 E  S Y=Y_$S(X'<($$NOW^XLFDT-10000):" "_TM,LF=1:" "_YR,1:"/"_$E(YR,3,4))
 Q Y
