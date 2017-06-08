IBYOENV ;ALB/TMP - PATCH IB*2.0*51 ENVIRONMENT CHECK ;20-AUG-96
 ;;2.0;INTEGRATED BILLING;**51**;21-MAR-94
 ;
 Q:$G(XPDENV)'=1
 N CNT,PATCH,Z,Z0
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user",! S XPDQUIT=2
 ;
 ;Check for existence of prerequisite IB patch 6
 ;
 I $P($T(+2^IBCOIVM1),"**",2)'["6" D NOPTCH(6,.CNT)
 ;
 I $G(CNT) W !!,"Please install th",$S(CNT>1:"ese patches",1:"is patch")," first and then restart this install.",! S XPDQUIT=2
 ;
 ; Check that no local form fields in file 364.7 are using the data
 ; elements being deleted
 N DA,Z
 F Z="N-BALANCE DUE","N-CURR INSURANCE CO STREET","N-CURR INSURANCE CO CITY","N-CURR INSURANCE CO STATE","N-CURR INSURANCE CO ZIP CODE","N-UB92 ADMISSION DATE","N-STATE CODE FOR ACCIDENT","N-HCFA 1500 BOX 19 (LINE 2)" D
 . S DA=$O(^IBA(364.5,"B",Z,0))
 . Q:'DA
 . S IB=0,IBOK=1
 . F  S IB=$O(^IBA(364.7,"C",DA,IB)) Q:'IB  I $P($G(^IBA(364.7,IB,0)),U,2)="L" D  Q:'IBOK
 .. N Z
 .. S Z=$G(^IBE(353,+$G(^IBA(364.6,+$G(^IBA(364.7,IB,0)),0)),2))
 .. I $P(Z,U,2)'="P" S IBOK=1 Q
 .. S Z=$G(^IBE(353,+$P(Z,U,5),2)) ;Get parent form
 .. I $P(Z,U,2)="P",$P(Z,U,4) Q
 .. S IBOK=1
 . Q:IBOK
 . S IBX="   *** ERROR - Data element "_Z_" will be deleted with this patch" D MES^XPDUTL(IBX)
 . S IBX="               It must be removed from any local output formatter forms before this install can continue" D MES^XPDUTL(IBX)
 . S XPDQUIT=2
 ;
 ; Check that no local output formatter entries are numbered 1-9999
 S IBX="Checking for local output formatter entries in wrong number space" D MES^XPDUTL(IBX)
 F Z=364.5,364.6,364.7 S Z0=0,IBF=1 F  S Z0=$O(^IBA(Z,Z0)) Q:'Z0!(Z0>9999)  I $P($G(^(Z0,0)),U,2)="L" D
 . I IBF D
 .. S IBX=">> Invalid local entry(s) found in "_$S(Z=364.5:"IB DATA ELEMENT DEFINITION",Z=364.6:"IB FORM SKELETON DEFINITION",1:"IB FORM FIELD CONTENT")_"("_Z_") file in national numberspace" D MES^XPDUTL(IBX)
 .. S IBX="   These must be moved to entry(s)>10,000 for the install to continue" D MES^XPDUTL(IBX)
 . S IBX="     #"_Z0_" - "_$S(Z=364.5:$P($G(^IBA(364.5,Z0,0)),U),Z=364.6:$P($G(^IBA(364.6,Z0,0)),U,10),1:$P($G(^IBA(364.6,+$G(^IBA(364.7,Z0,0)),0)),U,10))
 . D MES^XPDUTL(IBX)
 . S XPDQUIT=2,IBF=0
 Q
 ;
NOPTCH(PATCH,CNT) ; Writes patch not installed messsage
 ;PATCH = patch number not found
 ;CNT = # of patches missing ... passed by reference ... running count
 W !!,*7,"PATCH #: IB*2.0*",PATCH," does not appear to be installed on your system and is",!,"  required before this patch can be installed."
 S CNT=$G(CNT)+1
 Q
 ;
