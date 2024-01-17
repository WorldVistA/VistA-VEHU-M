PSOERX1E ;ALB/JSG - eRx Utilities ; 11/27/2019 11:02am
 ;;7.0;OUTPATIENT PHARMACY;**581,700**;DEC 1997;Build 261
 ;
PHCHREQ(PSOIEN,RULE,LINE,PRTVIEW) ; Pharmacy Change Request Note
 S PRTVIEW=+$G(PRTVIEW)
 N I,NEWRXNOT,NOTEARY,PHCHRQNT,RELERX,RELHUB,REQIEN
 S REQIEN=$S(RULE?1(1"1059",1"1060",1"1062".E):$$RESOLV^PSOERXU2(PSOIEN),1:PSOIEN)
 S RELHUB=$$GET1^DIQ(52.49,REQIEN,.14)
 S RELERX=$O(^PS(52.49,"FMID",RELHUB,0))
 S PHCHRQNT=$$GET1^DIQ(52.49,REQIEN,8,"I")
 S NEWRXNOT=$$GET1^DIQ(52.49,RELERX,8,"I")
 S:NEWRXNOT=PHCHRQNT PHCHRQNT=""
 I 'PRTVIEW D
 .S LINE=LINE+1 D SET^VALM10(LINE,"")
 .S LINE=LINE+1 D SET^VALM10(LINE,"Pharmacy Change Request Note: ")
 .I PHCHRQNT]"" D
 ..K NOTEARY
 ..D TXT2ARY^PSOERXD1(.NOTEARY,PHCHRQNT," ",80)
 ..S I=0 F  S I=$O(NOTEARY(I)) Q:'I  D
 ...S LINE=LINE+1 D SET^VALM10(LINE,NOTEARY(I))
 .I PHCHRQNT="" D
 ..S LINE=LINE+1 D SET^VALM10(LINE,PHCHRQNT)
 I PRTVIEW D
 .W !!,"Pharmacy Change Request Note: "
 .W !,PHCHRQNT
 Q
 ;
