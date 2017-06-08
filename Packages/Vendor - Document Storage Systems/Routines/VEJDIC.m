VEJDIC ;DSS/LM - Insurance card RPC's ;12/14/2004 [1/25/05 11:02am]
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;
 ; 2051     FIND^DIC
 ; 
 Q
INSCO(RESULT,X) ;;Insurance company name lookup and validate
 ; Implements VEJDIC INSURANCE COMPANY remote procedure
 ; See REMOTE PROCEDURE entry for input parameter definition
 ; X=Insurance company name or approximation
 ; 
 ; Returns matching values in local array
 ; 
 S RESULT(1)="-1^Insurance company name required" Q:'$L($G(X))
 N VEJDICR,VEJDICM
 D FIND^DIC(36,,"@;.01","MPQ",$$UC(X),,,,,"VEJDICR","VEJDICM")
 I '$D(VEJDICR) S RESULT(1)="-1"_U_$G(VEJDICM("DIERR",1,"TEXT",1)) Q
 S RESULT(1)="0^No match found"
 N I F I=1:1 Q:'$D(VEJDICR("DILIST",I,0))  D
 .S RESULT(I)=VEJDICR("DILIST",I,0)
 .Q
 Q
GRPPOL(RESULT,X,FLDS,VDT)  ;;Group Name #355.3 lookup and validate
 ; Implements VEJDIC GROUP INSURANCE PLAN remote procedure
 ; See REMOTE PROCEDURE entry for input parameter definition
 ; X=Group Insurance Plan name or approximation
 ; FLDS=Field list, defaults to "@;.03;.01I;.01"
 ; VDT=Visit Date.Time, defaults to DT
 ; 
 ; Returns matching values in local array
 ; 
 S RESULT(1)="-1^Group Plan name required" Q:'$L($G(X))
 S FLDS=$G(FLDS,"@;.03;.01I;.01"),VDT=$G(VDT,$G(DT,$$DT^XLFDT))
 N VEJDICR,VEJDICM
 D FIND^DIC(355.3,,FLDS,"MPQ",$$UC(X),,,,,"VEJDICR","VEJDICM")
 I '$D(VEJDICR) S RESULT(1)="-1"_U_$G(VEJDICM("DIERR",1,"TEXT",1)) Q
 S RESULT(1)="0^No match found"
 N I F I=1:1 Q:'$D(VEJDICR("DILIST",I,0))  D
 .S RESULT(I)=VEJDICR("DILIST",I,0)
 .Q
 Q
ADDBUF(RESULT,DFN,TYPE,INSCO,DATA) ;;Add entry to INSURANCE BUFFER file
 ; Uses private DBIA 3302 (unsupported to this application)
 ; Processes one and only one insurance buffer entry per call
 ; 
 ; DFN=Patient internal entry number
 ; TYPE="M" for Medicare, "X" for all other (Default is "X")
 ; INSCO=INSURANCE COMPANY name (Required unless Medicare)
 ; DATA=(Medicare) Array of keyword^value pairs (e.g. SOURCE^value of source)
 ;      (Insurance) Array of field#^value pairs (Must include required fields)
 ; 
 ; RESULT=Buffer IEN for success,  0 for filing error, -1 for RPC error
 ; 
 S RESULT="-1^Patient IEN required" Q:'$G(DFN)
 S TYPE=$G(TYPE,"X") I '$D(DATA)>1 S RESULT="-1^Nothing to file" Q
 I TYPE="X",'$L($G(INSCO)) S RESULT="-1^Insurance company name required" Q
 N DSICIC,I,R,Y
 S:TYPE="M" R="DSICIC(""M"")",@R@("DFN")=DFN
 S:TYPE="X" R="DSICIC(1)",@R@(20.01)=INSCO,@R@(60.01)=DFN
 F I=1:1 Q:'$D(DATA(I))  S @R@($P(DATA(I),U))=$P(DATA(I),U,2,99)
 S Y=$$BUFF^IBCNBES1(.DSICIC)
 S RESULT=$G(DSICIC($S(TYPE="M":"M",1:1),"MESSAGE"))
 Q
