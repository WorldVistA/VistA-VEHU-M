ORY12803 ;SLC/RJS,CLA - OCX PACKAGE RULE TRANSPORT ROUTINE (Delete after Install of OR*3*128) ;JAN 3,2002 at 16:11
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**128**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^ORY128ES
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXRULE",$J,$O(^TMP("OCXRULE",$J,"A"),-1)+1)=TEXT
 ;
 G ^ORY12804
 ;
 Q
 ;
DATA ;
 ;
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^FREE TEXT
 ;;EOR^
 ;;KEY^863.4:^ORDER PATIENT
 ;;R^"863.4:",.01,"E"
 ;;D^ORDER PATIENT
 ;;R^"863.4:","863.41:1",.01,"E"
 ;;D^DATA TYPE
 ;;R^"863.4:","863.41:1",1,"E"
 ;;D^NUMERIC
 ;;EOR^
 ;;EOF^OCXS(863.4)^1
 ;;SOF^863.2  OCX MDD SUBJECT
 ;;KEY^863.2:^PATIENT
 ;;R^"863.2:",.01,"E"
 ;;D^PATIENT
 ;;R^"863.2:","863.21:1",.01,"E"
 ;;D^FILE
 ;;R^"863.2:","863.21:1",1,"E"
 ;;D^2
 ;;EOR^
 ;;EOF^OCXS(863.2)^1
 ;;SOF^863.3  OCX MDD LINK
 ;;KEY^863.3:^PATIENT.ALLERGY ASSESSMENT
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.ALLERGY ASSESSMENT
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^ALLERGY ASSESSMENT
 ;;R^"863.3:",.06,"E"
 ;;D^2344
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO EXTERNAL FUNCTION CALL
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^ALRGY(|PATIENT IEN|)
 ;;EOR^
 ;;KEY^863.3:^PATIENT.HL7_FILLER
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.HL7_FILLER
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.04,"E"
 ;;D^HL7
 ;;R^"863.3:",.05,"E"
 ;;D^HL7 FILLER
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^2
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^OCXODATA("ORC",3)
 ;;R^"863.3:","863.32:4",.01,"E"
 ;;D^OCXO HL7 SEGMENT ID
 ;;R^"863.3:","863.32:5",.01,"E"
 ;;D^OCXO DATA DRIVE SOURCE
 ;;R^"863.3:","863.32:5",1,"E"
 ;;D^HL7
 ;;R^"863.3:","863.32:6",.01,"E"
 ;;D^OCXO FILE POINTER
 ;;EOR^
 ;;KEY^863.3:^PATIENT.HL7_PATIENT_ID
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.HL7_PATIENT_ID
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.04,"E"
 ;;D^HL7
 ;;R^"863.3:",.05,"E"
 ;;D^IEN
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO HL7 SEGMENT ID
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.3:","863.32:3",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:3",1,"E"
 ;;D^OCXODATA("PID",3)
 ;;EOR^
 ;;KEY^863.3:^PATIENT.IEN
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.IEN
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^IEN
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^DFN
 ;;EOR^
 ;;KEY^863.3:^PATIENT.OERR_ORDER_PATIENT
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.OERR_ORDER_PATIENT
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.05,"E"
 ;;D^ORDER PATIENT
 ;;R^"863.3:",.06,"E"
 ;;D^5567
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXORD
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO UP-ARROW PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.3:^PATIENT.OPS_FILLER
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.OPS_FILLER
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.04,"E"
 ;;D^OPS
 ;;R^"863.3:",.05,"E"
 ;;D^FILLER
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXPSD
 ;;R^"863.3:","863.32:2",.01,"E"
 ;;D^OCXO VT-BAR PIECE NUMBER
 ;;R^"863.3:","863.32:2",1,"E"
 ;;D^1
 ;;EOR^
 ;;KEY^863.3:^PATIENT.OPS_ORD_MODE
 ;;R^"863.3:",.01,"E"
 ;;D^PATIENT.OPS_ORD_MODE
 ;;R^"863.3:",.02,"E"
 ;;D^PATIENT
 ;;R^"863.3:",.04,"E"
 ;;D^OPS
 ;;R^"863.3:",.05,"E"
 ;;D^ORDER MODE
 ;;R^"863.3:",.06,"E"
 ;;D^99
 ;;R^"863.3:","863.32:1",.01,"E"
 ;;D^OCXO VARIABLE NAME
 ;;R^"863.3:","863.32:1",1,"E"
 ;;D^OCXPSM
 ;;EOR^
 ;;EOF^OCXS(863.3)^1
 ;;SOF^860.9  ORDER CHECK NATIONAL TERM
 ;;KEY^860.9:^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.01,"E"
 ;;D^ANGIOGRAM (PERIPHERAL)
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^BLOOD SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^BLOOD SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^DANGEROUS MEDS FOR PTS > 64
 ;;R^"860.9:",.01,"E"
 ;;D^DANGEROUS MEDS FOR PTS > 64
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;R^"860.9:",2,"E"
 ;;D^I $P($G(^ORD(100.98,$P($G(^ORD(101.43,+Y,0)),U,5),0)),U)="PHARMACY"
 ;;EOR^
 ;;KEY^860.9:^DNR
 ;;R^"860.9:",.01,"E"
 ;;D^DNR
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^FOOD-DRUG INTERACTION MED
 ;;R^"860.9:",.01,"E"
 ;;D^FOOD-DRUG INTERACTION MED
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;R^"860.9:",2,"E"
 ;;D^I $P($G(^ORD(100.98,$P($G(^ORD(101.43,+Y,0)),U,5),0)),U)="PHARMACY"
 ;;EOR^
 ;;KEY^860.9:^NPO
 ;;R^"860.9:",.01,"E"
 ;;D^NPO
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^ONE TIME MED
 ;;R^"860.9:",.01,"E"
 ;;D^ONE TIME MED
 ;;R^"860.9:",.02,"E"
 ;;D^51.1
 ;;R^"860.9:",2,"E"
 ;;D^I $E($P(^(0),U,4),1,2)="PS"
 ;;EOR^
 ;;KEY^860.9:^PARTIAL THROMBOPLASTIN TIME
 ;;R^"860.9:",.01,"E"
 ;;D^PARTIAL THROMBOPLASTIN TIME
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^PROTHROMBIN TIME
 ;;R^"860.9:",.01,"E"
 ;;D^PROTHROMBIN TIME
 ;;R^"860.9:",.02,"E"
 ;;D^101.43
 ;;EOR^
 ;;KEY^860.9:^SERUM CREATININE
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM CREATININE
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^SERUM SPECIMEN
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM SPECIMEN
 ;;R^"860.9:",.02,"E"
 ;;D^61
 ;;EOR^
 ;;KEY^860.9:^SERUM UREA NITROGEN
 ;;R^"860.9:",.01,"E"
 ;;D^SERUM UREA NITROGEN
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;KEY^860.9:^WBC
 ;;R^"860.9:",.01,"E"
 ;;D^WBC
 ;;R^"860.9:",.02,"E"
 ;;D^60
 ;;EOR^
 ;;EOF^OCXS(860.9)^1
 ;;SOF^860.8  ORDER CHECK COMPILER FUNCTIONS
 ;;KEY^860.8:^ALLERGY ASSESSMENT
 ;;R^"860.8:",.01,"E"
 ;;D^ALLERGY ASSESSMENT
 ;;R^"860.8:",.02,"E"
 ;;D^ALRGY
 ;;R^"860.8:",1,1
 ;;D^This function checks to see if the patient has an allergy assessment on 
 ;;R^"860.8:",1,2
 ;;D^file. If not, a "0" (zero) is returned.  If the patient does have an
 ;;R^"860.8:",1,3
 ;;D^allergy assessment or no know allergies (NKA), a "1" (one) is returned.
 ;;R^"860.8:",100,1
 ;;D^   ;ALRGY(ORPT)   ; determine if pt has an allergy assessment
 ;;R^"860.8:",100,2
 ;;D^   ; ; rtn 0 if no allergy assessment, 1 if allergy assessment or NKA
 ;;R^"860.8:",100,3
 ;;D^   ; N ORALRGY
 ;;R^"860.8:",100,4
 ;;D^   ; D EN1^GMRAOR1(ORPT,"ORALRGY")
 ;;R^"860.8:",100,5
 ;;D^   ; Q:$G(ORALRGY)="" 0
 ;;R^"860.8:",100,6
 ;;D^   ; Q 1
 ;;R^"860.8:",100,7
 ;;D^   ; ;
 ;;EOR^
 ;;KEY^860.8:^CONVERT DATE FROM FILEMAN FORMAT TO OCX FORMAT
 ;;R^"860.8:",.01,"E"
 ;;D^CONVERT DATE FROM FILEMAN FORMAT TO OCX FORMAT
 ;;R^"860.8:",.02,"E"
 ;;D^DT2INT
 ;;R^"860.8:",1,1
 ;;D^  ;DT2INT(OCXDT) ;      This Local Extrinsic Function converts a date into an integer
 ;;R^"860.8:",1,2
 ;;D^  ; ; By taking the Years, Months, Days, Hours and Minutes converting
 ;;R^"860.8:",1,3
 ;;D^  ; ; Them into Seconds and then adding them all together into one big integer
 ;;R^"860.8:",100,1
 ;;D^  ;DT2INT(OCXDT) ;      This Local Extrinsic Function converts a date into an integer
 ;;R^"860.8:",100,2
 ;;D^  ; ; By taking the Years, Months, Days, Hours and Minutes converting
 ;;R^"860.8:",100,3
 ;;D^  ; ; Them into Seconds and then adding them all together into one big integer
 ;;R^"860.8:",100,4
 ;;D^  ; ;
 ;;R^"860.8:",100,5
 ;;D^  ; Q:'$L($G(OCXDT)) ""
 ;;R^"860.8:",100,6
 ;;D^  ; N OCXDIFF,OCXVAL S (OCXDIFF,OCXVAL)=0
 ;;R^"860.8:",100,7
 ;;D^  ; ;
 ;;R^"860.8:",100,8
 ;;D^  ; I $L(OCXDT),'OCXDT,(OCXDT[" at ") D  ; EXTERNAL EXPERT SYSTEM FORMAT 1 TO EXTERNAL FORMAT
 ;;R^"860.8:",100,9
 ;;D^  ; .N OCXHR,OCXMIN,OCXTIME
 ;;R^"860.8:",100,10
 ;;D^  ; .S OCXTIME=$P($P(OCXDT," at ",2),".",1),OCXHR=$P(OCXTIME,":",1),OCXMIN=$P(OCXTIME,":",2)
 ;1;
 ;
