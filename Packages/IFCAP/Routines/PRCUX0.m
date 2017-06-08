PRCUX0 ;WISC@ALTOONA/CTB-ELECTRONIC SIGNATURE CODE CONVERSION SETUP ; 06 Apr 93  1:31 PM
V ;;4.0;IFCAP;;9/23/93
 N DIC,DLAYGO,DIE,DA,DR,Y,X
 W !,"This section will set up entries in the File 443.1."
 W !,"File 443.1 is used to manage the conversion of the Electronic"
 W !,"Signature Code Conversion.  ",!!
 W !,"Before I begin, you must enter the Site Parameters for the"
 W !,"conversion.",!!
 S DIC=443.2,DIC(0)="NL",DLAYGO=DIC,X=1 D ^DIC K DIC,DLAYGO
 I Y<0 W !,"No Action Taken at this time.",! Q
 S DIE="^PRC(443.2,",DA=+Y,DR="2//0600;3//YES;4//YES;5//YES;6//10"
 D ^DIE
 W !,"Now you can use task manager to schedule the option"
 W !,"'General Bacth Processing' in IFCAP application to"
 W !,"start the real electronic conversion"
 W !! D BUILD^PRCUX1,BUILD^PRCUX2,BUILD^PRCUX3,BUILD^PRCUX4,BUILD^PRCUX5,BUILD^PRCUX7,BUILD^PRCUX8
 QUIT
