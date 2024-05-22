IBECEAMH ;EDE/SAB - Cancel/Edit/Add... Mental Health Utilities ; 21-APR-23
 ;;2.0;INTEGRATED BILLING;**784**;21-MAR-94;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to FILE #27.11 in ICR #5158
 ; Reference to FILE #2 in ICR #7182
 ;
ISCDELIG(IBDOS) ;Is the Date of Service allow the bill to be Cleland-Dole Eligible
 ; INPUT   - IBDOS - Date of Service of the Bill in question or the bill attempting to be created
 ; Returns - 0 - Not eligible
 ;           1 - Eligible for Cleland-Dole Review
 ;
 N IBCDEFF,IBCDEND
 S IBCDEFF=$$GET1^DIQ(350.9,"1,",71.03,"I")
 S IBCDEND=$$GET1^DIQ(350.9,"1,",71.04,"I")+1  ; IBDOS may have a time stamp, so add 1 to ensure bills on the end date are considered eligible.
 I (IBDOS'<IBCDEFF),(IBDOS<IBCDEND) Q 1
 Q 0
 ;
ISCDCANC(IBIEN) ; Check to see if bill is cancellable
 ;INPUT - IBIEN The Bill Number
 ; Returns - 0 - Not eligible
 ;           1 - Eligible for Cleland-Dole Review
 ;
 ;Initializations
 N IBDATA,IBENC,IBSCDIEN,IBSTCD,IBRES,Z
 ;
 ;Extract the Stop Code
 S IBDATA=$G(^IB(IBIEN,0))
 S IBSCDIEN=$P(IBDATA,U,20) I 'IBSCDIEN Q 0
 S IBSTCD=$$GET1^DIQ(352.5,IBSCDIEN_",",.01,"E")
 S IBRES=$$STCDCHK(IBSTCD)
 I 'IBRES S Z=$P($P(IBDATA,U,4),";") I $P(Z,":")="409.68" S IBRES=$$CHKST44($P(Z,":",2))
 Q IBRES
 ;
STCDCHK(IBSTCD) ;Check to see if the stop code is eligible for C-D cancellation. 
 ;INPUT: IBSTCD - Stop Code associated with the bill.
 ; Returns - 0 - Not eligible
 ;           1 - Eligible for Cleland-Dole Review
 ;
 N STCDARY
 ;
 ; Grab all of the Stop Codes that are automatically eligible for the Cleland-Done Benefit check.
 S STCDARY=""
 D GETSTCD(.STCDARY)
 ;
 ; If the stop code passed in to be checked is in the array, the return a 1, otherwise, exit with a 0
 Q:$D(STCDARY(IBSTCD)) 1
 Q 0
 ;
GETSTCD(STCDARY) ; Retrieve the list of Stop codes that are Cleland Dole Eligible
 ;INPUT - None
 ;OUTPUT - STCDARY - Array of Stop Codes that are Cleland Dole eligible
 ;
 N LOOP,IBDATA
 ;
 ; Grab all of the Stop Codes that are automatically eligible for the Cleland-Done Benefit check.
 F LOOP=1:1 S IBDATA=$T(STOPCODE+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . Q:IBDATA=""    ;go to next entry No data in Call.
 . ;store the stop code into a local arrary
 . S STCDARY($P(IBDATA,";",3))=""
 Q
 ;
STOPCODE ; List of stop codes eligible for Cleland Dole tracking and cancellations
 ;;156
 ;;157
 ;;502
 ;;509
 ;;510
 ;;513
 ;;514
 ;;516
 ;;519
 ;;523
 ;;524
 ;;527
 ;;528
 ;;533
 ;;534
 ;;535
 ;;536
 ;;538
 ;;539
 ;;542
 ;;545
 ;;546
 ;;550
 ;;552
 ;;560
 ;;562
 ;;564
 ;;565
 ;;566
 ;;567
 ;;568
 ;;573
 ;;574
 ;;575
 ;;576
 ;;577
 ;;579
 ;;582
 ;;583
 ;;584
 ;;596
 ;;597
 ;;598
 ;;599
 ;;END
 Q 
PRCLSCHK(IBPRSCLS) ;Check to see if the Person Class associated with an Outpatient Copay is eligible for Cleland-Dole Tracking and cancellations.
 ;INPUT: IBPRSCLS - Person Class associated with a doctor associated with the outpatient bill.
 ; Returns - 0 - Not eligible
 ;           1 - Eligible for Cleland-Dole Review
 ;
 N PRSCLARY
 ;Get the List of Person Classes
 D GETPRCL(.PRSCLARY)
 ; If the Person class passed in to be checked is in the array, the return the return value, otherwise, exit with a 0
 Q $S($D(PRSCLARY(IBPRSCLS)):1,1:0)
 ;
GETPRCL(PRSCLARY) ;
 ;INPUT - None
 ;OUTPUT - PRSCLARY - Array of Person classes that are Cleland Dole eligible
 ;
 N LOOP,IBDATA
 F LOOP=2:1 S IBDATA=$T(PRSCLS+LOOP) Q:$P(IBDATA,";",3)="END"  D
 .Q:IBDATA=""
 .S PRSCLARY($P(IBDATA,";",4))=""
 Q
 ;
PRSCLS ; List of Person Classes
 ;;Person Class;Class Code
 ;;PSYCHIATRIST;V182911
 ;;LPMHC;V010205
 ;;MFT;V010202
 ;;PSYCHOLOGY;V010400
 ;;SOCIAL WORK;V010100
 ;;END
 Q
MHCPTCHK(IBCPT) ;Checks to see if the CPT code is Cleland-Dole eligible for tracking and cancellation
 ;INPUT: IBCPT - CPT Code
 ; Returns - 0 - Not eligible
 ;           1 - Eligible for Cleland-Dole Review
 ;
 N CPTARY
 ;
 ; Grab all of the Stop Codes that are automatically eligible for the Cleland-Done Benefit check.
 S CPTARY=""
 D GETCPT(.CPTARY)
 ;
 ; If the Person class passed in to be checked is in the array, the return the return value, otherwise, exit with a 0
 Q:$D(CPTARY(IBCPT)) 1
 Q 0
 ;
GETCPT(CPTARY) ; Utility to gather the list of CPT Codes eligible for Cleland Dole Tracking and Cancellation
 ;INPUT - None
 ;OUTPUT - CPTARY - Array of CPT Codes that are Cleland Dole eligible
 ;
 N LOOP,IBDATA
 ;
 F LOOP=1:1 S IBDATA=$T(CPTCODE+LOOP) Q:$P(IBDATA,";",3)="END"  D
 . Q:IBDATA=""    ;go to next entry No data in Call.
 . ;store the stop code into a local arrary
 . S CPTARY($P(IBDATA,";",3))=""
 Q
 ;
CPTCODE ; List of CPT Codes that are eligble for Cleland Dole Tracking and copay cancellation
 ;;99202
 ;;99203
 ;;99204
 ;;99205
 ;;99212
 ;;99213
 ;;99214
 ;;99215
 ;;90832
 ;;90834
 ;;90837
 ;;90839
 ;;90791
 ;;90792
 ;;END
 Q
 ;
NUMVSTCK(DFN,IBDOS) ; Check the DB to for the number of visits in a calendar year for a Veteran
 ;
 ; INPUT: DFN   - Patient IEN CPT Code
 ;        IBDOS - Date of Service
 ; Returns - 0 - All Free Visits used
 ;           1 - Free Visits Still Remain
 ;
 N NUMVST,YR,LP,DATA,VD
 ;
 S NUMVST=0
 ;
 S YR=$E(IBDOS,1,3)
 ;
 S LP=0
 F  S LP=$O(^IBMH(351.83,"B",DFN,LP)) Q:'LP  D  Q:NUMVST=3
 . ;get the visit entry
 . S DATA=$G(^IBMH(351.83,LP,0))
 . ;get the visit date
 . S VD=$P(DATA,U,3)
 . ;If visit prior to the DOS being checked, skip
 . I $E(VD,1,3)'=YR Q
 . ;If the correct year and the visit was free, update the counter
 . I $P(DATA,U,4)=1 S NUMVST=NUMVST+1
 ;If the Number of Free Visits is <3 return 1
 I NUMVST<3 Q 1
 ;Else, return 0
 Q 0
 ;
ADDVST(DFN,IBDT,IBN,IBSTATUS,IBREAS,IBSITE) ; Update the Visit Tracking DB
 ;
 ;Input:
 ;   DFN      - (Required) Patient IEN (from file #2)
 ;   IBDT     - (Required) Date of Visit
 ;   IBN      - (Required) Copay IEN (from file #350)
 ;   IBSTATUS - (Required) Mental Helath Visit Billing Status
 ;              1 - FREE
 ;              2 - BILLED (i.e. copay was created)
 ;              3 - Not Counted (i.e. MH visit was cancelled at the site)
 ;              4 - Visit Only (Visit counted, but no bill produced)
 ;   IBREAS   - Code # for the comment
 ;   IBCMT    - Add SC/SA/SV (1) comment if adding a visit for a PG6.
 ;   IBSITE   - (Optional) Site where the copay was charged.  Defaults to IBFAC if not passed in.
 ;
 N FDA,FDAIEN,IBSITE,IBBILL,IBERROR,IBBLSTAT
 ;
 ;check for a defined site in the copay file
 I $G(IBSITE)="" S IBSITE=$$STA^XUAF4($$GET1^DIQ(350,$G(IBN)_",",.13,"I")) S:IBSITE]"" IBSITE=+IBSITE
 ;
 ;Otherwise, default to IBFAC
 ;IBFAC can be an IEN for a child and not the actual facility so it may not be the IEN for the actual site. Pretty sure IBSITE will already be defined
 ;but if we need to use IBFAC, let's turn it into a site number
 S:$G(IBSITE)="" IBSITE=$$STA^XUAF4(IBFAC)
 ;
 S IBBILL=$$GET1^DIQ(350,$G(IBN)_",",.11,"E")
 S IBREAS=$G(IBREAS)
 ;
 ;If no Bill Number, check to see if on hold.  If so, store ON HOLD
 I IBBILL="" D
 . S IBBLSTAT=$$GET1^DIQ(350,$G(IBN)_",",.05,"I")
 . ; If bill status is 8 (On Hold) then store On Hold as the Bill Number
 . I IBBLSTAT=8 s IBBILL="ON HOLD"
 ;
 ;Call utility to add to DB
 D ADD(IBN,DFN,IBSITE,IBDT,IBSTATUS,IBBILL,IBREAS,1,"",.IBERROR)
 Q
 ;
ADD(IBN,IBDFN,IBSITE,IBVISDT,IBSTAT,IBBILL,IBCOMM,IBUPDATE,IBUNIQ,RETURN) ; Add an entry to the file
 ; INPUT:
 ;        IBDFN - Pointer to the patient number
 ;        IBSITE - external site number
 ;        IBVISDT - Visit date
 ;        IBSTAT - Status
 ;        IBBILL - Bill number or possibly free text description such as 'ONHOLD'
 ;        IBCOMM - Cancel reason
 ;        IBUPDATE - 1 if this is the originating site and data should be pushed out to other treating facilities, otherwise 0
 ;        IBUNIQ - Unique ID consiting of external site number underscor ien of file 351.83 on originating site ex. 442_1234567
 ; OUTPUT:
 ;        RETURN - This is any information returned by FileMan if update was unsuccessful
 ;  
 ; Function call returns 0 or 1 if successful.
 ; data must be all internal or all external - no mashup of the two allowed
 ; I vote internal and since I am coding...
 ; the incoming parameters were all internal except site #.
 ; NOTE to self: internal data is filed without validation so be sure it's cool
 ;
 N IBCTS,IBMAXFR
 ;Last chance check to see if all free visits are used up.  If so, don't add the visit and exit.
 I $G(IBSTAT)=1,'$$NUMVSTCK(IBDFN,IBVISDT) D  Q 0
 . N Y
 . S Y=IBVISDT X ^DD("DD")
 . S RETURN="Exceeds MAX free visits in a calendar year.  Can't add "_Y_"."
 ;
 N FDA,IENS
 S IENS="+1,"
 S FDA(351.83,IENS,.01)=IBDFN
 S FDA(351.83,IENS,.02)=$$FIND1^DIC(4,,"X",IBSITE,"D")   ; turn external site # into internal one
 S FDA(351.83,IENS,.03)=IBVISDT
 S FDA(351.83,IENS,.04)=$G(IBSTAT)
 S FDA(351.83,IENS,.05)=$G(IBBILL)
 S FDA(351.83,IENS,.06)=$G(IBCOMM)
 S FDA(351.83,IENS,.07)=$G(IBUNIQ)
 S FDA(351.83,IENS,.08)=$G(IBN)
 S FDA(351.83,IENS,1.01)=$G(IBUPDATE)  ; While technically being added, this is not the originating site so don't mark as such.  The flag is used to determine which entries to push.
 ;
 ; first parameter is currently "" so internal it is for now
 D UPDATE^DIE("","FDA","","RETURN")
 ;
 ; if RETURN is defined then BAD else GOOD
 Q $S($D(RETURN):0,1:1)
 ;
CHKST44(IBOE) ; check stop codes in file 44 for Cleland Dole eligibility
 ;
 ; IBOE - ien in file 409.68
 ;
 ; returns 1 if either stop code (44/8) or credit stop code (44/2503) is eligible for C-D, or 0 otherwise.
 ;
 N FLD,IBLOC,IBSTIEN,IBSTOP,RES
 S RES=0
 S IBLOC=$$GET1^DIQ(409.68,IBOE,.04,"I")
 I IBLOC D
 .F FLD=8,2503 D  Q:RES
 ..S IBSTIEN=$$GET1^DIQ(44,IBLOC,FLD,"I") I IBSTIEN S IBSTOP=$$GET1^DIQ(40.7,IBSTIEN,1) I IBSTOP,$$STCDCHK(IBSTOP) S RES=1
 ..Q
 .Q
 Q RES
 ;
CDCHK(IBSTOPDA,IBFR) ;
 ; INPUT: IBSTOPDA  - Stop Code
 ;        IBFR      - Date of Service
 ; Returns - 0 - Not eligible
 ;           1 - Eligible
 ;
 N CDDTCHK,IBSTCHCK
 S CDDTCHK=$$ISCDELIG^IBECEAMH(IBFR)  ;Date Check Flag
 Q:'CDDTCHK 0                         ;Exit if not within date range
 S IBSTCHCK="" I ($G(IBSTOPDA)'="") S IBSTCHCK=$$STCDCHK^IBECEAMH(IBSTOPDA)  ;Stop code check flag, if stop code present
 I CDDTCHK,IBSTCHCK Q 1
 Q 0
 ;
DTCHK(DFN,IBEVDT) ; Checks to see if the copay being cancelled as C-D is in the correct sequence (i.e. 1 of the oldest 3 for the calendar year)
 ; INPUT: DFN     - Patient
 ;        IBEVDT  - Date of Service
 ; Returns - 0 - No sequence issue
 ;           1 - Possible sequence issue
 ;
 N STARTDT,ENDDT,LP,CHK,CT,SQFLG,DATA,VD,STAT
 ;
 S STARTDT=$E(IBEVDT,1,3)_0000,ENDDT=$E(IBEVDT,1,3)_9999
 S LP=0,CHK=1,CT=0,SQFLG=0
 ;Loop through the patients entries.  Quit if:
 ;  - None found for the calendar year.
 ;  - If 3 Free visits found without a sequence issue
 ;  - a sequence issue is found.
 ;
 F  S LP=$O(^IBMH(351.83,"B",DFN,LP)) Q:'LP  D  Q:CT=3  Q:SQFLG
 . S DATA=$G(^IBMH(351.83,LP,0))
 . S VD=$P(DATA,U,3),STAT=$P(DATA,U,4)
 . I (IBEVDT<STARTDT)!(IBEVDT>ENDDT) Q  ;Not for the calendar year, get the next entry
 . I STAT=1 D    ;If entry is a free visit, update count and check sequence.
 . . S CT=CT+1
 . . I IBEVDT<VD S SQFLG=1  ;Event Date is before a Free visit.  Possible sequence issue.
 Q SQFLG
 ;
MESS1 ; Visit cancelled due to Cleland Dole.
 W !!,"Under the Cleland-Dole Act of 2022, this visit is free."
 Q
 ;
MESS2 ; User received their 3 free visits
 N IBX
 W !!,"Under the Cleland-Dole Act of 2022, this patient has already"
 W !,"received their 3 free Mental Health visits for this calendar year."
 R !!,?10,"Press any key to continue.    ",IBX:DTIME
 Q
 ;
MESS2A ;User received 3 free visits, but the DoS is prior to one of those free visits.
 N IBX
 W !!,"Under the Cleland-Dole Act of 2022, this patient has already received"
 W !,"3 free visits for this calendar year.   This date of service is prior to"
 W !,"the previously filed free visits for the calendar year.  The free visit"
 W !,"sequence should be reviewed for updating or re-billing."
 R !!,?10,"Press any key to continue.    ",IBX:DTIME
 Q
 ;
MESS2B ; User received their 3 free visits
 W !!,"This visit has been entered into the Mental Health Visit Tracking"
 W !,"Database."
 Q
 ;
MESS3(IBFLG) ;
 ;
 ;INPUT: IBFLG = 1 - Add No Free Visits remaining verbiage.
 ;               0 or NULL - Standard Message
 ;
 N IBX
 S IBFLG=$G(IBFLG)
 W !!,"This bill is not eligible for cancellation under the Cleland-Dole Act of 2022"
 I IBFLG W !," because no more free visits are available"
 W "."
 W !,"Please select another cancellation reason."
 R !!,?10,"Press any key to continue.    ",IBX:DTIME
 W !!
 Q
 ;
OECHK(IBOE,IBEVDT) ;
 ; INPUT: IBOE   - Outpatient Encounter IEN (from Bill Resulting From field (#350, .04, 2nd ";" piece)
 ;        IBEVDT - Date of Service
 ; Returns - 0 - Encounter Not eligible under Cleland-Dole
 ;           1 - Encounter eligible under Cleland-Dole
 ;
 N IBSDV,ERR,IBLP,RES,IBPRVIEN,IBPRCLS,IBCPTCHK,IBCPTARY,IBLP1,IBCPTCHK
 ;
 ;gets the list of providers on an encounter
 S (IBSDV,ERR)=""
 D GETPRV^SDOE(IBOE,"IBSDV","ERR")
 Q:$D(ERR)>1 0      ;Errors present
 Q:$D(IBSDV)'=11 0  ;No providers found
 ;
 ;Loop through the providers, check their Person Class.  if Person class returns a 1, Encounter is eligible.  If it returns a 2, Need to check the CPT codes
 S (RES,IBLP)=0
 F  S IBLP=$O(IBSDV(IBLP)) Q:IBLP=""  D  Q:RES=1
 . S IBCPTARY=""
 . ; Get the User IEN of the Provider
 . S IBPRVIEN=$P($G(IBSDV(IBLP)),U)
 . ; Get the Person Class ID
 . S IBPRCLS=$P($$GET^XUA4A72(IBPRVIEN,IBEVDT),U,7) I IBPRCLS="" Q  ; person class
 . ; Check to see if it is Cleland Dole Eligible
 . Q:'$$PRCLSCHK^IBECEAMH(IBPRCLS)  ; Provider is not Cleland-Dole eligible.
 . ;Provider can potentially make the encounter Cleland Dole Eligible if a C-D eligible CPT code is used.  Check the CPT code.
 . D GETPCECP^IBOMHC(IBOE,.IBCPTARY)
 . S IBLP1="",IBCPTCHK=0
 . ;Loop through the CPT codes.  If a C-D eligible CPT code is found on the encounter, quit.
 . F  S IBLP1=$O(IBCPTARY(IBLP1)) Q:IBLP1=""  S IBCPTCHK=$$MHCPTCHK(IBLP1) I IBCPTCHK S RES=1 Q
 . K IBCPTARY
 Q RES
 ;
UPMHDB(DFN,IBDOS) ; Update the MH Visit Tracking DB if the Cancellation Reason is usable on MH copays
 ;
 N IBNOFRVS
 ;
 ;Retrieve # visits
 S IBNOFRVS=$$NUMVSTCK(DFN,IBDOS)
 ;
 ;If free visit remain, convert visit to Free Visit
 I IBNOFRVS<3 D UPDVST(3) Q
 ;
 ;Otherwise, visit only.
 D UPDVST(2)
 ;
 Q
 ;
UPDVST(IBN,IBCAN,IBVSTIEN) ; update the Visit Tracking file
 ;
 ;INPUT - IBCAN - Type of Update to perform
 ;             1 - Remove with Entered in Error Message
 ;             2 - Visit Only Update
 ;             3 - Free (if free not used) or Visit Only
 ;             4 - Remove with Duplicate Error message
 ;
 N IBSTAT,IBREAS,IBRTN,IBERROR
 I $G(IBCAN)'>0 Q
 S IBERROR=""
 S IBVSTIEN=$G(IBVSTIEN,0) I 'IBVSTIEN S IBVSTIEN=+$O(^IBMH(351.83,"D",IBN,""))
 I IBVSTIEN=0 D  Q
 .W !!,"Unable to locate the bill in the Mental Health Visit Tracking Database"
 .W !,"for this veteran.  Please review and update the Mental Health Visit "
 .W !,"Tracking Maintenance Utility.",!
 .Q
 ;
 ;Set Status and Reason based on update type.
 S:IBCAN=1 IBREAS=3,IBSTAT=3   ;Visits Removed
 S:IBCAN=2 IBREAS=5,IBSTAT=4   ;Visit set to Visit Only
 S:IBCAN=3 IBREAS=1,IBSTAT=1   ;Free visit
 S:IBCAN=4 IBREAS=4,IBSTAT=3   ;Duplicate Visit
 ;
 S IBRTN=$$UPDATE(0,IBVSTIEN,IBSTAT,"",IBREAS,1,.IBERROR)
 ;
 Q
 ;
FNDVST(IBBLNO,IBVSTDT,IBN) ; Locate the Visit IEN
 ;
 N IBVSTIEN,IBVSTD,IBFOUND
 S IBVSTIEN=0,IBFOUND=0
 F  S IBVSTIEN=$O(^IBMH(351.83,"C",IBBLNO,IBVSTIEN)) Q:IBVSTIEN=""  D  Q:IBFOUND=1
 . S IBVSTD=$G(^IBMH(351.83,IBVSTIEN,0))
 . I (IBVSTDT=$P(IBVSTD,U,3)),(IBN=$P(IBVSTD,U)) S IBFOUND=1
 Q +IBVSTIEN
 ;
UPDATE(IBNP,IBIEN,IBSTAT,IBBILL,IBCOMM,IBUPDATE,RETURN) ; update an entry to the file
 ;  INPUT:
 ;        IBNP   - Flag for processing type
 ;                  1 = Nightly Process
 ;                  0 or NULL  = Manual Update (IB CANCEL/EDIT/ADD, MH Visit Maintenance,etc.)
 ;        IBIEN  - internal entry number into 351.82 that is being edited
 ;        IBSTAT - Status
 ;        IBBILL - Bill number or possibly free text description such as 'ONHOLD'
 ;        IBCOMM - Cancel reason 
 ;        IBUPDATE  - 1 if this is the originating site and data should be pushed out to other treating facilities, otherwise 0
 ;  OUTPUT:
 ;        RETURN - This is any information returned by FileMan if update was unsuccessful
 ;  
 ; Function call returns 0 or 1 if successful.
 ;    
 ; limiting edits to a few fields
 ; data must be all internal or all external - no mashup of the two allowed
 ; I still vote internal and since I am still coding...
 ; the incoming parameters were all internal
 ; NOTE to self: internal data is filed without validation so be sure it's cool
 ;
 ; returns 1 if added sucessfully
 ; returns 0 otherwise
 ;
 N IBCTS,IBMAXFR,IBDFN,IBVISDT,IBY,IBDOS
 S IBDFN=$$GET1^DIQ(351.83,IBIEN,.01,"I")
 S IBDOS=$$GET1^DIQ(351.83,IBIEN,.03,"I")
 S IBVISDT=$$GET1^DIQ(351.83,IBIEN,.03,"I")
 ;S IBMAXFR=3  ; max free visits in a calendar year
 ;S IBCTS=$$GETVST^IBECEA36(IBDFN,IBVISDT)
 S IBCTS=$$NUMVSTCK(IBDFN,IBDOS),IBY=0
 I $G(IBSTAT)=1,'IBCTS D  Q:IBY<0
 . I IBNP D
 . . N Y
 . . S Y=IBVISDT X ^DD("DD")
 . . S RETURN="Exceeds MAX free visits in a calendar year.  Can't update "_Y_"."
 . . S IBY=-1
 . ;CHECK WITH USER OR AUTO CHANGE TO vISIT ONLY - currently auto change to visit only
 . S IBSTAT=4
 ;
 N FDA,IENS
 S IENS=IBIEN_","
 S FDA(351.83,IENS,.04)=$G(IBSTAT)
 S FDA(351.83,IENS,.05)=$G(IBBILL)
 S FDA(351.83,IENS,.06)=$G(IBCOMM)
 S FDA(351.83,IENS,1.01)=$G(IBUPDATE,0)
 ;
 ; first parameter is currently "" so internal it is for now
 D FILE^DIE("","FDA","RETURN")
 ;
 ; if RETURN is defined then BAD else GOOD
 Q $S($D(RETURN):0,1:1)
 ;
ASKMH() ; Mental Health visit (Cleland - Dole) confirmation prompt
 ;
 ; returns 1 for "yes", 0 for "no", or -1 for user exit / timeout
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A")="Is this visit covered under the Cleland Dole Act? (Y/N): "
 S DIR(0)="YA"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(+Y=1:1,1:0)
 ;
ASKCONT() ; "do you wish to continue" confirmation prompt
 ;
 ; returns 1 for "yes", 0 for "no", or -1 for user exit / timeout
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A")="Do you wish to continue? (Y/N): "
 S DIR(0)="YA"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(+Y=1:1,1:0)
