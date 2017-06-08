DSIFENA1 ;DSS/RED - RPC FOR FEE BASIS ;08/09/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**1,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API's used in Fee Basis to Enter/edit Authorizations RPC's:
 ; 
 ; Integration Agreements
 ;  2051  LIST^DIC
 ;  2052  FIELD^DID
 ;  2056  GETQ^DIQ
 ;  2171  $$NS^XUAF4(IEN)
 ;  4419  $$INSUR^IBBAPI
 ;  4807  RDIS^DGRPDB 
 ; 10003  ^%DT     
 ; 10009  FILE^DICN
 ; 10061  6^VADPT, ELIG^VADPT
 ; 10103  $$FMTE^XLFDT
 ; 
 Q  ; Routine cannot be called directly, must use calling points
VER(DSIFFB,DFN) ;  RPC: DSIF VERIFY FB
 ;    Patient eligibility determination for Fee Basis Authorizations, based on ^FBAAAUT
 ; 1st check Fee Basis Site Parameters
 K DSIFFB
 N X,VERIF,DISHON,AGONG,X,FBPOP,FBSITE,I1,I2,I3,IBDT,IBFLDS,IBR,IBSTAT,AUTHCNT,MEANST,FBPT
 S FBPOP=0,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=1
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=1
 I FBPOP=1 S DSIFFB="-1^Fee Basis Site parameters are not setup yet, quitting" Q
 ; Returns the following string:
 ;  DSIFFB="0 {Not a FB pt} or 1 or -1 {error^msg}^0 {no} or 1 (verified)^Current means test status^0 or 1{DISHON DISCH}^0 or 1{AGENT ORANGE ONLY}^# of Authorizations
 I DFN'?1.20N  S DSIFFB="-1^Invalid input parameter" Q  ;DFN Must be numeric
 D DEM^VADPT I VADM(1)="" S DSIFFB="-1^Invalid PT selection" D KVAR^VADPT Q  ;Pt "0" node doesn't exist
 I '$D(^FBAAA(DFN,0)) S FBPT=0
 I $G(FBPT)="" S FBPT=1
 S MEANST=$$GET1^DIQ(2,DFN_",",.14,"I")_";"_$$GET1^DIQ(2,DFN_",",.14,"") ;to return internal;external
 S (VERIF,DISHON,AGONG)=0  ;New flags, set default to off
 D ELIG^VADPT S VERIF=VAEL(8),VERIF=$S(VERIF="":0,VERIF="R":0,1:1) D KVAR^VADPT  ; Verified or Pending=1; null or Re-verify =0
 ;Check for dishonorable discharge and if Vietnam Era checked, should allow agent orange exam only
 D SVC^VADPT I VASV(6),+VASV(6,3)=2 S DISHON=1 S:VASV(2) AGONG=1 D KVA^VADPT
 S AUTHCNT=$P($G(^FBAAA(DFN,1,0)),U,4) I 'AUTHCNT S AUTHCNT=0
 S DSIFFB=FBPT_U_VERIF_U_MEANST_U_DISHON_U_AGONG_U_AUTHCNT
 Q
