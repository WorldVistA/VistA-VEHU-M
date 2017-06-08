VEJDICB ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 
 Q
 ;
 ; Code cloned from various ^IBCN* routines 
 ; 
NEWINS(IBBUFDA) ; add new insurance carrier entry in Insurance Company (#36) file
 ; From ^IBCNBMN
 N DIC,DA,DIE,DR,X,Y,DLAYGO,IBINSDA,IB20,IBINSNM,IBREIMB
 S IBINSDA=0,IB20=$G(^IBA(355.33,+$G(IBBUFDA),20))
 S IBINSNM=$P(IB20,U,1) Q:IBINSNM="" IBINSDA
 ;
 S IBREIMB=$P(IB20,U,5) I IBREIMB'="" S DIC("DR")="1///"_IBREIMB ;will reimburse?
 K DD,DO S DIC="^DIC(36,",DIC(0)="L",X=IBINSNM,DLAYGO=36
 D FILE^DICN I +Y>0  S IBINSDA=+Y
 Q IBINSDA
 ;
NEWGRP(IBBUFDA,IBINSDA) ; add a new group/plan to the Group Insurance Plan (#355.3) file, also add standard fields
 ; From ^IBCNBMN
 N DIC,DA,DR,DIE,X,Y,DLAYGO,IBGRPDA,IB40,IBFIELDS,IBERR,IBXIFN
 S IBGRPDA=0,IB40=$G(^IBA(355.33,+$G(IBBUFDA),40))
 I '$D(^DIC(36,+$G(IBINSDA),0)) Q IBGRPDA
 I $P(IB40,U,1)=0,'$G(^IBA(355.33,+$G(IBBUFDA),60)) Q IBGRPDA
 ;
 K DA,DO S DIC="^IBA(355.3,",DIC(0)="L",X=IBINSDA,DLAYGO=355.3
 D FILE^DICN I +Y'>0 Q IBGRPDA
 S IBGRPDA=+Y,IBXIFN=IBGRPDA_","
 ;
 S IBFIELDS(355.3,IBXIFN,.02)=$P(IB40,U,1) ;group plan?
 I $P(IB40,U,1)=0 S IBFIELDS(355.3,IBXIFN,.1)=+$G(^IBA(355.33,+$G(IBBUFDA),60)) ;individual plan patient
 D FILE^DIE("","IBFIELDS","IBERR")
 Q IBGRPDA
 ;
NEWPOL(IBBUFDA,IBINSDA,IBGRPDA) ; add a new patient policy to the Patient's Insurance Policys (2.312), also add standard fields
 ; From ^IBCNBMN
 N DIC,DA,DR,DIE,X,Y,IBPOLDA,IBFIELDS,IBERR,DFN,IBGRP,IBXIFN
 S IBPOLDA=0
 I '$D(^DIC(36,+$G(IBINSDA),0)) Q IBPOLDA
 S IBGRP=$G(^IBA(355.3,+$G(IBGRPDA),0)) I +IBGRP'=IBINSDA Q IBPOLDA
 S DFN=+$G(^IBA(355.33,+$G(IBBUFDA),60)) I 'DFN Q IBPOLDA
 I $P(IBGRP,U,10)'="",$P(IBGRP,U,10)'=DFN Q IBPOLDA
 ;
 ; IB*2*211
 L +^DPT(DFN,.312):5 I '$T D LOCKED Q IBPOLDA
 I $G(^DPT(DFN,.312,0))="" S ^DPT(DFN,.312,0)="^2.312PAI^^"
 ;
 K DA,DO S DIC="^DPT("_DFN_",.312,",DIC(0)="L",X=IBINSDA,DA(1)=DFN
 D FILE^DICN I +Y'>0 Q IBPOLDA
 S IBPOLDA=+Y,IBXIFN=IBPOLDA_","_DFN_","
 ;
 S IBFIELDS(2.312,IBXIFN,.18)=IBGRPDA ;policy's group/plan
 S IBFIELDS(2.312,IBXIFN,1.09)=$P($G(^IBA(355.33,+$G(IBBUFDA),0)),U,3) ;source
 S IBFIELDS(2.312,IBXIFN,1.1)=+$G(^IBA(355.33,+$G(IBBUFDA),0)) ;source date
 D FILE^DIE("","IBFIELDS","IBERR")
 L -^DPT(DFN,.312)
 Q IBPOLDA
 ;
INS(IBBUFDA,IBINSDA,TYPE) ;  move buffer insurance company data (file 355.33) to existing Insurance Company (file 36)
 ; From ^IBCNBMI
 S IBBUFDA=IBBUFDA_",",IBINSDA=$G(IBINSDA)_","
 D SET("INS",IBBUFDA,IBINSDA,TYPE)
 Q
 ;
GRP(IBBUFDA,IBGRPDA,TYPE) ;  move buffer insurance group/plan data (file 355.33) to existing Group/Plan (file 355.3)
 ; From ^IBCNBMI
 S IBBUFDA=IBBUFDA_",",IBGRPDA=$G(IBGRPDA)_","
 D SET("GRP",IBBUFDA,IBGRPDA,TYPE)
 D STUFF("GRP",IBGRPDA)
 Q
 ;
POLICY(IBBUFDA,IBPOLDA,TYPE) ;  move buffer insurance policy data (file 355.33) to existing Patient Policy (file 2.312)
 ;
 N DFN S DFN=+$G(^IBA(355.33,+$G(IBBUFDA),60)) Q:'DFN
 ;
 S IBBUFDA=IBBUFDA_",",IBPOLDA=$G(IBPOLDA)_","_DFN_","
 D SET("POL",IBBUFDA,IBPOLDA,TYPE)
 D STUFF("POL",IBPOLDA)
 D POLOTH^VEJDICA(IBBUFDA,IBPOLDA)
 Q
 ;
SET(SET,IBBUFDA,IBEXTDA,TYPE) ; move buffer data to insurance files
 ; From ^IBCNBMI
 ; Input:  IBBUFDA - ifn of Buffer File entry to move (#355.33)
 ;         IBEXTDA - ifn of insurance entry to update (#36,355.3,2)
 ;         TYPE    - 1 = Merge     (only buffer data moved to blank fields in ins file, no replace)
 ;                   2 = Overwrite (all buffer data moved to ins file, replace existing data)
 ;                   3 = Replace (all buffer data including null move to ins file)
 ;                   4 = Individually Accept (Skip Blanks) (user accepts)
 ;  individual diffs b/w buffer data and existing file data (excl blanks)
 ;  to overwrite flds (or addr grp) in existing file)
 ;
 ;
 N IBX,IBFLDS,EXTFILE,DRBUF,DREXT,BUFARR,EXTARR
 N IBBUFFLD,IBEXTFLD,IBBUFVAL,IBEXTVAL,IBCHNG,IBCHNGN,IBERR
 ;
 D FIELDS(SET_"FLD")
 S IBX=$P($T(@(SET_"DR")+1),";;",2),EXTFILE=+$P(IBX,U,1),DRBUF=$P(IBX,U,2),DREXT=$P(IBX,U,3)
 ;
 D GETS^DIQ(355.33,IBBUFDA,DRBUF,"E","BUFARR")
 D GETS^DIQ(EXTFILE,IBEXTDA,DREXT,"E","EXTARR")
 ;
 I +$G(TYPE) S IBBUFFLD=0 F  S IBBUFFLD=$O(BUFARR(355.33,IBBUFDA,IBBUFFLD)) Q:'IBBUFFLD  D
 . S IBEXTFLD=$G(IBFLDS(IBBUFFLD)) Q:'IBEXTFLD
 . S IBBUFVAL=BUFARR(355.33,IBBUFDA,IBBUFFLD,"E")
 . S IBEXTVAL=$G(EXTARR(EXTFILE,IBEXTDA,IBEXTFLD,"E"))
 . ;
 . I IBBUFVAL=IBEXTVAL Q
 . I TYPE=1,IBEXTVAL'="" Q
 . I TYPE=2,IBBUFVAL="" Q
 . I TYPE=4,'$D(^TMP($J,"IB BUFFER SELECTED",IBBUFFLD)) Q
 . ;
 . S IBCHNG(EXTFILE,IBEXTDA,IBEXTFLD)=IBBUFVAL
 . S IBCHNGN(EXTFILE,IBEXTDA,IBEXTFLD)=""
 ;
 I $D(IBCHNGN)>9 D FILE^DIE("E","IBCHNGN","IBERR")
 I $D(IBCHNG)>9 D FILE^DIE("E","IBCHNG","IBERR")
 Q
 ;
STUFF(SET,IBEXTDA) ; update fields in insurance files that should be
 ; set automatically when an entry is edited
 ; From ^IBCNBMI
 ; 
 ; Input:  IBEXTDA - ifn of insurance entry to update (#36,356,2)
 ;
 N IBX,IBFLDS,EXTFILE,IBEXTFLD,IBEXTVAL,IBCHNG,IBCHNGN,IBERR
 ;
 D FIELDS(SET_"A")
 S IBX=$P($T(@(SET_"DR")+1),";;",2),EXTFILE=+$P(IBX,U,1)
 ;
 S IBEXTFLD=0 F  S IBEXTFLD=$O(IBFLDS(IBEXTFLD)) Q:'IBEXTFLD  D
 . S IBEXTVAL=IBFLDS(IBEXTFLD) I IBEXTVAL="DUZ" S IBEXTVAL="`"_DUZ
 . S IBCHNG(EXTFILE,IBEXTDA,IBEXTFLD)=IBEXTVAL
 . S IBCHNGN(EXTFILE,IBEXTDA,IBEXTFLD)=""
 ;
 D FILE^DIE("E","IBCHNGN","IBERR")
 D FILE^DIE("E","IBCHNG","IBERR")
 Q
 ;
FIELDS(SET) ; return array of corresponding fields: IBFLDS(Buffer #)=Ins #
 N IBI,IBLN,IBB,IBE,IBG K IBFLDS,IBADDS,IBLBLS
 F IBI=1:1 S IBLN=$P($T(@(SET)+IBI),";;",2) Q:IBLN=""  I $E(IBLN,1)'=" " D
 . S IBB=$P(IBLN,U,1),IBE=$P(IBLN,U,2),IBG=$P(IBLN,U,4)
 . I IBB'="",IBE'="" D
 .. S IBFLDS(IBB)=IBE
 .. I SET["FLD" S IBLBLS(IBB)=$P(IBLN,U,3) I +IBG S IBADDS(IBB)=IBE
 Q
 ;
LOCKED ;;
 S RESULT="-1^Record is locked.  Try later."
 Q
 ; ***** Fields lists from ^IBCNBMI
INSDR ;
 ;;36^20.02:20.04;21.01:21.06^.131;.132;.133;.111:.116
INSFLD ; corresponding fields:  Buffer File (355.33) and Insurance Company file (36)
 ;;20.02^.131^Phone Number^           ; MM Phone Number
 ;;20.03^.132^Billing Phone^          ; Billing Phone Number
 ;;20.04^.133^Pre-Cert Phone^         ; Pre-Certification Phone Number
 ;;21.01^.111^Street [Line 1]^1       ; MM Street Address [Line 1]
 ;;21.02^.112^Street [Line 2]^1       ; MM Street Address [Line 2]
 ;;21.03^.113^Street [Line 3]^1       ; MM Street Address [Line 3]
 ;;21.04^.114^City^1                  ; MM City
 ;;21.05^.115^State^1                 ; MM State
 ;;21.06^.116^Zip^1                   ; MM Zip Code
 ;
GRPDR ;
 ;;355.3^40.02:40.09;40.1;40.11;40.5;^.03:.04;6.02;6.03;.05:.09;.12
GRPFLD ;corresponding fields:  Buffer File (355.33) and Insurance Group Plan file (355.3)
 ;;40.02^.03^Group Name^              ; Group Name
 ;;40.03^.04^Group Number^            ; Group Number
 ;;40.1^6.02^BIN^                     ; BIN ;;Daou/EEN
 ;;40.11^6.03^PCN^                    ; PCN ;;Daou/EEN
 ;;40.04^.05^Require UR^              ; Utilization Review Required
 ;;40.05^.06^Require Pre-Cert^        ; Pre-Certification Required
 ;;40.06^.12^Require Amb Cert^        ; Ambulatory Care Certification
 ;;40.07^.07^Exclude Pre-Cond^        ; Exclude Pre-Existing Conditions
 ;;40.08^.08^Benefits Assign^         ; Benefits Assignable
 ;;40.09^.09^Type of Plan^            ; Type of Plan
 ;
GRPA ; auto set fields
 ;;1.05^NOW^                          ; Date Last Edited
 ;;1.06^DUZ^                          ; Last edited By
 ;
POLDR ;
 ;;2.312^60.02:61.12^8;3;1;6;16;17;3.01;3.05;4.01;4.02;.2;2.1;2.015;2.11;2.12;2.01:2.08
POLFLD ; corresponding fields:  Buffer File (355.33) and Insurance Patient Policy file (2.312)
 ;;60.02^8^Effective Date^            ; Effective Date
 ;;60.03^3^Expiration Date^           ; Expiration Date
 ;;60.04^1^Subscriber Id^             ; Subscriber Id
 ;;60.05^6^Whose Insurance^           ; Whose Insurance
 ;;60.06^16^Relationship^             ; Pt. Relationship to Insured
 ;;60.07^17^Name of Insured^          ; Name of Insured
 ;;60.08^3.01^Insured's DOB^          ; Insured's DOB
 ;;60.09^3.05^Insured's SSN^          ; Insured's SSN
 ;;60.1^4.01^Primary Provider^        ; Primary Care Provider
 ;;60.11^4.02^Provider Phone^         ; Primary Care Provider Phone
 ;;60.12^.2^Coor of Benefits^         ; Coordination of Benefits
 ;;  
 ;;61.01^2.1^Emp Sponsored^           ; ESGHP?
 ;;61.02^2.015^Employer Name^         ; Subscriber's Employer Name
 ;;61.03^2.11^Emp Status^             ; Employment Status
 ;;61.04^2.12^Retirement Date^        ; Retirement Date
 ;;61.05^2.01^Send to Employer^       ; Send Bill to Employer?
 ;;61.06^2.02^Emp Street Ln 1^1       ; Employer Claims Street Line 1
 ;;61.07^2.03^Emp Street Ln 2^1       ; Employer Claims Street Line 2
 ;;61.08^2.04^Emp Street Ln 3^1       ; Employer Claims Street Line 3
 ;;61.09^2.05^Emp City^1              ; Employer Claims City
 ;;61.1^2.06^Emp State^1              ; Employer Claims State
 ;;61.11^2.07^Emp Zip Code^1          ; Employer Claims Zip Code
 ;;61.12^2.08^Emp Phone^              ; Employer Claims Phone
 ;
POLA ; auto set fields
 ;;1.03^NOW^                          ; Date Last Verified (default is person that accepts entry)
 ;;1.04^DUZ^                          ; Verified By        (default is person that accepts entry)
 ;;1.05^NOW^                          ; Date Last Edited
 ;;1.06^DUZ^                          ; Last Edited By
 ;
 ;
