DGYPRT1 ;MAF/ALB - PARAMETER CHECK AND UPDATE FOR IRT. ;APR 2 1993@1100
 ;;5.2;REGISTRATION;**27**;JUL 29,1992
EN W !!,"This option will check the parameters for the IRT package to make sure informat-ion is contained in the parameters needed to run the IRT conversion, with the",!,"installation of PIMS v5.3. ",!
 W !,"A list of those parameters that need to be updated will be provided by this",!,"option.",!
 W !,"Only those divisions that are running IRT and have parameters that need to be  updated will appear on this list.",!
 W !!,"*** Please contact your MAS office if you have any questions as to how the",!,"    parameters should be answered."
 S DGPGM="START^DGYPRT1" D ZIS^DGUTQ I 'POP U IO G START^DGYPRT1
 G Q
EN1 N DGJFLAG S DGJMSG=0
 I '$D(^VAS(393,0)) D NOCON G Q
 S DGJTDV=0 F  S DGJTDV=$O(^DG(40.8,DGJTDV)) Q:DGJTDV']""!(+DGJTDV=0)  I $D(^DG(40.8,DGJTDV,0)) I $D(^DG(40.8,DGJTDV,"DT")) D DIVPAR Q:$D(DGJFLAG)
 I 'DGJMSG W !!!,"***All IRT Parameters are updated!***"
 G Q:$D(DGJFLAG)
 G Q
START N DGJFLAG S DGJMSG=0
 I '$D(^VAS(393,0)) D NOCON G Q
 S DGJTDV=0 F  S DGJTDV=$O(^DG(40.8,DGJTDV)) Q:DGJTDV']""!(+DGJTDV=0)  I $D(^DG(40.8,DGJTDV,0)) I $D(^DG(40.8,DGJTDV,"DT")) D LIST
 W !!?26,"LISTING OF PARAMETERS TO UPDATE FOR IRT",!!!
 I $D(^UTILITY("VAS",$J)) W "***PLEASE UPDATE THE FOLLOWING PARAMETERS FOR THE IRT PACKAGE!",!,"***THESE PARAMETERS MUST BE UPDATED PRIOR TO THE INSTALLATION OF PIMS v5.3***",!! D PRT,MSG
 I '$D(^UTILITY("VAS",$J)) W !!!,"***ALL IRT PARAMETERS ARE UPDATED!"
 G Q:$D(DGJFLAG)
Q K DIC,DIE,DR,DA,DGJTNODE,DGJTADM,DGJATT,DGJPRIM,DGJRES,DGJT,DGJTPAR,DGJTPHDE,DGJSTAT,DGJTDV,DGJDV,DGJDTN,DGJFSIG,DGJY,DGJMSG,DGPGM,IFN,POP,X,^UTILITY("VAS",$J) D CLOSE^DGUTQ Q
LIST S X=^DG(40.8,+DGJTDV,"DT") I $P(X,"^",2)']"" S $P(^UTILITY("VAS",$J,$P(^DG(40.8,DGJTDV,0),"^",1)),"^",1)=100.02
 I $P(X,"^",3)']"" S $P(^UTILITY("VAS",$J,$P(^DG(40.8,DGJTDV,0),"^",1)),"^",2)=100.03
 I $P(X,"^",3)=1,$P(X,"^",4)']"" S $P(^UTILITY("VAS",$J,$P(^DG(40.8,DGJTDV,0),"^",1)),"^",3)=100.04
 I $P(X,"^",10)']"" S $P(^UTILITY("VAS",$J,$P(^DG(40.8,DGJTDV,0),"^",1)),"^",4)=100.1
 Q
PRT S DGJTDV=0 F  S DGJTDV=$O(^UTILITY("VAS",$J,DGJTDV)) Q:DGJTDV']""  I $D(^UTILITY("VAS",$J,DGJTDV)) S DGJTNODE=^UTILITY("VAS",$J,DGJTDV) D WRITE
 Q
WRITE W !!,"DIVISION: "_DGJTDV
 I $P(DGJTNODE,"^",1)]"" W !?5,$P(^DD(40.8,$P(DGJTNODE,"^",1),0),"^",1),?32,"     Choices: Primary or Attending Physician"
 I $P(DGJTNODE,"^",2)]"" W !?5,$P(^DD(40.8,$P(DGJTNODE,"^",2),0),"^",1),?34,"   Choices: Yes or No",!?10,"If 'YES' the parameter DEFAULT REVIEWING PHYSICIAN will also be asked",!?32,"     Choices: Primary or Attending Physician"
 I $P(DGJTNODE,"^",3)]"" W !?5,$P(^DD(40.8,$P(DGJTNODE,"^",3),0),"^",1),?32,"     Choices: Primary or Attending Physician"
 I $P(DGJTNODE,"^",4)]"" W !?5,$P(^DD(40.8,$P(DGJTNODE,"^",4),0),"^",1),"     Choices: Primary or Attending Physician"
 Q
DIVPAR K DR S X=^DG(40.8,+DGJTDV,"DT") I $P(X,"^",2)']"" S DR="100.02"
 I $P(X,"^",3)']"" S DR=$S($D(DR):DR_";100.03;I X=0 S Y=""@1"";100.04;@1",1:"100.03;I X=0 S Y=""@1"";100.04;@1")
 I $P(X,"^",3)=1,$P(X,"^",4)']"" S DR=$S($D(DR):DR_";100.04",1:"100.04")
 I $P(X,"^",10)']"" S DR=$S($D(DR):DR_";100.1",1:"100.1")
 I $D(DR) D:'DGJMSG PARSET S DIE="^DG(40.8,",DA=+DGJTDV,DR="W !,""DIVISION: "",$P(^DG(40.8,DA,0),U);"_DR D ^DIE I X']""!($D(DTOUT)) D Q1 S DGJFLAG=1
 Q
Q1 W !!!,"It is necessary to have all parameters set up prior to the installation of",!,"PIMS v5.3."
 W !!,"***FAILURE TO ANSWER ALL PARAMETERS WILL CAUSE THE IRT CONVERSION TO ABORT!"
MSG W !!!,"***PLEASE CONTACT YOUR MAS OFFICE IF YOU HAVE ANY QUESTIONS AS TO HOW THE",!,"   IRT PARAMETERS SHOULD BE ANSWERED!"
 W !!,"***The 'IRT Parameters That Need Updating' report will provide you with the",!,"   areas needing updating.  Go under the 'Update IRT Parameters' under your",!,"   Pre-Install Menu to update your data."
 Q
PARSET W !!,"This option allows the user to update the parameters for the IRT package that   will be needed to run the IRT conversion with the installation of PIMS v5.3."
 W !!,"**FAILURE TO UPDATE ANY OF THE PARAMETERS WILL CAUSE THE IRT CONVERSION TO ABORT  AT THE TIME OF INSTALLATION!",!
 I $D(^DG(43,1,"GL")) S X=$P(^DG(43,1,"GL"),"^",2) I X=1 W !!,"PARAMETERS MUST BE ANSWERED FOR ALL DIVISIONS!!",!
 W !!,"PLEASE UPDATE THE FOLLOWING PARAMETERS NOW!",!
 S DGJMSG=1
 Q
NOCON  W !!!,"***THIS SITE IS NOT USING THE IRT PACKAGE. THIS IRT PARAMETER UPDATE NEED NOT BE RUN***",!! Q
