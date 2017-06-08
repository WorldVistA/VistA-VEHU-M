DENTVHLU ;DSS/LM - Dental Encounter Extract Utilities ;5/29/2003 16:40
 ;;1.2;DENTAL;**40,45,46,59**;Aug 10, 2001;Build 19
 ;Copyright 1995-2011, Document Storage Systems, Inc., All Rights Reserved
 ; Integration Agreements
 ;
 ; 2051   $$FIND1^DIC
 ; 2056   $$GET1^DIQ, GETS^DIQ
 ; 2161   INIT^HLFNC2
 ; 3630   BLDPID^VAFCQRY
 ; 1625   $$GET^XUA4A72 reference will be removed
 ; 2053   FILE^DIE
 ; 3744   $$TESTPAT^VADPT 
 ; 
 Q
ACTIVE(HLAPP) ;;Return 1=TRUE if and only if HL7 Application is Active
 Q:'$L($G(HLAPP)) 0
 S:'$G(HLAPP) HLAPP=$$FIND1^DIC(771,,"X",HLAPP)
 Q:'$G(HLAPP) 0
 Q $$GET1^DIQ(771,HLAPP,2,"I")="a"
 ;
INIT(HL,PROT) ;;Set up HL7 environment variables 
 ; Return 0=Success or 1=Failure
 ; HL=Return array of HL7 variables [by reference]
 ; PROT=Event Driver protocol
 S PROT=$G(PROT,"DENTVHL ORU-R01 SERVER") ;12/1/03 Changed from RCI-I05
 S HL("EID")=$$FIND1^DIC(101,,,PROT)
 Q:'HL("EID") 1  D INIT^HLFNC2(HL("EID"),.HL)
 Q +$G(HL)
 ;
