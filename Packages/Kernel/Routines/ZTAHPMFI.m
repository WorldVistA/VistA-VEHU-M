ATAENGFI ; GLRISC/REL - File Manager Search/Print ;10/5/90  15:30 ; [ 04/23/93  3:20 PM ]
 ;;1.0;;LOCAL ROUTINE
PRNT ; File Manager Print
 D DICRW Q:Y<1  S L=1 G EN1^DIP
SRCH ; File Manager Search
 D DICRW Q:Y<1  G EN^DIS
DIC ; List Dictionary
 W ! G ^DID
INQ ; Inquire to File
 D DICRW Q:Y<1  S DI=DIC,DPP(1)=+Y_"^^^@",DK=+Y
 G B^DII
ED ;Edit File
 D DICRW Q:Y<1  S DIE=DIC G EN^DIB
DICRW ; Select File
 K %,DTOUT,BY,DA,DHD,DI,DIC,DPP,DK,DIQ,DIS,DUOUT,FR,L,TO
 D NOW^%DTC S DT=%\1 K %,%H,%I
 S DIC="^DIC(",DIC("S")="I $D(^DIC(""AC"",""ENG"",+Y))",DIC(0)="AEQM",DIC("A")="SELECT FILE: "
 W ! D ^DIC K DIC I $D(DTOUT)!(Y<1) Q
 I $D(^DIC(+Y,0,"GL")) K DIC S DIC=^("GL") Q
 K DIC S Y=-1 Q
