MAGJMN1 ;WIRMFO/JHC - VRad Maint functions ; 10/17/2022
 ;;3.0;IMAGING;**16,9,22,18,65,76,101,90,115,120,133,152,153,184,199,255,341**;Dec 21, 2022;Build 28
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ;; ISI IMAGING;**99,100,101,105,102,106**
SVRLIST ;
 W @IOF,!!?10,"Enter/Edit ISI Rad Exams List Definition",!!
 N MAGIEN
 K DIC S (DIC,DLAYGO)=2006.631,DIC(0)="ALMEQ"
 D ^DIC I Y=-1 K DIC,DA,DR,DIE,DLAYGO Q
 S X=$P(@(DIC_+Y_",0)"),U,2)
 I X>9000 W !!,$C(7),"You may not edit System-Supplied files!" H 3 G SVRLIST
 S DIE=2006.631,DA=+Y,DR="[MAGJ LIST EDIT]"
 S MAGIEN=DA
 D ^DIE I '$D(DA) G SVRLIST
 ; ISI start
 S X=$P(@(DIC_+DA_",0)"),U,3)
 I X="I" W !!,"Indexed List Type requires compile program entry point:",!
 I  S DIE=2006.631,DR="200;201" D ^DIE I '$D(DA) G SVRLIST
 ; ISI end
 D ENSRCH
 D BLDDEF(MAGIEN)
 S $P(^MAG(2006.631,MAGIEN,0),U,5)=$$NOW^XLFDT()
 W !!,"List Definition complete!" R X:2
 G SVRLIST
 Q
