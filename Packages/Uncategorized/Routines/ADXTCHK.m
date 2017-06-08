ADXTCHK ; 523/KC pattern match check of data
 ;;1.1;;
EN ; INPUT VARIABLE: LBL = "PAT","SCD","DOC","DI", OR "FL"
 ; OUTPUT VARIABLES: ADXT(LBL) (RECORD COUNT)
 ;                   ADXT(LBL,"FAIL") (FAILURE COUNT)
 ;
 N ADXTCNT,ADXTERR,ADXTRN,ADXTSTR,ADXTI
 S (ADXTRN,ADXTCNT,ADXTERR)=0
 S ADXT(LBL)=0,ADXT(LBL,"FAIL")=0
 D @(LBL_"1")
 F  S ADXTRN=$O(^TMP("ADXT",LBL,ADXTRN)) Q:'+ADXTRN  D
 .S ADXT(LBL)=ADXT(LBL)+1,ADXTERR=0
 .D @LBL
 .I +ADXTERR S ADXT(LBL,"FAIL")=ADXT(LBL,"FAIL")+1
 W !,$J(ADXT(LBL),6)," ",ADXTSTR," Records found in ^TMP global. "
 W $J(ADXT(LBL,"FAIL"),6),") failed data check."
 N ADXTCNT,ADXTERR,ADXTRN,ADXTSTR,ADXTI
 Q
 ;
PAT ;
 D PAT1
 S X=$G(^TMP("ADXT","PAT",ADXTRN)),ADXTERR=0
 I +(ADXTRN#2) F ADXTI=3,32,35,40,43,202,205,213,216 D  Q:ADXTERR=1
 .I $E(X,ADXTI)'="/" S ADXTERR=1,ADXTPOS=ADXTI,ADXTLVL=ADXTRN Q
 I +(ADXTRN#2)&(ADXTERR=0) S ADXTRN=ADXTRN+1 D
 .;S X=$G(^TMP("ADXT","PAT",ADXTRN))
 .;I $E(X,33)'="(" S ADXTERR=1,ADXTPOS=33,ADXTLVL=ADXTRN Q
 .;I $E(X,37)'=")" S ADXTERR=1,ADXTPOS=37,ADXTLVL=ADXTRN Q
 I +ADXTERR W !?10,ADXTSTR," Record at level ^TMP(""ADXT"",""PAT"",",ADXTRN,":",ADXTRN+1,") failed data check."
 I  W !?10,"Failed at or before position ",ADXTPOS," at subscript level ",ADXTLVL,"."
 Q
SCD ;
 D SCD1
 S X=$G(^TMP("ADXT","SCD",ADXTRN)),ADXTERR=0
 D
 .I $E(X,3)'="/" S ADXTERR=1,ADXTPOS=3,ADXTLVL=ADXTRN Q
 .I $L(X)<66 S ADXTERR=1,ADXTPOS=66,ADXTLVL=ADXTRN Q
 .;I $E(X,86)'="(" S ADXTERR=1,ADXTPOS=86,ADXTLVL=ADXTRN Q
 .;I $E(X,90)'=")" S ADXTERR=1,ADXTPOS=90,ADXTLVL=ADXTRN Q
 I +ADXTERR W !?10,ADXTSTR," Record at level ^TMP(""ADXT"",""SCD"",",ADXTRN,") failed data check."
 I  W !?10,"Failed at or before position ",ADXTPOS," at subscript level ",ADXTLVL,"."
 Q
DOC ;
 D DOC1
 S X=$G(^TMP("ADXT","DOC",ADXTRN)),ADXTERR=0
 D
 .I $L(X)<66 S ADXTERR=1,ADXTPOS=66,ADXTLVL=ADXTRN Q
 .I X?4"9".E S ADXTERR=1,ADXTPOS=10,ADXTLVL=ADXTRN W !,"9999" Q
 .;I $E(X,115)'="(" S ADXTERR=1,ADXTPOS=115,ADXTLVL=ADXTRN Q
 .;I $E(X,119)'=")" S ADXTERR=1,ADXTPOS=119,ADXTLVL=ADXTRN Q
 I +ADXTERR W !?10,ADXTSTR," Record at level ^TMP(""ADXT"",""DOC"",",ADXTRN,") failed data check."
 I  W !?10,"Failed at or before position ",ADXTPOS," at subscript level ",ADXTLVL,"."
 Q
DI ;
 D DI1
 S X=$G(^TMP("ADXT","DI",ADXTRN,1)),ADXTERR=0
 F ADXTI=3,41,44,49,52,57,60,65,68,73,76,81,84,111,114,121,124,134,137,144,147,154,157,164,167,174,177,184,187,204,207 D  Q:ADXTERR=1
 .I $E(X,ADXTI)'="/" S ADXTERR=1,ADXTPOS=ADXTI,ADXTLVL=ADXTRN_",1"
 S X=$G(^TMP("ADXT","DI",ADXTRN,2))
 I '+ADXTERR S ADXTERR=0 F ADXTI=126,129 D  Q:ADXTERR=1
 .I $E(X,ADXTI)'="/" S ADXTERR=1,ADXTPOS=ADXTI,ADXTLVL=ADXTRN_",2"
 I +ADXTERR W !?10,ADXTSTR," Record at level ^TMP(""ADXT"",""DI"",",ADXTRN,") failed data check."
 I  W !?10,"Failed at or before position ",ADXTPOS," at subscript level ",ADXTLVL,"."
 Q
FL ;
 D FL1
 S X=$G(^TMP("ADXT","FL",ADXTRN)),ADXTERR=0
 F ADXTI=3,16,19,33,36,47,50,60,63,70,73,80,83,90,93,100,103,108,111 D
 .I $E(X,ADXTI)'="/" S ADXTERR=1,ADXTPOS=ADXTI,ADXTLVL=ADXTRN
 I +ADXTERR W !?10,ADXTSTR," Record at level ^TMP(""ADXT"",""FL"",",ADXTRN,") failed data check."
 I  W !?10,"Failed at or before position ",ADXTPOS," at subscript level ",ADXTLVL,"."
 Q
CHK ;check presence of files in Kermit Holding Area
 ;
 K DIC S DIC="^DIZ(8980,",DIC(0)="XZ",X="DAGFILE.T01" D CHK1
 K DIC S DIC="^DIZ(8980,",DIC(0)="XZ",X="DOCFILE.T01" D CHK1
 K DIC S DIC="^DIZ(8980,",DIC(0)="XZ",X="FLWFILE.T01" D CHK1
 K DIC S DIC="^DIZ(8980,",DIC(0)="XZ",X="PATFILE.T01" D CHK1
 K DIC S DIC="^DIZ(8980,",DIC(0)="XZ",X="SCDFILE.T01" D CHK1
 Q
CHK1 ;
 D ^DIC
 I +Y<1 W !,"Could not find ",X," in Kermit Holding Area." S ADXTSTAT=0
 Q
 ;
TMPCHK ; check presence of files in ^TMP global
 ;
 W !!,"Verifying/counting records stored in ^TMP global, please wait..."
 S LBL="PAT" D EN
 S LBL="SCD" D EN
 S LBL="DOC" D EN
 S LBL="DI" D EN
 S LBL="FL" D EN
 Q
 ;
PAT1 S ADXTSTR="Patient" Q
SCD1 S ADXTSTR="Secondary" Q
DOC1 S ADXTSTR="Doctor" Q
DI1 S ADXTSTR="Diagnosis" Q
FL1 S ADXTSTR="Follow-up" Q
