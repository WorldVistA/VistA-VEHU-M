DENTVHL1 ;DSS/LM - Dental Transaction Extract HL7 Messaging ;5/29/2003 16:40
 ;;1.2;DENTAL;**40,43,53**;Aug 10, 2001;Build 10
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ; Integration Agreements
 ;
 ; 2161   MSH^HLFNC2
 ; 2164   GENERATE^HLMA
 ;        
 Q
CONT() ;Continuation of ^DENTVHL
 ;continue OBR
 ; File# 42.4 values - (Moved to 2nd OBX 3/24/2004)
 N SPTR,SPDATA S SPTR=$G(@FP1@(.17,"I")),SPDATA="" ;Pointer to SPECIALTY
 N SNME,SSVC
 S:SPTR SNME=$$GET1^DIQ(42.4,SPTR,.01) ;Specialty Name
 S:SPTR SSVC=$$GET1^DIQ(42.4,SPTR,3) ;Specialty Service
 N DENTRPT S DENTRPT=0
 S:SPTR DENTRPT=DENTRPT+1,$P(SPDATA,EC2,DENTRPT)=SPTR_EC1_EC1_"VISTA228.1;F.17"
 S:$G(SNME)]"" DENTRPT=DENTRPT+1,$P(SPDATA,EC2,DENTRPT)=SNME_EC1_EC1_"VISTA42.4;F.01"
 S:$G(SSVC)]"" DENTRPT=DENTRPT+1,$P(SPDATA,EC2,DENTRPT)=SSVC_EC1_EC1_"VISTA42.4;F3"
 ;S:SPDATA]"" $P(@MSG@(DENTVHLI),FS,14)=SPDATA ;OBR-13 Relevant Clinical Info (PTF)
 ; Provider fields -
 ; January 2004 - Change OBR.16 to use Provider SSN
 ;                Move provider identifiers from OBR.20 and 21 to PRA segment
 N OBR16,PSSN S OBR16="",PSSN=$S(PDUZ:$$GET1^DIQ(200,PDUZ,9),1:"")
 S:PSSN]"" OBR16=PSSN ;Also primary key in PRA segment
 S OBR16=OBR16_$S(PRNM]"":EC1_$TR($$HLNAME^XLFNAME(PRNM),U,EC1),1:"")
 S:PSSN]"" $P(OBR16,EC1,8)="USSSA" ;"VistA200;F9"
 S:OBR16]""&(STNO]"") $P(OBR16,EC1,14)=STNO ;Will become a pointer to file #4
 S:OBR16]"" $P(@MSG@(DENTVHLI),FS,17)=OBR16 ;Provider
 ; January 2004 -  Remove OBR.20 and 21 (additional provider data)
 I $L($G(OBR25)) S $P(@MSG@(DENTVHLI),FS,26)=OBR25 ;From DEL - "Marked as deleted"
 ; Procedure -
 N ICPT,CPT S ICPT=$G(@FP2@(.04,"I"))
 S CPT=$G(@FP2@(.04,"E")) ; External format ADA code (Same as OBR.4)
 ; Reference to file #81 removed
 ; Change table name to VistA format -
 S:ICPT $P(@MSG@(DENTVHLI),FS,45)=ICPT_EC1_CPT_EC1_"VistA228.2;F.04" ;OBR-44
 ;OBR-47 Dental Product Line
 I $G(@FP2@(1.16,"E"))]"" S $P(@MSG@(DENTVHLI),FS,48)=$G(@FP2@(1.16,"E"))
 E  S $P(@MSG@(DENTVHLI),FS,48)="DES131" ;default for Local codes w/o PL's
 ;
 ; First OBX segment 
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="OBX"_FS_1 ;Set ID 1
 S $P(@MSG@(DENTVHLI),FS,3)="CE" ;OBX-2 (Encodable) strings
 ; Make OBX.3 same as OBR.3 (Observation ID = Filler Order # = Transaction ID)
 ;S $P(@MSG@(DENTVHLI),FS,4)=OBR3_EC1_"DENTAL TRANSACTION RECORD"_EC1_"VistA228.2;F.01"
 S $P(@MSG@(DENTVHLI),FS,4)="DENTAL ANATOMY" ;Purpose of observation (PR)
 ; Results -
 N RSLT S RSLT="" ;Initialize, then add repeats..
 ; Previous code commented-out -
 S DENTRPT=0
 ;check tooth related flag (1.202) before setting tooth# (TP records only)
 I $G(@FP2@(.06,"I")) S:$G(@FP2@(.15,"E"))]""&($E($G(@FP2@(1.202,"E")))=1) DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(.15,"E"))_EC1_EC1_"VistA228.2;F.15" ;TOOTH NUMBER
 E  S:$G(@FP2@(.15,"E"))]"" DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(.15,"E"))_EC1_EC1_"VistA228.2;F.15" ;TOOTH NUMBER
 I $G(@FP2@(.06,"I")),$G(@FP2@(.09,"E"))="cndPartial" S DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(.15,"E"))_EC1_EC1_"VistA228.2;F.15" ;force partials tooth# P43
 S:$G(@FP2@(.16,"E"))]"" DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(.16,"E"))_EC1_EC1_"VistA228.2;F.16" ;SURFACE
 S:$G(@FP2@(1.8,"E"))]"" DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(1.8,"E"))_EC1_EC1_"VistA228.2;F1.8" ;QUADRANT
 S:$G(@FP2@(1.17,"E"))]"" DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(1.17,"E"))_EC1_EC1_"VistA228.2;F1.17" ;CANAL#
 S:$G(@FP2@(.18,"E"))]"" DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(.18,"E"))_EC1_EC1_"VistA228.2;F.18" ;ISJUVENILE
 S:$G(@FP2@(1.12,"E"))]"" DENTRPT=DENTRPT+1,$P(RSLT,EC2,DENTRPT)=$G(@FP2@(1.12,"E"))_EC1_EC1_"VistA228.2;F1.12" ;RVU (Relative Value Units)
 S $P(@MSG@(DENTVHLI),FS,6)=RSLT ;OBX-5
 S $P(@MSG@(DENTVHLI),FS,12)="F" ;OBX-11 Final result (Required field)
 N EIEN S EIEN=$G(@FP1@(.12,"I")) ;Outpatient encounter IEN
 D:EIEN  ;Requires PCE patch
 .N OEDT S OEDT=$$GET1^DIQ(409.68,EIEN,.01,"I") ;Date/Time
 .S:OEDT $P(@MSG@(DENTVHLI),FS,15)=$$FMTHL7^XLFDT(OEDT)
 .S $P(@MSG@(DENTVHLI),FS,16)=EIEN_EC1_EC1_"VistA228.1;F.12"
 .Q
 ;
 ; Second OBX segment
 ; 
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="OBX"_FS_2 ;Set ID 2
 S $P(@MSG@(DENTVHLI),FS,3)="CE" ;OBX-2 (Encodable) strings
 ; Make OBX.3 same as OBR.3 (Observation ID = Filler Order # = Transaction ID)
 ;S $P(@MSG@(DENTVHLI),FS,4)=OBR3_EC1_"DENTAL TRANSACTION RECORD"_EC1_"VistA228.2;F.01"
 S $P(@MSG@(DENTVHLI),FS,4)="DENTAL SPECIALTY" ;Purpose of observation (PR)
 ; Results -
 S $P(@MSG@(DENTVHLI),FS,6)=SPDATA ;OBX-5 Specialty data
 S $P(@MSG@(DENTVHLI),FS,12)="F" ;OBX-11 Final result (Required field)
 ;
 ; PRA segment
 ; 
 S DENTVHLI=DENTVHLI+1,@MSG@(DENTVHLI)="PRA"_FS_PSSN_EC1_EC1_"USSSA" ;PRA.1 Primary Key
 ; January 2004 -  Move OBR.20 and 21 (provider data) to PRA segment
 N PRA2,PRA6 S PRA2=$$VCODE^DENTVHLU(PDUZ,PDATE)_EC1_EC1_"VistA8932.1;F5" ;PRA.2 VA CODE
 N PRA6A S PRA6A=$G(@FP2@(.03,"I")) S:PRA6A PRA6A=PRA6A_EC1_"VistA228.2;F.03"
 N PRA6B S PRA6B=$$ZNMBR^DENTVHLU(PDUZ)_EC1_"VistA220.5;F.04"
 ; Next is placeholder.  Uncomment and replace empty strings with values
 ;N PRA6D S PRA6D=""_EC1_"" ;National Provider ID Placeholder
 S:'(PRA2=EC1) $P(@MSG@(DENTVHLI),FS,3)=PRA2
 S DENTRPT=0,PRA6=""
 S:PRA6A DENTRPT=DENTRPT+1,$P(PRA6,EC2,DENTRPT)=PRA6A
 S:PRA6B DENTRPT=DENTRPT+1,$P(PRA6,EC2,DENTRPT)=PRA6B
 ; Uncomment next when Dental provider national ID is coded
 ;S:PRA6D]"" DENTRPT=DENTRPT+1,$P(PRA6,EC2,DENTRPT)=PRA6D
 S:PRA6]"" $P(@MSG@(DENTVHLI),FS,7)=PRA6
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