ENSRCH ; Invoke Search for 2006.631 def'n
 N GREF,GLIN,GO,CT,DIARI,DIC,FNOD,TNOD,NCOND,NODE0
 ; GREF holds indirect ref to store search logic data:
 ; @GREF@(3, ff -- conditional elements (fields/logic)
 ; @GREF@(4, ff -- composite elements (ANDed conditions)
 ; @GREF@(5, ff -- Human-readable search text
 ; GLIN holds indirect ref to retrieve search logic data from ^DIBT
 ; @GLIN@("DC", ff -- conditional elements
 ; @GLIN@("DL", ff -- composite elements
 ; @GLIN@("O", ff -- readable text
 S GREF=$NA(^MAG(2006.631,MAGIEN,"DEF"))
 S GO=1 I $D(@GREF@(5,1)) D  ; show current logic
 . W ! D DISPSRCH(GREF)
 . S X=$$YN("Do you want to delete or re-enter the search logic?","NO")
 . I X'="Y" S GO=0 Q
 . W !!?7,"Re-entering the search logic requires first deleting the current",!?7,"definition, then entering the new definition from scratch."
 . S X=$$YN("Are you sure you want to continue?","NO")
 . I X'="Y" S GO=0 Q
 I 'GO Q
 W !!?7,"Now enter search logic for this List.  To do this, the program"
 W !?7,"will prompt you just as if you were going to run a Fileman Search."
 W !?7,"When prompted STORE RESULTS OF SEARCH IN TEMPLATE:, answer with 'TEMP'"
 W !?7,"If prompted ... OK TO PURGE? NO// answer 'YES'; don't bother specifying"
 W !?7,"output print fields, but just RETURN through all the prompts to"
 W !?7,"complete the process.  The search definition will be saved as part"
 W !?7,"of this List definition; you will test it out by running it from "
 W !?7,"the workstation.  If you need to modify the search logic, you will"
 W !?7,"have to re-enter it in its entirety."
 W !!?7,"NOTES: EXAM LOCK INDICATOR will not work for search logic;"
 W !?14,"REMOTE CACHE INDICATOR only works for Null/Not Null logic."
 S DIC=2006.634 D EN^DIS  ; call Fman Search Logic routine. It will store search logic in ^DIBT
 ; 2006.634 is intentional--don't change this!
 I '$G(DIARI) W !!," Search logic NOT updated" D  Q
 . Q:'$D(@GREF@(5,1))  ; if no logic had existed, quit
 . S X=$$YN("Do you want to DELETE the search logic?","NO")
 . I X="Y" K @GREF@(3) K ^(4),^(5) W " -- Deleted!"
 K @GREF@(3) K ^(4),^(5)
 S GLIN=$NA(^DIBT(DIARI))  ; Copy logic to 2006.631 DEF nodes
 S FNOD="DC",TNOD=3,CT=0  ; "DC" data--straight copy
 S T=0 F  S T=$O(@GLIN@(FNOD,T)) Q:T=""  S X=^(T),CT=CT+1,@GREF@(TNOD,T)=X
 S @GREF@(TNOD,0)=CT
 S FNOD="DL",TNOD=4,CT=0  ; "DL" data--copy depends on storage scheme in DIBT:
 ;Zero node null -- straight copy
 ; Else 1) either only one condition is defined;
 ; or, 2) the zero-node condition is ANDed with all defined conditions
 ;  Case 2: Var A -- Pre-pend zero node, then dup zero node
 ;            Var B -- Pre-pend zero node
 S NCOND=+$G(@GLIN@(FNOD))
 I $G(@GLIN@(FNOD,0))]"" S NODE0=^(0) D
 . S T=0 F  S T=$O(@GLIN@(FNOD,T)) Q:T=""  S X=^(T) I X]"" S CT=CT+1,@GREF@(TNOD,CT)=NODE0_X
 . I CT'=NCOND S CT=CT+1,@GREF@(TNOD,CT)=NODE0_$S(CT=1:"",1:"^")
 E  D
 . S T=0 F  S T=$O(@GLIN@(FNOD,T)) Q:T=""  S X=^(T) I X]"" S CT=CT+1,@GREF@(TNOD,CT)=X
 S @GREF@(TNOD,0)=CT
 ; readable text--straight copy
 S TNOD=5,T=0 F  S T=$O(@GLIN@("O",T)) Q:T=""  S @GREF@(TNOD,T)=^(T,0)
 Q
 ;
BLDDEF(LSTID) ; build DEF nodes for Column/Sort defs
 N X,QX,SS,STR,LSTHDR,T,T0,T8,T6,HASCASE,XT,HASDATE,HASNIMG,HASPRIO,HASLOCK,LISTYPE
 N HASASSIG  ;  ISI
 S SS=0,HASCASE=0,HASDATE=0,HASNIMG=0,HASPRIO=0,HASLOCK=0
 S HASASSIG=0  ;  ISI
 S LISTYPE=$P($G(^MAG(2006.631,LSTID,0)),U,3)
 ; columns/hdrs: Order in T array by the Relative Column Order
 F  S SS=$O(^MAG(2006.631,LSTID,1,SS)) D  Q:'SS
 . I 'SS D  Q
 . . I 'HASCASE S X=1 D BLDDEF2(X)  ; Force CASE#
 . . I 'HASDATE S X=7 D BLDDEF2(X)  ; DATE/TIME
 . . I 'HASNIMG S X=9 D BLDDEF2(X)  ; NUMBER IMAGES
 . . I LISTYPE="U" D  ; force below only if for an Unread list  ;  ISI
 . . . I 'HASLOCK S X=2 D BLDDEF2(X)  ; EXAM LOCK IND.  ;  ISI
 . . . I 'HASPRIO S X=5 D BLDDEF2(X)  ; PRIORITY  ;  ISI
 . . I LISTYPE]"",("UAP"[LISTYPE) D  ; force below for Unread/All Active/Pending lists  ;  ISI
 . . . I 'HASASSIG S X=201 D BLDDEF2(X)  ; ASSIGNEE  ;  ISI
 . E  S X=^MAG(2006.631,LSTID,1,SS,0)
 . D BLDDEF2(X)
 ; go thru T to build ordered field sequence for output columns
 S QX="T",STR="",LSTHDR=""
 F  S QX=$Q(@QX) Q:QX=""  S X=@QX D
 . S STR=STR_$S(STR="":"",1:U)_$P(X,U)
 . S LSTHDR=LSTHDR_$S(LSTHDR="":"",1:U)_$P(X,U,2)
 S ^MAG(2006.631,LSTID,"DEF",.5)=LSTHDR,^(1)=STR
 ; Sort values:
 S SS=0,STR=""
 F  S SS=$O(^MAG(2006.631,LSTID,2,SS)) Q:'SS  S X=^(SS,0) D
 . S X=+X_$S($P(X,U,2):"-",1:"")
 . S STR=STR_$S(STR="":"",1:U)_X
 S ^MAG(2006.631,LSTID,"DEF",2)=STR
 S $P(^MAG(2006.631,LSTID,"DEF",0),U)=$$NOW^XLFDT()
 Q
 ;
BLDDEF2(X) ;
 S X=+X_$S($P(X,U,2):";"_+$P(X,U,2),1:"")
 I 'HASCASE S HASCASE=(+X=1)
 I 'HASDATE S HASDATE=(+X=7)
 I 'HASNIMG S HASNIMG=(+X=9)
 I 'HASLOCK S HASLOCK=(+X=2)
 I 'HASPRIO S HASPRIO=(+X=5)
 I 'HASASSIG S HASASSIG=(+X=201)  ; ISI
 S T0=^MAG(2006.63,+X,0),T6=+$P(T0,U,6) S:'T6 T6=99
 S T8=$P(T0,U,8) I T8]"" S T8="~"_T8
 S XT=$S($P(T0,U,3)]"":$P(T0,U,3),1:$P(T0,U,2))_T8
 S $P(XT,"~",3)=+X
 S T(T6,+X)=X_U_XT
 Q
 ;
