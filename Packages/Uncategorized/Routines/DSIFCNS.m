DSIFCNS ;DSS/BPD - FBCS Consults RPCs; 1/24/12 10:02am
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**23**;Oct 27, 2011;Build 8
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API's used in Fee Basis to Enter/edit Authorizations RPC's:
 ; 
 ; Integration Agreements
 ; 4576   $$VALID^GMRCAU
 ; 2051   $$FIND1^DIC
 ; 2056   GETS^DIQ
 ; 5845   ^GMR(123
 ; 2638   ^ORD(100.01
 Q
FEECNSLT(DSIFRET,DSIFSVC,DSIFLDT,DSIFLIEN,DSIFSCR,DSIFSTAT) ; RPC - DSIF CNSLTS FEE CONSULTS
 N DSIFDT,DSIFIEN,CNT,DSIFPEND,DSIFXREF,DATA,DFN,PATDATA,DSIFERR,SCN K DSIFRET
 I $G(DSIFSVC)="" S DSIFRET(1)="-1^No Service Passed" Q
 I $G(DSIFLIEN)'="",$G(DSIFLDT)="" S DSIFRET(1)="-1^Last IEN passed without Last DT" Q
 I $G(DSIFSTAT)="" S DSIFRET(1)="-1^A Consult Status must be passed" Q
 I DSIFSTAT'="ACTIVE",DSIFSTAT'="PENDING" S DSIFRET(1)="-1^That status is currently not returned" Q
 S DSIFSCR=$G(DSIFSCR)
 I $L(DSIFSCR)>1!("NU"'[DSIFSCR) S DSIFRET(1)="-1^Invalid value passed for screen" Q
 D SCRCN(.SCN,DSIFSVC):DSIFSCR="N",SCRCP(.SCN,DSIFSVC):DSIFSCR="U"
 I (+$G(SCN))<0 S DSIFRET(1)=SCN Q
 S DSIFPEND=$$FIND1^DIC(100.01,,"QX",DSIFSTAT,,,"DSIFERR")
 I $D(DSIFERR) S DSIFRET(1)="-1^Error occurred when looking up"_DSIFSTAT_" status" Q
 I '+DSIFPEND S DSIFRET(1)="-1^Could not find a "_DSIFSTAT_" status value" Q
 S DSIFXREF=$NA(^GMR(123,"AE",DSIFSVC,DSIFPEND))
 ;If last date passed, begin search at 1 decisecond earlier
 ;(this sets our outer loop to begin looking at the last date
 ;passed)
 ;Otherwise, begin search at the bottom of the list.
 S DSIFDT=1
 I 'DSIFLIEN,$G(DSIFLDT)'="" S DSIFDT=$S(+$G(DSIFLDT):9999999-(DSIFLDT-.0000001),1:9999999)
 I DSIFLIEN S DSIFDT=9999999-(DSIFLDT+.0000001)
 ;Loop backward through dates...
 S DSIFIEN=$G(DSIFLIEN)
 S CNT=0
 F  S DSIFDT=$O(@DSIFXREF@(DSIFDT),1) Q:DSIFDT=""!(CNT=50)  D  Q:$D(DSIFERR)
 . ;For each consult...
 . F  S DSIFIEN=$O(@DSIFXREF@(DSIFDT,DSIFIEN)) Q:DSIFIEN=""!(CNT=50)  D  Q:$D(DSIFERR)
 . . ;Get consult data
 . . K DATA D GETS^DIQ(123,DSIFIEN_",",".02;1;3;4;5;8;13","IE","DATA")
 . . I $D(DSIFERR) D  Q
 . . . S DSIFRET(CNT+1)="-1^Error reading data for Consult "_DSIFIEN
 . . S DATA=$NA(DATA(123,DSIFIEN_","))
 . . S DFN=$G(@DATA@(.02,"I"))
 . . K PATDATA D GETS^DIQ(2,DFN_",",".01;.09",,"PATDATA")
 . . I $D(DSIFERR) D  Q
 . . . S DSIFRET(CNT+1)="-1^Error reading data for Consult "_DSIFIEN
 . . S PATDATA=$NA(PATDATA(2,DFN_","))
 . . I $G(@DATA@(13,"I"))="C" D
 . . . ;Increment count
 . . . S CNT=CNT+1
 . . . ;Add data to list
 . . . S $P(DSIFRET(CNT),U,1)=DSIFIEN
 . . . S $P(DSIFRET(CNT),U,2)=$G(@DATA@(3,"E"))_";"_$G(@DATA@(3,"I"))
 . . . S $P(DSIFRET(CNT),U,3)=$G(@DATA@(8,"E"))
 . . . S $P(DSIFRET(CNT),U,4)=$G(@DATA@(1,"E"))
 . . . S $P(DSIFRET(CNT),U,5)=$G(@DATA@(4,"E"))
 . . . S $P(DSIFRET(CNT),U,6)=$G(@PATDATA@(.01))
 . . . S $P(DSIFRET(CNT),U,7)=$E($G(@PATDATA@(.01)))_$E($G(@PATDATA@(.09)),6,9)
 . . . S $P(DSIFRET(CNT),U,8)=DFN
 . . . S $P(DSIFRET(CNT),U,9)=$G(@DATA@(5,"E"))
 ;If we reached the last consult, append $$END$$ to list
 I DSIFDT="" D
 . S DSIFRET(CNT+1)="$$END$$"
 Q
SCRCN(DSIFRET,DSIFSVC) ; Perform Consult Notification Screening
 N VAL
 S DSIFSVC=$G(DSIFSVC)
 ;Default to the failed validation message
 S DSIFRET="-1^User not a Consult Notification Update User for this service"
 S VAL=$$VALID^GMRCAU(DSIFSVC)
 ;The above returns 2 if user can view DSIFSVC; I want to return 1
 S:VAL=2 DSIFRET=1
 Q
SCRCP(DSIFRET,DSIFSVC) ; Perform Consult Parameter screening
 N RTN,I,FOUND
 I $G(DSIFSVC)="" S DSIFRET="-1^No DSIFSVC Passed" Q
 ;Default to the failed validation message
 S DSIFRET="-1^User does not contain DSIFSVC in their Parameter List"
 D GETWP^DSICXPR(.RTN,"USR~GMRC FEE SERVICES")
 I $D(RTN)>1 D
 . S (I,FOUND)=0 F  S I=$O(RTN(I)) Q:'+I  D  Q:FOUND
 . . S FOUND=DSIFSVC=RTN(I,0)
 S:$G(FOUND) DSIFRET=1
 Q
DETAIL(DSIFRET,DSIFCSLT) ; RPC: DSIF CNSLTS GET CONSULT DETAIL
 ; INPUT - IEN OF CONSULT
 ; OUTPUT - DSIFRET(1)=Patient^Internal;External
 ;        - DSIFRET(2)=Referral Date (System)^Internal;External
 ;        - DSIFRET(3)=Referring Provider^Internal;External
 ;        - DSIFRET(4)=Referral Date (Earliest Date)^Internal;External
 ;        - DSIFRET(5)=Urgency^Internal;External
 ;        - DSIFRET(6)=Service Rendered as^I or O   (Inpatient or Outpatient)
 N DSIF,DSIFERR,DSIF1
 I $G(DSIFCSLT)="" S DSIFRET(1)="-1^You must provide a Consult IEN." Q
 D GETS^DIQ(123,DSIFCSLT_",",".02;.01;10;3;5;14","IE","DSIF","DSIFERR")
 I $D(DSIFERR) S DSIFRET(1)="-1^"_DSIFERR("DIERR",1,"TEXT",1) Q
 I $D(DSIF) M DSIF1=DSIF(123,DSIFCSLT_",")
 S DSIFRET(1)="Patient^"_DSIF1(.02,"I")_";"_DSIF1(.02,"E")
 S DSIFRET(2)="Referral Date (System)^"_DSIF1(.01,"I")_";"_DSIF1(.01,"E")
 S DSIFRET(3)="Referring Provider^"_DSIF1(10,"I")_";"_DSIF1(10,"E")
 S DSIFRET(4)="Referral Date (Earliest Date)^"_DSIF1(3,"I")_";"_DSIF1(3,"E")
 S DSIFRET(5)="Urgency^"_DSIF1(5,"I")_";"_DSIF1(5,"E")
 S DSIFRET(6)="Service Rendered as^"_DSIF1(14,"I")_";"_DSIF1(14,"E")
 Q
