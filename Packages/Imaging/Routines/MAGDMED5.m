MAGDMED5 ;WCIOFO LB/4/98 Routine to lookup patient [ 10/06/1999   1:51 PM ]
 ;;2.5T;DICOM41F;;6-October-1999
 ;;
 ;; ********************************************************************
 ;; ********************************************************************
 ;; **  Property of the US Government.  No permission to copy or      **
 ;; **  redistribute this software is given. Use of this software     **
 ;; **  requires the user to execute a written test agreement with    **
 ;; **  the VistA Imaging Development Office of the Department of     **
 ;; **  Veterans Affairs, telephone (301) 734-0100.                   **
 ;; **                                                                **
 ;; **  The Food and Drug Administration classifies this software as  **
 ;; **  a medical device.  As such, it may not be changed in any way. **
 ;; **  Modifications of the software may result in an adulterated    **
 ;; **  medical device under 21CFR820 and may be a violation of US    **
 ;; **  Federal Statutes.                                             **
 ;; ********************************************************************
 ;; ********************************************************************
 ;;
 Q
PAT(MAGARR,MAGMPAT) ;Use the patient name to do a lookup in patient file
 ; Validate patient name
 ; Receive patient name^ssn
 ; Can receive any combination:
 ;       last name initial^last 4 of ssn
 ;              full name ^
 ;                        ^ ssn
 ; Return array of:
 ;               array(0) 1 or 0 ^ #entries ^ msg
 ;               array(#) = patient name SSN
 ;               array(#,1) = dfn ^ patient name ^ SSN
 ; Only one match must be sent IF FOUND at BS5 xref
 N ARRAY,BS5,MAGNME,MAGPID,Y
 Q:'$L(MAGMPAT)      ;Nothing sent.
 S MAGNME=$P(MAGMPAT,"^"),MAGPID=$P(MAGMPAT,"^",2)
 S BS5=1 D BS5
 S NUM=$P($G(ARRAY("DILIST",0)),"^")
 I NUM D LOOP I $D(MAGARR(0)) Q
 S BS5=0 D FULLLK
 I $D(^TMP("DIERR",$J)) S MAGARR(0)="0^No patient match found" Q
 S NUM=$P($G(ARRAY("DILIST",0)),"^")
 I NUM D LOOP I $D(MAGARR(0)) Q
 S MAGARR(0)="0^No patient match found"
 Q
BS5 ;
 ; 1st lookup by last name initial & last 4 of SSN
 K ARRAY,^TMP("DIERR",$J)
 Q:$L(MAGPID)<3
 ; Need at least 4 characters in the SSN
 S LSSN=$E(MAGNME,1)_$E(MAGPID,$L(MAGPID)-3,$L(MAGPID))
 ; Get the last 4 characters in the SSN
 D FIND^DIC(2,"",".01;.09","",LSSN,50,"BS5","","","ARRAY")
 ; file#^^fields^^text to match^# of matchs^xref^screen^error^target
 Q
FULLLK ;
 ; 2nd lookup by patient name
 K ARRAY,^TMP("DIERR",$J)   ;cleanup before next attempt.
 D FIND^DIC(2,"",".01;.09","",MAGNME,50,"B","","","ARRAY")
 ; file#^^fields^^text to match^# of matchs^xref^screen^error^target
 Q
LOOP ;
 Q:'NUM
 N DFN,NAME,PID,CNT
 S CNT=0
 F I=1:1:NUM D
 . S DFN=$G(ARRAY("DILIST",2,I))
 . S NAME=$G(ARRAY("DILIST",1,I))
 . S PID=$G(ARRAY("DILIST","ID",I,.09))
 . ;On BS5 lookup, if more than 1 entry match name
 . I NUM>1,$G(BS5),'$$MATCH(MAGNME,NAME) Q
 . S CNT=CNT+1
 . S MAGARR(CNT)=NAME_" "_PID
 . S MAGARR(CNT,1)=NAME_"^"_PID_"^"_DFN
 I CNT S MAGARR(0)="1^"_CNT_"^ Entr"_$S(CNT=1:"y",1:"ies")_" found."
 Q
PATLK() ; Lookup patient in medicine file.
 ; This module must be called from a menu option or it will error out on
 ; patients marked sensitive (RESTRICTED).
 N DIC,X,Y
 S DIC="^MCAR(690,",DIC(0)="AEIMQ"
 D ^DIC
 Q +Y
MATCH(NAME1,NAME2) ;
 N X1
 S X1=$E($P(NAME1,","),1,15)=$E($P(NAME2,","),1,15)
 Q X1