POSTINST ; Patch installation inits, etc.
 D P120DD ; Patch 120 DD mods
 D BLDALL ; update list definitions  <*> Use any time fields are added
 D ISIPOST1 ;  ISI -- pick up search logic for ASSIGN exam lists
 D BGCSTRT ; re-start background compile
 ; D POST ; install message, etc.
 Q
 ;
BLDALL ; Create "DEF" nodes, Button labels List Def'ns
 ; Updates all lists after s/w update list defs are installed
 N SS,LSTDAT,LSTNUM,BUTTON,LSTTYP
 S SS=0
 F  S SS=$O(^MAG(2006.631,SS)) Q:'SS  S LSTDAT=$G(^(SS,0)) I LSTDAT]"" D
 . S LSTNUM=$P(LSTDAT,U,2),BUTTON=$P(LSTDAT,U,7),LSTTYP=$P(LSTDAT,U,3)
 . I LSTNUM>9799!$P(LSTDAT,U,6) D BLDDEF(SS)  ; ISI: 9799; build DEF nodes for System Lists & any Enabled lists
 . I BUTTON="",(LSTTYP]"") D   ; Create Button Labels if needed
 . . S BUTTON=$S(LSTTYP="U":"Unread #",LSTTYP="R":"Recent #",LSTTYP="A":"All Active #",LSTTYP="P":"Pending #",1:"List #")_LSTNUM
 . . S $P(^MAG(2006.631,SS,0),U,7)=BUTTON
 Q
 ;
 ; ISI begin
ISIPOST1 ; stuff search logic into exam lists for 4 ASSIGN lists
 N SRCH,LSTNUM
 S SRCH("DEF",3,0)=1
 S SRCH("DEF",3,1)="201^'?."" """
 S SRCH("DEF",4,0)=1
 S SRCH("DEF",4,1)="^1^"
 S SRCH("DEF",5,1)="ASSIGNEE NOT NULL"
 F LSTNUM=9800:1:9803 D BLDSRCH(LSTNUM,.SRCH)
 Q
BLDSRCH(LSTNUM,DATA) ; stuff search logic nodes into list entry
 N IEN,NODE
 I $D(DATA)>9,LSTNUM D
 . S IEN=$O(^MAG(2006.631,"C",LSTNUM,""))
 . Q:'IEN
 . S NODE=$NA(^MAG(2006.631,IEN))
 . M @(NODE)=DATA
 Q
 ;
BLDLSNUM(LSTNUM) ; Update list LSTNUM after list defs are installed (added in ISI-P102)
 I +$G(LSTNUM)
 E  Q
 N IEN
 S IEN=$O(^MAG(2006.631,"C",LSTNUM,""))
 Q:'IEN  ; list not defined here
 D BLDDEF(IEN)
 Q
 ;
POST102L ; stuff search logic for MY RECENT EXAMS list (added in ISI-P102)
 N SRCH,LSTNUM
 S LSTNUM=9830
 S SRCH("DEF",3,0)=1
 S SRCH("DEF",3,1)="24^=""Y"""
 S SRCH("DEF",4,0)=1
 S SRCH("DEF",4,1)="^1^"
 S SRCH("DEF",5,1)="INTERP BY LOGON RADIOLOGIST? EQUALS ""Y""^YES"
 D BLDSRCH(LSTNUM,.SRCH)
 Q
 ;
POST106L ; stuff search logic for US READY list (added in ISI-P106)
 N SRCH,LSTNUM
 S LSTNUM=980
 S SRCH("DEF",3,0)=1
 S SRCH("DEF",3,1)="8^[""READY FOR INTERP"""
 S SRCH("DEF",4,0)=1
 S SRCH("DEF",4,1)="^1^"
 S SRCH("DEF",5,1)="STATUS CONTAINS (case-insensitive) ""READY FOR INTERP"""
 D BLDSRCH(LSTNUM,.SRCH)
 Q
 ;
PRE341 ;  Delete "old version" list entries for standard lists
 N DA,DIDEL,DIE,DR,FIL,FILENUM,IEN,LSTID
 S FILENUM=2006.631
 S FIL=$NA(^MAG(FILENUM)),X=""
 F LSTID=9991,9992,9993,9995,9996 S IEN=$O(@FIL@("C",LSTID,"")) I IEN D
 . S DIDEL=FILENUM,DR=".01////@",DIE="^MAG("_FILENUM_",",DA=IEN D ^DIE
 Q
 ;
