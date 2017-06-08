MUSCUM ;AVAMC/REG- AP PATIENT CUM ;3/8/91  12:10 ;
 ;;5.1;LAB;;04/11/91 11:06
 S IOP="HOME" D ^%ZIS,L^LRU
 W !!?15,LRAA(1)," PATIENT REPORT(S) DISPLAY"
P ;
 ;
R ;
 I '$D(^LR(LRDFN,LRSS)) W *7,!!,"No ",LRAA(1)," reports on file",! Q
 D S F LRI=0:0 W @IOF S LRA(1)=$Y+21,LRI=$O(^LR(LRDFN,LRSS,LRI)) Q:'LRI  S B=^(LRI,0) D W Q:LRA(2)?1P
 Q
F D E S C=0 F LRZ=0:1 S C=$O(^LR(LRDFN,LRSS,LRI,LRV,C)) Q:'C  D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  S X=^LR(LRDFN,LRSS,LRI,LRV,C,0) D ^DIWP
 Q:LRA(2)?1P  D:LRZ ^DIWW Q
E K ^UTILITY($J) S DIWL=3,DIWR=IOM-3,DIWF="W" Q
W S Y=+B D D^LRU S LRW(1)=Y,Y=$P(B,"^",10) D D^LRU S LRW(10)=Y,Y=$P(B,"^",3) D D^LRU S LRW(3)=Y,X=$P(B,"^",2) D:X D^LRUA S LRW(2)=X,LRW(11)=$P(B,"^",11)
 S X=$P(B,"^",4) D:X D^LRUA S LRW(4)=X,X=$P(B,"^",7) D:X D^LRUA S LRW(7)=X
 W !,"Date Spec taken: ",LRW(1),?38,"Pathologist:",LRW(2),!,"Date Spec rec'd: ",LRW(10),?38,$S(LRSS="SP":"Resident: ",1:"Tech: "),LRW(4)
 W !,$S($L(LRW(3)):"Date  completed: ",1:"REPORT INCOMPLETE"),LRW(3),?38,"Accession #: ",$P(B,"^",6),!,"Submitted by: ",$P(B,"^",5),?38,"Practitioner:",LRW(7),!,LR("%")
 I LRW(11)="" W !,*7,"Report not verified",! G MORE
 I $D(^LR(LRDFN,LRSS,LRI,.1)) W !,"Specimen: " S LRV=.1 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.2)) W !,"Brief Clinical History:" S LRV=.2 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.3)) W !,"Preoperative Diagnosis:" S LRV=.3 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.4)) W !,"Operative Findings:" S LRV=.4 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,.5)) W !,"Postoperative Diagnosis:" S LRV=.5 D F Q:LRA(2)?1P
 D SET^LRUA I $D(^LR(LRDFN,LRSS,LRI,1)) W !,LR(69.2,.03) S LRV=1 D F Q:LRA(2)?1P
 I $D(^LR(LRDFN,LRSS,LRI,1.1)) W !,LR(69.2,.04)," (Date Spec taken: ",LRW(1),")" I $D(^LR(LRDFN,LRSS,LRI,4,0)),$P(^(0),"^",4) D ^LRSPRPTM
 S LRV=1.1 D F Q:LRA(2)?1P
 I $O(^LR(LRDFN,LRSS,LRI,1.2,0)) W !,"Supplementary Report:" F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,1.2,C)) Q:'C!(LRA(2)?1P)  S X=^(C,0),Y=+X,X=$P(X,U,2) D D^LRU W !?3,"Date: ",Y W:'X " not verified" D:X U Q:LRA(2)?1P
 Q:LRA(2)?1P  I $D(^LR(LRDFN,LRSS,LRI,2)) D B,^LRAPCUM1 Q:LRA(2)?1P
 Q:LRA(2)?1P  D MORE Q
MORE R !,"'^' TO STOP: ",LRA(2):DTIME I LRA(2)["?" W *7 G MORE
 I LRA(2)?1P S A=0 Q
 S LRA(1)=LRA(1)+21 W $C(13),$J("",41),$C(13) Q
S S (A,LRA(2))=0 Q
U D E S E=0 F LRZ=0:1 S E=$O(^LR(LRDFN,LRSS,LRI,1.2,C,1,E)) Q:'E  D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  S X=^LR(LRDFN,LRSS,LRI,1.2,C,1,E,0) D ^DIWP
 Q:LRA(2)?1P  D:LRZ ^DIWW Q
B F C=0:0 S C=$O(^LR(LRDFN,LRSS,LRI,2,C)) Q:'C!(LRA(2)?1P)  D SP
 Q
SP F G=0:0 S G=$O(^LR(LRDFN,LRSS,LRI,2,C,5,G)) Q:'G  S X=^(G,0),Y=$P(X,"^",2),E=$P(X,"^",3),E(1)=$P(X,"^")_":",E(1)=$P($P(LR(LRSS),E(1),2),";") D D^LRU S T(2)=Y D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  D WP
 Q
WP W !,E(1)," ",E," Date: ",T(2)," ",! D E S F=0 F LRZ=0:1 S F=$O(^LR(LRDFN,LRSS,LRI,2,C,5,G,1,F)) Q:'F!(LRA(2)?1P)  D:$Y>LRA(1)!'$Y MORE Q:LRA(2)?1P  S X=^LR(LRDFN,LRSS,LRI,2,C,5,G,1,F,0) D ^DIWP
 Q:LRA(2)?1P  D:LRZ ^DIWW Q
