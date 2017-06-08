ZZCL ;ALN-ISC;MJB;:THE TROUBLESHOOTER 10/14/94  2:17 PM ] [ 10/23/96  8:49 AM ]
 ;
START S IOF="#,$C(27,91,50,74,27,91,72)"
 W @IOF
 W !,"This program is intended to assist in debugging ",!,"Auto Instrument routines.",!!
PICK R !,?5,"Do you want to just clean up nodes ?",!,?20,"OR",!,?5,"Clean up nodes AND do LASET ? (N/L) ",MJBST:DTIME
 I '$T!(MJBST["^") G END
 I MJBST["?" W !,*7,"Please enter a 'N' for nodes or an 'L' for nodes and LASET" G PICK
 I MJBST="N" D NODE G END
 I MJBST="L" G NODE
NODE ; Use this program to clean up ^LA nodes
 W !!,"This will clean up the LOCK and ERR nodes in ^LA",!
 K ^LA("LOCK"),^LA("ERR") 
 W !,"All done"
 Q:MJBST="N"
RTN R !!,"Enter the IFN from the AI file: ",TSK:DTIME
 I '$T!(TSK["^") G END
 S ^LA(TSK,"I",0)=0
 R !!,"Enter the name of the routine: ",LANM:DTIME
 I '$T!(LANM["^") G END
TC W !!,?15,"Lets do LASET and get the TC arrays" H 2 D ^LASET
 ZW TC
 W !,"Would you like to clean up ^LAH "_LWL_" now ? (Y/N)" R LAH:DTIME
 I '$T!(LAH["^") G END
 I LAH="Y" K ^LAH(LWL)
 W !!,"OK... Now what is the line tag of "_LANM_" after the call to LASET ?  " R X:DTIME
 I '$T!(X["^") G END
 S TAG=X
 W !!,"Lets do that now !!",! S MBRTN=TAG_"^"_LANM
 W !,"-----------------------------------------------------"
 W !!,"LOAD/WORKLIST IFN = ",LWL,!,"JOB NUMBER = ",$J,!!
 W !,".......... WE ARE CURRENTLY PROCESSING "_LANM_"......",!!!!!
 D @MBRTN
 ;
DEBUG ;
 ;W !!,*7,"In order to continue, using the debugger you need to set a ",!,"BREAK in the code of the "_LANM_" routine. "
 ;R !!,"Have you done this yet ??? (Y/N) ",UG
 ;I UG="Y" D END2
 ;I UG="N" W !,*7,"Set the break in "_LANM_" and come back in.",!
END K MJBST,TAG,MBRTN,TSK,LANM,UG,X
 Q
END2 ;D END W @IOF
 ;G ^%DEBUG
