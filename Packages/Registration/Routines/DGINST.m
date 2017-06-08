DGINST ;ALB/MTC - MAS VERSION 5.2 INSTALL; 5/1/92  12:58
 ;;5.2;REGISTRATION;;JUL 29,1992
 W !,"Please read MAS V5.2 Installation Guide." Q
 ;
BEGIN ; All parts of the init. (DPT, DG, SD)
 W !,"Start of MAS v5.2 install process"
DPT W !!,"Start PATIENT Version 5.2 install process " D TIME,^DPTINIT
DG W !,"Start REGISTRATION Version 5.2 install " D TIME,^DGINIT
SD W !,"Start SCHEDULING Version 5.2 install" D TIME,^SDINIT
 W !," MAS Version 5.2 install is DONE " D TIME
INTEG ;-- add integrated routines/agreed tags 
 W !!,"Starting init of integrated packages "
 W !,"Start HINQ mini init " D TIME,^DVBYCHK
 W !,"Finished with integrated packages " D TIME
 Q
 ;
TIME ;
 D NOW^%DTC W:$E(%,4) $E(%,4) W $E(%,5),"/",$E(%,6,7),"/",$E(%,2,3)," @ ",$E(%_"00",9,10),":",$E(%_"0000",11,12) Q
