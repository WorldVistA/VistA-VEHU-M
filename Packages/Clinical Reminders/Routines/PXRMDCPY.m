PXRMDCPY ;SLC/PJH - Copy dialog files. ;10/23/2019
 ;;2.0;CLINICAL REMINDERS;**4,12,45**;Feb 04, 2005;Build 566
 ;
 ;Called by label from PXRMDEDT
 ;
 ;Yes/No prompts
 ;--------------
ASK(YESNO,TEXT,HLP,DEFAULT) ;
 N X,Y,DIR
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")=TEXT
 S DIR("B")=DEFAULT
 S DIR("?")="Enter Y or N. For detailed help type ??"
 S DIR("??")=U_"D HELP^PXRMDEDT(HLP)"
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S YESNO=$E(Y(0))
 Q
 ;
 ;Copy any dialog
 ;---------------
ANY W IORESET
 N PROMPT,PXRMDANY,ROOT,WHAT
 S WHAT="dialog",ROOT="^PXRMD(801.41,",PROMPT="Select the dialog to copy: "
 S PXRMDANY=1
 D COPY^PXRMCOPY(PROMPT,ROOT,WHAT)
 Q
 ;
 ;Delete the entry just added
 ;--------------------------- 
DELETE S DIK=ROOT,DA=IENN D ^DIK
 W !!,"New entry not created due to invalid name!",!
 Q
 ;
 ;Error Handler
 ;-------------
ERR(DESC) ;
 N ERROR,IC,REF
 S ERROR(1)="Unable to update GUI PROCESS file : "_DESC
 S ERROR(2)="Error in UPDATE^DIE, needs further investigation"
 ;Move MSG into ERROR
 S REF="MSG"
 F IC=3:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D BMES^XPDUTL(.ERROR)
 Q
 ;
 ;;Given ROOT return the first
 ;;---------------------------
 ;GETFOIEN(ROOT) ;Return the first open IEN in ROOT. This should be called
 ;;after a call to SETSTART.
 ;N ENTRY,NIEN,OIEN
 ;S ENTRY=ROOT_0_")"
 ;S OIEN=$P(@ENTRY,U,3)
 ;S ENTRY=ROOT_OIEN_")"
 ;F  S NIEN=$O(@ENTRY) Q:+(NIEN-OIEN)>1  Q:+NIEN'>0  S OIEN=NIEN,ENTRY=ROOT_NIEN_")"
 ;Q OIEN+1
 ;;
 ;;Use MERGE to copy ROOT(IENO into ROOT(IENN
 ;;------------------------------------------
 ;MERGE(IENN,IENO,ROOT) ;
 ;N DEST,SOURCE
 ;;
 ;S DEST=ROOT_IENN_")"
 ;;Lock the file before merging.
 ;L +@DEST:10
 ;E  W !,"Another user is editing this file, try later" H 2 S DUOUT=1 Q
 ;S SOURCE=ROOT_IENO_")"
 ;M @DEST=@SOURCE
 ;;Unlock the file
 ;L -@DEST
 ;Q
 ;;
 ;Get default name
 ;----------------
NAME(IEN,ORG) ;
 N CNT,NAME,PREV
 ;
 S PREV=0
 I $E(ORG,$L(ORG))=")",ORG[" (" D
 .S PREV=+$P(ORG," (",2) S:PREV>0 ORG=$P(ORG," (",1)
 F CNT=PREV+1:1 S NAME=ORG_" ("_CNT_")" Q:'$D(^PXRMD(801.41,"B",NAME))
 Q NAME
 ;
 ;Copy selected dialog element OR reminder dialog
 ;-----------------------------------------------
SEL(IENO,RDIEN) ;
 W IORESET S VALMBCK="R"
 N ANS,IENN,PROMPT,ROOT,TEXT,WHAT,DPOS
 S WHAT="dialog element"
 S ROOT="^PXRMD(801.41,"
 S PROMPT="Select the dialog to copy: "
 S TEXT=$P($G(^PXRMD(801.41,IENO,0)),U)
 ;
 I RDIEN S TEXT="Copy and replace '"_TEXT_"'  "
 I 'RDIEN S TEXT="Copy reminder dialog '"_TEXT_"'  "
 D ASK(.ANS,TEXT,2,"Y") Q:$D(DUOUT)!$D(DTOUT)  Q:ANS'="Y"
 ;Copy
 D GETORGRC^PXRMCOPY(IENO,.IENN,ROOT,WHAT,1) Q:$D(DUOUT)!$D(DTOUT)
 I +$G(IENN)=0 S DTOUT=1 Q
 S DPOS=$G(SEQ)
 ;Replace dialog element in reminder dialog
 I RDIEN D
 .N DR,DA,DIE
 .S DA=0
 .F  S DA=$O(^PXRMD(801.41,RDIEN,10,"D",IENO,DA)) Q:DA=""  D
 . . I $P($G(^PXRMD(801.41,RDIEN,10,DA,0)),U)=$G(DPOS) D
 . . . S DA(1)=RDIEN
 . . . S DR="2///"_IENN
 . . . S DIE=ROOT_RDIEN_",10,"
 . . . D ^DIE
 .;W !,"Replaced element'"_$P(@(ROOT_IENO_",0)"),U)_"'"
 .;W !,"with '"_$P(@(ROOT_IENN_",0)"),U)_"'"
 .;W !,"on this dialog.",!
 ;
 ;Quit screen for edit = yes
 I 'RDIEN S VALMBCK="Q" Q
 ;
 N DIR
 S DIR(0)="YAO"
 S DIR("A")="Do you want to edit now  "
 S DIR("B")="Y"
 D ^DIR
 I $D(DIRUT) S DUOUT=1 Q
 I $E(Y(0))'="Y" S DUOUT=1 Q
 W !
 ;Reset dialog element ien
 S IENO=IENN
 Q
 ;
 ;Return TRUE (1) if NAME is unique 
 ;---------------------------------
UNIQNAME(NAME,ROOT) ;
 N RETVAL,REF
 S RETVAL=1,REF=ROOT_"""B"""_","_""""_NAME_""""_")"
 I $D(@REF) S RETVAL=0
 Q RETVAL
