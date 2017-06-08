ADXTPCO1 ;523/KC fill in Last Follow-up Contact field ; 3-NOV-1992
 ;;1.0;;
 ;
 N ADXTFDTA,ADXTFDT,ADXTRN,ADXTPID,ADXTPIDP,X,DIE,DA,DR
 ;
 U IO(0) W !!,"Setting Last Contact field in Oncology Patient File..."
 S ADXTRN="",ADXTPID="",ADXTPIDP="",ADXTFDT=""
 F  S ADXTRN=$O(^TMP("ADXT","FL",ADXTRN)) Q:ADXTRN=""  D
 .I ADXTRN#10=1 W "."
 .S ADXTPIDP=ADXTPID
 .S ADXTPID=$E(^TMP("ADXT","FL",ADXTRN),1,7)
 .I ((ADXTPIDP'=ADXTPID)&(ADXTPIDP'="")) D STUFF Q
 .D SET Q
 ;
 D ABSTDATE
EXIT ;
 K ADXTFDTA,ADXTFDT,ADXTRN,ADXTPID,ADXTPIDP,X,DIE,DA,DR
 Q
STUFF ; stuff entry into 160 if necessary
 S ADXTFDT="",ADXTFDTS=""
 F  S ADXTFDT=$O(ADXTFDTA(ADXTFDT)) Q:ADXTFDT=""  S:(ADXTFDT'="") ADXTFDTS=ADXTFDT
 Q:ADXTFDTS=""
 S X=$$GTMDP^ADXTUT(ADXTFDTA(ADXTFDTS)) Q:+X<1
 S ADXTDA=$$GTPP^ADXTUT(ADXTPIDP) Q:+ADXTDA<1
 W !,"Setting entry ",ADXTDA,"'s LAST CONTACT TO ",$P($G(^ONCO(165,X,0)),"^"),"."
 K DIE,DA,DR
 S DIE="^ONCO(160,",DR="15.1////"_X,DA=ADXTDA D ^DIE
 S CHECK=$P($G(^ONCO(160,ADXTDA,1)),"^",6) I CHECK'=X W !,"   ...BUT DIE FAILED!"
 K ADXTFDTA
 Q
SET ; set a subscript in ADXTFDTA array of dates for current entry
 S ADXTFDT=$E(^TMP("ADXT","FL",ADXTRN),14,21)
 S %=$E(^TMP("ADXT","FL",ADXTRN),22,27)
 I $$GTMDP^ADXTUT(%)'<1 S ADXTFDTA($$DTCVT^ADXTUT(ADXTFDT))=$E(^TMP("ADXT","FL",ADXTRN),22,27) Q
 ;I '$D(ADXTFDTA($$DTCVT^ADXTUT(ADXTFDT))) S ADXTFDTA($$DTCVT^ADXTUT(ADXTFDT))=$E(^TMP("ADXT","FL",ADXTRN),22,27) Q
 Q
 ;
ABSTDATE ;523/KC set abstract date based on Discharge Date + 6mo 
 N ADXTDA,ADXTDTAB,ADXTDTDS,COUNT,COUNTSET,DA,DIE,DR
 S (ADXTDA,COUNT,COUNTSET)=0
 Q:($G(DUZ(0))'="@")
 U IO(0) W !!,"In primaries w/no abstract date, setting to Discharge Date + 6 months."
 F  S ADXTDA=$O(^ONCO(165.5,ADXTDA)) Q:'+ADXTDA  D
 .S COUNT=COUNT+1 I ((COUNT#10)=1) W "."
 .S ADXTDTAB=$P($G(^ONCO(165.5,ADXTDA,7)),"^",1)
 .I ADXTDTAB]"" W !,"already had abstract date for entry # ",ADXTDA Q
 .I ADXTDTAB']"" D
 ..S ADXTDTDS=$P($G(^ONCO(165.5,ADXTDA,0)),"^",9)
 ..I '+ADXTDTDS W !,"missing or invalid discharge date for entry # ",ADXTDA Q
 ..I +ADXTDTDS D
 ...K DIE,DR,DA
 ...S DA=ADXTDA,DIE="^ONCO(165.5,",DR="90////"_$$SIXMO(ADXTDTDS)
 ...D ^DIE S COUNTSET=COUNTSET+1
 ;
 W !!,COUNT," entries looked at, ",COUNTSET," abstract dates set."
 K ADXTDA,ADXTDTAB,ADXTDTDS,COUNT,COUNTSET,DA,DIE,DR
 Q
SIXMO(X1) ; return date + 6 mos.
 N X2 S X2=182 D C^%DTC Q X
