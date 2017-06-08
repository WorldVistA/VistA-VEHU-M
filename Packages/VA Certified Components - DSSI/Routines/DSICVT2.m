DSICVT2 ;DSS/WLC - ADDT'L CALLS FOR APPT RPC ROUTINES ;06/06/2006 14:57
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#  Supported References
 ;-----  ----------------------------------------------
 ; 1906  $$LOOKUP^VSIT
 ; 2056  $$GET1^DIQ
 ; 3869  SDAMA202
 ; 4433  SDAMA301
 ;10061  VADPT
 ;10103  XLFDT
 ;10104  XLFSTR
 ; 
VALL(DSIV,IEN,FMT,SUB,FUN,WITHIEN) ;
 ;  get all visit info from VSIT API
 ;      IEN - required - pointer to VISIT file or Visit ID
 ;      FMT - optional - I, E, or B [B is default]
 ;  WITHIEN - optional - 1 or 0 [default is 1]
 ;            if 1 return @retv@(visitien,fld)
 ;            if 0 return @retv@(fld)
 ;            if CALL from RPC then WITHIEN ignored and set to 0
 ;      SUB - optional - if $g(SUB)]"" return that subscript only
 ;                       else return all VISIT data in RETV
 ;      FUN - optional - 0 or 1 [default 0]
 ;                       if FUN = 1 then extrinsic function
 ;                       else RPC
 ; RETURN:
 ;    Format of @DSIV@() = value [dependent upon FMT]
 ;                    if FMT="I" value = internal
 ;                    if FMT="E" value = external
 ;                    if FMT="B" value = internal ^ external
 ;
 ;    If extrinsic function call [i.e., I '$G(FUN)]
 ;    1. then on error, QUIT -1
 ;    2. I $G(SUB)="" then QUIT IEN
 ;    3. I $G(SUB) QUIT p1^p2^p3...  where
 ;       pn = int val or ext val or (int val ^ ext val) - see FMT
 ;       a. it is the responsibility of the calling program to make
 ;          sure that maximum string length is not exceeded
 ;       b. @DSIV@() will still be set - see WITHIEN
 ;    
 ;    If RPC case, then return
 ;    @DSIV@(1) = -1 if problems encountered
 ;    @DSIV@(#) = field# ^ internal value ^ external value
 ;      where # = 1,2,3,4,5,...
 ;      internal/external values will be present depending upon FMT
 ;
 ;Field# Value        Description
 ;.01     VDT  VISIT/ADMIT DATE&TIME (date) 
 ;.02     CDT  DATE VISIT CREATED (date) 
 ;.03     TYP  TYPE (set) 
 ;.05     PAT  PATIENT NAME (pointer PATIENT file #9000001)
 ;.06     INS  LOC. OF ENCOUNTER (pointer LOCATION file 
 ;            #9999999.06) (IHS file DINUMed to INSTITUTION  file #4) 
 ;.07     SVC  SERVICE CATEGORY (set) 
 ;.08     DSS  DSS ID (pointer to CLINIC STOP file) 
 ;.09     CTR  DEPENDENT ENTRY COUNTER (number) 
 ;.11     DEL  DELETE FLAG (set) 
 ;.12     LNK  PARENT VISIT LINK (pointer VISIT file #9000010) 
 ;.13     MDT  DATE LAST MODIFIED (date) 
 ;.18     COD  CHECK OUT DATE&TIME (date) 
 ;.21     ELG  ELIGIBILITY (pointer ELIGIBILITY CODE file #8) 
 ;.22     LOC  HOSPITAL LOCATION (pointer HOSPITAL LOCATION file #44) 
 ;.23     USR  CREATED BY USER (pointer NEW PERSON file #200) 
 ;.24     OPT  OPTION USED TO CREATE (pointer OPTION file #19) 
 ;.25     PRO  PROTOCOL (pointer PROTOCOL file #101) 
 ;2101    OUT  OUTSIDE LOCATION (free text) 
 ;80001   SC   SERVICE CONNECTED (set) 
 ;80002   AO   AGENT ORANGE EXPOSURE (set) 
 ;80003   IR   IONIZING RADIATION EXPOSURE (set) 
 ;80004   EC   PERSIAN GULF EXPOSURE (set) 
 ;80005   MST   MILITARY SEXUAL TRAUMA (set) 
 ;80006   HNC   HEAD AND NECK CANCER (set) 
 ;15001   VID  VISIT ID (free text) 
 ;15002   IO   PATIENT STATUS IN/OUT (set) 
 ;15003   PRI  ENCOUNTER TYPE (set) 
 ;81101   COM  COMMENTS 
 ;81202   PKG  PACKAGE (pointer PACKAGE file #9.4) 
 ;81203   SOR  DATA SOURCE (pointer PCE DATA SOURCE file (#839.7)
 ;
 N I,X,Y,Z,RET,VAL,VIEN,VSIT
 S FUN=$G(FUN),FMT=$G(FMT,"B"),IEN=$G(IEN)
 S WITHIEN=+$G(WITHIEN) S:'FUN WITHIEN=0
 I 'IEN S @DSIV@(1)="-1^No VISIT lookup value received" Q:FUN -1  Q
 ;  lookup^vsit returns VSIT()
 S VIEN=$$LOOKUP^VSIT(IEN,FMT,WITHIEN)
 S X="-1^Problems encountered trying to retrieve VISIT: "_IEN
 I VIEN<1!'$D(VSIT) S @DSIV@(1)=X Q:FUN X Q
 ;  return values for extrinsic function
 I FUN M DSIV=VSIT D  Q RET
 .I $G(SUB)="" S RET=IEN Q
 .S RET="" F I=1:1 S X=$P(SUB,U,I) Q:X=""  D
 ..S Y=$S(WITHIEN:$G(VSIT(IEN,X)),1:$G(VSIT(X)))
 ..I FMT="E" S Y=$P(Y,U,2)
 ..I $L(RET)+$L(Y)<501 S RET=RET_U_Y
 ..Q
 .Q
 ;  return values for RPC call
 K Z I $G(SUB)'="" F I=1:1 S X=$P(SUB,U,I) Q:X=""  S Z(X)=""
 ;  return specific data requested
 S Y=0 F I=0:0 S I=$O(VSIT(I)) Q:'I  I $G(SUB)=""!$D(Z(I)) S Y=Y+1,DSIV(Y)=I_U_VSIT(I)
 Q
 ;
ADM(DFN) ;  return current admission data
 ;
 ;  return 1^p2^p3^p4^p5^p6^p7 where
 ;    p2 = external date.time
 ;    p3 = external location
 ;    p4 = internal date.time
 ;    p5 = internal ptr to 44
 ;    p6 = external current location
 ;    p7 = internal current ptr to 44
 ;    if invalid dfn return -1^error message
 ;    if not an inpatient, return 0^Not currently admitted
 ;
 N X,Y,Z,AWARD,CWARD,DIERR,ERR,HOS,RET,VAERR,VAIP,VAROOT
 S X=$$GET^DSICDPT1(+$G(DFN)) I X<1 Q X ;  invalid dfn
 S VAROOT="HOS",VAIP("D")=$$NOW^XLFDT D IN5^VADPT
 I '$G(HOS(13,1)) Q "0^Not currently admitted"
 ;  admission date.time int^ext
 S RET=1,$P(RET,U,2)=$P(HOS(13,1),U,2),$P(RET,U,4)=$P(HOS(13,1),U)
 S X=$G(HOS(5)) ;  current loc
 S $P(RET,U,6)=$P(X,U,2)
 S Z=$$GET1^DIQ(42,+X_",",44,"I",,"ERR") S:'$D(DIERR) $P(RET,U,7)=Z
 S X=HOS(13,4) ;   admission loc
 S $P(RET,U,3)=$P(X,U,2) K DIERR,ERR
 S Z=$$GET1^DIQ(42,+X_",",44,"I",,"ERR") S:'$D(DIERR) $P(RET,U,5)=Z
 Q RET
 ;
APPL(DSIC,SDT,EDT,DATA) ;
 ; get all scheduled appts for one or more clinics
 ; INPUT:
 ;    SDT:     Start date in FM format, default = TODAY (Optional)
 ;    EDT:     End date in FMN format, default = TODAY +6 (Optional)
 ;    DATA():  passed by reference where DATA(n) = code ^ value
 ;    CODE    VALUE
 ;    ------  ------------------------------------------------------
 ;    C       clinic lookup value [name, IFN, or any lookup value]
 ;            - only exact matches accepted.
 ;    S       3-digit Stop Code
 ;    FI      1 or 0, default is 0
 ;            - if 1, then filter out 'Checked In' appts
 ;    F0      1 or 0, default is 0
 ;            - if 1, then filter out 'Checked Out' appts
 ;            
 ; OUTPUT:
 ;       Return @DSIC@(n) = visit IFN^date.time^loc^patient^ssn^division^check-in user^check-out user
 ;       where P2 - P8 is internal IEN;external value        
 ;       data will be sorted by location name, then date.time
 ;       
 N I,J,K,X,Y,Z,ASSN,CLIN,CNT,D0,D1,DATE,DFN,LIST,SSN,STOP,TMP
 N DSII,DSI0,DSIC1,DSIC0,DSIT,INPUT
 N ARRAY K ARRAY
 S DSIC=$NA(^TMP("VEJD",$J)) K @DSIC
 I $O(DATA(""))="" S @DSIC@(1)=$$ERR^DSICVT3(1) Q
 S:'$G(SDT) SDT=DT S SDT=$$FMADD^XLFDT(SDT,,,-1)
 S:'$G(EDT) EDT=$$FMADD^XLFDT(DT,60) S EDT=$$FMADD^XLFDT(EDT,,23,59)
 S (DSIC0,DSIC1)=0
 ; check data() for valid inputs
 S I="",CNT=1 F  S I=$O(DATA(I)) Q:I=""  S Z=DATA(I) D
 . S X=$P(Z,U),Y=$P(Z,U,2) Q:X=""!(Y="")
 . I X?.E1L.E S X=$$UP^XLFSTR(X)
 . I $E(X)="S" D
 . . N DSIT
 . . S INPUT(1)="FILE^40.7",INPUT(2)="INDEX^C",INPUT(3)="VAL^"_Y
 . . D FIND^DSICFM(.DSIT,.INPUT)
 . . S STOP(CNT)=Y,CNT=CNT+1
 . I X="F0",Y>0 S DSIC0=1
 . I X="FI",Y>0 S DSIC1=1
 . Q:'$E(X)="C"
 . K TMP D LOC^DSICVT3(.TMP,Y)
 . I TMP>0 S LIST(+TMP)=$P(TMP,U)_";"_$P(TMP,U,2)_U_$P(TMP,U,5)
 I $D(STOP) D
 . K TMP D CLST^DSICVT3(.TMP,.STOP)
 . I $D(TMP) D
 . . Q:+TMP($O(TMP("")))<0
 . . S Y="" F  S Y=$O(TMP(Y)) Q:Y=""  S LIST(+TMP(Y))=$P(TMP(Y),U)_";"_$P(TMP(Y),U,2)_U_$P(TMP(Y),U,5)
 I $D(LIST) D
 . S (I,CNT)=0 F  S I=$O(LIST(I)) Q:'I  D
 . . S ARRAY("FLDS")="1;2;3;4;9;11;30;31",ARRAY(1)=SDT_";"_EDT,ARRAY(2)=+LIST(I),ARRAY(3)="R;I;NT"
 . . S J=SDT,CLIN=LIST(I),CLIN(0)=$P($P(CLIN,U),";",2)_"~"_(+CLIN)_"~"
 . . N RES,FLG,SCR
 . . S RES=$$SDAPI^SDAMA301(.ARRAY)  ; D GETPLIST^SDAMA202(+CLIN,"1;2;3;4;9;11","R;NT",SDT,EDT,.RES,"")
 . . ;I RES<0 D  Q
 . . ;. N ERRN
 . . ;. S ERRN=$O(^TMP($J,"SDAMA301",0))
 . . ;. S @DSIC@(1)="-1"_U_$G(^TMP($J,"SDAMA301",ERRN))
 . . S FLG=0
 . . I RES>0 D  Q:'FLG
 . . . N CLN,DSIN,DATE,DSIII,DSIIO,SDAPT,SDAPT0,TMP
 . . . S CLN=$O(^TMP($J,"SDAMA301",""))
 . . . S DSIN="" F  S DSIN=$O(^TMP($J,"SDAMA301",CLN,DSIN)) Q:'DSIN  D
 . . . . S DATE="" F  S DATE=$O(^TMP($J,"SDAMA301",CLN,DSIN,DATE)) Q:'DATE  D
 . . . . . N CKOU,CKIU
 . . . . . S SDAPT=$G(^TMP($J,"SDAMA301",CLN,DSIN,DATE))
 . . . . . S SDAPT0=$G(^TMP($J,"SDAMA301",CLN,DSIN,DATE,0))  ; added in SD*5.3*508
 . . . . . S DFN=+$P(SDAPT,U,4) Q:'DFN
 . . . . . S DSIII=$S($P(SDAPT,U,9):1,1:0)  ; check-in status
 . . . . . S DSIIO=$S($P(SDAPT,U,11):1,1:0)  ; check-out status
 . . . . . S CKIU=$P(SDAPT0,U,3)  ; check-in user
 . . . . . S CKOU=$P(SDAPT0,U,4)  ; check-out user
 . . . . . ;9/13/2005 - SGM - check for filters
 . . . . . I DSIC0,DSIIO Q  ;      ck'd out
 . . . . . I DSIC1,DSIII+DSIIO Q  ; ck'd in
 . . . . . S D0=DFN,D1=DATE N I,J,K,LIST
 . . . . . S Y=$$GET^DSICDPT1(DFN),Z=(+Y)_";"_$P(Y,U,2)_U_$P(Y,U,3)
 . . . . . K ^TMP("DSICVT2",$J) M ^TMP("DSICVT2",$J)=^TMP($J,"SDAMA301")
 . . . . . S TMP=$$GV^DSICVT3(D0,D1)_U_DATE_";"_$$FMTE^XLFDT(DATE,"5PZ")_U_$P(CLIN,U)_U_Z_U_$P(CLIN,U,2)_U_CKIU_U_CKOU
 . . . . . M ^TMP($J,"SDAMA301")=^TMP("DSICVT2",$J) K ^TMP("DSICVT2",$J)
 . . . . . S FLG=1,CNT=CNT+1,@DSIC@(CLIN(0),+DATE,CNT)=TMP
 . K ^TMP($J,"SDAMA301")
 I '$D(@DSIC) S @DSIC@(1)=$$ERR^DSICVT3(2)
 Q
 ;
