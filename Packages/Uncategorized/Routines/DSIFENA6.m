DSIFENA6 ;DSS/RED - RPC FOR FEE BASIS ;10/11/2007 7:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API's used in Fee Basis to View Authorization RPC's:
 ;
 ; Integration Agreements
 ;  2051  LIST^DIC
 ;  2056  GETS^DIQ
 ;  2171 - $$STA^XUAF4
 ;  5090  SITEP^FBAAUTL
 ; 10000  NOW^%DTC
 ; 10089  ^%ZISC
 ; 10063  ^%ZTLOAD
 ; 10061  DEM^VADPT,KVAR^VADPT
 ;  5403  ^FBAA(161.82
 ;  5275  ^FBAA(161.4
 ;  5104  ^FB7078
 ;  2056  GETS^DIQ
 ;
 Q  ; Routine cannot be called directly, must use calling points
AUTH(FBOUT,DFN,AUTHIEN) ;  RPC:  DSIF AUTH DISPLAY
 ;  Output:  ^TMP($J,"DSIFENA6",0)="Auth"^Patient(I;E)^AuthIEN^From date (I;E)^To date (I;E)
 ;                                           ,field)=field number^value (I;E)
 K FBOUT,^TMP($J,"DSIFENA6") S FBOUT=$NA(^TMP($J,"DSIFENA6"))
 N MSG,I,FILE,DATA,IENS,FIELDS,FLAGS,TARGET,NAM S:$G(U)="" U="^"
 D DEM^VADPT I VADM(1)="" S @FBOUT@(0)="-1^Invalid Patient selection" D KVAR^VADPT Q
 S NAM=VADM(1) D KVAR^VADPT
 I '$D(^FBAAA(DFN,0)) S @FBOUT@(0)="-1^Not a Fee Basis Patient" Q
 ; Retrieve all data for the Auth 
 S IENS=AUTHIEN_","_DFN_",",TARGET=$NA(^TMP("LIST",$J)),FILE=161.01,FIELDS="**",FLAGS="IE"
 D GETS^DIQ(FILE,IENS,FIELDS,FLAGS,TARGET,"MSG") S TARGET=$NA(^TMP("LIST",$J,FILE,IENS))
 I $D(MSG) S @FBOUT@(0)=-1_U_DFN_";"_AUTHIEN_U_"Invalid auth for this Pt" Q
 N I F I=0:0 S I=$O(@TARGET@(I)) Q:'I  D
 . I I=.01!(I=.02) Q   ;Do not build from and to dates, displayed on the zero node
 . ; Skip empty nodes/fields
 . K ARRAY,J I I=.021 D GETS^DIQ(FILE,IENS,".021","","ARRAY","MSG") Q:$D(MSG)  S DATA=$NA(ARRAY(FILE,IENS,.021)) D
 . . F J=0:0 S J=$O(@DATA@(J)) Q:'J  S @FBOUT@(.021,J)=.021_U_J_U_@DATA@(J)
 . Q:I=.021
 . I I=.07,$D(@TARGET@(I,"I")) S @FBOUT@(I)=I_U_@TARGET@(I,"I")_";"_$P($G(^FBAA(161.82,@TARGET@(.07,"I"),0)),U,3)_";"_@TARGET@(I,"E") Q
 . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")'=@TARGET@(I,"E")) S @FBOUT@(I)=I_U_@TARGET@(I,"I")_";"_@TARGET@(I,"E")
 . I @TARGET@(I,"I")]"",(@TARGET@(I,"I")=@TARGET@(I,"E")) S @FBOUT@(I)=I_U_@TARGET@(I,"I")
 . I I=105,@TARGET@(I,"I")]"" S @FBOUT@(I)=I_U_@TARGET@(I,"I")_";"_@TARGET@(I,"E") ; DSIF*3.2*2 display contract
 I '$D(^TMP("LIST",$J)) S @FBOUT@(0)=-1_U_DFN_";"_$G(NAM)_U_AUTHIEN_U_"Invalid auth for this Pt" Q
 S @FBOUT@(0)="Auth"_U_DFN_";"_$G(NAM)_U_AUTHIEN_U_@TARGET@(.01,"I")_";"_@TARGET@(.01,"E")_U_@TARGET@(.02,"I")_";"_@TARGET@(.02,"E")
 K ^TMP("LIST",$J)
 Q
