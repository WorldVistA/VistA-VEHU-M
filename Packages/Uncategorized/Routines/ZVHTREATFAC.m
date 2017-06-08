ZVHTREATFAC ;
 
START ;
 n tempIEN,tempDGCN,FACNO,job,UP,LO,system
 ;
 s job = $J
 SET UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 SET LO="abcdefghijklmnopqrstuvwxyz"
 ;
 ;s system = $ZU(110)
 ;s system = $TR(system,UP,LO)
 ;
 s tempDGCN=$p(^DGCN(391.91,0),"^",3)
 i tempDGCN'?1N.N w !,"Problem!" b    
 ; 
SELECT 
 w !,"Choose (I)ndividual Patient or (L)oop: "
 R X
 i X["^" q
 i X="" q
 s X=$TR(X,LO,UP)
 i $E(X)="I" d PT Q
 i $e(X)="L" d LOOP Q
 Q
 ;
LOOP
 ;
 S DIC="^DIC(4,",DIC(0)="QEAL" D ^DIC
 I Y=-1 K DIC Q  
 s FACNO=$p(Y,"^",1)
 i FACNO'?1N.N Q
 F tempIEN=100829:1:101829 D  
 . i '$D(^DPT(tempIEN)) Q
 . d ADDTREAT
 s $p(^DGCN(391.91,0),"^",3)=tempDGCN
 s $p(^DGCN(391.91,0),"^",4)=tempDGCN
 Q
 ;
PT ;Patient Select
 W ! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC  ; Patient Select utility stores results in Y array
 s tempIEN = $p(Y,"^",1) d  
 .i '$d(^DPT(tempIEN)) w !,"Problem!" b  
 .;f FACNO=200,660,756  d  
 .S DIC="^DIC(4,",DIC(0)="QEAL" D ^DIC
 .I Y=-1 K DIC Q  
 .s FACNO=$p(Y,"^",1) d  
 ..d ADDTREAT
 ;
 s $p(^DGCN(391.91,0),"^",3)=tempDGCN
 s $p(^DGCN(391.91,0),"^",4)=tempDGCN
 ;w !,tempDGCN
 Q
 
ADDTREAT ;
 ;i $D(^DGCN(391.91,"B",tempIEN)) Q
 s tempDGCN=tempDGCN+1
 s ^DGCN(391.91,tempDGCN,0)=tempIEN_"^"_FACNO_"^3050229"
 s ^DGCN(391.91,"AINST",FACNO,tempIEN,tempDGCN)=""
 s ^DGCN(391.91,"APAT",tempIEN,FACNO,tempDGCN)=""
 S ^DGCN(391.91,"B",tempIEN,tempDGCN)=""
 s ^DGCN(391.91,"C",FACNO,tempDGCN)=""
 q
