A1CGCMP1 ;JSH/TROY;10/23/87;GLOBAL/PACKAGE COMPARE
 ;CONTINUED FROM A1CGCMP
 ;
EN S SUB1="ERRF" D NOW^%DTC S Y=% U IO W @IOF,?(IOM/2-12),"File Entries Compare Report",!!?(IOM/2-10),"Began: " X ^DD("DD") W Y W !!
 K GLO F I=0:0 S I=$N(^UTILITY("A1CGCMP",SUB,I)) Q:I'>0  S GLOB=$E(^(I,0),2,999),GLEN=$L(GLOB) D LOOP
 U IO W:$Y>(IOSL-4) @IOF W !!?(IOM/2-15),"Comparision finished at " D NOW^%DTC S Y=% X ^DD("DD") W Y,!! Q
LOOP D NOW^%DTC S Y=% X ^DD("DD") W:$Y>(IOSL-4) @IOF W !!,"Beginning ",^UTILITY("A1CGCMP",SUB,I)," file stored in ",GLOB," at ",$P(Y,"@",2)
 F ZZZ=0:0 S ZZZ=$N(UCIVOL(ZZZ)) Q:ZZZ'>0  D GLOB S GLO(ZZZ)=GLREF,DATA(ZZZ)=0
 F ZZZ=0:0 S ZZZ=$N(GLO(ZZZ)) Q:ZZZ'>0  I '$D(@GLO(ZZZ)) W:$Y>(IOSL-4) @IOF W !?10,GLO(ZZZ),"  does not exist" S DATA(ZZZ)=1,^UTILITY("A1CGCMP",SUB,SUB1,GLO(ZZZ),ZZZ)="Undefined"
 ;
LP1 F ZZZ=0:0 S ZZZ=$N(GLO(ZZZ)) Q:ZZZ'>0  S GLO(0)=GLO(ZZZ) D LP2
 Q
LP2 W " ." I '$D(@GLO(0)) Q
 S L=GLO(0) F M=0:0 S (L,N)=$ZO(@L) S:L["]" N=$P(L,"]",2,999),N="^"_N S:N'["," N=$P(N,"(",1)_"(" S N=$P(N,",") S:$E(GLOB,GLEN)="(" N=$P(N,"(")_"(" Q:N'=("^"_GLOB)  S LL=$P(L,GLOB,2,999) S:$E(LL,1)="," LL=$E(LL,2,999) S N=$P(LL,",") Q:N?1"""".E  D LP3
 Q
LP3 F ZZ=0:0 S ZZ=$N(GLO(ZZ)) Q:ZZ'>0  I ZZ'=ZZZ,'DATA(ZZ) D CHECK
 Q
CHECK S GLO=$P(GLO(ZZ),"]",1)_"]",LZ=$E(L,2,999) S:LZ["]" LZ=$P(LZ,"]",2,999) S GLO=GLO_LZ
 I ($D(@GLO)#10)=0 S ^UTILITY("A1CGCMP",SUB,SUB1,I,+N,$P(GLO,"]",2,999),.1)="" Q
 S A=$P(GLO,"]"),A=$P(A,"[",2),B=$P(GLO(0),"]"),B=$P(B,"[",2)
 I @GLO'=@L S:'$D(^UTILITY("A1CGCMP",SUB,SUB1,I,+N,$P(GLO,"]",2,999),.1)) ^UTILITY("A1CGCMP",SUB,SUB1,I,+N,$P(GLO,"]",2,999),.1)="" Q
 Q
GLOB S:$E(GLOB,$L(GLOB))="," GLOB=$E(GLOB,1,$L(GLOB)-1) S GLREF="^["_""""_$P(UCIVOL(ZZZ),",",1)_""""_","_""""_$P(UCIVOL(ZZZ),",",2)_""""_"]"_GLOB
 S:$E(GLREF,$L(GLREF))="(" GLREF=$E(GLREF,1,$L(GLREF)-1) S:GLREF["(" GLREF=GLREF_")"
 Q
BADUCI W !!,*7,"'",U,",",V,"'"," is a non-existent uci...please re-enter the list!",!! K UCIVOL G EN
SUB1OR W !!,$ZE Q
UCI W !!,"Now I need you to list the ucis and volume sets you want me to check, using the form UCI,VOL",!! K UCIVOL
 F I=1:1 R !,"UCI,VOL: ",X Q:"^"[X  S UCIVOL(I)=X
 Q:'$D(UCIVOL)  S $ZT="BADUCI" F I=0:0 S I=$N(UCIVOL(I)) Q:I'>0  S UC=$P(UCIVOL(I),","),V=$P(UCIVOL(I),",",2) S X=$D(^[UC,V]%ZTSK)
 S $ZT="SUB1OR"
