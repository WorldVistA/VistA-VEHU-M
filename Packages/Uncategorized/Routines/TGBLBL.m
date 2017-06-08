A1AMLBLV ;ISC1/JSH - VERIFICATION LABEL PRINT
 S DIC=500084,DIC(0)="AEQMZ",DIC("A")="Select Verification Label: " D ^DIC Q:Y'>0  S DA=+Y
 S %IS("A")="Select Label Printer: " D ^%ZIS I POP G END
 U IO(0) R !,"WANT TO ALIGN LABELS? Y//",PAP D LUP:PAP'["N"
RDC U IO(0) S DIR(0)="N^1:50:0",DIR("A")="Number of Copies" D ^DIR Q:Y<1  S COP=Y
RD1 F I=1:1:11 S L(I)=$S($D(^DIZ(500084,DA,I)):^(I),1:"")
 U IO F I=1:1:COP W ! F J=1:1:11 W L(J),!
 G END
LUP U IO F TT=1:1:2 W ! F PP=1:1:11 W "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",!
 Q
END X ^%ZIS("C") K I,J,L,COP,TT,PP,DIC,DIR,DA,PAP,DIE Q
 X:IO'=IO(0) ^%ZIS("C") Q
EDIT S DIC=500084,DIC(0)="AQLEMZ",DIC("A")="Edit which Verification Label: "
 D ^DIC Q:Y'>0  S DA=+Y
 S DR="[A1AM VERIF LABEL]",DIE=DIC D ^DIE
 K DIC,DA,Y,DR,DIE Q