AUTOHOLD(TYPE,ERXIEN,VPATIEN,EPATIEN) ; Checks whether the VistA Patient has an Allergy Assessment or is Eligibile for
 ;                               ChampVA Rx Benefit, if not, put all eRx's on Hold (HAL or HEL) - Used by MbM only
 ;Input: r TYPE    - Type of Hold: "A": Allergy | "E": Eligibility
 ;       r ERXIEN  - Poiter to the ERX HOLDING QUEUE file (#52.49)
 ;       r VPATIEN - Poiter to the VISTA PATIENT file (#2)
 ;       o EPATIEN - Poiter to the ERX PATIENT file (#42.56)
 ;
 N RECDATE,OERXIEN,HAHLDCOD,ERXLST,HDR,XX,CNT,DIR,PSOIEN
 I '$G(EPATIEN) S EPATIEN=$$GET1^DIQ(52.49,ERXIEN,.04,"I") I 'EPATIEN Q
 S HAHLDCOD=$O(^PS(52.45,"B",$S(TYPE="A":"HAL",1:"HEL"),0)) I 'HAHLDCOD Q
 S RECDATE=0 F  S RECDATE=$O(^PS(52.49,"PAT2",EPATIEN,RECDATE)) Q:'RECDATE  D
 . S OERXIEN=0  S OERXIEN=$O(^PS(52.49,"PAT2",EPATIEN,RECDATE,OERXIEN)) Q:'OERXIEN  D
 . . I $G(ERXIEN)=OERXIEN Q
 . . S ERXSTS=$$GET1^DIQ(52.49,OERXIEN,1,"E")
 . . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"'[(","_ERXSTS_",") Q
 . . ; DO NOT FILL record
 . . I $$GET1^DIQ(52.49,+$G(OERXIEN),10.5,"I")=2 Q
 . . ; eRx/user not eligible for Hold
 . . S PSOIEN=OERXIEN
 . . I '$$OPACCESS^PSOERXU7("PSO ERX HOLD",DUZ,OERXIEN) Q
 . . I TYPE="A" D UPDSTAT^PSOERXU1(OERXIEN,"HAL","Hold for Allergy Assessment")
 . . I TYPE="E" D UPDSTAT^PSOERXU1(OERXIEN,"HEL","Hold due to Eligibility Issue")
 . . S ERXLST(OERXIEN)=""
 . . ; Updating the VistA Patient for other eRx record for the same patient (if not already matched)
 . . I $$GET1^DIQ(52.49,OERXIEN,.05,"I") Q
 . . K FDA
 . . S FDA(52.49,OERXIEN_",",.05)=VPATIEN
 . . S FDA(52.49,OERXIEN_",",1.7)="",FDA(52.49,OERXIEN_",",1.13)="",FDA(52.49,OERXIEN_",",1.14)=""
 . . D FILE^DIE(,"FDA") K FDA
 ;
 I '$D(ERXLST) Q
 ;
 W !!,"The following eRx record(s) have been put on Hold ("_$S(TYPE="A":"HAL",1:"HEL")_") because the VistA"
 W !,"Patient ("_$$GET1^DIQ(2,VPATIEN,.01)_") "
 W:TYPE="A" "does not have an Allergy Assessment."
 W:TYPE="E" "is not Eligible for ChampVA Rx Benefit."
 ;
 S HDR="ERX ID",$E(HDR,17)="DRUG NAME",$E(HDR,48)="PROVIDER",$E(HDR,77)="STS"
 S $P(XX,"-",80)="" W !,HDR,!,XX
 S (OERXIEN,CNT)=0 F  S OERXIEN=$O(ERXLST(OERXIEN)) Q:'OERXIEN  D
 . W !,$$GET1^DIQ(52.49,OERXIEN,.01),?16,$E($S($$GETDRUG^PSOERXU5(OERXIEN)'="":$$GETDRUG^PSOERXU5(OERXIEN),1:"N/A"),1,30)
 . W ?47,$E($$GET1^DIQ(52.49,OERXIEN,2.1),1,23)
 . W ?76,$$GET1^DIQ(52.49,OERXIEN,1)
 . S CNT=CNT+1 I '(CNT#18),$O(ERXLST(OERXIEN)) K DIR D PAUSE^VALM1 W !,HDR,!,XX
 ;
 K DIR D PAUSE^VALM1
 Q
 ;
DUPVPAT(DFN,LIST) ; Checks whether a VistA Patient has potential duplicate records
 ; Input: DFN  - Pointer to the PATIENT file (#2)
 ;Output: LIST - List of duplicate patient(s), Defined if any OR Undefined ('$D)
 ;
 N FULLNAME,FLFN,LASTNAME,DOB,OPATNAME,DUPPAT
 K LIST S FULLNAME=$$GET1^DIQ(2,DFN,.01),FLFN=$E($P(FULLNAME,",",2))
 S LASTNAME=$P(FULLNAME,",") I LASTNAME="" Q
 S DOB=$$GET1^DIQ(2,DFN,.03,"I")
 ;
 S OPATNAME=LASTNAME
 F  S OPATNAME=$O(^DPT("B",OPATNAME)) Q:($P(OPATNAME,",")'=LASTNAME)  D
 . S DUPPAT=0 F  S DUPPAT=$O(^DPT("B",OPATNAME,DUPPAT)) Q:'DUPPAT  D
 . . I DUPPAT=DFN Q
 . . I $$DEAD^PSONVARP(DUPPAT) Q
 . . ; If full names matches OR last names + First Letter of first names + Dates of Birth matches, then it's a match
 . . I OPATNAME=FULLNAME!($E($P(OPATNAME,",",2))=FLFN&($$GET1^DIQ(2,DUPPAT,.03,"I")=DOB)) D
 . . . S LIST(DUPPAT)=OPATNAME_"  "_$$GET1^DIQ(2,DUPPAT,.03)_"  "_$$GET1^DIQ(2,DUPPAT,.09)
 . . . S LIST(DUPPAT)=LIST(DUPPAT)_"  "_$$GET1^DIQ(2,DUPPAT,.114)_","_$$STATEABB^PSOERUT(2,DUPPAT)
 Q
