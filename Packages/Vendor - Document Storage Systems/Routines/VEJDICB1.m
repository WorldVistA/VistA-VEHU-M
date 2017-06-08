VEJDICB1 ;DSS/LM - Insurance card RPC's ;12/14/2004
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ; 
 Q
 ;
 ; Code cloned from various ^IBCN* routines 
 ; 
POL(DFN) ; Update TRICARE policies with Sponsor information.
 ; From ^IBCNSU41
 ;  Input:   DFN  --  Pointer to the patient in file #2
 ;
 I '$G(DFN) Q
 N IBX,IBY,SPON,X,X1,X3,Y,Z
 ;
 S X=0 F  S X=$O(^IBA(355.81,"B",DFN,X)) Q:'X  D  Q:$D(Z)
 .S Y=$G(^IBA(355.81,X,0))
 .;
 .; - relationship must be with a Tricare sponsor
 .Q:$P(Y,"^",4)'="T"
 .;
 .S SPON=$G(^IBA(355.8,+$P(Y,"^",2),0)) Q:SPON=""
 .;
 .; - if sponsor is a patient, get name/dob/SSN from the patient
 .;   file; otherwise, use file #355.82
 .I $P(SPON,"^")["DPT" D
 ..S X1=$G(^DPT(+SPON,0)) Q:X1=""
 ..S Z("NAME")=$P(X1,"^"),Z("DOB")=$P(X1,"^",3),Z("SSN")=$P(X1,"^",9)
 .E  D
 ..S X1=$G(^IBA(355.82,+SPON,0)) Q:X1=""
 ..S Z("NAME")=$P(X1,"^"),Z("DOB")=$P(X1,"^",2),Z("SSN")=$TR($P(X1,"^",3),"-","")
 .;
 .S Z("BRAN")=$P(SPON,"^",3),Z("RANK")=$P(SPON,"^",4)
 ;
 ; - if no Tricare sponsors were found, quit.
 I '$D(Z) Q
 ;
 ; - update any policies with TRICARE plans
 S IBX=0 F  S IBX=$O(^DPT(DFN,.312,IBX)) Q:'IBX  S IBY=$G(^(IBX,0)) D
 .;
 .; - only consider TRICARE plans
 .Q:$P($G(^IBE(355.1,+$P($G(^IBA(355.3,+$P(IBY,"^",18),0)),"^",9),0)),"^",3)'=7
 .;
 .; - the policyholder should not be the veteran (patient)
 .Q:$P(IBY,"^",6)="v"
 .;
 .; - if a sponsor DOB exists, be sure it's the same as the
 .;   sponsor file DOB
 .S X3=$G(^DPT(DFN,.312,IBX,3))
 .I X3,+X3'=Z("DOB") Q
 .;
 .S DR=""
 .;IB*2*211
 .I $P(IBY,"^",17)="" S DR=DR_"17////"_Z("NAME")_";"
 .I $P(X3,"^")="",Z("DOB") S DR=DR_"3.01////"_Z("DOB")_";"
 .I $P(X3,"^",2)="",Z("BRAN") S DR=DR_"3.02////"_Z("BRAN")_";"
 .I $P(X3,"^",3)="",Z("RANK")]"" S DR=DR_"3.03////"_Z("RANK")_";"
 .I $P(X3,"^",5)="",Z("SSN")]"" S DR=DR_"3.05////"_Z("SSN")_";"
 .;
 .Q:DR=""
 .I $E(DR,$L(DR))=";" S DR=$E(DR,1,$L(DR)-1)
 .;
 .S DIE="^DPT(DFN,.312,",DA(1)=DFN,DA=IBX D ^DIE K DA,DIE,DR
 ;
 Q
