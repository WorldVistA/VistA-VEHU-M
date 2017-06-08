DENTVHL2 ;DSS/LM - Dental Transaction Extract HL7 Messaging ;5/29/2003 16:40
 ;;1.2;DENTAL;**40,42,45**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ; Integration Agreements
 ;
 ; 2053   VALS^DIE
 ; 10070  ^XMD
 ;
 Q
ERR(ECODE,ETEXT,EARRY) ;;Error processing
 ;ECODE=numeric error code (optional)
 ;ETEXT=one-line textual error description (optional)
 ;EARRY=Name of array containing additional error text (optional)
 ;
 ;Generate message and send to mailgroup
 ;
 Q:$G(DENTVHST)  ;don't send messages for historical batch
 I $G(ECODE)!$L($G(ETEXT))!$L($G(EARRY)) N %,DENTVTXT,R,XMDUZ,XMSUB,XMTEXT,XMY,DIFROM
 E  Q  ;Nothing to process
 S XMDUZ=.5,XMSUB="Dental Transaction Error"
 S XMY("G.DENTV HL7 MESSAGES")=""
 S %=0,R="DENTVTXT"
 D:$G(ECODE)
 .N I,X F I=1:1 S X=$T(DATA+I) Q:X=""  I $P(X,";",2)=ECODE S X=$P(X,";",3) Q 
 .S %=%+1,@R@(%,0)="Error "_ECODE_" occurred while processing TREATMENT PLAN TRANSACTION/EXAM IEN="_$G(IEN)
 .S:X]"" %=%+1,@R@(%,0)="Explanation: "_X
 .S %=%+1,@R@(%,0)="Transaction was not transmitted."
 .Q
 D:$L($G(ETEXT))
 .S %=%+1,@R@(%,0)="An error was reported for a dental transaction HL7 message."
 .; To do: Details of NAK report here
 .S %=%+1,@R@(%,0)=ETEXT
 .Q
 I $L($G(EARRY)) S EARRY=$NA(@EARRY) D:EARRY]""
 .N J F J=1:1 Q:'$D(@EARRY@(J))  S %=%+1,@R@(%,0)=@EARRY@(J)
 .Q
 Q:'$D(DENTVTXT)
 S XMTEXT="DENTVTXT("
 D ^XMD
 Q
NTG() ;;Integrity check
 ; Return 0=PASSED if okay to generate message
 ;        -n=error code if check fails
 Q:'$G(@FP2@(.02,"I")) -5 ;Patient IEN (DFN)
 Q:'$G(STNO) -6 ;Station number
 Q:$G(@FP2@(1.12,"E"))="" -9 ;Relative Value Units
 ; Other rules here
 Q 0 ;Passed
