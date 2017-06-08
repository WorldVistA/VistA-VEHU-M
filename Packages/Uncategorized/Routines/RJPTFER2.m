RJPTFER2 ;RJ WILM DE -MISSING DATA IN PATIENT FILE; 12-12-85
 ;;4.0
 S DR="",RJPTF=$P(^DGPT(I,0),"^",1),RJPAT=^DPT(RJPTF,0),RJSTATE=""
 S:$D(^DPT(RJPTF,.11)) RJSTATE=^DPT(RJPTF,.11) S:$P(RJPAT,"^",9)="" DR=";"_.09 S:$P(RJPAT,"^",5)="" DR=DR_";"_.05 S:$P(RJPAT,"^",2)="" DR=DR_";"_.02 S:$P(RJPAT,"^",3)="" DR=DR_";"_.03 S:$P(RJPAT,"^",6)="" DR=DR_";"_.06
 S:$P(RJSTATE,"^",5)="" DR=DR_";"_.115 S:$P(RJSTATE,"^",7)="" DR=DR_";"_.117 S:$P(RJSTATE,"^",6)="" DR=DR_";"_.116
 I '$D(^DPT(RJPTF,.52)) S DR=DR_";"_.525_";"_.526
 E  S Y=$P(^DPT(RJPTF,.52),"^",5) D P
 I '$D(^DPT(RJPTF,.321)) S DR=DR_";"_.32101_";"_.32102_";"_.32103_";"_.3212
 E  S Y=$P(^DGPT(I,101),"^",4) D A,I
 I '$D(^DPT(RJPTF,57)) S DR=DR_";"_57.4
 E  S:$P(^DPT(RJPTF,57),"^",4)="" DR=DR_";"_57.4
 S:$E(DR,1)=";" DR=$E(DR,2,1000) K RJPTF,RJSTATE,RJPAT Q
A Q:Y'=6  S L=$P(^DPT(RJPTF,.321),"^",1) S:L="" DR=DR_";"_.32101 Q:L="N"  S:$P(^DPT(RJPTF,.321),"^",2)="" DR=DR_";"_.32102 Q
I Q:Y<2!(Y>7)  S L=$P(^DPT(RJPTF,.321),"^",3) S:L="" DR=DR_";"_.32103 Q:L="N"!(L="U")  S:$P(^DPT(RJPTF,.321),"^",12)="" DR=DR_";"_.3212 Q
P I Y="" S DR=DR_";"_.525_";"_.526 Q
 Q:Y="N"!(Y="U")  I $P(^DPT(RJPTF,.52),"^",6)="" S DR=DR_";"_.526
 Q