GETVAL(FBOUT,DFN) ;RPC:  DSIF INP 7078 VAL
 ; Input: Patient IEN
 ; Output: ^TMP($J,"DSIFENA6",0)=1 (or -1)^Name of Approving official^Title^# Copies
 ;                                         ,n)=7078 IEN;Reference #^Vendor (I;E)^Auth from date(I;E)^Est. Amount
 ; Used to get values for print 7078
 N DATA,SCREEN,PART K ^TMP($J,"DSIFENA6"),^TMP("DILIST",$J)
 S FBOUT=$NA(^TMP($J,"DSIFENA6"))
 I '$D(^FB7078("D",DFN)) S @FBOUT@(0)="-1^There are no 7078's found for this patient." Q
 D DEM^VADPT I VADM(1)="" S @FBOUT@(0)="-1^Invalid patient selected." D KVAR^VADPT Q
 S SCREEN="I $P(^DPT(DFN,0),U,9)'=""DC""",PART=$G(VADM(1))
 D LIST^DIC(162.4,"",".01;1I;3IE;6","P","","",.PART,"D",.SCREEN,"","","MSG") S DATA=$NA(^TMP("DILIST",$J))
 N I S I=0 F  S I=$O(@DATA@(I)) Q:'I  D
 . S @FBOUT@(I)=$P(@DATA@(I,0),U)_";"_$P(@DATA@(I,0),U,3)_U_$P(@DATA@(I,0),U,4)_U_$P(@DATA@(I,0),U,5)_";"_$P(@DATA@(I,0),U,6)_U_$P(@DATA@(I,0),U,7)
 . S $P(@FBOUT@(I),U,2)=+$P(@FBOUT@(I),U,2)_";"_$P($G(^FBAAV($P($P(@FBOUT@(1),U,2),";"),0)),U)
 D SITEP^FBAAUTL S FBO=$S($D(FBSITE(1)):$P(FBSITE(1),"^",7),1:""),FBNUM=$S($D(FBSITE(1)):$P(FBSITE(1),"^",5),1:"")
 S FBT=$S($D(FBSITE(1)):$P(FBSITE(1),"^",8),1:""),@FBOUT@(0)=1_U_FBO_U_FBT_U_FBNUM
 K ^TMP("DILIST",$J)
 Q
PRT7078(RETURN,FB7078,DEV,FBNUM) ;RPC: DSIF INP 7078 PRT
 ;INPUT:  FB7078=IEN OF 7078, DEV=VistA print device (not the IEN of the VistA device)
 ;RETURN: 1^Successfully queued^Task  (or) -1^error message
 N NOW,%,FBPOP,VAL,FBK,FBPG,FBSITE,ZL,ZTQUEUED,PATH,POP,UL,ZTIO,ZTREQ
 S POP=0,UL="",$P(UL,"-",120)="-",FBPG=0
 I 'FB7078!($G(DEV)="") S RETURN="-1^Invalid input parameter" Q
 S FBPOP=0,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=1
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=1
 I FBPOP S RETURN="-1^Fee Basis Site Parameters must be entered to proceed." Q
 I '$D(^FB7078(FB7078,0)) S RETURN="-1^Not a valid 7078 number." Q
 S FB(0)=$G(^FB7078(FB7078,0))
 ; setup taskman parameters
 D NOW^%DTC S NOW=% S:'$D(DT) DT=%
 S ZTREQ="@",FBO=$S($D(FBSITE(1)):$P(FBSITE(1),"^",7),1:"")
 I $G(FBNUM)<1 S FBNUM=$S($D(FBSITE(1)):$P(FBSITE(1),"^",5),1:"1")
 S FBT=$S($D(FBSITE(1)):$P(FBSITE(1),"^",8),1:""),FB("SITE")=$$STA^XUAF4($P($G(FBSITE(1)),U,3))
 S VAR="FB7078^FBNUM^FBO^FBT^FB(""SITE"")",VAL=FB7078_"^"_FBNUM_"^"_FBO_"^"_FBT_"^"_FB("SITE"),PGM="START^FBCHP78"
 S ZTRTN=PGM,ZTSAVE("FB7078")=FB7078,ZTSAVE("FBO")=FBO,ZTSAVE("FBNUM")=FBNUM,ZTSAVE("QUEUE")=NOW,ZTSAVE("FBPG")=FBPG
 S ZTSAVE("FBSITE(0)")=FBSITE(0),ZTSAVE("FBSITE(1)")=FBSITE(1),ZTSAVE("FB(""SITE"")")=FB("SITE"),ZTSAVE("FB(0)")=FB(0),ZTSAVE("FBT")=FBT,ZTSAVE("UL")=UL
 S ZTSAVE("VAR")=VAR,ZTSAVE("VAL")=VAL,ZTIO=DEV,ZTDTH=NOW,ZTDESC="DSIFENA5 - FB 7078 print"
 D ^%ZTLOAD I $D(ZTSK) S RETURN="1^Request queued to device: "_DEV_", Task #: "_$G(ZTSK)
 S:'$D(ZTSK) RETURN="-1^Error creating task."
 I '$D(ZTQUEUED) D ^%ZISC
 K IOP,ZTDESC,ZTRTN,ZTSAVE,ZTDTH,ZTSK,ZTSAVE,ZTRTN,VAR,VAL,PGM,FBPOP,POP
 Q
