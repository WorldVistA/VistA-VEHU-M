DSIVDM01 ;DSS/SGM - DOCMANAGER TO VISTA IMAGING RPCS ;07/01/2005 18:02
 ;;2.2;INSURANCE CAPTURE BUFFER;;May 19, 2009;Build 12
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This routine is not independently invokable.  It should only be invoked
 ;from ^DSIVDM
 ;
 ; Integration Agreements
 ; 10009      FILE^DICN
 ;  2053      FILE^DIE,UPDATE^DIE
 ;  2054      DT^DILF
 ;  5325      $$MSG^DSICFM01
 ; 10103      $$NOW^XLFDT
 ; 10104      $$UP^XLFSTR
 ;
 ;TRANID - 1921 .01 field value
 ;   APP - code assigned by Jay for a specific DSS application.
 ;
CALLBK ;callback
 N I,J,X,Y,Z,APP,DIERR,DSIA,DSIERR,DSIW,IEN,IENS,ROOT,DSIT,DO
 I $G(DSIV(1))="" Q
 ; if 'ien then record does not exist, add it, set iens
 S IEN=+$$IEN(DSIV(1))
 I IEN S IENS=IEN_",",ROOT=$NA(DSIA(19621,IENS))
 I 'IEN D
 .S X=DSIV(1) S:$E(X,$L(X))?1A X=$$TRANID(X) S DSIT=X
 .S DIC="^DSI(19621,",DIC(0)="L" D FILE^DICN S IEN=+Y,IENS=IEN_"," ;DSIV 1.6 change
 .I IEN<0 S IENS(1)="",ROOT=$NA(DSIA(19621,"+1,")),@ROOT@(.01)=DSIT S IEN=0,IENS=""
 .E  S ROOT=$NA(DSIA(19621,IENS)) ;we added an entry
 .S Y=$P(X,";",2),APP=""
 .F I=1:1:$L(Y) S Z=$E(Y,I) Q:Z'?1U  S APP=APP_Z
 .S:APP="" APP="DM" S @ROOT@(.06)=APP
 .S @ROOT@(.05)=$$NOW(,1),@ROOT@(.04)=.5
 .Q
 S X=$G(DSIV(0)) I X'="" S @ROOT@(.03)=(X>0),@ROOT@(2)=$P(X,U,2)
 I $G(DSIV(2))]"" S @ROOT@(.02)=DSIV(2)
 S I=2,J=0
 F  S I=$O(DSIV(I)) Q:'I  S J=J+1,DSIW(J,0)=DSIV(I)
 I $D(DSIW) S @ROOT@(1)="DSIW"
 ; ien = record#
 Q:'$$LOCK(IEN)
 I 'IEN D UPDATE^DIE(,"DSIA","IENS","DSIERR")
 I IEN D FILE^DIE(,"DSIA","DSIERR")
 D UNLK(IEN)
 Q
 ;
DEL ; delete one or more entries
 N I,X,Y,Z,DSI,IEN,TCNT
 S TCNT=0,TCNT(0)=0
 I $O(DSIVL(""))="" S DSIV="-1^No input array received" Q
 S DSI="" F  S DSI=$O(DSIVL(DSI)) Q:DSI=""  D
 .S X=DSIVL(DSI),IEN=$$IEN(X),TCNT=TCNT+1 Q:IEN<1
 .D FILE(IEN,.01,"@") S TCNT(0)=1+TCNT(0)
 .Q
 I 'TCNT S DSIV="-1^No records deleted" Q
 I TCNT=TCNT(0) S DSIV="1^All records deleted" Q
 S DSIV="1^"_TCNT_" received, "_TCNT(0)_" records deleted"
 Q
 ;
IMP() ;  check to see if VistA Imaging supports import API
 N X,Y,VER,PATCH
 S VER=$$VERSION^DSICXPDU(,"MAG",1)
 S PATCH=$$PATCH^DSICXPDU(,"MAG*3.0*7",1)
 I VER>3!PATCH Q 1
 Q "-1^Your VistA Imaging system does not support the import API"
 ;
