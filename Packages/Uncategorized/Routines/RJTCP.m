RJTCP ;
 S A="",B="",C=0
 F I=0:0 S A=$O(^PRCA(433,"B",A)) Q:A=""  D 1
 W !,"total # of records affected "_C
 Q
1 ;
 F I=0:0 S B=$O(^PRCA(433,"B",A,B)) Q:B=""  D 2
 Q
2 ;
 I $D(^PRCA(433,B,7,1,0)),^(0)["DUE TO CO-PAY" S C=C+1
 Q
