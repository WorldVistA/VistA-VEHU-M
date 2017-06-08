GMRQSET ;ISC-SLC/MJC;OPT RTN TO INACTIVATE NON-EXP TITLES;06/09/94  12:12 PM
V ;;2.5;Progress Notes;**23**;Jan 08,1993
EN ;optional rtn to inactivate all PNs titles not exported with PNs 2.5
 I '$D(^GMR(121.2,0)) W $C(7),$C(7),!,"I think you're in the wrong UCI!",!!,"Regroup and try it again!!" G END
 D HOME^%ZIS W @IOF,!!,"Invoking this routine will INACTIVATE all Progress Notes Titles entered"
 W !,"after the 29 Titles that were exported with the package."
 W !!,"If your site has a large number of titles to inactivate, you may find it less"
 W !,"time consuming to use this option and then REACTIVATE the titles your site uses"
 W !,"with the option [GMRPN TITLE INACTIVATE]."
 W !!,"You may prefer to use the option [GMRP TITLE PRINT] to print a list of titles"
 W !,"and then inactivate the appropriate titles using the option",!,"[GMRPN TITLE INACTIVATE]"
 W !!,"All of the above options may be found on the [GMRPN TITLE MGMT MENU]"
 W !,"located on the [GMRPNMGR] menu."
 W !!,"If you run this option, the VIS title, which was exported with GMRP*2.5*19,"
 W !,"will need to be reactivated."
 W !!?10,"Do you wish to proceed with this option"
 S %=2 D YN^DICN G EN:%=0 W ! I %'=1 W !?15,$C(7),"Option Aborted...." G END
 S IEN=29 F  S IEN=$O(^GMR(121.2,IEN)) Q:'IEN  S $P(^(IEN,0),"^",4)=1 W "."
 W !!?2,$C(7),"...all titles not exported with Progress notes v2.5 are now inactive."
END K IEN Q