POST341 ;
 N LSTNUM  ; re-build exam list definition details
 I $$UJOCHECK^ISIJUTL9() D  ; Assign not in VA yet
 . F LSTNUM=9800:1:9803 D BLDLSNUM^MAGJMN1(LSTNUM)
 . D ISIPOST1 ; stuff search logic for ASSIGN lists
 F LSTNUM=9810,9820,9830,9991,9992,9993,9995,9996 D BLDLSNUM^MAGJMN1(LSTNUM)
 D POST102L ; stuff search logic for MY RECENT EXAMS list
 D BGCSTRT ; re-start background compile
 Q
 ;
 ; ISI end
 ;
POST ; Install msg
 ; D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
P120DD ; DD changes for MAG VISTARAD SITE PARAMETERS, deleting deprecated fields
 ;
 W !!,"Deleting deprecated fields from MAG VISTARAD SITE PARAMETERS file ... "
 ; First, delete the field entries
 N I,REC
 S REC=$G(^MAG(2006.69,1,0))
 I REC]"" D
 . F I=6,12,14,15 S $P(REC,U,I)=""
 . S ^MAG(2006.69,1,0)=REC
 ;
 ; Then, delete the field definitions
 S DIK="^DD(2006.69,",DA(1)=2006.69
 F DA=4,5.5,10,11 D ^DIK
 K DIK,DA
 W " done! ",!
 Q
 ;
YN(MSG,DFLT) ; get Yes/No reply
 N X I $G(DFLT)="" S DFLT="N"
 W !
 S DFLT=$E(DFLT),DFLT=$S(DFLT="N":"NO",1:"YES")
YN1 W !,MSG_" "_DFLT_"// "
 R X:DTIME S:X="" X=DFLT S X=$E(X),X=$TR(X,"ynYN","YNYN")
 I "YN"'[X W "  ??? Enter YES or NO",! G YN1
 Q X
 ;
LSTINQ ; Inq/Disp list def'n
 N GREF,MAGIEN
 W !!?15,"Display ISI Rad Exams List Definition",!!
 N MAGIEN
 S DIC=2006.631,DIC(0)="AMEQ"
 D ^DIC I Y=-1 K DIC,DA,DR Q
 K DR S DA=+Y,MAGIEN=DA
 S GREF=$NA(^MAG(2006.631,MAGIEN,"DEF"))
 W ! D EN^DIQ
 R !,"Enter RETURN to display the Search Logic: ",X:DTIME W !
 D DISPSRCH(GREF)
 G LSTINQ
 Q
 ;
DISPSRCH(GREF) ; GREF holds indirect ref for global holding search logic data
 I $D(@GREF@(5,1)) W !,"List Exams where:",! D
 . F I=1:1 Q:'$D(@GREF@(5,I))  W !?3,^(I)
 E  W !?3,"NO Search Logic defined!"
 Q
 ;
