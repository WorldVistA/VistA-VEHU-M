PRCPURS2 ;WISC/RFJ-select dates                                     ;24 May 93
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DATESEL(V1) ;  select starting and ending dates in days
 ;  returns datestrt and dateend
 N %,%DT,%H,%I,DEFAULT,X,Y
 K DATEEND,DATESTRT
START S Y=$E(DT,1,5)_"01" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with "_$S(V1'="":V1_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 S DATESTRT=Y
 S Y=DT D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with "_$S(V1'="":V1_" ",1:"")_"Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I $E(Y,6,7)="00" S Y=$E(Y,1,5)_"01"
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START
 S DATEEND=Y,Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
 ;
 ;
MONTHSEL ;  select starting and ending dates in months
 ;  returns datestrt and dateend
 N %,%DT,%H,%I,DEFAULT,X,Y
 K DATEEND,DATESTRT
START1 S X1=DT,X2=-90 D C^%DTC S Y=$E(X,1,5)_"00" D DD^%DT S DEFAULT=Y
 S %DT("A")="Start with Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 S DATESTRT=Y
 S Y=$E(DT,1,5)_"00" D DD^%DT S DEFAULT=Y
 S %DT("A")="  End with Date: ",%DT("B")=DEFAULT,%DT="AEP",%DT(0)=-DT D ^%DT I Y<0 Q
 I Y<DATESTRT W !,"END DATE MUST BE GREATER THAN OR EQUAL TO THE START DATE.",! G START1
 S DATEEND=Y,Y=DATESTRT D DD^%DT
 W !?5,"***  Selected date range from ",Y," to " S Y=DATEEND D DD^%DT W Y,"  ***"
 Q
