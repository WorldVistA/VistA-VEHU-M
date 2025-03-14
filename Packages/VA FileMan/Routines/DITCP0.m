DITCP0 ;GFT/MSC - COMPARE ACROSS UCIs OR COMPARE TWO ENTRIES ;16MAR2016
 ;;22.2;VA FileMan;;Jan 05, 2016;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC FileMan 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
UCI ;Compare across UCI's  FILEMAN OPTION 9, SUBOPTION 3
 N DITCPI,DIC,DIR,DITCPUCI,DIRUT,DIB,DITCPT
 S Y=$$WUCI Q:Y=""  D DT^DICRW,L^DICRW1 Q:'$D(DIC)
 S DITCPI=+Y,DIR(0)="F^1:90",DIR("A")="Compare to what UCI",DIR("B")=$G(^DOPT("DITCPUCI",DUZ))
 I $G(^DD("OS"))=18 S DIR("?")="^D UCIQ^DITCP0"
 D ^DIR
 D:'$D(DISYS) OS^DII
 Q:U[X  S Y="" X:X'["," $G(^DD("OS",DISYS,"UCICHECK")) I 0[Y W !!,X," IS NOT A VALID UCI!" Q 
 S ^DOPT("DITCPUCI",DUZ)=X,DITCPUCI=X
 K DIR S DIR(0)="S^1:DATA DICTIONARY ONLY;2:FILE ENTRIES ONLY;3:DATA DICTIONARY AND FILE ENTRIES",DIR("B")=3 D ^DIR
 Q:U[X  S DIB=Y
 D START Q:IO=""
 S DIR=DITCPI
DD K DITCPT
 I DIB#2 D EN^DITCP("^DD("_DITCPI_")","^["""_DITCPUCI_"""]DD("_DITCPI_")",0,1,.DITCPT) F X=0:0 S X=$O(^DD(DITCPI,"SB",X)) Q:'X  S DITCPI(X)=""
 I '$D(DIRUT) S DITCPI=$O(DITCPI(0)) I DITCPI K DITCPI(DITCPI) G DD
FILES S X=$G(DITCPT) K DITCPT S DITCPT=X
 I '$D(DIRUT),DIB>1,$D(^DIC(DIR)) S X=$$CREF^DILF(^DIC(DIR,0,"GL")) D EN^DITCP(X,"^["""_DITCPUCI_"""]"_$P(X,U,2,9),DIR,1,.DITCPT)
 I '$D(DIRUT) S DIR=$O(^DIC(DIR)) I DIR,DIR'>DIB(1) K DITCPI S DITCPI=DIR G DD
C G CLOSE^DIO4
 ;
 ;
UCIQ ;HELP
  N L W !?4,"CHOOSE FROM:" D  ;***CACHE-SPECIFIC   FROM %NSP
 .X "n gft,UCI f UCI=1:1:$zu(90,0) s gft=$zu(90,2,0,UCI) s:$l(gft) L(gft)=0"
 S L="" F  S L=$O(L(L)) Q:L=""  W !?8,L
 Q
 ;
 ;
ENTRIES ;Compare entries in a File
 N D1,D2,DIRUT,DITCP
 I $D(DIU) S DIC=DIU
 E  D R^DICRW Q:'$D(DIC)
 S DIC(0)="AEQM" D ^DIC Q:Y<0  S DITCP=+Y,DIC("A")="Select a SECOND: ",DIC("S")="I Y-"_+Y D ^DIC K DIC("S"),DIC("A") Q:Y<0
 S D1=DIC_DITCP_")",D2=DIC_+Y_")",DIDD=+$P(@(DIC_"0)"),U,2)
 D START Q:IO=""
 D EN^DITCP(D1,D2,DIDD,"2N")
 G C
 ;
 ;
 ;
START ;
 W !,"DISPLAY COMPARISON ON" K %ZIS D ^%ZIS K POP Q:IO=""  U IO
 D DT^DICRW S Y=DT D DD^%DT W !,Y I $D(^DD("SITE")) W ?14,^("SITE") S Y=$$WUCI
 I $D(DITCPUCI) S %=$L(DITCPUCI) W ?$S(IOM\2>%:IOM\2,1:IOM-%),"UCI: "_DITCPUCI
 W ! F %=1:1:IOM W "-"
 Q
 ;
WUCI() ;
 N Y I ^DD("OS")=19!(^DD("OS")=17) X "S Y=$ZGD" ;GTM GLOBAL DIRECTORY
 E  I $D(^%ZOSF("UCI"))#2 X ^("UCI")
 I $D(Y) W !?2,"UCI: "_Y Q Y
 Q ""
