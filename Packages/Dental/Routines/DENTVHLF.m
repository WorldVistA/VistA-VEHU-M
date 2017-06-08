DENTVHLF ;DSS/KC - Dental Fee Basis Extract HL7 Messaging ;4/05/2004 16:00
 ;;1.2;DENTAL;**40,47**;Aug 10, 2001
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 2056   GETS^DIQ
 ; 10103  $$NOW^XLFDT $$FMTHL7^XLFDT
 ; 2171   $$STA^XUAF4
 ; 2053   FILE^DIE
 ; 10003  %DT
 ; 2161   MSH^HLFNC2
 ; 2164   GENERATE^HLMA
 ; 10112  $$SITE^VASITE
 ; 
 Q
EN ;enter to loop thru Fee Basis recs
 N %DT,EDT,X,Y S X="T-14",%DT="" D ^%DT S EDT=Y
 N DENTVADD,DENTVDA,DENTVDT,DENTVFDA,DENTVMID ;,DENTVCNT,DENTVMAX
 N HLECH,HLFS,HLQ,HLARYTYP,LNMBRS ;,DENTBCNT,DENTBMID,DENTBMSG,DENTVBAT
 S DENTVDT=0 ;,DENTVCNT=0,DENTVMAX=1000 ;Message counter
 ; Traverse "pending" transactions -
 F  S DENTVDT=$O(^DENT(228.5,"AXMIT","P",DENTVDT)) Q:'DENTVDT!(DENTVDT>EDT)!(DENTVCNT=DENTVMAX)  D
 .S DENTVDA=0 F  S DENTVDA=$O(^DENT(228.5,"AXMIT","P",DENTVDT,DENTVDA)) Q:'DENTVDA!(DENTVCNT=DENTVMAX)  D
 ..S DENTVMID=$$ADD(DENTVDA) Q:DENTVMID<0
 ..I DENTVMID[";" S DENTVFDA(228.5,DENTVDA_",",.12)="E" D FILE^DIE(,"DENTVFDA") Q  ;error
 ..S DENTVCNT=1+DENTVCNT
 ..S DENTVFDA(228.5,DENTVDA_",",.12)="T" D FILE^DIE(,"DENTVFDA") ;transmitted
 ..D F25^DENTVHLB(DENTVMID,228.5,DENTVDA) ;DES/HL7 Transmission File
 ..Q
 .Q
 Q
 ;
ADD(IEN) ; New Fee Basis HL7 message
 ; IEN=File #228.5 Internal Entry Number
 ; Returns positive message ID or
 ; negative error code:
 ; -1    =   Missing or invalid parameter
 ; -2    =   Defective HL7 environment 
 ; -3    =   Application not active
 ; -99   =   GENERATE^HLMA failed
 ;
 ; To test in foreground, SET DEBUG=1 WRITE $$ADD^DENTVHL(<IEN>)
 ; Test will not generate message
 ; 
 Q:'$G(IEN) -1 ;Required parameter
 N HL,HLA,DENTVHLD,FB,X,STNO,ERR
 Q:$$INIT^DENTVHLU(.HL,"DENTVHL DFT-P03 SERVER") -2 ;Initialize HL7 variables
 Q:'$$ACTIVE^DENTVHLU(HL("SAN")) -3 ;Application not active
 ; Get data
 D GETS^DIQ(228.5,+IEN,"**","EI","DENTVHLD")
 S FB="DENTVHLD(228.5,"""_+IEN_","")" ;File 228.5 data
 S DENTVADD=$G(@FB@(.09,"I"))=""
 S STNO=$G(@FB@(.05,"E"))
 ; Verify station number and other data
 S ERR=$$VER()
 I ERR D MSG^DENTVHL3($G(@FB@(.01,"E")),ERR) Q ERR ;SRS validation
 ; 
 ; Filter HL7 field separator and encoding characters from source fields
 S X=FB F  S X=$Q(@X) Q:X=""  S:@X]"" @(X_"=$$ESC^DENTVHLU("_X_")")
 ;
 ; Miscellaneous HL7 variables
 N EC1,EC2,EC3,EC4,FS
 S FS=$G(HL("FS")) Q:'$L(FS) -2 ;Field separator
 S EC1=$E($G(HL("ECH"))) Q:'$L(EC1) -2 ;Component separator
 S EC2=$E($G(HL("ECH")),2) Q:'$L(EC2) -2 ;Repetition separator
 S EC3=$E($G(HL("ECH")),3) Q:'$L(EC3) -2 ;Escape character
 S EC4=$E($G(HL("ECH")),4) Q:'$L(EC4) -2 ;Subcomponent separator
 ; Additional message variables
 N DENTVHLI,MSG,SEG,DFN,PNM,PDATE
 S DENTVHLI=0,MSG="HLA(""HLS"")" ;Segment counter and message array
 S DFN=$G(@FB@(.04,"I")),PNM=$G(@FB@(.04,"E")) ;Patient IEN and NAME
 S PDATE=DT ;Transaction date
 ;
 ; EVN segment
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="EVN"_FS_"P03"_FS_$$FMTHL7^XLFDT($$NOW^XLFDT)
 ; PID segment from ^VAFCQRY
 N PID S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)=$$PID^DENTVHLU(DFN,.PID)
 ; PID continuation
 N I F I=2:1 Q:'$D(PID(I))  S @MSG@(DENTVHLI,I-1)=PID(I)
 ; FT1 segment
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="FT1"_FS_1
 S $P(@MSG@(DENTVHLI),FS,3)=$P($$SITE^VASITE(),U,3)_"-"_$G(@FB@(.01,"I")) ;txn id
 S $P(@MSG@(DENTVHLI),FS,5)=$$FMTHL7^XLFDT($G(@FB@(.02,"I"))) ;txn date
 S $P(@MSG@(DENTVHLI),FS,6)=$$FMTHL7^XLFDT($G(@FB@(.07,"I"))) ;txn posting date
 S $P(@MSG@(DENTVHLI),FS,7)=$S(DENTVADD:"PY",1:"CA") ;txn type
 S $P(@MSG@(DENTVHLI),FS,8)="FEE" ;txn code
 S $P(@MSG@(DENTVHLI),FS,13)=$G(@FB@(.08,"E")) ;txn amount
 S $P(@MSG@(DENTVHLI),FS,17)=EC1_EC1_EC1_STNO ;pt location
 S $P(@MSG@(DENTVHLI),FS,19)=$G(@FB@(.06,"I")) ;pt type
 ;
 I $G(DEBUG) D  Q "" ;DEBUG
 .N I,J F I=1:1 Q:'$D(@MSG@(I))  D
 ..W ! W:$G(LNMBRS) $J(I,3),?5
 ..W @MSG@(I) F J=1:1 Q:'$D(@MSG@(I,J))  D
 ...W !,@MSG@(I,J)
 ...Q
 ..Q
 .Q
 ; Generate message -
 N HLEXROU,HLRSLT S HLRSLT=""
 ; Batch -
 I $G(DENTVBAT) D  Q $G(DENTBMID)_"-"_$G(DENTBCNT) ;Add to Batch
 .Q:'$G(DENTBMID)  S DENTBCNT=1+$G(DENTBCNT) ;Individual message counter
 .D MSH^HLFNC2(.HL,DENTBMID_"-"_DENTBCNT,.HLRSLT)
 .N I,J S I=$O(@DENTBMSG@(""),-1)+1
 .S @DENTBMSG@(I)=$G(HLRSLT)
 .F J=1:1 Q:'$D(@MSG@(J))  M @DENTBMSG@(I+J)=@MSG@(J)
 .Q
 ; Individual -
 D GENERATE^HLMA(HL("EID"),$G(HLARYTYP,"LM"),1,.HLRSLT)
 Q $S($G(HLRSLT)>0:+$G(HLRSLT),1:-99)
 ;
VER() ; verify required fields
 ; File 228.2 -
 I STNO="" Q "228.2;.05" ;Facility
 I '$G(@FB@(.01,"I")) Q "228.5;.01" ;Transaction ID
 I '$G(@FB@(.02,"I")) Q "228.5;.02" ;Report Date (create date)
 I '$G(@FB@(.04,"I")) Q "228.5;.04" ;Patient IEN
 I '$G(@FB@(.06,"I")) Q "228.5;.06" ;Patient Category
 I '$G(@FB@(.07,"I")) Q "228.5;.07" ;Date Authorized
 I '$D(@FB@(.08,"I")) Q "228.5;.08" ;Total Cost
 Q 0
