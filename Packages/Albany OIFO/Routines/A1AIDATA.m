A1AIDATA ;NP/ISC ALBANY; 11-3-87; 10:40am; Validate data extracted from site Equipment log globals.  Routine is called by A1AIGC which extracts data from tape.
1 ;
 ;.01;X $P(^DD(11200.02,.01,0),U,5)
 ;2;K:X'="I"&(X'="V") X
 ;3;S DIC=11200.2,DIC(0)="MNF" D ^DIC K:+Y<1 X
 ;5;X $P(^DD(11200.02,5,0),U,5)
 ;1;S %DT="XT",%DT(0)="-NOW" D ^%DT K %DT(0) K:Y<1 X
 ;4;S %DT="XT",%DT(0)="-NOW" D ^%DT K %DT(0) K:Y<1 X
 ;6.5;X $P(^DD(11200.02,6.5,0),U,5)
 ;
EN1 ;
 S U="^" S NOGO=""
 F II=1:1:6 S X=$P(X2,U,II),XFLD=$P($T(1+II),";",2) X $P($T(1+II),";",3) I $D(X)=0 S NOGO=1 D INVAL
 Q
INVAL ;
 W !,*7,"Invalid #",XFLD," ",$P(^DD(11200.02,XFLD,0),U),";  data = """,$P(X2,U,II+1),"""" Q
