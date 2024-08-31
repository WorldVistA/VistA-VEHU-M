PSOERPC2 ;BIRM/MFR - All Patients (Patient Centric) eRx Queue - Supporting APIs 2 ;09/28/22
 ;;7.0;OUTPATIENT PHARMACY;**700,746**;DEC 1997;Build 106
 ;
INIT ; Initialization for the option (Setting global variables, Reviewing Locks, Holds, etc.)
 ; MBMSITE indicates whether it's an MbM site or not, RESETLBD indicates whether the Look Back Days should be reset
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0),RESETLBD=1
 ;Review/Clean-up Locks (e.g.,Session crased and ^XTMP global remained)
 D REVLOCKS
 ;Review/Releases Future Fill Holds
 D UHFFS
 Q
 ;
REVLOCKS ; Review/Clean-up Locks
 N ERXPATID,LKTOUT,DIE,DR,DA
 S (ERXPATID,LKTOUT)=0 F  S ERXPATID=$O(^XTMP("PSOERXLOCK",ERXPATID)) Q:'ERXPATID  D
 . L +^XTMP("PSOERXLOCK",ERXPATID):LKTOUT I '$T Q
 . L -^XTMP("PSOERXLOCK",ERXPATID) K ^XTMP("PSOERXLOCK",ERXPATID)
 . S DIE="^PS(52.46,",DR="6///@",DA=ERXPATID D ^DIE
 Q
 ;
UHFFS ; Un-Hold Future Fills that are Due
 N ERX,HFFIEN,INST,MSGDT,HFFDT,UHSTS,DIE,ERX,DA,DR
 S HFFIEN=$O(^PS(52.45,"B","HFF",0)) I 'HFFIEN Q
 S (INST,ERX)=0,MSGDT=""
 F  S INST=$O(^PS(52.49,"E",INST)) Q:'INST  D
 . F  S MSGDT=$O(^PS(52.49,"E",INST,HFFIEN,MSGDT)) Q:'MSGDT  D
 . . F  S ERX=$O(^PS(52.49,"E",INST,HFFIEN,MSGDT,ERX)) Q:'ERX  D
 . . . S HFFDT=$$GET1^DIQ(52.49,ERX,6.7,"I") I HFFDT>DT Q
 . . . S UHSTS=$$UHSTS^PSOERXH1(ERX)
 . . . D UPDSTAT^PSOERXU1(ERX,UHSTS,"Future Fill Automatically Un-Held",,$$PROXYDUZ^PSOERXUT())
 . . . K DIE S DIE="52.49",DA=ERX,DR="6.7///@" D ^DIE K DIE
 Q
 ;
MATCHLBL(MATCH) ; Match Filter Label
 I MATCH=1 Q $S($G(MBMSITE):"PATIENT FAIL",1:"PATIENT NOT MATCHED")
 I MATCH=2 Q $S($G(MBMSITE):"PROVIDER FAIL",1:"PROVIDER NOT MATCHED")
 I MATCH=3 Q $S($G(MBMSITE):"DRUG FAIL",1:"DRUG NOT MATCHED")
 I MATCH=4 Q $S($G(MBMSITE):"BASIC",1:"ALL MATCHED")
 Q ""
 ;
