A1BFMSG1 ;ALBANY ISC ; ECF ; 26MAR93 3:45PM [ 05/20/93  2:16 PM ]
 ;;V1.0
EN ;
 D SETUP
 D COMPT I A1BFSEND D EN^A1BFMSG2,EXIT Q
 D CHREAD I A1BFSEND D EN^A1BFMSG2,EXIT Q
 Q
SETUP ;
 D NOW^%DTC S A1BFND=X,A1BFNH=%H,A1BFFMDT=%,Y=% X ^DD("DD") S A1BFPRDT=Y
 S A1BFSEND=0
 Q
COMPT ;If last error msg over 30 minutes ago, send another
 ;whether it's been read or not
 Q:'$D(^A1BF(11601,1,4)) 
 I $P(^A1BF(11601,1,4),U,1)']""!($P(^(4),U,1)>A1BFFMDT) S A1BFSEND=1 Q
 S X=$P(^A1BF(11601,1,4),U,1) D H^%DTC 
 I %H<($P(A1BFNH,",",1)-1) S A1BFSEND=2  Q
 I %H=$P(A1BFNH,",",1) I ($P(A1BFNH,",",2)-%T)>1800 S A1BFSEND=3 Q
 I %H+1=$P(A1BFNH,",",1) I (86439-%T)+$P(A1BFNH,",",2)>300 S A1BFSEND=4  Q
 Q
CHREAD ;Has last error msg been read?  If so, send another
 S (A1BFRC,A1BFX)=0 F I=0:0 S I=$O(A1BFEMR(I)) Q:I=""  S A1BFRC=A1BFRC+1
 Q:'$D(^A1BF(11601,1,4))  Q:$P(^(4),U,2)']""  S A1BFMNO=$P(^(4),U,2)
 Q:'$D(^XMB(3.9,A1BFMNO,0))
 I $P(^XMB(3.9,A1BFMNO,0),U,1)'["RTM Error" S A1BFSEND=1 Q  ;If this isn't our message, better send another
 F I=0:0 S I=$O(^XMB(3.9,A1BFMNO,1,"C",I)) Q:I=""!(I'?.N)  D
 .Q:'$D(A1BFEMR(I))  ;Not designated recipient
 .Q:'$D(^VA(200,I,0))  ;Bad pointer
 .Q:'$D(^XMB(3.7,I,0))  ;No such mail user
 .Q:'$D(^XMB(3.7,"M",A1BFMNO,I))  ;Get basket msg is in
 .S J=$O(^XMB(3.7,"M",A1BFMNO,I,0)) Q:J=""
 .I $P(^XMB(3.7,I,2,J,1,A1BFMNO,0),U,4)]"" S A1BFX=A1BFX+1  ;Has it been read?
 I $S((A1BFRC=1)&A1BFX:1,A1BFRC=1:0,A1BFX>1:1,1:0) S A1BFSEND=1
 Q
EXIT ;
 K A1BFFMDT,A1BFMNO,A1BFND,A1BFNH,A1BFPRDT,A1BFRC,A1BFSEND,A1BFX,A1BFZERO,I,J,X,Y
 Q
