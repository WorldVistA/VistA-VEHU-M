IBYZ20X1 ;ALB/CPM - X-REF CLAIMS IN FILE #399 (CON'T) ; 16-APR-97
 ;;FOR USE ONLY AT VAMC POPLAR BLUFF (#647)
 ; 
 ;
XREF(DA) ; Re-cross reference an entry in file #399 (no triggers)
 ;  Input:   DA  --  pointer to an entry in file #399
 ;
 Q:'$G(DA)
 ;
 ; - first, update counter
 S IBCTX=IBCTX+1
 ;
 ;
 ; - bill number (.01)
 S DIKZ(0)=$G(^DGCR(399,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^DGCR(399,"B",$E(X,1,30),DA)=""
 ;
 ; - patient (.02)
 S X=$P(DIKZ(0),U,2)
 I X'="" S ^DGCR(399,"C",$E(X,1,30),DA)=""
 ;
 ; - event date (.03)
 S X=$P(DIKZ(0),U,3)
 I X'="" S ^DGCR(399,"D",$E(X,1,30),DA)=""
 I X'="" S IBN=$P(^DGCR(399,DA,0),"^",2) S:$D(IBN) ^DGCR(399,"APDT",IBN,DA,9999999-X)="" K IBN
 I X'="" S ^DGCR(399,"ABNDT",DA,9999999-X)=""
 ;
 ; - bill classification (.05)
 S X=$P(DIKZ(0),U,5)
 I X'="" S ^DGCR(399,"ABT",$E(X,1,30),DA)=""
 ;
 ; - rate type (.07)
 S X=$P(DIKZ(0),U,7)
 I X'="" S ^DGCR(399,"AD",$E(X,1,30),DA)=""
 ;
 ; - ptf entry (.08)
 S X=$P(DIKZ(0),U,8)
 I X'="" S ^DGCR(399,"APTF",$E(X,1,30),DA)=""
 ;
 ; - status (.13)
 S X=$P(DIKZ(0),U,13)
 I X'="" I X>0,X<3,$P(^DGCR(399,DA,0),U,2) S ^DGCR(399,"AOP",$P(^(0),U,2),DA)=""
 I X'="" I +X=3 S ^DGCR(399,"AST",+X,DA)=""
 ;
 ; - primary bill (.17)
 S X=$P(DIKZ(0),U,17)
 I X'="" S ^DGCR(399,"AC",$E(X,1,30),DA)=""
 ;
 ; - date entered (1)
 S DIKZ("S")=$G(^DGCR(399,DA,"S"))
 S X=$P(DIKZ("S"),U,1)
 I X'="" S ^DGCR(399,"APD",$E(X,1,30),DA)=""
 ;
 ; - authorization date (10)
 S X=$P(DIKZ("S"),U,10)
 I X'="" S ^DGCR(399,"APD3",$E(X,1,30),DA)=""
 ;
 ; - date first printed (12)
 S X=$P(DIKZ("S"),U,12)
 I X'="" S ^DGCR(399,"AP",$E(X,1,30),DA)=""
 ;
 ; - primary insurance carrier (101)
 S DIKZ("M")=$G(^DGCR(399,DA,"M"))
 S X=$P(DIKZ("M"),U,1)
 I X'="" S:$P(^DGCR(399,DA,0),"^",2) ^DGCR(399,"AE",$P(^(0),U,2),X,DA)=""
 ;
 ; - primary insurance policy (112)
 S X=$P(DIKZ("M"),U,12)
 I X'="" D IX^IBCNS2(DA,"I1")
 ;
 ; - secondary insurance policy (113)
 S X=$P(DIKZ("M"),U,13)
 I X'="" D IX^IBCNS2(DA,"I2")
 ;
 ; - tertiary insurance policy (114)
 S X=$P(DIKZ("M"),U,14)
 I X'="" D IX^IBCNS2(DA,"I3")
 ;
 ; - statement covers from (151)
 S DIKZ("U")=$G(^DGCR(399,DA,"U"))
 S X=$P(DIKZ("U"),U,1)
 I X'="" S:$P(^DGCR(399,DA,0),"^",2) ^DGCR(399,"APDS",$P(^(0),U,2),-X,DA)=""
 ;
 ;
 ; - cover the multiples
 ; 
 S DA(1)=DA
 ;
 ;
 ; - procedures (304)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"CP",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"CP",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"CP","B",$E(X,1,30),DA)=""
 .I X'="" I $P(X,";",2)="ICPT(",$D(^DGCR(399,DA(1),"CP",DA,0)),$P(^(0),"^",2) S ^DGCR(399,"ASD",-$P(^(0),"^",2),+X,DA(1),DA)=""
 .S X=$P(DIKZ(0),U,2)
 .I X'="" I $D(^DGCR(399,DA(1),"CP",DA,0)),+^(0),$P($P(^(0),"^",1),";",2)="ICPT(" S ^DGCR(399,"ASD",-X,+^(0),DA(1),DA)=""
 .S X=$P(DIKZ(0),U,4)
 .I X'="" S ^DGCR(399,DA(1),"CP","D",$E(X,1,30),DA)=""
 .S X=$P(DIKZ(0),U,5)
 .I X'="" S ^DGCR(399,DA(1),"CP","ASC",$E(X,1,30),DA)=""
 ;
 ; - occurrence codes (41)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"OC",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"OC",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"OC","B",$E(X,1,30),DA)=""
 ; 
 ; - revenue codes (42)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"RC",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"RC",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"RC","B",$E(X,1,30),DA)=""
 .S X=$P(DIKZ(0),U,1)
 .I X'="" I $P(^DGCR(399,DA(1),"RC",DA,0),U,5) S ^DGCR(399,DA(1),"RC","ABS",$P(^DGCR(399,DA(1),"RC",DA,0),U,5),$E(X,1,30),DA)=""
 .S X=$P(DIKZ(0),U,5)
 .I X'="" S ^DGCR(399,DA(1),"RC","ABS",$E(X,1,30),+^DGCR(399,DA(1),"RC",DA,0),DA)=""
 .S X=$P(DIKZ(0),U,6)
 .I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC1",$E(X,1,30),DA(1),DA)=""
 .S X=$P(DIKZ(0),U,6)
 .I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC2",DA(1),$E(X,1,30),DA)=""
 .S X=$P(DIKZ(0),U,7)
 .I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC1",$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA(1),DA)=""
 .S X=$P(DIKZ(0),U,7)
 .I X'="" I $$RC^IBEFUNC1(DA(1),DA) S ^DGCR(399,"ASC2",DA(1),$P(^DGCR(399,DA(1),"RC",DA,0),U,6),DA)=""
 ; 
 ; - op visit dates (43)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"OP",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"OP",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,"AOPV",$P(^DGCR(399,DA(1),0),U,2),$E(X,1,30),DA(1))=""
 ;
 ; - initial disapproval reasons (44)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"D1",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"D1",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"D1","B",$E(X,1,30),DA)=""
 ;
 ; - secondary disapproval reasons (45)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"D2",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"D2",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"D2","B",$E(X,1,30),DA)=""
 ;
 ; - returned log (46)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"R",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"R",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"R","B",$E(X,1,30),DA)=""
 .S X=$P(DIKZ(0),U,4)
 .I X'="" S ^DGCR(399,DA(1),"R","AC",$E(X,1,30),DA)=""
 ;
 ; - value codes (47)
 S DA=0 F  S DA=$O(^DGCR(399,DA(1),"CV",DA)) Q:'DA  D
 .S DIKZ(0)=$G(^DGCR(399,DA(1),"CV",DA,0))
 .S X=$P(DIKZ(0),U,1)
 .I X'="" S ^DGCR(399,DA(1),"CV","B",$E(X,1,30),DA)=""
 ;
 ;
 K DA,DIKZ,X
 Q
