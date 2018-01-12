ZXAEKPMV ;BIZ/WPB - PATCH MANAGEMENT VIEW;03/23/2015
 ;;1.0;Patch Installs;**1**;Mar 23, 2015;Build 17
 Q
EN ; Provides a list of patches installed by namespace. Will give the last 10 patches installed. Prompts the user to ask if they want to see additional patches
 K DIR S DIR(0)="P^9.4:EMZ" D ^DIR Q:$D(DIRUT)  S PKG=$P(Y(0),"^",2),CV=$G(^DIC(9.4,+Y,"VERSION")) S SEED=PKG_"*"_CV W ?60,SEED
 S PATCH=SEED F  S PATCH=$O(^XPD(9.7,"B",PATCH)) Q:(PATCH=""!($P(PATCH,"*")'=PKG))  S EN=0 F  S EN=$O(^XPD(9.7,"B",PATCH,EN)) Q:EN=""  S ZERO=$G(^XPD(9.7,EN,0)) S LOAD=$P(ZERO,"^",3) S PM((10000000-LOAD),EN)=PATCH
 S (CT,L)=0 F  S L=$O(PM(L)) Q:L=""  S CT=CT+1 D  Q:$D(DIRUT)  
 . S EN=0 F  S EN=$O(PM(L,EN)) Q:EN=""  S PAT=PM(L,EN) W !,PAT S DATA=$G(^XPD(9.7,EN,0)),ID=$P(DATA,"^",3),WHO=$P(DATA,"^",11) W ?14,$E($$EXTERNAL^DILFD(9.7,2,"",ID),1,18),?34,$E($$EXTERNAL^DILFD(9.7,9,"",WHO),1,15) D
 .. S NODE2=$G(^XPD(9.7,EN,2)) I NODE2]"" W ?51,$E(NODE2,1,28)
 . I CT#11=0 K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="See more patches" D ^DIR Q:$D(DIRUT)  I Y<1  S DIRUT=1
 K PATCH,SEED,ZERO,PM,L,EN,CT,PAT,DATA,LOAD
 G ZXAEKPMV
BYDATE ; report of patches installed by datetime
 D KDIR
 K ^TMP($J,"PATCHES")
 S DIR("A")="Enter Starting Date/Time ",DIR(0)="D" D ^DIR 
 Q:$G(DTOUT)
 Q:$G(DUOUT)
 Q:$G(DIRUT)
 Q:$G(DIROUT)
 S START=$TR($G(Y),"@","."),START=$P(START,"."),START=$$FMADD^XLFDT(START,-1)_".235959"
 D KDIR
 S DIR("A")="Enter Ending Date/Time ",DIR(0)="D" D ^DIR
 Q:$G(DTOUT)
 Q:$G(DUOUT)
 Q:$G(DIRUT)
 Q:$G(DIROUT)
 S END=$G(Y)
 S END=END_".235959",CNT=1
 D KDIR
 ;Need to change the following Writes to use DIR calls
 I $G(END)<$G(START) W !,"The ending date you entered is before the starting date, please try again..." G BYDATE
 W !,"Let me check on that for you. Be right back with your answer....",!!
 S XX=0 F  S XX=$O(^XPD(9.7,XX)) Q:XX'>0  D
 .;W !,"HERE"
 .K PATCHES,INDATE,ENDATE,PATCH,IN,DONE,IEN
 .S IEN=XX_","
 .D GETS^DIQ(9.7,XX,".01;11;17;51","IE","PATCHES")
 .;ZW PATCHES
 .S INDATE=$G(PATCHES(9.7,IEN,11,"I")),ENDDATE=$G(PATCHES(9.7,IEN,17,"I")),DISTDATE=$G(PATCHES(9.7,IEN,51,"I"))
 .;W !,$G(INDATE),"   ",$G(ENDDATE),"    ",START,"   ",END
 .Q:INDATE<$G(START)
 .;Q:ENDDATE>$G(END)
 .S PATCH=$G(PATCHES(9.7,IEN,.01,"E")),IN=$G(PATCHES(9.7,IEN,11,"E")),DONE=$G(PATCHES(9.7,IEN,17,"E")),DSDT=$G(PATCHES(9.7,IEN,51,"E"))
 .S ^TMP($J,"PATCHES",CNT)=PATCH_"^"_IN_"^"_$G(DONE)_"^"_$G(DSDT),CNT=CNT+1
 .;W !,PATCH,?52,$P(IN,"@"),?66,$P(DONE,"@")
 .K PATCH,IN,DONE,PATCHES,DISTDATE,DSDT
 K X,END,START
 ;Change the Write to use DIR call
 I '$D(^TMP($J,"PATCHES")) W !,"No patches were installed during that time period"
 I $D(^TMP($J,"PATCHES")) D
 .S YY=0 F  S YY=$O(^TMP($J,"PATCHES",YY)) Q:YY'>0  D
 ..K PATCH,IN,DONE
 ..S PATCH=$P(^TMP($J,"PATCHES",YY),"^"),IN=$P(^TMP($J,"PATCHES",YY),"^",2),DONE=$P(^TMP($J,"PATCHES",YY),"^",3),DSDT=$P(^TMP($J,"PATCHES",YY),"^",4)
 ..W !,$E($G(PATCH),1,40),?44,$P($G(IN),"@"),?58,$P($G(DSDT),"@")
 ..K PATCH,IN,DONE,DSDT
 K YY,PATCH,IN,DONE,^TMP($J,"PATCHES")
 Q
KDIR ;
 K DIR,DIR("A"),DIR(0),DTOUT,DUOUT,DIRTU,DIROUT,Y
 Q
