RJPTFPH1 ;RJ WILM DE -SHELL FOR REPORTS; 3-12-87
 ;;4.0
 S %DT="APE",%DT("A")="From Discharge Date: " D ^%DT G:Y=-1 X S Z1=Y,%DT("A")="To Discharge Date: " D ^%DT G:Y=-1 X S Z2=Y
 W !!,"This report can be queued by typing a ""Q"" at the DEVICE: prompt." S %IS="QM",%IS("B")="" K IOP D ^%ZIS G:POP X
 I $D(IO("Q")) S PGM="QQ^RJPTFPH1" D ^RJPTFQ S ^%ZTSK(ZTSK,"Z1")=Z1,^%ZTSK("Z2")=Z2 G X
 W !,"This may take a while..."
X Q
QQ S Z1=^%ZTSK(ZTSK,"Z1"),Z2=^%ZTSK(ZTSK,"Z2") G S
