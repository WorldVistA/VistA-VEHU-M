ZVHBCIV ;OIA/AJC+TJH - Auto populate BCMA data for demos ; 6/18/14
 ;;0.1;NO PACKAGE;**NO PATCHES**;2/12/2014
 ;
 ; called by ZVHBC and ZVHBC3 (IV and PRN meds for ZVHBC)
 ;----------------------------------------------------------
 ;
 W "Not an entry point!  Use EN^ZVHBC",!! Q  ; labels in this routine are called by ZVHBC and ZVHBC3
 ;
RN(ZVHDATE,ZVHUSARRAY,ZVHERRUS)  ; 
 ; Get nurses array who are active on that date
 D SELRN^ZVHBC(ZVHDATE,.ZVHUSARRAY,.ZVHERRUS)
 I $D(ZVHUSARRAY)'>9 I 'SILENT W " Can't file without nurses, skipping this date.",! SET ZVHERR=1 QUIT
 ;B ;ZW
 Q  ;
 ;
MEDARRAY(ZVHPT,ZVHDATE,ZVHMED,ZVHERRMED) ;
 N ZVHERRMED S ZVHERRMED=0 ; var for errors
 D ACTMED^ZVHBC(ZVHPT,ZVHDATE,.ZVHERRMED,SILENT) ;
 I ZVHERRMED D  Q 
 .  S (ZVHERR,ZVHERRIV)=1 
 .  S ZVHERR("IV","RN",ZVHDATE,ZVHPT)="" 
 .  I 'SILENT W "No MED defined",! 
 I $G(^TMP("PSJ",$J,1,0))=-1 D  Q
 .I 'SILENT W !!,?5,"No active meds for this date!",!
 ;Build new med array
  I 'SILENT W ?6,"Building Active IV Meds array...",! 
 F  S MED=$O(^TMP("PSJ",$J,MED)) Q:'MED  D  ; set up array of continuous, scheduled meds
 .I 'SILENT W "MEDS" ,MED,!
 .Q:$P(^TMP("PSJ",$J,MED,1),"^",2)'="C"  ; not continuous
 .W:'SILENT ?5,"1",($P(^TMP("PSJ",$J,MED,1),"^",2)'="C"),", "
 .Q:$P(^TMP("PSJ",$J,MED,0),"^",3)["U"  ; Unit dose order
 .W:'SILENT "2",($P(^TMP("PSJ",$J,MED,1),"^",3)["U"),", "
 .Q:$P(^TMP("PSJ",$J,MED,1),"^",3)="O"  ;One time order 
 .W:'SILENT "3",($P(^TMP("PSJ",$J,MED,1),"^",3)="O"),", " 
 .Q:$P(^TMP("PSJ",$J,MED,1),"^",1)="IVPB"   ; IVPB order
 .W:'SILENT "4",($P(^TMP("PSJ",$J,MED,1),"^",1)="IVPB"),", "
 .;
 .;check status, start and stop dates in OR
 .NEW ON ; Order number for ^OR(100
 .SET ON=$PIECE(^TMP("PSJ",$J,MED,0),"^",9)
 .IF ON[";" SET ON=$PIECE(ON,";") ; Strip the version numbers
 .;Q:$P(^TMP("PSJ",$J,MED,1),"^",7)'="A"  ; not active
 .;W:'SILENT "5",($P(^TMP("PSJ",$J,MED,1),"^",7)'="A"),", "
 .QUIT:$PIECE(^OR(100,ON,3),"^",3)'=6 ; quit if not an active order
 .W:'SILENT "5",$P(^ORD(100.01,($P(^OR(100,ON,3),"^",3)),0),"^"),", " 
 .;
 .;Q:$P(^TMP("PSJ",$J,MED,1),"^",4)'<(ZVHDATE_"."_2359)    ; future order start date
 .;W:'SILENT "6",$P(^TMP("PSJ",$J,MED,1),"^",4)'<(ZVHDATE_"."_2359),", "
 .QUIT:$PIECE(^OR(100,ON,0),"^",8)'<(ZVHDATE_"."_24) ; future order start date
 .WRITE:'SILENT "6",$P(^OR(100,ON,0),"^",8)'<(ZVHDATE_"."_24),", "
 .;
 .;Q:$P(^TMP("PSJ",$J,MED,1),"^",5)'>ZVHDATE  ; past order stop date
 .;W:'SILENT "7",$P(^TMP("PSJ",$J,MED,1),"^",5)'>ZVHDATE,!
 .QUIT:$PIECE(^OR(100,ON,0),"^",9)'>ZVHDATE ; stop date in the past
 .WRITE:'SILENT "7",$PIECE(^OR(100,ON,0),"^",9)'>ZVHDATE,!
 .S MEDARRAY(MED)=""
 I 'SILENT W " DONE!",!
 ;B ;CK MEDARRAY
 Q ;
 ;
LASTGVNIV(ZVHPT,ZVHON,SDATE,EDATE,ZVHIVED,ZVHNUM,ZVHERRLG) ; find last date/time given in a date range
 ; pass by value: PATIENT (IEN) and MED (number of med in the ^TMP("PSJ",$J) array)
 ; SDATE (start date) and EDATE (end date) in fileman date/time format
 ; pass by ref:  (will return date/time in this var in fileman format)
 ;B ;4get the Pharm IO 
 I SDATE'=+SDATE!(SDATE'>0) S ZVHERRLG=1 Q ;LASTGVN="ERROR^BAD START DATE" QUIT
 I EDATE'=+EDATE!(EDATE'>0) S ZVHERRLG=1 Q ;LASTGVN="ERROR^BAD END DATE" QUIT
 N ZVHNUM S (LASTGVN,ZVHNUM)="" ;
 S LASTGVN=$O(^PSB(53.79,"AORDX",ZVHPT,ZVHON,LASTGVN),-1) ; first given on or after start date
 I LASTGVN="" Q 
 ;B ;9
 S ZVHNUM=$O(^PSB(53.79,"AORDX",ZVHPT,ZVHON,LASTGVN,ZVHNUM)) ;$PIECE(^TMP("PSJ",$J,ZVHMED,3),U) 
 I 'ZVHNUM D  Q 
 .  S ZVHERRLG=1
 .  S (ZVHERR,ZVHERRIV)=1 
 .  S ZVHERR("IV","MED",LASTGVN)="" 
 .  I 'SILENT W "No ZVHNUM defined",! ;
 I 'SILENT W "LASTGVN - ",LASTGVN,!,"ZVHNUM - ",ZVHNUM,!,"START DT - ",SDATE,!
 ;B ;14
 N ZVHVOL S ZVHVOL=+$P(^PSB(53.79,ZVHNUM,.7,1,0),"^",2) ; define order volume
 N ZVHIVRT S ZVHIVRT=+$P(^PSB(53.79,ZVHNUM,0),"^",11)   ; get order infusion rate
 ;19 determine start time for next order
 I $P(^PSB(53.79,ZVHNUM,0),"^",9)="I" S $P(^PSB(53.79,ZVHNUM,0),"^",9)="C"  ;NUM=LAST ORDER NUMBER DOCUMENTED IN PSB GLOBAL ;
 I +ZVHIVRT>0 N ZVHHRBG S ZVHHRBG=$E((ZVHVOL/+ZVHIVRT),1,2) ; calculate the infusion duration in hrs ;IV INFUSION RATE if rate is ml/hr
 I +ZVHIVRT=0 S ZVHHRBG=$E(ZVHIVRT," ",3) ;extract hrs from set rate if "Infuse Over X hrs"
 I ZVHHRBG>24 S ZVHHRBG=24 ; If the iv runs > 1 days, start new bagVOL"ml"/RATE(ml/hr)= HRS
 I ZVHHRBG'>0 S ZVHHRBG=0  ;Needs to be 0 or >
 I ZVHHRBG D
 . S ZVHIVED=$$FMADD^XLFDT(LASTGVN,0,ZVHHRBG,$R(60),0) 
 I ZVHHRBG="" DO ;Need frequency to do skip
 . ;B ;26
 . N ZVHIVRT S ZVHIVRT=+$P(^TMP("PSJ",$J,ZVHMED,2),U,2)
 . N HVOL S ZVHVOL=$P(^TMP("PSJ",$J,ZVHMED,900,ZVHBRCD,1),U,3)
 . I +ZVHIVRT>0 N ZVHHRBG S ZVHHRBG=$E((ZVHVOL/+ZVHIVRT),1,2) ; calculate the infusion duration in hrs ;IV INFUSION RATE if rate is ml/hr
 . I +ZVHIVRT=0 S ZVHHRBG=$E(ZVHIVRT," ",3) ;extract hrs from set rate if "Infuse Over X hrs"
 . I ZVHHRBG'>0 S ZVHHRBG=0  ;Needs to be 0 or >+
 . I VHHRBG>24 S ZVHHRBG=24 ; If the iv runs > 3 days, start new bagVOL"ml"/RATE(ml/hr)= HRS
 . S ZVHIVED=$$FMADD^XLFDT(LASTGVN,0,ZVHHRBG,$R(60),0) 
 ;B ;CK LASTGVN, ZVHIVED, ZVHNUM
 Q  ; 
 ;
