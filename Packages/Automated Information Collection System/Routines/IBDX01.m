IBDX01 ; COMPILED XREF FOR FILE #357 ; 08/27/14
 ; 
 S DIKZK=2
 S DIKZ(0)=$G(^IBE(357,DA,0))
 S X=$P($G(DIKZ(0)),U,4)
 I X'="" K ^IBE(357,"D",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,7)
 I X'="" K ^IBE(357,"C",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,13)
 I X'="" K ^IBE(357,"ADEF",$E(X,1,30),DA)
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" K ^IBE(357,"B",$E(X,1,30),DA)
END G ^IBDX02
