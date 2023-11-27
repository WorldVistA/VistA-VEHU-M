IBCE837Q ;EDE/JWS - POST EXECUTE OUTPUT FOR 837 TRANSMISSION - CONTINUED ;
 ;;2.0;INTEGRATED BILLING;**742**;21-MAR-94;Build 36
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
11 ;IB*2.0*742;JWS;11/3/22:EBILL-2517;VistA will perform edits done by FSC's PayerIDSwitches.exe
 N FT,COB,X1,IBOPID,IBPPID,OK,IBTPAID,IBTPAOID,IB3648,IB3648TF,IB3648FT,IBEXSV,IBCLM
 I $G(IBXIEN)="" Q
 S IBCLM=$P($G(^DGCR(399,IBXIEN,0)),"^")
 S COB=$$COBN^IBCEF(IBXIEN)
 ;skip if not a secondary (Medicare Supplemental) claim
 I COB'=2 Q
 ; primary other payer will always be the 1st OI6 record.
 S IBOPID=$G(^TMP("IBXDATA",$J,1,114,1,4))
 ; quit if Other Payer ID is NOT one of the Medicare Payer IDs
 I '$F(",12M61,SMTX1,SMDEV",","_IBOPID) Q
 S IBPPID=$G(^TMP("IBXDATA",$J,1,37,1,3))
 ; if no CI5-3, Primary Payer ID, then stop
 I IBPPID="" Q
 ; get form type, 2 = prof, 3 = inst
 S FT=$$FT^IBCEF(IBXIEN)
 ; if Primary Payer ID, CI5-3 is not in the PayerIDSwitch file, send as is.
 S (OK,IB3648)=0 F  S IB3648=$O(^IBA(364.8,"B",IBPPID,IB3648)) Q:IB3648=""  D  Q:OK
 . ; has entry been deactivate or flagged as deleted
 . I $P($G(^IBA(364.8,IB3648,0)),"^",9)=1 Q
 . S IB3648FT=$P($G(^IBA(364.8,IB3648,0)),"^",4)
 . I IB3648FT'=1,FT'=IB3648FT Q
 . S IB3648TF=$P($G(^IBA(364.8,IB3648,0)),"^",8)
 . I $$PROD^XUPROD(1),'+$$TEST^IBCEF4(IBXIEN),IB3648TF Q
 . S OK=1
 . Q
 Q:'IB3648
 ; 
 ; F:REQ-1
 S IBTPAID=$P($G(^IBA(364.8,IB3648,0)),"^",2)
 I IBTPAID="" D  Q
 . S ^TMP("IBXDATA",$J,1,37,1,3)=$S(FT=2:"PPRNT",1:"IPRNT"),^(2)="PI"
 . D UP11(IB3648)
 . Q
 ;
 ; F:REQ-2 and F:REQ-4
 S IBTPAOID=$P($G(^IBA(364.8,IB3648,0)),"^",3)
 ;;I IBTPAID'=$G(^TMP("IBXDATA",$J,1,37,1,3)) S ^(3)=IBTPAID
 S ^TMP("IBXDATA",$J,1,37,1,3)=IBTPAID
 I IBTPAOID'="" D
 . I $G(^TMP("IBXDATA",$J,1,37,1,5))="" S ^(4)="FY",^(5)=IBTPAOID Q
 . S ^TMP("IBXDATA",$J,1,37,1,6)="FY",^(7)=IBTPAOID
 . Q 
 D UP11(IB3648)
 ; F:REQ-6; Medicare excluded service(s)
 S X1=0 S X1=$O(^TMP("IBXDATA",$J,1,107,X1)) Q:X1=""  I $G(^(X1,5))="A8" D  Q
 . S IBEXSV=$P($G(^IBA(364.8,IB3648,0)),"^",11)
 . I IBEXSV=1!(IBEXSV=FT) Q
 . S ^TMP("IBXDATA",$J,1,37,1,3)="NOEXC"
 . D UP11(IB3648,"X")
 Q
 ;
UP11(IEN,EXSV) ;update file 364.8 record for use
 N X,Y,F1
 S %DT="TXR",X="N" D ^%DT
 S F1=6 I $G(EXSV)="X" S F1=13
 S X=$G(^IBA(364.8,IEN,0)),$P(X,"^",F1)=Y,$P(X,"^",F1+1)=$P(X,"^",F1+1)+1,^(0)=X I F1=6 S $P(^(0),"^",15)=IBCLM
 Q
 ;
