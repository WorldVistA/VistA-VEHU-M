DSIVIC ;DSS/LM - Insurance card RPC's ;12/14/2004 [1/25/05 11:02am]
 ;;2.2;INSURANCE CAPTURE BUFFER;**4**;May 19, 2009;Build 7
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 2051     FIND^DIC
 ; 5318     ^DSICDDR0
 ; 5324     FILE^DSICFM04
 ; 5319     FIND^DSICFM05
 ; 3302     $$BUFF^IBCNBES1,
 ; 10103    $$DT^XLFDT
 ; 
 Q
INSCO(RESULT,X) ;RPC: DSIV INSURANCE COMPANY
 ;Insurance company name lookup and validate
 ; See REMOTE PROCEDURE entry for input parameter definition
 ; X=Insurance company name or approximation
 ; 
 ; Returns matching values in local array
 ; 
 S RESULT(1)="-1^Insurance company name required" Q:'$L($G(X))
 N DSIVICR,DSIVICM
 D FIND^DIC(36,,"@;.01","MPQ",$$UC(X),,,,,"DSIVICR","DSIVICM")
 I '$D(DSIVICR) S RESULT(1)="-1"_U_$G(DSIVICM("DIERR",1,"TEXT",1)) Q
 S RESULT(1)="0^No match found"
 N I F I=1:1 Q:'$D(DSIVICR("DILIST",I,0))  D
 .S RESULT(I)=DSIVICR("DILIST",I,0)
 .Q
 Q
GRPPOL(RESULT,X,FLDS,VDT)  ;RPC: DSIV GROUP INSURANCE PLAN
 ;Group Name #355.3 lookup and validate
 ; See REMOTE PROCEDURE entry for input parameter definition
 ; X=Group Insurance Plan name or approximation
 ; FLDS=Field list, defaults to "@;.03;.01I;.01"
 ; VDT=Visit Date.Time, defaults to DT
 ; 
 ; Returns matching values in local array
 ; 
 S RESULT(1)="-1^Group Plan name required" Q:'$L($G(X))
 S FLDS=$G(FLDS,"@;.03;.01I;.01"),VDT=$G(VDT,$G(DT,$$DT^XLFDT))
 N DSIVICR,DSIVICM
 D FIND^DIC(355.3,,FLDS,"MPQ",$$UC(X),,,,,"DSIVICR","DSIVICM")
 I '$D(DSIVICR) S RESULT(1)="-1"_U_$G(DSIVICM("DIERR",1,"TEXT",1)) Q
 S RESULT(1)="0^No match found"
 N I F I=1:1 Q:'$D(DSIVICR("DILIST",I,0))  D
 .S RESULT(I)=DSIVICR("DILIST",I,0)
 .Q
 Q
ADDBUF(RESULT,DFN,TYPE,INSCO,DATA) ;RPC: DSIV ADD BUFFER ENTRY
 ;Add entry to INSURANCE BUFFER file
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
 I TYPE="M" S RESULT="" D MED Q:RESULT<0
 S Y=$$BUFF^IBCNBES1(.DSICIC)
 S RESULT=$G(DSICIC($S(TYPE="M":"M",1:1),"MESSAGE"))
 Q
MED ;medicare special checks DSIV*2.0*2 (medicare not filing) 3.4.08
 N S,PA,PB S S=$G(@R@(.03))
 I S]"" S @R@("SOURCE")=S
 E  S RESULT="-1^Source required" Q
 S PA=$G(@R@(40.02))
 I PA]"" S @R@(PA)=""
 E  S RESULT="-1^Group Name required" Q
 S PB=$G(@R@(40.03))
 I PB]"" S @R@(PB)=""
 E  S RESULT="-1^Group Number required"
 Q
FIND(RESULT,DFN,FLDS) ;RPC: DSIV FIND ENTRIES
 ;Return INSURANCE BUFFER file entries for a given patient
 ; DFN=Patient IEN (required)
 ; FLDS=Fields list (optional)
 ; 
 Q:'$G(DFN)  N PARM,DSIVI,DSIVBUF,ERR,SYM
 S PARM(1)="FILE^355.33",PARM(2)="VAL^"_DFN,PARM(3)="INDEX^C"
 S PARM(4)="FLAGS^QX",PARM(5)="SCREEN^I $P(^(0),U,5)="""""
 I $L($G(FLDS)) S PARM(6)="FIELDS"_U_FLDS
 N DSIV D FIND^DSICFM05(.DSIV,.PARM)
 I $D(DSIV) S DSIV=$NA(@DSIV,2) N DSIVI,DSIVBUF  D  K @DSIV ;12.19.05 KC
 .F DSIVI=1:1 Q:'$D(@DSIV@("DILIST",DSIVI))  D
 ..S DSIVBUF=$P(@DSIV@("DILIST",DSIVI,0),U),SYM=$$SYM^DSIVIC3(DSIVBUF)
 ..K ERR D ERR^DSIVIC3(DSIVBUF,1,SYM,.ERR) ;DSIV*2.2*4 return eIV error msg
 ..S RESULT(DSIVI)=@DSIV@("DILIST",DSIVI,0)_U_$$FLGS^DSIVIC3(DFN)_U_SYM_U_$S($D(ERR):ERR(1),1:"")
 ..Q
 .Q
 Q
GETS(RESULT,IENS,FIELDS,FLAGS) ;RPC: DSIV GETS
 ;Return details of an INSURANCE BUFFER file entry-gets all data
 ; IENS=INSURANCE BUFFER file IEN or IENS (required)
 ; FIELDS=Field list (optional) in GETS^DIQ format (default=all top level)
 ; FLAGS=Flag list (option) in GETS^DIQ format (default=external, omit null)
 Q:'$G(IENS)  S FIELDS=$G(FIELDS,"*"),FLAGS=$G(FLAGS,"EN")
 S:IENS=+IENS IENS=IENS_","
 N DSIV D GET^DSICDDR0(.DSIV,355.33,IENS,FIELDS,FLAGS)
 I $D(DSIV) N I D  K @DSIV
 .F I=1:1 Q:'$D(@DSIV@(I))  S RESULT(I)=$P(@DSIV@(I),U,2,99)
 .Q
 Q
FILE(RESULT,IENS,DATA) ;RPC: DSIV FILE EDITS
 ;File updates to an INSURANCE BUFFER file entry
 ; IENS=IEN of entry, or IENS of entry or sub-entry
 ; DATA=array of fields and values in format <field#>^<flag>^<value>
 ; where optional flag indicates external format value (default=internal)
 ; For word-processing data see additional notes with DSIC FM FILER RPC.
 S RESULT(1)="-1^IENS required" Q:'$G(IENS)
 S RESULT(1)="-1^Nothing to file" Q:'($D(DATA)>1)
 K RESULT(1)  S:$E(IENS,$L(IENS))'="," IENS=IENS_","
 D FILE^DSICFM04(.RESULT,355.33,IENS,,.DATA)
 Q
UC(X) ;;To uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
