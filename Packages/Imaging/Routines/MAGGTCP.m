MAGGTCP ;WIRMFO/GEK - Testing Delphi-Broker calls [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
LKP(MAGRY,ZY) ;RPC Call to Do a lookup using FIND^DIC
 ;       NOT USED in Version 2.5   Kept in for backward compatibility.
 ; MAGRY is the Array to return.
 ; ZY is parameter sent by calling app (Delphi)
 ;    FILE NUM ^ NUM TO RETURN ^ TEXT TO MATCH ^  ^ SCREEN ($P 5-99)
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 E  S X="ERRA^MAGGTERR",@^%ZOSF("TRAP")
 ; Kernel uses Y, we have to New it because calls to DIC etc
 ;            also use it and change it, and kill it.
 N Y,XI,Z,FI,MAGDFN
 N FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT
 S (FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT)=""
 ;
 S FILE=+$P(ZY,U,1) ; this is the File Number
 I 'FILE!'$D(^DIC(FILE,0)) S MAGRY(1)="ERROR No File Number was sent" Q
 ;          Number of entries to return, If 0 we'll stop at 200
 S NUM=$S(+$P(ZY,U,2):+$P(ZY,U,2),1:200)
 S VAL=$P(ZY,U,3) ; this is the starting value i.e. 'Smi'
 S SCR=$P(ZY,U,5,99)
 ;  FLDS will equal .1; for Ward, needs to be made generic, or use
 ;   FM Components.
 S FLDS=$P(ZY,U,4) ; if fields were sent (6/21/96)
 ;  Add Identifiers to FLDS
 I $L(FLDS) S FLDS=FLDS_".03;.09;.301;391"
 ;  index will default to "B" if nothing sent.  We'll set it anyway
 S INDEX="B"
 ;  if patient file, we'll decide which xref to use
 I FILE=2 D
 . S INDEX=$S(VAL?9N:"SSN",VAL?1U1.N:"BS5",1:"B") ; 6/18 GEK
 . I $L(FLDS)&(INDEX="B") D
 . . F FI=1:1:$L(FLDS,";") I ($P(FLDS,";",FI)=.1) S INDEX="B^ACN"
 ; GEK 6/18/96 ALLOW WARD LOOKUP IF WARD FIELD IS SENT
 ;
 K ^TMP("DILIST",$J) ; is this necessary ?
 K ^TMP("DIERR",$J) ; This is. 1/27/98
 ;  hey we'll use FM21
 S MAGNOCOM=1 ; GEK this flag was set for DIC1 PROB in Balt
 D FIND^DIC(FILE,IENS,FLDS,FLAGS,VAL,NUM,INDEX,SCR,IDENT,TROOT)
 K MAGNOCOM
 ;
 ;  if no match we'll send first entry as NO MATCH (for now)
 ;  Or if error send ERROR.
 ;  LATER we'll figure a better way
 ;I $D(^TMP("DIERR",$J)) D FINDERR() Q  ;1/28/98
 I '$D(^TMP("DILIST",$J,1)) S XI=1 D  Q
 . I $D(^TMP("DIERR",$J)) D FINDERR(XI) Q
 . S MAGRY(XI)="NO MATCH for lookup on """_$P(ZY,"^",3)_""""
 ;  so we have some matches, (BUT we could still have an error)
 ;  so first list all matches, then the ERROR
 ;  Next lines were Q&D but old .EXE's expect return string with 
 ;  this syntax, when all T11 code is gone, this can be rewritten
 S XI="" F  S XI=$O(^TMP("DILIST",$J,1,XI)) Q:XI=""  D
 . S X=^(XI),MAGDFN=^TMP("DILIST",$J,2,XI),$E(MAGDFN,10)=" "
 . S Z=""
 . I INDEX="B^ACN" D WARDTMP(XI) Q
 . F  S Z=$O(^TMP("DILIST",$J,"ID",XI,Z)) Q:Z=""  S X=X_"   "_^(Z)
 . ; GEK 8/1/99 use '^' delimeter always now
 . ;S MAGRY(XI)=X_" "_MAGDFN
 . S MAGRY(XI)=X_"^"_+MAGDFN
 ;
 I $D(^TMP("DIERR",$J)) D FINDERR() Q
 I '$D(^TMP("DILIST",$J,0)) Q
 N INFO S INFO=^(0)
 S XI=$O(MAGRY(""),-1)+1
 S MAGRY(0)="Found "_$P(INFO,"^")_" entr"_$S((+INFO=1):"y",1:"ies")_" matching """_$P(ZY,"^",3)_""""
 I $P(INFO,"^",3)>0 S MAGRY(0)=MAGRY(0)_" there are more"
 Q
WARDTMP(XI) ;  MAGDFN is DFN  X is NAME
 N WARD ; this is a temp subroutine quick change to display ward
 ;  we'll redo this later. gek
 S WARD=^TMP("DILIST",$J,"ID",XI,.1)
 K ^TMP("DILIST",$J,"ID",XI,.1)
 I $E(WARD,1,$L(VAL))=VAL S X=WARD_"   "_X
 S Z=0   ;FM22 has ^tmp("dilist",$j,"id",seq#,0,1) & need value after
 F  S Z=$O(^TMP("DILIST",$J,"ID",XI,Z)) Q:Z=""  S X=X_"   "_^(Z)
 S MAGRY(XI)=X_"                                        ^"_+MAGDFN
 Q
FINDERR(XI) ;get error text from FIND^DIC call.
 I '+$G(XI) S XI=$O(MAGRY(""),-1)+1
 S MAGRY(XI)="ERROR^"_^TMP("DIERR",$J,1,"TEXT",1)
 Q
PINF1(MAGRY,MAGDFN) ;RPC Call to  Return patient info.
 ; Not used in version 2.5.   Kept for backward compatibility
 ;
 N Y,MAGGX,MAGGE,RIENC,Z,X,I
 D GETS^DIQ(2,+MAGDFN,".03;391;1901;.01;.02;.09;.301;.14;.361;.3611;.3192;.32102;.32103;.322013;.033","","MAGGX","MAGGE")
 I $D(MAGGE("DIERR",1)) S MAGRY="0^"_MAGGE("DIERR",1,"TEXT",1) Q
 S RIENC=+MAGDFN_",",Z="1^"
 F I=.03,391,1901,.01,.02,.09,.301,.14,.361,.3611,.3192,.32102,.32103,.322013,.033 D
 . S X=MAGGX(2,RIENC,I) S Z=Z_X_"^"
 S MAGRY=Z
 ;S MAGRY=$E(Z,1,$L(Z)-1)
 D ACTION^MAGGTAU("PAT^"_MAGDFN)
 Q
