RJTENG ; ;[ 08/29/96  11:55 AM ]
 F I=0:0 S F=$O(^ENG(6914,"B",F)) W !,F Q:F=""  D CHK
 Q
CHK I $P(^ENG(6914,F,2),"^",11) W !,^ENG(6914,F,2)
 Q
CHG ;
 I $D($P(^ENG(6914,F,2),"^",11))["AR7" S L=$ZR
