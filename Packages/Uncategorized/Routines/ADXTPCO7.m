ADXTPCO7 ;523/KC continuation of ADXTPCO6; 16-FEB-1992
 ;;1.0;;
 ;clone of ADXZDPR2
 ;
CANSTAT ; loop through temporary index, set overall canstat in follow-ups on dod
 W !!,"Setting Cancer Status for all follow-ups on a date of death..."
 S (ADXTPDA,ADXTDOD)=0
 F  S ADXTPDA=$O(^TMP("ADXT","CANSTAT",ADXTPDA)) Q:'+ADXTPDA  D
 .S ADXTDOD=0 S ADXTDOD=$O(^TMP("ADXT","CANSTAT",ADXTPDA,ADXTDOD))
 .Q:'+ADXTDOD  S X=""
 .I $D(^TMP("ADXT","CANSTAT",ADXTPDA,ADXTDOD,2)) S X=2
 .I $D(^TMP("ADXT","CANSTAT",ADXTPDA,ADXTDOD,9))&(X']"") S X=9
 .I $D(^TMP("ADXT","CANSTAT",ADXTPDA,ADXTDOD,1))&(X']"") S X=1
 .I X'["" S X=9
 .S ADXTSBDA=0
 .S ADXTSBDA=$O(^ONCO(160,ADXTPDA,"F","B",ADXTDOD,ADXTSBDA))
 .I +ADXTSBDA D
 ..Q:'+$D(^ONCO(160,ADXTPDA,"F",ADXTSBDA,0))
 ..S $P(^ONCO(160,ADXTPDA,"F",ADXTSBDA,0),"^",3)=X
 Q
ADDTS ;
 ; need ADXTDOD,ADXTDA
 S ADXTDA=ADXTTUDA
 S ADXTFNUM=165.5
 S ADXTFLD=73
 S X=ADXTDOD I +X D ^ADXTMULT
 I ADXTSBDA=-1 D  Q
 .W !,"## Couldn't add tumor status multiple for tumor # ",ADXTDA," on date ",ADXTDOD,"."
 ;W !,"-> Added tumor status entry, tumor ",ADXTDA," date ",ADXTDOD,"."
 S ADXTCNTT=ADXTCNTT+1 Q
ADDFOL ;
 ; need ADXTDOD,ADXTDA
 S ADXTDA=ADXTPDA
 S ADXTFNUM=160,ADXTFLD=400,X=ADXTDOD D ^ADXTMULT
 I ADXTSBDA=-1 W !,"## Couldn't add follow-up for patient entry ",ADXTDA,", on date ",ADXTDOD,"."
 ; set vital status of created follow-up
 S $P(^ONCO(160,ADXTDA,"F",ADXTSBDA,0),"^",2)=0
 S $P(^ONCO(160,ADXTDA,"F",ADXTSBDA,0),"^",8)=1
 D NOW^%DTC S ^ONCO(160,ADXTDA,"F",ADXTSBDA,1,0)="^^1^1^"_X_"^"
 S ^ONCO(160,ADXTDA,"F",ADXTSBDA,1,1,0)="Follow-up created from Date of Death from MRS DPRE post-conversion."
 W !,"** Added FOLLOW-UP entry, tumor ",ADXTDA," date ",ADXTDOD,"."
 S ADXTCNTF=ADXTCNTF+1
 Q