MATCHFLT(FILTER,ERXPAT) ; Check whether the patient qualifies for Match Filter
 ; Input: FILTER - Filter Value: 1 - Patient Fail | 2 - Provider Fail | 3 - Drug Fail | 4 - Basic (All matched) | 5 - All
 ;        ERXPAT - eRx Patient IEN (Pointer to #52.46)
 ;Ouptut: 1 - Patient qualifies for Match Filter | 0 - Patient does not qualify
 ;
 N MATCHFLT,RECDAT,ERXIEN,CSERX,MTYPE,ERXSTAT,VPATIEN,VPRVIEN,VDRGIEN,FOUNDONE,STATIEN
 S FILTER=+$G(FILTER) I FILTER=5!'FILTER Q 1
 S FOUNDONE=0,MATCHFLT=0
 I FILTER=4 S MATCHFLT=1
 S RECDAT=$$FMADD^XLFDT(DT,-PSOLKBKD)
 F  S RECDAT=$O(^PS(52.49,"PAT2",ERXPAT,RECDAT)) Q:'RECDAT  D  Q:(FILTER=4&'MATCHFLT)  Q:(FILTER'=4&MATCHFLT)
 . S ERXIEN=0 F  S ERXIEN=$O(^PS(52.49,"PAT2",ERXPAT,RECDAT,ERXIEN)) Q:'ERXIEN  D  Q:(FILTER=4&'MATCHFLT)  Q:(FILTER'=4&MATCHFLT)
 . . S CSERX=+$G(^PS(52.49,ERXIEN,95))
 . . S MTYPE=$P($G(^PS(52.49,ERXIEN,0)),"^",8)
 . . S STATIEN=+$G(^PS(52.49,ERXIEN,1)),ERXSTAT=$P(^PS(52.45,STATIEN,0),"^")
 . . ; Exclude eRx's on Hold
 . . I $E(ERXSTAT,1)="H" Q
 . . I '$$ELIGSTS^PSOERPC1("PC",ERXSTAT,MTYPE) Q
 . . ; - CS/Non-CS Filter
 . . I $G(PSOCSERX)="Non-CS",CSERX Q
 . . I $G(PSOCSERX)="CS",'CSERX Q
 . . ; - Match Status Filter
 . . S VPATIEN=+$P($G(^PS(52.49,ERXIEN,0)),"^",5)  ; Vista Patient
 . . S VPRVIEN=+$P($G(^PS(52.49,ERXIEN,2)),"^",3)  ; Vista Provider
 . . S VDRGIEN=+$P($G(^PS(52.49,ERXIEN,3)),"^",2)  ; Vista Drug
 . . S FOUNDONE=1
 . . I FILTER=1,'VPATIEN S MATCHFLT=1 Q
 . . I FILTER=2,'VPRVIEN,'$$MATCHFLT(1,ERXPAT) S MATCHFLT=1 Q
 . . I FILTER=3,'VDRGIEN,'$$MATCHFLT(1,ERXPAT),'$$MATCHFLT(2,ERXPAT) S MATCHFLT=1 Q
 . . I FILTER=4,'VDRGIEN!'VPATIEN!'VPRVIEN S MATCHFLT=0 Q
 I '$G(FOUNDONE) S MATCHFLT=0
 ;
 Q MATCHFLT
 ;
SETLINE ; - Setting Listman line
 N ERXPAT,PATIEN,X1,POS,SORTORD,GROUP,CSERX
 K ^TMP("PSOERPC0",$J)
 I '$D(^TMP("PSOERPCS",$J)) D  Q
 . F I=1:1:6 S ^TMP("PSOERPC0",$J,I,0)=""
 . S ^TMP("PSOERPC0",$J,7,0)="               No patients with actionable prescriptions found."
 . S VALMCNT=1
 ;
 ; - Resetting list to NORMAL video attributes
 D RESET^PSOERUT0()
 K GRPLN,PTMTCHLN,PRMTCHLN,DRMTCHLN
 ;
 ; - Building the list (line by line)
 S (GROUP,SEQ)="",LINE=0,SORTORD=$S(PSORDER="A":1,1:-1)
 F  S GROUP=$O(^TMP("PSOERPCS",$J,GROUP)) Q:GROUP=""  D
 . I GROUP'="ALL" D
 . . N LBL,POS,X
 . . S LBL=$S(GROUP="NON-CS":"NON-",1:"")_"CONTROLLED SUBSTANCE Rx's"
 . . S POS=41-($L(LBL)\2) S X="",$P(X," ",81)="",$E(X,POS,POS-1+$L(LBL))=LBL
 . . S LINE=LINE+1,^TMP("PSOERPC0",$J,LINE,0)=X,GRPLN(LINE)=LBL
 . S ERXPAT="" F  S ERXPAT=$O(^TMP("PSOERPCS",$J,GROUP,ERXPAT),SORTORD) Q:ERXPAT=""  D
 . . S PATIEN=$G(^TMP("PSOERPCS",$J,GROUP,ERXPAT,"PATIEN"))
 . . S Z=$G(^TMP("PSOERPCS",$J,GROUP,ERXPAT)),SEQ=SEQ+1
 . . S X1=SEQ_$S($P(Z,"^",11):"]",1:".")
 . . S $E(X1,$S(SEQ>999:6,1:5))=$E($P(Z,"^",1),1,$S(SEQ>999:23,1:24)),$E(X1,30)=$P(Z,"^",2),$E(X1,41)=$$SSN^PSOERUT($P(Z,"^",3))
 . . S $E(X1,54)=$J(+$P(Z,"^",4),3),$E(X1,58)=$J(+$P(Z,"^",5),2),$E(X1,61)=$J(+$P(Z,"^",6),2)
 . . S $E(X1,64)=$J(+$P(Z,"^",7),2),$E(X1,67)=$J(+$P(Z,"^",8),2),$E(X1,70)=$J(+$P(Z,"^",9),3)
 . . S $E(X1,74)=$J(+$P(Z,"^",10),3)
 . . S $E(X1,78)=$J($P(Z,"^",5)+$P(Z,"^",6)+$P(Z,"^",7)+$P(Z,"^",8)+$P(Z,"^",9)+$P(Z,"^",10),3)
 . . S LINE=LINE+1,^TMP("PSOERPC0",$J,LINE,0)=X1,^TMP("PSOERPC0",$J,SEQ,"PATIEN")=PATIEN
 . . I $D(LOCKPATS(PATIEN)) S HIGHLN(LINE)=1
 ;
 ; - Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 D VIDEO^PSOERPT1()
 S VALMCNT=+$G(LINE)
 Q
