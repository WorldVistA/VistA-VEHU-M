IBCEU5 ;ALB/TMP - EDI UTILITIES (continued) FOR CMS-1500 ;13-DEC-99
 ;;2.0;INTEGRATED BILLING;**51,137,232,348,349,432,592,608**;21-MAR-94;Build 90
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EXTCR(IBPRV) ; Called by trigger on field .02 of file 399.0222
 ; Also called by trigger on field .02 of file 399.0404 (DEM;432).
 ; Function returns the first 3 digits of the provider's degree if
 ; a VA provider or the credentials in file 355.9 if non-VA provider
 ; IBPRV = vp to file 200 or 355.93
 Q $E($$CRED^IBCEU(IBPRV),1,3)
 ; 
FTPRV(IBIFN,NOASK) ; If form type changes from UB-04 to CMS-1500 or vice
 ; versa, ask to change provider function to appropriate function for
 ; form type (ATTENDING = UB-04, RENDERING = CMS-1500)
 ; IBIFN = ien of bill in file 399
 ; NOASK (flag) = 1 if change should happen without asking first
 N ATT,REN,FT
 S FT=$$FT^IBCEF(IBIFN)
 S REN=$$CKPROV^IBCEU(IBIFN,3,1)
 S ATT=$$CKPROV^IBCEU(IBIFN,4,1)
 ;JWS;IB*2.0*592;add Dental form check 
 I $S(FT=2:'REN&ATT,FT=3:'ATT&REN,FT=7:'REN&ATT,1:0) D
 . I '$G(NOASK) D TXFERPRV(IBIFN,FT) Q
 . D PRVCHG(IBIFN,FT)
 D CLEANUP(IBIFN,FT)
 Q
 ;
TXFERPRV(IBIFN,FT) ; Ask to change the function of the main provider on
 ;  bill IBIFN to the function appropriate to the form type FT
 ;  
 N DIR,X,Y,Z,DIE,DA,DR,HAVE,NEED,IBZ
 ; DEM;432 - Changed the prompt from uppercase to mixed case.
 W ! S DIR("A")="  Change the Claim Level "_$S(FT=3:"Rendering",1:"Attending")_" provider's function to "_$S(FT=3:"Attending",1:"Rendering")_"?: "
 S DIR(0)="YA",DIR("B")="NO",DIR("?",1)="If you answer YES here, you will make the claim level provider functions",DIR("?")="  consistent with the form type of the bill"
 D ^DIR K DIR
 I Y'=1 Q
 D PRVCHG(IBIFN,FT)
 Q
 ;
PRVCHG(IBIFN,IBFT) ; Change provider type to type consistent with current
 ; data on bill
 N Z,IBZ,HAVE,NEED,DIE,DA,X,Y
 S HAVE=$S(IBFT=3:3,1:4)
 S NEED=$S(IBFT=3:4,1:3)
 S Z=$O(^DGCR(399,IBIFN,"PRV","B",HAVE,0))
 I Z D
 . S DA(1)=IBIFN,DA=+Z
 . D FDA^DILF(399.0222,.DA,.01,,NEED,"IBZ")
 . D FILE^DIE(,"IBZ")
 ;I Z S DA(1)=IBIFN,DIE="^DGCR(399,"_DA(1)_",""PRV"",",DA=+Z,DR=".01////"_NEED D FILE^DIE(,DIE
 Q
 ;
CLEANUP(IBIFN,FT)  ; If form type changes remove any extra provider FUNCTIONS.
 N X,PRV,CLEAN,DA,DIE
 ;
 ;JWS;IB*2.0*592 US1108 - If form type changes to (7) J430D - Dental, default Bill Charge Type
 I FT=7 S CLEAN(399,IBIFN_",",.27)=2
 ; (3) If form type changes from CMS-1500 to UB-04, remove any extra provider FUNCTIONS. 
 ;JWS;IB*2.0*592 US1108 - added 6-ASSISTANT SURGEON
 I FT=3 F X=5,6 D  ; 5-SUPERVISING, 6-ASSISTANT SURGEON
 . I $D(^DGCR(399,IBIFN,"PRV","B",X)) D
 .. S PRV=0 F  S PRV=$O(^DGCR(399,IBIFN,"PRV","B",X,PRV)) Q:+PRV=0  D
 ... S DA(1)=IBIFN,DA=PRV D FDA^DILF(399.0222,.DA,.01,,"@","CLEAN")
 ;
 ; (2) If form type changes from UB-04 to CMS-1500, remove any extra provider FUNCTIONS. 
 ;JWS;IB*2.0*592 US1108 - added 6-ASSISTANT SURGEON
 I FT=2 F X=2,4,6,9 D  ; 2-OPERATING, 4-ATTENDING, 6-ASSISTANT SURGEON, 9-OTHER
 . I $D(^DGCR(399,IBIFN,"PRV","B",X)) D
 .. S PRV=0 F  S PRV=$O(^DGCR(399,IBIFN,"PRV","B",X,PRV)) Q:+PRV=0  D
 ... S DA(1)=IBIFN,DA=PRV D FDA^DILF(399.0222,.DA,.01,,"@","CLEAN")
 ;
 I $D(CLEAN) D FILE^DIE(,"CLEAN")
 Q
 ;
PRVHELP ; Text for the provider function help
 Q:$G(X)'="??"
 N IBZ,IBQUIT,IB,IB1,DIR,Z
 S IBQUIT=0
 S Z=""
 I '$D(IOSL)!'$D(IOST) D HOME^%ZIS
 Q:IOST'["C-"
 D:$G(D0) SPECIFIC(D0)
 N DIR,X,Y S DIR(0)="E" D ^DIR K DIR W @IOF
 S:$G(D0) Z=$$FT^IBCEF(D0)
 S IB=IOSL,IB1=1
 F IBZ=1:1 S:$P($T(HLPTXT+IBZ),";;",2)="" IBQUIT=1 Q:IBQUIT  S IB1=1 D
 . I $Y>(IB-3) N DIR,X,Y S IB1=0,DIR(0)="E" D ^DIR K DIR S IB=IB+IOSL I Y'=1 S IBQUIT=1 Q
 . W !,$P($T(HLPTXT+IBZ),";;",2)
 I IB1 D
 . N DIR,X,Y S DIR(0)="E" D ^DIR K DIR
 W @IOF
 Q
 ;
SPECIFIC(IBIFN) ; Display specific provider requirements for the bill IBIFN
 N IBFT,IBPRV,IBR,ONBILL,Z,IBZ
 S IBFT=$$FT^IBCEF(IBIFN)
 D GETPRV^IBCEU(IBIFN,"ALL",.IBPRV) ;Returns needed providers
 ;JWS;IB*2.0*592 US1108 - added Dental form #7
 W !,"This bill is ",$S(IBFT=7:"J430D",IBFT=3:"UB-04",1:"CMS-1500"),"/",$S($$INPAT^IBCEF(IBIFN):"Inpatient",1:"Outpatient")
 W !!,"The valid provider functions for this bill are:"
 ;JWS;IB*2.0*592 US1108 - changed loop from :5 to :6 for Assistant Surgeon
 F IBZ=1:1:6,9 I $$PRVOK^IBCEU(IBZ,IBIFN) D
 . S ONBILL=$$CKPROV^IBCEU(IBIFN,IBZ)
 . S IBR=$S($G(IBPRV(IBZ,"NOTOPT")):1,$G(IBPRV(IBZ,"SITUATIONAL")):2,1:0)  ; DEM;432 added "SITUATIONAL" check.
 . ;JWS;IB*2.0*592 US1108 - dental form#7
 . I IBFT=7 S IBR=2
 . ; ib2.0*432
 . ; W !,IBZ,"  ",$$EXPAND^IBTRE(399.0222,.01,IBZ),?18,$S(IBR&'ONBILL:"**",1:""),?20,$S(IBR:"REQUIRED",1:"OPTIONAL"),$S(ONBILL:" - ALREADY ON BILL",1:" - NOT ON BILL")
 . W !,IBZ,"  ",$$EXPAND^IBTRE(399.0222,.01,IBZ),?18,$S(IBR&'ONBILL:"**",1:""),?23,$S(IBR=1:"REQUIRED",IBR=2:"SITUATIONAL",1:"OPTIONAL")
 W !
 Q
 ;
HLPTXT ; Helptext for provider function
 ;; 
 ;;PROVIDER FUNCTION requirements:
 ;; 
 ;;RENDERING: UB-04 Situational, CMS-1500 Situational, or J430D Situational
 ;;           This is the provider who performed a service.
 ;; 
 ;;ATTENDING: UB-04 REQUIRED
 ;;           The physician who has primary responsibility
 ;;           for the patient's medical care and treatment. 
 ;; 
 ;;OPERATING: UB-04 SITUATIONAL 
 ;;           The provider who performed the principal procedure(s)
 ;;           being billed.
 ;; UB-04 (inpatient): Situational IF type of bill has first 2
 ;;                    digits of 11, and there is a principal
 ;;                    procedure that will print in Form
 ;;                    Locator 74 of the claim, there must be
 ;;                    an Operating or Rendering Provider.
 ;; UB-04 (outpatient):REQUIRED IF type of bill has first 2
 ;;                    digits of 83, and there is a principal
 ;;                    procedure that will print in Form
 ;;                    Locator 74 of the claim.
 ;; 
 ;;REFERRING: UB-04, CMS-1500, or J430D SITUATIONAL
 ;;           The provider who referred the patient for the services being billed. 
 ;; 
 ;;SUPERVISING: CMS-1500 OPTIONAL or J430D SITUATIONAL
 ;;           Required when the rendering provider is supervised
 ;;           by another provider. Data will not be printed.
 ;; 
 ;;OTHER OPERATING: UB-04 SITUATIONAL
 ;;           Used to report another Operating Physician.  There must
 ;;           also be an Operating Physician on the claim.
 ;; 
 ;;ASSISTANT SURGEON: J430D SITUATIONAL
 ;;           Use when the Rendering Provider provided these services in the role
 ;;           of the Assisting Surgeon.
 ;; 
 ;;           There are providers who performed specific functions for
 ;;           the services on this bill.  These providers are needed to
 ;;           enable the V.A. to collect reimbursement when more than
 ;;           one provider function is involved in the billable episode
 ;;           (like an operating physician or referring provider). 
 ;; 
 ;;           This data identifies the type of function that was performed
 ;;           by a provider.
 ;;
 ;
LINKRX(IBIFN,IBREV) ; Ask for revenue code's RX if not already there
 N DIR,X,Y,IBZ,IBRX,Z,Z0,DA
 Q:$P($G(^DGCR(399,IBIFN,"RC",IBREV,0)),U,11)!($P($G(^(0)),U,10)'=3)
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  I Z'=IBREV S Z0=$G(^(Z,0)) I $P(Z0,U,10)=3,$P(Z0,U,11) S IBRX(+$P(Z0,U,11))=""
 S DIR(0)="PAO^IBA(362.4,:AEMQ",DIR("S")="I $P(^(0),U,2)=IBIFN,'$D(IBRX(+Y))"
 S DIR("A")="Select Rx for this charge: "
 S DIR("?",1)="Enter an Rx# for this revenue code"
 S DIR("?")=" The Rx must not already have an associated revenue code"
 D ^DIR K DIR
 I Y>0 D
 . S DA(1)=IBIFN,DA=IBREV,IBZ=""
 . D FDA^DILF(399.042,.DA,.11,"R",+Y,"IBZ")
 . D FILE^DIE(,"IBZ")
 Q
 ;
LINKCPT(IBIFN,IBREV) ; Ask for revenue code's CPT
 N DIR,X,Y,IBZ,IBCP,Z,Z0,Z1,DA,IBRC,IBP
 S IBRC=$G(^DGCR(399,IBIFN,"RC",IBREV,0))
 Q:$P(IBRC,U,8)!($P(IBRC,U,10)'=4)
 S IBP=+$P(IBRC,U,6)
 I $P(IBRC,U,11) W !,"PROCEDURE #"_$P(IBRC,U,11)_" HAS BEEN ASSOCIATED WITH THIS MANUAL CHARGE"
 I '$P(IBRC,U,11) D  Q:IBRC=""
 . S DIR("?",1)="Respond YES if this revenue code charge specifically references the data for"
 . S DIR("?",2)="  a particular procedure that was manually entered on the previous screen."
 . S DIR("?",3)="  For outpatient UB-04 bills, associating a manual revenue code charge with",DIR("?")="  a procedure is the only way to print a modifier in box 44"
 . S DIR(0)="YA",DIR("A")="SHOULD A PROCEDURE ENTRY BE ASSOCIATED WITH THIS CHARGE?: ",DIR("B")=$S(IBP:"YES",1:"NO") W ! D ^DIR K DIR W !
 . I Y'=1 S IBRC="" Q
 I $P(IBRC,U,11) D
 . S DIR("?",1)="Respond YES if you no longer want this revenue code charge to reference a",DIR("?")="  specific manually entered procedure"
 . S DIR(0)="YA",DIR("A")="DELETE THE EXISTING PROCEDURE ASSOCIATION?: ",DIR("B")="NO" W ! D ^DIR K DIR
 . I Y=1 D UPDPTR(IBIFN,IBREV,"") S $P(IBRC,U,11)=""
 S Z=0 F  S Z=$O(^DGCR(399,IBIFN,"RC",Z)) Q:'Z  S Z0=$G(^(Z,0)) I IBREV'=Z,$P(Z0,U,11) D
 . ; Don't allow to link to 'used' proc
 . I $P(Z0,U,10)=4 S IBCP($P(Z0,U,11))="" Q
 . I $P(Z0,U,10)=3,$P(Z0,U,15) S IBCP($P(Z0,U,15))=""
 S DIR(0)="PAO^DGCR(399,"_IBIFN_",""CP"",:AEMQ",DIR("S")="I '$D(IBCP(+Y)),$P(^(0),U)[""CPT"",+^(0)="_+$P($G(^DGCR(399,IBIFN,"RC",IBREV,0)),U,6)
 S DIR("A")="SELECT A PROCEDURE ENTRY: "_$S($P(IBRC,U,11):"#"_$P(IBRC,U,11)_" - "_$$EXPAND^IBTRE(399.0304,.01,$P($G(^DGCR(399,IBIFN,"CP",$P(IBRC,U,11),0)),U))_"// ",1:"")
 S DIR("?")="Enter a manually-added CPT procedure to associate with this charge"
 S DA(1)=IBIFN
 D ^DIR K DIR W !
 I Y>0 D UPDPTR(IBIFN,IBREV,+Y)
 Q
 ;
UPDPTR(IBIFN,IBREV,Y) ;
 N IBZ,DA
 S DA(1)=IBIFN,DA=IBREV,IBZ=""
 D FDA^DILF(399.042,.DA,.11,"R",$S(Y:+Y,1:""),"IBZ")
 D FILE^DIE(,"IBZ")
 Q
 ;
INSFT(IBIFN) ; Returns 1 if form type is UB-04, 0 if CMS-1500 or J430D
 Q ($$FT^IBCEF(IBIFN)=3)
