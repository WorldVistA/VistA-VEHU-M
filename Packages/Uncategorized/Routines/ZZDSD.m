ZZDSD ;DSD 9/6/94 [ 09/06/94  2:12 PM ]
 S ZXM=$P(^IBE(350.9,1,6),U,11)
 S XMTEXT="THE NUMBER OF WEEKLY ADMISSIONS IS/ARE "_ZXM
 S XMB="XQSERVER" D ^XMB
 Q
 
