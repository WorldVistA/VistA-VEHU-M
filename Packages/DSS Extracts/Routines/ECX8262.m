ECX8262 ; COMPILED XREF FOR FILE #727.826 ; 01/21/16
 ; 
 S DIKZK=1
 S DIKZ(0)=$G(^ECX(727.826,DA,0))
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^ECX(727.826,"B",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,1)
 I X'="" S ^ECX(727.826,"AINV",-X,DA)=""
 S X=$P($G(DIKZ(0)),U,3)
 I X'="" S ^ECX(727.826,"AC",$E(X,1,30),DA)=""
 S X=$P($G(DIKZ(0)),U,9)
 I X'="" N ND,ND1 S ND=$G(^ECX(727.826,DA,0)) S ND1=$G(^ECX(727.826,DA,1)) S ^ECX(727.826,"AG",$E(X,1,30),$P(ND1,"^",4),$P(ND,"^",15),DA)=""
 S X=$P($G(DIKZ(0)),U,15)
 I X'="" N ND,ND1 S ND=$G(^ECX(727.826,DA,0)) S ND1=$G(^ECX(727.826,DA,1)) S ^ECX(727.826,"AG",$P(ND,"^",9),$P(ND1,"^",4),$E(X,1,30),DA)=""
 S DIKZ(1)=$G(^ECX(727.826,DA,1))
 S X=$P($G(DIKZ(1)),U,4)
 I X'="" N ND S ND=$G(^ECX(727.826,DA,0)) S ^ECX(727.826,"AG",$P(ND,"^",9),$E(X,1,30),$P(ND,"^",15),DA)=""
END Q