ESC(X,FS,EC) ;;Convert HL7 delimiter(s) in X to escape sequence(s)
 ; X=String to be converted [Required]
 ; FS=HL7 Field Separator [Defaults to HL("FS") or "|"]
 ; EC=HL7 Encoded characters [Defaults to HL("ECH") or "^~\&"]
 ;
 S X=$G(X),FS=$G(FS,$G(HL("FS"),"|")),EC=$G(EC,$G(HL("ECH"),"^~\&"))
 N %,E1,E2,E3,E4,Y,Z S Y="" F %=1:1:4 S @("E"_%_"=$E(EC,%)")
 F %=1:1:$L(X) S Z=$E(X,%) D:FS_EC[Z  S Y=Y_Z
 .S Z=$S(Z=FS:"F",Z=E1:"S",Z=E2:"R",Z=E3:"E",Z=E4:"T",1:""),Z=E3_Z_E3
 Q Y
 ;
ZNMBR(IEN) ;;New Dental Provider Number
 ; IEN=Provider DUZ (required)
 ; Returns 220.5F.04
 Q:'$G(IEN) ""
 N IENS S IENS=$$FIND1^DIC(220.5,,"QO",IEN)_"," Q:'IENS ""
 Q $$GET1^DIQ(220.5,IENS,.04)
 ;
STANO() ;;Return station number
 Q "" ;Place holder
PIEN(DFN,STA) ;;Return formatted patient IEN as
 ; 3-digit station number + 0-padded DFN
 ;
 ; DFN=Patient file IEN
 ; STA=Station number + suffix
 Q:'$G(DFN) "" ;Patient IEN
 S STA=$TR($J(+$G(STA,$$STANO),3)," ",0) Q:'STA "" ;Station number
 Q STA_$TR($J(DFN,15)," ",0) ;18-character string
 ;
PID(DFN,PID) ;BLDPID^VAFCQRY Wrapper
 ; PID by reference for long PID with continuation
 ; Requires HL array
 Q:'$G(DFN) "PID"
 ; Protect non-namespaced variables
 N DIV,EC1,EC2,EC3,EC4,FN,FP1,FP2,FS,I,IE1,IEN,MSG,PNM,SEG,VIEN,VDT,X,WL
 ;Use BLDPID^VAFCQRY in place of $$EN^VAFCPID (Peter Rontey)
 D BLDPID^VAFCQRY(DFN,1,"1,2,3,7,18,19",.PID,.HL)
 Q $G(PID(1)) ;Assumes no continuation
 ;
VCODE(IEN,DATE) ;GET^XUA4A72 wrapper
 ; IEN=Provider IEN, File #200
 ; DATE=Date of Role (Defaults to DT)
 ;
 ; Return PERSON CLASS: VA Code
 ;
 Q:'$G(IEN) ""
 ; Next is placeholder. Will be replaced by USR API (from Steve)
 Q $P($$GET^XUA4A72(IEN,$G(DATE,$G(DT))),U,7)
 ; Above will be replaced by API from Steve to supply 3 pieces of
 ; data: provider TYPE, SPECIALTY and USR CLASS.
ROLE(IEN,DATE) ;GET^XUA4A72 wrapper
 ; IEN=Provider IEN, File #200
 ; DATE=Date of Role (Defaults to DT)
 ;
 ; Return PERSON CLASS: Occupation
 ;
 Q:'$G(IEN) ""
 ; Next is placeholder. Will be replaced by USR API (from Steve)
 Q $P($$GET^XUA4A72(IEN,$G(DATE,$G(DT))),U,2)
 ; Above will be replaced by API from Steve to supply 3 pieces of
 ; data: provider TYPE, SPECIALTY and USR CLASS.
SQUISH(X,C) ;;Remove trailing characters from string
 ; C=Character to be removed
 I $L($G(X)),$L($G(C))=1 ;Required
 E  Q $G(X)
 N % F %=$L(X):-1:1 Q:'($E(X,%)=C)
 Q $E(X,1,%)
 ;
PRECHECK(START,END) ;;Utility Entry to check existing transactions
 ; prior to transmitting historic data.
 ; 
 ; START=Starting IEN (optional)
 ; END=Ending IEN (optional)
 ; 
 ; If printed report is desired D ^%ZIS and U IO
 ; before calling this entry.
 ; 
 N IEN,IE1,FP2,FP1,RESULT
 S END=$G(END,999999999)
 W !,"TRANSACTION",?15,"VALS RESULT",!
 S IEN=$G(START,0) F  S IEN=$O(^DENT(228.2,IEN)) Q:'IEN!(IEN>END)  D
 .S FP2="DENTVHLD(228.2,"""_+IEN_","")"
 .D GETS^DIQ(228.2,+IEN,"**","EI","DENTVHLD")
 .S IE1=$G(@FP2@(1.15,"I"))
 .I 'IE1 K @FP2 W !,$G(@FP2@(.01,"E"),"`"_IEN),?15,"Missing DENTAL HISTORY pointer!" Q
 .S FP1="DENTVHLD(228.1,"""_+IE1_","")"
 .D GETS^DIQ(228.1,+IE1,"**","EI","DENTVHLD")
 .;S RESULT=$$VALS^DENTVHL2() ;FileMan validation
 .S RESULT=$$VER^DENTVHL2() ;SRS verification
 .W !,$G(@FP2@(.01,"E"),"`"_IEN),?15,$S(RESULT:RESULT,1:"PASSED")
 .K @FP1,@FP2
 .Q
 Q
 ;
REDO(START,END) ;resend a set of transactions that didn't go to the AAC
 W !,"Resend a set of HL7 Transactions to the AAC.",!
 W !,"This routine will set the HL7 STATUS field (.18) of 228.2 to ""P"""
 W !,"so that the transactions will retransmit next Sunday."
 S START=+$G(START),END=+$G(END)
 I 'START!'END W !,"No STARTING and/or ENDING transaction Id!" Q
 N DENT,DENT0,DENST S START=START-1
 F  S START=$O(^DENT(228.2,START)) Q:'START!(START>END)  D
 .S DENST="P" ;default status to Pending
 .I $$TESTPAT^VADPT(+$P($G(^DENT(228.2,START,0)),U,2)) S DENST="" ;test pt, don't resend
 .S DENT0=$G(^DENT(228.2,START,0)) I DENT0="" S DENST="" ;no data, don't resend
 .I $P(DENT0,U,12)'=104 S DENST="" ;P59 not a completed txn
 .I $P(DENT0,U,9)=23,$P(DENT0,U,22)>1 S DENST="" ;only resend 1st tooth in partial
 .I $P(DENT0,U,9)=66 S DENST="" ;don't resend Observe txns
 .I $P(DENT0,U,4)="" S DENST="" ;no ADA code (placeholder txn) don't resend
 .K DENT S DENT(228.2,START_",",1.18)=DENST D FILE^DIE(,"DENT")
 .Q
 W !!,"DONE"
 Q
