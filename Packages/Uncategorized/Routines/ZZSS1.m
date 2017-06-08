ZZSS1 ;at/jas; birmingham ocio/albany ocio ;PROGRAM TO COUNT
 ;
 D QUEST 
START ;
 D BUILD,CNT,DISPLAY
 Q
QUEST ;
 S DIR("A")="Select the Time Increment You Want to Use"
 S DIR(0)="N^0:99999999"
 D ^DIR
 I Y="^" Q
 S Y=+Y
 Q        
 ;
BUILD ; BUILDS THE WINDOW FOR DISPLAY
 D HOME^%ZIS
 D PREP^XGF
 D WIN^XGF(2,10,17,77)
 D SAY^XGF(1,11,"[Number of Jobs Currently in Job Table]")
 D SAY^XGF(1,55,"[Time Increment] ") W Y
 D SAY^XGF(3,5,">150")
 D SAY^XGF(4,5,">140")
 D SAY^XGF(5,5,">130")
 D SAY^XGF(6,5,">120")
 D SAY^XGF(7,5,">110")
 D SAY^XGF(8,5,">100")
 D SAY^XGF(9,5,"> 90")
 D SAY^XGF(10,5,"> 80")
 D SAY^XGF(11,5,"> 70")
 D SAY^XGF(12,5,"> 60")
 D SAY^XGF(13,5,"> 50")
 D SAY^XGF(14,5,"> 40")
 D SAY^XGF(15,5,"> 30")
 D SAY^XGF(16,5,"> 20")
 D SAY^XGF(18,10,"") D ^%T
 Q
CNT ;
 K JOB,PROG,JJ,sw10,pid,i,base,user,CNT,rx,XX,M,PASS
 S rx=""
 s sw10=$v(0,-2,$ZU(40,0,1))\1024#2
 s base=$v($zu(40,2,47),-2,"S")
 s maxpid=$v($zu(40,2,47)-(2*$zu(40,0,4)),-2,4)
 K PASS S CNT=0
 f i=1:1:maxpid s pid=$v(i*4+base,-3,4) S:pid CNT=CNT+1
 I CNT>150 S CNT=3
 I CNT>140 S CNT=4
 I CNT>130 S CNT=5
 I CNT>120 S CNT=6
 I CNT>110 S CNT=7
 I CNT>100 S CNT=8
 I CNT>90 S CNT=9
 I CNT>80 S CNT=10
 I CNT>70 S CNT=11
 I CNT>60 S CNT=12
 I CNT>50 S CNT=13
 I CNT>40 S CNT=14
 I CNT>30 S CNT=15
 I CNT>20 S CNT=16
 Q
DISPLAY ;
 F I=11:1:76 D SAY^XGF(CNT,I,"*") H Y D CNT
 D SAY^XGF(21,11,"More [Y] [N] [^] ") R ANS:30
 I ANS="^" Q
 I ANS="N" Q
 D SAY^XGF(22,11,"New Increment: ") R Y:30
 I Y<0!(Y>999999) Q
 G START
 Q                
