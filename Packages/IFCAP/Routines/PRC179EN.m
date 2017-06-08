PRC179EN ;WISC/CAC-Environment check for patch PRC*5*179;5/10/99
V ;;5.0;IFCAP;**179**;4/21/95
 ; Has generic code sheet patch 19 been installed?
 N INSTALL,MSG,PRCEN
 D FIND^DIC(9.7,"",".01;.02","X","GEC*2.0*19",10,"B","","","PRCEN")
 S INSTALL=1
 I $O(PRCEN("DILIST",2,""))']"" S INSTALL=0
 I INSTALL,$P(PRCEN("DILIST","ID",PRCEN("DILIST",0)+0,.02),"^",1,2)'="Install Completed" S INSTALL=0
EXIT I 'INSTALL D
 . W !!,"GEC*2.0*19 must be installed prior to PRC*5.0*179."
 . S XPDQUIT=2 ; abort and keep transport global
 Q
