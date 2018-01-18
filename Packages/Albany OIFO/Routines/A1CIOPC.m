A1CIOPC ;np/isc-a;checks file 43.1 for data integrity ; ;6/7/89  1:24 PM
 K ^UTILITY("OPCCHK") S IOP=$I,U="^" D ^%ZIS
 S (CN,DFN)=0 F I=0:1 S DFN=$O(^DG(43.1,DFN)) Q:+DFN<1  I $D(^(DFN,2))=11,$D(^(1))'=11 S ^UTILITY("OPCCHK",DFN)="",CN=CN+1
 W @IOF,*7,I," entries were found in the means test file."
 W:CN !,CN," of these had corrupt means test year data.",!,"The patients are:",!!
 F DFN=0:0 S DFN=$O(^UTILITY("OPCCHK",DFN)) Q:DFN=""  W !?2,DFN,?12,$P(^DPT(DFN,0),U)
EXIT K DFN,I,CN Q
