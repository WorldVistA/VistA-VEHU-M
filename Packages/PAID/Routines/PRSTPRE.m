PRSTPRE ; HISC/CLS/WAA - Payroll Edit ;11/20/89  13:51
 ;;3.5;PAID;;Jan 26, 1995
 S PP=$P(^PRST(455,0),"^",3) G:PP<1 EX^PRSTPRE1 S X="T",%DT="X" D ^%DT S DT=+Y K %DT
 W !!,"8B TRANSACTIONS PAYROLL CLERK EDIT/REVIEW Routine for Pay Period ",+$E(PP,4,5),", ",1700+$E(PP,1,3) D CODES^PRSTUTL
 S FLG="P"
TLUN D PICK^PRSTUTL G:TLIEN<1 EX^PRSTPRE1 S TL=$P(^PRST(455.5,TLIEN,0),"^",1)
QST W !!,"Would you like to edit the 8B RECORDs in alphabetical order" S %=1 D YN^DICN I % S LP=% G LOOP^PRSTPRE1:LP=1,NME:LP=2,TLUN
 W !!,"Answer YES if you want all RECORDs brought up for which timekeeper"
 W !,"data exists which has not been verified and which was not entered"
 W !,"by you." G QST
NME K DIC S DIC="^PRST(455,PP,1,",DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",7)=TL" S DIC(0)="AEQM" W ! D ^DIC S DFN=+Y K DIC
 I DFN=-1 D:FLG="P" TCLS^PRSTKE G TLUN
 I $P(^PRST(455,PP,1,DFN,0),"^",2)="" W *7,!!,"Timekeeper has not entered data for this employee." G NME
 I $P(^PRST(455,PP,1,DFN,0),"^",2)="H" W *7,!!,"RECORD is on hold no editing allowed." G NME
 S LP=2 D LP^PRSTPRE1 G NME
