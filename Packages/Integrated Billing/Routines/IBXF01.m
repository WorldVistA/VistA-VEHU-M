IBXF01 ; COMPILED XREF FOR FILE #357 ; 09/22/94
 ; 
 S DIKZK=2
 S DIKZ(0)=$S($D(^IBE(357,DA,0))#2:^(0),1:"")
 S X=$P(DIKZ(0),U,1)
 I X'="" K ^IBE(357,"B",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,4)
 I X'="" K ^IBE(357,"D",$E(X,1,30),DA)
 S X=$P(DIKZ(0),U,7)
 I X'="" K ^IBE(357,"C",$E(X,1,30),DA)
END Q
