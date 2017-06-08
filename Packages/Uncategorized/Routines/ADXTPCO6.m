ADXTPCO6 ;523/KC handle DPRE for deceased patients ; 12-FEB-1992
 ;;1.0;;
 ; clone of ADXZDPRE
 ;
 N ADXT,ADXTCNT,ADXTDA,ADXTDOD,ADXTFLD,ADXTFNUM,ADXTPDA,ADXTPRE,ADXTRN,ADXTSBDA,ADXTTS,ADXTTUDA,ADXTX1,ADXTX2,X,ADXTCNTF,ADXTCNTT,ADXTCNTS
 ;
 ; make sure set up as programmer
 I '($G(DUZ(0))="@") W !,"Not set up as programmer!" Q
 ; make sure ^TMP("ADXT","DI") exists
 I '$D(^TMP("ADXT","DI")) W !,"Diagnosis file not loaded in ^TMP!" Q
 ;
 ; loop through patient file, set tmp index for dates of death
 K ^TMP("ADXT","PID"),^TMP("ADXT","CANSTAT")
 S ADXTRN=0
 U IO(0) W !,"Building a temporary index, please wait..."
 F  S ADXTRN=$O(^TMP("ADXT","PAT",ADXTRN)) Q:'+ADXTRN  D
 .I +(ADXTRN#2) D
 ..S ADXT("PID")=$E(^TMP("ADXT","PAT",ADXTRN),1,7)
 ..S ADXT("PEXP")=$E(^TMP("ADXT","PAT",ADXTRN),211,218)
 ..S ^TMP("ADXT","PID",ADXT("PID"))=$$DTCVT^ADXTUT(ADXT("PEXP"))
 ;
 ; loop through diagnosis file, get variables.
 ;
 S (ADXTRN,ADXTCNT,ADXTCNTF,ADXTCNTT,ADXTCNTS)=0
 U IO(0) W !,"now setting tumor status at d.o.d to DPRE..."
 F  S ADXTRN=$O(^TMP("ADXT","DI",ADXTRN)) Q:'+ADXTRN  D
 .D VAR I '(ADXTCNT#10) W "."
 .S ADXTTUDA=$$TP(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 .I '+ADXTTUDA D ERR Q
 .S ADXTPDA=$P($G(^ONCO(165.5,ADXTTUDA,0)),"^",2) I '+ADXTPDA D ERR2 Q
 .;
 .;   if match patient+tumor, check if follow-up on date of death exists.
 .I '+$$TS(ADXT("DPRE")) Q  ;if not dead, quit
 .S ADXTDOD=$G(^TMP("ADXT","PID",ADXT("PID")))
 .I '+ADXTDOD Q  ;if no date of death quit
 .;add follow-up for dod
 .I '$D(^ONCO(160,ADXTPDA,"F","B",ADXTDOD)) D ADDFOL^ADXTPCO7
 .;add tumor-status if not there
 .I '$D(^ONCO(165.5,ADXTTUDA,"TS","B",ADXTDOD)) D ADDTS^ADXTPCO7
 .;add ts mult for dod
 .;now must set TS to ADXT("DPRE")
 .;loop through TS multiple, get 1st tumor status that date
 .S ADXTSBDA=0 S ADXTSBDA=$O(^ONCO(165.5,ADXTTUDA,"TS","B",ADXTDOD,ADXTSBDA))
 .I '+ADXTSBDA D  Q
 ..W !,"## No tumor status multiple found, tumor ",ADXTTUDA," for date of death."
 .S ADXTTS=$P($G(^ONCO(165.5,ADXTTUDA,"TS",ADXTSBDA,0)),"^",2)
 .;
 .; set index of tumor status values here...
 .S ^TMP("ADXT","CANSTAT",ADXTPDA,ADXTDOD,$$TS(ADXT("DPRE")))=""
 .;
 .I ($L(ADXTTS)&(ADXTTS'=$$TS(ADXT("DPRE")))) D  Q
 ..W !,"## For tumor ",ADXTTUDA," DPRE says tumor stat at d.o.d. is ",$$TS(ADXT("DPRE"))," but stored status is ",ADXTTS,"."
 .S $P(^ONCO(165.5,ADXTTUDA,"TS",ADXTSBDA,0),"^",2)=$$TS(ADXT("DPRE"))
 .;W !,"--> Set tum stat for tumor ",ADXTTUDA," from DPRE ",ADXT("DPRE")," to value ",$$TS(ADXT("DPRE")),"."
 .;
 .;set last tumor status for primary
 .K DIE,DR,DA S DIE="^ONCO(165.5,",DR="95///"_$$TS(ADXT("DPRE"))
 .S DA=ADXTDA D ^DIE
 .;
 .S ADXTCNTS=ADXTCNTS+1
 ;
 D CANSTAT^ADXTPCO7
EXIT ;
 W !!,ADXTCNTF," Follow-ups added for date of death."
 W !,ADXTCNTT," Tumor status entries added for date of death."
 W !,ADXTCNTS," Tumor statuses (and last tumor statuses) set to new values at date of death."
 K ^TMP("ADXT","PID")
 K ^TMP("ADXT","CANSTAT")
 K ADXT,ADXTCNT,ADXTDA,ADXTDOD,ADXTFLD,ADXTFNUM,ADXTPDA,ADXTPRE,ADXTRN,ADXTSBDA,ADXTTS,ADXTTUDA,ADXTX1,ADXTX2,X
 Q
 ;
VAR ;
 S ADXTCNT=ADXTCNT+1
 S ADXTX1=$G(^TMP("ADXT","DI",ADXTRN,1))
 S ADXTX2=$G(^TMP("ADXT","DI",ADXTRN,2))
 K ADXT D EN^ADXTADI1
 Q
ERR ;
 U IO(0) W !,"## MRS Tumor for PID ",ADXT("PID")," DTOP ",ADXT("DTOP")," SEQUENCE ",ADXT("DSQ")," not matched!" Q
ERR2 ;
 U IO(0) W !,"## Tumor # ",ADXTTUDA," in primary file not matched w/ patient in ONCO patient file!" Q
 ;
TS(ADXTPRE) ;
 I ADXTPRE=4 Q 1
 I ADXTPRE=5 Q 2
 I ADXTPRE=6 Q 1
 I ADXTPRE=7 Q 2
 I ADXTPRE=9 Q 9
 Q 0
 ;
TP(PID,DTOP,DSQ) ; return pointer to primary file (0 if not matched)
 N RETVAL S RETVAL=""
 Q:((PID="")!(DTOP="")!(DSQ="")) 0
 S PID=$E(PID,1,2)_$E(PID,4,7)
 I (DTOP]"") D
 .S X=$G(^ONCO(169,"ACV",DTOP))
 .S ADXTDA=""
 .F  S ADXTDA=$O(^ONCO(165.5,"AA",PID,ADXTDA)) Q:'+ADXTDA  D  Q:RETVAL]""
 ..I $P($G(^ONCO(165.5,ADXTDA,2)),"^")=X I $P($G(^ONCO(165.5,ADXTDA,0)),"^",6)=DSQ S RETVAL=ADXTDA
 Q +RETVAL
