RMPRLNAN ;PHX/RFM-1465 REPORT TO FISCAL ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
EN1 ;ENTRY POINT TO RESET VARIABLES
 S X1=DATE(1),X2=-1 D C^%DTC S DATE("1A")=X,X1=DATE(2),X2=1 D C^%DTC S DATE("2A")=X
 S (RO,RP)=0,RMPR("T")="" F I=1:1:7 S RMPR(I)=""
 F  S RO=$O(^RMPR(660.1,"AG",RO)) Q:RO'>0  F  S RP=$O(^RMPR(660.1,"AG",RO,RP)) Q:RP=""  D
 .Q:'$D(^RMPR(660.1,RP,0))  Q:$P(^(0),U,15)'=RMPR("STA")  S RB=^(0),ROB="S CATE=$S(+$P(RB,U,13):$P(RB,U,13),1:7)"
1 .X ROB S VAR="RMPR(CATE)",X1=DATE("2A"),X2=-790 D C^%DTC I '$P(^RMPR(660.1,RP,0),U,11)!($P(^(0),U,11)>DATE("1A")) D
 ..I $P(^RMPR(660.1,RP,0),U,10)>X,$P(^(0),U,10)<DATE("1A") D
 ...S $P(@VAR,U)=$P(@VAR,U)+1,$P(@VAR,U,2)=$P(@VAR,U,2)+$P(^(0),U,5),RMPR("T")=RMPR("T")+$P(^(0),U,5)
 .I '$P(^RMPR(660.1,RP,0),U,11),$P(^(0),U,10)>X,$P(^(0),U,10)'<DATE("1A") S RMPR("T")=RMPR("T")+$P(^(0),U,5)
 .I $P(^RMPR(660.1,RP,0),U,11),$P(^(0),U,10)>X,$P(^(0),U,10)'<DATE("1A") S RMPR("T")=RMPR("T")+$P(^(0),U,5)
A .I $P(^RMPR(660.1,RP,0),U,10)>DATE("1A"),$P(^(0),U,10)<DATE("2A"),$P(^(0),U,17)["N" S $P(@VAR,U,3)=$P(@VAR,U,3)+1,$P(@VAR,U,4)=$P(@VAR,U,4)+$P(^(0),U,5)
B .I $P(^RMPR(660.1,RP,0),U,10)>DATE("1A"),$P(^(0),U,10)<DATE("2A"),$P(^(0),U,17)["R" S $P(@VAR,U,5)=$P(@VAR,U,5)+1,$P(@VAR,U,6)=$P(@VAR,U,6)+$P(^(0),U,5)
C .I $P(^RMPR(660.1,RP,0),U,11),$P(^RMPR(660.1,RP,0),U,11)<DATE("2A"),$P(^(0),U,11)>DATE("1A") D
 ..S X1=DATE("2A"),X2=-730 D C^%DTC I X<$P(^RMPR(660.1,RP,0),U,10) S $P(@VAR,U,7)=$P(@VAR,U,7)+1,$P(@VAR,U,8)=$P(@VAR,U,8)+$P(^(0),U,5),RMPR("T")=RMPR("T")-$P(^(0),U,5)
D .S X1=DATE("2A"),X2=-730 D C^%DTC I $P(^RMPR(660.1,RP,0),U,10)<X D
 ..S X1=DATE("2A"),X2=-820 D C^%DTC I $P(^RMPR(660.1,RP,0),U,10)>X,'$P(^(0),U,11) S $P(@VAR,U,9)=$P(@VAR,U,9)+1,$P(@VAR,U,10)=$P(@VAR,U,10)+$P(^(0),U,5),RMPR("T")=RMPR("T")-$P(^(0),U,5)
 G PRINT
EXIT I $E(IOST)["C",'$D(RMPRKILL) R !!,"Enter `return` to continue or `^` to exit: ",X:DTIME I X'="",X'="^" W $C(7),!,"You may only enter `return` to continue or `^` to exit" G EXIT
 D ^%ZISC K RP,RO,RMPRFY,ANS,CATE,VAR,RMPR,DATE,DIR,RMPRPR,RMPRKILL,RMPRQTR,ROB,RB Q
PRINT ;PRINT REPORT
 U IO W:$E(IOST)["C" @IOF W !,?26,"Fiscal Inventory Account 1465",?65,"STA: ",$$STA^RMPRUTIL
 W !! S Y=DT X ^DD("DD") W ?3,"DATE: ",Y
 W !!,?5,"TO: Chief, Fiscal Service (04)"
 W !!,?3,"FROM: Prosthetics and Sensory Aids Service"
 W !!,?3,"SUBJ: Inventory of Active Loan Items Quarter Ending " S Y=DATE(2) X ^DD("DD") W Y," FY ",RMPRFY
 W !!,?50,"Number",?65,"Value" F I=1:2:10 G:$D(RMPRKILL) EXIT D:$E(IOST)["C"&(I=3)!($E(IOST)["C"&(I=7)) HOLD Q:$D(RMPRKILL)  D
 .W:I'=1 ! W !,?3,$S(I=1:"1.   Active Loans",I=3:"a.   New items placed on loan",I=5:"b.   Recovered items placed on loan",I=7:"c.   Items recovered",I=9:"d.   Other items to be deleted (Inactive loans)",1:"")
 .W !,?9,"Hospital Beds",?45,$J($P(RMPR(1),U,I),10),?60,$J($P(RMPR(1),U,I+1),10,2)
 .W !,?9,"Van Lift",?45,$J($P(RMPR(2),U,I),10),?60,$J($P(RMPR(2),U,I+1),10,2)
 .W !,?9,"Home Dialysis",?45,$J($P(RMPR(3),U,I),10),?60,$J($P(RMPR(3),U,I+1),10,2)
 .W !,?9,"Invalid Lifts",?45,$J($P(RMPR(4),U,I),10),?60,$J($P(RMPR(4),U,I+1),10,2)
 .W !,?9,"Respirators",?45,$J($P(RMPR(5),U,I),10),?60,$J($P(RMPR(5),U,I+1),10,2)
 .W !,?9,"Wheelchairs",?45,$J($P(RMPR(6),U,I),10),?60,$J($P(RMPR(6),U,I+1),10,2)
 .W !,?9,"All Other Items",?45,$J($P(RMPR(7),U,I),10),?60,$J($P(RMPR(7),U,I+1),10,2)
 G:$D(RMPRKILL) EXIT W !,?50,"Total:",?60,$J(RMPR("T"),10,2),!!!,?9,RMPR("SIG"),!,?9,"Chief, P&SA Service"
 G EXIT
HOLD R !!,"Enter Return to continue or `^` to exit: ",X:DTIME I '$T!(X="^") S RMPRKILL=1 Q
 I X'="" W $C(7),!,"You can only enter `return` to continue or `^` exit" G HOLD
