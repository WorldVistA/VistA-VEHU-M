PRSTRP ; HISC/CLS - Payroll Reports ;11/2/89  14:33
 ;;3.5;PAID;;Jan 26, 1995
 W ! S L=0,DIC="^PRST(455.5,",FLDS=".01,1,2;L25",BY=.01,(FR,TO)="",DHD="T&L UNITS STATUS REPORT" D EN1^DIP G EX
PR ; List T&L's not yet reviewed by Payroll
 W ! S L=0,DIC="^PRST(455.5,",FLDS=".01,1,2;L25",BY=.01,(FR,TO)="",DHD="T&L UNITS NOT YET REVIEWED",DIS(0)="I ""T""[$P(^PRST(455.5,D0,0),""^"",3)" D EN1^DIP G EX
EX K DIJ,DISYS,DP,P,X,Y,BY,DHD,DIC,DIS,FLDS,FR,L,TO,DIJ,DISYS,DP,P,X,Y Q
