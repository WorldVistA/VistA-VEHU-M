ADXTPCV1 ;523/KC post-convert carry forward tumor statuses
 ;;1.1;;
 ;
 S ADXTFILE="CARRY FORWARD"
 S ADXTFNUM=165.5
 S ADXTFLD=73
 ;
 U IO(0) W !,"Carrying forward tumor statuses from the conversion..."
 S (ADXTRN,ADXTCNT)=0
 F  S ADXTRN=$O(^TMP("ADXT","FL",ADXTRN)) Q:'+ADXTRN  D
 .I '(ADXTRN#10) U IO(0) W "."
 .S ADXTX1=$G(^TMP("ADXT","FL",ADXTRN)) D EN^ADXTAFL1
 .S ADXTID=ADXT("PID")_ADXT("DTOP")_ADXT("DSQ")
 .;
 .S ADXTDA=$$GTOPP^ADXTUT(ADXT("PID"),ADXT("DTOP"),ADXT("DSQ"))
 .I '+ADXTDA U IO(0) W !,ADXTID," did not match a VA tumor!!" Q
 .;
 .S ADXTPDA=$P($G(^ONCO(165.5,ADXTDA,0)),"^",2) Q:'+ADXTPDA
 .Q:'+$$ALIVE^ADXTUT(X,ADXTPDA)  ; if deceased, DON'T carry forward!
 .;
 .S ADXTDASV=ADXTDA D OTHERTS S ADXTDA=ADXTDASV
EXIT ;
 W !!,ADXTCNT," Tumor statuses carried forward",!
 Q
OTHERTS ;
 ; loop through other tumors for same patient
 ; check if date dx < ADXT("FDT")
 ; if so, check if multiple exists for this date
 ; if not, create one
 ;
 S ADXTDA=0 F  S ADXTDA=$O(^ONCO(165.5,"C",ADXTPDA,ADXTDA)) Q:'+ADXTDA  D
 .Q:ADXTDA=ADXTDASV  ; quit if same tumor
 .S ADXTDDX=$P($G(^ONCO(165.5,ADXTDA,0)),"^",16)
 .Q:'+ADXTDDX  S X=$$DTCVT^ADXTUT(ADXT("FDT")) Q:'+X
 .Q:(ADXTDDX'<X)  ; quit if DATE DX '< FDT
 .S ADXTSBDA=0
 .I $D(^ONCO(165.5,ADXTDA,"TS","B",X)) Q  ; quit if TS already exists
 .D ^ADXTMULT I +ADXTSBDA D  ; add previous TS, (9 if no previous)
 ..S ADXTPS=9,ADXTZDAT=0 F  S ADXTZDAT=$O(^ONCO(165.5,ADXTDA,"TS","B",ADXTZDAT)) Q:'+ADXTZDAT  Q:ADXTZDAT'<X  D
 ...S ADXTZBDA=$O(^ONCO(165.5,ADXTDA,"TS","B",ADXTZDAT,0)) Q:'+ADXTZBDA  D
 ....S ADXTPS=$P($G(^ONCO(165.5,ADXTDA,"TS",ADXTZBDA,0)),"^",2)
 ..S DA(1)=ADXTDA,DA=ADXTSBDA,DIE="^ONCO(165.5,"_DA(1)_",""TS"","
 ..S DR=".02///"_ADXTPS D ^DIE
 ..I $P($G(^ONCO(165.5,ADXTDA,"TS",ADXTSBDA,0)),"^",2)'=ADXTPS D  Q
 ...W !,"Error adding carry-forward tumor status, DA ",ADXTDA," date "
 ...W ADXT("FDT"),"."
 ..S ADXTCNT=ADXTCNT+1
 Q
