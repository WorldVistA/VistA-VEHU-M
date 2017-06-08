DSIFENA4 ;DSS/RED - RPC FOR FEE BASIS ;08/09/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2056  GETS^DIQ
 ; 10000  NOW^%DTC
 ; 10089  ^%ZISC
 ; 10063  ^%ZTLOAD
 ;  5272  ^FBAAA
 ;  5278  ^FBAAV
 ; 10000  NOW^%DTC
 ;  
 ; Routine for API used in Fee Basis to print Authorizations RPC's:
 Q  ;; no direct calls to routine
PRINT(OUT,DFN,AUTHNUM,DEV) ; RPC - DSIF PRINT 7079
 N NOW,%,FBPOP,FBJ,VAL,FBK,FBPG,FBSITE,ZL,ZTQUEUED,PATH,POP,UL,ZTIO,ZTREQ
 I 'DFN!('AUTHNUM) S OUT="-1^Invalid input parameter" Q
 S FBPOP=0,FBSITE(0)=$G(^FBAA(161.4,1,0)) S:FBSITE(0)']"" FBPOP=1
 S FBSITE(1)=$G(^FBAA(161.4,1,1)) S:FBSITE(1)']"" FBPOP=1
 I FBPOP S OUT="-1^Fee Basis Site Parameters must be entered to proceed" Q
 S FBK=AUTHNUM,POP=0,UL="",$P(UL,"-",120)="-",FBPG=0
 I '$D(^FBAAA(DFN,1,FBK,0)) S OUT="-1^Not a valid Authorization number" Q
 ; setup taskman parameters
 D NOW^%DTC S NOW=% S:'$D(DT) DT=%
 S FBJ=DT,VAR="DFN^FBK^FBJ",VAL=DFN_"^"_FBJ_"^"_FBK,PGM="GOT^FBAA79"
 S ZTREQ="@"
 S ZTRTN=PGM,ZTSAVE("DFN")=DFN,ZTSAVE("FBK")=FBK,ZTSAVE("QUEUE")=NOW,ZTSAVE("FBPG")=FBPG
 S ZTSAVE("FBSITE(0)")=FBSITE(0),ZTSAVE("FBSITE(1)")=FBSITE(1),ZTSAVE("UL")=UL,ZTSAVE("FBJ")=FBJ
 S ZTSAVE("VAR")=VAR,ZTSAVE("VAL")=VAL,ZTIO=DEV,ZTDTH=NOW,ZTDESC="DSIFENA4 - FB 7079 print"
 D ^%ZTLOAD I $D(ZTSK) S OUT="1^Request queued to device: "_DEV_", Task #: "_$G(ZTSK)
 S:'$D(ZTSK) OUT="-1^Error creating task."
 I '$D(ZTQUEUED) D ^%ZISC
 K IOP,ZTDESC,ZTRTN,ZTSAVE,ZTDTH,ZTSK,ZTSAVE,ZTRTN,VAR,VAL,PGM,FBPOP,POP
 Q
