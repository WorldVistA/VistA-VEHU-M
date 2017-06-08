DENTVIP3 ;DSS/SGM - INITIALIZATION OF DENTV SYS PARAMETERS ;02/10/2004 18:09
 ;;1.2;DENTAL;**31,39,47**;Aug 10, 2001
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  POST-INSTALL INITIALIZATION FOR DENTV PARAMETERS
 ;  DBIA# 10076 - direct read of ^XUSEC(key_name)
 ;
 N I,J,X,DEN,DENT,ENT,INST,PARAM,STUB,TAG,VAL,RET
 F TAG="V1","V2","V3" D
 .S PARAM=$P($T(@TAG),";",3) Q:PARAM=""
 .F I=1:1 S X=$P($T(@(TAG_"+"_I)),";",3) Q:X=""  D
 ..S INST=$P(X,U),VAL=$P(X,U,2),ENT=$P(X,U,3)
 ..I ENT'="",ENT'["S" Q
 ..I VAL'="" D SET()
 ..Q
 .Q
 ;
 F TAG="VA" D
 .S STUB=$P($T(@TAG),";",3) Q:STUB=""
 .F I=1:1 S X=$P($T(@(TAG_"+"_I)),";",3) Q:X=""  D
 ..S PARAM=STUB_" "_$P(X,U),VAL=$P(X,U,2),ENT=$P(X,U,3),INST=1
 ..I ENT'="",ENT'["S" Q
 ..I VAL'="" D SET()
 ..Q
 .Q
 ;
 F TAG="VP" D
 .S STUB=$P($T(@TAG),";",3) Q:STUB=""
 .F I=1:1 S X=$P($T(@(TAG_"+"_I)),";",3,10) Q:X=""  D
 ..S PARAM=STUB,INST=$P(X,U),VAL=$P(X,U,2),ENT=$P(X,U,3)
 ..I ENT'="",ENT'["S" Q
 ..I VAL'="" D SET()
 ..Q
 .Q
 ;  special cases
 S PARAM=$P($T(V4),";",3),TAG="V4" D
 .F I=1:1 S X=$P($T(@(TAG_"+"_I)),";",3) Q:X=""  D
 ..S INST=$P(X,U),VAL=$P(X,U,2) I VAL'="" D SET("PKG")
 ..Q
 .Q
 ;
 ;  move key holders to dent admin
 K DENT
 F DEN=0:0  S DEN=$O(^XUSEC("DENTV EDIT FILE",DEN)) Q:'DEN  D
 .S DENT="USR.`"_DEN_"~DENTV DRM ADMINISTRATOR~1"
 .Q:$$GET1^DSICXPR(,DENT,1)>0  S X=$$ADD^DSICXPR(,DENT_"~1",1)
 .Q
 ;
 ; set the word processing parameter
 K DENT,RET S PARAM=$P($T(VS),";",3),TAG="VS"
 F DEN=1:1:9 S DENT(DEN)=$P($T(@(TAG_"+"_DEN)),";",3)
 D PAR^DENTVTP0(.RET,"PKG",PARAM,1,.DENT)
 Q
 ;
SET(E) ;  add/update parameter for SYSTEM
 N I,J,X,Y,Z,DENT,DENX
 S E=$G(E) S:E="" E="SYS"
 ;  does it exist?
 S DENT=E_"~"_PARAM_"~"_INST_"~~~Q",DENX=$$GET1^DSICXPR(,DENT,1)
 Q:VAL=DENX  S $P(DENT,"~",4)=VAL
 I +DENX=-1 S Y=$$ADD^DSICXPR(,DENT,1)
 I +DENX'=-1 S Y=$$CHG^DSICXPR(,DENT,1)
 Q
 ;
 ;  entries in Vn - n = 1,2,3,4,....
 ;  the first line is the name of the parameter
 ;  Lines following the param name consist of:
 ;    instance ^ SYSTEM default value ^ applicable entities
 ;  If no entities, default to SPU
 ;
V1 ;;DENTV PAGE SETUP
 ;;BOTTOM MARGIN^0.5
 ;;LEFT MARGIN^0.25
 ;;RIGHT MARGIN^0.25
 ;;TOP MARGIN^0.5
 ;;FOOTER FONT NAME^Courier New
 ;;FOOTER FONT SIZE^10
 ;;FOOTER FONT STYLE^fsRegular
 ;;FOOTER TEXT LINES^0
 ;;HEADER FONT NAME^Courier New
 ;;HEADER FONT SIZE^10
 ;;HEADER FONT STYLE^fsRegular
 ;;HEADER TEXT LINES^5
 ;;PAGE FONT NAME^Courier New
 ;;PAGE FONT SIZE^10
 ;;PAGE FONT STYLE^fsRegular
 ;;PAGE ORIENT^poPortrait
 ;;PAGE NUMBER HORZ^pnCenter
 ;;PAGE NUMBER VERT^pnBottom
 ;;PRINT PAGE NUMBER^1
 ;;
V2 ;;DENTV DATE RANGE
 ;;DENT NUMBER OF DAYS^999
 ;;DENT MAX^999
 ;;LAB NUMBER OF DAYS^180
 ;;LAB MAX^100
 ;;NOTES NUMBER OF DAYS^180
 ;;NOTES MAX^100
 ;;VISIT NUMBER OF DAYS^365
 ;;VISIT MAX^100
 ;;
V3 ;;DENTV CVISION
 ;;csApplicationName^Clinical Dental Record Management System^S
 ;;csCompanyName^Clinical DRM System^SP
 ;;csDebugMode^0
 ;;csDefaultMode^1
 ;;csDefaultPrinter^^PU
 ;;csDefaultToPrimary^0^SP
 ;;csDoctorName^0
 ;;csDragonEnabled^0^S
 ;;csExamSequence^ 
 ;;csExcessPocket^4
 ;;csExcessPocketColor^255
 ;;csFGMWarning^4
 ;;csFurcationWarning^2
 ;;csMGJWarning^3
 ;;csMobilityWarning^1.5
 ;;csNormPocketColor^0
 ;;csPocketWarning^4
 ;;csPrintChart^1
 ;;csPrintPatNotes^1
 ;;csPrintToothNotes^1
 ;;csPrintTransactions^1
 ;;csProbeOneEnabled^0^SP
 ;;csProbeOneCommPort^1^SP
 ;;csSpeechFeedbackEnabled^0^S
 ;;csShowMGJTrace^1
 ;;csTransDisplay^14531481
 ;;csWarnDuplicateTrans^1
 ;;csShowSeqOnStart^0
 ;;csSeqFormSettings^
 ;;
V4 ;;DENTV TX HNPRESETS
 ;;Amalgam Tattoo^1
 ;;Angular Chelitis^1
 ;;Apthous Ulceration^1
 ;;Cancerous condition^1
 ;;Candida^1
 ;;Cavitated Lesion^1
 ;;Cicatrix^1
 ;;Epulis^1
 ;;Erythroplakia^1
 ;;Exophytic lesion^1
 ;;Hairy leukoplakia^1
 ;;Herpetic Lesion^1
 ;;Leukoplakia^1
 ;;Lichen Plannus^1
 ;;Mass noted^1
 ;;Nodes palpable^1
 ;;Pigmented lesion^1
 ;;R/O Cancerous condition^1
 ;;TMD/ Facial Pain Condition^1
 ;;Ulcerative Lesion^1
 ;;
 ;  entires in Vx - x = A,B,C,D,...
 ;  the first line is the stub name of parameter
 ;  following line consist of
 ;    rest of param name ^ instance ^ entities ^ param type
 ;
VA ;;DENTV DRM
 ;;ADMINISTRATOR^^U^boolean
 ;;BOILERPLATE PROMPT^1^^boolean
 ;;DEF ENC TAB^REST^^I $D(^DENT(228,"AS1",X))
 ;;DEF STARTUP TAB^3^^0:coverpage;1:clinical;2:history;3:chart
 ;;DEF TEMP FOLDER^C:\TEMP\^
 ;;DEF TX TAB^0^
 ;;EXCEL EXTRACT^0^^boolean
 ;;EXTRACT IP^^^free text
 ;;EXTRACT PORT^^^numeric
 ;;EXTRACT FOLDER^C:\TEMP\^^free text
 ;;NOTE WIDTH^74^SP^numeric
 ;;USER CHAR ACCESS^E^^N:No access;D:Display only;E:Edit allowed
 ;;DAS TURNOFF^10/31/2004^S^date/time
 ;;
 ;
VP ;;DENTV TP NOTE OBJECTS
 ;;COMPLETED ITEMS^1;0;0;1^
 ;;DIAGNOSTIC FINDINGS^1;0;1;0^
 ;;HEADNECK FINDINGS^1;0;1;1^
 ;;PERIODONTAL EXAM^1;0;0;0^
 ;;PLANNED ITEMS^1;0;1;0^
 ;;PSR EXAM^1;0;1;0^
 ;;TOOTH NOTES^1;0;1;1^
 ;;CODE BOILERPLATE^0;0;0;0^
 ;;NEXT APPOINTMENT^1;0;0;0^
 ;;DENTAL ALERTS^0;0;0;0^
 ;;
 ;
VS ;;DENTV TP NOTE SEQUENCE
 ;;HEADNECK FINDINGS
 ;;DIAGNOSTIC FINDINGS
 ;;PSR EXAM
 ;;PERIODONTAL EXAM
 ;;TOOTH NOTES
 ;;PLANNED ITEMS
 ;;CODE BOILERPLATE
 ;;COMPLETED ITEMS
 ;;NEXT APPOINTMENT
 ;;DENTAL ALERTS
 ;;
 ;
