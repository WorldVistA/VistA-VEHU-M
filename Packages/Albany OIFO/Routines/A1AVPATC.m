A1AVPATC ;ISC1/JSH - TO LOG PATCHES ;11/16/92  13:25
 ;;1.0;10 JUNE 90;
EN R !,"Patch Prefix to Print: ",X Q:U[X  R !!,"Title:",X1 Q:U[X  R !!,"Start with:",ZZ Q:U[ZZ  R !!,"Go to:",ZZZ Q:U[ZZZ  S %IS="Q" D ^%ZIS Q:POP  U IO(0)
EN1 I $D(IO("Q")) S ZTRTN="EN2^A1AVPATC",ZTDTH="",ZTDESC="PATCH LOG",ZTSAVE("X")=X,ZTSAVE("X1")=X1,ZTSAVE("ZZ")=ZZ,ZTSAVE("ZZZ")=ZZZ
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"REQUEST QUEUED" G END
EN2 S XH="W @IOF,!?IOM\2-10,X1,!!,""Designation"",?18,""Type"",?29,""Routines Patched"",?51,""XTSUMBLD After"",?74,""UCI"",?82,""Earlier Patches"",?100,""Comments"",?116,""Packman"",?126,""Date"",!" S XZ=0 U IO
 F I=ZZ:1:ZZZ D
 . I '(XZ#6) X XH
 . W !?1,X,I S XZ=XZ+1
 . F J=1:1:9 D
 .. W ?18,$S(J=2:"DD",J=3:"INP TEMP",J=4:"PRT TEMP",J=5:"SRT TEMP",J=6:"ROUTINE",J=7:"DB",J=8:"ENHANCE",J=9:"OTHER",1:""),?29,"-------------------",?51,"--------------------"
 .. W ?74,$S(J=1:"INH",J=2:"VER",J=3:"ALF",J=4:"KNL",J=5:"VIR",J=6:"MGR-A",J=7:"MGR-B",1:""),?82,"---------------",?100,"--------------",?116,"--------",?126,"------",!
END K X,X1,ZZ,ZZZ,XZ,J,XY,XH
 D ^%ZISC
 Q