FIND(RESULT,DFN,FLDS) ;;Return INSURANCE BUFFER file entries for a given patient
 ; Implements VEJDIC FIND ENTRIES remote procedure
 ; DFN=Patient IEN (required)
 ; FLDS=Fields list (optional)
 ; 
 Q:'$G(DFN)  N VEJDPARM
 S VEJDPARM(1)="FILE^355.33",VEJDPARM(2)="VAL^"_DFN,VEJDPARM(3)="INDEX^C"
 S VEJDPARM(4)="FLAGS^QX",VEJDPARM(5)="SCREEN^I $P(^(0),U,5)="""""
 I $L($G(FLDS)) S VEJDPARM(6)="FIELDS"_U_FLDS
 N VEJD D FIND^DSICFM05(.VEJD,.VEJDPARM)
 I $D(VEJD) S VEJD=$NA(@VEJD,2) N VEJDI,VEJDBUF  D  K @VEJD ;12.19.05 KC
 .F VEJDI=1:1 Q:'$D(@VEJD@("DILIST",VEJDI))  D
 ..S VEJDBUF=$P(@VEJD@("DILIST",VEJDI,0),U)
 ..S RESULT(VEJDI)=@VEJD@("DILIST",VEJDI,0)_U_$$FLGS(DFN)_U_$$SYM(VEJDBUF)
 ..Q
 .Q
 ;I $D(VEJD) S VEJD=$NA(@VEJD,2) N I D  K @VEJD
 ;.F I=1:1 Q:'$D(@VEJD@("DILIST",I))  S RESULT(I)=@VEJD@("DILIST",I,0)
 ;.Q
 Q
LIST(RESULT,SDT,EDT,FLDS) ;;Return INSURANCE BUFFER file entries for date range
 ; Implements VEJDIC LIST ENTRIES remote procedure
 ; SDT=Inclusive start date (optional)
 ; EDT=Inclusive end date (optional)
 ; FLDS=Field list (optional)
 S SDT=$G(SDT,0),EDT=$G(EDT,9999999),FLDS=$G(FLDS,".01I;.01") N VEJDPARM
 S RESULT=$NA(^TMP("VEJDIC",$J)) K @RESULT ;9.13.05 KC now a global array returned
 S VEJDPARM(1)="FILE^355.33"
 S VEJDPARM(2)="SCREEN^I '($P(^(0),U)<SDT!($P(^(0),U)>EDT)!$P(^(0),U,5))"
 S VEJDPARM(3)="INDEX^B",VEJDPARM(4)="FROM^"_SDT,VEJDPARM(5)="FIELDS^"_"60.01I;.02I;"_FLDS
 S VEJDPARM(6)="NUMBER^*" ;9.13.05 KC added because DSICFM05 defaults to 100
 N VEJD D LIST^DSICFM05(.VEJD,.VEJDPARM)
 I $D(VEJD) N DFN,SSN,UDIV,UDUZ,VEJDI S VEJD=$NA(@VEJD,2) N I D  K @VEJD
 .F VEJDI=1:1 Q:'$D(@VEJD@("DILIST",VEJDI))  D
 ..S @RESULT@(VEJDI)=@VEJD@("DILIST",VEJDI,0)
 ..S DFN=$P(@RESULT@(VEJDI),U,2),SSN=$$GET1^DIQ(2,+DFN,.09,"I")
 ..S UDUZ=$P(@RESULT@(VEJDI),U,3) S:UDUZ UDIV=$P($$DIV^DSICDUZ(,UDUZ,1,1),U,2)
 ..S @RESULT@(VEJDI)=@RESULT@(VEJDI)_U_SSN_U_$$FLGS(DFN)_U_$$SYM(+@RESULT@(VEJDI))_U_$G(UDIV)
 ..Q
 .Q
 Q
GETS(RESULT,IENS,FIELDS,FLAGS) ;;Return details of an INSURANCE BUFFER file entry
 ; Implements VEJDIC GETS remote procedure
 ; IENS=INSURANCE BUFFER file IEN or IENS (required)
 ; FIELDS=Field list (optional) in GETS^DIQ format (default=all top level)
 ; FLAGS=Flag list (option) in GETS^DIQ format (default=external, omit null)
 Q:'$G(IENS)  S FIELDS=$G(FIELDS,"*"),FLAGS=$G(FLAGS,"EN")
 S:IENS=+IENS IENS=IENS_","
 N VEJD D GET^DSICDDR0(.VEJD,355.33,IENS,FIELDS,FLAGS)
 I $D(VEJD) N I D  K @VEJD
 .F I=1:1 Q:'$D(@VEJD@(I))  S RESULT(I)=$P(@VEJD@(I),U,2,99)
 .Q
 Q
FILE(RESULT,IENS,DATA) ;;File updates to an INSURANCE BUFFER file entry
 ; Implements VEJDIC FILE EDITS
 ; IENS=IEN of entry, or IENS of entry or sub-entry
 ; DATA=array of fields and values in format <field#>^<flag>^<value>
 ; where optional flag indicates external format value (default=internal)
 ; For word-processing data see additional notes with DSIC FM FILER RPC.
 S RESULT(1)="-1^IENS required" Q:'$G(IENS)
 S RESULT(1)="-1^Nothing to file" Q:'($D(DATA)>1)
 K RESULT(1)  S:$E(IENS,$L(IENS))'="," IENS=IENS_","
 D FILE^DSICFM04(.RESULT,355.33,IENS,,.DATA)
 Q
FLGS(DFN) ;;Compute iIEYH flags - Private, not an RPC
 ; Adapted from routine ^IBCNBLL
 ; DFN=Patient IEN
 I $G(DFN) N VADM,VAIN,VEJDICY,X
 E  Q ""
 D DEM^VADPT,INP^VADPT S VEJDICY=""
 S VEJDICY=$S(+$$INSURED^IBCNS1(DFN,DT):"i",1:" ")
 S VEJDICY=VEJDICY_$S(+$G(VAIN(1)):"I",1:" ")
 S VEJDICY=VEJDICY_$S(+$G(VADM(6)):"E",1:" "),X=$P($$LST^DGMTU(DFN),U,4)
 S VEJDICY=VEJDICY_$S(X="C":"Y",X="G":"Y",1:" ")
 S VEJDICY=VEJDICY_$S(+$$HOLD^IBCNBLL(DFN):"H",1:" ")
 Q VEJDICY
 ;
SYM(IEN)    ;;Retrieve entry IIV symbol - Private, not an RPC
 ; IEN=Insurance Buffer IEN
 Q:'$G(IEN) "" Q $$SYMBOL^IBCNBLL(IEN)
 ;
UC(X) ;;To uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
