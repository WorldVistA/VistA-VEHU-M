VEJDICA ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 
 Q
 ;
 ; The following code is cloned from ^IBCN* routines, bypassing I/O
 ; 
ACCEPT(RESULT,IBBUFDA,DFN,IBINSDA,IBGRPDA,IBPOLDA,IBMVINS,IBMVGRP,IBMVPOL,IBNEWINS,IBNEWGRP,IBNEWPOL,IVMREPTR,VEJDAUDT) ;;
 ; Implements VEJDIC ACCEPT BUFFER ENTRY remote procedure
 ; Cloned from ACCEPT^IBCNBAR bypassing I/O
 ; 
 ; IBBUFDA=INSURANCE BUFFER file internal entry number (required)
 ; DFN=PATIENT file internal entry number (required)
 ; IBINSDA=File 36 IEN if not adding new entry
 ; IBGRPDA=File 355.3 IEN if not adding new entry
 ; IBPOLDA=File 2.312 IEN if not adding new entry
 ; IBMVINS=Type for INSURANCE 1=Merge, 2=Overwrite, 3=Replace, 4=Unsupported 
 ; IBMVGRP=Type for GROUP     1=Merge, etc.
 ; IBMVPOL=Type for POLICY    1=Merge, etc.
 ; IBNEWINS=Add new INSURANCE COMPANY flag (non-zero means add)
 ; IBNEWGRP=Add new GROUP INSURANCE PLAN flag (non-zero means add)
 ; IBNEWPOL=Add new patient insurance policy (non-zero means add)
 ; IVMREPTR=File 301.91 IEN if applicable (IVM REASONS FOR NOT UPLOADING...)
 ; VEJDAUDT=File 19625 IEN if updating patient policy or group plan COMMENT
 ; 
 S RESULT="-1^INSURANCE BUFFER IEN required" Q:'$G(IBBUFDA)
 S RESULT="-1^INSURANCE BUFFER ENTRY PREVIOUSLY PROCESSED"
 Q:"~A~R~"[("~"_$$GET1^DIQ(355.33,IBBUFDA,.04,"I")_"~")
 S RESULT="-1^PATIENT IEN required" Q:'$G(DFN)  N VEJDFN S VEJDFN=DFN
 I $D(IBINSDA)>1 N I,X F I=1:1 Q:'($D(IBINSDA(I))#2)  D  ;Alternate parameter list
 .S X=$P(IBINSDA(I),U)
 .Q:'(",IBINSDA,IBGRPDA,IBPOLDA,IBMVINS,IBMVGRP,IBMVPOL,IBNEWINS,IBNEWGRP,IBNEWPOL,IVMREPTR,VEJDAUDT,"[(","_X_","))
 .S @(X_"=$P(IBINSDA(I),U,2,99)")
 .Q
 S IBINSDA=$G(IBINSDA),IBGRPDA=$G(IBGRPDA),IBPOLDA=$G(IBPOLDA)
 S IBMVINS=$G(IBMVINS,2),IBMVGRP=$G(IBMVGRP,2),IBMVPOL=$G(IBMVPOL,2)
 S IBNEWINS=$G(IBNEWINS),IBNEWGRP=$G(IBNEWGRP),IBNEWPOL=$G(IBNEWPOL)
 S VEJDAUDT=$G(VEJDAUDT)
 ;
 N IVMINSUP,IBNEW,IBCDFN
 S IBCDFN=IBPOLDA S:+IBNEWPOL IBNEW=1
 D BEFORE ; insurance event driver
 ;
 N X,Y,IBX,IBINSH,IBGRPH,IBPOLH
 S (IBINSH,IBGRPH,IBPOLH)="Updated"
 ;
 S RESULT="-1^Add new INSURANCE COMPANY failed"
 I +IBNEWINS D  Q:'IBINSDA  S IBINSH="Created"
 .S IBINSDA=+$$NEWINS^VEJDICB(IBBUFDA)
 .Q
 ;
 S RESULT="-1^Add new GROUP INSURANCE PLAN failed"
 I +IBNEWGRP D  Q:'IBGRPDA  S IBGRPH="Created"
 .S IBGRPDA=+$$NEWGRP^VEJDICB(IBBUFDA,+IBINSDA)
 .Q
 N VEJDGPDA S VEJDGPDA=IBGRPDA ;For COMMENT
 ;
 S RESULT="-1^Add new patient insurance policy failed"
 I +IBNEWPOL D  Q:'IBPOLDA  S IBPOLH="Created"
 .S IBPOLDA=+$$NEWPOL^VEJDICB(IBBUFDA,+IBINSDA,+IBGRPDA)
 .Q
 N VEJDNSDA S VEJDNSDA=IBPOLDA ;For COMMENT
 ;
 S RESULT="-1^Move TYPE parameter value="_IBMVINS_" is invalid"
 Q:"1^2^3"'[IBMVINS
 S RESULT="-1^Move buffer data to insurance files failed"
 I +IBINSDA,+IBMVINS D INS^VEJDICB(IBBUFDA,IBINSDA,+IBMVINS)
 I +IBINSDA,+IBMVGRP,+IBGRPDA D GRP^VEJDICB(IBBUFDA,IBGRPDA,+IBMVGRP)
 I +IBINSDA,+IBMVPOL,+IBGRPDA,+IBPOLDA D POLICY^VEJDICB(IBBUFDA,IBPOLDA,+IBMVPOL)
 ;
 ; Cleanup
 N IBSOURCE S IBSOURCE=$P($G(^IBA(355.33,IBBUFDA,0)),U,3)
 ;
 D POL^VEJDICB1(DFN) ;update Tricare sponsor data
 D COVERED^VEJDICB1(DFN) ;update 'Covered by Insurance' field (2,.3192
 I +IBSOURCE=3 D IVM(1,IBBUFDA) ;update/notify IVM
 I +IBINSDA,+IBPOLDA S IBX=$$DUPCO^VEJDICB3(DFN,IBINSDA,IBPOLDA,1) ;warning if duplicate policy added for patient
 S RESULT="0"_$S(IBX:"^Warning - Duplicate or inconsistent insurance data",1:"")
 I +IBGRPDA S IBX=$$DUPPOL^VEJDICB3(IBGRPDA,1) ;warning if duplicate plan was added
 S:IBX RESULT=RESULT_"^Warning - Duplicate or inconsistent policy data"
 I +IBNEWPOL I +$$PTHLD^VEJDICB3(DFN,1,1) ;W !!,"Patient's bills On Hold date updated due to new insurance."
 I  S RESULT=RESULT_"^Patient's bills On Hold date updated due to new insurance"
 I $$HOLD^VEJDICB3(DFN) ;W !!,"There are bills On Hold for this patient."
 I  S RESULT=RESULT_"^There are bills On Hold for this patient"
 ; . . . view omitted . . .
 ; update buffer file entry so only stub remains and status is changed
 D STATUS^VEJDICB3(IBBUFDA,"A",IBNEWINS,IBNEWGRP,IBNEWPOL) ;update buffer entry's status to accepted
 D DELDATA^VEJDICB3(IBBUFDA) ;delete buffer's insurance/patient data
 ;
 S IBCDFN=IBPOLDA S:+IBSOURCE=3 IVMINSUP=1
 D AFTER
 D:VEJDAUDT  ;Update COMMENT fields
 .N VEJD D GETS^DIQ(19625,+VEJDAUDT,"4;4.1",,"VEJD")
 .S VEJD=$NA(VEJD(19625,+VEJDAUDT_","))
 .D:$G(@VEJD@(4))]""  ;Patient policy comment
 ..N VEJDIENS S VEJDIENS=+VEJDNSDA_","_+VEJDFN_","
 ..N VEJDFDA S VEJDFDA(2.312,VEJDIENS,1.08)=@VEJD@(4)
 ..D FILE^DIE(,"VEJDFDA")
 ..Q
 .D:$G(@VEJD@(4.1,1))]""  ;Group plan comment (WP)
 ..D WP^DIE(355.3,VEJDGPDA_",",11,,$NA(@VEJD@(4.1))) ;KC 8.31.05 Remove "A" append flag
 ..Q
 .Q
 D ^IBCNSEVT ;<<<=== Believed non-interactive - insurance event driver
 ; 
 Q
