PSOBPSU2 ;BIRM/MFR - BPS (ECME) Utilities 2 ;10/15/04
 ;;7.0;OUTPATIENT PHARMACY;**260,287,289,341,290,358,359,385,421,459,482,512,544,562,660,681,703,704**;DEC 1997;Build 16
 ; Reference to ^VA(200 in ICR #10060
 ; Reference to DUR1^BPSNCPD3 in ICR #4560
 ; Reference to $$NCPDPQTY^PSSBPSUT in ICR #4992
 ; Reference to $$CLAIM^BPSBUTL in ICR #4719
 ; Reference to $$TRICVANB^PSXRPPL1 in ICR #7351
 ;
MWC(RX,RFL) ; Returns whether a prescription is (M)ail, (W)indow or (C)MOP
 ; Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ; Output: "M": MAIL / "W": WINDOW / "C": CMOP
 ;
 N MWC
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 ;
 ; If RFL is not zero, then pull the value from MAIL/WINDOW on the
 ; REFILL multiple. Otherwise, pull the value from MAIL/WINDOW
 ; at the Prescription level.
 ;
 I RFL S MWC=$$GET1^DIQ(52.1,RFL_","_RX,2,"I")
 E  S MWC=$$GET1^DIQ(52,RX,11,"I")
 ;
 ; If <blank>, default to Window.
 ; If neither Mail nor Window, quit now and skip other checks.
 ;
 I MWC="" S MWC="W"
 I MWC'="M",MWC'="W" Q MWC
 ;
 ; - Checking the RX SUSPENSE file (#52.5)
 ; File# 52, field# 100 is STATUS; 5=Suspended
 I $$GET1^DIQ(52,RX,100,"I")=5 D
 . N RXS
 . S RXS=+$O(^PS(52.5,"B",RX,0))
 . I 'RXS Q
 . ;
 . ; File#52.5, RX SUSPENSE; field# 3, CMOP INDICATOR
 . ; If the CMOP INDICATOR is not blank, then this is CMOP...
 . I $$GET1^DIQ(52.5,RXS,3,"I")'="" S MWC="C" Q
 . ; ...otherwise, this is a Mail fill.
 . S MWC="M"
 ;
 ; Checking the CMOP EVENT sub-file (#52.01)
 I MWC'="C" D
 . N CMP
 . S CMP=0
 . F  S CMP=$O(^PSRX(RX,4,CMP)) Q:'CMP  D  I MWC="C" Q
 . . I $$GET1^DIQ(52.01,CMP_","_RX,2,"I")=RFL S MWC="C"
 ;
 Q MWC
 ;
RXACT(RX,RFL,COMM,TYPE,USR) ; - Add an entry to the ECME Activity Log (PRESCRIPTION file)
 ;Input: (r) RX   - Rx IEN (#52)
 ;       (o) RFL  - Refill #  (Default: most recent)
 ;       (r) COMM - Comments (up to 100 characters)
 ;       (r) TYPE - Comments type: (M-ECME,E-Edit, etc...) See file #52 DD for all values
 ;       (o) USR  - User logging the comments (Default: DUZ)
 ;
 I '$D(^PSRX(RX)) Q
 ;
 S COMM=$E($G(COMM),1,100)
 I COMM="" Q
 ;
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 I '$D(USR) S USR=DUZ
 I '$D(^VA(200,+USR,0)) S USR=DUZ
 I '$D(^VA(200,+USR,0)) S USR=.5
 ;
 N PSOTRIC
 S PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,"")
 I PSOTRIC=1,$E(COMM,1,7)'="TRICARE" S COMM=$E("TRICARE-"_COMM,1,100)
 I PSOTRIC=2,$E(COMM,1,7)'="CHAMPVA" S COMM=$E("CHAMPVA-"_COMM,1,100)
 ;
 N DA,DD,DIC,DINUM,DLAYGO,DO,DR,X,Y
 S DA(1)=RX
 S DIC="^PSRX("_RX_",""A"","
 S DLAYGO=52.3
 S DIC(0)="L"
 S DIC("DR")=".02///"_TYPE_";.03////"_USR_";.04///"_$S(TYPE'="M"&(RFL>5):RFL+1,1:RFL)_";.05///"_COMM
 S X=$$NOW^XLFDT()
 D FILE^DICN
 Q
 ;
ECMENUM(RX,RFL) ; Returns the ECME number for a specific prescription and fill
 I $G(RX)="" Q ""
 N ECMENUM
 ;
 ; If RFL was passed in, return ECME # based on that.
 ;
 I $G(RFL)'="" S ECMENUM=$$GETECME(RX,RFL) Q ECMENUM
 ;
 ; If RFL was not passed in, determine the last refill, and return
 ; the ECME # based on that, if possible.
 ;
 S RFL=$$LSTRFL^PSOBPSU1(RX)
 S ECMENUM=$$GETECME(RX,RFL)
 I ECMENUM'="" Q ECMENUM
 ;
 ; If still no ECME #, then go backwards through the fills until
 ; we are able to determine an ECME #.
 ;
 F  S RFL=RFL-1 Q:(RFL<0)  S ECMENUM=$$GETECME(RX,RFL) I ECMENUM'="" Q
 Q ECMENUM
 ;
GETECME(RX,RFL) ; Internal function used by ECMENUM to get the ECME # from BPS
 I $G(RX)="" Q ""
 I $G(RFL)="" Q ""
 Q $P($$CLAIM^BPSBUTL(RX,RFL),U,6)
 ;
RXNUM(ECME) ; Returns the Rx number for a specific ECME number
 ;
 N FOUND,MAX,LFT,RAD,I,DIR,RX,X,Y,DIRUT
 S ECME=+ECME,LFT=0,FOUND=0
 S MAX=$O(^PSRX(9999999999999),-1)  ; MAX = largest Rx ien on file
 ;
 ; Attempt left digit matching logic in specific case only,
 ; otherwise attempt a normal lookup.
 I $L(MAX)>7,$L(ECME)'>7 D
 . S LFT=$E(MAX,1,$L(MAX)-7)  ; LFT = left most digits
 . F RAD=LFT:-1:0 S RX=RAD*10000000+ECME I $D(^PSRX(RX,0)),$$ECMENUM(RX)'="" S FOUND=FOUND+1,FOUND(FOUND)=RX
 . Q
 E  S RX=ECME I $D(^PSRX(RX,0)),$$ECMENUM(RX)'="" S FOUND=FOUND+1,FOUND(FOUND)=RX
 ;
 I 'FOUND S FOUND=-1 G RXNUMX            ; Rx not found
 I FOUND=1 S FOUND=FOUND(1) G RXNUMX     ; exactly 1 found
 ;
 ; More than 1 found so build a list and ask
 W !
 F I=1:1:FOUND W !?5,I,". ",$$GET1^DIQ(52,FOUND(I),.01),?25,$$GET1^DIQ(52,FOUND(I),6)
 W !
 S DIR(0)="NA^1:"_FOUND
 S DIR("A")="Select one: "
 S DIR("B")=1
 D ^DIR
 I $D(DIRUT) S FOUND=-1 G RXNUMX
 S FOUND=FOUND(Y)
 ;
RXNUMX ;
 Q FOUND
 ;
ELIG(RX,RFL,PSOELIG) ;Stores eligibility flag
 I RFL>0,'$D(^PSRX(RX,1,RFL,0)) QUIT
 N DA,DIE,X,Y,PSOTRIC
 I 'RFL S DA=RX,DIE="^PSRX(",DR="85///"_PSOELIG D ^DIE
 I RFL S DA=RFL,DA(1)=RX,DIE="^PSRX("_DA(1)_",1,",DR="85///"_PSOELIG D ^DIE
 Q
 ;
ECMESTAT(RX,RFL) ;called from local mail
 ; Input:
 ;  RX = Prescription File IEN
 ;  RFL = Refill
 ; Output:
 ;  0 for not allowed to print from suspense
 ;  1 for allowed to print from suspense
 ;
 N STATUS,PSOTRIC
 S STATUS=$$STATUS^PSOBPSUT(RX,RFL)
 ; IN PROGRESS claims - try again.  If still IN PROGRESS, do not allow to print
 I STATUS["IN PROGRESS" H 5 S STATUS=$$STATUS^PSOBPSUT(RX,RFL) I STATUS["IN PROGRESS" Q 0
 ;
 ; no ECME status, allow to print.  This will eliminate 90% of the cases
 I STATUS="" Q 1
 ;
 ; check for suspense hold date/host reject errors
 I $$DUR(RX,RFL)=0 Q 0
 ;
 ; check for any TRICARE/CHAMPVA rejects, not allowed to go to print until resolved.
 ; But allow to print if RX/RFL is in the TRI/CVA Audit Log with no unresolved rejects
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,.PSOTRIC)
 I PSOTRIC,STATUS'["PAYABLE",$$TRIAUD^PSOREJU3(RX,RFL) Q 1    ; on TRI/CVA Audit log - allow to print
 ;
 ; Disallow printing from suspense if the prescription has an unresolved
 ; 79/88/943 reject or an RRR reject.
 I $$FIND^PSOREJUT(RX,RFL,,"79,88,943",,1) Q 0
 ;
 Q 1
 ;
 ; This function checks to see if a RX should be submitted to ECME
 ; Submit when:
 ;  RX/Fill was not submitted before (STATUS="")
 ;  Previous submission had Host Reject Error Code(s)
 ; Input:
 ;  RX = Prescription file #52 IEN
 ;  RFL = Refill number
 ; Returns:
 ;  1 = OK to resubmit
 ;  0 = Don't resubmit
ECMEST2(RX,RFL) ;
 ; Do not resubmit a claim if this Rx has a closed eT/eC reject.
 I $$TRICVANB^PSXRPPL1(RX,RFL) Q 0
 N STATUS
 S STATUS=$$STATUS^PSOBPSUT(RX,RFL)
 ;
 ; Never submitted before, OK to submit
 I STATUS="" Q 1
 ;
 ; If status other than E REJECTED, don't resubmit
 I STATUS'="E REJECTED" Q 0
 ;
 ; Check for host reject codes(s)
 Q $$HOSTREJ(RX,RFL,1)
 ;
 ; This subroutine checks an RX/FILL for Host Reject Errors (M6, M8,
 ; NN, 99) returned from previous ECME submissions.
 ; Note that host reject errors do not pass to the pharmacy reject
 ; worklist so it's necessary to check ECME for these type errors.
 ; Input:
 ;   RX = Prescription File IEN
 ;   RFL = Refill
 ;   ONE = Either 1 or 0 - Defaults to 1
 ;     If 1, At least ONE reject code associated with the RX/FILL
 ;       must match either M6, M8, NN, or 99.
 ;     If 0, ALL reject codes must match either M6, M8, NN, or 99
 ; Return:
 ;   0 = no host rejects exists based on ONE parameter
 ;   1 = host reject exists based on ONE parameter
 ;   Note:  The REJ array may be updated by the call to DUR1^BPSNCPD3.
HOSTREJ(RX,RFL,ONE) ; called from PSXRPPL2 and this routine
 N IDX,TXT,CODE,HRCODE,HRQUIT,RETV,REJ,I
 S IDX="",(RETV,HRQUIT)=0
 I '$D(ONE) S ONE=1
 ;for print from suspense there will only be primary insurance or an index of 1 in REJ array
 D DUR1^BPSNCPD3(RX,RFL,.REJ) ; Get reject list from last submission if not present
 S TXT=$G(REJ(1,"REJ CODE LST"))
 I TXT="" Q 0
 I ONE=0,TXT'["," S ONE=1
 F I=1:1:$L(TXT,",") S CODE=$P(TXT,",",I) D  Q:HRQUIT
 . F HRCODE=99,"M6","M8","NN" D  Q:HRQUIT
 . . I CODE=HRCODE S RETV=1 I ONE S HRQUIT=1 Q
 . . I CODE'=HRCODE,RETV=1 S RETV=0,HRQUIT=1 Q
 Q RETV
 ;
 ; Input: RX = Prescription file #52 IEN
 ;       RFL = Refill number
 ; Returns: A value of 0 (zero) will be returned when reject codes M6, M8,
 ; NN, and 99 are present OR if on susp hold which means the prescription should not
 ; be printed from suspense. Otherwise, a value of 1(one) will be returned.
DUR(RX,RFL) ;
 N REJ,IDX,TXT,CODE,SHOLD,SHCODE,ESTAT,SHDT
 S SHOLD=1,IDX=""
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S SHDT=$$SHDT(RX,RFL) ; Get suspense hold date for rx/refill
 I SHDT'="",SHDT'<$$FMADD^XLFDT(DT,1) Q 0
 I $$HOSTREJ^PSOBPSU2(RX,RFL,1) I SHDT="" S SHOLD=0 D SHDTLOG(RX,RFL)
 Q SHOLD
 ;
 ; This subroutine sets the EPHARMACY SUSPENSE HOLD DATE field
 ; for the rx or refill to tomorrow and adds an entry to the SUSPENSE Activity Log.
 ; Input: RX = Prescription File IEN
 ;       RFL = Refill
SHDTLOG(RX,RFL) ;
 N DA,DIE,DR,COMM,SHDT
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S SHDT=$$FMADD^XLFDT(DT,1)
 S COMM="SUSPENSE HOLD until "_$$FMTE^XLFDT(SHDT,"2D")_" due to host reject error."
 I RFL=0 S DA=RX,DIE="^PSRX(",DR="86///"_SHDT D ^DIE
 E  S DA=RFL,DA(1)=RX,DIE="^PSRX("_DA(1)_",1,",DR="86///"_SHDT D ^DIE
 D RXACT(RX,RFL,COMM,"S",+$G(DUZ)) ; Create Activity Log entry
 Q
 ;
 ; This function returns the EPHARMACY SUSPENSE HOLD DATE field
 ; for the original fill or the refill.
 ; Input: RX = Prescription File IEN
 ;       RFL = Refill
SHDT(RX,RFL) ;
 N FILE,IENS
 I '$D(RFL) S RFL=$$LSTRFL^PSOBPSU1(RX)
 S FILE=$S(RFL=0:52,1:52.1),IENS=$S(RFL=0:RX_",",1:RFL_","_RX_",")
 Q $$GET1^DIQ(FILE,IENS,86,"I")
 ;
ELOG(RESP) ; Logs an ECME Activity Log if Rx Qty is different than Billing Qty
 I '$G(RESP),$T(NCPDPQTY^PSSBPSUT)'="" D
 . N DRUG,RXQTY,BLQTY,BLDU,Z
 . S DRUG=$$GET1^DIQ(52,RX,6,"I")
 . S RXQTY=$S('RFL:$$GET1^DIQ(52,RX,7,"I"),1:$$GET1^DIQ(52.1,RFL_","_RX,1))/1
 . S Z=$$NCPDPQTY^PSSBPSUT(DRUG,RXQTY),BLQTY=Z/1,BLDU=$P(Z,"^",2)
 . I RXQTY'=BLQTY D
 . . D RXACT(RX,RFL,"QUANTITY SUBMITTED ON CLAIM: "_$J(BLQTY,0,$L($P(BLQTY,".",2)))_" ("_BLDU_")","M",DUZ)
 Q
 ;
UPDFL(RXREC,SUB,INDT) ; Update fill date with release date when NDC changes at CMOP and OPAI auto-release
 ; Input: RXREC = Prescription File IEN
 ;         SUB = Refill
 ;        INDT = Release date
 N COM,DA,DEAD,DIE,DR,DTOUT,DUOUT,EXDAT,EXPDATE,II,OFILLD
 N PSOSUSPA,RXRECI
 ;
 S DEAD=0
 S EXDAT=INDT
 I EXDAT["." S EXDAT=$P(EXDAT,".")
 ;
 ; If the expiration date of the prescription is on or before
 ; the Released Date, then Quit out (i.e. do not change the
 ; Fill Date, do not add an entry to the Activity Log).
 ;
 S EXPDATE=$$GET1^DIQ(52,RXREC,26,"I")
 I EXPDATE'="",EXPDATE'>EXDAT Q
 ;
 I '$D(SUB) S SUB=0 F II=0:0 S II=$O(^PSRX(RXREC,1,II)) Q:'II  S SUB=+II
 I 'SUB D
 . S OFILLD=$$GET1^DIQ(52,RXREC,22,"I")
 . I OFILLD=EXDAT Q
 . S DA=RXREC
 . S DIE=52
 . S DR="22///"_EXDAT_";101///"_EXDAT
 . D ^DIE
 . K DIE,DA
 . Q
 I SUB D
 . S OFILLD=$$GET1^DIQ(52.1,SUB_","_RXREC,.01,"I")
 . I OFILLD=EXDAT Q
 . S DA=SUB
 . S DA(1)=RXREC
 . S DIE="^PSRX("_DA(1)_",1,"
 . S DR=".01///"_EXDAT
 . D ^DIE
 . K DIE
 . S $P(^PSRX(RXREC,3),"^")=EXDAT  ; Field# 101, Last Dispensed Date
 . Q
 I $D(DTOUT)!($D(DUOUT)) Q
 ;
 S RXRECI=$O(^PS(52.5,"B",RXREC,0))
 I RXRECI S PSOSUSPA=$P($G(^PS(52.5,RXRECI,0)),"^",5)
 S COM="Change "_$S($G(PSOSUSPA):"Partial",'$G(SUB):"Fill",1:"Refill")_" Date "_$E(OFILLD,4,5)_"/"_$E(OFILLD,6,7)_"/"_$E(OFILLD,2,3)_" to "_$E(INDT,4,5)_"/"_$E(INDT,6,7)_"/"_$E(INDT,2,3)
 D RXACT(RXREC,SUB,COM,"S",DUZ)
FIN ;
 Q
 ;
SEND(PSORX,PSOFILL) ; Determine whether to send a claim.
 ;
 ; Returns: 1 = Send a claim
 ;          0 = Do not send a claim
 ;
 ; A claim should not be sent if the last submission was rejected
 ; and all rejects have been closed.
 ;
 ; If status of last submission is not E REJECTED, then send a claim.
 ;
 N PSOSTATUS
 S PSOSTATUS=$$STATUS^PSOBPSUT(PSORX,PSOFILL)
 I PSOSTATUS'="E REJECTED" Q 1
 ;
 ; If there are any open rejects, then send a claim.
 ;
 I $$FIND^PSOREJUT(PSORX,PSOFILL) Q 1
 ;
 ; The last submission was rejected, and there are no open rejects.
 ; Quit with a 0 (zero) to indicate a claim should not be sent.
 ;
 Q 0