COVERED(DFN,IBCOVP) ; -- update covered by insurance in background
 ; From ^IBCNSM31
 ; -- input ibcovp = the covered by insurance field prior to editing
 ;                   (add/edit/delete) of the 2.312 insurance type mult.
 ;
 Q:$G(DFN)<1
 N X,Y,I,IBCOV,IBNCOV,DA,DR,DIE,DIC,IBINS,IBINSD
 S (IBCOV,IBNCOV)=$P($G(^DPT(DFN,.31)),"^",11)
 D ALL(DFN,"IBINS",2,DT) S IBINSD=+$G(IBINS(0))
 ;
 ; -- initial value ="" or Unknown
 I $G(IBCOVP)=""!($G(IBCOVP)="U") S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"U",IBINSD:"Y",1:"N")
 ;
 ; -- initial value = YES or NO (treat the same)
 I $G(IBCOVP)="Y"!($G(IBCOVP)="N") S IBNCOV=$S('$O(^DPT(DFN,.312,0)):"N",IBINSD:"Y",1:"N")
 ;
 ;
 I IBCOV'=IBNCOV D
 .S DIE="^DPT(",DR=".3192////"_IBNCOV,DA=DFN D ^DIE
 .I '$D(ZTQUEUED) ;W !!,"COVERED BY HEALTH INSURANCE changed to '"_$S(IBNCOV="Y":"YES",IBNCOV="N":"NO",1:"UNKNOWN"),"'.",!
 .;H 3
 .Q
 Q
ALL(DFN,VAR,ACT,ADT,SOP) ; -- find all insurance data on a patient
 ; From ^IBCNS1
 ;
 ; -- input DFN  = patient
 ;          VAR  = variable to output in format of abc
 ;                 or abc(dfn)
 ;                 or ^tmp($j,"Insurance")
 ;          ACT  = 1 if only active ins. desired
 ;               = 2 if active and will not reimburse desired
 ;               = 3 if active, will not reimburse, and indemnity are
 ;                 all desired (for the $$INSTYP function below)
 ;               = 4 if only active and MEDICARE WNR only desired
 ;          ADT  = if ACT=1 or 4, then ADT is the internal date to check
 ;                 active for, default = dt
 ;          SOP  = if SOP=1, then sort policies in COB order
 ;
 ; -- output var(0)   =: number of entries insurance multiple
 ;           var(x,0) =: ^dpt(dfn,.312,x,0)
 ;           var(x,1) =: ^dpt(dfn,.312,x,1)
 ;           var(x,2) =: ^dpt(dfn,.312,x,2)
 ;           var(x,3) =: ^dpt(dfn,.312,x,3)
 ;           var(x,4) =: ^dpt(dfn,.312,x,4)
 ;       var(x,355.3) =: ^iba(355.3,$p(var(x,0),"^",18),0)
 ;       var("S",COB sequence,x) =: (null) as an xref for COB
 ;
 N X,IBMRA,IBSP
 S X=0 I $G(ACT),$E($G(ADT),1,7)'?7N S ADT=DT
 S (IBMRA,IBSP)=0 ;Flag to say if pt has medicare wnr, spouse has policy
 F  S X=$O(^DPT(DFN,.312,X)) Q:'X  I $D(^(X,0)) D
 .I $G(ACT),'$$CHK(^DPT(DFN,.312,X,0),ADT,$G(ACT)) Q
 .S @VAR@(0)=$G(@VAR@(0))+1
 .S @VAR@(X,0)=$$ZND(DFN,X)
 .S @VAR@(X,1)=$G(^DPT(DFN,.312,X,1))
 .S @VAR@(X,2)=$G(^DPT(DFN,.312,X,2))
 .S @VAR@(X,3)=$G(^DPT(DFN,.312,X,3))
 .S @VAR@(X,4)=$G(^DPT(DFN,.312,X,4))
 .S @VAR@(X,355.3)=$G(^IBA(355.3,+$P($G(^DPT(DFN,.312,X,0)),"^",18),0))
 .I $G(SOP) D
 ..N COB,WHO
 ..S COB=$P(@VAR@(X,0),U,20)
 ..S WHO=$P(@VAR@(X,0),U,6) S:WHO="s" IBSP=1
 ..I $$MCRWNR(+@VAR@(X,0)) D
 ... S COB=.5,IBMRA=1
 ... 
 ..S COB=$S(COB'="":COB,WHO="v":1,WHO="s":$S(IBMRA:1,1:2),1:3)
 ..S @VAR@("S",COB,X)=""
 ..Q
 ; Ck for spouse's insurance, move it before any MEDICARE WNR if sorting
 I $G(SOP),IBMRA,IBSP D
 . ; Shuffle Medicare WNR, if necessary
 . S X=0 F  S X=$O(@VAR@("S",.5,X)) Q:'X  S @VAR@("S",2,X)="" K @VAR@("S",.5,X)
 . S X=0 F  S X=$O(@VAR@("S",2,X)) Q:'X  I $P(@VAR@(X,0),U,6)="s",'$P(@VAR@(X,0),U,20) S @VAR@("S",1,X)="" K @VAR@("S",2,X)
 . Q
 Q
 ;
ZND(DFN,NODE) ; -- set group number and group name back into zeroth node of ins. type
 ; From ^IBCNS1
 N X,Y S (X,Y)=""
 I '$G(DFN)!('$G(NODE)) Q X
 S X=$G(^DPT(+DFN,.312,+NODE,0))
 S Y=$G(^IBA(355.3,+$P(X,"^",18),0)) I Y="" Q X
 S $P(X,"^",3)=$P(Y,"^",4) ; move group number
 S $P(X,"^",15)=$P(Y,"^",3) ; move group name
 Q X
 ;
CHK(X,Z,Y) ; -- check one entry for active
 ; From ^IBCNS1
 ; --  Input   X    = Zeroth node of entry in insurance multiple (2.312)
 ;             Z    = date to check
 ;             Y    = 2 if want will not reimburse
 ;                  = 3 if want will not reimburse AND indemnity plans
 ;                  = 4 if want will not reimburse, but only if it's
 ;                       MEDICARE
 ; --  Output  1    = Insurance Active
 ;             0    = Inactive
 ;
 N Z1,X1
 S Z1=0,Y=$G(Y)
 I Y'=3,$$INDEM(X) Q Z1 ; is an indemnity policy or company
 S X1=$G(^DIC(36,+X,0)) Q:X1="" Z1 ;insurance company entry doesn't exist
 I $P(X,"^",8) Q:Z<$P(X,"^",8) Z1 ;effective date later than care
 I $P(X,"^",4) Q:Z>$P(X,"^",4) Z1 ;care after expiration date
 I $P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",11) Q Z1 ;plan is inactive
 Q:$P(X1,"^",5) Z1 ;insurance company inactive
 I Y<2 Q:$P(X1,"^",2)="N" Z1 ;insurance company will not reimburse
 I Y=4,$P(X1,"^",2)="N",'$$MCRWNR(+X) Q Z1 ;only MEDICARE WNR
 S Z1=1
 Q Z1
 ;
INDEM(X) ; -- is this an indemnity plan
 ; From ^IBCNS1
 ; -- input zeroth node if insurance type field
 N IBINDEM,IBCTP
 S IBINDEM=1
 I $P($G(^DIC(36,+X,0)),"^",13)=15 Q IBINDEM ; company is indemnity co.
 S IBCTP=$P($G(^IBA(355.3,+$P(X,"^",18),0)),"^",9)
 I IBCTP,$P($G(^IBE(355.1,+IBCTP,0)),"^",3)=9 Q IBINDEM ; plan is an indemnity plan
 S IBINDEM=0
 Q IBINDEM
 ;
MCRWNR(IBINS) ;Returns whether the ins co IBINS is MEDICARE WNR (Will
 ; From ^IBEFUNC
 ;           NOT Reimburse) 0=NO, 1=YES
 N Z,Z0
 S Z=0,Z0=$G(^DIC(36,+IBINS,0))
 I $P(Z0,U,2)="N",$P($G(^IBE(355.2,+$P(Z0,U,13),0)),U)="MEDICARE" S Z=1
 Q Z
 ;