REJECT(RESULT,IBBUFDA) ;;
 ; Implements VEJDIC REJECT remote procedure
 ; Cloned from REJECT^IBCNBAR bypassing I/O
 Q
IVM(AR,IBBUFDA) ; IVM must be notified whenever a buffer entry that originated in IVM is accepted or rejected
 ; From ^IBCNBAR
 ; this lets them clean up their files since they also have a buffer type file of insurance uploaded from the IVM center
 ; if rejected they then ask the user for a reason it was rejected
 ; input:  AR = 1 if accepted, 0 if rejected
 ;
 N DFN,IBX,IBY I $P($G(^IBA(355.33,+IBBUFDA,0)),U,3)'=3 Q
 ;
 S DFN=+$G(^IBA(355.33,+IBBUFDA,60))
 S IBX=$P($G(^IBA(355.33,+IBBUFDA,20)),U,1)_U_$P($G(^IBA(355.33,+IBBUFDA,21)),U,1)_U_$P($G(^IBA(355.33,+IBBUFDA,40)),U,3)
 ;
 S IBY=$$UPDATE^VEJDICB2(DFN,AR,IBX)
 Q
BEFORE ; -- get insurance type values before adding/editing
 ; From ^IBCNSEVT
 I $G(IBNEW) S (IBEVTP0,IBEVTP1,IBEVTP2)="" Q
 S IBEVTP0=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBEVTP1=$G(^DPT(DFN,.312,IBCDFN,1))
 S IBEVTP2=$G(^DPT(DFN,.312,IBCDFN,2))
 Q
