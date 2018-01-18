VEGKZOPT ;GRK;Pioneer Data Systems;Edit options [4/23/98 4:03pm]
 ;
OPT(OPTDA) ;enter here to edit an option
 ; if OPTDA is not passed, the option will be asked
 N OPTYPE,DIC,VAL,%1
 I $G(OPTDA)'>0 D
 .S DIC="^DIC(19,",DIC(0)="QEAMZ"
 .S DIC("S")="I $L($P(^(0),U,4)),""R""[$P(^(0),U,4)" ;avoid menus, protocols, etc.
 .D ^DIC S OPTDA=+Y
 ;
 I $D(^DIC(19,+OPTDA,0)) S OPTYPE=$P(^(0),U,4) D
 .; should we edit entry and exit for ANY option?
 .I OPTYPE="A" S VAL=$G(^DIC(19,+OPTDA,20)) ;call VPE field editor
 .I OPTYPE="E" ; set up var. and call FM input template editor
 .I OPTYPE="P" ; set up var. and call FM to edit sort and print temp.
 .I OPTYPE="I" ; set up var. and edit the opt fields
 .I OPTYPE="R" D  Q
 ..S %1=$G(^DIC(19,+OPTDA,25)) S:%1["^" %1=$P(%1,"^",2) X ^%ZVEMS("E")
 .W !!,"Editing an ",OPTYPE," type option is not yet supported.",*7
EXIT Q
