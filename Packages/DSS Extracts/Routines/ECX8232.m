ECX8232 ; COMPILED XREF FOR FILE #727.823 ; 01/04/05
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^ECX(727.823,DA,0))
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^ECX(727.823,"AC",$E(X,1,30),DA)=""
END Q
