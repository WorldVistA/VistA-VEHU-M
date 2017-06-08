PRSIPST1 ;HISC/REL-PAID 4.0 Conversion ;6/14/95  13:18
 ;;4.0;PAID;;Sep 21, 1995
 W !!,"Converting data for Family Leave"
 S PPI=$O(^PRST(458,"B","95-01",0)) Q:PPI<1
 F PPI=PPI-1:0 S PPI=$O(^PRST(458,PPI)) Q:PPI<1  F DFN=0:0 S DFN=$O(^PRST(458,PPI,"E",DFN)) Q:DFN<1  F DAY=1:1:14 D
 .S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,2))
 .I Z'["SL",Z'["AA" Q
 .S C=0 F K=1:4:25 Q:$P(Z,"^",K+2)=""  I $P(Z,"^",K+3)>14 S C=$P(Z,"^",K+3) S $P(Z,"^",K+3)=1,$P(Z,"^",K+2)=$S(C<17:"CB",C=17:"AD",1:"DL")
 .I C S ^PRST(458,PPI,"E",DFN,"D",DAY,2)=Z
 .Q
 K PPI,DFN,DAY,Z,C,K
 Q