12 ;IB*2.0*742;JWS;12/5/22:EBILL-2321;VistA will perform edits done by FSC's SvcFacilityAddress.exe
 N I,X
 ;if a Lab/Facility name exists already, leave as is
 I $G(^TMP("IBXDATA",$J,1,55,1,2))'="" Q
 ; set SUB2[1]="SUB2" in case it does not exist
 ; set SUB2[2]=77 - Lab/Facility Entity Code
 ; set SUB2[3]=2 - non-person
 S ^TMP("IBXDATA",$J,1,57,1,1)="SUB2",^(2)=77,^(3)=2
 ; set SUB2[7] Lab/Facility Secondary ID Qualifier(1) = CI1A[4] Billing Prov Sec ID Qualifier(2) 
 ; set SUB2[8] Lab/Facility Secondary ID(1) = CI1A[5] Billing Prov Sec ID(2)
 ; set SUB2[9] Lab/Facility Secondary ID Qualifier(2) = CI1A[6] Billing Prov Sec ID Qualifier(3)
 ; set SUB2[10] Lab/Facility Secondary ID(2) = CI1A[7] Billing Prov Sec ID(3)
 ; set SUB2[11] Lab/Facility ID Qualifier(3) = CI1A[8] Billing Prov Sec ID Qualifier(4)
 ; set SUB2[12] Lab/Facility ID(3) = CI1A[9] Billing Prov Sec ID(4)
 F I=4:1:9 S X=$G(^TMP("IBXDATA",$J,1,28,1,I)) I X'="" S ^TMP("IBXDATA",$J,1,57,1,I+3)=X
 ; set SUB[2] Lab/Facility Name = PRV[3] Billing Prov Organization Name
 ; set SUB[3] Lab/Facility Address 1 = PRV[4] Billing Prov Address 1
 ; set SUB[4] Lab/Facility City = PRV[5] Billing Prov City Name
 ; set SUB[5] Lab/Facility State = PRV[6] Billing Prov State Code
 ; set SUB[6] Lab Facility ZIP code = PRV[7] Billing Prov ZIP Code
 ; set SUB[1] RECORD ID = "SUB" - just in case it does not already exist
 S ^TMP("IBXDATA",$J,1,55,1,1)="SUB"
 F I=3:1:7 S X=$G(^TMP("IBXDATA",$J,1,15,1,I)) I X'="" S ^TMP("IBXDATA",$J,1,55,1,I-1)=X
 ; set SUB2[5] Lab/Facility Primary ID Qualifier = "XX"
 ; set SUB2[6] Lab/Facility Primary ID = PRV[9] Billing Prov Primary ID
 S X=$G(^TMP("IBXDATA",$J,1,15,1,9)) I X'="" S ^TMP("IBXDATA",$J,1,57,1,5)="XX",^(6)=X
 ; set SUB[12] Lab/Facility Address 2 = PRV[11] Billing Prov Address 2
 S X=$G(^TMP("IBXDATA",$J,1,15,1,11)) I X'="" S ^TMP("IBXDATA",$J,1,55,1,12)=X
 Q
 ;
13 ;IB*2.0*742;JWS;12/5/22:EBILL-2852;VistA will perform edits done by FSC's RemoveLoopsForPayerSDMEV.exe
 N X
 ; remove the following segments from the 837 Output Formatter results
 ; seq 96 - OPR: Attending/Other Oper/Operating Physician/Provider Data
 ; seq 97 - OPR1: Attending/Other Oper/Operating Physician/Provider Data
 ; seq 101 - OPR5: Referring Provider Secondary ID Data
 ; seq 103 - OPR7: Supervising Provider Data
 ; seq 104 - OPR8: Supervising Provider Secondary ID Data
 ; seq 104.2 - OPR9: Rendering Provider Data
 ; seq 104.4 - OPRA: Rendering Provider Secondary ID
 ; seq 170 - OP1: Other Payer Rendering Provider Data
 ; seq 173 - OP4: Other Payer Referring Provider Data
 ; seq 176 - OP7: Other Payer Service Facility Data
 ; seq 177 - OP8: Other Payer Supervising Provider Data
 ; seq 193.3 - LREN: Line Rendering Provider Data
 ; seq 193.6 - LPUR: Line Purchase Service Provider Data
 ; seq 194 - LSUP: Line Supervising Provider Data
 ; seq 194.3 - LREF: Line Referring Provider Data
 ; seq 191 - LDAT: Supplemental Line Information [13] Purchase Service Provider ID and [14] Purchase Service Amount
 K ^TMP("IBXDATA",$J,1,96),^(97),^(101),^(103),^(104),^(104.2),^(104.4),^(170),^(173),^(176),^(177),^(193.3),^(193.6),^(194),^(194.3)
 S X=0 F  S X=$O(^TMP("IBXDATA",$J,1,191,X)) Q:X=""  K ^TMP("IBXDATA",$J,1,191,X,13),^(14)
 Q
 ;
