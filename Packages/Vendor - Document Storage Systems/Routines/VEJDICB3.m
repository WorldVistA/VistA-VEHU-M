VEJDICB3 ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 
 Q
 ;
 ; Code cloned from various ^IBCN* routines 
 ; 
DUPCO(DFN,IBCNS,IBCDFN,IBTALK) ; -- is this a duplicate company for this patient
 ; -- make this call after selecting a company
 ; -- input    DFN = patient file pointer (required)
 ;           IBCNS = new insurance company selected
 ;          IBCDFN = if added to patient ins type mult is required as enter number in multiple
 ;          IBTALK = (optional) if defined and true will write messages to current device if not queued
 ;  -- output      = $p1 - 0 if no other entry 1 if possible dup.
 ;                   $p2 - 1 if another active entry for same company
 ;                   $p3 - 1 if same co, same subscriber
 ;                   $p4 - 1 if same co, same dates
 ;                   $p5 - 1 if same co, same plan
 ;                   $p6 - 1 if spouse insurer but not listed
 ;                   $p7 - 1 if spouse insurer but no employer
 N IBI,IBJ,IBX,IBY,I,J,X,Y,Z,IBDUP,IBACT,IBCDFND
 S (I,IBDUP)=0
 I '$O(^DPT(DFN,.312,0)) Q IBDUP ; no policies on file, don't bother
 ;
 ; -- use b x-ref
 F  S I=$O(^DPT(DFN,.312,"B",IBCNS,I)) Q:'I  S IBX=$G(^DPT(DFN,.312,I,0)) I $S('$G(IBCDFN):1,I=$G(IBCDFN):0,1:1) D
 .S IBDUP=1
 .S IBACT=$$CHK^VEJDICB1(IBX,DT,2) I IBACT S $P(IBDUP,"^",2)=1 ; another active entry
 .I '$G(IBCDFN) Q  ;quit if not stored in dpt
 .I 'IBACT Q
 .;
 .S IBCDFND=$G(^DPT(DFN,.312,+IBCDFN,0)) I IBCDFND=""!(IBCDFND=+IBCDFND) Q
 .I $P(IBX,"^",6)=$P(IBCDFND,"^",6) S $P(IBDUP,"^",3)=1 ; same whose ins.
 .I $P(IBX,"^",4)="",$P(IBCDFND,"^",4)="" S $P(IBDUP,"^",4)=1 ; no expiration date
 .I $P(IBX,"^",8)="",$P(IBCDFND,"^",8)="" S $P(IBDUP,"^",4)=1 ; no effective date
 .; need to figure out overlapping date logic.  not simple
 .I $P(IBX,"^",18)=$P(IBCDFND,"^",18) S $P(IBDUP,"^",5)=1 ; same plan
 .I $P(IBCDFND,"^",6)="s" I $P(^DPT(DFN,0),"^",5)=6!($P(^DPT(DFN,0),"^",5)=7) S $P(IBDUP,"^",6)=1 ; marital status inconsistent
 .I $P(IBCDFND,"^",6)="s",$P($G(^DPT(DFN,.25)),"^")="" S $P(IBDUP,"^",7)=1
 I 'IBDUP Q IBDUP
 I IBDUP,$G(IBTALK),'$D(ZTQUEUED) D
 .;W !!,*7,"Warning:  Insurance Company selected already on file for this patient."
 .I $P(IBDUP,"^",2) ;W !,"          The previous entry is active."
 .I $P(IBDUP,"^",3) ;W !,"          The WHOSE INSURANCE are the same."
 .I $P(IBDUP,"^",4) ;W !,"          The Effective and Expiration dates may cover overlapping dates."
 .I $P(IBDUP,"^",5) ;W !,"          The Group Plans are the same."
 .I $P(IBDUP,"^",6) ;W !,"          WHOSE INSURANCE is Spouse, patient marital Status Inconsistent."
 .I $P(IBDUP,"^",7) ;W !,"          WHOSE INSURANCE is Spouse but no Employer listed."
 .Q
 ;
 Q IBDUP
 ;
DUPPOL(IBCPOL,IBTALK) ; -- is this a duplicate policy for this company
 N I,J,X,Y,Z,IBDUP,IBCNS
 S (I,IBDUP)=0,J=$G(^IBA(355.3,IBCPOL,0)),IBCNS=+J
 F  S I=$O(^IBA(355.3,"B",IBCNS,I)) Q:'I  I I'=IBCPOL S X=$G(^IBA(355.3,I,0)) D
 .Q:'$P(X,"^",2)  ;skip individual policies
 .I $P(J,"^",3)'="",$P(J,"^",3)=$P(X,"^",3) S $P(IBDUP,"^")=1
 .I $P(J,"^",4)'="",$P(J,"^",4)=$P(X,"^",4) S $P(IBDUP,"^",2)=1
 I IBDUP,$G(IBTALK),'$D(ZTQUEUED) D
 .I $P(IBDUP,"^",1) ;W !!,"Warning:  There is another policy with the same Group Name."
 .I $P(IBDUP,"^",2) ;W !!,"Warning:  There is another policy with the same Group Number."
 ;
 Q IBDUP
 ;
