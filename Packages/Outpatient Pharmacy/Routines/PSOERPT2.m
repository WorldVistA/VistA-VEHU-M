PSOERPT2 ;BIRM/MFR - eRx Patient Medication Profile - Cont'd ; 12/10/22 9:50am
 ;;7.0;OUTPATIENT PHARMACY;**700**;DEC 1997;Build 261
 ;
HOLDELIG(ERXLST) ; Given a list of eRx IENs (array passed in by Reference) it checks if they can all be put on HOLD
 N HOLDELIG,SEQ,ERXIEN
 S HOLDELIG=1,SEQ=0 F  S SEQ=$O(ERXLST(SEQ)) Q:'SEQ  D
 . S ERXIEN=ERXLST(SEQ)
 . I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2 D  S HOLDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="DO NOT FILL eRx record"
 . S ERXSTAT=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 . S MSGTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 . I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2  D  S HOLDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="DO NOT FILL record"
 . I $E(ERXSTAT,1)="H" D  S HOLDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="eRx already on Hold"
 . I $E(ERXSTAT,1,3)="REM" D  S HOLDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="eRx with a status of 'Removed'."
 . I $F(" RJ RM PR "," "_ERXSTAT_" ") D  S HOLDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="eRx with a status of 'Rejected', 'Removed' or 'Processed'."
 . I ERXSTAT="RXP"!(ERXSTAT="RXC")!(ERXSTAT="RXE") D  S HOLDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="Response record with a status of 'Complete', 'Processed', or 'Error'."
 Q HOLDELIG
 ;
UNHDELIG(ERXLST) ; Given a list of eRx IENs (array passed in by Reference) it checks if they can all be put on HOLD
 N UNHDELIG,SEQ,ERXIEN
 S UNHDELIG=1,SEQ=0 F  S SEQ=$O(ERXLST(SEQ)) Q:'SEQ  D
 . S ERXIEN=ERXLST(SEQ)
 . I $$GET1^DIQ(52.49,+$G(ERXIEN),10.5,"I")=2 D  S UNHDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="DO NOT FILL eRx record"
 . S ERXSTAT=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 . S MSGTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 . I $E(ERXSTAT,1)'="H" D  S UNHDELIG=0 Q
 . . S $P(ERXLST(SEQ),"^",2)="eRx is not on Hold"
 Q UNHDELIG
 ;
UNHDSTAT(ERXIEN) ; Returns the Status the eRx should be set to after being Un-Held
 N MSGTYPE,ERXSTAT,ERXSTATI
 S MSGTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S ERXSTAT=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 I $$GET1^DIQ(52.49,ERXIEN,1.3,"I"),$$GET1^DIQ(52.49,ERXIEN,1.5,"I"),$$GET1^DIQ(52.49,ERXIEN,1.7,"I") D  Q ERXSTAT
 . I MSGTYPE="N" S ERXSTATI=$$PRESOLV^PSOERXA1("W","ERX"),ERXSTAT=$$GET1^DIQ(52.45,ERXSTATI,.01,"E") Q
 . I MSGTYPE="RE" S ERXSTATI=$$PRESOLV^PSOERXA1("RXW","ERX"),ERXSTAT=$$GET1^DIQ(52.45,ERXSTATI,.01,"E")
 . I MSGTYPE="CX" S ERXSTATI=$$PRESOLV^PSOERXA1("CXW","ERX"),ERXSTAT=$$GET1^DIQ(52.45,ERXSTATI,.01,"E")
 I MSGTYPE="N" S ERXSTATI=$$PRESOLV^PSOERXA1("I","ERX"),ERXSTAT=$$GET1^DIQ(52.45,ERXSTATI,.01,"E")
 I MSGTYPE="RE" S ERXSTATI=$$PRESOLV^PSOERXA1("RXI","ERX"),ERXSTAT=$$GET1^DIQ(52.45,ERXSTATI,.01,"E")
 I MSGTYPE="CX" S ERXSTATI=$$PRESOLV^PSOERXA1("CXI","ERX"),ERXSTAT=$$GET1^DIQ(52.45,ERXSTATI,.01,"E")
 Q ERXSTAT
 ;