IV(ZVHPT,ZVHROOM,ZVHFILE,SILENT,END,ZVHERRIV) ; ZVHPT,ZVHROOM,$GET(ZVHFILE),SILENT,END,.ZVHERRIV) Starting point for IV orders
 I $G(SILENT)="" S SILENT=0
  ;B
 N MEDARRAY,MED,EDATE,XX S (MEDARRAY,MED)="" ;
 N ZVHMED,ZVHINF S (ZVHMED,ZVHINF)=""
 N ZVHDUZ,ZVHUSARRAY,ZVHERRUS,ZVHERRMED,ZVHERRBC S (ZVHDUZ,ZVHUSARRAY)="",(ZVHERRUS,ZVHERRMED,ZVHERRIV,ZVHERRBC,ZVHERRLG)=0
 N ZVHDATE,ZVHIVED S (ZVHDATE,ZVHIVED)=""	 ;identify if the order is active for a given date to be administered
 N ZVHBCUSED,ZVHDONE1,ZVHINC1,ZVHON,ZVHBRCD S (ZVHBRCD,ZVHDONE1,ZVHINC1,ZVHON)=""
 N ZVHNUM,LASTGVN,ZVHHRBG S (ZVHNUM,LASTGVN,ZVHHRBG)=""
 F  S ZVHDATE=$O(^TMP("ZVHDTARY",$J,ZVHDATE)) Q:'ZVHDATE  D
 . ;B ;1 DATE ARRAY
 . D MEDARRAY(ZVHPT,ZVHDATE,.ZVHMED,.ZVHERRMED)
 . I ZVHERRMED DO  Q 
 ..  S (ZVHERR,ZVHERRIV)=1 
 ..  S ZVHERR("IV","MED",ZVHDATE,ZVHPT)="" 
 ..  I 'SILENT W "No RN defined",! ;
 . ;B
 . I 'SILENT W ?2,"Date: ",$$FMTE^XLFDT(ZVHDATE,1),"  "
 . D RN(ZVHDATE,.ZVHUSARRAY,.ZVHERRUS)
 . I ZVHERRUS D  Q 
 ..  S (ZVHERR,ZVHERRIV)=1 
 ..  S ZVHERR("IV","RN",ZVHDATE)="" 
 ..  I 'SILENT W "No RN defined",! ;
