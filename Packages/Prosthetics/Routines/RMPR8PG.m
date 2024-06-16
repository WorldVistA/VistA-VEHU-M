RMPR8PG ;PHX,HOIFO/JLT,SPS-PURGE 668 SUSPENSE FILE ; AUGUST 29, 1994
 ;;3.0;PROSTHETICS;**5,75,140,163,211**;Feb 09, 1996;Build 10
 ;
 ;02/03/06 Added code to delete the pointer in 664.1 field .05 when a 
 ;record is purged.
 ;
EN D DIV4^RMPRSIT Q:$D(X)
 I '$$CONFIRM(RMPRSITE,RMPR("STA")) S RDEL=0 G END ;RMPR*3.0*211
EN2 K %ZIS,IOP,ZTIO S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP END
 ;I IOST["C-" W !,$C(7),"YOU MAY NOT SELECT YOUR TERMINAL" G EN2
 I $D(IO("Q")) S ZTRTN="EN1^RMPR8PG",ZTDESC="PURGE 668 SUSPENSE FILE" F RD="I","RMPRIEN","RMPRDT","ION","RMPR(","RMPRSITE" S ZTSAVE(RD)=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,"<REQUEST QUEUED!>" G EXIT
EN1 S (I,RMPRIEN,RDEL)=0,RMPRDT=$P(^RMPR(669.9,RMPRSITE,0),U,8) G:RMPRDT'>89 END
 S X1=DT,X2=-RMPRDT D C^%DTC S RMPRDT=X I RMPRDT<$O(^RMPR(668,"B",""))!('$O(^RMPR(668,0))) G END
 ;RMPR*3.0*163 adds check to insure the 0 node is defined in DIP run
 S DIS(0)="I $D(^RMPR(668,D0,0)),$P(^RMPR(668,D0,0),U,7)=RMPR(""STA"")",IOP=ION,DIC="^RMPR(668,",FLDS=".01;C1,1;C20;L17,2,3,6;C45;L15,5;C65,4;C1,7;C1",BY="5",FR=$S($D(^RMPR(668,"B")):$O(^RMPR(668,"B","")),1:2890101)
 S TO=RMPRDT,DHD="Purge Suspense File Entries from Station/Division "_RMPR("STA") D EN1^DIP
 N RMPR6641
 F  S RMPRIEN=$O(^RMPR(668,RMPRIEN)) Q:RMPRIEN'>0  I $P($G(^RMPR(668,RMPRIEN,0)),U,7)=RMPR("STA") I ($P(^RMPR(668,RMPRIEN,0),U,5))&($P(^(0),U,5)<RMPRDT) S DA=RMPRIEN,DIC="^RMPR(668," S DA=RMPRIEN,DIK=DIC D ^DIK D  S RDEL=RDEL+1
 . S RMPR6641=0 F  S RMPR6641=$O(^RMPR(664.1,"SUS",DA,RMPR6641)) Q:RMPR6641'>0  D
 .. I $D(^RMPR(664.1,RMPR6641,0)) S $P(^(0),U,8)=""
END I $G(RDEL)<1 W !!,"No Suspense entries purged."
 I $G(RDEL)>1 W !!,RDEL," Suspense entries purged."
 I $G(RDEL)=1 W !!,RDEL,"Suspense entry purged. "
EXIT ;common exit point
 K I,RD,X,DIS,%ZIS,X1,X2,RMPRIEN,RMPRDT,RMPR6641,RDEL,DIC,DIK,DA,RL,BY,DHD,DHIT,FLDS,FR,TO D ^%ZISC
 G AUDIT^RMPR8PG1    ;RMPR*3.0*163  Call to audit/remove file 668 'L' & 'L1' x-ref with pointer to null master rec
 Q
CONFIRM(RMPRSITE,RMPRSTA) ;RMPR*3.0*211;display number of deletes and ask user to confirm to proceed with the Purge;
 ;Return 1 to proceed with purge, 0 to not proceed;
 N I,RMPRIEN,RMPRDT,RMPRSN,EDEL,RMPRYN,RMPROLD,RMPRNEW,RMPRPD
 S (I,RMPRIEN,EDEL)=0,RMPRSN=$P(^RMPR(669.9,RMPRSITE,0),U),RMPROLD=DT,RMPRNEW=0
 ;Check Suspense Purge value
 S RMPRDT=$P(^RMPR(669.9,RMPRSITE,0),U,8) I RMPRDT'>89 D  Q 0
 .W !,"The SUSPENSE PURGE value in the PROSTHETICS SITE PARAMETER FILE for "
 .W !,RMPRSN," is less than 90 days."
 .W !,"The Suspense Purge cannot proceed unless the value is between 90 and "
 .W !,"4,000 days (inclusive)."
 .D RTN
 S X1=DT,X2=-RMPRDT D C^%DTC S RMPRPD=X
 ;Check if file has 0 node and whether there are any entries
 I RMPRPD<$O(^RMPR(668,"B",""))!('$O(^RMPR(668,0))) D  Q 0
 .W !,"There are no suspense records to be purged or the file has no 0 node."
 .D RTN
 ;Scan suspense file to estimate how much will be deleted"
 W !!,"The PROSTHETIC SUSPENSE file will now be scanned to estimate the number of"
 W !,"records that will be purged. Depending on how long it has been since the last"
 W !,"purge, it may take some time to determine the estimate.",!
 F  S RMPRIEN=$O(^RMPR(668,RMPRIEN)) Q:RMPRIEN'>0  I $P($G(^RMPR(668,RMPRIEN,0)),U,7)=RMPRSTA,($P(^RMPR(668,RMPRIEN,0),U,5))&($P(^(0),U,5)<RMPRPD) D
 .S EDEL=EDEL+1,X=$P(^RMPR(668,RMPRIEN,0),U) S:X<RMPROLD RMPROLD=X S:X>RMPRNEW RMPRNEW=X
 I EDEL'>0 W !,"There are currently no suspense records old enough to be purged." D RTN Q 0
 ;Display estimate of records to purged
 W !,"For the ",RMPRSN,", there are currently ",EDEL
 W !,"suspense records that will be purged based on the SUSPENSE PURGE value in the"
 W !,"PROSTHETICS SITE PARAMETER FILE. The value is currently set to ",RMPRDT," days.",!
 S Y=RMPROLD D DD^%DT S RMPROLD=$P(Y,"@"),Y=RMPRNEW D DD^%DT S RMPRNEW=$P(Y,"@")
 W !,"The oldest record that will be purged was suspended on ",RMPROLD,"."
 W !,"The most recent record to be purged was suspended on ",RMPRNEW,".",!
 W !,"Once the purge runs, the entries purged are unrecoverable.",!
RMPRTP ;Ask user to confirm before initiating the purge
 W !,"Are you sure you want to proceed with the purge?  NO// " R RMPRYN:DTIME I '$T!(RMPRYN["^") Q 0
 S:RMPRYN="" RMPRYN="N" S RMPRYN=$E(RMPRYN)
 I "YyNn"'[RMPRYN W !!,"Enter YES to proceed with the purge. Otherwise, enter NO.",! G RMPRTP
 I "Yy"'[RMPRYN Q 0
 Q 1
RTN ;
 R !,"Type < Enter > to continue: ",I:DTIME Q
