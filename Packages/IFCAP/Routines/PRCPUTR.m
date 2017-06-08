PRCPUTR ;WISC/RFJ-transaction history file 445.2 sets ;7 Jul 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
ADDTRAN(V1,V2,V3,V4,PRCPDATA) ;     |-> add transaction entry to file 445.2
 ;     |-> v1 = inventory point
 ;     |-> v2 = item da
 ;     |-> v3 = type of transaction
 ;     |-> v4 = order number
 ;     |-> duz = user number
 ;prcpdata nodes:
 ;     |-> date)        = date of transaction (posted or issued, etc)
 ;     |->                (optional) if not set it uses current date
 ;     |-> qty)         = quantity of transaction
 ;     |-> invval)      = inventory value
 ;     |-> selval)      = sales value
 ;     |-> avgunit)     = average unit cost
 ;     |-> selunit)     = selling unit cost
 ;     |-> pkg)         = unit per issue / units
 ;     |->                (optional) set to current if not passed
 ;     |-> ref)         = reference number
 ;     |-> 2237po)      = 2237 or purchase order number
 ;     |-> issue)       = issue/nonissue
 ;     |->                (optional) set to I for issuable, N for non
 ;     |-> otherpt)     = other inventory point
 ;     |-> reason)      = n:reason (if n=1 ask reason)
 ;
 ;     |-> returns variable y = da of entry added
 S Y=0
 ;
 ;     |-> inventory point is not keeping a detailed transaction reg.
 I $P($G(^PRCP(445,+V1,0)),"^",6)'="Y" Q
 ;
 N %,%DT,D,D0,DA,DI,DIC,DIE,DLAYGO,DQ,DR,INVPT,ITEMDA,ORDERNO,NOW,PRCPDR,PRCPREAS,TRANDA,TRANTYPE,X
 S INVPT=V1,ITEMDA=V2,TRANTYPE=V3,ORDERNO=V4 D NOW^%DTC S NOW=%
 ;
 ;     |-> set up all variables not defined
 I '$G(PRCPDATA("DATE")) S PRCPDATA("DATE")=$E(NOW,1,7)
 I '$D(PRCPDATA("PKG")) S PRCPDATA("PKG")=$$UNIT^PRCPUX1(INVPT,ITEMDA,"/")
 F %="QTY","INVVAL","SELVAL" I '$G(PRCPDATA(%)) S PRCPDATA(%)=0
 S %=$G(^PRCP(445,INVPT,1,ITEMDA,0)) S:'$G(PRCPDATA("AVGUNIT")) PRCPDATA("AVGUNIT")=+$P(%,"^",22) S:'$G(PRCPDATA("SELUNIT")) PRCPDATA("SELUNIT")=+$P(%,"^",15)
 F %="REF","2237PO","ISSUE","OTHERPT","REASON" I '$D(PRCPDATA(%)) S PRCPDATA(%)=""
 ;
 ;     |-> add new transaction history entry
 S DIC(0)="L",DLAYGO=445.2,DIC="^PRCP(445.2,",X=INVPT,PRCPPRIV=1 D FILE^DICN K PRCPPRIV I Y<1 S Y=0 Q
 S (TRANDA,DA)=+Y,DIE="^PRCP(445.2,"
 S DR="1///"_TRANTYPE_ORDERNO_";2///"_PRCPDATA("DATE")_";2.5///"_NOW_";3///"_TRANTYPE_";4////"_ITEMDA_";5////"_PRCPDATA("PKG")_";6////"_PRCPDATA("QTY")_";7////"_(+PRCPDATA("AVGUNIT"))_";8////"_(+PRCPDATA("SELUNIT"))_";"
 S DR=DR_"6.1////"_(+PRCPDATA("INVVAL"))_";6.2////"_(+PRCPDATA("SELVAL"))_";8.5////"_DUZ_";10////"_PRCPDATA("ISSUE")_";13////"_PRCPDATA("REF")_";14////"_PRCPDATA("OTHERPT")_";410////"_PRCPDATA("2237PO")_";"
 ;     |-> additional reason text (for asking in second call to die)
 S PRCPDR="9.5//"_$S($P(PRCPDATA("REASON"),":"):"",1:"/")_"^S X=PRCPREAS",PRCPREAS=$E($P(PRCPDATA("REASON"),":",2,99),1,80)
 L +^PRCP(445.2,TRANDA) D ^DIE
 S DR=PRCPDR D ^DIE L -^PRCP(445.2,TRANDA)
 S Y=DA
 Q
 ;
 ;
ORDERNO(V1) ;     |-> get next order number for inventory point
 ;     |-> returns orderno
 S Y=0
 I $P($G(^PRCP(445,+V1,0)),"^",6)="Y" L +^PRCP(445.2,"ANXT",V1) S Y=$G(^PRCP(445.2,"ANXT",V1))+1 S:Y>9999999 Y=1 S ^(V1)=Y L -^PRCP(445.2,"ANXT",V1)
 Q Y
