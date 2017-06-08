DSICUSR ;DSS/SGM - USER CLASS & ROLE UTILITIES ;11/18/2004 14:54
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  Supported References
 ; -----  --------------------------------------
 ;  2054  DT^DILF
 ;  2324  WHATIS^USRLM [controlled subscription]
 ; 10103  $$FMTE^XLFDT
 ; 10104  $$UP^XLFSTR
 ;
USRCLASS(DSIC,INPUT) ; rpc: DSIC USR CLASS MEMBERSHIP
 ; given a user, return a list of user class membership
 ; RETURN: DSIC(n) = p1^p2^p3^p4^p5  where n=1,2,3,4,...
 ;   p1 = pointer to 8930       p4 = FM effective date;external date
 ;   p2 = pointer to 8930.3     p5 = FM expiration date;external date
 ;   p3 = display name of user class from 8930
 ; INPUT(n) = name^value  where n=0,1,2,3,...
 ;   Required: name=USER, value=DUZ
 ;   Optional: name=DATE, value=FM date, or "*", or "T"
 ;      DATE     Return class memberships that are:
 ;   ----------  ----------------------------------------
 ;   not passed  active as of TODAY
 ;     <null>    active as of TODAY
 ;       "T"     active as of TODAY
 ;       "*"     all, whether active or not
 ;     FM date   active as of that FM date
 ;
 ;If problems, return DSIC(1) = -1^msg
 ;
 N A,I,X,Y,Z,CNT,DATE,DSIA,DSIX,USER
 I $O(INPUT(""))="" D ERR(1) Q
 S I="" F  S I=$O(INPUT(I)) Q:I=""  S Z=INPUT(I) D
 .S X=$P(Z,U),Y=$P(Z,U,2) S:X?.E1L.E X=$$UP^XLFSTR(X)
 .I X="USER",Y>0 S USER=+Y
 .I X="DATE" S DATE=Y
 .Q
 S:"T"[$G(DATE) DATE=DT I DATE,DATE["." S DATE=$P(DATE,".")
 I DATE'="*" D DT^DILF(,DATE,.DSIX,,"DSIA") I DSIX=-1 D ERR(3,DATE) Q
 I $G(USER)="" D ERR(2) Q
 I +USER'=USER D ERR(5,USER) Q
 K DSIA,DSIX D WHATIS^USRLM(USER,"DSIX")
 I $O(DSIX(0))="" D ERR(4) Q
 S (I,CNT)=0 F  S I=$O(DSIX(I)) Q:I=""  S Z=DSIX(I) D
 .K DSIA F Y=1:1:5 S DSIA(Y)=$P(Z,U,Y)
 .I DATE Q:DATE<DSIA(4)  I DSIA(5),DATE>DSIA(5) Q
 .I DSIA(4) S $P(DSIA(4),";",2)=$$FMTE^XLFDT(DSIA(4)\1)
 .I DSIA(5) S $P(DSIA(5),";",2)=$$FMTE^XLFDT(DSIA(5)\1)
 .S CNT=CNT+1 F X=1:1:5 S $P(DSIC(CNT),U,X)=DSIA(X)
 .Q
 I 'CNT D ERR(4)
 Q
 ;
ERR(X,Y) ;
 I X=1 S X="No INPUT array received"
 I X=2 S X="No user DUZ received"
 I X=3 S X="Invalid date received: "_Y
 I X=4 S X="No user class memberships found"
 I X=5 S X="Invalid user DUZ received: "_Y
 S:+X'=-1 X="-1^"_X
 S DSIC(1)=X
 Q
