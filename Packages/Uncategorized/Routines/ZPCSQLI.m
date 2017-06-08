ZPCSQLI ;MENU for SQLI-M Interaction - Master Control
 ; amt 1/15/97  Copyright 1997 Pittsburgh Veterans Research Corporation
 ;COPYRIGHT 1997 Aspire Technology ALL RIGHTS RESERVED
 ;
START ;;D CURRENT^%ZIS S %CLR=FF ;call a kernal routine set manually if no good
 W #,!?20,"SQL Interoceter - M Master Control"
OPT R !,"Enter OPTION: ",O:200 I O=""!('$T)!(O="//")!(O="^") K N,I,X,O Q
 I O["?" D DISP G OPT
 I O?1.N,O'=0,$T(OPTION+O)'="" W "  ",$P($T(OPTION+O),";",3) G FUNC
 I O'?1.N F I=1:1 S X=$P($T(OPTION+I),";",3) Q:X=""  I $E(X,1,$L(O))=O W $E(X,$L(O)+1,99) S O=I G FUNC
 W *7," Illegal Entry - Enter ? for Help",! G OPT
FUNC ;
 S X=$T(OPTION+O) D @$P(X,";",2) G START
DISP ;
 W !!,"Choose one of the following:",!!
 F I=1:1 S X=$T(OPTION+I) Q:X=""  W I,".",?4,$P(X,";",3),!
 Q
CALC ;RUN CALCULATOR
 W !,"{*PROGACT:CALC.EXE}",! Q
CLEAN ;DESTROY ^ZSQLINT the logging global
 K ^ZSQLINT W " Done.." H 2 Q
GRAPH ;RUN GRAPH
 S SP="                   "
 W " Launching PC program: ",*17,*17,*17,*17,*17,SP,!
 H 2 W "{*PROGACT:C:\VB4\GRAPH\GRAPH.EXE}"," ",*17,*17,! H 3 D ^ZPCDIAG Q
OPTION ;Program to execute;Description
 ;^ZRESP;Natural Language Interface;Natural dialog
 ;^ZRGET;Build Knowledge Base Definitions; what's defined
 ;LIST^ZRGET;List all object in Knowledge base
 ;DEL^ZRGET;Delete Knowledge Base Definitions;get rid of definitions
 ;SYN^ZRGET;Create a synoynm for knowledge base
 ;^ZPCDIAG;PC-M Host Dialog Messaging;
 ;ENDEM^ZPCMBCP;Demographic BCP accumulation;
 ;ENADM^ZPCMBCP;Admission BCP accumulation;
 ;ENLAB^ZPCMBCP1;Lab BCP accumulation;
 ;ENMED^ZPCMBCP1;Medication BCP accumulation;
 ;^ZPCLABC;Lab Clinic BCP Test Correlation;
 ;^ZPCAPPT;Appointment BCP accumulation (file:44);
 ;^ZPCAPPT1;Real appts BCP (Patient file)
 ;ENENC^ZPCMBCP2;BCP Encounters;
 ;BCP^ZPCRAD;BCP Radiology;
 ;CLEAN^ZPCSQLI;Clear all restart markers(BCP)
