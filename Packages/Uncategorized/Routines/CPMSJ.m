CPMSJ ;ALB/CPM - FIND INSURANCE POLICIES WITHOUT COMPANIES ; 20-MAR-98
 ;;To be distributed from the Albany CIO Field Office by Sheryl Jackson
 ;
 ;
 ; This is a simple routine that will look at all the insurance
 ; policies stored in the patient file and list to the screen those
 ; that have a dangling pointer to the INSURANCE COMPANY (#36) file.
 ;
 ;
 I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,1:0) W !!?3,"The variable DUZ must be set to an active user code before continuing." Q
 ;
 ;
 W !!,"This program will simply check all insurance policies in the PATIENT (#2)"
 W !,"file and list on the screen those that have a dangling pointer to the"
 W !,"INSURANCE COMPANY (#36) file.  The program will run at your terminal for"
 W !,"probably 30-60 minutes."
 ;
 S DIR(0)="Y",DIR("A")="Is it okay to begin now"
 W !! D ^DIR K DIR I 'Y G Q
 ;
 W !!!,"Searching for Insurance Policies...",!!
 ;
 ;
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .S IBCDFN=0 F  S IBCDFN=$O(^DPT(DFN,.312,IBCDFN)) Q:'IBCDFN  S IBC=+$G(^(IBCDFN,0)) D
 ..S IBH=0
 ..I 'IBC S IBH=1
 ..I 'IBH S IBCO=$G(^DIC(36,IBC,0)) D
 ...I IBCO="" S IBH=2 Q
 ...I $P(IBCO,"^")="" S IBH=3
 ..;
 ..; - display results
 ..Q:'IBH
 ..S IBN=$G(^DPT(DFN,0))
 ..W !,$E($P(IBN,"^"),1,20)," (",$E($P(IBN,"^",9),6,9),")"
 ..W "  Pol #",IBCDFN
 ..W "  => ",$S(IBH=1:"No Insurance Company Pointer",IBH=2:"Dangling Ins Company Pointer ("_IBC_")",1:"Company ("_IBC_") has no name")
 ;
Q K DFN,IBCDFN,IBC,IBH,IBCO,IBN
 Q