FAC ;Get existing facility data
 N IBNM,IBPRE,IBSEL,IBFAC,IBX,IBA,IBS,X,Y,IBQ,IBADDR,IBROUT,IBABORT,XPDQUES,DIR
 S IBS="",$P(IBS,"*",43)=""
 S IBSEL=0,IBFAC=$P($G(^IBE(350.9,1,2)),U),IBNM=$P($G(^(2)),U,10)
 I IBNM'="" Q
 S IBPRE=($P($G(^XTMP("IB20_51","IBFAC")),U)'="")
 I $L(IBFAC)<1!($L(IBFAC)>18)!($TR(IBFAC," ")'?.A) D
 . D BMES^XPDUTL("Current Agent Cashier Mail Symbol: "_IBFAC)
 . I IBPRE D MES^XPDUTL("Previously entered FACILITY NAME FOR BILLING: "_$P(^XTMP("IB20_51","IBFAC"),U)),MES^XPDUTL("")
 . S IBX(1)="The Agent Cashier Mail Symbol has more than 18 characters"
 . S IBX(2)="or contains non-alpha characters so it can't be used for the"
 . S IBX(3)="new FACILITY NAME FOR BILLING data.  You must enter a new"
 . S IBX(4)="FACILITY NAME FOR BILLING (consisting of 1-18 alpha"
 . S IBX(5)="characters & spaces only)"
 . I IBPRE S IBX(6)="OR  you can use the data entered in a previous install of this patch"
 . S IBSEL=2 D MES^XPDUTL(.IBX)
 N DIR,DIROUT,DUOUT,DTOUT,DUOUT
FAC1 I IBSEL=0 F  D  G:$G(XPDQUIT) Q Q:IBOK
 . S IBOK=1
 . D MES^XPDUTL(IBS)
 . D MES^XPDUTL("Current Agent Cashier Mail Symbol: "_IBFAC)
 . I IBPRE D MES^XPDUTL("Previously entered FACILITY NAME FOR BILLING: "_$P(^XTMP("IB20_51","IBFAC"),U))
 . D MES^XPDUTL("")
 . S DIR("A",1)="DO YOU WANT TO "
 . S DIR("A",2)="1 - COPY AGENT CASHIER MAIL SYMBOL FIELD TO FACILITY NAME FOR BILLING"
 . S DIR("A",3)="2 - ADD NEW FACILITY NAME FOR BILLING"
 . I IBPRE S DIR("A",4)="3 - USE FACILITY NAME FOR BILLING ENTERED IN PREVIOUS INSTALL"
 . S DIR(0)="SAXB^1:COPY EXISTING AGENT CASHIER MAIL SYMBOL;2:ADD NEW FACILITY NAME FOR BILLING"_$S('IBPRE:"",1:";3:USE FACILITY NAME FOR BILLING ENTERED IN PREVIOUS INSTALL")
 . S DIR("A")="SELECT AN ACTION: ",DIR("B")=$P($P(DIR(0),";",$S('IBPRE:2,1:3)),":",2)
 . D ^DIR K DIR
 . S IBSEL=+Y
 . I $D(DTOUT)!$D(DUOUT) D
 .. S IBOK=0,IBSEL=""
 .. I $$ABORT(.XPDQUIT) Q
 I IBSEL=1 D BMES^XPDUTL(">>> '"_IBFAC_"' WILL BE COPIED TO THE NEW FACILITY NAME FOR BILLING FIELD") S $P(^XTMP("IB20_51","IBFAC"),U)=IBFAC
 I IBSEL=3 D BMES^XPDUTL(">>> PREVIOUSLY ENTERED DATA WILL BE USED FOR NEW FACILITY NAME FOR BILLING")
 ;
 I IBSEL=2 D  G:$G(XPDQUIT) Q
 . N IBZ
 . D BMES^XPDUTL("")
 . S DIR("A")="NEW FACILITY NAME FOR BILLING: "
 . I IBPRE S DIR("B")=$P(^XTMP("IB20_51","IBFAC"),U)
 . S DIR("?",1)="Enter a Facility Name for Billing.  This data will print on"
 . S DIR("?",2)="the UB-92 in form locator 1 and in Box 33 of the HCFA 1500."
 . S DIR("?")="Answer must be 1-18 alpha and space characters only"
 . S DIR(0)="FA^1:18^K:$TR(X,"" "")'?.A X"
 . D ^DIR K DIR
 . I '$D(DUOUT)&'$D(DTOUT) S IBFAC=Y,$P(^XTMP("IB20_51","IBFAC"),U)=Y Q
 . S IBSEL=0
 . S IBZ='$$ABORT(.XPDQUIT)
 I IBSEL=0 G FAC1
ADD1 S IBA=$P($G(^IBE(350.9,1,2)),U,2)
 D BMES^XPDUTL(IBS)
 S IBX(1)="Update Agent Cashier Street Address to include the agent cashier mail symbol"
 S IBX(2)="Enter a new street address"_$S($L(IBA)<24:" or add the agent cashier mail symbol to the end",1:" (max length of 25)")
 S IBX(3)=$S($L(IBA)<24:"of the current street address (max length of 25)",1:"")
 D MES^XPDUTL(.IBX)
 D BMES^XPDUTL("Current Agent Cashier Street Address: "_IBA_" ("_$L(IBA)_" char)")
 D MES^XPDUTL("")
ADDR S (IBADDR,IBROUT)=""
 S DIR("A",1)="YOU CAN NOW:"
 S DIR("A",2)="1 - MAKE NO CHANGES TO THE EXISTING ADDRESS"
 S DIR("A",3)="2 - REENTER THE ENTIRE ADDRESS LINE"
 S:$L(IBA)<24 DIR("A",4)="3 - APPEND MAIL SYMBOL TO END OF EXISTING ADDRESS"
 S DIR("?")="Enter a new address line with agent cashier mail symbol - up to 25 characters"
 S DIR(0)="SAXB^1:MAKE NO CHANGES TO THE EXISTING ADDRESS;2:REENTER THE ENTIRE ADDRESS LINE"_$S($L(IBA)<24:";3:APPEND MAIL SYMBOL TO END OF EXISTING ADDRESS",1:"")
 S DIR("A")="SELECT AN ACTION: ",DIR("B")=$P($P(DIR(0),";",$S($L(IBA)<24:3,1:2)),":",2)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) D NOADCHG S XPDQUIT=1 G Q
 S IBSEL=+Y,IBOK=1
 I IBSEL=1 D NOADCHG G Q
 I IBSEL=2 D  G:IBOK Q
 . D MES^XPDUTL("")
 . S DIR("A",1)=" (columns)                                      1         2    2"
 . S DIR("A",2)="                                       1234567890123456789012345"
 . S DIR("A")="NEW STREET ADDRESS (WITH MAIL SYMBOL): "
 . S DIR(0)="FA^1:25"
 . D ^DIR K DIR
 . I '$D(DUOUT)&'$D(DTOUT) S IBADDR=Y,$P(^XTMP("IB20_51","IBFAC"),U,2)=IBADDR Q
 . S IBOK=0,XPDQUIT=1
 I IBSEL=3 D  G:'IBOK Q
 . S DIR("A")="ENTER AGENT CASHIER MAIL SYMBOL (1-"_(24-$L(IBA))_" char): "
 . S DIR(0)="FA^1:"_(24-$L(IBA))
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT) S IBOK=0,XPDQUIT=1 Q
 . S IBROUT=Y
 . S IBADDR=$P($G(^IBE(350.9,1,2)),U,2)_" "_IBROUT
 . S $P(^XTMP("IB20_51","IBFAC"),U,2)=IBADDR Q
 W !!
Q Q
NOADCHG ;
 D BMES^XPDUTL("NO AGENT CASHIER ADDRESS LINE CHANGES MADE")
 H 2
 Q
ABORT(XPDQUIT) ;
 N IBABORT
 S IBABORT=0
 S DIR(0)="YA",DIR("A")="THIS ACTION WILL ABORT THE INSTALL.  IS THE REALLY WHAT YOU WANT TO DO?: ",DIR("B")="NO" D MES^XPDUTL("") D ^DIR K DIR
 I Y'=1 G ABQ
 D BMES^XPDUTL("MANDATORY ENTRY OF FACILITY NAME FOR BILLING STEP WAS SKIPPED.  INSTALL ABORTED") S XPDQUIT=2,IBABORT=1
ABQ Q IBABORT
