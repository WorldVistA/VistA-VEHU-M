DSIFENA2 ;DSS/RED - RPC FOR FEE BASIS ;08/09/2006 17:18
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**8,2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; Routine for API's used in Fee Basis to Enter/edit Authorizations RPC's:
 ;  
 ; Integration Agreemetns
 ;  2051  FIND^DIC
 ;  2056  GETS^DIQ
 ;  5093  $$PADZ^FBAAV01
 ;  5274  File 442 access
 ;  5328  $$REFNPI^FBCH78
 ; 10061  6^VADPT
 ; 10103  $$FMTE^XLFDT
 ;  5403  ^FBAA(161.82
 ;  5278  ^FBAAV(
 ; 
 Q  ; Routine cannot be called directly, must use calling points
AUTHLIST(DSIFFB,DFN,FLAG,DSIFFDAT,DSIFTDAT) ;  RPC:  DSIF AUTHLIST
 ; DSIF*3.2*8: Added optional input variable DAT for restricting return of records after given date
 ;  "Authorization";(1)^AUTHIEN;(2)^"1";(3)^"LINE";(4)^From date;(5)^To date;(6)^Vendor;(7)^Primary Service Facility;(8)
 ;                      ^Purpose of visit code;(9)^Patient type code;(10)^treatment type;(11)
 ;  "Authorization";(1)^AUTHIEN;(2)^"2";(3)^"Line";(4)^DX1;(5)^DX2;(6)^DX3;(7)^Type of care;(8)^Accident related;(9)
 ;        ^Cost recovery;(10)^clerk;(11)^Fee program;(12)^referring prov;(13)^NPI;(14)^CONTRACT;(15)
 ;  "Authorization";(1)^AUTHIEN;(2)^3;(3)^"LINE";(4)^DFN;Patient name;(5)^SSN;SSN (formatted);(6)^Fee ID Card#;(7)
 ;          ^Card Issue date;(8)^Associated 7078/583;(9)^FCP;(10)^Discharge type;(11)
 ;                                                                             *Note: Associated 7078 and FCP only display if CH auth
 ;         *Fee program: #;FB583(=Unauthorized, #;FB7078(=Inpatient (Civil Hospital), ""=Medical
 ;   Authorization^AUTHIEN^n^Remark^{remark 1} Authorization IEN Remark n={remark 2}
 ;
 ;   (or) Authorization^-1^Not a Fee Basis Patient (or) Invalid Authorization
 K DSIFFB N LIST,MSG,Y,CNT,POP,AUTHIEN,VENDOR,VENPT,FRDT,ARRAY,NEWPER,AUTHCNT,I,REF,VAL,DSIFSTA
 K ^TMP($J,"DSIFENA2") S DSIFFB=$NA(^TMP($J,"DSIFENA2"))
 S (POP,CNT,AUTHCNT)=0,FRDT="A",I=""
 I $G(U)="" S U="^"
 ; Flag values:  0 = Inpatient or Unathorized Only
 ;                    1 = Outpatient only
 ;            2 or "" = All Authorizations
 I $G(FLAG)="" S FLAG=2  ;Default to display both Inpatient and Outpatient Authorizations
 I "012"'[FLAG S @DSIFFB@(0)="-1^Invalid flag, must be 0, 1 or 2" Q
 D DEM^VADPT I VADM(1)="" S @DSIFFB@(0)="-1^Invalid Patient selection" D KVAR^VADPT Q
 I '$D(^FBAAA(DFN,0)) S @DSIFFB@(0)="-1^Not a Fee Basis Patient" Q
 ; Build returned array based on values returned from VADPT, using the "B" cross reference (newest date 1st)
 S FRDT="A" I $G(DSIFTDAT)'="" S FRDT=DSIFTDAT+.1 ;DSIF*3.2*8 added to-date limiter
 F  S FRDT=$O(^FBAAA(DFN,1,"B",FRDT),-1) Q:'FRDT  N AUTHIEN S AUTHIEN="" D 
 . I $G(DSIFFDAT),FRDT<(DSIFFDAT-.1) Q  ;DSIF*3.2*8 added from-date limiter
 . F  S AUTHIEN=$O(^FBAAA(DFN,1,"B",FRDT,AUTHIEN)) Q:AUTHIEN=""  D GET
 I '$D(^TMP($J,"DSIFENA2")) S @DSIFFB@(0)="-1^No authorizations currently exist for this patient!"
 Q
GET ;  Called by RPC's DSIF AUTHLIST and DSIF SEARCH
 ; For ease of troubleshooting build the array with each record a whole number and subsets of that record in .01 increments 
 N IENS,MSG,MSG1,ID,ADAT,DATA,VENPT,VENDOR,LIST,J,IDCARD,POV,FCP,FBNPI
 S CNT=CNT+1,IENS=AUTHIEN_","_DFN_","
 K LIST,MSG,MSG1,IDCARD,ARRAY S VAPA("P")="" D 6^VADPT
 D GETS^DIQ(161,DFN_",",".5;.6","IE","IDCARD","MSG") S ID=$NA(IDCARD(161,DFN_","))
 I $D(MSG) S @DSIFFB@(CNT,0)="-1^File 161 data error for Pt's Auth: "_AUTHIEN Q
 D GETS^DIQ(161.01,IENS,".02;.021;.03;.04;.055;.06;.065;.07;.08;.085;.086;.095;.096;.097;2;100;101;104;105","IE","LIST","MSG1") S ADAT=$NA(LIST(161.01,IENS)) ;DSIF*3.2*2 read contract number from file
 ; Check for POV, if found, get values, DSIF*3.2*2 do a more thorough check and return error message if pointer is invalid
 I $G(@ADAT@(.07,"I"))]"",$D(^FBAA(161.82,+(@ADAT@(.07,"I")),0)) D GETS^DIQ(161.82,@ADAT@(.07,"I")_",","3","E","POV","MSG") S POV=POV(161.82,@ADAT@(.07,"I")_",",3,"E")
 I $G(@ADAT@(.07,"I"))]"",'$D(^FBAA(161.82,+(@ADAT@(.07,"I")),0)) S @DSIFFB@(0)="-1^File 161.01; IENS: "_IENS_"FIELD '.07' is invalid and must be verified/changed" Q
 S:$G(POV)="" POV="" S (FBNPI,FCP)=""
 I FLAG=0,($L($G(@ADAT@(.055,"I")))>0) Q
 I FLAG=1,($L($G(@ADAT@(.055,"I")))<1) Q
 S VENPT=$G(@ADAT@(.04,"I")),VENDOR=$S('VENPT:"Not Specified",$D(^FBAAV(VENPT,0)):$P(^(0),"^")_" - "_$P(^(0),"^",2),1:"")
 I $G(VENDOR)="" S VENPT="",VENDOR="Not Specified"
 ; Get NPI of referring provider
 I $G(@ADAT@(104,"I")) S REF=$P(^FBAAA(DFN,1,AUTHIEN,0),"^",21),FBNPI=$$PADZ^FBAAV01($$REFNPI^FBCH78($G(REF),"",1),10)
 S @DSIFFB@(CNT,1)="Authorization"_U_AUTHIEN_U_"1"_U_"Line"_U_FRDT_";"_$$FMTE^XLFDT(FRDT,1)_U_$G(@ADAT@(.02,"I"))_";"_$G(@ADAT@(.02,"E"))
 S @DSIFFB@(CNT,1)=@DSIFFB@(CNT,1)_U_VENPT_";"_VENDOR_U_$G(@ADAT@(101,"I"))_";"_$G(@ADAT@(101,"E"))_U_$G(@ADAT@(.07,"I"))_";"_POV_";"_$G(@ADAT@(.07,"E"))
 S @DSIFFB@(CNT,1)=@DSIFFB@(CNT,1)_U_$G(@ADAT@(.065,"I"))_";"_$G(@ADAT@(.065,"E"))_U_$G(@ADAT@(.095,"I"))_";"_$G(@ADAT@(.095,"E"))
 S @DSIFFB@(CNT,2)="Authorization"_U_AUTHIEN_U_"2"_U_"Line"  ;Continue record, start new line
 S @DSIFFB@(CNT,2)=@DSIFFB@(CNT,2)_U_$G(@ADAT@(.08,"E"))_U_$G(@ADAT@(.085,"E"))_U_$G(@ADAT@(.086,"E"))_U_$G(@ADAT@(2,"I"))_";"_$G(@ADAT@(2,"E"))_U_$G(@ADAT@(.096,"I"))
 S @DSIFFB@(CNT,2)=@DSIFFB@(CNT,2)_U_$G(@ADAT@(.097,"I"))_U_$G(@ADAT@(100,"I"))_";"_$G(@ADAT@(100,"E"))_U_$G(@ADAT@(.03,"I"))_";"_$G(@ADAT@(.03,"E"))
 S @DSIFFB@(CNT,2)=@DSIFFB@(CNT,2)_U_$G(@ADAT@(104,"I"))_";"_$G(@ADAT@(104,"E"))_U_FBNPI  ;Referring Provider
 S @DSIFFB@(CNT,2)=@DSIFFB@(CNT,2)_U_$G(@ADAT@(105,"I"))_";"_$G(@ADAT@(105,"E")) ;DSIF*3.2*2 added contract number to list
 S @DSIFFB@(CNT,3)="Authorization^"_AUTHIEN_"^3^Line"_U_DFN_";"_VADM(1)_U_$TR(VADM(2),U,";")_U_$G(@ID@(.5,"I"))_U_$G(@ID@(.6,"I"))_";"_$G(@ID@(.6,"E"))
 S $P(@DSIFFB@(CNT,3),U,11)=$G(@ADAT@(.06,"I"))_";"_$G(@ADAT@(.06,"E"))
 I FLAG,$G(@ADAT@(.055,"I"))[7078 S DSIFSTA=$G(@ADAT@(101,"I")) D
 . S VAL=$P($$NS^XUAF4(DSIFSTA),U,2)_"-"_$P($G(@ADAT@(.055,"E")),".") Q:$G(VAL)=""  N OUT D FIND^DIC(442,"","@;1;IX","M",.VAL,1,"B","","","OUT") S FCP=$P($G(OUT("DILIST","ID",1,1))," ")
 . S $P(@DSIFFB@(CNT,3),U,9,10)=$P($G(@ADAT@(.055,"I")),";")_";"_$G(@ADAT@(.055,"E"))_U_FCP Q
 I FLAG,$G(@ADAT@(.055,"I"))[583 S $P(@DSIFFB@(CNT,3),U,9,10)=$G(@ADAT@(.055,"I"))_U_"" Q
 ; get the remarks
 S J=0 F  S J=$O(@ADAT@(.021,J)) Q:J<1  S @DSIFFB@(CNT,4,J)="Authorization"_U_AUTHIEN_U_J_U_"Remark"_U_$G(@ADAT@(.021,J))
 Q
