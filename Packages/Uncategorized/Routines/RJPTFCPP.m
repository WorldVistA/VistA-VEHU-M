RJPTFCPP ;RJ WILM DE -CONTROLS CREATING PTF CODE SHEETS; 12-12-85
 ;;4.0
 D ^RJPTFXM G:DUZ<.5 E1 S:'$D(^DGPT("PU")) ^DGPT("PU")=0 S:'$D(DTIME) DTIME=300 S RJ(2)="",RJ(1)=0
 F RJPTFA=1:1 S I=$P(A,",",RJPTFA) G:I="" E D X
X W !,"PTF NUMBER ",I," being coded." D KILL,L
 Q
E I RJERL'="" W !,"PATIENTS CARDS COULD NOT BE PUNCHED, MISSING DATA!",! F I=1:1:79 W "="
 F I=2:1 Q:$P(RJERL,"^",I)=""  W !,$P(RJERL,"^",I),"  ",$P(^DPT($P(^DGPT($P(RJERL,"^",I),0),"^",1),0),"^",1)
 W !,"There was a total of ",RJ(1)," cards coded." S ^DGPT("PU")=^DGPT("PU")+RJ(1),^XMB(3.9,RJXM,2,0)="^^"_RJ(1)_"^"_RJ(1)_"^"_DT_"^^"
E1 K RJ,RJPAT,RJCON,RJPTFA,I,A,RJERL,C501,L,RJN101,RJN701,RJXM,ZN101 Q
L I RJERL'[(U_I) D ^RJPTFCOD,^RJPTF10C S L=RJN101 D PUNCH,^RJPTF70C S L=RJN701 D PUNCH,^RJPTF50C S L=C501(1) D PUNCH
 Q
PUNCH S RJ(1)=RJ(1)+1,^XMB(3.9,RJXM,2,RJ(1),0)=$E(L,1,80) Q
KILL K ZN101,C501,RJN101,RJN701,C501 Q