VALS() ;;Wrap VALS^DIE
 ; Return 0 if no problems found _or_
 ; Return File#;Field# of first failure.
 ; 
 ; This is not a generic validator.
 ; FP1 and FP2 have data to be validated.
 ; 
 N FLD,FDA,R,RESULT,RFDA
 ; File 228.2 -
 S FLD=0 F  S FLD=$O(@FP2@(FLD)) Q:'FLD  D
 .Q:'$L($G(@FP2@(FLD,"E")))
 .S FDA($QS(FP2,1),$QS(FP2,2),FLD)=@FP2@(FLD,"E")
 .Q
 S R="RFDA("_$QS(FP2,1)_","""_$QS(FP2,2)_""")",RESULT=0
 D VALS^DIE("U","FDA","RFDA")
 ;S FLD=0 F  S FLD=$O(@R@(FLD)) Q:'FLD!RESULT  D
 ; Validate only fields used in Dental Encounter message
 F FLD=.01:.01:.04,.13,.15,.16,.18,.23,1.01,1.06:.01:1.1,1.12:.01:1.17,1.8 Q:RESULT  D
 .S:$G(@R@(FLD))="^" RESULT=$QS(R,1)_";"_FLD
 Q:RESULT RESULT
 ; File 228.1 -
 K FDA,RFDA
 S FLD=0 F  S FLD=$O(@FP1@(FLD)) Q:'FLD  D
 .Q:'$L($G(@FP1@(FLD,"E")))
 .S FDA($QS(FP1,1),$QS(FP1,2),FLD)=@FP1@(FLD,"E")
 .Q
 S R="RFDA("_$QS(FP1,1)_","""_$QS(FP1,2)_""")"
 D VALS^DIE("U","FDA","RFDA")
 ; Validate only fields used in Dental Encounter message
 ;S FLD=0 F  S FLD=$O(@R@(FLD)) Q:'FLD!RESULT  D
 F FLD=.01:.01:.03,.05,.1:.01:.14,.16:.01:.18,.2 Q:RESULT  D
 .S:$G(@R@(FLD))="^" RESULT=$QS(R,1)_";"_FLD
 Q RESULT
 ;
VER() ;;Similar to VALS, but hard-coded to check selected
 ; field values versus their SRS descriptions..
 ; DAS disposition will be defaulted to Inprogress (wasn't being filed when user didn't file to DAS)
 ; File 228.2 -
 N X
 I '$G(@FP2@(.01,"I")) Q "228.2;.01" ;Transaction ID
 I '$G(@FP2@(.02,"I")) Q "228.2;.02" ;Patient IEN
 I '$$GET1^DIQ(2,+$G(@FP2@(.02,"I"))_",",.03) Q "2;.03" ;Patient DOB
 I '$$GET1^DIQ(2,+$G(@FP2@(.02,"I"))_",",.09) Q "2;.09" ;Patient SSN
 I '$G(@FP2@(.03,"I")) Q "228.2;.03" ;Provider IEN
 S X=$$ZNMBR^DENTVHLU($G(@FP2@(.03,"I"))) I X="" Q "220.5;.04" ;8 digit provider Id
 I $L($G(@FP2@(.04,"E"))),$L(@FP2@(.04,"E"))<6
 E  Q "228.2;.04" ;ADA Code
 I '($G(@FP2@(.15,"E"))?.2N) Q "228.2;.15" ;Tooth
 I $L($G(@FP2@(.16,"E")))>7 Q "228.2;.16" ;Surface
 I $L($G(@FP2@(.18,"I"))<2),"01"[@FP2@(.18,"I")
 E  Q "228.2;.18" ;Is juvenile?
 I '$G(@FP2@(1.01,"I")) Q "228.2;1.01" ;Date created
 I $L($G(@FP2@(1.06,"E")))>7 Q "228.2;1.06" ;ICD-1
 I $L($G(@FP2@(1.07,"E")))>7 Q "228.2;1.07" ;ICD-2
 I $L($G(@FP2@(1.08,"E")))>7 Q "228.2;1.08" ;ICD-3
 I $L($G(@FP2@(1.09,"E")))>7 Q "228.2;1.09" ;ICD-4
 I $L($G(@FP2@(1.1,"E")))>7 Q "228.2;1.1" ;ICD-5
 I $L($G(@FP2@(1.12,"E"))),$L(@FP2@(1.12,"E"))<6,@FP2@(1.12,"E")?.5N.1".".1N
 E  Q "228.2;1.12" ;RVU
 I $L($G(@FP2@(1.16,"E"))),$L(@FP2@(1.16,"E"))<7
 E  Q "228.2;1.16" ;Dental product line
 I '($G(@FP2@(1.17,"I"))?.1N) Q "228.2;1.17" ;Canal #
 I $L($G(@FP2@(1.8,"I")))>2 Q "228.2;1.8" ;Quadrant
 ;
 ; File 228.1 -
 I '$G(@FP1@(.02,"I")) Q "228.1;.02" ;Patient IEN
 I $L($G(@FP1@(.1,"I"))),"IO"[@FP1@(.1,"I")
 E  Q "228.1;.1" ;In/Outpatient
 I '($G(@FP1@(.13,"I"))?1.2N) Q "228.1;.13" ;Patient Category
 ;I '($G(@FP1@(.16,"I"))?1N) Q "228.1;.16" ;Disposition 8.3.04 KC don't check this (filing bug in DRM)
 I '$G(@FP1@(.18,"I")) Q "228.1;.18" ;Division
 ; Check that transaction and history have same patient
 I '(@FP1@(.02,"I")=@FP2@(.02,"I")) Q "228.X;.02" ;Patient IEN
 ;
 Q 0
 ;
DATA ;;
 ;-1;Missing or invalid parameter
 ;-2;Defective HL7 environment 
 ;-3;Application not active
 ;-4;Bad DENTAL HISTORY file pointer
 ;-5;Defective patient IEN
 ;-6;Missing station number
 ;-9;Mission Relative Value Units (RVU)
 ;-99;GENERATE^HLMA failed
