ADXTPCVT ;523/KC continuation of post-conversion;21-OCT-1992
 ;;1.1;;
 ;
 N ADXTCNT,ADXTDA,ADXTDOD,ADXTDSQ,ADXTDTOP,ADXTFDAT,ADXTPID,ADXTSDA
 N ADXT,ADXTFLD,ADXTFNUM,ADXTPEXP,ADXTRN,ADXTSBDA,ADXTSTFF,ADXTX1,X
 ;
 ;
 D VITAL ; create follow-ups on dates of death, where missing
 ;
 D ^ADXTPCV1 ; carry forward missing tumor statuses
 ;
 U IO(0) W !!,"The conversion is almost done!...",!!
 D RX^ONCOUK ; call site manager option to reindex all files...
 U IO(0) W !!,"Now re-staging ALL tumors...",!!
 S ADXTODDX=2880101 ; same as date used in ONCOPOS
 I '$D(ADXTODDX) S ADXTODDX=0 ; use 0 to re-stage ALL tumors
 D RSTG^ONCOU55A(ADXTODDX) ; re-stage primaries
 ;
 D ^ADXTPCV2 ; fill in cause of death
 ;
 D ^ADXTPCK ; check patients and primaries matching!
 ;
EXIT ;
 K ADXTCNT,ADXTDA,ADXTDOD,ADXTDSQ,ADXTDTOP,ADXTFDAT,ADXTPID,ADXTSDA
 K ADXT,ADXTFLD,ADXTFNUM,ADXTPEXP,ADXTRN,ADXTSBDA,ADXTSTFF,ADXTX1,X
 Q
 ;
VITAL W !!!,"Creating follow-up entries at Date of death when no follow-up exists w/date = D.O.D..."
 ;
 S ADXTDA=0,ADXTCNT=0,ADXTDCNT=0
 F  S ADXTDA=$O(^ONCO(160,ADXTDA)) Q:'+ADXTDA  D
 .S ADXTDCNT=ADXTDCNT+1 I '+(ADXTDCNT#10) W "."
 .; if patient not deceased, quit
 .S ADXTDOD=$$DOD^ADXTUT(ADXTDA) Q:'+ADXTDOD
 .;
 .S ADXTSBDA=0
 .S:$D(^ONCO(160,ADXTDA,"F","B",ADXTDOD)) ADXTSBDA=$O(^ONCO(160,ADXTDA,"F","B",ADXTDOD,0))
 .Q:+ADXTSBDA  ; don't need to create, a follow-up already exists!
 .; if no follow-up = date of death, create one...
 .S ADXTFNUM=160,ADXTFLD=400,X=ADXTDOD D ^ADXTMULT
 .I ADXTSBDA=-1 W !,"Couldn't add follow-up for DATE of DEATH, patient entry ",ADXTDA,"." Q
 .S ADXTCNT=ADXTCNT+1 ; record that another fup created
 .; set vital status of created follow-up
 .S $P(^ONCO(160,ADXTDA,"F",ADXTSBDA,0),"^",2)=0
 .; set follow-up entry status to complete
 .S $P(^ONCO(160,ADXTDA,"F",ADXTSBDA,0),"^",8)=1
 .; set conversion id field
 .S ^ONCO(160,ADXTDA,"F",ADXTSBDA,523000)="MRS DATE OF DEATH"
 .D NOW^%DTC S ^ONCO(160,ADXTDA,"F",ADXTSBDA,1,0)="^^1^1^"_X_"^"
 .S ^ONCO(160,ADXTDA,"F",ADXTSBDA,1,1,0)="Follow-up created from Date of Death from MRS conversion."
 ;
DISPLAY ;
 W !!?5,ADXTCNT," Follow-up entries were created.",!!!
 Q
