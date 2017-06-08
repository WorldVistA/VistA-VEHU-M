ZZQIPS ;; QUIC file DD protection Set and Kill routine for support ;
 ;;1.1;QUALITY IMPROVEMENT CHECKLIST;;MAY 6,1992
 ; To set protection on QUIC files - D SET^ZZQIPS
 ; To kill protection on QUIC files - D KILL^ZZQIPS
 ;***********************************************************************
SET ; SET DD PROTECTION FOR QUIC FILES
 W !,"Setting ""9"" nodes...."
 W !!,"File: ^QIP(735," F JJ=.01,.5,1,2,3,4,5,6,10,20,21 S ^DD(735,JJ,9)="^" W !,"Field: ",JJ
 W !!,"File: ^QIP(735.1," F JJ=.01,.5,1,2,3,4,5,10,11 S ^DD(735.1,JJ,9)="^" W !,"Field: ",JJ
 W !!,"File: ^QIP(736," F JJ=.01,1,2,3 S ^DD(736,JJ,9)="^" W !,"Field: ",JJ
 W !!,"File: ^QIP(738," F JJ=.01,1 S ^DD(738,JJ,9)="^" W !,"Field: ",JJ
 W !!,"File: ^QIP(738.1," F JJ=.01,.5,1,2,3,4,5,6,10 S ^DD(738.1,JJ,9)="^" W !,"Field: ",JJ
 W !!,"Setting ""LAYGO"" nodes...."
 S ^DD(735,.01,"LAYGO",1,0)="W *7,*7,"" ??"",!,""Do NOT edit or LAYGO to this file!!"" I 0" W !,"File: ^QIP(735,"
 S ^DD(735.1,.01,"LAYGO",1,0)="W *7,*7,"" ??"",!,""Do NOT edit or LAYGO to this file!!"" I 0" W !,"File: ^QIP(735.1,"
 S ^DD(736,.01,"LAYGO",1,0)="W *7,*7,"" ??"",!,""Do NOT edit or LAYGO to this file!!"" I 0" W !,"File: ^QIP(736,"
 S ^DD(738,.01,"LAYGO",1,0)="I '$O(^QIP(738,0))" W !,"File: ^QIP(738,"
 S ^DD(738.1,.01,"LAYGO",1,0)="W *7,*7,"" ??"",!,""Do NOT edit or LAYGO to this file!!"" I 0" W !,"File: ^QIP(738.1,"
 Q
KILL ; KILL DD PROTECTION ON QUIC FILES
 W !,"Deleting ""9"" nodes...."
 W !!,"File: ^QIP(735," F JJ=.01,.5,1,2,3,4,5,6,10,20,21 K ^DD(735,JJ,9) W !,"Field: ",JJ
 W !!,"File: ^QIP(735.1," F JJ=.01,.5,1,2,3,4,5,10,11 K ^DD(735.1,JJ,9) W !,"Field: ",JJ
 W !!,"File: ^QIP(736," F JJ=.01,1,2,3 K ^DD(736,JJ,9) W !,"Field: ",JJ
 W !!,"File: ^QIP(738," F JJ=.01,1 K ^DD(738,JJ,9) W !,"Field: ",JJ
 W !!,"File: ^QIP(738.1," F JJ=.01,.5,1,2,3,4,5,6,10 K ^DD(738.1,JJ,9) W !,"Field: ",JJ
 W !!,"Deleting ""LAYGO"" nodes...."
 F JJ=735,735.1,736,738,738.1 K ^DD(JJ,.01,"LAYGO",1,0) W !,"File: ",JJ
 Q
