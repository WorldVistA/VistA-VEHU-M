RJPTFPD2 ;RJ WILM DE; Display PTF File Status; 3-16-87
 ;;4.0
 D H S RJ1=$J(RJIN/RJTOTAL*100,7,2),RJ2=$J(RJNC/RJTOTAL*100,7,2),RJ3=$J(RJCNC/RJTOTAL*100,7,2),RJ4=$J(RJCNR/RJTOTAL*100,7,2),RJ5=$J(RJR/RJTOTAL*100,7,2)
 W !,$J(RJIN,8,0),?10,"Inpatients (Not Counted).",?70,RJ1,!,$J(RJNC,8,0),?10,"Patients Discharged but not Coded (Not Counted)."
 W ?70,RJ2,!,$J(RJCNC,8,0),?10,"Patients Coded but not reviewed by HSRO (Not Counted).",?70,RJ3,!,$J(RJCNR,8,0),?10,"Patients waiting for Transmission to Austin.",?70,RJ4,!,$J(RJR,8,0),?10,"Patients Released to Austin."
 W ?70,RJ5,!,$J(RJTOTAL,8,0),?10,"Total Patients within period" W:$D(RJPERIOD) "  ",RJPERIOD W ".",!
 K RJ1,RJ2,RJ3,RJ4,RJ5,RJIN,RJNC,RJCNC,RJCNR,RJR,RJTOTAL,P Q
H W !!?3,"Total",?10,"Description",?65,"% of Patients",! F P=1:1:79 W "-"
 Q
