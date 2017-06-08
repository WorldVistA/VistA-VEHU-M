A1BFCHK1 ;ALBANY ISC ; ECF ; 1MAR93 2:03pm [ 06/17/93  4:23 PM ]
 ;;V1.0
EN ;
 ;Check parameters to avoid predictable failures
 ;Called from A1BFLOG1
SETUP ;   
 ;
 K A1BFERR S A1BFERR(0)="",U="^"
 ;Look over params - if error or no err msg recip, send msg
 D WHERE I $O(A1BFERR(0))'="" D EN^A1BFMSG1
 D EXIT Q
WHERE ;Where am i
 D ^%GUCI I '$D(%UCI) D EXIT Q 
 S A1BFUVOL=%UCI,A1BFUCI=$P(A1BFUVOL,",",1),A1BFVOL=$P(A1BFUVOL,",",2)
PARAM ;Check existence, validity of parameter file entries    
 ;Does param file exist - entry #1 exist - error msg recipients
 ;
 I '$D(^A1BF(11601,0)) S A1BFERR(1)="" Q  ;Is param file there
 I '$D(^A1BF(11601,1,0)) S A1BFERR(2)="" Q  ;Is entry 1 there
 I '$D(^A1BF(11601,1,1,0)) S A1BFERR(3)="" Q  ;Is 0 node there
EMSG ;
 K A1BFEMR S A1BFEMR(0)=""
 F I=0:0 S I=$O(^A1BF(11601,1,3,I)) Q:I=""!(I'?.N)  S II=$G(^(I,0)),II=$P(II,U,1) D 
 .I II="" S A1BFERR(4)="" Q  ;Is ptr value there
 .I '$D(^VA(200,II,0)) S A1BFERR(5,II)=""  ;Is it a good value
 .E  S A1BFEMR(II)=""  ;Save any good pointers
 S X=$O(A1BFEMR(0)) I X="" S A1BFEMR(.5)="" ;Somebody has to get msg
 S A1BFTU=$P(^A1BF(11601,1,0),U,2) I A1BFTU="" S A1BFERR(10)="" G DEV ;Is user ptr null
 I '$D(^VA(200,A1BFTU,0)) S A1BFERR(11)=A1BFTU G MAIL  ;Is user ptr good 
 I '$L($P(^VA(200,A1BFTU,0),U,1)) S A1BFERR(12)=A1BFTU G MAIL ;Does user have name ;
ACC ;Check validity of access code
 S X=$P(^A1BF(11601,1,0),U,3),X1=$A("@"),X2=$A("\") D DE^XUSHSHP 
 D ^XUSHSH I '$D(^VA(200,"A",X)) S A1BFERR(40)="" G VER ;Check validity of verify code
VER ;Check validity of verify code
 S X=$P(^A1BF(11601,1,0),U,4),X1=$A("+"),X2=$A("}") D DE^XUSHSHP 
 D ^XUSHSH I $P(^VA(200,A1BFTU,.1),U,2)'=X S A1BFERR(41)="" G MAIL
MAIL ;
 I $P(^A1BF(11601,1,0),U,6)']"" S A1BFERR(26)="" G DEV
 S A1BFBASK=$P(^A1BF(11601,1,0),U,6)
 I '$D(^XMB(3.7,A1BFTU,2,"B",A1BFBASK)) S A1BFERR(20)=A1BFTU G DEV ;Does user hav tst basket
 S A1BFMBNO=$O(^XMB(3.7,A1BFTU,2,"B",A1BFBASK,0)) I A1BFMBNO="" S A1BFERR(21)=A1BFMBNO G DEV  ;Entry number of basket
 I '$D(^XMB(3.7,A1BFTU,2,A1BFMBNO,0)) S A1BFERR(22)=A1BFMBNO G DEV  ;Zero node defined
 S A1BFMBN=$P(^XMB(3.7,A1BFTU,2,A1BFMBNO,0),U,1) I A1BFMBN="" S A1BFERR(23)=A1BFMNO G DEV  ;Name of mailbox
 S A1BFMSNO=$O(^XMB(3.7,A1BFTU,2,A1BFMBNO,1,0)) I A1BFMSNO="" S A1BFERR(24)=A1BFMBN G DEV  ;Is there a msg in basket
 I '$D(^XMB(3.9,A1BFMSNO,0)) S A1BFERR(25)=A1BFMBNO G DEV  ;Is msg good
DEV ;
 S A1BFDEV=$O(^A1BF(11601,1,6,"B",A1BFVOL,0)) I A1BFDEV="" S A1BFERR(30)="" Q
 I '$D(^A1BF(11601,1,6,A1BFDEV,0)) S A1BFERR(30)="" Q
 I $P(^A1BF(11601,1,6,A1BFDEV,0),U,3)=1 S A1BFERR(37)=A1BFVOL Q
 S A1BFDEV=$P(^A1BF(11601,1,6,A1BFDEV,0),U,2) I A1BFDEV="" S A1BFERR(30)="" Q
 ;S A1BFDEV=$P(^A1BF(11601,1,0),U,5) I A1BFDEV="" S A1BFERR(30)="" Q
 I '$D(^%ZIS(1,A1BFDEV,0)) S A1BFERR(31)=A1BFDEV  Q
 I $P(^%ZIS(1,A1BFDEV,0),U,2)="" S A1BFERR(32)=A1BFDEV
 I '$D(^%ZIS(1,A1BFDEV,"TYPE")) S A1BFERR(33)=A1BFDEV  ;Type defined
 I '$D(^%ZIS(1,A1BFDEV,"SUBTYPE")) S A1BFERR(34)=A1BFDEV  ;Stype defined
 S A1BFX=$P(^%ZIS(1,A1BFDEV,"SUBTYPE"),U,1) I A1BFX="" S A1BFERR(35)=A1BFDEV Q
 I '$D(^%ZIS(2,A1BFX,0)) S A1BFERR(36)=A1BFDEV Q
 S A1BFDEV=$P(^%ZIS(1,A1BFDEV,0),U,1)
 Q
EXIT ;
 K A1BFMBN,A1BFMBNO
 Q
