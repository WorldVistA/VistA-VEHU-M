PRC7A ;WISC/PLT-conversion utility (esitmate disk space/decode validate code ; 07/07/93  2:00 PM ; 02 Apr 93  12:12 PM
V ;;4.0;IFCAP;;9/23/93
 N PRCOP,PRCFN,PRCFNA,PRCRN,PRCCN,PRCCT,TOTE
ENT K PRCOP,PRCFN,PRCFNA,PRCRN,PRCCN,PRCCT,TOTE
 W !!
Q1 S X=$$Z(1,"OPTION") G QUIT:X=""!(X?1"^".E) S PRCOP=X
Q2 S X=$$Z(2,"Select File Number") G Q1:X=""!(X?1"^".E) S PRCFN=X
Q3 S X=$$Z(3,"Record ID Range(1-9999999999)") G Q2:X=""!(X?1"^".E)
 S PRCRN=X
Q4 ;S X=$$Z(4,"Number of Characters Add per Esig During Conversion")
 G Q2:X=""!(X?1"^".E) S PRCCN=30
QE ;
DEV K ZTQUEUED S %ZIS="Q" D ^%ZIS G ENT:POP
 I $G(IO("Q"))=1 D  G ENT
 . S ZTRTN="TM^PRC7A",ZTDESC="IFCAP CONVERSION UTILITY"
 . S ZTSAVE("PRC*")=""
 . K IO("Q") D ^%ZTLOAD
 . QUIT
TM ;start processing
 U IO S TOTE="",PRCFN=$TR(PRCFN,".","A") S:PRCFN'["A" PRCFN=PRCFN_"A"
 F PRCFNA="421A","421A2","421A5","423A","443A","410A","442A" D
 . I PRCFN="ALL"!(PRCFN=PRCFNA) S PRCPGM="C"_PRCFNA_"^PRC7A1(PRCRN)" D
 .. I PRCOP=2 W !,"IFCAP DECODE LIST PRINTED ON " D NOW^%DTC S Y=% D DD^%DT W Y W !,"FILE NUMBER: ",$TR(PRCFNA,"A",".")+0,!,"Record Id",?15,"Record Id",?35,"ESIG BLOCK NAME",!
 ..D @PRCPGM
 ..QUIT
 . QUIT
 ;W:PRCOP=2 @IOF
 W !!!,"IFCAP CONVERSION DISK SPACE ESTIMATE PRINTED ON " D NOW^%DTC S Y=% D DD^%DT W Y W !!,"Assume that data block is 95% efficiency, 1024 bytes/block"
 W !,"and 399 blocks/map.  The number of characters added for each ESIG is ",PRCCN,".",!
 W !,$J("FILE NUMBER",20),$J("# of Esig",20),$J("# of Blocks",20),$J("# of Map",10),!!
 S A="" F  S A=$O(PRCCT(A)) Q:A=""  S TOTE=$G(TOTE)+PRCCT(A) D
 . S B=PRCCT(A)*PRCCN/(1024*0.95)
 . W !,$J($TR(A,"A",".")+0,20),$J(PRCCT(A),20),$J(B,20,2),$J(B/399,10,2)
 S B=$G(TOTE)*PRCCN/(1024*.95)
 W !!,$J("TOTAL",20),$J(TOTE,20),$J(B,20,2),$J(B/399,10,2)
 W !!!,"END OF REPORT DATE/TIME: " D NOW^%DTC S Y=% D DD^%DT W Y
EXIT D ^%ZISC K TOTE,PRCOP,PRCFN,PRCFNA,PRCPGM,PRCRN,PRCCN,PRCCT
 I '$D(ZTQUEUED) D HOME^%ZIS G ENT
QUIT QUIT
 ;
Z(PRCQN,PRCQ) ;question driver for DIR
 K DIR S X="Z"_PRCQN,DIR(0)=$P($T(@X),";",3,999)
 S X="Z"_PRCQN_"A",DIR("A")=PRCQ
 F I=1:1 S A=$T(@X+I) Q:A=""!(A?1A.E)  S DIR("A",I)=$P(A,";",3,999)
 S X="Z"_PRCQN_"Q",DIR("?")=" "
 F I=1:1 S A=$T(@X+I) Q:A=""!(A?1A.E)  S DIR("?",I)=$P(A,";",3,999)
 D ^DIR K DIR
 QUIT Y
 ;
Z1 ;;NO^1:2
Z1A ;;OPTION
 ;;IFCAP Conversion Utility Option
 ;;      1.  Estimate File Conversion Diskspace Needed
 ;;      2.  Decode Validation Codes in Files before/after conversion
Z1Q ;;
 ;;Please enter:
 ;;  Option number.
Z2 ;;SOX^410:410 FILE;421:421 FILE;421.2:421.2 FILE;421.5:421.5 FILE;423:423 FILE;442:442 FILE;443:443 FILE;ALL:ALL FILES
Z2A ;;Select File Number
Z2Q ;;
 ;;Please enter:
 ;;  Valid file number or 'All' for all files
Z3 ;;FO^1:30^K:X'?1.N1"-"1.N!(X+0<1)!($P(X,"-")>$P(X,"-",2))!($P(X,"-",2)>99999999999) X
Z3A ;;RECORD ID RANGE(1-9999999999)
Z3Q ;;
 ;;Please enter:
 ;;  File internal record id number range (e.g. 200-500).
Z4 ;;NO^0:40
Z4A ;;Number of Characters Added per Record During Conversion
Z4Q ;;
 ;;Please enter an integer between 1 to 40.