STAT ; return statuses of import requests
 N I,X,Y,Z,DATE,DSIT,IEN,RET,STAT,STOP,TCNT,TIME
 N APP,DEL,EDT,MAX,OVERRIDE,SDT,TRANID,WHICH
 D INIT Q:$D(@DSIV)
 ;  get single transaction status
 I TRANID]"" D DOIT(TRANID)
 I TRANID="" F RET=0,1 I WHICH=1!'RET D  Q:STOP
 .F STAT=1,"p",0 I $D(WHICH(STAT)) D  Q:STOP
 ..S DATE=SDT
 ..F  S DATE=$O(^DSI(19621,"AC",APP,RET,STAT,DATE)) Q:DATE>EDT!'DATE  D  Q:STOP
 ...S IEN=0
 ...F  S IEN=$O(^DSI(19621,"AC",APP,RET,STAT,DATE,IEN)) Q:'IEN  D DOIT(IEN)
 ...Q
 ..Q
 .Q
 ; update file 19621 as needed
 F RET="R","D","S" D
 .N FLD,VAL
 .I RET="R" S FLD=.07,VAL=1
 .I RET="D" S FLD=.01,VAL="@"
 .I RET="S" S FLD=.03,VAL=1
 .F IEN=0:0 S IEN=$O(@DSIT@(RET,IEN)) Q:'IEN  D FILE(IEN,FLD,VAL)
 .Q
 I '$D(@DSIV) D ERR(6)
 K @DSIT
 Q
 ;
UPD ; add/del queue
 N I,X,Y,Z,IEN,RET
 ;store temporary error messages in RET()
 D INITU G:$D(RET) UPOUT
 I ACT="D" D
 .I '$$LOCK(IEN) D ERR(12) Q
 .D FILE(IEN,.01,"@"),UNLK(IEN)
 .S RET(1)="1^Record successfully deleted"
 .Q
 I $D(RET) G UPOUT
 N DIERR,DSIERR,DSIFDA
 I ACT="A" S X=TRANID D
 .K DO S DIC="^DSI(19621,",DIC(0)="L" D FILE^DICN S IEN=+Y,IENS=IEN_"," ;DSIV 1.6 change/DSIV 2.2T12
 .I IEN<0 S IENS(1)="",X=$NA(DSIFDA(19621,"+1,")),@X@(.01)=TRANID S IEN=0,IENS=""
 .E  S X=$NA(DSIFDA(19621,IENS)) ;we added an entry
 .Q
 S @X@(.01)=TRANID
 S:QUEUE @X@(.02)=QUEUE
 S @X@(.03)="p"
 S @X@(.04)=DUZ
 S @X@(.05)=$$NOW(,1)
 S @X@(.06)=APP
 S @X@(.07)=0
 S @X@(.08)=$G(TIU) ;V2.2 required for ICR 5351 2/16/09
 I '$$LOCK(IEN) D ERR(9) G UPOUT
 I 'IEN D UPDATE^DIE(,"DSIFDA","IENS","DSIERR")
 I IEN D FILE^DIE(,"DSIFDA","DSIERR")
 D UNLK(IEN)
 I '$D(DIERR) D
 .S X="1^Record successfully added" S:APP'="DM" X=X_U_TRANID
 .S RET(1)=X
 .Q
 I $D(DIERR) D
 .I $G(IEN(1))<1 D ERR(-9)
 .I $G(IEN(1))>0 S RET(1)="1^"_$P($$ERR(14,1),U,2)_$P($$ERR(-9,1),U,2)
 .Q
 ;
