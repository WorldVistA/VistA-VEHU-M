RJPTFXMT ;RJ WILM DE; TRANSMIT CODE SHEETS FOR XM MESSAGE OVER MCTS; OCT 21 86
 ;;4.0
 S:'$D(DTIME) DTIME=300 K IOP D ^%ZIS Q:POP  S A=""
1 U IO(0) S DIC(0)="QEAM",DIC="^XMB(3.9," W ! D ^DIC G:Y<1 X S DA=+Y
 U IO X ^%ZOSF("ZMAXBUF"),^%ZOSF("EOFF") W *10,*13 R I:1 U IO(0) H 2 F I=1:1 Q:'$D(^XMB(3.9,DA,2,I,0))  S L=^(0) U IO(0) W !,"Line ",I D TX
 S ^DGPT("PU")=^DGPT("PU")+I G 1
X X ^%ZOSF("EON"),^%ZIS("C") K DIC,DA,A,L,I,K,P,Y Q
TX U IO W *13 F P=1:1:80 W $E(L,P) D P
 R !,*XXX:0 U IO(0) Q
P F K=1:1:50
 Q