AFTER ; -- get insurance type values after adding/editing. set action flag.
 ; From ^IBCNSEVT
 ; -- get exemption after change
 ;    input  =:  dfn    = patient file ien
 ;
 S IBEVTA0=$G(^DPT(DFN,.312,IBCDFN,0))
 S IBEVTA1=$G(^DPT(DFN,.312,IBCDFN,1))
 S IBEVTA2=$G(^DPT(DFN,.312,IBCDFN,2))
 I IBEVTP0="",IBEVTA0'="" S IBEVTACT="ADD"
 I IBEVTP0'="",IBEVTA0'="" S IBEVTACT="EDT"
 I IBEVTP0'="",IBEVTA0="" S IBEVTACT="DEL"
 Q
POLOTH(IBBUFDA,IBPOLDA) ; other special cases that cannot be transfered
 ; using the genaric code above, usually because of dependencys
 ; From ^IBCNBMI
 N IB0 S IB0=$G(^IBA(355.33,+IBBUFDA,0))
 ;
 ;  --- if buffer entry was verified before the accept step, then add the correct verifier info to the policy
 I +$P(IB0,U,10) D
 . S IBCHNG(2.312,IBPOLDA,1.03)=$E($P(IB0,U,10),1,12),IBCHNGN(2.312,IBPOLDA,1.03)=""
 . S IBCHNG(2.312,IBPOLDA,1.04)=$P(IB0,U,11),IBCHNGN(2.312,IBPOLDA,1.04)=""
 ;
 I $D(IBCHNGN)>9 D FILE^DIE("I","IBCHNGN","IBERR")
 I $D(IBCHNG)>9 D FILE^DIE("I","IBCHNG","IBERR")
 Q
