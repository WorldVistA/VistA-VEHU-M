PRCPU4 ;WISC/RFJ-utilities ;14 Feb 91
 ;;4.0;IFCAP;;9/23/93
 Q
R ;press return to continue
 N X U IO(0) W !,"<Press RETURN to continue>" R X:DTIME Q
 ;
 ;
P ;pause
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" PRCPFLAG=1 U IO Q
 ;
 ;
YN ;yes, no reader
 ;%=default answer [1=yes,2=no]; XP=prompt array [none,1,2,3...]; XH=help array [none,1,2,3...]
 N I,X,XD S:'$D(%)#2 %=3 S XD=% W:$D(XP) !,XP F I=1:1 Q:'$D(XP(I))  W !,XP(I)
 W "? ",$P("YES// ^NO// ^<YES/NO> ","^",XD) R X:$S($D(DTIME):DTIME,1:300) E  W "  <<timeout>>" S X="^"
 G:X["?" HELP S:X["^" %=0 G:X["^" Q S:X="" X=XD S X=$TR($E(X),"yYnN","1122") I X=0!(X>2) G HELP
 W:$X>73 ! W $P("  (YES)^  (NO)","^",X) S %=X
Q K XP,XH Q
HELP I '$D(XH) W !,"You must enter a 'Yes' or a 'No', or you may enter an '^' to Quit",!! S %=XD G YN
 W !,XH F I=1:1 Q:'$D(XH(I))  W !,XH(I)
 W ! S %=XD G YN
 ;
 ;
LOCK(X,S,T) ;incremental or decremental lock of multiple globals
 ;X array to lock; S=1...lock+ or S=0...lock-; T wait time => $D(X)=1 if successful
 N L,I S (I,L)="" F  S I=$O(X(I)) Q:'I  S L=L_$S(L'="":",",1:"")_X(I)
 I L="" K X,S,T Q
 S L=$S(S=1:"+",1:"-")_"("_L_")"_$S(T=0:"",1:":1")
LI L @L I $T!(S'=1)!(T=0) K S,T Q
 Q:$D(ZTQUEUED)  S XP="OTHER JOBS ARE ACCESSING THE FILE(S).  DO YOU WANT TO WAIT",XH="Enter 'YES' to wait "_T_" seconds for the lock to clear, 'NO' or '^' to try later.",%=1 D YN I %'=1 K X,S,T Q
 W !,"WAITING ",T," SECONDS..." S:L["):1" L=$P(L,"):",1)_"):"_T G LI
 ;
 ;
MAILMSG(V1,V2,PRCTEXT) ;create mail message and send to g.ifcap install@forum
 ; v1 = message subject
 ; v2 = 2nd line info for message (i.e. version 4.0 or patch PRC*4*1)
 ; v3 = text to be included from line 10 and up
 N DIC,XCNP,XMDUZ,XMZ
 S PRCTEXT(1,0)=" ",PRCTEXT(2,0)="Installation of IFCAP "_V2_" information message:",PRCTEXT(3,0)="",PRCTEXT(4,0)="              site: "_$G(^DD("SITE"))
 X ^%ZOSF("UCI") S PRCTEXT(5,0)="            op sys: "_$P($G(^%ZOSF("OS")),"^"),PRCTEXT(6,0)="               uci: "_Y,PRCTEXT(7,0)="              user: "_$P($G(^VA(200,+DUZ,0)),"^")
 D NOW^%DTC S DT=X,Y=%,U="^" X ^DD("DD") S PRCTEXT(8,0)="         date@time: "_Y,PRCTEXT(9,0)=" "
 S U="^",XMDUZ=.5,XMY("G.IFCAP INSTALL@FORUM.VA.GOV")="",XMTEXT="PRCTEXT(",XMSUB=V1
 D ^XMD
 Q
