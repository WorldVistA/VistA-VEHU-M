AJK1UBM ;580/MRL - Collections, Menu Options; 07-Nov-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;Menu options associated with collections.  Entry points for options
 ;are all marked "--*" prior to explanation of option.
 ;
CAT ; --* update Accounts Receivable Category
 ;     used to update the "collect" field which tells the processor
 ;     which categories are collectable
 ;
 D DIC(430.2,"Flag which AR CATEGORY?  ",580000.01) Q
 ;
TRANS ; --* update Accounts Receivable Trans. Type
 ;     used to update the "collections status" field which tells the
 ;     process which transaction types are reported, and how, to
 ;     the collection agency once the status is updated.
 ;
 D DIC(430.3,"Update which AR TRANSACTION TYPE?  ",580000.01) Q
 ;
RATE ; --* update Rate Type Flag
 ;     used to determine, based on BILL/CLAIM rate type assigned,
 ;     which rate types are to be included in the process.
 ;
 D DIC(399.3,"Flag which RATE TYPE for Collection?  ",580950.1) Q
 ;
F36 ; --* update Insurance Flag
 ;     Restrict insurance payer to dollar amount or completely.
 ;
 D DIC(36,"Select INSURANCE COMPANY to Restrict?  ",580950.01) Q
 ;
DIC(F,A,DR) ; --- call DIC and return Y
 ;
 Q:'$$KEY^AJK1UBCP
 K DIC
 S DIC=$G(^DIC(+F,0,"GL"))
 S DIC("A")=A,DIC(0)="AEQMZ"
 ;
ASK ; --- reask
 ;
 D ^DIC
 I Y'>0 K DA,DIC,DIE Q
 S DIE=DIC,DA=+Y D ^DIE
 W ! G ASK
 ;
NEW ; --* update New Transaction Data String
 ;
 D STR^AJK1UBS(1) Q
 ;
CHG ; --* update Status Change Data String
 ;
 D STR^AJK1UBS(2) Q
 ;
CODE ; --* update Transmission Status Code file
 ;
 D DIC(580950.8,"Enter/Edit STATUS CODE: ",".01:.04") Q
 ;
RTS ; --* retransmit a single record
 ;
 S DIR(0)="SAM^N:NEW RECORD;S:STATUS CHANGE"
 S DIR("A")="Retransmit which type of Record? "
 S DIR("?")="SELECT TYPE OF COLLECTION RECORD TO RETRANSMIT!"
 S DIR("?",1)="Choose from NEW or STATUS CHANGE collection records."
 D ^DIR G END:$D(DIRUT)
 S TYPE="AJK1UB"_$S(X="N":"",1:"S")_"("
 ;
 ; ==> choose record
 ;
 S DIC="^"_TYPE,DIC(0)="AEQMZ" D ^DIC G END:Y'>0 S AJKREC=+Y
 ;
 ; ==> process retransmital
 ;
 S DEL=$O(^DIZ(580950.4,"B",(+Y_";"_TYPE),0))
 I DEL D  G END
DEL .W !!,"Record is already set up for Retransmission.  Want to DELETE"
 .S %=2 D YN^DICN I %,%'=1 Q
 .I % S X=$$DEL^AJK1UBTR(DEL) D  Q
 ..W !!,$S('X:"Record Deleted",1:"Unable to Delete")
 ..W " from Retransmission file."
 .W !?4,"Answer YES if you want to remove this record from the"
 .W !?4,"Retransmission file, otherwise respond NO, to retain."
 .G DEL
 S X=$$RT^AJK1UBTR($S(TYPE["S":0,1:1),AJKREC)
 W !!,"Record ",$S(X:"established",1:"already exists")
 W " in Retransmission file."
 ;
END ; --- kill variables and quit
 ;
 K DEL,AJKREC,X,Y,DIC Q
