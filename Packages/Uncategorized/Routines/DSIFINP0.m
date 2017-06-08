DSIFINP0 ;DSS/RED - RPC FOR FEE BASIS INPATIENT ;07/16/2007 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ; 10000   D^%DTC
 ;  2051   FIND^DIC,LIST^DIC
 ;  2052   FIELD^DID
 ;  2056   $$GET1^DIQ
 ;  2171 - $$STA^XUAF4
 ;  5274  File 442 access
 ;  5090   PDF^FBAAUTL
 ; 10005   DT^DICRW
 ;  5104   ^FB7078
 ; 10076   ^XUSEC
 ;  5090   STATION^FBAAUTL
 ;  2056   GETS^DIQ
 ;  
 Q   ;Cannot be called directly
 ;
GETVALS(FBOUT) ;  RPC: DSIF INP GET VALUES
 ; List values needed for selection screens, no input
 ;   ^TMP($J,"DSIFINP0","A",NAME)="VA Regulation (Admitting authority)"^43.4^IEN^NAME^*REGULATION #^CFR #^NURSING HOME^ACTIVE?
 ;   ^TMP($J,"DSIFINP0","B",n)="Bedsection/Treating Speciality^set of codes"^Code^Name
 ;   ^TMP($J,"DSIFINP0","C",n)="Discharge type"^161.01;FIELD^set of codes^code^Name
 ;   ^TMP($J("DSIFINP0","D",n)="Admitting Area^44^IEN;Name"
 ;   ^TMP($J("DSIFINP0","E",n)="POV (Inpat)^161.82^IEN;Austin code;Name
 ;
 N DSIF,IEN,FILE,SCREEN,FLAGS,FROM,ID,IENS,NUMBER,PART,RET1,TARGET S FBOUT=$NA(^TMP($J,"DSIFINP0")) K @FBOUT
 ; VA Regulation list
 S DSIF=$NA(^TMP($J,"DSIF")) K @DSIF
 ; DSIF*3.2*1, as per DG*5.3*140 remove field #6 below, and sort by Name, also quit screening INACTIVE codes from 43.4
 ; DSIF*3.2*2 Add field 4 show 1 or 0 for active field
 S FILE=43.4,FIELDS=".01;2;5;4;@",(SCREEN,INDEX)=""
 S CNT=0,IENS="",FLAGS="P",NUMBER="",FROM="",PART="",ID="",TARGET="",MSG=""
 D GETXREF^DSIFPAYR(.TARGET) I $D(^TMP("DIERR",$J)) S @FBOUT@(0)="-1^Error in data return for file "_FILE Q
 F J=0:0 S J=$O(^TMP("DILIST",$J,J)) Q:'J  S @FBOUT@("A",$P(^TMP("DILIST",$J,J,0),U,2),J)="VA Regulation (Admitting authority)^43.4^"_$P(^TMP("DILIST",$J,J,0),U,1,4)_U_$S($P(^TMP("DILIST",$J,J,0),U,5)["IN":1,1:0),CNT=CNT+1
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 ;Bedsection/treating speciality (set of codes)
 N DSIF S DSIF="00;SURGICAL^10;MEDICAL^86;PSYCHIATRY"
 N I F I=1:1:3 S @FBOUT@("B",I)="Bedsection/Treating Speciality^set of codes^"_$P($P(DSIF,U,I),";")_U_$P($P(DSIF,U,I),";",2)
 ; Get discharge type (set of codes)
 N FIELD,ROOT
 S FIELD=".06" D FILL
 N I F I=1:1:($L(FBDATA,U)-1) S @FBOUT@("C",I)="Discharge type"_U_"161.01;.06"_U_$TR($P($G(FBDATA),U,I),":",U)
 ;Admitting Area
 N SCREEN,RET,ERR,I,IEN,VALUE S SCREEN="I $P(^(0),U,3)=""Z"",$D(^DIC(40.9,+$P(^(0),U,22),0)),$P(^(0),U,2)=""AA"""
 D LIST^DIC(44,"",".01;1;@","KI",99,"","","",.SCREEN,"","RET","ERR") S RET1=$NA(RET("DILIST"))
 F I=0:0 S I=$O(@RET1@(2,I)) Q:'I  S IEN=@RET1@(2,I),VALUE=@RET1@("ID",I,.01) S @FBOUT@("D",IEN)="Admitting area^44^"_IEN_";"_VALUE
 ;POV (Inpatient)
 N SCREEN,RET,ERR,I,IEN,VALUE S SCREEN="I $P(^(0),U,2)=6"
 D LIST^DIC(161.82,"",".01;3;4;@","KI",99,"","","",.SCREEN,"","RET","ERR") S RET=$NA(RET("DILIST"))
 F I=0:0 S I=$O(@RET@(2,I)) Q:'I  S IEN=@RET@(2,I) D
 . Q:$G(@RET@("ID",I,4))'=""
 . S @FBOUT@("E",IEN)="POV (Inpat)^161.82^"_IEN_";"_@RET@("ID",I,3)_";"_@RET@("ID",I,.01)
 Q
FILL ; Used by GETVALS
 Q:'FIELD
 K ROOT,FBDATA D FIELD^DID(161.01,FIELD,"","POINTER","ROOT","MSG")
 S FBDATA=$TR($G(ROOT("POINTER")),";",U)
 I $L(MSG)>0 S @FBOUT@(0)="-1^Message return value error, please call IRM: File 161.01; field - "_FIELD Q
 Q
OBLLIST(FBOUT,FBCONT) ;RPC: DSIF INP OBLIG LOOKUP
 ; RPC used to lookup existing obligations from ^PRC(442,"E"
 ; input:  FBCONT = Fund control point
 ; output: IEN^Obligation number^date^Type^Actual Amount
 ; 
 N IEN,LIST,CNT,FBRET S IEN=0 S:$G(U)="" U="^"
 I FBCONT="" S @FBOUT@(0)="-1^No Control point entered" Q
 S FBOUT=$NA(^TMP($J,"DSIFINP0")),FBRET=$NA(^TMP("DILIST",$J)) K @FBOUT,@FBRET
 I '$D(^PRC(442,"E",FBCONT)) S @FBOUT@(0)="-1^Invalid control point entered" Q
 D LIST^DIC(442,"","IX;.01;.1I;.5;94;@;FIDI","","","",FBCONT,"E","","","")
 F  S IEN=$O(@FBRET@("ID",IEN)) Q:'IEN  D
 . ; Added $G to the entries below (error reported in San Antonio and Dallas ) fixed with patch DSIF*3.2*1
 . S @FBOUT@(IEN)=^TMP("DILIST",$J,2,IEN)_U_$G(@FBRET@("ID",IEN,.01))_U_$G(@FBRET@("ID",IEN,.1))_U_$G(@FBRET@("ID",IEN,.5))_U_$G(@FBRET@("ID",IEN,94))
 . S CNT=IEN
 K @FBRET
 S @FBOUT@(0)=1_U_CNT
 Q
DISP(FBOUT) ;RPC: DSIF INP DISP DISPLAY
 ;Used to show Dispositions (FBCHSTA)
 ;"PENDING 7078's display
 ;OUTPUT= @FBOUT@(CNT)=('++' indicates LOS > 10 days)^Veteran^Vendor^Admission Date
 S FBOUT=$NA(^TMP($J,"DSIFINP0")) K @FBOUT
 N CNT,FBAD,FBDT,FBDUZ,FBTYPE,FBVEN,FBVET,I,J,POP,Q,Y,FBFLG,FBSW,X,X1,X2
EN D DT^DICRW S FBDT=DT,FBSW=1,CNT=0
 F I=FBDT:0 S I=$O(^FB7078("AD",6,I)) Q:I'>0  F J=0:0 S J=$O(^FB7078("AD",6,I,J)) Q:J'>0  D TRANS
 I $D(^FB7078("AC","I")) F I=0:0 S I=$O(^FB7078("AC","I",I)) Q:I'>0  F J=0:0 S J=$O(^FB7078("AC","I",I,J)) Q:J'>0  D TRANS
END S:CNT'>0 @FBOUT@(0)="1^"_$S($D(^XUSEC("FBAASUPERVISOR",DUZ)):"There are ",1:"You have ")_"no inpatients pending disposition." K CNT,FBAD,FBDT,FBDUZ,FBTYPE,FBVEN,FBVET,I,J,POP,Q,Y,FBFLG Q
TRANS S Y(0)=^FB7078(J,0) Q:$P(Y(0),"^",9)="DC"
 S (DFN,FBVET)=$P(Y(0),"^",3) D DEM^VADPT S FBVET=$G(VADM(1)),FBVEN=$P(Y(0),"^",2),FBVEN=$P(FBVEN,";"),FBAD=$P(Y(0),"^",4),FBDUZ=$P(Y(0),"^",8),FBTYPE=$P(Y(0),"^",11) D KVAR^VADPT
 Q:FBTYPE'=6
 Q:DUZ'=FBDUZ&('$D(^XUSEC("FBAASUPERVISOR",DUZ)))
 S FBVEN=$S($D(^FBAAV(FBVEN)):$P(^FBAAV(FBVEN,0),"^",1),1:"UNKNOWN")
 S X1=FBDT,X2=FBAD D D^%DTC
 S FBFLG=$S(X>10:"++",1:""),Y=FBAD D PDF^FBAAUTL S FBAD=Y
 S @FBOUT@(CNT)=FBFLG_U_FBVET_U_FBVEN_U_FBAD
 S CNT=CNT+1 Q
 ;
GETNOTES(FBOUT,DFN) ; RPC:  DSIF INP GET NOTIFICATIONS
 ; Pass in Patient IEN (DFN)
 ; Output:  ^TMP($J,"DSIFINP0",0)=1^record count (or) -1^error
 ; ^TMP($J,"DSIFINP0",n)=Notification IEN^(#.01)DATE/TIME(I;E)^ (#1)VENDOR(I;E)^(#2)WHO CALLED^(#3.5)DATE/TIME OF 
 ;    ADMISSION(I;E)^(#4)AUTHORIZED FROM DATE/TIME(I;E)^(#5) ADMITTING DIAGNOSIS^(#6)ATTENDING PHYSICIAN^(#6.5) ATTENDING PHONE^(#8)LEGAL 
 ;    ENTITLEMENT^(#11)MEDICAL ENTITLEMENT^(#16)ASSOCIATED 7078(I;E;Status)^(#100)REQUEST STATUS^(#7)User who entered (I;E)
 ;            ^Type  of contact^FCP^Suspend code^(#17) Referring Provider  (#17 - Added with DSIF*3.2*1)
 ; ^TMP($J,DSIFINP0",n,nn)="Suspdesc"^IEN^(#15)DESCRIPTION OF SUSPENSION (wp field)
 N DSIEN,LIST,SUSP,MSG,CNT,DATA,SUSD,J,I,FILE,FIELDS,ARR,ERR,VAL,OUT,FCP,STANUM,ARR1,ERR1
 S FBOUT=$NA(^TMP($J,"DSIFINP0")),CNT=0
 K ^TMP($J,"DSIFINP0"),^TMP("DILIST",$J),^TMP("DIERR",$J)
 I '$D(^FBAA(162.2,"D",DFN)) S @FBOUT@(0)="0^No records for this patient" Q
 S FILE=162.2,FIELDS=".01;1;2;3.5;4;5;6;6.5;8;11;14;15;16;100;14;7;17;@",LIST="^TMP(""DILIST"",$J)"
 D STATION^FBAAUTL S STANUM=$$STA^XUAF4($P($G(FBSITE(1)),U,3))
 F DSIEN=0:0 S DSIEN=$O(^FBAA(162.2,"D",DFN,DSIEN)) Q:'DSIEN  D GETS^DIQ(FILE,DSIEN_",",.FIELDS,"IE",.LIST,"MSG") D
 . K DATA S DATA=$NA(^TMP("DILIST",$J,FILE)),J=DSIEN_","
 . N ROC,TOC  S (ROC,TOC)="" ; Get Type of contact from file 161.5 using the "B" cross reference
 . S ROC=DSIEN I ROC S ROC=$O(^FBAA(161.5,"B",ROC,"")) I ROC S TOC=$P(^FBAA(161.5,ROC,0),U,6)
 . S @FBOUT@(+J)=+J_U_$G(@DATA@(J,.01,"I"))_";"_$G(@DATA@(J,.01,"E"))_U_$G(@DATA@(J,1,"I"))_";"_$G(@DATA@(J,1,"E"))
 . S @FBOUT@(+J)=@FBOUT@(+J)_U_$G(@DATA@(J,2,"E"))_U_$G(@DATA@(J,3.5,"I"))_";"_$G(@DATA@(J,3.5,"E"))_U_$G(@DATA@(J,4,"I"))_";"_$G(@DATA@(J,4,"E"))_U_$G(@DATA@(J,5,"E"))_U_$G(@DATA@(J,6,"E"))
 . S @FBOUT@(+J)=@FBOUT@(+J)_U_$G(@DATA@(J,6.5,"E"))_U_$G(@DATA@(J,8,"E"))_U_$G(@DATA@(J,11,"E"))_U_$G(@DATA@(J,16,"I"))_";"_$G(@DATA@(J,16,"E"))
 . S VAL="",VAL=STANUM_"-"_$P($G(@DATA@(J,16,"E")),".") I $P(VAL,"-")'="" D FIND^DIC(442,"","@;1;IX","M",.VAL,1,"B","","","OUT") S FCP=$P($G(OUT("DILIST","ID",1,1))," ")
 . I $G(@DATA@(J,16,"I")) S @FBOUT@(+J)=@FBOUT@(+J)_";"_$$GET1^DIQ(162.4,$G(@DATA@(J,16,"I")),9)
 . S @FBOUT@(+J)=@FBOUT@(+J)_U_$G(@DATA@(J,100,"E"))_U_$G(@DATA@(J,7,"I"))_";"_$G(@DATA@(J,7,"E"))_U_TOC
 . S @FBOUT@(+J)=@FBOUT@(+J)_U_$G(FCP)_U_$G(@DATA@(J,14,"I"))_U_$G(@DATA@(J,17,"I"))_";"_$G(@DATA@(J,17,"E"))  ;#17 added with DSIF*3.2*1
 . I $D(^FBAA(162.2,+J,1,0)) F I=1:1:$P(^FBAA(162.2,+J,1,0),U,3) S @FBOUT@(+J,I)="Susdesc^"_I_"^"_$$GET1^DIQ(162.215,I_","_+J_",",".01","I","ARR1","ERR1")
 . S CNT=CNT+1
 I '$D(^TMP($J,"DSIFINP0")) S @FBOUT@(0)="0^No records found for this patient" Q
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 S @FBOUT@(0)="1^"_CNT
 Q
GET7078(FBOUT,FBIEN) ; RPC:  DSIF INP GET 7078
 ; Pass in FB7078 IEN (FBIEN)
 ; Output: 1^Reference # (#.01)^Fee program (#.5)^Auth From Date (internal/external, ;-delimited) (#3)
 ; ^Auth To Date (internal/external, ;-delimited) (#4)^Date of Discharge (internal/external, ;-delimited) (#4.5)
 ; ^Admitting Authority (internal/external, ;-delimited) (#5)^Estimated Amount (#6)^User who entered it (internal/external, ;-delimited) (#8)
 ; ^Status (Internal/external, ;-delimited) (#9)^Date of Issue (internal/external, ;-delimited) (#10)
 ; ^Reason for Pending Disposition (internal/external, ;-delimited) (#12)^HERO contract IEN (#.01 in file 161.43);HERO contract number
 ; On error: -1^No record found with that IEN
 ; DSIF*3.2*2 changed this RPC to send individual 7078, instead of a list.
 ;
 N FILE,FLD,I,IEN,PAT,RES,ERR S FBOUT="1^"
 I $G(FBIEN)']"" S FBOUT="-1^No IEN is provided" Q
 I '$D(^FB7078(FBIEN,0)) S FBOUT="-1^No record found with that IEN" Q
 S FILE=162.4,FLD="**",IEN=""
 D GETS^DIQ(FILE,FBIEN_",",FLD,"IE","RES","ERR")
 F I=.01,.5,3,4,4.5,5,6,8,9,10,12 D
 .S FBOUT=FBOUT_RES(FILE,FBIEN_",",I,"I")_";"_RES(FILE,FBIEN_",",I,"E")_U
 S FBIEN=FBIEN_";FB7078(",PAT=$G(RES(FILE,+FBIEN_",",2,"I"))
 I +PAT>0 S IEN=0,IEN=$O(^FBAAA("AG",FBIEN,PAT,IEN))
 I $G(IEN)]"" S IEN=$P($G(^FBAAA(PAT,1,IEN,0)),U,22)
 I $G(IEN)]"" S FBOUT=FBOUT_IEN_";"_$P($G(^FBAA(161.43,IEN,0)),U)
 Q