NXMD . ;start loop thru the med array
 . F  S ZVHMED=$O(MEDARRAY(ZVHMED)) Q:'ZVHMED  D
 .. I 'SILENT W ?4,$P(^TMP("PSJ",$J,ZVHMED,3),U,2)," (IEN ",ZVHMED,")",! ; Medication
 .. I ($P(^TMP("PSJ",$J,ZVHMED,1),"^")'="IV")&'($D(^TMP("PSJ",$J,ZVHMED,950,0))) Q
 .. I ($P(^TMP("PSJ",$J,ZVHMED,1),"^")="IV")&($D(^TMP("PSJ",$J,ZVHMED,950,0))) S ZVHINF=1 ; 
BC	;CHECK IF BARCODE USED
 .. I (ZVHINF)&($P(^TMP("PSJ",$J,ZVHMED,0),U,3)["V") N ZVHBRCD S (ZVHBRCD)=""
 .. ;B 
 .. S ZVHON=$P(^TMP("PSJ",$J,ZVHMED,0),"^",3) ; pharm order number
 .. D GETBC^ZVHBC1(ZVHMED,.ZVHBRCD,SILENT) ; get a barcode for this IV
 .. I ZVHBRCD["ADDED MORE" S ZVHBRCD="" D  ; loop again to get one of the new barcodes
 ... D ACTMED^ZVHBC(ZVHPT,ZVHDATE,.ZVHERRMED) ; restore the ^TMP("PSJ",$J) global
 ... I ZVHERRMED D  Q  
 .... S (ZVHERR,ZVHERRIV)=1
 .... S ZVHERR("IV","GETBC","ADDED MORE","ACTMED",ZVHPT,ZVHMED,ZVHDATE)=""
 .... I 'SILENT W "Error!  Unable to get active meds.",!
 ... D GETBC^ZVHBC1(ZVHMED,.ZVHBRCD,SILENT) ; loop again to get one of the new barcodesDO GETBC(ZVHPT,ZVHMED,.ZVHBRCD,.ZVHON,.ZVHDONE1) ; setup the IV fields.
 ... I ZVHBRCD["ERROR" D  Q
 .... S (ZVHERR,ZVHERRIV)=1 
 .... S ZVHERR("IV","BARCODE",ZVHMED,ZVHPT)="" 
 .... I 'SILENT W "Barcode not defined",! ; 
 .. ;I '$GET(ZVHBRCD) SET ZVHERRIV=1 IF 'SILENT WRITE !!,"BARCODE ERROR skipping",!! QUIT
 .. ;BREAK  ;
 .. N SDATE,EDATE 
 .. S SDATE=(ZVHDATE),EDATE=ZVHDATE_"."_2359
 .. I EDATE>END S EDATE=END
 .. ;IF $E($PIECE(^TMP("PSJ",$J,ZVHMED,1),"^",4),-1,7)'=ZVHDATE DO
 .. ; check if order given on ZVHDATE
 .. D LASTGVNIV(ZVHPT,ZVHON,SDATE,EDATE,.ZVHIVED,.ZVHNUM,.ZVHERRLG)
 .. I ZVHERRLG D  Q  
 ... S (ZVHERR,ZVHERRIV)=1
 ... S ZVHERR("IV","LASTGVN",ZVHPT,ZVHMED,ZVHDATE)=""
 ... I 'SILENT W "Error!  Unable to get LASTGVN date.",!
 I (LASTGVN)>EDATE Q ;
 ;BREAK ;10
RRN ..; Choose administrating RN for dose
 ..S ZVHDUZ=$R($P(ZVHUSARRAY(0),"^",2))+1 ; select a random nurse from the active nurses array
 ..S ZVHDUZ=ZVHUSARRAY(ZVHDUZ) ; Get the DUZ of Nurse
IVS ..; DEFINE Set start time for new iv
 .. ;BREAK ;ADDED TO CHECK FOR MED ALREADY GIVEN.
 .. I ZVHIVED=""  D
 ... N ZVHRANDHR S ZVHRANDHR=$R(23)+1 I ZVHRANDHR'?2N ;Set randome start hour
 ... I $L(ZVHRANDHR)=1 S ZVHRANDHR="0"_ZVHRANDHR ; need 2 digits
 ... N ZVHRANDMI S ZVHRANDMI=$R(60)+1  ;Set random start minutes
 ... I $L(ZVHRANDMI)=1 S ZVHRANDMI="0"_ZVHRANDMI ; need 2 digits
 ... S ZVHIVED=ZVHDATE_"."_ZVHRANDHR_ZVHRANDMI  ; random start date.time (ZVHIVED = START DATE/TIME)
 .. I ZVHIVED>$$NOW^XLFDT Q ;
 .. ; set infusion rate of new bag and define next stop dt/tm.
 .. N ZVHVOLN SET ZVHVOLN=+$P(^TMP("PSJ",$J,ZVHMED,950,1,0),U,3) ;ZVHVOLN VOLUME OF NEW ORDER define order volume
 .. N ZVHIVRTN SET ZVHIVRTN=+$P(^TMP("PSJ",$J,ZVHMED,2),U,2)    ; ZVHIVRTN INFUSION RT OF NEW ORDER get order infusion rate
 .. I +ZVHIVRTN>0 N ZVHHRBG S ZVHHRBG=$E((ZVHVOLN/+ZVHIVRTN),1,2) ; calculate the infusion duration in hrs ;IV INFUSION RATE if rate is ml/hr
 .. I +ZVHIVRTN=0 N ZVHHRBG S ZVHHRBG=$E(ZVHIVRT," ",3) ;extract hrs from set rate if "Infuse Over X hrs"
 .. I ZVHHRBG>24 N ZVHHRBG S ZVHHRBG=24 ; If the iv runs > 1 days, start new bagVOL"ml"/RATE(ml/hr)= HRS
 .. I ZVHHRBG'>0 N ZVHHRBG S ZVHHRBG=0  ;Needs to be 0 or >
 .. N ZVHIVSD S ZVHIVSD=$$FMADD^XLFDT(ZVHIVED,0,ZVHHRBG,$R(60),0) 
 .. I ZVHIVED>$$NOW^XLFDT Q ;
 .. W:'SILENT "Order end d/t: ",ZVHIVED,!,"NOW: ",$$NOW^XLFDT,!
 ..;B;19 determine start time for next order
SETFDA ..;
 .. N ZVHFDA ;
 .. ;B ; STEP TO CHECK INFUSING STATUS
 .. I ZVHIVSD>$$NOW^XLFDT S ZVHFDA(53.79,"+1,",.09)="I" ;set cross reference
 .. I ZVHIVSD'>$$NOW^XLFDT S ZVHFDA(53.79,"+1,",.09)="C"       ;COMPLETION TIME INFUSION LENGTH,
 .. ZW:'SILENT ZVHFDA(53.79,"+1,",.09)
 .. W:'SILENT "Order stop dt/tm: ",ZVHIVSD,!,"now: ",$$NOW^XLFDT,!
 .. W:'SILENT ?4,$P(^TMP("PSJ",$J,ZVHMED,3),U,2)
 ..;B ;  ACTION STATUS
 .. S ZVHFDA(53.79,"+1,",.06)=ZVHIVED   ; SET NEW ORDER FILL/START DATE/TIME
 .. S ZVHFDA(53.79,"+1,",.16)="IV"   ;          INJECTION SITE "IV"
 .. S ZVHFDA(53.79,"+1,",.26)=ZVHBRCD   ;         IV UNIQUE ID barcod
 .. S ZVHFDA(53.79,"+1,",.35)=$P(^TMP("PSJ",$J,ZVHMED,2),"^",2)  ;Set infusion rate
 ..;  Define additive if present
 .. I $D(^TMP("PSJ",$J,ZVHMED,850,1,0))'=0  DO   ;SET ADD=$PIECE(^TMP("PSJ",$J,ZVHMED,800,ZVHBRCD,1),U,2)
 ... S ZVHFDA(53.796,"+3,+1,",.01)=+$P(^TMP("PSJ",$J,ZVHMED,850,1,0),"^") ; additives - ien IV additives file
 ... S ZVHFDA(53.796,"+3,+1,",.02)=$P(^TMP("PSJ",$J,ZVHMED,850,1,0),"^",2) ; additive name stored in dose ordered
 ... S ZVHFDA(53.796,"+3,+1,",.03)=$P(^TMP("PSJ",$J,ZVHMED,850,1,0),"^",3) ; dose given (= dose ordered)
 .. ;  Define solution,
 .. S ZVHFDA(53.797,"+4,+1,",.01)=+$P(^TMP("PSJ",$J,ZVHMED,950,1,0),"^") ; solutions - ien IV solutions file
 .. S ZVHFDA(53.797,"+4,+1,",.02)=$P(^TMP("PSJ",$J,ZVHMED,950,1,0),"^",2) ; solution name store in dose ordered
 .. S ZVHFDA(53.797,"+4,+1,",.03)=$P(^TMP("PSJ",$J,ZVHMED,950,1,0),"^",3) ; dose given (= dose ordered)
 .. ; add order details
 .. S ZVHFDA(53.79,"+1,",.01)=ZVHPT ; patient IEN
 .. S ZVHFDA(53.79,"+1,",.02)=ZVHROOM ; room-bed from file 2
 .. S ZVHFDA(53.79,"+1,",.03)=DUZ(2) ; division ien of the user
 .. S ZVHFDA(53.79,"+1,",.04)=ZVHIVED ; date/time entered
 .. S ZVHFDA(53.79,"+1,",.05)=ZVHDUZ ; ien of nurse (entered)
 .. S ZVHFDA(53.79,"+1,",.06)=ZVHIVED ; date/time given
 .. S ZVHFDA(53.79,"+1,",.07)=ZVHDUZ ; ien of nurse (action)
 .. S ZVHFDA(53.79,"+1,",.08)=$P(^TMP("PSJ",$J,ZVHMED,3),"^") ; pharm orderable item
 .. S ZVHFDA(53.79,"+1,",.11)=$P(^TMP("PSJ",$J,ZVHMED,0),"^",3) ; med order in file 55 (ex 10U or 10V)
 .. S ZVHFDA(53.79,"+1,",.12)="C" ; Cont scheduled meds only, not PRN, one time, or on call ("C" for continuous)
 .. I $DATA(ZVHFDA(53.797))'>9 SET ZVHERRIV=1 QUIT  ; check if successful
 .. I 'SILENT WRITE ?4,ZVHBRCD,! 
 .. ;B  ; LN 36 CK ZW DEBUG
 .. N NUM,ERROR ;AJC/TH new ERROR also .  
 .. D UPDATE^ZVHBC2(ZVHFILE,.NUM,ZVHMED,.ERROR,SILENT) ;ZVHFILE,NUM,ZVHMED,ERROR,SILENT send the data array to fileman
 .. ;return by ref: NUM (ien for 53.79), ERROR (debug)
 .. IF $GET(ERROR) SET ZVHERR=1,ZVHERR("IV","UPDATE",ZVHPT,ZVHDUZ)="" W:'SILENT "ERROR: Not saved!" QUIT ;
 .. IF $GET(NUM) DO 
 ... W:'SILENT "NUM: ",NUM,!
 ... W:'SILENT ?2,$P(^PSB(53.79,NUM,0),U,9),!,$P(^PSB(53.79,NUM,0),U,10) ; IF "I" Order needs to show as infusing in CPRS and HMP. pass by value: ZVHFDA (Fileman Data Array) and ZVHFILE (save?)
 ... I $P(^PSB(53.79,NUM,0),U,9)="I",$P(^PSB(53.79,NUM,0),U,10)]"" S ^PSB(53.79,"AINFUSING",ZVHPT,ZVHIVED,NUM)=""
 ... D:ZVHFILE AUDIT^ZVHBC2(NUM,53.79,.09,"I","S",ZVHIVED,ZVHDUZ)
 ... I $D(^PSB(53.79,"AINFUSING",ZVHPT,ZVHIVED,NUM)) ZW:'SILENT ^PSB(53.79,"AINFUSING",ZVHPT,ZVHIVED,NUM)
 .. ;B ;
 .. I ZVHIVSD'>EDATE D BC ; Enter additional bags for the current ZVHDTARRAY 
 .. S (EDATE,XX,ZVHHRBG,ZVHNUM,ZVHON,ZVHIVED,LASTGVN)="" ; 
 ;B
 D AINFUSING^ZVHFIX(SILENT,ZVHFILE)
 ;B
 QUIT
 ;
 ;BC	;CHECK IF BARCODE USED
 I (ZVHINF)&($P(^TMP("PSJ",$J,ZVHMED,0),U,3)["V") N ZVHBRCD S (ZVHBRCD)=""
 ;B 
 S ZVHON=$P(^TMP("PSJ",$J,ZVHMED,0),"^",3) ; pharm order number
 D GETBC^ZVHBC1(ZVHMED,.ZVHBRCD,SILENT) ; get a barcode for this IV
 I ZVHBRCD["ADDED MORE" S ZVHBRCD="" D  ; loop again to get one of the new barcodes
 . D ACTMED^ZVHBC(ZVHPT,ZVHDATE,.ZVHERRMED) ; restore the ^TMP("PSJ",$J) global
 . I ZVHERRMED D  Q  
 .. S (ZVHERR,ZVHERRIV)=1
 .. S ZVHERR("IV","GETBC","ADDED MORE","ACTMED",ZVHPT,ZVHMED,ZVHDATE)=""
 .. I 'SILENT W "Error!  Unable to get active meds.",!
 . D GETBC^ZVHBC1(ZVHMED,.ZVHBRCD,SILENT) ; loop again to get one of the new barcodesDO GETBC(ZVHPT,ZVHMED,.ZVHBRCD,.ZVHON,.ZVHDONE1) ; setup the IV fields.
 . I ZVHBRCD["ERROR" D  Q
 .. S (ZVHERR,ZVHERRIV)=1 
 .. S ZVHERR("IV","BARCODE",ZVHMED,ZVHPT)="" 
 .. I 'SILENT W "Barcode not defined",! ; 
  ;I '$GET(ZVHBRCD) SET ZVHERRIV=1 IF 'SILENT WRITE !!,"BARCODE ERROR skipping",!! QUIT
 ;BREAK  ;
 N SDATE,EDATE 
 S SDATE=(ZVHDATE),EDATE=ZVHDATE_"."_2359
 I EDATE>END S EDATE=END
 ;IF $E($PIECE(^TMP("PSJ",$J,ZVHMED,1),"^",4),-1,7)'=ZVHDATE DO
 ; check if order given on ZVHDATE
 D LASTGVNIV(ZVHPT,ZVHON,SDATE,EDATE,.ZVHIVED,.ZVHNUM,.ZVHERRLG)
 I ZVHERRLG D  Q  
 .. S (ZVHERR,ZVHERRIV)=1
 .. S ZVHERR("IV","LASTGVN",ZVHPT,ZVHMED,ZVHDATE)=""
 .. I 'SILENT W "Error!  Unable to get LASTGVN date.",!
 I (LASTGVN)>EDATE Q ;
 ;BREAK ;10
 QUIT
 ;
 ;
IVCONT(PATIENT,ROOMBED,ZVHFILE,SILENT,SDATE,EDATE,ERROR)	; give Infusions
 ;[2014aug20 AJC] Rebuild to try to fix the stack overflow errors from 
 ;   infinite looping
 ; pass by value: PATIENT, ROOMBED, SDATE (Start date/time) EDATE 
 ;   (end date/time) ZVHFILE (0 to view, 1 to save) SILENT (1 for minimal output)
 ; pass by ref: ERROR
 ;
 ; REQUIRED:PATIENT and ROOMBED, start/end dates passed or in date array
 QUIT:$GET(PATIENT)=""!($GET(ROOMBED)="")
 IF $GET(SDATE)="" DO  ; if no start date is passed, use 00:00 of the FIRST date in the array
 . IF $DATA(^TMP("ZVHDTARY",$J))>9 DO  ; check if there is data there
 . . SET SDATE=$ORDER(^TMP("ZVHDTARY",$J,"")) ; get the FIRST date in the array
 . ELSE  SET ERROR="1^No start date"
 ;
 IF $GET(EDATE)="" DO  ; if no end date is passed, use 24:00 of the LAST date in the array
 . IF $DATA(^TMP("ZVHDTARY",$J))>9 DO  ; check if there is data there
 . . NEW DATE SET DATE=$ORDER(^TMP("ZVHDTARY",$J,""),-1) ; get the LAST date in the array
 . . SET EDATE=+(DATE_.24) ; 1 second BEFORE midnight
 . ELSE  SET ERROR="2^No End date"
 IF $GET(ERROR) DO
 . SET ZVHERR("IVCONT",$J)=$G(PATIENT)_U_$G(ROOMBED)_U_$G(SILENT)_U_$G(SDATE)_U_$G(EDATE)_U_ERROR
 . SET (ZVERR,ERROR)=1
 . WRITE:'SILENT "ERROR: Missing Start or End date.",!!
 ;
 ;check end date/time for missing time
 IF EDATE?7N&(EDATE'[".") SET EDATE=+(EDATE_.24) ; midnight
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to NOT silent
 ;
 IF 'SILENT WRITE ?1,"Infusions:",!
 ;
 ;use end date to get array of active infusion orders
 NEW MEDARRAY,ERRORMED SET ERRORMED=0
 DO IVARRAY(PATIENT,EDATE,SILENT,.ERRORMED)
 IF ERRORMED!($GET(^TMP("PSJ",$J,1,0))=-1) DO  QUIT  
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("IVCONT","MEDARRAY",$J,PATIENT)=$GET(EDATE)_U_$GET(SILENT)
 . WRITE:'SILENT "ERROR: Unable to set up meds array",!!
 ;
 ;B ;debug
 ;loop thru the MEDARRAY
 NEW MED SET MED=""
 FOR  SET MED=$ORDER(MEDARRAY(MED)) QUIT:MED=""  DO
 . IF 'SILENT WRITE ?3,$E($P(^TMP("PSJ",$J,MED,3),"^",2),1,20),?25,"(IEN ",MED,")" ; Medication
 . ; get the hours per bag for this med
 . NEW HOURS,INFUSIONS,PSJON SET HOURS=$$HRBAG(MED) 
 . IF HOURS=-1 DO  QUIT
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("IVCONT","HRBAG",$J,PATIENT)=$GET(MED)_U_$GET(SILENT)_U_$GET(HOURS)
 . . WRITE:'SILENT "ERROR: Unable to compute hours per bag",!!
 . ; use days in range and hours/bag to determine the maximum potential admins
 . NEW MAX SET MAX=$$MAX(SDATE,EDATE,HOURS) 
 . IF MAX=-1 DO  QUIT
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("IVCONT","MAX",$J,PATIENT)=$GET(MED)_U_$GET(SILENT)_U_$GET(HOURS)_U_$GET(SDATE)_U_$GET(EDATE)_U_$GET(MAX)
 . . WRITE:'SILENT "ERROR: Unable to compute Maximum admins for Date Range",!!
 . ; check what is infusing
 . SET INFUSIONS="Infusions for"_U_^TMP("PSJ",$J,MED,0) ; this array will have all administrations for the date range
 . SET PSJON=$PIECE(^TMP("PSJ",$J,MED,0),"^",3) ; PSJ order number
 . DO CHKINF(PATIENT,PSJON,SDATE,EDATE,SILENT)
 . IF $GET(INFUSIONS(0))=-1 DO  QUIT
 . . WRITE:'SILENT !,"ERROR: Unable to determine if existing infusions are running.",!!
 . . SET (ERROR,ZVHERR)=1
 . . SET ZVHERR("IVCONT","CHKINF",$J,MED)=$G(PATIENT)_U_$G(ROOMBED)_U_$G(ZVHFILE)_U_$G(SILENT)_U_$G(SDATE)_U_$G(EDATE)_U_$G(ERROR)
 . ELSE  DO
 . . IF $DATA(INFUSIONS)<10 DO  ; simple - no infusions running or in the date range
 . . . ;get the order start date vs sdate
 . . . NEW ON,ORSTART,IVSTART,IVSTOP,DONE
 . . . ;do set fda ^ zvhbc2
 . . . SET ON=$PIECE(^TMP("PSJ",$J,MED,0),"^",9) ; order # for ^OR(100,
 . . . SET ORSTART=$PIECE(^OR(100,ON,0),"^",8) ; order start date
 . . . SET IVSTOP=$SELECT(ORSTART>SDATE:$$FMADD^XLFDT(ORSTART,0,1,$R(59),0),1:$$FMADD^XLFDT(SDATE,0,1,$R(59),0)) ; this will be the first admin time
 . . . ;
 . . . ; start a for loop through date/times.  quit if the date/time is > EDATE
 . . . ; each loop set the end to be the next start (set IVSTART=IVSTOP+$random)
 . . . NEW COUNT,DONE SET (COUNT,DONE)=0 ; monitor count to prevent over looping
 . . . ;
 . . . FOR  SET IVSTART=$$FMADD^XLFDT(IVSTOP,0,$R(5),0) QUIT:'IVSTART!(IVSTART'<EDATE)!DONE!(COUNT>MAX)  DO
 . . . . SET IVSTOP=$$FMADD^XLFDT(IVSTART,HOURS,$R(5),0) ;  IVSTART + HOURS to get new IVSTOP 
 . . . . ;DO IVSTART(...,IVSTART,IVSTOP,HOURS,...)
 . . . . SET COUNT=COUNT+1
 . . . . IF COUNT>MAX SET DONE=1
 . . . . B ;debug
 . . ELSE  DO  ; complete the existing infusions
 . . . NEW PSBIEN SET PSBIEN=""
 . . . FOR  SET PSBIEN=$ORDER(INFUSIONS(PSBIEN)) QUIT:'PSBIEN  DO
 . . . . NEW ERRORCOMP,SUCCESS SET ERRORCOMP=0
 . . . . ; complete the IV
 . . . . SET SUCCESS=$$IVCOMP(PSBIEN,"","",$GET(SILENT),$GET(ZVHFILE),.ERRORCOMP)
 . . . . IF ERRORCOMP!(SUCCESS=-1) DO  QUIT
 . . . . . SET (ERROR,ZVHERR)=1
 . . . . . SET ZVHERR("IVCOMP",$J,PSBIEN)=$G(MED)_U_$G(SILENT)_U_$G(ZVHFILE)_U_$$NOW^XLFDT
 . . . . . WRITE:'SILENT "ERROR: Unable to complete previous IV ",PSBIEN,!
 . . . . IF SUCCESS=1 DO
 . . . . . WRITE:'SILENT ?10,"Infusion #",PSBIEN," completed.",! ;
 . . . . . SET INFUSIONS(PSBIEN,"STOP")=($PIECE($GET(^PSB(53.79,PSBIEN,0)),U,6))
 . . . . ;determine the type of overlap for each one
 . . . . . NEW ERROROL SET ERROROL=0
 . . . . . SET INFUSIONS(PSBIEN,"OVERLAP")=$$OVERLAP($GET(INFUSIONS(PSBIEN,"START")),$GET(INFUSIONS(PSBIEN,"STOP")),$GET(SDATE),$GET(EDATE),.ERROROL)
 . . . . . IF ERROROL!(OVERLAP=-1) DO  QUIT
 . . . . . SET (ERROR,ZVHERR)=1
 . . . . . SET ZVHERR("IVCONT","OVERLAP",$J,PSBIEN)=$G(INFUSIONS(PSBIEN,"START"))_U_$G(INFUSIONS(PSBIEN,"STOP"))_U_$G(SDATE)_U_$G(EDATE)
 . . . . . WRITE:'SILENT "ERROR: Unable to determine overlap.",!
 . . . ;
 . ;compute hours per bag
 . ;use start date/time and end date/time in a for loop
 . ; check last given
 . ; use last given if in range, else use order start date/time if in range, else use SDATE +$R
 . ;  select a given date/time
 . ;   if > end date/time
 . ;    set status="i"
 . ;    set x-ref
 . ;   else
 . ;    set status="c"
 . ;    set audit for status="i" for starting time
 . ;    check for AINFUSING x-ref and delete if there
 . ;  use date of given date/time to do SELRN^ZVHBC
 . ;  set FDA for items unique to IV (hope to use ivone^zvhbc1?)
 . ;  do setfda^zvhbc2
 . ;  do update^zvhbc2
 . ;   use ien to trigger freshness
 . ;   use ien to trigger audit^zvhbc2 (?)
 . ;   use given date/time as next last given (quit loop)
 ;
 ;
 B ;debug
 ;
 QUIT  ; label IVCONT
 ;
 ;
MAX(START,END,HOURS)	; determine the maximum potential administrations
 ;req: pass by value start date/time, end date/time, hours per bag
 ;  date/time must be fileman format
 ; errors will return a -1
 IF 'START!'END!'HOURS QUIT -1
 ;check dates
 IF ($GET(START)="")!($GET(END)="") QUIT -1
 IF ((START'?7N)&(START'?7N1"."1.6N))!((END'?7N)&(END'?7N1"."1.6N)) QUIT -1
 ;check hours
 IF ($GET(HOURS)="")!($GET(HOURS)'?.N) QUIT -1
 ;
 ; need to deal with precise date/times
 IF START>END NEW TEMP SET TEMP=START,START=END,END=TEMP ; makes sure start<end
 IF (START?7N1"."1.6N) SET START=$PIECE(START,".") ; drop the time
 IF (END?7N1"."1.6N) SET END=$PIECE(END,".")+1 ; drop the time and add a day
 ;
 NEW X,X1,X2,%Y ; fileman variables for date lookup
 SET X2=START,X1=END
 DO ^%DTC ; fileman compare dates
 IF %Y'=1!'$DATA(X) QUIT -1 ; unable to get difference
 IF X<0 SET X=-X
 IF X?.N QUIT (24/HOURS)*X ; # of admins per day * days in range
 IF X=0
 ELSE  QUIT -1
 ;
 QUIT  ; label MAX
 ;
 ;
HRBAG(MED)	; compute hours per bag from ^tmp("psj",med 
 ; required: pass by value MED 
 QUIT:$GET(MED)="" -1
 QUIT:'$DATA(^TMP("PSJ",$J)) -1
 QUIT:'$DATA(^TMP("PSJ",$J,MED)) -1
 QUIT:$DATA(^TMP("PSJ",$J,MED,950)) -1
 ;
 NEW VOLUME,RATE,HOURS
 SET VOLUME=+$PIECE($GET(^TMP("PSJ",$J,MED,950,1,0)),U,3) ; get solution volume
 SET RATE=$PIECE($GET(^TMP("PSJ",$J,MED,2)),U,2)   ; get infusion rate
 ; compute hours based on volume and rate
 IF (VOLUME=+VOLUME)&(+RATE>0) SET HOURS=+(VOLUME\(+RATE))
 ;
 ;extract hrs from set rate if "Infuse Over X hrs"
 IF (HOURS'>0) DO  
 . SET RATE=$$UP^XLFSTR(RATE) ; convert the text to upper case
 . IF RATE["INFUSE OVER" DO   
 . . SET TIME=$EXTRACT(RATE," ",4)
 . . IF TIME["HOUR"!(TIME["HR") SET HOURS=$EXTRACT(RATE," ",3)
 . . IF TIME["MIN" SET HOURS=(+$EXTRACT(RATE," ",3)\60) ; convert from minutes
 ;
 IF +HOURS'>0 QUIT -1 ; return -1 if unable to compute hours
 ;
 ;keep hours per bag between 4 and 24
 IF +HOURS<4 SET HOURS=4
 IF +HOURS>24 SET HOURS=24
 ;
 QUIT HOURS ; label HRBAG
 ;
 ;
HRBAG1(PSBIEN)	; compute hours per bag for a running IV use ^psb(53.79,psbien 
 ; required: pass by valuePSBIEN
 ; errors returned as -1
 QUIT:$GET(PSBIEN)="" -1
 QUIT:'$DATA(^PSB(53.79,PSBIEN)) -1
 QUIT:'$DATA(^PSB(53.79,PSBIEN,.7)) -1
 ;
 NEW VOLUME,RATE,HOURS
 SET VOLUME=+$PIECE($GET(^PSB(53.79,PSBIEN,.7,1,0)),"^",3) ; get solution volume
 SET RATE=$PIECE($GET(^PSB(53.79,PSBIEN,0)),"^",11)   ; get infusion rate
 ; compute hours based on volume and rate
 IF (VOLUME=+VOLUME)&(+RATE>0) SET HOURS=+(VOLUME\(+RATE))
 ;
 ;extract hrs from set rate if "Infuse Over X hrs"
 IF (HOURS'>0) DO  
 . SET RATE=$$UP^XLFSTR(RATE) ; convert the text to upper case
 . IF RATE["INFUSE OVER" DO   
 . . SET TIME=$EXTRACT(RATE," ",4)
 . . IF TIME["HOUR"!(TIME["HR") SET HOURS=$EXTRACT(RATE," ",3)
 . . IF TIME["MIN" SET HOURS=(+$EXTRACT(RATE," ",3)\60) ; convert from minutes
 ;
 IF +HOURS'>0 QUIT -1 ; return -1 if unable to compute hours
 ;
 ;keep hours per bag between 4 and 24
 IF +HOURS<4 SET HOURS=4
 IF +HOURS>24 SET HOURS=24
 ;
 QUIT HOURS ; label HRBAG1
 ;
 ;
INFUSING(PATIENT,ZVHFILE,SILENT,SDATE,EDATE,MED,ERROR,STDTTM,HRPERBAG)	; if the IV is currently infusing
 ;req..
 ;if it's infusing, will complete it and return the next start date/time (STDTTM) and hours per bag (HRPERBAG)
 ;
 ; return the RN for the next bag
 ;
 ;complete the old bag
 ; get the PSBIEN
 ; get hours per bag
 ; if hours per bag > 24 set it to 24
 ; add to start date/time
 ; get a nurse duz
 ;
 ;start the new bag
 ; if old bag stop date/time in range
 ;  set new bag start date/time = old bag start date time + 3 min
 ;
 QUIT  ; label INFUSING
 ;
 ;
IVCOMP(PSBIEN,STOPDATE,RNDUZ,SILENT,ZVHFILE,ERROR)	; complete an IV
 ; REQUIRED: PSBIEN (the IEN from 53.79) 
 ; optional: stop date/time
 ;    WARNING: if time is not included, the stop date will be at 00:00
 ;    if stop date/time is not included, it will be computed based on start date/time, volume and rate
 ; optional: RNDUZ - the DUZ of the RN stopping the infusion 
 ;    if null, then RNDUZ will be returned if passed by ref
 QUIT:'PSBIEN!(PSBIEN'=+PSBIEN)
 IF $GET(SILENT)="" SET SILENT=0
 ;
 IF '$GET(STOPDATE) NEW HOURS,STARTDATE DO
 . SET HOURS=$$HRBAG1(PSBIEN) ; get the hours per bag
 . IF HOURS=-1 DO  QUIT
 . . WRITE:'SILENT "ERROR: unable to get hours for existing infusion.",!!
 . . SET (ERROR,ZVHERR)=1
 . . SET STOPDATE=-1
 . . SET ZVHERR("IVCOMP","HRBAG1",$J,PSBIEN)=$GET(STOPDATE)_U_$GET(SILENT)
 . ; get the start date/time
 . SET STARTDATE=$P(^PSB(53.79,PSBIEN,0),"^",6)
 . IF +HOURS>0&$DATA(STARTDATE) SET STOPDATE=$$FMADD^XLFDT(STARTDATE,0,(HOURS-1),$R(59),0)
 . ELSE  DO  QUIT
 . . WRITE:'SILENT "ERROR: unable to get start date/time or hours for existing infusion.",!!
 . . SET (ERROR,ZVHERR)=1
 . . SET STOPDATE=-1
 . . SET ZVHERR("IVCOMP","HRBAG1",$J,PSBIEN)=$GET(STOPDATE)_U_$GET(SILENT)
 ;
 QUIT:'+STOPDATE>0 -1
 ;
 QUIT:STOPDATE>($$NOW^XLFDT) -1 ; only complete in the past
 ;
 NEW ERRORRN SET ERRORRN=0
 IF '$GET(RNDUZ) DO GETRN(STOPDATE,.RNDUZ,SILENT,.ERRORRN)
 IF ERRORRN DO  QUIT  
 . WRITE:'SILENT "ERROR: Unable to get a nurse." 
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("IVCOMP","GETRN",$J,PSBIEN)=$G(STOPDATE)_U_$G(RNDUZ)_U_$G(SILENT)
 ;
 ; set the fda
 NEW ZVHFDA,ERRORFDA,PATIENT,OLDDATE,OLDSTATUS SET ERRORFDA=0
 SET ZVHFDA("53.79",PSBIEN_",",.09)="C" ; status = complete
 SET ZVHFDA("53.79",PSBIEN_",",.04)=STOPDATE ; action date/time
 SET ZVHFDA("53.79",PSBIEN_",",.06)=STOPDATE ; entry date/time
 SET ZVHFDA("53.79",PSBIEN_",",.05)=RNDUZ ; nurse
 SET PATIENT=$PIECE(^PSB(53.79,PSBIEN,0),"^") ; will be used to check the x-ref
 SET OLDDATE=$PIECE(^PSB(53.79,PSBIEN,0),"^",6) ; get the old Action date/time for audit
 SET OLDSTATUS=$PIECE(^PSB(53.79,PSBIEN,0),"^",9) ; get the old Status for audit
 DO EDITPSB($GET(ZVHFILE),.ERRORFDA,SILENT) ; update with stop date/time, status, and audit
 ;
 ; check the AINFUSING x-ref
 IF $DATA(^PSB(53.79,"AINFUSING",PATIENT)) DO
 NEW INFDATE SET INFDATE="" ; action date/time from ainfusinf x-ref
 FOR  SET INFDATE=$ORDER(^PSB(53.79,"AINFUSING",PATIENT,INFDATE)) QUIT:'INFDATE  DO  
 . ;loop thru the psbien's for this date/time
 . NEW IEN SET IEN=""
 . FOR  SET IEN=$ORDER(^PSB(53.79,"AINFUSING",PATIENT,INFDATE,IEN)) QUIT:'IEN  DO
 . . IF PSBIEN=IEN DO
 . . . IF 'SILENT WRITE "Removing this X-Ref:",! ZWRITE ^PSB(53.79,"AINFUSING",PATIENT,INFDATE,IEN)
 . . . IF $GET(ZVHFILE)=1 KILL ^PSB(53.79,"AINFUSING",PATIENT,INFDATE,IEN)
 . . . ELSE  W:'SILENT !,?10,"Did not remove it since we are not saving.",!
 ;
 ; audit the changes 
 ;  action date/time deleted:
 IF $DATA(OLDDATE) DO AUDIT^ZVHBC2(PSBIEN,53.79,.06,OLDDATE,"K",STOPDATE,RNDUZ) ; set the audit for action date/time
 ;  action date/time set:
 DO AUDIT^ZVHBC2(PSBIEN,53.79,.06,STOPDATE,"S",STOPDATE,RNDUZ) ; set the audit for action date/time
 ;  status deleted:
 IF $DATA(OLDSTATUS) DO AUDIT^ZVHBC2(PSBIEN,53.79,.09,OLDSTATUS,"K",STOPDATE,RNDUZ) ; set the audit for action date/time
 ;  status set:
 DO AUDIT^ZVHBC2(PSBIEN,53.79,.09,"C","S",STOPDATE,RNDUZ) ; set the audit for the status=complete
 ; 
 IF $GET(ERRORFDA)!$GET(ZVHERR)!($GET(ZVHFILE)=0)!($GET(ZVHFILE)="") QUIT -1 ; return a -1 if unable to complete
 ELSE  QUIT 1 ; label IVCOMP 1=successful
 ;
 QUIT  ; label IVCOMP
 ;
 ;
IVSTRT(STARTDATE,RNDUZ,MED,IEN,SILENT,ZVHFILE,ERROR) ; start the infusion
 ; REQUIRED: Pass by value MED is from ^TMP("PSJ",$J,MED
 ;   pass by ref: ERROR will return 1 if errors
 ; optional: pass by value RNDUZ (nurse duz) if null and passed by ref, will 
 ;   return the selected duz; STARTDATE in fileman date/time
 ;   pass by ref: IEN will return the new IEN if successfully saved
 ;     SILENT (1 if true) ZVHFILE (1 if save)
 ; 
 ; if successful, return the PSBIEN in IEN
 ;
 ;acceptable format for STARTDATE:
 ;  7 numbers, 1 period, and numbers
 ;  7 numbers
 QUIT:'$GET(MED)
 QUIT:'$DATA(^TMP("PSJ",$J,MED))
 IF $GET(STARTDATE)="" SET STARTDATE=$$NOW^XLFDT
 IF (STARTDATE?7N1".".N)&(STARTDATE?7N) SET STARTDATE=$$NOW^XLFDT ; 
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 IF $GET(ZVHFILE)="" SET ZVHFILE=0 ; default to no save
 ;
 ;select a nurse if not passed
 NEW ERRORRN SET ERRORRN=0
 IF 'RNDUZ DO GETRN(STARTDATE,.RNDUZ,SILENT,.ERRORRN)
 IF ERRORRN DO  QUIT  
 . W:'SILENT "ERROR: Unable to get a nurse." 
 . SET (ERROR,ZVHERR)=1,IEN=-1
 . SET ZVHERR("IVCOMP","GETRN",$J,PSBIEN)=$G(STOPDATE)_U_$G(RNDUZ)_U_$G(SILENT)
 ;
 W:'SILENT MED,"  ",$P(^TMP("PSJ",$J,MED,3),"^",2),!
 W:'SILENT $P(^VA(200,RNDUZ,0),"^"),"  ",STARTDATE
 ; setfda^zvhbc2
 ;DO SETFDA(ZVHPT,ZVHROOM,ZVHGVNDTTM,ZVHDUZ,ZVHFDA,ZVHMED,ERROR,SILENT)
 ; ivone^zvhbc1
 ; update^zvhbc2 ; update with start date/time, status, and audit
 ;
 ; check and set the AINFUSING x-ref
 ;
 ; audit:
 ;^PSB(53.79,9214,.9,1,0)="3140918.132939^1108^Field: ACTION DATE/TIME Set to 'SEP 18, 2014@13:29:39'."
 ;^PSB(53.79,9214,.9,2,0)="3140918.132939^1108^Field: ACTION STATUS Set to 'INFUSING' by 'AJC'.^INFUSING^1108"
 ;^PSB(53.79,9214,.9,3,0)="3140918.132939^1108^Field: INJECTION SITE Set to 'IV/LOCK'."
 ;^PSB(53.79,9214,.9,4,0)="3140918.132939^1108^Field: DOSE GIVEN Set to '20 MEQ'."
 ;^PSB(53.79,9214,.9,5,0)="3140918.132939^1108^Field: DOSES GIVEN Set to '500 ML'.
 ;
 QUIT  ; label IVSTRT
 ;
 ;
GETRN(DATE,RNDUZ,SILENT,ERROR)	; return a random nurse that is active on a specific date
 ;REQUIRED: pass by value DATE, pass by reference: RNDUZ
 ; duz for the nurse is returned in RNDUZ
 ;
 IF $GET(SILENT)="" SET SILENT=0 ; default to not silent
 IF '$D(DATE) SET ERROR=1 W:'SILENT "ERROR: Date is required!",!! QUIT
 NEW ZVHUSARRAY,ERRORUSER SET DATE=$EXTRACT(DATE,1,7) ; get the date from the date/time
 SET ERRORUSER=0
 DO SELRN^ZVHBC(DATE,.ZVHUSARRAY,.ERRORUSER,SILENT)
 IF ERRORUSER DO  QUIT
 . IF 'SILENT WRITE "ERROR: Unable to get nurses... quitting",!!!
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("GETRN",$J)=$G(DATE)_U_$G(RNDUZ)
 . IF $DATA(ZVHUSARRAY)>9 MERGE ZVHERR("GETRN",$J,"USER ARRAY")=ZVHUSARRAY
 . SET RNDUZ=-1
 ELSE  DO  
 . SET RNDUZ=$RANDOM($PIECE(ZVHUSARRAY(0),"^",2))+1 ; select a random nurse from the active nurses array
 . SET RNDUZ=ZVHUSARRAY(RNDUZ)
 ;
 QUIT  ; label GETRN
 ;
 ;
RANGE(START,STOP,DATE,IN,SILENT)	; compare a date to a range, returns IN=1 if in the range.
 ;REQ: pass by value START, STOP, DATE as fileman date/times, SILENT= 0 0r 1
 ;     pass by ref: IN (1=true it is IN the range; 0 = not in range; -1 = error)
 ;
 QUIT:'START!'STOP!'DATE
 IF $GET(SILENT)="" SET SILENT=0
 ;
 IF START'<STOP DO  QUIT
 . WRITE:'SILENT "Start date/time is not before Stop Date/Time.",!!
 . SET IN=-1
 ;
 IF DATE<START DO  QUIT
 . WRITE:'SILENT "Date is before Start date/time.",!!
 . SET IN=0
 ;
 IF DATE>STOP DO  QUIT
 . WRITE:'SILENT "Date is after Stop date/time.",!!
 . SET IN=0
 ;
 IF DATE'>STOP&(DATE'<START) SET IN=1
 ;
 ;B ;debug
 ;
 QUIT  ; label RANGE
 ;
 ;
CHKINF(PATIENT,PSJON,SDATE,EDATE,SILENT)	; check what is infusing
 ;REQUIRED: new the variable array INFUSIONS before calling this label
 ;  pass by value PATIENT ien and PSJON order number
 ;  pass by value start date/time (SDATE) and end date/time (EDATE) for the range
 ;
 IF $GET(SILENT)="" SET SILENT=0
 IF '$DATA(INFUSIONS)!'$DATA(PATIENT)!'$DATA(PSJON)!'$DATA(SDATE)!'$DATA(EDATE) DO  QUIT
 . W:'SILENT "ERROR: required data missing!",!!
 . SET INFUSIONS(0)=-1 
 ;
 ; use the "AADT" x-ref to see if there are administrations for this order in the date range
 ;  if found add the PSBIEN to the array
 NEW ACTDATE SET ACTDATE=SDATE ; action date/time
 FOR  SET ACTDATE=$ORDER(^PSB(53.79,"AADT",PATIENT,ACTDATE)) QUIT:'ACTDATE!(ACTDATE>EDATE)  DO
 . WRITE:'SILENT ?5,ACTDATE,! ;debug
 . NEW PSBIEN SET PSBIEN="" ; ien from the PSB file
 . FOR  SET PSBIEN=$ORDER(^PSB(53.79,"AADT",PATIENT,ACTDATE,PSBIEN)) QUIT:'PSBIEN  DO
 . . WRITE:'SILENT ?10,PSBIEN," ",PSJON," "
 . . ; use PSBIEN to check the PSJON
 . . ; next line - get the PSJON of the administration found
 . . NEW PSJON1 SET PSJON1=$PIECE(^PSB(53.79,PSBIEN,.1),"^") ; 
 . . IF PATIENT=$P(^PSB(53.79,PSBIEN,0),"^")&(PSJON=PSJON1) DO  
 . . . SET INFUSIONS(PSBIEN)="" ; add to array
 . . . WRITE:'SILENT PSJON1," FOUND A MATCH!!!",! ;debug
 . . . IF $PIECE(^PSB(53.79,PSBIEN,0),"^",9)="I" DO  ; infusing
 . . . . SET INFUSIONS(PSBIEN,"STATUS")="INFUSING",INFUSIONS(PSBIEN,"START")=ACTDATE 
 . . . . WRITE:'SILENT ?20,"STATUS = INFUSING!",!
 . . . IF $PIECE(^PSB(53.79,PSBIEN,0),"^",9)="C" DO  ; completed IV
 . . . . SET INFUSIONS(PSBIEN,"STATUS")="COMPLETE"
 . . . . SET INFUSIONS(PSBIEN,"STOP")=ACTDATE
 . . . . SET INFUSIONS(PSBIEN,"START")=$$GETSTRT(PSBIEN) ;get the start date/time
 . . . . WRITE:'SILENT ?20,"STATUS = Complete,",!
 . . . IF $PIECE(^PSB(53.79,PSBIEN,0),"^",9)="S" DO  ; stopped IV
 . . . . SET INFUSIONS(PSBIEN,"STATUS")="STOPPED"
 . . . . SET INFUSIONS(PSBIEN,"START")=$$GETSTRT(PSBIEN)
 . . . . WRITE:'SILENT ?20,"STATUS = Stopped",!
 . . ELSE  WRITE:'SILENT "NO MATCH ",PSJON1,!
 . . ;  check for the AINFUSING x-ref or status="i"
 . . ; check the status of the infusion in ^psb(53.79
 ;
 ; now check the AINFUSING x-ref
 NEW ACTDATE1 SET ACTDATE1="" ; will use for action date/time from x-ref
 FOR  SET ACTDATE1=$ORDER(^PSB(53.79,"AINFUSING",PATIENT,ACTDATE1)) QUIT:'ACTDATE1!(ACTDATE1>EDATE)  DO
 . W:'SILENT ?2,"AINFUSING X-REF  ",ACTDATE1,! ;debug
 . ; next line - no active infusion for the action date time
 . QUIT:'$DATA(^PSB(53.79,"AINFUSING",PATIENT,ACTDATE1)) ;
 . NEW PSBIEN1 SET PSBIEN1="" ; get the PSBIEN from the x-ref
 . FOR  SET PSBIEN1=$ORDER(^PSB(53.79,"AINFUSING",PATIENT,ACTDATE1,PSBIEN1)) QUIT:'PSBIEN1  DO
 . . ;ZW ^PSB(53.79,"AINFUSING",PATIENT,ACTDATE1,PSBIEN1) ;debug
 . . W:'SILENT ?5,PSBIEN1," " ;debug
 . . ; check the PSJON to see if its a match
 . . NEW PSJON2 SET PSJON2=$PIECE(^PSB(53.79,PSBIEN1,.1),"^") ; 
 . . IF PATIENT=$P(^PSB(53.79,PSBIEN1,0),"^")&(PSJON=PSJON2) SET INFUSIONS(PSBIEN1)="",INFUSIONS(PSBIEN1,"AINFUSING X-REF")="INFUSING" W PSJON," ",PSJON2," FOUND A MATCH!!!",!
 . . ELSE  W:'SILENT PSJON," NO MATCH ",PSJON2,!
 . . ;
 ;
 QUIT  ; label CHKINF
 ;
 ;
GETSTRT(PSBIEN)	; use the audit log to find the start date/time of an infusion
 ; this will only find the oldest one (if multiples)
 ;REQUIRED: pass by value the PSBIEN from ^psb(53.79,PSBIEN,0
 ;
 IF '$GET(PSBIEN) QUIT -1 ; no PSBIEN
 IF '$DATA(^PSB(53.79,PSBIEN,.9)) QUIT -1 ; no audit log
 NEW AUDIT,COMMENT,DONE,OUTPUT SET (AUDIT,OUTPUT)="",DONE=0
 FOR  SET AUDIT=$ORDER(^PSB(53.79,PSBIEN,.9,AUDIT)) QUIT:'AUDIT!DONE  DO
 . SET COMMENT=$PIECE(^PSB(53.79,PSBIEN,.9,AUDIT,0),":",2)
 . IF COMMENT["ACTION STATUS Set to 'INFUSING' by" DO  QUIT ; this is the only one
 . SET DONE=1,OUTPUT=+$PIECE(^PSB(53.79,PSBIEN,.9,AUDIT,0),"^")
 . ELSE  QUIT
 ;
 ;
 ;
 QUIT OUTPUT ; label GETSTRT
 ;
 ;
IVARRAY(PATIENT,EDATE,SILENT,ERROR)	; set up the array of active IV's in MEDARRAY
 ; REQUIRED: new the array var MEDARRAY before calling this label
 ;     pass by value PATIENT ien, end date (EDATE)
 ; Optional: pass Silent as 1=true or 0=false
 QUIT:'PATIENT!'EDATE
 IF $GET(SILENT)="" SET SILENT=0
 ;
 ;use end date to run ACTMED^ZVHBC
 NEW ERRORMED SET ERRORMED=0
 DO ACTMED^ZVHBC(PATIENT,EDATE,.ERRORMED,SILENT) ; get list of active meds
 IF ERRORMED DO  QUIT  
 . SET (ERROR,ZVHERR)=1
 . SET ZVHERR("IVCONT","ACTMED",$J,PATIENT)=$GET(SDATE)_U_$GET(EDATE)_U_$GET(SILENT)
 . IF 'SILENT WRITE !!,?5,"ERROR in Active Meds!",!
 IF $GET(^TMP("PSJ",$J,1,0))=-1 DO  QUIT  
 . IF 'SILENT WRITE !!,?5,"No active meds for this date!",!
 ;
 ;set up medication array based on route=IV, type=continuous, no schedule, order status = active
 IF 'SILENT WRITE ?6,"Building Meds Array for PRN meds..."
 NEW MED SET MEDARRAY="INFUSION MEDS ARRAY",MED=""
 FOR  SET MED=$ORDER(^TMP("PSJ",$J,MED)) QUIT:'MED  DO  
 . ;B ; debug
 . NEW ON SET ON=$PIECE(^TMP("PSJ",$J,MED,0),"^",9) ; order # for ^OR(100,
 . IF ON[";" SET ON=$PIECE(ON,";") ; Strip the version numbers
 . ;check status, start and stop dates in OR
 . QUIT:$PIECE(^OR(100,ON,3),"^",3)'=6 ; quit if not an active order
 . QUIT:$PIECE(^OR(100,ON,0),"^",8)'<EDATE ; future order start date
 . QUIT:$PIECE(^OR(100,ON,0),"^",9)'>SDATE ; stop date in the past
 . QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^")'="IV" ; quit if not iv infusion
 . QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",2)'="C" ; quit if not continuous
 . QUIT:$PIECE(^TMP("PSJ",$J,MED,1),"^",3)'="" ; quit if schedule
 . ;
 . SET MEDARRAY(MED)=""
 ;
 QUIT  ; label IVARRAY
 ;
 ;
EDITPSB(ZVHFILE,ERROR,SILENT)	; edit an existing PSB record
 ; required: new ZVHFDA before calling this label.
 ;    new and pass by ref: ERROR for error tracking
 ;    pass by value: ZVHFILE (=1 to save the edit)
 ; optional: SILENT (=1 for true)
 ;
 IF $GET(SILENT)="" SET SILENT=0
 IF $DATA(ZVHFDA)'>9 SET ERROR=1 W:'SILENT "ERROR: No FDA array passed.",!! QUIT
 ;
 IF $GET(ZVHFILE)=1 DO FILE^DIE("S","ZVHFDA","") ; update the file, save ZVHFDA
 ;
 ;check for messages/errors
 IF $DATA(DIERR) DO  QUIT
 . SET (ERROR,ZVHERR)=1
 . MERGE ZVHERR("EDITPSB",$J)=^TMP("DIERR",$J)
 . WRITE:'SILENT " ERROR:Unable to save the Edit.",!!
 ;
 QUIT  ; label EDITPSB
 ;
 ;
OVERLAP(STARTDATE,STOPDATE,SDATE,EDATE,ERROR)	; determine what type of overlap
 ;REQUIRED: 
 ; pass by value:
 ;  start date/time and stop date/time of the Infusion
 ;  start date/time of the range (SDATE) 
 ;  end date/time of the range (EDATE)
 ; pass by ref: ERROR
 ;
 ;optional: SILENT=1 for minimal output
 IF '$GET(STARTDATE)!'$GET(STOPDATE)!'$GET(SDATE)!'$GET(EDATE) SET ERROR=1 QUIT -1
 IF $DATA(INFUSIONS)'>10 SET ERROR=1 QUIT -1
 IF STARTDATE>STOPDATE SET ERROR=1 QUIT -1
 IF SDATE>EDATE SET ERROR=1 QUIT -1
 ;
 IF STARTDATE'>SDATE&(STOPDATE'>SDATE) QUIT 0 ; no overlap, running before
 IF STARTDATE'<EDATE&(STOPDATE'<EDATE) QUIT 0 ; no overlap, running after
 ;
 IF STARTDATE'<SDATE&(STARTDATE'>EDATE)&(STOPDATE'<SDATE)&(STOPDATE'>EDATE) QUIT 1 ; infusion is within the range
 ;
 IF STARTDATE<SDATE&(STOPDATE<EDATE) QUIT 2 ; overlaps start of date range only
 ;
 IF STARTDATE>SDATE&(STARTDATE<EDATE)&(STOPDATE>EDATE) QUIT 3 ; overlaps end of range only
 ;
 IF STARTDATE'>SDATE&(STOPDATE'<EDATE) QUIT 4 ; overlaps the entire range
 ;
 QUIT  ; label OVERLAP
 ;
 ;
