RJPTFXM ;RJ WILM DE; PUT CODE SHEET IN MAIL MESSAGE; OCT 21 86
 ;;4.0
 I DUZ<.5 W !!,"You must be a user before I can save the coded records in a Mailman Message." Q
 D NOW^%DTC S RJXM=$P(^XMB(3.9,0),"^",3)+1,^XMB(3.9,0)=$P(^(0),"^",1,2)_"^"_RJXM_"^"_($P(^(0),"^",4)+1),RJPTFSUB=RJXM_" PTF CARDS "_$E(DT,4,7)_$E(DT,2,3),^XMB(3.9,RJXM,0)=RJPTFSUB_"^"_DUZ_"^"_%
 S ^XMB(3.9,RJXM,1,0)="^3.91LA^1^1",^XMB(3.9,RJXM,1,1,0)=DUZ,^XMB(3.9,RJXM,1,"C",DUZ,1)="",^XMB(3.7,DUZ,2,1,1,RJXM,0)=RJXM,^XMB(3.7,DUZ,"N",RJXM,1)=""
 S Z=$O(^XMB(3.8,"B","RJPTF TX",0)) I Z'="",Z?.N S Z10=0 F Z11=2:1 S Z10=$O(^XMB(3.8,Z,1,Z10)) Q:Z10'?.N!(Z10="")  S Z12=$P(^XMB(3.8,Z,1,Z10,0),"^",1) D S
 W !!!,"Coded Records saved in Mailman Message Subject: ",RJPTFSUB K RJPTFSUB,%,%H,%I,Z,Z10,Z11 Q
S S ^XMB(3.9,RJXM,1,Z11,0)=Z12,^XMB(3.9,RJXM,1,"C",Z12,Z11)="",^XMB(3.7,Z12,2,1,1,RJXM,0)=RJXM Q
