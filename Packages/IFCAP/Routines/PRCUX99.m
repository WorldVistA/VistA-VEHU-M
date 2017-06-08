PRCUX99 ;PLT/WISC move data from file 20 to 200 new person file ; 05/11/93  9:48 AM
V ;;4.0;IFCAP;;9/23/93
CVT(X) ;CONVERT RANGE OF RECORDS - X?.N1"-".N
 N BEGIN,END,DA
 S BEGIN=$P(X,"-"),END=$P(X,"-",2)
 S DA=BEGIN-1
 F  S DA=$O(^PRSN(20,DA)) Q:'DA  Q:DA>END  I $D(^(DA,0)) L +^PRSN(20,DA) D ONE(DA) W:DA#1000=0 "." L -^PRSN(20,DA)
 QUIT
ONE(DA) ;ENTRY POINT TO MOVE DATA FOR ONE RECORD
 N A,PRCRI
 S A=$G(^DIC(16,DA,"A3")),PRCRI=$P(A,"^",1) I PRCRI+0>0 D
 . ;move supply employee data to dic(200)
 . S A=$G(^PRSN(20,DA,400)) ;W !,DA,"  -  ",PRCRI,"    SE:",A
 . I $P(A,"^",1)]"" L +^VA(200,PRCRI,400) S $P(^VA(200,PRCRI,400),"^",1)=$P(A,"^",1) L -^VA(200,PRCRI,400)
 . ;move phone in dic(20) to commercial phone in dic(200)
 . S A=$G(^PRSN(20,DA,"PHONE")) ;W "   PHONE:",A
 . I $P(A,"^",1)]"" L +^VA(200,PRCRI,.13) S $P(^VA(200,PRCRI,.13),"^",5)=$P(A,"^",1) L -^VA(200,PRCRI,.13)
 QUIT