MATCH(TYPE,ERXIEN) ; Returns the eRx Match for Patient/Provider/Drug
 ; Input: TYPE - Type of Match (PAM:Patient Match|PRM:Provider Match|DRM:Drug Match)
 ;        ERXIEN - eRx IEN (Pointer to #52.49)
 ;Output: MATCH - P1: Match info (Ex: "":(Not Matched)|M:Manual matched|AV: Auto matched & Verified)
 ;                P2: 1:Auto Matched & Manual Matched afterwards | 0: Not Edited
 ;                p3: 1:Auto-Validated | 0: Not auto-validated
 N MAT,VAL,MORA,AVAL
 S MAT=$S(TYPE="PAM":$$GET1^DIQ(52.49,ERXIEN,.05,"I"),TYPE="PRM":$$GET1^DIQ(52.49,ERXIEN,2.3,"I"),1:$$GET1^DIQ(52.49,ERXIEN,3.2,"I"))
 S MORA=+$S(TYPE="PAM":$$GET1^DIQ(52.49,ERXIEN,1.6,"I"),TYPE="PRM":$$GET1^DIQ(52.49,ERXIEN,1.2,"I"),1:$$GET1^DIQ(52.49,ERXIEN,1.4,"I"))
 S VAL=$S(TYPE="PAM":$$GET1^DIQ(52.49,ERXIEN,1.13,"I"),TYPE="PRM":$$GET1^DIQ(52.49,ERXIEN,1.8,"I"),1:$$GET1^DIQ(52.49,ERXIEN,1.11,"I"))
 S AVAL=0 I TYPE="PRM",$$GET1^DIQ(52.49,ERXIEN,1.8,"I")=$$PROXYDUZ^PSOERXUT() S AVAL=1
 Q $S('MAT:"",1:$S(MORA=1:"A",1:"M")_$S(VAL:"V",1:""),1:"")_"^"_$S(MORA=2:1,1:0)_"^"_AVAL
 ;
MATCHSRT(PAT,PRO,DRU) ; Returns the Matching Score for Sorting purpose
 I PAT="",PRO="",DRU="" Q 1
 I PAT=""&(PRO="") Q 2
 I PAT=""&(DRU="") Q 2
 I PRO=""&(DRU="") Q 2
 I PAT=""!(PRO="")!(DRU="") Q 3
 I PAT["V",PRO["V",DRU["V" Q 8
 I PAT["V"&(PRO["V") Q 7
 I PAT["V"&(DRU["V") Q 7
 I PRO["V"&(DRU["V") Q 7
 I PAT["V"!(PRO["V")!(DRU["V") Q 6
 I PAT="M"&(PRO="M") Q 5
 I PAT="M"&(DRU="M") Q 5
 I PRO="M"&(DRU="M") Q 5
 Q 4
 ;
HASACTRX(EPATIEN) ; Checks whether the eRx Patient has any Actionable prescription (other than on Hold)
 ; Input: EPATIEN - Pointer to ERX PATIENT file (#52.46)
 ;Output: 0: No Actionable eRx found | 1: Actionable eRx's found
 N HASACTRX,ERXIEN,RELMSGID,RECDAT
 S (ERXIEN,RELMSGID,HASACTRX)=0,RECDAT=$$FMADD^XLFDT(DT,-$$GET1^DIQ(59,PSOSITE,10.2))
 F  S RECDAT=$O(^PS(52.49,"PAT2",EPATIEN,RECDAT)) Q:'RECDAT  D
 . F  S ERXIEN=$O(^PS(52.49,"PAT2",EPATIEN,RECDAT,ERXIEN)) Q:'ERXIEN  D  I HASACTRX Q
 . . I ",N,I,W,"[(","_$$GET1^DIQ(52.49,ERXIEN,1)_",") S HASACTRX=1
 . . F  S RELMSGID=$O(^PS(52.49,ERXIEN,201,"B",RELMSGID)) Q:'RELMSGID  D  I HASACTRX Q
 . . . I ",N,I,W,"[(","_$$GET1^DIQ(52.49,RELMSGID,1)_",") S HASACTRX=1
 Q HASACTRX
