DENTVHLB ;DSS/LM - Dental Transaction Extract HL7 Messaging ;5/29/2003 16:40
 ;;1.2;DENTAL;**40,53,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2007, Document Storage Systems, Inc., All Rights Reserved
 ; Batch process messages
 ; 
 ; Integration Agreements
 ;
 ; 2056   $$GET1^DIQ
 ; 2051   $$FIND1^DIC
 ; 2053   UPDATE^DIE
 ; 2053   FILE^DIE
 ; 10103  $$NOW^XLFDT
 ; 10112  $$SITE^VASITE
 ; 
 ;
 Q
EN ;;From DENTVHLB TASK option
 ; and DENTVHLB BATCH via BAT^DENTVHLB
 Q:'$D(ZTQUEUED)  ;Background only
 ;N %DT,EDT,X,Y S X="T-14",%DT="" D ^%DT S EDT=Y ;P55 remove the 2 week delay!
 N DENTVADD,DENTVDA,DENTVDT,DENTVFDA,DENTVMID,DENTV0 S DENTVDT=0
 ; Traverse "pending" transactions -
 S DENTVCNT=0 ;Message counter
 F  S DENTVDT=$O(^DENT(228.2,"AXMIT","P",DENTVDT)) Q:'DENTVDT!(DENTVCNT=DENTVMAX)  D
 .S DENTVDA=0
 .F  S DENTVDA=$O(^DENT(228.2,"AXMIT","P",DENTVDT,DENTVDA)) Q:'DENTVDA!(DENTVCNT=DENTVMAX)  D
 ..S DENTV0=$G(^DENT(228.2,DENTVDA,0))
 ..I $P(DENTV0,U,12)'=104!($P(DENTV0,U,29)'=1) Q  ;not txn type, not complete
 ..;Q:$$GET1^DIQ(228.2,DENTVDA_",",.19)<60  ;Not complete (chart# field)
 ..S DENTVADD=$$GET1^DIQ(228.2,DENTVDA_",",1.03)="" ;not Deleted means add
 ..S DENTVMID=$S(DENTVADD:$$ADD^DENTVHL(DENTVDA),1:$$DEL^DENTVHL(DENTVDA))
 ..I (DENTVMID'>0)!(DENTVMID[";") S DENTVFDA(228.2,DENTVDA_",",1.18)="E" D FILE^DIE(,"DENTVFDA") Q  ;error
 ..S DENTVCNT=1+DENTVCNT
 ..S DENTVFDA(228.2,DENTVDA_",",1.18)="T" D FILE^DIE(,"DENTVFDA") ;STATUS
 ..D F25(DENTVMID,228.2,DENTVDA) ;DES/HL7 Transmission File
 ..Q
 .Q
 ; To do: Process 228.5 here
 Q
HST ;;Adapted from EN (above) for one-time historical batch
 ;
 Q:'$D(ZTQUEUED)  ;Background only
 N %DT,EDT,X,Y S X="T-14",%DT="" D ^%DT S EDT=Y
 N DENTVADD,DENTVDA,DENTVDT,DENTVFDA,DENTVMID,DENTV0 S DENTVDT=0
 ; Traverse all transactions -
 S (DENTVCNT,DENTVDA)=0 ;
 F  S DENTVDA=$O(^DENT(228.2,DENTVDA)) Q:'DENTVDA!(DENTVCNT=DENTVMAX)  D
 .Q:$$GET1^DIQ(228.2,DENTVDA_",",1.18)'=""  ;Historical status unrecorded
 .S DENTV0=$G(^DENT(228.2,DENTVDA,0))
 .I $P(DENTV0,U,12)'=104!($P(DENTV0,U,29)'=1) Q  ;not txn type, not complete
 .;Q:$$GET1^DIQ(228.2,DENTVDA_",",.19)<60  ;Not complete (chart# field)
 .S DENTVADD=$$GET1^DIQ(228.2,DENTVDA_",",1.03)="" ;not Deleted means add
 .S DENTVMID=$S(DENTVADD:$$ADD^DENTVHL(DENTVDA),1:$$DEL^DENTVHL(DENTVDA))
 .I (DENTVMID'>0)!(DENTVMID[";") S DENTVFDA(228.2,DENTVDA_",",1.18)="E" D FILE^DIE(,"DENTVFDA") Q  ;error
 .S DENTVCNT=1+DENTVCNT
 .S DENTVFDA(228.2,DENTVDA_",",1.18)="T" D FILE^DIE(,"DENTVFDA") ;STATUS
 .D F25(DENTVMID,228.2,DENTVDA) ;DES/HL7 Transmission File
 .Q
 ;
 Q
BAT ;;From DENTVHLB BATCH option.
 ; HL7 Batch message
 ; Code limits: 1000 messages/batch, 2KB / message.
 N DENTVCNT,DENTVMAX S DENTVMAX=1000 ;Maximum messages per batch
 F  S DENTVCNT=0 D B1 Q:$G(DENTVCNT)<DENTVMAX  ;Encounter
 ;F  S DENTVCNT=0 D B2 Q:$G(DENTVCNT)<DENTVMAX  ;Fee Basis P55 don't see fee anymore
 D TASK^DENTVHL3 ;P53 queue job for T+3 days, check to see if acks recvd
 Q
B1 ;;Continuation of BAT for each 1000 messages
 ; HL7 Batch message
 N DENTVBAT,DENTBEID S DENTVBAT=1 ;Batch context flag
 N HL,HLA Q:$$INIT^DENTVHLU(.HL)  S DENTBEID=HL("EID")
 N DENTBMID,DENTBIEN D CREATE^HLTF(.DENTBMID,.DENTBIEN)
 Q:'$G(DENTBMID)
 N DENTBMSG,DENTBCNT S DENTBMSG="^TMP(""HLS"",$J)" K @DENTBMSG
 ; Generate individual messages here
 I $G(TEST) Q:'$$TEST
 E  D @$S($G(DENTVHST):"HST",1:"EN")
 ; Per 4/13/2004 conference call, transmit batch even if empty.
 ; However, HL7 Infrastructure reports error for empty batch.
 Q:'$G(DENTVCNT)!'$D(@DENTBMSG)  ;Empty batch
 I $G(DENTVHST) D  Q  ;One-time historical batch (via HFS)
 .S ^TMP("HLS",$J,"DENTVHL")=$H_"%%"_DENTBEID_"%%"_DENTVCNT
 .Q
 N HLRSLT D GENERATE^HLMA(DENTBEID,"GB",1,.HLRSLT,DENTBIEN)
 W:$G(TEST) !,$G(HLRSLT) ;DEBUG
 K @DENTBMSG
 Q
B2 ;;Continuation of BAT for each 1000 messages
 ; HL7 Batch message (Fee Basis)
 N DENTVBAT,DENTBEID S DENTVBAT=1 ;Batch context flag
 N HL,HLA Q:$$INIT^DENTVHLU(.HL,"DENTVHL DFT-P03 SERVER")  S DENTBEID=HL("EID")
 N DENTBMID,DENTBIEN D CREATE^HLTF(.DENTBMID,.DENTBIEN)
 Q:'$G(DENTBMID)
 N DENTBMSG,DENTBCNT S DENTBMSG="^TMP(""HLS"",$J)" K @DENTBMSG
 ; Generate individual messages here
 I $G(TEST) Q:'$$TEST
 E  D EN^DENTVHLF ;@$S($G(DENTVHST):"HST",1:"EN")_"^DENTVHLF"
 ; Per 4/13/2004 conference call, transmit batch even if empty.
 ; However, HL7 Infrastructure reports error for empty batch.
 Q:'$G(DENTVCNT)!'$D(@DENTBMSG)  ;Empty batch
 I $G(DENTVHST) D  Q  ;One-time historical batch (via HFS)
 .S ^TMP("HLS",$J,"DENTVHL")=$H_"%%"_DENTBEID_"%%"_DENTVCNT
 .Q
 N HLRSLT D GENERATE^HLMA(DENTBEID,"GB",1,.HLRSLT,DENTBIEN)
 W:$G(TEST) !,$G(HLRSLT) ;DEBUG
 K @DENTBMSG
 Q
F25(MID,SRC,SDA) ;;Create and update #228.25 entry
 ; MID=HL7 Message ID
 ; SRC=Source File ID for this message, e.g. 228.2
 ; SDA=Source File record number
 ; 
 Q:'$G(MID)  ;Required
 N DENTVFDA,DENTVIEN,IENS,R,XEVT,XID S R="DENTVFDA(228.25)"
 S IENS=$$FIND1^DIC(228.25,,"X",MID,"B")_",",XEVT=4 ;If RETRANSMIT
 D:'IENS  ;Else IENS should not exist..
 .S XEVT=$S(DENTVADD:1,1:2)
 .S @R@("+1,",.01)=MID D UPDATE^DIE(,"DENTVFDA","DENTVIEN")
 .S IENS=$G(DENTVIEN(1))_","
 .Q
 Q:'IENS  ;IENS should exist
 K @R S @R@(IENS,.03)=XEVT,@R@(IENS,.04)=$$NOW^XLFDT,@R@(IENS,.1)=+IENS
 ; To do: Acknowledgement (.05)
 D:$G(SRC)
 .S XID=+$$SITE^VASITE_"-"_$$GET1^DIQ(SRC,SDA,.01) ;$S(SRC=228.2:"T",SRC=228.5:"F",1:"")_"-"_$G(SDA)
 .S @R@(IENS,.06)=XID
 .S:SRC=228.2 @R@(IENS,.07)=$G(SDA) ;Treatment Plan Transaction/Exam
 .S:SRC=228.5 @R@(IENS,.08)=$G(SDA) ;DES Fee Basis
 .Q
 ; To do: Application ACK source
 D FILE^DIE(,"DENTVFDA")
 Q
ACK ;;Common received application ACK processing here
 ; Come here from DENTVHL ORU-R01 SERVER, RESPONSE PROCESSING RTN
 ;
 I $L($G(HLNEXT))  ;HL7 context
 E  Q  ;Nothing to process
 N I,R S R=$NA(^XTMP("DENTV","ACK",$J)) K @R ;Prep for copy
 F I=1:1 X HLNEXT Q:HLQUIT'>0  M @R@(I)=HLNODE ;Batch to ^XTMP
 ; Process messages
 N FS,EC,EC1,EC2,DENTVCID,DENTVSA,DENTVACD,DENTVERR,DENTVECD
 N J,DENTVSEG,DENTVSEQ,DENTVFLD,DENTVCER,X
 F I=1:1 Q:'$D(@R@(I))  D:@R@(I)?1"MSH".E  ;Main loop
 .S FS=$E(@R@(I),4),EC=$E(@R@(I),5,8),EC1=$E(EC),EC2=$E(EC,2) Q:'$L(FS)
 .S DENTVSA=$P(@R@(I),FS,3) ;Sending application
 .S (DENTVACD,DENTVCID,DENTVERR,DENTVECD)="",X=$G(@R@(I+1)) D:X?1"MSA".E
 ..S DENTVACD=$P(X,FS,2),DENTVCID=$P(X,FS,3) ;Ack code and control ID
 ..S DENTVERR=$P(X,FS,4),DENTVECD=$P(X,FS,7) ;Error text and error code (MSA)
 ..S X=$G(@R@(I+2)) D:X?1"ERR".E&$L(EC1)&$L(EC2)
 ...;ERR segment, repeatable sequence 1
 ...K DENTVSEG,DENTVSEQ,DENTVFLD,DENTVCER
 ...S X=$P(X,FS,2) F J=1:1:$L(X,EC2) D  ;For each repeat
 ....S DENTVSEG(J)=$P($P(X,EC2,J),EC1) ;Segment
 ....S DENTVSEQ(J)=$P($P(X,EC2,J),EC1,2) ;Sequence
 ....S DENTVFLD(J)=$P($P(X,EC2,J),EC1,3) ;Field position
 ....S DENTVCER(J)=$P($P(X,EC2,J),EC1,4) ;Code identifying error
 ....Q
 ...Q
 ..Q
 .I $L($G(DENTVCID)) N IENS S IENS=$$FIND1^DIC(228.25,,"X",DENTVCID,"B")
 .E  D ERR^DENTVHL2(,"Missing message control ID in application acknowledgement") Q
 .I $G(IENS) N DENTVFDA,RR S RR="DENTVFDA(228.25,"""_IENS_","")"
 .E  D ERR^DENTVHL2(,"Unknown message control ID "_DENTVCID) Q
 .S @RR@(.05)=$E(DENTVACD,2) ;Acknowledgement code
 .S @RR@(.09)=$S(DENTVSA["-AAC-":1,DENTVSA["-HDR-":2,1:"") ;Application ACK
 .D FILE^DIE(,"DENTVFDA") ;File DES/HL7 TRANSMISSION status update
 .D AAC:DENTVSA["-AAC-",HDR:DENTVSA["-HDR-" ;Additional processing
 .D:'($E(DENTVACD,2)="A") ERR ;Prep error message
 .Q
 K @R ;Cleanup
 Q
AAC ;;Process application ACK from Austin Automation Center
 ; AAC-specific processing here
 ;
 Q
HDR ;;Process application ACK from Healthcare Data Repository
 ; HDR-specific processing here
 ;
 Q
ERR ;;Prep to call ERR^DENTVHL2
 ; Report ACK error or reject
 N DENTV257,DENTVACK,J,X
 ; Initialize Table 0357 values
 S DENTV257(100)="Segment sequence error"
 S DENTV257(101)="Required field missing"
 S DENTV257(102)="Data type error"
 S DENTV257(103)="Table value not found"
 S DENTV257(200)="Unsupported message type"
 S DENTV257(201)="Unsupported event code"
 S DENTV257(202)="Unsupported processing ID"
 S DENTV257(203)="Unsupported version ID"
 S DENTV257(204)="Unknown key identifier"
 S DENTV257(205)="Duplicate key identifier"
 S DENTV257(206)="Application record locked"
 S DENTV257(207)="Application internal error"
 ;
 S DENTVACK(1)="Application error or reject for HL7 message "_$G(DENTVCID)
 S X=$S($G(DENTVSA)["-AAC-":"Austin Automation Center",$G(DENTVSA)["-HDR-":"Health Data Repository",1:$G(DENTVSA))
 S DENTVACK(2)="received from "_X_"."
 S DENTVACK(3)="Error code: "_$G(DENTVECD)_", Error text: "_$G(DENTVERR)
 F J=1:1 Q:'$D(DENTVSEG(J))  D
 .S DENTVACK(2*J+2)="SEG: "_$G(DENTVSEG(J))_"  SEQ: "_$G(DENTVSEQ(J))
 .S DENTVACK(2*J+3)="FLD: "_$G(DENTVFLD(J))_"  Code: "_$G(DENTVCER(J))
 .I $G(DENTVCER(J)),$D(DENTV257(DENTVCER(J))) S DENTVACK(2*J+3)=DENTVACK(2*J+3)_": "_DENTV257(DENTVCER(J))
 .Q
 D ERR^DENTVHL2(,,"DENTVACK")
 Q
TEST() ;;Generate test messages for batch
 N OK F DENTVTST=9,10,25 S OK=$$ADD^DENTVHL(DENTVTST) Q:'(OK>0)
 Q OK>0
