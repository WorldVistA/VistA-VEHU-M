EHMHL7 ;ALB/WTC - EHRM HL7 MESSAGES ; Oct 24, 2023@15:01:46
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**10**;Apr 19, 2021;Build 30
 ;
 ;  Use of $$CRNRSITE^VAFCCRNR supported by ICR #7346.
 ;
 Q  ;
 ;
SAVEHL7(TYPE,SENDER,RECEIVER,FS,CS,RS) ;
 ;
 ;  Save HL7 message in EHRM HL7 Message file (#1609)
 ;
 ;  TYPE     = Type of HL7 message (IFC or PRF) [REQUIRED]
 ;  SENDER   = Message sender.  Suggested values are CERNER-stn or VISTA-stn (e.g., CERNER-668, VISTA-541) [OPTIONAL]
 ;  RECEIVER = Message receiver. [OPTIONAL]
 ;  FS       = Field separator.  Default="|". [OPTIONAL]
 ;  CS       = Component separator.  Default="^". [OPTIONAL]
 ;  RS       = Repetition separator.  Default="~". [OPTIONAL]
 ;
 ;  Returns pointer to file #1609 if successful or 0^error message if not.
 ;
 I $G(TYPE)'="IFC",$G(TYPE)'="PRF" Q "0^TYPE parameter error" ;
 ;
 N HL7MSG,RTNCODE ;
 ;
 I $G(FS)="" S FS="|" ;
 I $G(CS)="" S CS="^" ;
 I $G(RS)="" S RS="~" ;
 ;
 ;  Load HL7 message into HL7MSG array.
 ;
 D GETHL7(.HL7MSG) ;
 ;
 ;  Store HL7 message.
 ;
 S RTNCODE=$$FILE(.HL7MSG,TYPE,$G(SENDER),$G(RECEIVER),FS,CS,RS) I 'RTNCODE D APPERROR^%ZTER("Error saving HL7 message in file #1609.  Error message="_$P(RTNCODE,U,2)) ;
 ;
 Q RTNCODE ;
 ;
SAVEHL7X(NODE,TYPE,SENDER,RECEIVER,FS,CS,RS) ;
 ;
 ;  Save HL7 message in EHRM Message file (#1609).  Message is in ^TMP(NODE,$J).
 ;
 I $G(NODE)="" Q "0^NODE parameter error" ;
 I $G(TYPE)'="IFC",$G(TYPE)'="PRF" Q "0^TYPE parameter error" ;
 ;
 N HL7MSG,RTNCODE ;
 ;
 I $G(FS)="" S FS="|" ;
 I $G(CS)="" S CS="^" ;
 I $G(RS)="" S RS="~" ;
 ;
 M HL7MSG=^TMP(NODE,$J) ;
 ;
 ;  Store HL7 message.
 ;
 S RTNCODE=$$FILE(.HL7MSG,TYPE,$G(SENDER),$G(RECEIVER),FS,CS,RS) I 'RTNCODE D APPERROR^%ZTER("Error saving HL7 message in file #1609.  Error message="_$P(RTNCODE,U,2)) ;
 ;
 Q RTNCODE ;
 ;
GETHL7(HL7MSG) ;
 ;
 ;  Load HL7 message into HL7MSG array.
 ;
 N I,J,HLNODE ;
 ;
 F I=1:1 X HLNEXT Q:HLQUIT'>0  D  ;
 . S HL7MSG(I)=HLNODE,J=0 ;get first segment node
 . ;
 . ; Get continuation nodes for long segments, if any.  Append all pieces of segment together.  They were split apart by HL7 processing code.
 . ;
 . F  S J=$O(HLNODE(J)) Q:'J  S HL7MSG(I)=HL7MSG(I)_HLNODE(J) ;
 Q  ;
 ;
FILE(HL7MSG,TYPE,SENDER,RECEIVER,FS,CS,RS) ;
 ;
 ;  Post HL7 message to file #1609.
 ;
 N DIC,X,Y,DA,ERRMSG,MSGID,CONSULT,CERNER,PATIENT,ICN,I,Z,SITE,PLACER,FILLER ;
 ;
 S DIC=1609,X=$$NOW^XLFDT(),DIC(0)="L",DIC("DR")="1///"_TYPE ;
 S MSGID=$E($$PARSE(.HL7MSG,"MSH",10),1,50),DIC("DR")=DIC("DR")_";2///"_MSGID ;
 I $G(SENDER)="" S SENDER=$$PARSE(.HL7MSG,"MSH",4),SENDER=$P(SENDER,CS,1) S:SENDER="" SENDER="CERNER" ;
 S DIC("DR")=DIC("DR")_";7///"_SENDER ;
 I $G(RECEIVER)="" S RECEIVER=$$PARSE(.HL7MSG,"MSH",6),RECEIVER=$P(RECEIVER,CS,1) S:RECEIVER="" RECEIVER="CERNER" ;
 S DIC("DR")=DIC("DR")_";8///"_RECEIVER ;
 ;
 ;  Extract fields specific to IFC HL7 messages.
 ;
 I TYPE="IFC" D  ;
 . ;
 . S PLACER=$$PARSE(.HL7MSG,"ORC",3),FILLER=$$PARSE(.HL7MSG,"ORC",4) ;
 . S SITE=$P(PLACER,CS,2),(CERNER,CONSULT)="" ;
 . I $$CRNRSITE^VAFCCRNR(SITE)=1 S CERNER=$P(PLACER,CS,1),CONSULT=$P(FILLER,CS,1) ;  icr #7346
 . E  S CERNER=$P(FILLER,CS,1),CONSULT=$P(PLACER,CS,1) ;
 . I CONSULT'="" S DIC("DR")=DIC("DR")_";3///"_CONSULT ;
 . I CERNER'="" S DIC("DR")=DIC("DR")_";4///"_CERNER ;
 . ;
 . S PATIENT=$$PARSE(.HL7MSG,"PID",6) I PATIENT'="" S PATIENT=$P(PATIENT,CS,1)_","_$P(PATIENT,CS,2)_$S($P(PATIENT,CS,3)'="":" "_$P(PATIENT,U,3),1:""),DIC("DR")=DIC("DR")_";5///"_PATIENT ;
 ;
 ;  Extract fields specific to PRF HL7 messages.
 ;
 I TYPE="PRF" D  ;
 . ;
 . S ICN=$$PARSE(.HL7MSG,"PID",4) I ICN'="" S Y=ICN,ICN="" D  ;
 .. F I=1:1 S Z=$P(Y,RS,I) Q:Z=""  I $P(Z,CS,4)="ICN"!($P(Z,CS,4)["USVHA"&($P(Z,CS,5)="NI")) S ICN=$P(Z,CS,1),DIC("DR")=DIC("DR")_";6///"_ICN Q  ;
 . S PATIENT=$$PARSE(.HL7MSG,"PID",6) I PATIENT'="" S PATIENT=$P(PATIENT,CS,1)_","_$P(PATIENT,CS,2)_$S($P(PATIENT,CS,3)'="":" "_$P(PATIENT,U,3),1:""),DIC("DR")=DIC("DR")_";5///"_PATIENT ;
 ;
 D FILE^DICN I Y<0 Q "0^Error creating entry in file #1609" ;
 ;
 S DA=+Y ;
 ;
 D WP^DIE(1609,DA_",",10,,"HL7MSG","ERRMSG") ;
 I $D(ERRMSG) Q "0^Error filing HL7 message in entry #"_DA_" in file #1609" ;
 ;
 Q DA ;
 ;
PARSE(HL7MSG,SEGID,FIELDNO) ;
 ;
 ;  Return requested field from HL7 segment
 ;
 N X,I,RTNVALUE ;
 ; 
 S RTNVALUE="" F I=1:1 Q:'$D(HL7MSG(I))  S X=$S($D(HL7MSG(I))#10:HL7MSG(I),1:HL7MSG(I,0)) D  Q:RTNVALUE'=""  ; WTC 8/17/23
 . ;
 . I $P(X,FS,1)=SEGID S RTNVALUE=$P(X,FS,FIELDNO) ;
 ;
 Q RTNVALUE ;
 ;
PURGE ; [EHMHL7 PURGE]
 ;
 ;  Purge records from the EHRM HL7 Message file (#1609).
 ;
 N TYPE,DA,X,RETNTN,CREATED,DIK ;
 ;
 ;  Get retention period for each HL7 message type from the EHRM HL7 Message Retention file (#1609.1).
 ;
 S DA=0 F  S DA=$O(^EHMHL7(1609.1,DA)) Q:'DA  S X=$G(^(DA,0)) I X'="" S TYPE=$P(X,U,1),RETNTN(TYPE)=$P(X,U,2) ;
 ;
 ;  Scan EHRM HL7 Message file (#1609).  Delete records older than the retention period for the message type.
 ;
 S DA=0 F  S DA=$O(^EHMHL7(1609,DA)) Q:'DA  S X=$G(^(DA,0)) I X'="" S CREATED=$P(X,U,1),TYPE=$P(X,U,2) I $$FMDIFF^XLFDT(DT,CREATED)>RETNTN(TYPE) D  ;
 . ;
 . ;  Delete record from EHRM HL7 Message file (#1609)
 . ;
 . K DIK S DIK=^DIC(1609,0,"GL") D ^DIK ;
 ;
 Q  ;
 ;
INQUIRE ; [EHMHL7 INQUIRE]
 ;
 ;  Inquire into EHRM HL7 Message file (#1609).
 ;
 N DIR,X,Y,DIC,D,INQUIRE,DIRUT ;
 ;
 S DIR(0)="SO^M:Message ID;V:VistA Consult Number;C:Cerner Order Number;P:Patent's Name;I:ICN;D:Date",DIR("A")="Inquire by" D ^DIR Q:$D(DIRUT)  S INQUIRE=Y Q:INQUIRE=""  ;
 ;
 W !,$S(INQUIRE="M":"Message ID",INQUIRE="V":"VistA Consult Number",INQUIRE="C":"Cerner Order Number",INQUIRE="P":"Patient's Name",INQUIRE="I":"ICN",INQUIRE="D":"Date",1:""),": " R X:DTIME Q:'$T  Q:X=""  ;
 ;
 K DIC,D S DIC=1609,DIC(0)="E",D=$S(INQUIRE="M":"MSGID",INQUIRE="V":"CONSULT",INQUIRE="C":"CERNER",INQUIRE="P":"PATIENT",INQUIRE="I":"ICN",1:"B") D IX^DIC I Y<0 W "... Nothing found/selected" Q  ;
 ;
 W !!,"--------------------------------------------------------------------------------",! ;
 K DIC,D S DIC=^DIC(1609,0,"GL"),DA=+Y D EN^DIQ ;
 ;
 Q  ;
 ;
