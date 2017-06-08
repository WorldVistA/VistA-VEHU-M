ADXTMFL ;523/KC follow-up file pre-processor;4-AUG-1992
 ;;1.1;;
 ;
 ; move MRS records (follow-up file) from Kermit holding area
 ; to ^TMP("ADXT","FL"). Stored as ^TMP("ADXT","FL",record#,1 or 2),
 ; where 1 is chars 1-221 in MRS record, 2 is chars 222-439.
EN ;
 N ADXTFN,ADXTPOS,ADXTRN,DIC,X,Y
 S DIC="^DIZ(8980,",X="FLWFILE.T01",DIC(0)="QZ" D ^DIC
 I +Y<1 S ADXTSTAT=0
 I  W !!,"LOOKUP OF FLWFILE.T01 (FOLLOW-UP FILE) IN KERMIT HOLDING AREA"
 I  W " FAILED. ",!,"ABORTING...",! G EXIT
 S ADXTFN=$P(Y,"^")
 ;
 W !,"Copying Follow-up file records from Kermit Holding area to ^TMP"
 K ^TMP("ADXT","FL")
 S (ADXTRN,ADXTPOS)=0
 ;
PROCESS ;
 F  S ADXTPOS=$O(^DIZ(8980,ADXTFN,2,ADXTPOS)) Q:+ADXTPOS=0  D
 .S ADXTRN=ADXTRN+1
 .I $E(ADXTRN,$L(ADXTRN))="0" W "."
 .S ^TMP("ADXT","FL",ADXTRN)=^DIZ(8980,ADXTFN,2,ADXTPOS,0)
 W !,ADXTRN," records were copied.",!
 ;
EXIT ;
 K ADXTFN,ADXTPOS,ADXTRN,DIC,X,Y
 Q
