VEJDMAIL  ; PTLD/JEB ; Generic mail message ; January 1990
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;DO NOT CHANGE - NATIONAL SUPPORT USES THIS ROUTINE
 ; MODIFIED FOR XMB*7.1*50, 8-10-99, PTLD/JIT
 ;User program sets variables calls MSG^BJMAIL (See variable List)
 ;VARIABLE LIST:
 ;  SET 'GROUP' TO THE MAIL GROUP NAME OR NUMBER
 ;  or
 ;  K GROUP AND SET UP A 'TO()' ARRAY WITH THE DUZ AS THE SUBSCRIPT OF
 ;   THE 'TO' ARRAY IF YOU WANT TO SEND A MSG TO AN INDIVIDUAL OR GROUP
 ;   OF INDIVIDUALS WHO ARE NOT IN AN ESTABLISHED MAIL GROUP
 ;  or
 ;  SET 'GROUP' AND INDIVIDUAL 'T()' ARRAY NODES TO SEND TO THE
 ;   ESTABLISHED GROUP AND INDIVIDUALS NOT IN THE GROUP
 ;  SET 'TITLE'=TO THE TITLE YOU WANT DISPLAYED
 ;  SET 'FROM' AS THE PERSON WHO IS SENDING THE MESSAGE ( A NULL 'FROM'
 ;   WILL USE THE POSTMASTER).
 ;  SET THE TEXT OF THE MESSAGE IN ARRAY USING 'T' AND SUBSCRIPT OF A NUMBER
 ;   I.,E T(1)="This is the first line of the message"
 ;        T(2)="This is the second line of the message, etc.
 ;  SET 'CONFIRM'=1 FOR A CONFIRMATION
 ;  SET 'INFO'=1 FOR INFORMATION ONLYH (NO REPLIES ALLOWED) MESSAGE
 ;
 ;  SET 'PRIO'=1 FOR PRIORITY DELIVERY
MSG ;
 N XMINSTR
 Q:'$O(T(0))
 D GROUP
 Q:$O(TO(""))=""
 I $G(CONFIRM) S XMINSTR("FLAGS")=$G(XMINSTR("FLAGS"))_"R"
 I $G(PRIO) S XMINSTR("FLAGS")=$G(XMINSTR("FLAGS"))_"P"
 I $G(INFO) S XMINSTR("FLAGS")=$G(XMINSTR("FLAGS"))_"I"
 I '$D(FROM) S FROM=.5
 D SETFROM^XMD(.FROM,.XMINSTR)
 I '$D(TITLE) S TITLE="Title not specified by sender"
 I $L(TITLE)>65 S TITLE=$E(TITLE,1,65)
 I $L(TITLE)<3 S TITLE=TITLE_"..."
 D SENDMSG^XMXAPI(FROM,TITLE,"T",.TO,.XMINSTR)
 I $G(XMERR)=1 D
 .I '$D(ZTSK) W ! F L=0:0 S L=$O(^TMP("XMERR",$J,1,"TEXT",L)) Q:L<1  W !,^(L)
 ; blj/dss 15/6/2000  Per e-mail from John Thomas in Portland, we can fix the
 ; error below.  The line immediately below this one was commented, but the 4
 ; lines below it weren't.  Because of this, these lines were never called.
 ;.;I $D(ZTSK) D
 ;..S NODE=$G(ZTRTN) I $P(NODE,"^",2)="XQ1" S NODE=$P($G(^%ZTSK(ZTSK,0)),U,9)
 ;..I NODE="" S NODE=$G(XQZ)
 ;..S:NODE="" NODE="UNKNOWN"
 ;..D NOW^%DTC S ^JTUT("XMERR",%,NODE)=$G(TITLE)_"^"_$G(^TMP("XMERR",$J,1,"TEXT",1))
 K CONFIRM,FROM,GROUP,INFO,PRIO,T,TITLE,TO,^TMP("XMERR",$J),XMERR
 Q
GROUP ;
 Q:$G(GROUP)=""
 I +GROUP=GROUP S:$D(^XMB(3.8,GROUP,0)) TO($P(^XMB(3.8,GROUP,0),U))="" Q
 S TO("G."_GROUP)=""
 Q
 ;
WRITE ;Write a message - not part of the main program
 K T
RI ;
 S X="" F I=1:1 R !,"|",X:30 Q:X=""  S T(I)=X,X=""
 Q