ADD(DSIFFB,DFN) ; RPC DSIF ADD PT
 ; Add a patient to Fee Basis (File #161)
 N DA,DD,DO,DINUM,DLAYGO K DSIFFB
 D DEM^VADPT I VADM(1)="" S DSIFFB="-1^ Not a valid patient to add" D KVAR^VADPT Q
 S DA=DFN I '$D(^FBAAA(DA,0)) L +^FBAAA(DA):$S($G(DILOCKTM):DILOCKTM,1:5) I '$T S DSIFFB="-1^Unable to lock file, try again later" Q
 K DD,DO S (X,DINUM)=DA,DIC="^FBAAA(",DIC(0)="LM",DLAYGO=161 D FILE^DICN L -^FBAAA(DFN) K DIC
 S:'$D(^FBAAA(DFN,1,0)) ^(0)="^161.01D^^"
 S:$G(Y)="" Y="0^Already a Fee Basis pt"
 S DSIFFB=Y Q
 ;
DEMOG(DSIFFB,DFN) ;  RPC:  DSIF DEMOG   
 ; OUTPUT FROM API:
 ;  DSIFFB(A;1)=Demographics;1^DFN;Pt Name or -1{error^msg}^SSN^Date of death(without time)^DOB^telephone
 ;  DSIFFB(A;2)=Demographics;2^Address line 1^address line 2^Address line 3^City^State^Zip^County^Primary eligibility code^Verified?
 ;  ^Verified date^Disability %^Health insurance Yes or No^VA Claim Number
 ;  DSIFFB(B{n})=Other eligibilities;n^Other eligibility code
 ;  DSIFFB(C{n})="Rated disabilities;n^disability condition^percentage
 ;  DSIFFB(D{n})="Insurance data;n^Insurance company^Subscriber ID^Group^Holder^Effective date^Expiration date {left blank if none}^Insurance company reimburse
 ;  DSIFFB(D{n}.1)= "Insurance data";CNT_.1^1^ *** Patient has Insurance Buffer entries *
 K DSIFFB
 N DISAB,INS,DGRTN,DGX,I,I1,VADM,VAEL,VAPA,CNT,SCPER,VERDT,DGERR,DGINSDT,DGKVAR,DGQUIT,DGSTAT,INSIEN
 I DFN'?1.N  S DSIFFB("A")="Demographics^-1^Invalid input parameter" Q  ;Must be numeric
 S DSIFFB("A1")="Demographics;1",VAPA("P")="" D 6^VADPT
 I VADM(1)="" S $P(DSIFFB("A1"),U,2)="-1^Invalid Patient selection" Q
 N Y S Y=$$GET1^DIQ(2,DFN,.3612,"I"),VERDT=Y I Y]"" S Y=$$FMTE^XLFDT(Y,1) S VERDT=VERDT_";"_Y
 S SCPER=$P(VAEL(3),U,2) I SCPER'="" S SCPER=SCPER_"%"  ;Service connected percentage
 S DSIFFB("A1")=DSIFFB("A1")_U_DFN_";"_VADM(1)_U_$TR(VADM(2),U,";")_U_$P($TR(VADM(6),U,";"),"@")_U_$TR(VADM(3),U,";")
 S DSIFFB("A1")=DSIFFB("A1")_U_$S(VAPA(8)="":"None",1:VAPA(8))_U_VAPA(1)
 S DSIFFB("A2")="Demographics;2"_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)_U_$P(VAPA(7),U,2)_U_$TR(VAEL(1),U,";")
 S DSIFFB("A2")=DSIFFB("A2")_U_$TR(VAEL(8),U,";")_U_VERDT_U_SCPER
 I $D(VAEL(1))>9 S (I,I1)=0 F  S I=$O(VAEL(1,I)) Q:'I  D
 . S I1=I1+1 S DSIFFB("B"_I1)="Other eligibilities;"_I1_U_$TR(VAEL(1,I),U,";")
 I '$D(VAEL) D ELIG^VADPT S DGKVAR=1
 S INS=$$INSUR^IBBAPI(DFN,$S($D(DGINSDT):DGINSDT,1:DT))
 I $D(INS)!($D(IBR)) D
 . I '$D(DGSTAT) S DGSTAT="RAB"
 . S DGX=$$INSUR^IBBAPI(DFN,"",DGSTAT,.DGRTN,"*") S:DGX<0 DGERR=$O(DGRTN("IBBAPI","INSUR","ERROR",0))
 N CNT I $D(DGRTN("IBBAPI","INSUR")) F CNT=0:0 S CNT=$O(DGRTN("IBBAPI","INSUR",CNT)) Q:CNT<1  D
 . S INSIEN=+DGRTN("IBBAPI","INSUR",CNT,1)
 . S DSIFFB("D"_CNT)="Insurance data;"_CNT_U_$TR(DGRTN("IBBAPI","INSUR",CNT,1),U,";")_U_DGRTN("IBBAPI","INSUR",CNT,14)
 . S DSIFFB("D"_CNT)=DSIFFB("D"_CNT)_U_$G(DGRTN("IBBAPI","INSUR",CNT,18))_U_$TR(DGRTN("IBBAPI","INSUR",CNT,12),U,";")
 . I $D(DGRTN("IBBAPI","INSUR",2,10)) N X,INTDT S X=DGRTN("IBBAPI","INSUR",2,10) D ^%DT S INTDT=Y
 . S DSIFFB("D"_CNT)=DSIFFB("D"_CNT)_U_$G(INTDT)_";"_$TR($$FMTE^XLFDT(DGRTN("IBBAPI","INSUR",CNT,10),"2DF")," ","0")
 . I $D(DGRTN("IBBAPI","INSUR",2,11)) N X,INTDT S X=DGRTN("IBBAPI","INSUR",2,11) D ^%DT S INTDT=Y
 . S DSIFFB("D"_CNT)=DSIFFB("D"_CNT)_U_$G(INTDT)_";"_$TR($$FMTE^XLFDT(DGRTN("IBBAPI","INSUR",CNT,11),"2DF")," ","0")
 .  ;Insurance company reimburse text
 . S $P(DSIFFB("D"_CNT),U,8)=$$GET1^DIQ(36,INSIEN_",",1,"I")
 . I DGRTN("BUFFER")>0 S DSIFFB("D"_CNT_".1")="Insurance data;"_CNT_".1^1^ *** Patient has Insurance Buffer entries ***"
 S DSIFFB("A2")=DSIFFB("A2")_U_$S(INS=1:"Yes",1:"No")_U_$G(VAEL(7))
 N DSIFRD D RDIS^DGRPDB(DFN,.DSIFRD) I $D(DSIFRD) F I=0:0 S I=$O(DSIFRD(I)) Q:'I  D
 .S I1=$P(DSIFRD(I),U),I2=$S($D(^DIC(31,I1,0)):$P(^DIC(31,I1,0),"^",1)_" ("_$P(DSIFRD(I),U,2)_"%-"_$S($P(DSIFRD(I),U,3):"SC",$P(DSIFRD(I),U,3)']"":"not specified",1:"NSC")_")",1:"")
 .S DSIFFB("C"_I)="Rated disabilities;"_I_U_I2
 I 'VAEL(4),$S('$D(^DG(391,+VAEL(6),0)):1,$D(^DG(391,+VAEL(6),0)):0,1:1) S DSIFFB("C1")="Rated disabilities;1^0^Not a Veteran"
 D KVAR^VADPT
 Q
 ;
GETVAL(FBOUT) ;  RPC: DSIF GET FB VALUES
 ; Output:   (Modified to send out put to Global array)
 ;   ^TMP($J,"DSIFENA1","A",n)="Patient type"^.065^IEN^Value   {n=counter}
 ;   ^TMP($J,"DSIFENA1","B",n)="Purpose of visit"^.07^IEN^Value
 ;   [Removed in DSIF*3.2*2] ^TMP($J,"DSIFENA1","C",n)="Primary service area"^101^IEN^Value (Name)^Field 99
 ;   ^TMP($J,"DSIFENA1","D",n)="Treatment type"^.095^IEN^Value
 ;   ^TMP($J,"DSIFENA1","E",n)="Type of care"^2^IEN^Value 
 ;   ^TMP($J,"DSIFENA1","F",n)="Place of service"^353.1^IEN^Name
 ;
 K ^TMP($J,"DSIFENA1"),FBOUT N FBDATA,CNT,I,FIELD,MSG,MSG101
 S FBOUT=$NA(^TMP($J,"DSIFENA1"))
 ; Get the codes from the file the field points to
 S FIELD=".065" D FILL
 N I F I=1:1:($L(FBDATA,U)-1) S @FBOUT@("A",I)="Patient type"_U_FIELD_U_$TR($P($G(FBDATA),U,I),":",U)
 ;  POV List
 K FBDATA,ARRAY,ADAT S CNT=1,I=""
 N ADAT D LIST^DIC(161.82,"","3;.01;4;@","P","","","","C","","","ARRAY","MSG") S ADAT=$NA(ARRAY("DILIST"))
 N I,J S I=0 F  S I=$O(@ADAT@(I)) Q:I<1  D
 . S J=+@ADAT@(I,0)
 . I $L($P(@ADAT@(I,0),U,4))>0 Q  ;Inactive date field
 . S @FBOUT@("B",+J)="Purpose of Visit"_U_".07"_U_$P(@ADAT@(I,0),U)_";"_$P(@ADAT@(I,0),U,2)_U_$P(@ADAT@(I,0),U,3)
 ;  Primary Service Area List  -- Removed this whole section in DSIF*3.2*2
 ;S MSG101=""
 ;K ^TMP("DILIST",$J) D LIST^DIC(4,,".01;99;101;@","MPQ","*",,,,,,,"MSG101")   ;DSIF*3.2*1 changed this to a global array, and screen out inactive institutions
 ;I $D(MSG101("DIERR")) S @FBOUT@("C",0)="-1^Primary Service Area^File #4 retrieval error" M @FBOUT@("C")=MSG101("DIERR",1,"TEXT")
 ;S I=0 F  S I=$O(^TMP("DILIST",$J,I)) Q:'I  S X=^TMP("DILIST",$J,I,0) I $P(X,U,4)'["INACT",$P(X,U)'="",$P(X,U,2)'="" S @FBOUT@("C",$P(X,U))="Primary Service Area"_U_"101"_U_$P(X,U)_U_$P(X,U,2)_U_$P(X,U,3)
 ;K ^TMP("DILIST",$J),I
 ;   Treatment type
 S CNT=1 K FBDATA S FIELD=".095" D FILL
 S I="" F I=1:1:($L(FBDATA,U)-1) S @FBOUT@("D",I)="Treatment Type"_U_FIELD_U_$TR($P($G(FBDATA),U,I),":",U)
 ;  Type of care
 K FBDATA S FIELD="2" D FILL
 S I="" F I=1:1:($L(FBDATA,U)-1) S @FBOUT@("E",I)="Type of Care"_U_FIELD_U_$TR($P($G(FBDATA),U,I),":",U)
 I '$D(^TMP($J,"DSIFENA1")) S @FBOUT@(0)="-1^Error in list creation" Q
 Q
FILL ; Used by RPC - Getval
 Q:'FIELD
 K ROOT D FIELD^DID(161.01,FIELD,"","POINTER","ROOT","MSG")
 I $D(MSG) S @FBOUT@(0)="-1^Message return value error, please call IRM: File 161.01; field - "_FIELD Q
 S FBDATA=$TR(ROOT("POINTER"),";",U)
 Q