UPOUT ;
 K DSIV S X="",I=0
 F  S I=$O(RET(I)) Q:'I  S Y=RET(I) S:X'=""&(+Y=-1) Y=$P(Y,U,2) S X=X_Y_"; "
 S DSIV=$S(X'="":X,1:"-1^Unexpected problem encountered")
 Q
 ;
 ;-------------------------------------------------------
 ;                      SUBROUTINES
 ;-------------------------------------------------------
DATE(X) ; process input date to validate
 N Y,DIERR,DSIVDATE,DSIVDT,DSIVER
 S DSIVDATE=X D DT^DILF("T",X,.DSIVDT,,"DSIVER")
 S Y="" I $D(DIERR) S Y=$$MSG^DSICFM01("VE",,,,"DSIVER") D ERR(0) Q -1
 I Y="" I '$G(DSIVDT) D ERR(3) Q -1
 Q DSIVDT
 ;
DOIT(I) ; I - req - IEN to 19621 or TRANID from 19621
 N A,X,Y,Z,IEN,PRE,STAT,STATUS,TID
 S X=$$IEN(I) I X<1 D ERR(4) Q
 S IEN=+X,TCNT=1+TCNT
 K Z S Z=$G(^DSI(19621,IEN,0)) I Z="" D ERR(5) Q
 S Z(2)=$G(^DSI(19621,IEN,2))
 S TID=$P(Z,U),X=$P(Z,U,3),PRE=$P(Z,U,7),STAT=$S(X="":4,X="p":3,1:1+X)
 ; if status is pending, check to see if import
 I STAT=3 S Y=$$MAG(TID) I Y S STAT=2,STAT(0)="p"
 S STATUS=$P("Error^Successfully Imported^Pending^Unknown",U,STAT)
 ;log of successful entries to delete
 S Y=0 I DEL,STAT=2 S @DSIT@("D",IEN)="",Y=1
 ;log of entries not previously retrieved
 I 'Y,'PRE S @DSIT@("R",IEN)=""
 ;log pending entries that need status updated
 I 'DEL,$D(STAT(0)) S @DSIT@("S",IEN)=""
 D DS(TID_U_STATUS) I Z(2)'="" D DS(Z(2))
 F Z=0:0 S Z=$O(^DSI(19621,IEN,1,Z)) Q:'Z  D DS(^(Z,0))
 D DS("$END")
 I TCNT>MAX S STOP=1
 I 'STOP,'OVERRIDE,$$TDIFF(TIME)>60 S STOP=1
 Q
 ;
DS(X,A) ;
 N NODE S NODE=$S($G(A)>0:"zERR",1:STAT)
 I $G(A) D
 .I A=1 S X="-1^Input parameter TRANID is invalid: "_TRANID
 .I A=2 S X="-1^Queue file record not found for IEN="_IEN
 .Q
 S Y=1+$O(@DSIV@(NODE,"A"),-1),@DSIV@(NODE,Y)=X
 I $G(A)>0 S Y=Y+1,@DSIV@(NODE,Y)="$END"
 Q
 ;
ERR(A,B) ; error processor
 I A=-9 S A=$$MSG^DSICFM01("VE",,,,"DSIERR")
 I A=1 S A="Input parameter WHICH is invalid: "_WHICH
 I A=2 S A="Input parameter APP not received"
 I A=3 S A="Input date parameter is invalid: "_DSIVDATE
 I A=4 S A="Input parameter TRANID is invalid: "_TRANID
 I A=5 S A="Queue file record not found for IEN="_IEN
 I A=6 S A="No data found, unexpected findings"
 I A=7 S A="Invalid action type received: "_ACT
 I A=8 S A="Delete record request received, but no TRANID received"
 I A=9 S A="Unable to lock ~DSI(19621,0), try again"
 I A=10 S A="Delete request received for "_TRANID_", but record not found"
 I A=11 S A="Add request received for "_TRANID_", but record already exists: "_IEN
 I A=12 S A="Unable to lock record "_IEN_", try again"
 I A=13 S A="Add request received with no TRANID and other params missing"
 I A=14 S A="Record added, but problems encountered: "
 I A=15 S A="Problems encountered when trying to add a new Queue record"
 I $G(B) Q "-1^"_A
 S B=1+$O(@DSIV@("A"),-1),@DSIV@(B)="-1^"_A
 Q
 ;
FILE(IEN,FLD,VAL) ; update a field in file
 N I,X,Y,Z,DIERR,DSIVER,DSIVX
 S DSIVX(19621,IEN_",",FLD)=VAL
 D FILE^DIE(,"DSIVX","DSIVER")
 Q
 ;
IEN(NM) ;
 I +NM=NM Q $S($D(^DSI(19621,NM,0)):NM,1:0)
 I NM'?1"DSS;".E Q -1
 Q +$O(^DSI(19621,"B",NM,0))
 ;
INIT ; initialize get status local variables
 N A,I,X,Y,Z
 S TIME=$H,(STOP,TCNT)=0
 S DSIT=$NA(^TMP("DSIVDM1",$J)) K @DSIT
 S DSIV=$NA(^TMP("DSIVDM",$J)) K @DSIV
 S I="" F  S I=$O(DSIVDAT(I)) Q:I=""  S Z=DSIVDAT(I) D
 .S X=$P(Z,U),Y=$P(Z,U,2),X=$$UP(X)
 .I X="APP"!(X="WHICH") S Y=$$UP(Y)
 .I "^APP^DEL^EDT^MAX^OVERRIDE^SDT^TRANID^WHICH^"[(U_X_U) S @X=Y
 .Q
 F X="APP","DEL","EDT","MAX","OVERRIDE","SDT","TRANID","WHICH" S @X=$G(@X)
 I WHICH="" S WHICH="A"
 K Z S Z=0 F I=1:1:$L(WHICH) S X=$E(WHICH,I) D
 .I X="*" S Z=1 Q
 .I "AS"[X S Z(1)=""
 .I "AE"[X S Z(0)=""
 .I "AP"[X S Z("p")=""
 .Q
 I $D(Z)<10 D ERR(1)
 K WHICH M WHICH=Z
 S:APP="" APP="DM" I APP="" D ERR(2)
 S:EDT'="" EDT=$$DATE(EDT) S:'EDT EDT=DT+.25
 S:SDT'="" SDT=$$DATE(SDT) S:'SDT SDT=2500101 S:SDT>0 SDT=SDT-.000001
 I 'MAX S MAX=1000000
 Q
 ;
INITU ; initialize input params for update call
 N I,Y,Z
 S DSIV="RET"
 F X="ACT","TRANID","QUEUE","APP" S @X=$G(@X)
 S:ACT="" ACT="A" I APP="" S APP="DM"
 S APP=$$UP(APP),ACT=$E($$UP(ACT))
 S X=$$IMP I X<1 S RET(1)=X Q
 ;  QA input values
 I "AD"'[ACT D ERR(7) Q
 S IEN="" I TRANID'="" S IEN=$$IEN(TRANID) I IEN<0 D ERR(4) Q
 I ACT="D" D ERR(8):TRANID="",ERR(10):IEN=0 Q
 ; ACT="A" at this point
 I IEN>0 D ERR(11) Q
 I TRANID="" S TRANID=$$TRANID("DSS;"_APP)
 Q
 ;
LOCK(N) L +^DSI(19621,N):2 Q $T
UNLK(N) L -^DSI(19621,N) Q
 ;
MAG(NM) Q +$O(^MAG(2005,"ATRKID",NM,0)) ; NM=import trans ID name
 ;
NOW(A,B) ;
 N X S X=$$NOW^XLFDT S:$G(A) X=$TR(X,".") S:$G(B) X=$E(X,1,12)
 Q +X
 ;
TDIFF(X) N S,Y S Y=$H,S=$P(Y,",",2) S:+Y>+X S=S+86400 Q S-$P(X,",",2)
 ;
TRANID(Z) ; create new tranid
 N X F  S X=Z_$$NOW(1) Q:'$D(^DSI(19621,"B",X))
 Q X
 ;
UP(X) S:X?.E1L.E X=$$UP^XLFSTR(X) Q X
