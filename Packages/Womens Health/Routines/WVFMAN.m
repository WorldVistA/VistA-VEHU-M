WVFMAN ;HCIOFO/FT,JR - FILEMAN CALLS;06/26/2017  12:56
 ;;1.0;WOMEN'S HEALTH;**24**;Sep 30, 1998;Build 582
 ;;IHS/ANMC/MWR * MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLS TO FILEMAN WITH PRE- AND POST-CALL VARIABLE SETTING.
 ;
 ;
DIC(DIC,DIC0,Y,DICA,DICB,DICS,X,WVPOP,DICW) ;EP
 ;---> CALL TO ^DIC
 ;---> PARAMETERS:
 ;     1 - DIC=DIC       (REQUIRED)
 ;     2 - DIC0=DIC(0)   (REQUIRED)
 ;     3 - Y             (RETURNED) FROM CALL TO ^DIC
 ;     4 - DICA=DIC("A") (OPTIONAL) PROMPT
 ;     5 - DICB=DIC("B") (OPTIONAL) DEFAULT
 ;     6 - DICS=DIC("S") (OPTIONAL) SCREEN
 ;     7 - X             (OPTIONAL) IF DIC(0)'["A"
 ;     8 - WVPOP         (OPTIONAL) WVPOP=1 IF DTOUT OR DUOUT
 ;     9 - DICW=DIC("W") (OPTIONAL) 
 ;
 ;---> EXAMPLE: D DIC^WVFMAN(790,"QEMAL",.Y,"   Select PATIENT: ")
 ;
 I $G(DIC)']""!($G(DIC0)']"") S WVPOP=1 Q
 S WVPOP=0 S:DIC DLAYGO=$P(DIC,".")
 S DIC(0)=DIC0
 S:$G(DICA)]"" DIC("A")=DICA
 S:$G(DICB)]"" DIC("B")=DICB
 S:$G(DICS)]"" DIC("S")=DICS
 S:$G(DICW)]"" DIC("W")=DICW
 D ^DIC
 S:($D(DTOUT))!($D(DUOUT)) WVPOP=1
 D DKILLS
 Q
 ;
DDS(DDSFILE,DR,DA,DDSPARM,DDSCHANG,WVPOP) ;EP
 ;---> CALL TO ^DDS
 ;---> NOTE: SCREENMAN AUTOMATICALLY USES INCREMENTAL LOCKS.
 ;---> PARAMETERS:
 ;     1 - DDSFILE=FILE# (REQUIRED)
 ;     2 - DR=FORM       (REQUIRED)
 ;     3 - DA=RECORD     (REQUIRED)
 ;     4 - DDSPARM (C/E) (OPTIONAL) C=REGISTER CHANGE IN DDSCHANG
 ;     5 - DDSCHANG      (RETURNED) DDSCHANG=1 IF CHANGE TO DATABASE
 ;     6 - WVPOP         (RETURNED) FAIL/QUIT/TIMEOUT
 ;
 ;---> EXAMPLES:
 ;     D DDS^WVFMAN(790.02,"[WV SITE PARAMS-FORM-1]",+Y)
 ;     D DDS^WVFMAN(790.1,"[WV PROC-FORM-LAB]",DA,"C",.WVCHG,.WVPOP)
 ;
 N WVDA,WVERROR S WVDA=DA,WVPOP=0
 I DDSFILE S DDSFILE=$$GET1^DID(DDSFILE,,,"GLOBAL NAME",,"WVERROR")
 I $D(WVERROR) D  Q
 .W !,?5,"* The Screen Manager could not locate the file containing this record."
 .W !,?7,"Please contact your Site Manager." D DIRZ^WVUTL3
 .S WVPOP=1
 L +@(DDSFILE_WVDA_")"):5 I '$T S WVPOP=1 D LOCKED^WVUTL3 Q
 K ^TMP("DDS",$J)
 D:'$D(IOST(0)) HOME^%ZIS D ENS^%ZISS
 D ^DDS
 S:$D(DTOUT) WVPOP=1
 I $D(DIMSG)!($D(DIERR)) D  S WVPOP=1
 .W !?5,"* The Screen Manager could not edit this record."
 .W !?7,"Please contact your Site Manager." D DIRZ^WVUTL3
 L -@(DDSFILE_WVDA_")")
 D DKILLS
 Q
 ;
DIE(DIE,DR,DA,WVPOP,Z) ;EP
 ;---> CALL TO ^DIE
 ;---> PARAMETERS:
 ;     1 - DIE=DIE (REQUIRED)
 ;     2 - DR=DR   (REQUIRED)
 ;     3 - DA=DA   (REQUIRED)
 ;     4 - WVPOP   (RETURNED) WVPOP=1 INDICATES FAILURE/QUIT
 ;     5 - Z       (OPTIONAL) Z=1 IF USER SHOULD *NOT* BE NOTIFIED
 ;                            RECORD WAS LOCKED.
 ;
 ;---> EXAMPLE: D DIE^WVFMAN(790,DR,+Y,.WVPOP)
 ;              (+Y FROM DIC CALL, DR COULD BE LITERAL IF SHORT.)
 ;
 N WVDA,WVERROR S WVDA=DA,WVPOP=0
 I DIE S DIE=$$GET1^DID(DIE,,,"GLOBAL NAME",,"WVERROR")
 I $D(WVERROR) D  Q
 .S WVPOP=1
 .Q:$G(Z)
 .W !?5,"Could not locate the file containing this record."
 .W !?7,"Please contact your Site Manager." D DIRZ^WVUTL3
 L +@(DIE_WVDA_")"):5 I '$T S WVPOP=1 D:'$G(Z) LOCKED^WVUTL3 Q
 D ^DIE
 I $D(DTOUT) S WVPOP=1
 L -@(DIE_WVDA_")")
 D DKILLS
 Q
 ;
FILE(DIC,DICDR,DIC0,X,DLAYGO,Y) ; EP - CALL FILE^DICN
 K DD,DO
 N WVERROR
 I DIC S DIC=$$GET1^DID(DIC,,,"GLOBAL NAME",,"WVERROR")
 S:$G(DICDR)]"" DIC("DR")=DICDR S DIC(0)=DIC0
 I '$D(WVERROR) D FILE^DICN
 D DKILLS
 Q
 ;
DIK ; EP - CALL ^DIK
 D ^DIK
 D DKILLS
 Q
 ;
DIQ ; EP - CALL ^DIQ
 D EN^DIQ
 D DKILLS
 Q
 ;
DIQ1 ; EP - CALL ^DIQ1
 D EN^DIQ1
 D DKILLS
 Q
 ;
DKILLS ;EP
 K D,D0,D1,DA,DD,DDH,DI,DIADD,DIC,DIC1,DICR,DIE,DIG,DIH,DIK,DILC
 K DINUM,DIRUT,DIQ,DIQ2,DIR,DIU,DIW,DIWF,DIWL,DIWR,DIWT,DK,DL
 K DLAYGO,DN,DQ,DR,DTOUT,DUOUT,DX,DIROUT,DIERR,DIMSG
 Q
