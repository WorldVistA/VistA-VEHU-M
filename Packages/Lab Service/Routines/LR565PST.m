LR565PST ;HDSO/DSK - LR*5.2*565 Post-install routine; Mar 21, 2023@14:00
 ;;5.2;LAB SERVICE;**565**;Sep 27, 1994;Build 7
 ;
 Q
 ;
EN ;
 ;This post-install routine for LR*5.2*565 will correct the spelling
 ;of "TRIMETHAPRIM" to "TRIMETHOPRIM" in several fields - if incorrect
 ;spelling exists.
 ;
 ;1. Delete the INTERNAL NAME (#5) field entry from the ANTIMICROBIAL
 ;   SUSCEPTIBILITY (#62.06) file entry for "TRIMETHAPRIM/SULFAMETHOXAZOLE"
 ;   and "TRIMETHAPRIMSULFAMETHOXAZOLE". (Not all sites have the second
 ;   misspelling without the "/".)
 ;
 ;2. In the ORGANISM (#63.3) sub-file of the MICROBIOLOGY (#5) sub-file of
 ;   the LAB DATA (#63) file, correct spellings for "TRIMETHAPRIM/SULFA INTERP",
 ;   "TRIMETHAPRIM/SULFA SCREEN", "TRIMETHAPRIM/SULFAMETHOXAZOLE" and
 ;   "TRIMETHAPRIMSULFAMETHOXAZOLE"
 ;
 ;3. Re-file the INTERNAL NAME(#5) field of the ANTIMICROBIAL SUSCEPTIBILITY
 ;   (#62.06) file entry from step 2.
 ;
 ;A MailMan message is sent to the installer and members of the LMI MailMan group
 ;for one of the following outcomes:
 ;
 ;1. File updates were performed successfully for files 62.06 and 63.3.
 ;   or
 ;2. No entries containing incorrect spelling currently exist, so no
 ;   corrections were needed by the post-install routine.
 ;
 ;The routine is not deleted after install because the backout section
 ;needs to remain.
 ;
 D BMES^XPDUTL($$CJ^XLFSTR("LR*5.2*565 post-install routine beginning....",80))
 ;
 N LRSEQ,LRLINE,LRDA633,LRDA6206,LRSAVE,LRMZ,LRSL,LRNOSL
 S LRSEQ=16
 ;Killing ^XTMP in case routine is run more than once during testing.
 K ^XTMP("LR*5.2*565 POST INSTALL")
 S ^XTMP("LR*5.2*565 POST INSTALL",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^LR*5.2*565 POST INSTALL"
 S ^XTMP("LR*5.2*565 POST INSTALL",1)="If Laboratory files contained the incorrect spelling ""TRIMETHAPRIM/"
 S ^XTMP("LR*5.2*565 POST INSTALL",2)="SULFAMETHOXAZOLE"", the LR*5.2*565 post-install routine corrected the"
 S ^XTMP("LR*5.2*565 POST INSTALL",3)="spelling to ""TRIMETHOPRIM/SULFAMETHOXAZOLE""."
 S ^XTMP("LR*5.2*565 POST INSTALL",4)=" "
 S ^XTMP("LR*5.2*565 POST INSTALL",5)="Fields which were checked:"
 S ^XTMP("LR*5.2*565 POST INSTALL",6)=" "
 S ^XTMP("LR*5.2*565 POST INSTALL",7)="LAB DATA (#63) file, MICROBIOLOGY (#5) sub-file, ORGANISM (#63.3) sub-file"
 S ^XTMP("LR*5.2*565 POST INSTALL",8)="   TRIMETHOPRIM/SULFAMETHOXAZOLE (#75) field"
 S ^XTMP("LR*5.2*565 POST INSTALL",9)="   TRIMETHOPRIM/SULFA INTERP (#75.1) field"
 S ^XTMP("LR*5.2*565 POST INSTALL",10)="   TRIMETHOPRIM/SULFA SCREEN (#75.2) field"
 S ^XTMP("LR*5.2*565 POST INSTALL",11)=" "
 S ^XTMP("LR*5.2*565 POST INSTALL",12)="ANTIMICROBIAL SUSCEPTIBILITY (#62.06) file"
 S ^XTMP("LR*5.2*565 POST INSTALL",13)="   ""C"" cross reference (points to field #75 in sub-file #63.3)"
 S ^XTMP("LR*5.2*565 POST INSTALL",14)=" "
 S ^XTMP("LR*5.2*565 POST INSTALL",15)="Results of post-install routine:"
 S ^XTMP("LR*5.2*565 POST INSTALL",16)="-------------------------------"
 D DEL6206,TRI633,F6206
 D MAIL,BMES
 Q
 ;
BMES ;
 D BMES^XPDUTL($$CJ^XLFSTR("LR*5.2*565 post-install routine complete.",80))
 D BMES^XPDUTL($$CJ^XLFSTR("MailMan message number #"_LRMZ_" sent to installer",80))
 D BMES^XPDUTL($$CJ^XLFSTR("and members of the LMI MailMan group.",80))
 Q
 ;
DEL6206 ;
 ;Several scenarios found at sites in the "C" cross reference:
 ;1. No misspellings found.
 ;2. Misspelling of "TRIMETHAPRIM/SULFAMETHOXAZOLE" found.
 ;3. Misspelling of "TRIMETHAPRIMSULFAMETHOXAZOLE" found.
 ;4. One or both of the above misspellings found.
 ;
 ;First, have to delete the field so that the incorrect "C" cross reference
 ;will be killed. The cross reference logic retrieves the current
 ;name from file 63.3 so simply refiling later will not kill the
 ;misspelled name.
 S LRSL=$O(^LAB(62.06,"C","TRIMETHAPRIM/SULFAMETHOXAZOLE",""))
 S LRNOSL=$O(^LAB(62.06,"C","TRIMETHAPRIMSULFAMETHOXAZOLE",""))
 ;Quit if no misspellings found.
 I 'LRSL,'LRNOSL D  Q
 . ;Save text so will display after file 63.3 message(s).
 . S LRSAVE(1)="Correction not needed in the ANTIMICROBIAL SUSCEPTIBILITY (#62.06) file"
 . S LRSAVE(2)="""C"" cross reference."
 . S LRSAVE(3)=" "
 ;Delete the current INTERNAL NAME entry.
 N LRHIT
 S LRHIT=0
 F LRDA6206=LRSL,LRNOSL I 'LRHIT,LRDA6206,$D(^LAB(62.06,LRDA6206,0)) D
 . N DIE,DR,DA
 . S DIE="^LAB(62.06,",DR="5////@"
 . S DA=LRDA6206
 . D ^DIE
 . ;Do not file twice if IEN's are the same.
 . I LRSL=LRNOSL S LRHIT=1
 ;Make sure all stray cross references are audited and then killed. Some sites have both.
 I LRSL D
 . S ^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"C","TRIMETHAPRIM/SULFAMETHOXAZOLE",LRSL)=""
 . K ^LAB(62.06,"C","TRIMETHAPRIM/SULFAMETHOXAZOLE")
 I LRNOSL D
 . S ^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"C","TRIMETHAPRIMSULFAMETHOXAZOLE",LRNOSL)=""
 . K ^LAB(62.06,"C","TRIMETHAPRIMSULFAMETHOXAZOLE")
 Q
 ;
TRI633 ;
 ;Correct spelling in file 63.3.
 ;No sites appear to have a "B" index spelled "TRIMETHAPRIMSULFAMETHOXAZOLE"
 ;so not checking for that.
 N DIE,DR,LRHIT
 S LRHIT=0
 S DIE="^DD(63.3,"
 S LRDA633=$O(^DD(63.3,"B","TRIMETHAPRIM/SULFAMETHOXAZOLE",""))
 I LRDA633 D
 . S DR=".01////TRIMETHOPRIM/SULFAMETHOXAZOLE"
 . D F633
 . D INIT633
 . S LRLINE="   TRIMETHOPRIM/SULFAMETHOXAZOLE (#75) field"
 . D XTMP
 . ;Line below is kept in case back out is needed.
 . S ^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF")=LRDA633
 S LRDA633=$O(^DD(63.3,"B","TRIMETHAPRIM/SULFA INTERP",""))
 I LRDA633 D
 . S DR=".01////TRIMETHOPRIM/SULFA INTERP"
 . D F633
 . I 'LRHIT D INIT633
 . S LRLINE="   TRIMETHOPRIM/SULFA INTERP (#75.1) field"
 . D XTMP
 . ;Line below is kept in case back out is needed.
 . S ^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF INTERP")=LRDA633
 S LRDA633=$O(^DD(63.3,"B","TRIMETHAPRIM/SULFA SCREEN",""))
 I LRDA633 D
 . S DR=".01////TRIMETHOPRIM/SULFA SCREEN"
 . D F633
 . I 'LRHIT D INIT633
 . S LRLINE="   TRIMETHOPRIM/SULFA SCREEN (#75.2) field"
 . D XTMP
 . ;Line below is kept in case back out is needed.
 . S ^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF SCREEN")=LRDA633
 I 'LRHIT D
 . S LRLINE="Corrections not needed in the ORGANISM (#63.3) sub-file."
 . D XTMP
 S LRLINE=" "
 D XTMP
 ;Retrieve field 75 IEN again for use when correcting file 62.06.
 S LRDA633=$O(^DD(63.3,"B","TRIMETHOPRIM/SULFAMETHOXAZOLE",""))
 Q
 ;
INIT633 ;
 S LRLINE="Incorrect spelling found and corrected in the ORGANISM (#63.3) sub-file:"
 D XTMP
 S LRHIT=1
 Q
 ;
F633 ;
 N DA
 S DA=LRDA633 D ^DIE
 Q
 ;
F6206 ;
 ;Now re-set 62.06
 N DIE,DA,DR,LRDA6206,LRINIT,LRHIT
 S DIE="^LAB(62.06,"
 S (LRINIT,LRHIT)=0
 S DR="5////"_LRDA633
 ;Performing a $D on the zero node because some sites appear to
 ;have killed the zero node but left the "C" cross reference.
 F LRDA6206=LRSL,LRNOSL I 'LRHIT,LRDA6206,$D(^LAB(62.06,LRDA6206,0)) D
 . S DA=LRDA6206
 . D ^DIE
 . ;Don't file twice if IEN's are the same.
 . I LRSL=LRNOSL S LRHIT=1
 . I 'LRINIT D
 . . S LRLINE="Incorrect spelling found and corrected in the ""C"" cross"
 . . D XTMP
 . . S LRLINE="reference of the ANTIMICROBIAL SUSCEPTIBILITY (#62.06) file."
 . . D XTMP
 . . S LRINIT=1
 . ;Line below is kept in case back out is needed.
 . S ^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"IEN",LRDA6206)=""
 S LRLINE=" "
 D XTMP
 Q
 ;
XTMP ;
 S LRSEQ=LRSEQ+1
 S ^XTMP("LR*5.2*565 POST INSTALL",LRSEQ)=LRLINE
 Q
 ;
MAIL ;
 N LRTEXT,LRMY,LRSUB,LRMIN
 I $O(LRSAVE("")) D
 . N LRSQX
 . S LRSQX=""
 . F  S LRSQX=$O(LRSAVE(LRSQX)) Q:LRSQX=""  D
 . . S LRSEQ=LRSEQ+1
 . . S ^XTMP("LR*5.2*565 POST INSTALL",LRSEQ)=LRSAVE(LRSQX)
 S ^XTMP("LR*5.2*565 POST INSTALL",LRSEQ+1)="The text of this message will be stored in the global"
 S ^XTMP("LR*5.2*565 POST INSTALL",LRSEQ+2)="^XTMP(""LR*5.2*565 POST INSTALL"" for 90 days."
 S LRTEXT="^XTMP(""LR*5.2*565 POST INSTALL"")"
 S LRMY("G.LMI")=""
 S LRMY(DUZ)=""
 S LRSUB="LR*5.2*565 Post-Install Information"
 S LRMIN("FROM")="LR*5.2*565 Post-Install"
 D SENDMSG^XMXAPI(DUZ,LRSUB,LRTEXT,.LRMY,.LRMIN,.LRMZ,"")
 Q
 ;
BACKOUT ;
 ;This section is invoked manually from the programmer's prompt if backout is needed.
 ;
 ;The backout will revert the spelling of "TRIMETHOPRIM" to "TRIMETHAPRIM" in several fields.
 ;
 ;Only if changes were made by the patch install:
 ;
 ;1. Delete the INTERNAL NAME (#5) field entry from the ANTIMICROBIAL
 ;   SUSCEPTIBILITY (#62.06) file entry for "TRIMETHOPRIM/SULFAMETHOXAZOLE".
 ;2. In the ORGANISM (#63.3) sub-file of the MICROBIOLOGY (#5) sub-file of
 ;   the LAB DATA (#63) file, revert spellings for "TRIMETHOPRIM/SULFA INTERP",
 ;   "TRIMETHOPRIM/SULFA SCREEN", and "TRIMETHOPRIM/SULFAMETHOXAZOLE".
 ;3. Re-file the INTERNAL NAME(#5) field of the ANTIMICROBIAL SUSCEPTIBILITY
 ;   (#62.06) file entry from step 2. (This is necessary to re-set the
 ;   "C" cross reference.)
 ;4. Re-set stray cross references.
 ;
 N DIR,Y
 S DIR("A",1)="This action will back out the file modifications that were performed"
 S DIR("A",2)="after the install of LR*5.2*565."
 S DIR("A")="Are you sure you wish to proceed",DIR("B")="NO",DIR(0)="Y"
 D ^DIR
 Q:Y<1
 ;
 N LRSEQ,LRDA633,LRDA6206,LRLINE,LRHIT,LRSTRAY
 S LRSEQ=4
 ;Killing ^XTMP in case routine is run more than once during testing.
 K ^XTMP("LR*5.2*565 BACKOUT")
 S ^XTMP("LR*5.2*565 BACKOUT",0)=$$FMADD^XLFDT(DT,90)_"^"_DT_"^LR*5.2*565 BACKOUT"
 S ^XTMP("LR*5.2*565 BACKOUT",1)="Backout of LR*5.2*565 restored field entries in two files to contain"
 S ^XTMP("LR*5.2*565 BACKOUT",2)="""TRIMETHAPRIM"" instead of ""TRIMETHOPRIM"" if those fields were modified"
 S ^XTMP("LR*5.2*565 BACKOUT",3)="by the patch install."
 S ^XTMP("LR*5.2*565 BACKOUT",4)=" "
 D:$D(^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"IEN")) BDEL6206
 D BCK633
 D:$D(^XTMP("LR*5.2*565 POST INSTALL",0,62.06)) BF6206
 ;Ensure that stray cross-references are reset.
 S LRSTRAY="",LRHIT=0
 F  S LRSTRAY=$O(^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"C",LRSTRAY)) Q:LRSTRAY=""  D
 . S LRDA6206=""
 . F  S LRDA6206=$O(^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"C",LRSTRAY,LRDA6206)) Q:LRDA6206=""  D
 . . I '$D(^LAB(62.06,"C",LRSTRAY,LRDA6206)) D
 . . . S ^LAB(62.06,"C",LRSTRAY,LRDA6206)=""
 I '$D(^XTMP("LR*5.2*565 POST INSTALL",0,62.06)) D
 . S LRLINE="Backout not performed for the ANTIMICROBIAL SUSCEPTIBILITY (#62.06) file"
 . D BXTMP
 . S LRLINE="since misspellings did not exist before patch install."
 . D BXTMP
 . S LRLINE=" "
 . D BXTMP
 D END
 Q
 ;
BDEL6206 ;
 ;Check if 62.06 was refiled during install.
 Q:'$D(^XTMP("LR*5.2*565 POST INSTALL",0,62.06))
 N LRDA6206,DA,DR
 S LRDA6206=""
 F  S LRDA6206=$O(^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"IEN",LRDA6206)) Q:LRDA6206=""  D
 . ;Delete internal name from file 62.06.
 . S DIE="^LAB(62.06,",DR="5////@"
 . S DA=LRDA6206
 . D ^DIE
 Q
 ;
BF633INIT ;
 S LRLINE="In the ORGANISM (#63.3) sub-file of the MICROBIOLOGY (#5) sub-file of the"
 D BXTMP
 S LRLINE="LAB DATA (#63) file, the LR*5.2*565 backout process restored the following"
 D BXTMP
 S LRLINE="field(s) to contain ""TRIMETHAPRIM"":"
 D BXTMP
 S LRLINE=" "
 D BXTMP
 S LRHIT=1
 Q
 ;
BCK633 ;
 ;Not performing $D checks to determine if the IEN's exist since
 ;sites do not delete entries from file 63.3.
 N LRHIT
 S LRHIT=0
 ;Restore the original spelling in file 63.3.
 S DIE="^DD(63.3,"
 S LRDA633=$G(^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF"))
 I LRDA633 D
 . S DR=".01////TRIMETHAPRIM/SULFAMETHOXAZOLE"
 . D BF633,BF633INIT
 . S LRLINE="    TRIMETHAPRIM/SULFAMETHOXAZOLE (#75) field"
 . D BXTMP
 . ;Keeping audit of backout in case questions arise later.
 . S ^XTMP("LR*5.2*565 BACKOUT",0,633,"TRSULF")=LRDA633
 S LRDA633=$G(^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF INTERP"))
 I LRDA633 D
 . S DR=".01////TRIMETHAPRIM/SULFA INTERP"
 . D BF633
 . I 'LRHIT D BF633INIT
 . S LRLINE="    TRIMETHAPRIM/SULFA INTERP (#75.1) field"
 . D BXTMP
 . ;Keeping audit of backout in case questions arise later.
 . S ^XTMP("LR*5.2*565 BACKOUT",0,633,"TRSULF INTERP")=LRDA633
 S LRDA633=$G(^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF SCREEN"))
 I LRDA633 D
 . S DR=".01////TRIMETHAPRIM/SULFA SCREEN"
 . D BF633
 . I 'LRHIT D BF633INIT
 . S LRLINE="    TRIMETHAPRIM/SULFA SCREEN (#75.2) field"
 . D BXTMP
 . ;Keeping audit of backout in case questions arise later.
 . S ^XTMP("LR*5.2*565 BACKOUT",0,633,"TRSULF SCREEN")=LRDA633
 I 'LRHIT D
 . S LRLINE="Backout not performed for the ORGANISM (#63.3) sub-file of the"
 . D BXTMP
 . S LRLINE="MICROBIOLOGY (#5) sub-file of the LAB DATA (#63) file since no"
 . D BXTMP
 . S LRLINE="fields were modified during patch install."
 . D BXTMP
 S LRLINE=" "
 D BXTMP
 Q
 ;
BF633 ;
 S DA=LRDA633 D ^DIE
 Q
 ;
BF6206 ;
 ;Now re-set 62.06
 Q:'$D(^XTMP("LR*5.2*565 POST INSTALL",0,62.06))
 N LRDA6206,LRHIT,DIE,DA,DR,LRDA633
 S LRDA6206="",LRHIT=0
 S DIE="^LAB(62.06,"
 S LRDA633=$G(^XTMP("LR*5.2*565 POST INSTALL",0,633,"TRSULF"))
 ;LRDA633 should not be null, but checking to be sure.
 Q:'LRDA633
 S DR="5////"_LRDA633
 S LRDA6206="",LRHIT=0
 F  S LRDA6206=$O(^XTMP("LR*5.2*565 POST INSTALL",0,62.06,"IEN",LRDA6206)) Q:LRDA6206=""  D
 . ;Stop in case site deleted this IEN after install but before backout.
 . Q:'$D(^LAB(62.06,LRDA6206,0))
 . S DA=LRDA6206 D ^DIE
 . I 'LRHIT D
 . . S LRLINE="In the ANTIMICROBIAL SUSCEPTIBILITY (#62.06) file, the ""C"""
 . . D BXTMP
 . . S LRLINE="cross reference spelling was restored."
 . . D BXTMP
 . S LRHIT=1
 . ;Keeping audit of backout in case questions arise later.
 . S ^XTMP("LR*5.2*565 BACKOUT",0,62.06,"IEN",LRDA6206)=""
 S LRLINE=" "
 D BXTMP
 Q
 ;
BXTMP ;
 S LRSEQ=LRSEQ+1
 S ^XTMP("LR*5.2*565 BACKOUT",LRSEQ)=LRLINE
 Q
 ;
END ;
 W !!,"Backout is complete.",!
 N LRTEXT,LRMY,LRSUB,LRMIN,LRMZ,DIR
 S ^XTMP("LR*5.2*565 BACKOUT",LRSEQ+1)="The text of this message will be stored in the global"
 S ^XTMP("LR*5.2*565 BACKOUT",LRSEQ+2)="^XTMP(""LR*5.2*565 BACKOUT"" for 90 days."
 S LRTEXT="^XTMP(""LR*5.2*565 BACKOUT"")"
 S LRMY("G.LMI")=""
 S LRMY(DUZ)=""
 S LRSUB="LR*5.2*565 Backout Information"
 S LRMIN("FROM")="LR*5.2*565 BACKOUT"
 D SENDMSG^XMXAPI(DUZ,LRSUB,LRTEXT,.LRMY,.LRMIN,.LRMZ,"")
 S DIR("A",1)="MailMan message #"_LRMZ_" has been sent to you as well as"
 S DIR("A",2)="holders of the LMI security key."
 S DIR("A")="Press any key to continue"
 S DIR(0)="E"
 D ^DIR
 Q
 ;
