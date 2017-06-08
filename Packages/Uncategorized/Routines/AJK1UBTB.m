AJK1UBTB ;580/MRL - Collections, XMIT Build String; 06-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This process is designed to build the record using information from
 ;the BILL/CLAIMS (#399) file, ACCOUNTS RECEIVABLE (#430) file and the
 ;PATIENT (#2) file.  Record parameters are defined in the AJK1UB DATA
 ;SET (#580950.6) file by the local facility.
 ;
 Q
 ;
TS(R,T) ; --- enter here to create record
 ;             R = record number in file 430
 ;             T = transaction type
 ;                 1 = Cancellation
 ;                 2 = Suspension
 ;                 5 = Paid in Full
 ;                 9 = New Bill Transmission
 ;                 A = Partial Payment
 ;
 ;             Returns STR()
 ;
 I $G(AJKCP("C"))="" D CPAR^AJK1UBCP G NOCOL:'AJKCP  ;parameters
 K AR,BN,C,STR
 S NEW=$S(T=9:1,1:0)
 F I=0,7,202 S AR(I)=$G(^PRCA(430,+R,I)) ;ar/430 nodes
 I '+$G(^PRCA(430.2,+$P(AR(0),"^",2),"AJK1UB")) G NOCOL
 S DUE=0 F I=1:1:5 S DUE=DUE+$P(AR(7),"^",I)
 S X=$O(^DIZ(580950.8,"C",T,0))
 I +X,$P($G(^DIZ(580950.8,+X,0)),"^",3) S DUE=0 ;don't xmit due amt
 I NEW,'DUE G NOCOL ;no balance due on new bill
 S DUE=$P(DUE,".",1)_$E($P(DUE,".",2)_"00",1,2) ;add cents
 D DATA(NEW) ;get array from file
 S X=$P($P(AR(0),"^",1),"-",2) ;bill# w/o stn
 S X=$O(^DGCR(399,"B",X,0)) ;bill# in 399
 F I=0,"S","I1","I2","I3","U1","M","MP" D
 .S BN(I)=$G(^DGCR(399,+X,I)) ;bn/399 nodes
 I '+$G(^DGCR(399.3,+$P(BN(0),"^",7),"AJK1UB")) G NOCOL ;rate type exc.
 I $P($G(^DGCR(399.3,+$P(BN(0),"^",7),0)),"^",7)="p" G NOCOL ;pt bill
 D STR(19,AJKCP("C"))
 S DFN=+$P(BN(0),"^",2) ;patient
 S X=$P(BN(0),"^",21),X="I"_($F("PST",X)-1),X=BN(X)
 D INS(+BN("MP"),BN("M"),X) ;insurance
 S X=$G(^DIC(36,+BN("MP"),"AJK1UB"))
 I $S(X="*":1,'+X:0,+DUE<+X:1,1:0) G NOCOL
 D STR(13,$P(^DPT(DFN,0),"^",1)) ;patient name
 D STR(14,$P(BN(0),"^",1)) ;bill #
 D STR(15,1) ;service code
 D STR(16,$$DATE($P(BN(0),"^",3))) ;service date
 D STR(18,T) ;transaction code
 D STR(17,DUE) ;amount
 F I=3,20,21,22,23,24,25,26,27,28,29,30,31,32 I $D(DE(I)) D
 .D STR(I,"") ;zero/space fills
 F I=25,26 I $D(DE(I)) D STR(I,$C(I+40)) ;record id (part)
 S X=$S(NEW:1,1:2),(I,STR)=0
 F S=1,2 D
 .F  S I=$O(^DIZ(580950.6,X,"D","AS",I)),J=0  Q:I'>0  D
 ..F  S J=$O(^DIZ(580950.6,X,"D","AS",I,J)) Q:J'>0  D
 ...S Y=+$P(DE(J),"^",4) S:'Y Y=1 S:Y=3 Y=S
 ...I Y=S S STR(S)=$G(STR(S))_DS(J),STR=1
 G END
 ;
 ;
NOCOL ; --- don't create a transmit record
 ;
 K STR
 S STR=0
 ;
END ; --- that's all folks
 ;
 K AR,BN,C,D,DE,DFN,DS,DUE,F,I,IC,J,L,N,N1,NEW,R,S,T,W,X,Y
 Q
 ;
INS(IC,A,PAY) ; --- return insurance co. info.
 ;
 N Y
 F I=0,.11 S X(I)=$G(^DIC(36,+IC,I))
 D STR(1,$P(X(0),"^",1)) ;name
 S C=0 F I=5,6 S Y=$P(A,"^",I) D:Y]""
 .S C=C+1,Y(C)=Y
 I C=1 S Y(2)=Y(1),Y(1)="   " ;optl st blank if only one
 F I=1,2 D STR((I*2),$G(Y(I))) ;street 1&2
 D STR(5,$P(A,"^",7)) ;city
 D STR(6,$P($G(^DIC(5,+$P(A,"^",8),0)),"^",2)) ;state
 S X=$P(A,"^",9)
 D STR(7,$E(X,1,5)) ;zip
 D STR(8,$E(X,6,9)) ;z+4
 S (N,I)=0 F  S I=$O(^DPT(DFN,.312,I)) Q:I'>0!(N)  S X=^(I,0) D
 .I +X=+IC S N=^(0),N1=$G(^(1))
 S W=0,X=$P(AR(202),"^",4) I $L(X) D STR(9,X) ;cert/430
 E  D STR(9,$$IN1(2)) ;subscriber id/399
 S X=$P(AR(202),"^",6) I $L(X) D STR(10,X) ;group/430
 E  S X=$P($G(^IBA(355.3,+$$IN1(18),0)),"^",4) D STR(10,X) ;group/399
 D STR(11,$$IN1(17)) ;insured name
 I $P(PAY,"^",6)'="v" S Y=$P(PAY,"^",2) S:Y?9N X=Y
 I X'?9N S X=$P(^DPT(DFN,0),"^",9)
 D STR(12,X) ;ssn
 Q
 ;
IN1(X) ; --- return info from either BILL/CLAIM or PATIENT file
 ;     decides where to get information and returns it.
 ;     If I find the subscriber id in Bill/claim I get all
 ;     data there, if possible.  Otherwise, I get from
 ;     Patient file.  [W=0 (Bill/Claim); W=1 (Patient)]
 ;
 S Y=$P(PAY,"^",+X) ;Bill/Claim file
 I Y=""!(W) S Y=$P(N,"^",+X) S:X=2 W=1 ;patient file
 Q Y
 ;
STR(X,V) ; --- format & extract data
 ;             X = field
 ;             V = Value
 ;
 N I,D,N,L,F,Y,Z
 I '+$G(DE(+X)) Q  ;not a needed field
 S N=+X,Y=DE(+X),D=V,L=+$P(Y,"^",2),F=1
 I $P(Y,"^",3)=2!($P(Y,"^",3)=4) S F=0
 S $P(Z,$S(F:" ",1:"0"),100)=""
 I F S X=$E(D_Z,1,L)
 E  S X=$E(Z,0,(L-$L(D)))_D,X=$E(X,1,L)
 S DS(+N)=X Q
 ;
DATE(Y) ; --- transform date to MMDDYY format
 ;
 S X=$E(Y,4,7)_$E(Y,2,3)
 Q X
 ;
DATA(X) ; --- get transmission data and save in DE()
 ;
 S X=$S(X:X,1:2),I=0
 K DE,DS
 F  S I=$O(^DIZ(580950.6,+X,"D",I)) Q:I'>0  S DE(I)=$P(^(I,0),"^",2,5)
 Q
