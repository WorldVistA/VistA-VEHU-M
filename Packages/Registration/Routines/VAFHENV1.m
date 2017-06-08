VAFHENV1 ;ALB/RJS,PKE;environment check routine.;6/03/96
 ;;5.3;Registration;**91**;Jun 06, 1996
EN ;the main entry point of the enviroment check routine.
 I '($D(DUZ)#2) DO
 .W !?3,"DUZ must be set to a valid user to run this init."
 .S XPDQUIT=2
 I '$D(DUZ(0)) DO
 .W !?3,"DUZ(0) must be defined to run this init."
 .S XPDQUIT=2
 I $G(DUZ(0))'="@" DO
 .W !?3,"DUZ(0) must be equal to '@' to run this init."
 .S XPDQUIT=2
 W ! I $G(XPDQUIT) Q
 ;
EN1 ;around the normal DUZ checks
 ;PIMS CHECK
 N X,VAFHA
 ;;;S X="IBDFREG" X ^%ZOSF("TEST") E  DO
 ;.K X
 ;.W !!?6,"*** Required element missing ***"
 ;.W !?3,"Patch DG*5.3*86 must be installed first !"
 ;.W !?3,"Install will be aborted at end of environment check."
 ;.S XPDABORT=2
 ;
 ;HL7 CHECK
 S VAFHA=$$VERSION^XPDUTL("HL")
 I +VAFHA<1.6 DO
 .W !!?6,"*** Required element missing ***"
 .W !?3,"Your site seems to be running a version of HL7 less than 1.6"
 .W !?3,"Please investigate the version of the HL7 Package."
 .W !?3,"Install will be aborted at end of environment check."
 .S XPDABORT=2
 ;
 S VAFHA=$$VERSION^XPDUTL("REGISTRATION")
 I +VAFHA<5.3 DO
 .W !!?3,"Your site seems to be running a version of Registration less than 5.3"
 .W !?3,"Please investigate the version of Registration."
 .W !?3,"Install will be aborted at end of environment check."
 .S XPDABORT=2
 .;
 S VAFHA=$$VERSION^XPDUTL("SCHEDULING")
 I +VAFHA<5.3 DO
 .W !!?3,"Your site seems to be running a version of Scheduling less than 5.3"
 .W !?3,"Please investigate the version of Scheduling."
 .W !?3,"Install will be aborted at end of environment check."
 .S XPDABORT=2
 ;
 I $G(XPDABORT) DO  QUIT
 .W !
 .W !!?3,"*** Element(s) critical to installation of DG*5.3*91 are missing."
 .W !?3,"*** The installation will be aborted."
 .W !
 ;
 I '$G(XPDABORT) DO  QUIT
 .W !!?3,"The environment check has completed."
 .W !
 Q
