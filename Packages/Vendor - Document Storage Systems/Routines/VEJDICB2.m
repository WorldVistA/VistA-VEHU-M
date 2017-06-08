VEJDICB2 ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 
 Q
 ;
 ; Code cloned from various ^IVM* routines 
 ; 
UPDATE(DFN,IVMINSST,IVMID) ;
 ; From ^IVMLINS4
 ;
 ; Input:       DFN  --  internal entry number of PATIENT file
 ;         IVMINSST  --  upload status 1-accepted  0-rejected
 ;            IVMID  --  ins. co. name ^ street add[line 1] ^ group #
 ;
 ; Output: returns 1 if updated or 0 followed by error if not updated
 ;
 N IVM1INSN,IVM2SA1,IVM3GNU,IVMI,IVMIBERR,IVMJ,IVMDA,IVMDAIN,IVMFOUND,IVMREPTR
 I '$G(DFN)!('$D(^DPT(+DFN,0))) S IVMIBERR="No patient defined" G EXIT
 I '$D(^IVM(301.5,"B",DFN)) S IVMIBERR="Patient not in IVM PATIENT file" G EXIT
 ;
 I $G(IVMINSST)'=0&($G(IVMINSST)'=1) S IVMIBERR="upload status not accepted or rejected" G EXIT
 ;
 ; - check id fields
 S IVM1INSN=$P(IVMID,"^")
 S IVM2SA1=$P(IVMID,"^",2)
 S IVM3GNU=$P(IVMID,"^",3)
 I IVM1INSN']"" S IVMIBERR="no insurance company name from MCCR insurance module" G EXIT
 I IVM2SA1']"" S IVMIBERR="no street address from MCCR insurance module" G EXIT
 I IVM3GNU']"" S IVMIBERR="no group number from MCCR insurance module" G EXIT
 ;
 S IVMDA=0
 F  S IVMDA=$O(^IVM(301.5,"B",DFN,IVMDA)) Q:'IVMDA  D FIND Q:$G(IVMFOUND)
 G PROCESS
 ;
 ; - find ins. record in IVM PATIENT file
FIND S IVMDAIN=0
 F  S IVMDAIN=$O(^IVM(301.5,IVMDA,"IN",IVMDAIN)) Q:'IVMDAIN  D  Q:$G(IVMFOUND)
 .; - record missing
 .Q:'$D(^IVM(301.5,IVMDA,"IN",IVMDAIN,0))
 .Q:'$D(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"))
 .;
 .; - if 2nd piece not null - skip record - insurance record not transferred
 .Q:$P($G(^IVM(301.5,IVMDA,"IN",IVMDAIN,0)),"^",2)]""
 .;
 .; - if 4th piece not null - skip record - already uploaded or rejected
 .Q:$P($G(^IVM(301.5,IVMDA,"IN",IVMDAIN,0)),"^",4)]""
 .;
 .; - check 3 fields in ^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST") if not 3 matches - skip record
 .Q:$P(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"),"^",4)'=IVM1INSN
 .Q:$P($P(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"),"^",5),"~")'=IVM2SA1
 .Q:$P(^IVM(301.5,IVMDA,"IN",IVMDAIN,"ST"),"^",8)'=IVM3GNU
 .; - if ins record found
 .S IVMFOUND=1
 .Q
 Q
 ;
PROCESS I 'IVMDAIN S IVMIBERR="Insurance data not found in IVM PATIENT file" G EXIT
 ;
 N DA,DTOUT,DUOUT,DR,DIE,Y
 ;
 ; - if the insurance data is accepted do
 I IVMINSST D  G DEL
 .;
 .; - stuff UPLOAD INSURANCE DATA(.04), UPLOADED INSURANCE DATE/TIME(.05)
 .S DA=IVMDAIN,DA(1)=IVMDA
 .S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 .S DR=".04////1;.05///NOW" D ^DIE
 ;
 ; - if the insurance data is rejected do
 ; - ask for reason why
 ;
 ;W !!,"The 'Reject IVM Insurance Policy' action has been selected."
 ;
 ;W !,"Please select a reason for rejecting the IVM insurance information."
 ;
 S IVMREPTR=$G(IVMREPTR) I 'IVMREPTR S IVMIBERR="No reason selected" G EXIT
 ;
 ;S DIC="^IVM(301.91,",DIC("A")="Select reason for rejecting: ",DIC(0)="QEAMZ"
 ;D ^DIC K DIC I Y<0!($D(DTOUT))!($D(DUOUT)) S IVMIBERR="No reason selected" G EXIT
 ;S IVMREPTR=+Y
 ;
 ; stuff UPLOAD INSURANCE DATA(.04) and REASON NOT UPLOADING INSURANCE
 ; (.08)
 S DA=IVMDAIN,DA(1)=IVMDA
 S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 S DR=".04////0;.08////^S X=IVMREPTR" D ^DIE
 ;
DEL ; - delete incoming segments strings
 K ^IVM(301.5,DA(1),"IN",DA,"ST"),^("ST1")
 ;
 ; - send HL7 message to IVM Center
 ;
 S IVMI=DA(1),IVMJ=DA
 D HL7^IVMLINS2 ;<<<=== Non-interactive - Send HL7 message to HEC
 ;
EXIT Q $S($D(IVMIBERR):0,1:1)_"^"_$G(IVMIBERR)
