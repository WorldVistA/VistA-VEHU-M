RJPTFER1 ;RJ WILM DE -MISSING DATA IN PTF FILE; 12-12-85
 ;;4.0
 S DR="",RJPTF=^DGPT(I,0) S:$P(RJPTF,"^",2)="" DR=";2" S:$P(RJPTF,"^",3)="" DR=DR_";3" S:$P(RJPTF,"^",10)="" DR=DR_";10" S:'$D(^DGPT(I,101)) ^DGPT(I,101)="" S:$P(^DGPT(I,101),"^",1)="" DR=DR_";20" S:$P(^DGPT(I,101),"^",4)="" DR=DR_";23"
 S:'$D(^DGPT(I,70)) ^DGPT(I,70)="" S Z=^DGPT(I,70)
 S:$P(Z,"^",1)="" DR=DR_";70" S:$P(Z,"^",2)="" DR=DR_";71" S:$P(Z,"^",3)="" DR=DR_";72" I $P(Z,"^",3)'=4&($P(Z,"^",3)'=7)&($P(Z,"^",3)'=6) S:$P(Z,"^",4)="" DR=DR_";73" S:$P(Z,"^",5)="" DR=DR_";74" S:$P(Z,"^",6)="" DR=DR_";75"
 S:'$D(^DGPT(I,"M",1)) DR=DR_";50"
 S:$P(Z,"^",9)="" DR=DR_";78" S:$P(Z,"^",10)="" DR=DR_";79"
 K Z,RJPTF S:$E(DR,1)=";" DR=$E(DR,2,200) Q
