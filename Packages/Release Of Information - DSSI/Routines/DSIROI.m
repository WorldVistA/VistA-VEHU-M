DSIROI ;EWL/AMC - Document Storage Systems Inc;ROI RPC's ;04/14/2011 11:18
 ;;8.2;RELEASE OF INFORMATION - DSSI;;Nov 08, 2011;Build 25
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA# Supported Reference
 ;----- --------------------------------
 ;2053  FILE^DIE
 ;2056  GET1^DIQ
 ;2056  GETS^DIQ
 ;2340  ^DIK
 ;10035 $$GET1^DIQ(2,+DFN,.09)
 ;10060 $$GET1^DIQ(200,duz,.01)
 ;10061 DEM^VADPT
 ;10009 FILE^DICN
 Q
GETTODAY(DSIRRET,DSIRCLRK,BILLING) ;RPC - DSIR GET CLERK REQUESTS
 ;Input: CLERK - Clerk IEN
 ;       BILLING - The billing system is on (1) or off(0)
 ;
 ; Return: Global Array of:
 ;  PATFOIA^RECEIVED^STATCODE^SSN^IEN^DFN
 ;
 ;  PATFOIA  - Patient Name/FOIA
 ;  RECEIVED - External Date Entered
 ;  STATCODE - Status code (numeric)
 ;  SSN
 ;  REQSTR   - Requestor Name
 ;  IEN      - Instance IEN
 ;  DFN      - Patient/FOIA DFN
 ;  INTCMNTS - INTERNAL COMMENTS 0=FALSE 1=TRUE
 ;  DISCALRT - Disclosure Alert
 ;  BILLFLAG - The requestor has outstanding bills
 ;  RQSTRIEN - The requestor IEN
 ; Setup return global
 S DSIRRET=$NA(^TMP("DSIRTODAY",$J)) K ^TMP("DSIRTODAY",$J)
 I $G(DSIRCLRK)="" S ^TMP("DSIRTODAY",$J,0)="-1^The IEN of the clerk was not provided in the call" Q 
 N IEN,IENS,GET,STATCODE,DSIRCTR,DFN,PATFOIA,SSN,RECVDDT,MONTH,DAY,YEAR,RECEIVED,REQSTR,INTCMNTS,DISCALRT,BILLFLAG S DSIRCTR=0
 ; Loop through all open/pending statuses
 ; 1=open 2=pending, 18=pending payment 19=pending clarivfioation 25=pending payment held 22=pending payment released
 F STATCODE=1,2,18,19,25,26 D
 .S IEN=0 F  S IEN=$O(^DSIR(19620,"AS",DSIRCLRK,STATCODE,IEN)) Q:'IEN  S IENS=IEN_"," D
 ..D GETS^DIQ(19620,IENS,".01;.11;203","IE","GET")
 ..S DFN=GET(19620,IENS,.01,"I"),PATFOIA=GET(19620,IENS,.01,"E"),SSN=GET(19620,IENS,203,"E")
 ..S REQSTR=GET(19620,IENS,.11,"E"),RQSTRIEN=GET(19620,IENS,.11,"I")
 ..S RECVDDT=$P(^DSIR(19620,IEN,10),U,6),MONTH=$E(RECVDDT,4,5),DAY=$E(RECVDDT,6,7),YEAR=1700+$E(RECVDDT,1,3)
 ..;S RECEIVED=MONTH_"/"_DAY_"/"_$E(YEAR,3,4),INTCMNTS=($P($G(^DSIR(19620,IEN,9,0)),U,3)>1)
 ..S RECEIVED=MONTH_"/"_DAY_"/"_YEAR,INTCMNTS=($P($G(^DSIR(19620,IEN,9,0)),U,3)>1)
 ..S DISCALRT=0,DISCALRT=+$O(^DSIR(19620.98,"B",$P($G(^DSIR(19620,IEN,0)),U,1),DISCALRT))
 ..I $G(^DSIR(19620.98,DISCALRT,1,1,0))="" S DISCALRT=""
 ..I '$G(BILLING) S BILLFLAG=0
 ..E  D STBLFLG(.BILLFLAG,IEN)
 ..S DSIRCTR=DSIRCTR+1,^TMP("DSIRTODAY",$J,RECVDDT,DSIRCTR)=PATFOIA_U_RECEIVED_U_STATCODE_U_SSN_U_REQSTR_U_IEN_U_DFN_U_INTCMNTS_U_$G(DISCALRT)_U_BILLFLAG_U_RQSTRIEN
 Q