VRSIT ;
 W @IOF,!!?10,"Enter/Edit ISI Rad Site Parameters",!!
 S DIC=2006.69,DIC(0)="ALMEQ"
 I '$D(^MAG(DIC,1)) S DLAYGO=DIC
 D ^DIC I Y=-1 K DIC,DA,DR,DIE,DLAYGO Q
 S DIE=2006.69,DA=+Y,DR=".01:20;"
 ; ISI P341--Assign to work only in Jordan until VA/IHS requests it (needs data storage change from file #70)
 I $$UJOCHECK^ISIJUTL9() S DR=DR_"101;"
 S DR=DR_"102;103;106;"
 ; ISI P341--Mgr Rev-2 to work only in Jordan until VA/IHS 
 ;   requests Assign (or we re-jigger Mgr Rev-2); ditto w/hold Exam List Stats
 ; --> Need to re-work hard-coded client Rev-2 Lists per Assign enabled or not
 I $$UJOCHECK^ISIJUTL9() S DR=DR_"105;104;"
 S DR=DR_"107:110" ; ISI Patches 99, ff thru VA341
 D ^DIE
 K DIC,DA,DR,DIE,DLAYGO
 N PLACE S DA=""
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S:PLACE DA=PLACE
 I DA D
 . W !!,"Editing ISI Rad Timeout for division #",DUZ(2),!
 . S DIE=2006.1,DR="123" D ^DIE
 K DA,DR,DIE
 Q
 ;
 ;+++++ OPTION: MAGJ E/E DEFAULT USER PROFILES
 ;
 ; FileMan ^DIE call to enter/edit IMAGING SITE PARAMETERS File (#2006.1),
 ;   fields #202: DEFAULT VISTARAD USERPREF RAD and
 ;          #203: DEFAULT VISTARAD USERPREF NON.
 ; 
 ; These fields point to entries in the MAGJ USER DATA File (#2006.68), and
 ;   allow the ISI Rad client to initialize new ISI Rad users to the settings
 ;   held by the appropriate default user type ("Radiologist", "Non-rad'ist").
 ;
EEPRO ;
 ;
 ;--- Get IEN of IMAGING SITE PARAMETERS File.
 N FIELD,SITEPIEN S SITEPIEN=+$$IMGSIT^MAGJUTL1(DUZ(2),1)
 F FIELD=202,203 D
 . ;
 . ;--- Report field being edited.
 . N PROMPT S PROMPT=$S(FIELD=202:"RADIOLOGIST",FIELD=203:"NON-RADIOLOGIST")
 . W !!,"Editing default "_PROMPT_" profile ...",!
 . N DA,DIE,DR
 . S DIE=2006.1,DR=FIELD,DA=SITEPIEN D ^DIE
 . Q
 Q
EEPREF ;
 W @IOF,!!?10,"Enter/Edit ISI Rad Prefetch Logic",!!
 N MAGIEN
 K DIC S (DIC,DLAYGO)=2006.65,DIC(0)="ALMEQ"
 D ^DIC I Y=-1 K DIC,DIE,DR,DLAYGO Q
 S DIE=2006.65,DA=+Y,DR="[MAGJ PRIOR EDIT]"
 S MAGIEN=DA
 D ^DIE I '$D(DA) G EEPREF
 G EEPREF
 Q
INPREF ; Inquire VRad PreFetch
 W @IOF,!!?10,"Inquire ISI Rad Prefetch Logic",!!
 N MAGIEN,BY,FR,TO
 S DIC=2006.65,DIC(0)="AMEQ"
 D ^DIC I Y=-1 K DIC Q
 S DA=+Y,(FR,TO)=$P(Y,U,2),MAGIEN=DA,L=0
 S BY="[MAGJ PRIOR SORT]",DIS(0)="I D0=MAGIEN"
 D EN^DIP
 R !,"Enter RETURN to continue: ",X:DTIME W !
 G INPREF
 Q
PRPREF ;Print VRad Prefetch
 N BY
 W !! S DIC=2006.65,L=0,BY="[MAGJ PRIOR SORT]"
 D EN1^DIP
 R !,"Enter RETURN to continue: ",X:DTIME W !
 Q
 ;
BGCSTOP ; Stop Background Compile program
 N MAGCSTRT,GO,NTRY,RETRY,X
 S MAGCSTRT=0,GO=1
 S X=$G(^MAG(2006.69,1,0))
 I X]"",+$P(X,U,8) D  ; Background compile switch; skip if already false
 . S ^MAG(2006.69,"BGSTOP")=X ; save current settings for restore later
 . S MAGCSTRT=1
 . S $P(X,U,8)=0
 . S ^MAG(2006.69,1,0)=X  ; disable compile
 . W !!,*7,"Wait for Background Compile program to stop;"
 . W !,"     this might take up to a few minutes."
 . S NTRY=60
 . F I=1:1:NTRY W "." L +^XTMP("MAGJ2","BKGND2","RUN"):3 I  Q  ; process maintains lock while running
 . I  D
 . . L -^XTMP("MAGJ2","BKGND2","RUN")
 . . W !!,"Background Compile Stopped"
 . . I +$G(MAGJKIDS) W "; proceeding with install.",! H 2
 . E  D
 . . S X=$$YN("Background Compile NOT Stopped -- Try again?","Y")
 . . S RETRY=("Y"[X),GO=0
 . . S ^MAG(2006.69,1,0)=^MAG(2006.69,"BGSTOP") K ^MAG(2006.69,"BGSTOP")
 I 'GO G BGCSTOP:RETRY
 I 'GO,+$G(MAGJKIDS) W !!,*7," * * * Exiting out of patch installation * * * ",! H 3 S XPDQUIT=1
 Q
BGCSTRT ; re-enable Background Compile
 I $D(^MAG(2006.69,"BGSTOP")) S X=^("BGSTOP") W " ... Enabling background compile ."
 E  Q
 S ^MAG(2006.69,1,0)=X
 K ^MAG(2006.69,"BGSTOP")
 W !!,"Background Compile Enabled.",! H 3
 Q
 ;
END ;
