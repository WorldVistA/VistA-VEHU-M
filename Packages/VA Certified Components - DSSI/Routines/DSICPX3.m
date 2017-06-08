DSICPX3 ;DSS/SGM - GET SELECTED VISIT INFO ;12/23/2004 09:20
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;
 ; DBIA#  Supported Description
 ; -----  --------- -----------------------------
 ;  1905  SELECTED^VSIT [controlled subscription]
 ;  1906  $$LOOKUP^VSIT [controlled subscription]
 ; 10003  ^%DT
 ; 10104  $$UP^XLFSTR
 ;
ILOOK(DSICX,DSICD,FUN) ; rpc: DSIC PX GET VISIT FLDS
 ; Use this rpc/api if you wish to get only selected fields for a
 ; VISIT file entry.
 ; DSICX - passed by reference
 ; DSICD(n) = p1^p2  for n=1,2,3,4,...  where
 ;   p1 = "V" if this is the visit ifn, else it is the field#
 ;   p2 = visit ifn if p1="V", else it is a format code
 ;        format I:return internal data format
 ;               E:return external data format
 ;               B:return both internal;external [default]
 ;
 ; FUN - for API only - I $G(FUN) & only a single field is passed, then
 ;       return as extrinsic function p1^p2^p3 [see return]
 ;       For this case, you can pass DATA = p1^p2^p3 where
 ;       p1=visit ien   p2=field#   p3=format code [I;E;B]
 ;
 ; Return DSICX(n) = p1^p2^p3  for n=1,2,3,4,...  where
 ;   p1 = field number
 ;   p2 = internal    p3=external
 ; If problems return DSICX(1) = -1^msg
 ;
 I '$D(DSICD) S DSICX(1)="-1^No input value received" G OUT
 N A,I,X,Y,Z,DSICA,DSICTMP,IEN
 I $G(FUN) S X=+$G(DSICD) I X>0 S IEN=X
 S I="" F  S I=$O(DSICD(I)) Q:I=""  D  Q:$D(IEN)
 .S X=DSICD(I)
 .I $P(X,U)'="","vV"[$P(X,U) S IEN=+$P(X,U,2) K DSICD(I)
 .Q
 I '$G(IEN) S DSICX(1)="-1^No visit ifn received" G OUT
 I $G(FUN),$G(DSICD)'="" S DSICD(1)=$P(DSICD,U,2,3)
 S I="" F  S I=$O(DSICD(I)) Q:I=""  D
 .S Z=$P(DSICD(I),U,2),X=+DSICD(I)
 .S:Z?.E1L.E Z=$$UP^XLFSTR(Z)
 .I Z="IE"!(Z="EI") S Z="B"
 .S DSICA(X)=Z
 .Q
 K DSICD
 D LOOK(.DSICTMP,IEN)
 S X=$G(DSICTMP(1)) I +X=-1 S DSICX(1)=X G OUT
 S (I,A)=0 F  S I=$O(DSICTMP(I)) Q:'I  S X=DSICTMP(I) D:$D(DSICA(+X))
 .S Z=DSICA(+X),Y=+X
 .S:"BI"[Z $P(Y,U,2)=$P(X,U,3)
 .S:"BE"[Z $P(Y,U,3)=$P(X,U,4)
 .S A=A+1,DSICX(A)=Y
 .Q
 I '$D(DSICX) S DSICX(1)="-1^Problems encountered retrieving data"
OUT Q:$G(FUN) DSICX(1)
 Q
 ;
LOOK(DSIC,DATA) ;  RPC: DSIC PX GET VISIT INFO2
 ;  Look up a visit and return all of its information
 ;  DSIC passed by reference
 ;  DATA = visit ien (or visit's ID) ^ FMT   where
 ;         FMT - I := return data in internal format
 ;               E := return data in external format
 ;               B := return both int and ext format - default
 ;
 ;  RETURN: DSIC(#) = p1^p2^p3^p4  where
 ;          p1 = field # from file 9000010
 ;          p2 = code representing type of data
 ;          p3 = internal value for field
 ;          p4 = external value for field
 ;  if problems return DSIC(1) = -1^message
 ;
 ; Field #  Code        Description 
 ; -------  ----  -----------------------------------------------------
 ; .01      VDT   VISIT/ADMIT DATE&TIME (date)
 ; .02      CDT   DATE VISIT CREATED (date)
 ; .03      TYP   TYPE (set)
 ; .05      PAT   PATIENT NAME
 ; .06      INS   LOC. OF ENCOUNTER (ptr LOCATION file #9999999.06)
 ;                  (IHS file DINUMed to INSTITUTION file #4) 
 ; .07      SVC   SERVICE CATEGORY (set)
 ; .08      DSS   DSS ID (pointer to CLINIC STOP file)
 ; .09      CTR   DEPENDENT ENTRY COUNTER (number)
 ; .11      DEL   DELETE FLAG (set)
 ; .12      LNK   PARENT VISIT LINK (pointer VISIT file #9000010)
 ; .13      MDT   DATE LAST MODIFIED (date)
 ; .18      COD   CHECK OUT DATE&TIME (date)
 ; .21      ELG   ELIGIBILITY (pointer ELIGIBILITY CODE file #8)
 ; .22      LOC   HOSPITAL LOCATION (pointer HOSPITAL LOCATION file #44)
 ; .23      USR   CREATED BY USER (pointer NEW PERSON file #200)
 ; .24      OPT   OPTION USED TO CREATE (pointer OPTION file #19)
 ; .25      PRO   PROTOCOL (pointer PROTOCOL file #101)
 ; 2101     OUT   OUTSIDE LOCATION (free text)
 ; 80001    SC    SERVICE CONNECTED (set)
 ; 80002    AO    AGENT ORANGE EXPOSURE (set)
 ; 80003    IR    IONIZING RADIATION EXPOSURE (set)
 ; 80004    EC    PERSIAN GULF EXPOSURE (set)
 ; 80005    MST   MILITARY SEXUAL TRAUMA (set)
 ; 80006    HNC   HEAD AND NECK CANCER (set)
 ; 15001    VID   VISIT ID (free text)
 ; 15002    IO    PATIENT STATUS IN/OUT (set)
 ; 15003    PRI   ENCOUNTER TYPE (set)
 ; 81101    COM   COMMENTS
 ; 81202    PKG   PACKAGE (pointer PACKAGE file #9.4)
 ; 81203    SOR   DATA SOURCE (pointer PCE DATA SOURCE file (#839.7) 
 ;
 N A,B,I,X,Y,Z,CODE,DSICX,FLD,FMT,IEN,VSIT
 I $G(DATA)="" S DSIC(1)="-1^No input value received" Q
 S IEN=$P(DATA,U),X=$E($P(DATA,U,2))
 S FMT=$S("Bb"[X:"B","Ii"[X:"I","Ee"[X:"E",1:"B")
 S X=$$LOOKUP^VSIT(IEN,"B",0)
 I X=-1 S DSIC(1)="-1^Invalid VISIT ien received; "_IEN Q
 S Z="",CODE=$P($T(S+1),";",3),FLD=$P($T(S+2),";",3)
 F I=1:1:$L(FLD,U) S X=$P(CODE,U,I),Y=$P(FLD,U,I) D
 .S Z=$G(VSIT(X)),A=Y_U_X
 .I "BI"[FMT S $P(A,U,3)=$P(Z,U)
 .I "BE"[FMT S $P(A,U,4)=$P(Z,U,1+(FMT="B"))
 .S DSIC(I)=A
 .Q
 I '$D(DSIC) S DSIC(1)="-1^Problems encountered"
 Q
 ;
SEL(DSIC,DATA) ;  RPC: DSIC PX GET SELECTED VISITS
 ; Returns selected visits depending on screens passed in
 ; Only "DFN" is required
 ; defaults for other is ALL
 ; 12/23/2004 - changed meaning of DSIC return variable
 ;   DSIC = $NA(^TMP("DSIC",$J)) if coming from this RPC or
 ;     coming from another M process and $G(DSIC)=""
 ;   Otherwise, DSIC must be a closed array name
 ;
 ;  DATA(sub) = value
 ; ----------   -------------------------------------
 ; DFN          pointer to the PATIENT file (#2)
 ; SDT          in external format or FM format
 ; EDT          in external format or FM format
 ; LOC          pointer to Hospital Location (#44)
 ; ENCTYPE      string of encounter types wanted
 ;                set of codes from ^DD(9000010,15003)
 ; NENCTYPE     string of encounter types not wanted
 ;                set of codes from ^DD(9000010,15003)
 ; SERVCAT      string of service categories to include
 ;                set of codes from ^DD(9000010,.07)
 ; NSERVCAT     string of service categories not to include
 ;                set of codes from ^DD(9000010,.07)
 ; MAX          maximum number of entries to return starting with end
 ;                date and going backwards
 ;
 ; RETURN: DSIC=$NA(^TMP("DSIC",$J))
 ;   ^TMP("DSIC",$J,n) = p1^p2^p3^p4^p5^p6^p7  where
 ;   p1 = ien to visit file
 ;   p2 = FM date.time;external date.time
 ;   p3 = location pointer;external value
 ;          if visit's service category '= "H" then from file 44
 ;          else then from file #9999999.06
 ;   p4 = service category code (from field .07)
 ;   p5 = service connected (external value from field 80001)
 ;   p6 = patient status in/out code (from field 15002)
 ;   p7 = clinic stop ien (pointer to file 40.7;external name)
 ; if problems return @DSIC@(n) = -1^message
 ;
 N I,X,Y,Z,DFN,ED,EDT,ENCTYPE,LOC,MAX,NENCTYPE,NSERVCAT,SD,SDT,SERVCAT
 I $G(DSIC)=""!($$BROKER^DSICUTL("DSIC PX GET SELECTED VISITS")=2) D
 .S DSIC=$NA(^TMP("DSIC",$J))
 .Q
 K @DSIC,^TMP("VSIT",$J)
 F X="DFN","SDT","EDT","LOC","ENCTYPE","NENCTYPE","SERVCAT","NSERVCAT","MAX" S @X=$G(DATA(X))
 I DFN="" S @DSIC@(1)="-1^No DFN valued received" Q
 S (ED,SD,Z)="" I SDT'="" D
 .S X=$$DT(SDT) S:X>0 SD=X
 .I X=-1 S Z="Invalid start date received: "_SDT_"; "
 .Q
 I EDT'="" D
 .S X=$$DT(EDT) S:X>0 ED=X
 .I X=-1 S Z="Invalid end date received: "_EDT
 .Q
 I Z'="" S @DSIC@(1)="-1^"_Z Q
 I ED<SD S @DSIC@(1)="-1^End date is earlier than start date" Q
 D SELECTED^VSIT(DFN,SDT,EDT,LOC,ENCTYPE,NENCTYPE,SERVCAT,NSERVCAT,MAX)
 S Z=$NA(^TMP("VSIT",$J)),Y=$P(Z,")")_","
 F I=1:1 S Z=$Q(@Z) Q:Z'[Y  S @DSIC@(I)=$QS(Z,3)_U_@Z
 I '$D(@DSIC) S @DSIC@(1)="-1^No records found"
 K ^TMP("VSIT",$J)
 Q
 ;
 ;------------------------  subroutines  -------------------------
DT(X) ;  convert to FM date.time
 N %DT,Y,Z I $G(X)="" Q -1
 S %DT="TS" D ^%DT
 Q Y
 ;
S ;
 ;;VDT^CDT^TYP^PAT^INS^SVC^DSS^CTR^DEL^LNK^MDT^COD^ELG^LOC^USR^OPT^PRO^OUT^SC^AO^IR^ED^MST^HNC^VID^IO^PRI^COM^PKG^SOR
 ;;.01^.02^.03^.05^.06^.07^.08^.09^.11^.12^.13^.18^.21^.22^.23^.24^.25^2101^80001^80002^80003^80004^80005^80006^15001^15002^15003^81101^81202^81203