PTHLD(DFN,IBACT,IBTALK) ; search for all charges on hold due to insurance for a specific patient then update the On Hold Date or release charges
 ; From ^IBOHCR
 ;
 ;  Input:   DFN:    pointer to the patient in file #2
 ;           IBACT:  1 if ON HOLD DATE should be updated with todays date
 ;                   2 if charges should be immediately released
 ;           IBTALK: true if error message can be printed to screen
 ;
 ;  Returns: 1 if On Hold charges were found and processed
 ;
 N X,Y,IBPFN,IBX,IBRTN S IBRTN=""
 I '$G(DFN)!('$G(IBACT)) Q IBRTN
 ;
 ; find all charges on hold for patient then complete action
 S IBPFN=0 F  S IBPFN=$O(^IB("AH",DFN,IBPFN)) Q:'IBPFN  D
 . S IBX=$G(^IB(IBPFN,0)) I $P(IBX,U,5)'=8 Q
 . I IBACT=1 D HLDDT(IBPFN)
 . I IBACT=2 D RELEASE(IBPFN)
 . S IBRTN=1
 ;
 Q IBRTN
 ;
HLDDT(IBPFN) ; update a charge's on hold date to today
 ; From ^IBOHCR
 N IBX,IBY,IBERR
 S IBX=$G(^IB(IBPFN,0)) I $P(IBX,U,5)'=8 Q
 I $P($G(^IB(IBPFN,1)),U,6)>DT Q
 ;
 S IBY(350,IBPFN_",",16)=DT D FILE^DIE("K","IBY")
 Q
 ;
RELEASE(IBPFN) ; release a charge on hold
 ; From ^IBOHCR
 N IBX,IBSEQNO,IBDUZ,IBNOS,DFN,Y
 S IBX=$G(^IB(IBPFN,0)) I $P(IBX,U,5)'=8 Q
 ;
 S IBSEQNO=1,IBDUZ=DUZ,IBNOS=IBPFN,DFN=+$P(IBX,U,2) D ^IBR ;<<<=== Believed non-interactive (AR interface)
 I $G(Y)<1,+$G(IBTALK),'$D(ZTQUEUED) ;W !,?5,"Error encountered - a separate bulletin has been posted."
 Q
HOLD(DFN) ; returns true if patient has bills On Hold
 ; From ^IBCNBLL
 Q $D(^IB("AH",+$G(DFN)))
 ;
STATUS(IBBUFDA,STATUS,NC,NG,NP) ; edit the status node
 ; From ^IBCNBEE
 ;
 N IBX,IBARR,IBIFN Q:'$G(IBBUFDA)  S IBIFN=IBBUFDA_","
 D CHK^DIE(355.33,.04,"",$G(STATUS),.IBX) Q:IBX="^"
 ;
 S IBARR(355.33,IBIFN,.04)=STATUS I STATUS="R" S (NC,NG,NP)=0
 S IBARR(355.33,IBIFN,.07)=+$G(NC),IBARR(355.33,IBIFN,.08)=+$G(NG),IBARR(355.33,IBIFN,.09)=+$G(NP)
 D FILE^DIE("E","IBARR")
 Q
 ;
DELDATA(IBBUFDA) ; delete all insurance/group/policy data from buffer file entry, leaving stub entry
 ; From ^IBCNBED
 ; deletes all data with field numbers 1 or greater and blank nodes
 ;
 Q:'$G(^IBA(355.33,+$G(IBBUFDA),0))
 N DR,DA,DIE,DIC,X,Y,IBFLDS,IBIFN,IBFLD,IBCNT,IBI,IBX S IBIFN=IBBUFDA_",",DR="",IBCNT=1
 ;
 D GETS^DIQ(355.33,IBIFN,"1:999","IN","IBFLDS") ; returns all non-blank fields
 ;
 S IBFLD=0 F  S IBFLD=$O(IBFLDS(355.33,IBIFN,IBFLD)) Q:'IBFLD  D  ; set up DR string
 . I $L(DR)>200 S DR(1,355.33,IBCNT)=DR,DR="",IBCNT=IBCNT+1
 . S DR=DR_IBFLD_"///@;"
 ;
 I DR'="" D  ; delete data then nodes
 . S DIE="^IBA(355.33,",DA=IBBUFDA D ^DIE K DA,DIC,DIE,DR
 . ;
 . ; if Status is Entered, change it to Rejected, there should be no entry with a status of Entered without data
 . I $P(^IBA(355.33,IBBUFDA,0),U,4)="E" D STATUS(IBBUFDA,"R")
 ;
 ; kill blank nodes since DIE doesn't
 S IBI=0 F  S IBI=$O(^IBA(355.33,IBBUFDA,IBI)) Q:'IBI  S IBX=$G(^IBA(355.33,IBBUFDA,IBI)) I IBX?."^" K ^IBA(355.33,IBBUFDA,IBI)
 Q