STBLFLG(RET,IEN) ;
 ; This routine checks the requestor attached to a request to see if there
 ; are any outstanding bills other than the current request.
 ; INPUT PARAMETER
 ; IEN - This is the IEN of the request whose reqyestor is being checked for an
 ;       outstanding balance.
 ; RETURNS
 ;  1 = One or more outstanding balances exits
 ;  0 = No outstanding balances
 ;
 I '$D(^DSIR(19620,+$G(IEN),0)) S RET="-1^IEN is missing or invalid" Q
 N RQSTR,AMT,CT,RQPTR,STATCD
 S CT=0,RQSTR=$$GET1^DIQ(19620,IEN_",",.11,"I"),AMT=0
 F  S AMT=$O(^DSIR(19620.2,"ARBAL",RQSTR,AMT)) Q:'AMT!(CT>0)  S RQPTR=0 D
 .F  S RQPTR=$O(^DSIR(19620.2,"ARBAL",RQSTR,AMT,RQPTR)) Q:(CT>0)!('RQPTR)  D
 ..;TEST FOR VALID REQUEST, ALREADY FOUND,OR CURRENT IEN
 ..S STATCD=+$$GET1^DIQ(19620,RQPTR_",",10.08,"I")
 ..I (RQPTR=IEN)!("^25^26^"'[(U_STATCD_U)) Q
 ..S CT=1
 S RET=CT Q
 ; 
GETLIST(DSIRRET,TYPE,STAT,IEN,DSIRCIEN,RQIEN,STDT,ENDT) ;RPC - DSIR GET ROIS
 ;Input: TYPE: Set of Codes:
 ;        "P"  : Get list by patient
 ;        "C"  : Get list by clerk
 ;        "O"  : Get all open or pending requests.
 ;               Defaults to all requests for a given status
 ;        "R"  : Gel list by requestor
 ;
 ;       STAT: '^' Delimited (Defaults to '*')
 ;        "*"  : Get all requests of a given type
 ;        "O"  : Get only the open requests of this type
 ;        "C"  : "          " closed "                " (-D,-G,-P,-R
 ;                                                       NOTE THAT -R IS PENDING PAYMENT RELEASED)
 ;        "P"  : "          " pending "               " (-P,-H,-C)
 ;        "N"  : "          " other nondisclosure     " (-NR,-RF,-ND,-NV,-RC,-NF,-NU,
 ;                                                       -NP,-MS,-PD,-PA,-G,-SL)
 ;        "E"  : "          " entered in error "      "
 ;        "X"  : "          " cancelled "             "
 ;        "A"  : "          " appealed "              " (-RV,-PR)
 ;
 ;        IEN: IFN of patient, requestor or clerk.
 ;             If not for requestor or clerk IEN should be one of the following formats
 ;                nnnn;DPT( - VA Patient file entry
 ;                nnnn;DSIR(19620.96, - DSIR NON-COMPUTERIZED RECORDS PATIENT
 ;                1;DSIR(19620.95, - True FOIA requests
 ;
 ; Return: Array of:
 ;  1 IEN^
 ;  2 Patient Name^
 ;  3 External Date Entered^
 ;  4 Status^
 ;  5 Requestor^
 ;  6 SSN^
 ;  7 Priority^
 ;  8 FMDT^
 ;  9 Exemptions^
 ; 10 Expedite Reqstd^
 ; 11 Expedite Granted^
 ; 12 Clerk Name^
 ; 13 Opened by Clerk Name^
 ; 14 Internal Open Date^
 ; 15 External Open Date^
 ; 16 Last Closed by Clerk Name^
 ; 17 Internal Last Closed Date^
 ; 18 External Last Closed Date^
 ; 19 Last Reopened by Clerk Name^
 ; 20 Internal Last Closed Date^
 ; 21 External Last Closed Date
 ;     
 K ^TMP("DSIROI",$J) S DSIRRET=$NA(^TMP("DSIROI",$J)),STAT=$TR(STAT,"~","U")
 N ROI,INDX,XX,ST S XX=0,DSIRCIEN=+$G(DSIRCIEN),RQIEN=+$G(RQIEN)
 I '((+$G(STDT))&(+$G(ENDT))) S ^TMP("DSIROI",$J,0)="-1^Missing date range." Q
 S STDT=(STDT\1)-.0000001
 I $G(STAT)=""!($G(STAT)="*") S STAT="ALL"
 S TYPE=$G(TYPE,"O"),IEN=$G(IEN) I "PR"[TYPE,'IEN S ^TMP("DSIROI",$J,0)="-1^Invalid Input!" Q
 S:TYPE="O" STAT="O^P^P-P^P-H^C-R^P-C" D LDSTAR^DSIRRPT1(.STAT)
 S (STAT,ST)="" F  S ST=$O(STAT(ST)) Q:ST=""  S:STAT'[$E(ST) STAT=STAT_$E(ST)
 D @TYPE
 I '$O(^TMP("DSIROI",$J,0)) S ^TMP("DSIROI",$J,0)="-1^No Requests Found!"
 Q
P ;Patient lookup
 N CSTAT,DSIRDISP,STCODE
 S ROI=0 F  S ROI=$O(^DSIR(19620,"B",IEN,ROI)) Q:'ROI  D
 .S STCODE=+$P($G(^DSIR(19620,ROI,10)),U,8)
 .D:STCODE 
 ..S DSIRDISP=$P($G(^DSIR(19620.41,STCODE,0)),U) Q:DSIRDISP=""
 ..D:$D(STAT(DSIRDISP))
 ...S CSTAT=$P(DSIRDISP,"-")
 ...D FOUND
 Q
C ;Clerk lookup
 N II
 I 'IEN D  Q
 .S IEN=0 F  S IEN=$O(^DSIR(19620,"AE",IEN)) Q:'IEN  F II=1:1:$L(STAT) D
 ..S INDX=$E(STAT,II),ROI=0 F  S ROI=$O(^DSIR(19620,"AE",IEN,INDX,ROI)) Q:'ROI  D 
 ...Q:'$D(^DSIR(19620,ROI,0))
 ...Q:'$D(^DSIR(19620,ROI,10))
 ...D:$$CST FOUND
 F II=1:1:$L(STAT) S INDX=$E(STAT,II),ROI=0 F  S ROI=$O(^DSIR(19620,"AE",IEN,INDX,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .D:$$CST FOUND
 Q
CST() ;
 N STCODE,DSIRDISP
 S STCODE=+$P($G(^DSIR(19620,ROI,10)),U,8)
 I STCODE S DSIRDISP=$P($G(^DSIR(19620.41,STCODE,0)),U)
 I $D(STAT(DSIRDISP)) Q 1
 Q 0
 ;ORIGINAL CST CODE BELOW WAS REPLACED WITH ABOVE CODE
 ;I $D(STAT($P($$CURSTAT^DSIROI6(ROI),":"))) Q 1
 ;Q 0
O ;Open/Pending only
 N II
 F II=1:1:$L(STAT) S INDX=$E(STAT,II),ROI=0 F  S ROI=$O(^DSIR(19620,"ACST",INDX,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .Q:'$D(^DSIR(19620,ROI,10))
 .I $D(STAT($P($$CURSTAT^DSIROI6(ROI),":"))) D FOUND
 Q
R ;Requestor lookup
 N CSTAT
 S ROI=0 F  S ROI=$O(^DSIR(19620,"AREQ",IEN,ROI)) Q:'ROI  D
 .Q:'$D(^DSIR(19620,ROI,0))
 .Q:'$D(^DSIR(19620,ROI,10))
 .S CSTAT=$P($$CURSTAT^DSIROI6(ROI),":") I CSTAT]"" D:$D(STAT(CSTAT)) FOUND
 Q
FOUND ;
 N GET,IENS,DFN,SSN,DTENT,STAT,REQTR,PRI,PAT,VADM,FOIA,EXRQ,EXGR,STATSQ,OPDT
 S IENS=ROI_"," D GETS^DIQ(19620,IENS,".01;.03;.04;.05;.11;.66;10.05;10.06;10.08","IE","GET")
 Q:'$G(GET(19620,IENS,.01,"I"))
 I DSIRCIEN Q:$G(GET(19620,IENS,.03,"I"))'=DSIRCIEN
 I RQIEN Q:$G(GET(19620,IENS,.11,"I"))'=RQIEN
 S OPDT=$G(GET(19620,IENS,10.06,"I")) Q:(STDT>OPDT)!(OPDT>ENDT)
 S FOIA=$P(GET(19620,IENS,.01,"I"),".",2)
 S DFN=+GET(19620,IENS,.01,"I") D:'FOIA DEM^VADPT S SSN=$S('FOIA:$P(VADM(2),U),FOIA=95:"N/A",1:$P($G(^DSIR(19620.96,+GET(19620,IENS,.01,"I"),0)),U,9)),PAT=$G(GET(19620,IENS,.01,"E"))
 S REQTR=$G(GET(19620,IENS,.11,"E")),EXRQ=$G(GET(19620,IENS,.04,"I")),EXGR=$G(GET(19620,IENS,.05,"I"))
 S DTENT=$G(GET(19620,IENS,10.06,"E")),STAT=$P($$CURSTAT^DSIROI6(+IENS),":"),PRI=$G(GET(19620,IENS,.66,"E")) S:PRI="" PRI="HIGH"
 S STATSQ=$$STATSEQ^DSIROI6(ROI)
 S XX=XX+1,^TMP("DSIROI",$J,XX)=ROI_U_PAT_U_DTENT_U_STAT_U_REQTR_U_SSN_U_PRI_U_$G(GET(19620,IENS,10.06,"I"))_U_$TR($G(^DSIR(19620,ROI,12)),U,";")_U_EXRQ_U_EXGR_U_$G(GET(19620,IENS,.03,"E"))_U_STATSQ
 Q
UPDATE(DSIRRET,DSIRDAT) ;RPC - DSIR ADD/EDIT ROI
 ;Create new or update existing ROI Instance
 ; Input: 
 ;   DSIRDAT: Array
 ;    (1): Patient DFN
 ;    (2): Purpose
 ;    (3): ROI Clerk (IFN)
 ;    (4): Requestor (IFN)
 ;    (5): Received Date (FM Format)
 ;    (6): Authority for request (Pointer to 19620.51)
 ;    (7): Type of request (Pointer to 19620.61)
 ;    (8): Requestor type (Pointer to 19620.71)
 ;    (9): Other Reason Comment
 ;    (10): Priority (0 - Normal , 1 - High)
 ;    (11): Release Drug Abuse Info?                     (0 - Don't Release , 1 - Release)
 ;    (12): Release Alcoholism Info?                     (0 - Don't Release , 1 - Release)
 ;    (13): Release HIV Info?                            (0 - Don't Release , 1 - Release)
 ;    (14): Release Sickle Cell Anemia                   (0 - Don't Release , 1 - Release)
 ;    (15): Release Copy of Hospital Summary?            (0 - Don't Release , 1 - Release)
 ;    (16): Release Copy of Outpatient Treatment Notes?  (0 - Don't Release , 1 - Release)
 ;    (17): Release Other info?                          (0 - Don't Release , 1 - Release)
 ;    (18): Mail to address (Pointer to 19620.92)
 ;    (19): Patient address (Pointer to 19620.92)
 ;    (20): ROI IEN (Add new if null)
 ;    (21): Status (Default to Open if (20) is null)
 ;    (22): Exemptions 1 thru 9
 ;          This is a multi-piece value delimited by ";"
 ;          with the following exemption order
 ;          1;2;3;4;5;6;7a;7b;7c;7d;7e;7f;8;9
 ;          A one in the above positions means that exemption was used
 ;    (23): Expedite Requested (0 = No, 1 = Yes)
 ;    (24): Expedite Granted (0 = No, 1 = Yes)
 ;    (25): 38 USC 5701  (0 = No, 1 = Yes)
 ;    (26): 38 USC 5705  (0 = No, 1 = Yes)
 ;    (27): 35 USC 205   (0 = No, 1 = Yes)
 ;    (28): 38 USC 7332  (0 = No, 1 = Yes)
 ;    (29): OTHER EXEMPTION  (Free text)
 ;    (30): Document Print Order (Free text)
 ;    (31): Document Print Order Continuation (Free text)
 ;    (32): No Exceptions Required (0=N/A, 1=No Exceptions Required)
 ;    (33): Date Expedited Requested (FM Format)
 ;    (34): Expedited Adjudicated
 ;    (35): Date Expedited Adjudicated (FM Format)
 ;    (36): 41 USC 253B  (0 = No, 1 = Yes)
 ;    (37): 5 USC APP 3  (0 = No, 1 = Yes)
 ;    (38): Fee Waiver Requested (0 = No, 1 = Yes)
 ;    (39): Fee Waiver Requested Date
 ;    (40): Fee Waiver Adjudicated (0 = No, 1 = Yes)
 ;    (41): Fee Waiver Adjudicated Date
 ;    (42): Fee Waiver Granted (0 = No, 1 = Yes)
 ;    (43): No Records (0 = No, 1 = Yes)
 ;    (44): Referral (0 = No, 1 = Yes)
 ;    (45): Records Not Reasonably Described (0 = No, 1 = Yes)
 ;    (46): Not an Agency Record (0 = No, 1 = Yes)
 ;    (47): Duplicate Request (0 = No, 1 = Yes)
 ;    (48): Delivery Type (0-6)
 ;    (49): Received Type (0-3)
 ;    (50): Medically Sensitive
 ;    (51): Address type
 ;          null or 0 = undefined
 ;          1 = Primary
 ;          2 = Temportary
 ;          3 = Conficential
 ;    (52): How Created
 ;          W = Wizard
 ;          P = Multiple Patient
 ;          R = Multiple Requestor
 ;
 ; Return: DSIRRET
 ;    Successful Creation/Update: 1^IFN of file 19620
 ;    Unsuccessful Creation/Update: -1^Error Message
 ;
 N ROI,Y,X,II,DIC,IENS,DSIRFDA,NEW
 S DSIRDAT(1)=$G(DSIRDAT(1)),NEW='$G(DSIRDAT(20)) S:NEW DSIRDAT(21)="O"
 I DSIRDAT(1)'?1.N1";"3.4A1"(".E S DSIRRET="-1^Invalid Input - Missing Patient!" Q
 I NEW D  I ROI<0 S DSIRRET="-1^Unable to create ROI Instance!" Q
 .S X=DSIRDAT(1),DIC="^DSIR(19620,",DIC(0)="L" D FILE^DICN S ROI=+Y Q:Y<0
 S ROI=$G(ROI,$G(DSIRDAT(20))),IENS=ROI_","
 S:$G(DSIRDAT(2))]"" DSIRFDA(19620,IENS,10.02)=DSIRDAT(2)
 S:$G(DSIRDAT(3)) DSIRFDA(19620,IENS,.03)=DSIRDAT(3)
 S:$G(DSIRDAT(4)) DSIRFDA(19620,IENS,.11)=DSIRDAT(4)
 S:$G(DSIRDAT(5)) DSIRFDA(19620,IENS,10.06)=DSIRDAT(5)\1
 S:$G(DSIRDAT(6)) DSIRFDA(19620,IENS,10.03)=DSIRDAT(6)
 S:$G(DSIRDAT(7)) DSIRFDA(19620,IENS,10.01)=DSIRDAT(7)
 S:$G(DSIRDAT(8)) DSIRFDA(19620,IENS,10.04)=DSIRDAT(8)
 S:$G(DSIRDAT(9))]"" DSIRFDA(19620,IENS,11.01)=DSIRDAT(9)
 S:$G(DSIRDAT(10))]"" DSIRFDA(19620,IENS,.66)=DSIRDAT(10)
 F II=11:1:17 S:$G(DSIRDAT(II))]"" DSIRFDA(19620,IENS,II+60/100)=DSIRDAT(II)
 S:$G(DSIRDAT(18)) DSIRFDA(19620,IENS,.81)=DSIRDAT(18)
 S:$G(DSIRDAT(19)) DSIRFDA(19620,IENS,.82)=DSIRDAT(19)
 S:$G(DSIRDAT(23))]"" DSIRFDA(19620,IENS,.04)=DSIRDAT(23)
 S:$G(DSIRDAT(25))]"" DSIRFDA(19620,IENS,13.01)=DSIRDAT(25)
 S:$G(DSIRDAT(26))]"" DSIRFDA(19620,IENS,13.02)=DSIRDAT(26)
 S:$G(DSIRDAT(27))]"" DSIRFDA(19620,IENS,13.03)=DSIRDAT(27)
 S:$G(DSIRDAT(28))]"" DSIRFDA(19620,IENS,13.04)=DSIRDAT(28)
 S DSIRFDA(19620,IENS,200)=$G(DSIRDAT(30))
 S DSIRFDA(19620,IENS,201)=$G(DSIRDAT(31))
 S DSIRFDA(19620,IENS,202)=$G(DSIRDAT(32))
 ; CODE FOR THE EXPEDITED PROCESSING FIELDS
 ; IF EXPEDITED REQUESTED
 I +DSIRDAT(23) D
 .S DSIRFDA(19620,IENS,.04)=1
 .S DSIRFDA(19620,IENS,.06)=$G(DSIRDAT(33))
 .;IS THIS EXPEDITED REQUEST ADJUDICATED
 .I +DSIRDAT(34) D
 ..S DSIRFDA(19620,IENS,.07)=1
 ..S DSIRFDA(19620,IENS,.08)=$G(DSIRDAT(35))
 ..S DSIRFDA(19620,IENS,.05)=+$G(DSIRDAT(24))
 ..; NOT ACJUDICATED
 .I +DSIRDAT(34)=0 D
 ..S DSIRFDA(19620,IENS,.07)=0
 ..S DSIRFDA(19620,IENS,.08)=""
 ..S DSIRFDA(19620,IENS,.05)=0
 ; EXPEDITED NOT REQUESTED 
 I +DSIRDAT(23)=0 D
 .S DSIRFDA(19620,IENS,.04)=0
 .S DSIRFDA(19620,IENS,.06)=""
 .S DSIRFDA(19620,IENS,.07)=0
 .S DSIRFDA(19620,IENS,.08)=""
 .S DSIRFDA(19620,IENS,.05)=0
 ;
 S DSIRFDA(19620,IENS,13.11)=$G(DSIRDAT(36))
 S DSIRFDA(19620,IENS,13.12)=$G(DSIRDAT(37))
 I +$G(DSIRDAT(29)) D:$D(DSIRDAT(29))
 .F II=1:1:6 S DSIRFDA(19620,IENS,+(13.04+(II/100)))=$P(DSIRDAT(29),U,II)
 ;FEE WAIVER PROCESSING
 S DSIRFDA(19620,IENS,4.01)=$G(DSIRDAT(38))
 I +$G(DSIRDAT(38)) D
 .S DSIRFDA(19620,IENS,4.02)=$G(DSIRDAT(39))
 .S DSIRFDA(19620,IENS,4.03)=$G(DSIRDAT(40))
 .I +$G(DSIRDAT(40)) D
 ..S DSIRFDA(19620,IENS,4.04)=$G(DSIRDAT(41))
 ..S DSIRFDA(19620,IENS,4.05)=$G(DSIRDAT(42))
 .I +$G(DSIRDAT(40))=0 D
 ..S DSIRFDA(19620,IENS,4.04)=""
 ..S DSIRFDA(19620,IENS,4.05)=0
 I +$G(DSIRDAT(38))=0 D
 .S DSIRFDA(19620,IENS,4.02)=""
 .S DSIRFDA(19620,IENS,4.03)=0
 .S DSIRFDA(19620,IENS,4.04)=""
 .S DSIRFDA(19620,IENS,4.05)=0
 S DSIRFDA(19620,IENS,12.5)=$G(DSIRDAT(43))
 S DSIRFDA(19620,IENS,12.51)=$G(DSIRDAT(44))
 S DSIRFDA(19620,IENS,12.52)=$G(DSIRDAT(45))
 S DSIRFDA(19620,IENS,12.53)=$G(DSIRDAT(46))
 S DSIRFDA(19620,IENS,12.54)=$G(DSIRDAT(47))
 ; ADDED FOF REL 8.0
 S DSIRFDA(19620,IENS,6.07)=+$G(DSIRDAT(48))
 ; ADDED FOF REL 8.2
 S DSIRFDA(19620,IENS,6.08)=+$G(DSIRDAT(49)) ; <---- RECEIVED TYPE
 S DSIRFDA(19620,IENS,12.55)=+$G(DSIRDAT(50)) ; <--- MEDICALLY SENSITIVE
 S DSIRFDA(19620,IENS,.83)=+$G(DSIRDAT(51)) ; <--- Patient Address Type
 S DSIRFDA(19620,IENS,6.09)=$G(DSIRDAT(52)) ; <--- How Created
 ;
 ;check for exemptions
 D:$G(DSIRDAT(22))]""  I $G(DSIRRET)<0 Q:'NEW  N DA,DIK S DA=ROI,DIK="^DSIR(19620," D ^DIK K DIK Q
 .I DSIRDAT(22)["12." S DSIRRET="-1^Exemption DSIRDAT Invalid!" Q
 .N I,FLD F I=1:1:14 S FLD=12+(I/100),DSIRFDA(19620,IENS,FLD)=+$P(DSIRDAT(22),";",I)
 ;Save division
 S DSIRFDA(19620,IENS,.63)=$G(DUZ(2))
 D FILE^DIE("","DSIRFDA")
 D:$G(DSIRDAT(21))]""
 .N STAT
 .S STAT=$$STATUS^DSIROI8(ROI,DSIRDAT(21),DUZ,DSIRDAT(5))
 .; IF STATUS UPDATE FAILS
 .I (+STAT)<0 S DSIRRET=STAT
 I '$G(DSIRRET) S DSIRRET="1^"_ROI
 Q
GETREQST(RET,IEN) ; RPC - DSIROI GETREQST GET REQUEST
 ;  ADDED IN VERSION 6.1 BY EWL
 N GET,I,CT,TARGET S (I,CT)=0
 D GETS^DIQ(19620,IEN_",","*","IE","GET","EMSG")
 F  S I=$O(GET(19620,IEN_",",I)) Q:'I  D
 .D FIELD^DID(19620,I,,"LABEL","TARGET") S NAME=TARGET("LABEL")
 .S CT=CT+1,RET(CT)=I_U_NAME_U_GET(19620,IEN_",",I,"I")_U_GET(19620,IEN_",",I,"E")
 Q
ADDANNO(DSIRRET,PAT) ;RPC - DSIR ADD ANNOTATION
 ;Input Parameter
 ;  PAT - Patient Pointer (Required - FM Variable Pointer Format)
 ;     NNNN;DPT(
 ;    NNNN;DSIR(19620.96,
 ;                       
 ;Return Values
 ;
 ;  -1^Missing/Invalid Patient Pointer!
 ;  -2^Unable to add record!
 ;  NNNN - File Entry Number of added record in 19620.98
 ;       
 ;       
 N DIC,X,Y,FIL
 S PAT=$G(PAT),FIL=U_$P(PAT,";",2)_U I 'PAT!("^DPT(^DSIR(19620.96,^"'[FIL) S DSIRRET="-1^Missing/Invalid Patient Pointer!" Q
 I $O(^DSIR(19620.98,"B",PAT,0)) S DSIRRET=+$O(^DSIR(19620.98,"B",PAT,0))_U_0 Q
 S DIC="^DSIR(19620.98,",DIC(0)="L",X=PAT D FILE^DICN
 I Y<0 S DSIRRET="-2^Unable to add record!" Q
 S DSIRRET=+Y_U_1
 Q
GETCMTS(RET,IEN,SEL) ; RPC DSIROI GETCMTS GET COMMENTS
 ; INPUT PARAMETERS
 ; IEN = REQUEST INTERNAL NUMBER (required)
 ; SEL = COMMENT SELECTION (required)
 ;   This is a string that will select what type of comments to return 
 ;     I = INTERNAL COMMENTS (.32 FIELD)
 ;     P = PATIENT COMMENTS (.31 FIELD)
 ;     A = ALERTS FROM 19620.98
 ;     R = PATIENT RECORD - In this case the IEN is the patient DFN.
 ;         If R is selected, it must be the only selection. 
 ;   If more than one type of comment is desired, send the selection in a 
 ;   carrot delimited string (ie. 'A^P^I'). The data will be returned in 
 ;   the order it is requested.
 ;
 ; RETURN VALUES
 ; THE COMMENTS ARE PRECEDED BY A HEADER RECORD AS FOLLOWS:
 ; $$INTERNALCOMMENTS$$  (INDICATES THAT INTERNAL COMMENTS FOLLOW)
 ; comment line 1 ---- ----------- ---------- ------- ----------
 ; comment line 2 --------- --------- ---- ----------- ---------
 ; .....
 ; comment line n --- ----------- ---------- ------ ------------
 ; $$PATIENTCOMMENTS$$   (INDICATES THAT PATIENT COMMENTS FOLLOW)
 ; comment line 1 ---- ----------- ---------- ------- ----------
 ; comment line 2 --------- --------- ---- ----------- ---------
 ; .....
 ; comment line n --- ----------- ---------- ------ ------------
 ;
 ; NOTE: IF THERE ARE NO COMMENTS, THE ROUTINE RETURNS HEADERS ONLY
 ;
 ; OR 
 ; -1^ERROR MESSAGE
 ;
 S RET=$NA(^TMP("DSIROICMTS",$J)) K ^TMP("DSIROICMTS",$J)
 S IEN=$G(IEN) I IEN']"" S ^TMP("DSIROICMTS",$J,1)="-1^IEN IS A REQUIRED FIELD" Q
 S SEL=$G(SEL) I IEN']"" S ^TMP("DSIROICMTS",$J,1)="-1^SEL IS A REQUIRED FIELD" Q
 ;
 ; SPECIAL ALLERTS ONLY SELECTED
 I SEL="R" D  Q
 .I '$D(^DSIR(19620.98,"B",IEN)) S ^TMP("DSIROICMTS",$J,1)="$$ALERTS$$"
 .E  N REC S REC=0,REC=$O(^DSIR(19620.98,"B",IEN,REC)) D ALERTS(REC,1)
 ;
 ; ALL OTHER REQUESTS
 I IEN'=+IEN S ^TMP("DSIROICMTS",$J,1)="-1^"""_IEN_""" IS AN INVALID VALUE FOR THE IEN. A NUMERIC VALUE WAS EXPECTED." Q
 N SELCOUNT,I,IENS S IENS=IEN_",",SELCOUNT=$L(SEL,U)
 I (SELCOUNT>3)!("P^A^I^P^A^P^I^A"'[SEL) S ^TMP("DSIROICMTS",$J,1)="-1^"""_SEL_""" IS NOT A VALID SELECTION." Q
 F I=1:1:SELCOUNT D
 .I $P(SEL,U,I)["P" D PCOMMENT(IENS,I) Q
 .I $P(SEL,U,I)["I" D ICOMMENT(IENS,I) Q
 .I $P(SEL,U,I)["A" D
 ..N PAT,PREC
 ..S PAT=$$GET1^DIQ(19620,IENS,.01,"I")
 ..S REC=0,REC=$O(^DSIR(19620.98,"B",PAT,REC))
 ..D ALERTS(REC,I)
 Q
PCOMMENT(IENS,POS) ;
 S ^TMP("DSIROICMTS",$J,POS)="$$PATIENTCOMMENTS$$"
 N X S X=$$GET1^DIQ(19620,IENS,.31,,"^TMP(""DSIROICMTS"",$J,POS)")
 Q
ICOMMENT(IENS,POS) ;
 S ^TMP("DSIROICMTS",$J,POS)="$$INTERNALCOMMENTS$$"
 N X S X=$$GET1^DIQ(19620,IENS,.32,,"^TMP(""DSIROICMTS"",$J,POS)")
 Q
ALERTS(REC,POS) ;
 S ^TMP("DSIROICMTS",$J,POS)="$$ALERTS$$"
 N X S X=$$GET1^DIQ(19620.98,REC_",",100,,"^TMP(""DSIROICMTS"",$J,POS)")
 Q
