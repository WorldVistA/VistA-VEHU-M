VEJDAUD0 ;DBB;AUDIT RPC CALLS
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 Q
 ;FILE (Required) File number of a File which is being audited.  
 ;FIELDS (Required) Specifies which fields from the audited File are to be examined.  
 ;Can be one of the following:  
 ;       A single field number, A list of field numbers separated by semicolons,
 ;       A range of field numbers in the form M:N, "*" meaning, 'examine all audited fields'.  
 ;BEGDAT (Optional) Beginning date/time (FileMan format) of the auditing period. 
 ;If no BEGDAT is specified, the File's archive history will be scanned from its earliest date/time.
 ;ENDDAT (Optional) Ending date/time (FileMan format). If no ENDDAT is specified, the File's archive history
 ;will be scanned through its most recent date/time. 
AUDRET(SUCCESS,FILE,FIELDS,BEGDAT,ENDDAT) N VEJDMES K SUCCESS,^TMP("VEJDAUD0",$J),^TMP("VEJDAUD0A",$J)
 I $G(FIELDS)="" S FIELDS="*"
 S ANSWER="" I $G(ENDDAT)'="" K MES D DT^DILF("T",ENDDAT,.ANSWER,"","VEJDMES") I $D(VEJDMES) D MES Q
 S ENDDAT0=ANSWER I ENDDAT0'["." S ENDDAT0=ENDDAT0_.235959
 S ANSWER="" I $G(BEGDAT)'="" K MES D DT^DILF("T",BEGDAT,.ANSWER,"","VEJDMES") I $D(VEJDMES) D MES Q
 S BEGDAT0=ANSWER
 D CHANGED^DIAUTL(FILE,FIELDS,"","^TMP(""VEJDAUD0"",$J)",BEGDAT0,ENDDAT0)
 K ^TMP("VEJDAUD0A",$J)
 S J="" F I=1:1 S J=$O(^TMP("VEJDAUD0",$J,J)) Q:'J  S ^TMP("VEJDAUD0A",$J,I)=J
 S SUCCESS=$NA(^TMP("VEJDAUD0A",$J)),^TMP("VEJDAUD0A",$J,0)=I-1
 Q
AUDCHK(SUCCESS,FILE,FIELD) N VEJDAUD,VEJDMES
 K SUCCESS D FIELD^DID(FILE,FIELD,"","AUDIT","VEJDAUD","VEJDMES") I $D(VEJDMES) D MES Q
 S X=$E($G(VEJDAUD("AUDIT"))) I X="" S X="N"
 S SUCCESS(0)="0^"_X
 Q
MES N X
 S X="-1" F I=1:1:VEJDMES("DIERR") S X=X_"^ "_VEJDMES("DIERR",I,"TEXT",1) Q:$L(X)>500
 S SUCCESS(0)=X
 Q
 ; entry for use by KIDS install (or stand-alone) to turn-on Auditing for IRT files
TURNON I $D(DT)+$D(U)'=2 S:'$G(DUZ(0)) DUZ(0)="@" D DT^DICRW
 N DIR,Y S DIR(0)="Y"
 S DIR("A",1)="Enable Auditing of fields in the INCOMPLETE RECORD FILE"
 S DIR("A")="Answer 'Y' or 'N'"
 D ^DIR Q:'Y
 D TURNON^DIAUTL(393,".01;.11")
 Q
TESTA K  D AUDRET(.ANS,393,"*","T-301","T")
 ZW  Q
TESTC K  D AUDCHK(.ANS,393,".01")
 ZW  Q