ALL ; (Need to add functionality to print all unprinted 7079's for a patient)
 ;S FBZZ(0)=^(0),J=$P(FBZZ(0),"^",13)
 ;S J=$S(J=1:$P(FBZZ(0),"^"),J=2:$P(FBZZ(0),"^"),J=3:$S($D(^FBAAA(DFN,4)):$P(^(4),"^",2),1:$P(FBZZ(0),"^")),1:$P(FBZZ(0),"^")) K FBZZ
 Q
VENDOR(DSIFOUT,LOOKUP) ;RPC DSIF VENDOR LOOK
 ;Input: last 4 of vendor ID
 ; Now screens out entries with 1st piece of ^FBAAV(IEN,"ADEL") (If "Y" Austin delete flag)
 ; Output(0)=1^count 
 ; Output(n)=IEN^Name^ID #^Street address^Street Address 2^City^State^Zip^Type of vendor^Speciality Code^Exempt from vendor flag^ 
 ;  Date Last Update From Austin^Pricer Exempt^Taxonomy Code
 I LOOKUP'?4N S DSIFOUT(0)=0,DSIFOUT(1)="-1^Not a valid entry, please enter 4 characters" Q
 K DSIFOUT,DSIFARR N I,LEN,FIND,CNT,CONV,IEN,IENS,LIST S I="",CNT=0
 F  S I=$O(^FBAAV("C",I)) Q:I=""  D
 . ;S CONV=$TR(I,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","")
 . ;S LEN=$L(CONV),FIND=$E(CONV,LEN-3,LEN)
 . S FIND=$E(I,6,9)
 . I FIND=LOOKUP D
 . . F IEN=0:0 S IEN=$O(^FBAAV("C",I,IEN)) Q:IEN<1  D
 . . . I $P($G(^FBAAV(IEN,"ADEL")),U)="Y" Q    ; Austin delete flag set to Yes
 . . . S CNT=CNT+1 D GETS^DIQ(161.2,IEN,".01;1;2;2.5;3;4;5;6;12.1;.05;42","IE","LIST","MSG")
 . . . K ARRAY S IENS=IEN_"," M ARRAY=LIST(161.2,IENS)
 . . . S DSIFOUT(CNT)=IEN_U_$G(ARRAY(.01,"E"))_U_$G(ARRAY(1,"E"))_U_$G(ARRAY(2,"E"))_U_$G(ARRAY(2.5,"E"))
 . . . S DSIFOUT(CNT)=DSIFOUT(CNT)_U_$G(ARRAY(3,"E"))_U_$G(ARRAY(4,"E"))_U_$G(ARRAY(5,"E"))_U_$G(ARRAY(6,"E")) ; DSIF*3.2*2 broke up a line (length)
 . . . S DSIFOUT(CNT)=DSIFOUT(CNT)_U_$G(ARRAY(.05,"E"))_U_U_$G(ARRAY(12.1,"E"))_U_$P($G(^FBAAV(IEN,"AMS")),U,2)_U_$G(ARRAY(42,"E")) ;DSIF*3.2*2 added new field TAXONOMY CODE(#42)
 I '$D(DSIFOUT) S DSIFOUT="-1^No entries found" Q
 S DSIFOUT(0)="1^"_CNT
 Q
SEARCH(DSIFFB,FRDT,TODATE) ; RPC: DSIF SEARCH
 ;Input FROMDT (Beginning date - mandatory), TODT (End date - optional)
 ;Output:  (same as DSIF AUTHLIST)
 ; ;   Authorization^AUTHIEN^1^LINE^To date^from date^Vendor^Primary Service Facility^Purpose of visit code
 ;   ^Patient type code^treatment type
 ;   (or) Authorization^-1^Not a Fee Basis Patient (or) Authorization^-1^Invalid Patient selection
 ;   Authorization^AUTHIEN^2^LINE^DX line 1^DX line 2^DX line 3^Type of Care^Accident related^Potentail cost recovery^Clerk
 ;   Authorization^AUTHIEN^3^LINE^DFN;Patient name^SSN;SSN (formatted)^Fee ID Card#^Card Issue date
 ;   Authorization^AUTHIEN^4^Supplemental^Evaluation type^Description of care^# of visits^est cost^IEN requesting provider^# visits text^Consult IEN
 ;   Authorization^AUTHIEN^n^Remark^{remark 1} Authorization IEN Remark n={remark 2}
 K DSIFFB N CNT,DFN,AUTHIEN,TODT
 I $G(FRDT)']"" S DSIFFB(1)="-1^No date passed into search" Q
 I $G(FRDT)'?7N S DSIFFB(1)="-1^Not a valid date" Q
 S FRDT=FRDT-1,CNT=0 I $G(TODATE)']"" S TODT="A",TODATE=3991231
 F  S FRDT=$O(^FBAAA("ATST",FRDT)) Q:FRDT<1  D
 . S DFN=$O(^FBAAA("ATST",FRDT,"")),AUTHIEN=$O(^FBAAA("ATST",FRDT,DFN,""))
 . S TODT=$P(^FBAAA(DFN,1,AUTHIEN,0),U,2) Q:TODT>TODATE
 . D GET^DSIFENA2
 I '$D(DSIFFB(1)) S DSIFFB(1)="-1^No Authorizations found for this date range" Q
 Q
