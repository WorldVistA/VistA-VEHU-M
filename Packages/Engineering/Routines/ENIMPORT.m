ENIMPORT ;BAH/MKN -Import Equipment Records from a tab-delimited file ; 12/19/2023@15:46:29
 ;;7.0;ENGINEERING;**105**;Aug 17, 1993;Build 20
 ;
 ; Reference to DD^%DT supported by #10003
 ; Reference to FIND^DIC supported by IA #2051
 ; Reference to ^DID supported by #2052
 ; Reference to FILE^DIE supported by #2053
 ; Reference to WP^DIE supported by #2053
 ; Reference to ^DIK supported by #10013
 ; Reference to ^DIR supported by #10026
 ; Reference to ^VA(200 supported by #10060
 ; Reference to $$FMTE^XLFDT,$$FMADD^XLFDT,$$NOW^XLFDT supported by #10103
 ; Reference to OWNSKEY^XUSRB() supported by #3277
 ;
EN ;
 N %DT,DIE,DR,DTOUT,ENABORT,ENBAD,ENBADIND,ENCHKFI,ENCOL,ENDASH,ENDATA,ENDATI,ENDID,ENERR
 N ENERRCT,ENERRL,ENERRPRE,ENFDA,ENFILE,ENFLD,ENFLDLTH,ENFLDNA,ENFLDS,ENFNAMES,ENGOOD
 N ENHARD,ENHD,ENIENS,ENLI,ENMAXROW,ENNA,ENNXL,ENOUT,ENPARM,ENPATH,ENQUOT,ENRBNA,ENRECSET
 N ENRES,ENROWS,ENRUNTYPE,ENSERIAL,ENSET,ENT,ENXTMPNA,ENUSER,ENVAL,ENVFILE,ENVFLD,ENVNAME
 N ENVPTR,ENVREQ,ENVSPEC,ENVTYPE,ENWP,ENWP1,ENX,ENXTMP,ENY,X,Y,ZTQUEUED
 ;
 S (ENABORT,ENCHKFI)=0,ENQUOT=$C(34)
 ;
 ;Check if user has security key authorizing use of this utility
 D OWNSKEY^XUSRB(.ENX,"ENIMPORT",DUZ)
 I ENX(0)=0 W !!,"*** You do not own the Security Key to access this utility ***",!! Q
 S ENX=$$FMTE^XLFDT(DT,7)
 S $P(ENX,"/",2)=$E("00",1,2-$L($P(ENX,"/",2)))_$P(ENX,"/",2)
 S $P(ENX,"/",3)=$E("00",1,2-$L($P(ENX,"/",3)))_$P(ENX,"/",3)
 S ENDATI=$TR(ENX,"/")_"@"_$P($$NOW^XLFDT,".",2)
 ;
 S ENRUNTYPE=$$ASKUSER() Q:ENRUNTYPE="^"
 ;
 I $P(ENRUNTYPE,U)="ROLLBACK" D ROLLBACK Q
 S ENPATH=$P(ENRUNTYPE,U,2),ENFILE=$P(ENRUNTYPE,U,3),ENMAXROW=$P(ENRUNTYPE,U,4),ENRUNTYPE=$P(ENRUNTYPE,U)
 S:ENMAXROW="" ENMAXROW=9999999
 ;
 S ENNA=$NA(^XTMP("EN-IMPORT-"_ENDATI)),ENXTMP=$NA(^XTMP("EN-IMPORT-"_ENDATI,1)) K @ENNA
 S ENRBNA=$NA(^XTMP("EN-IMPORT-"_ENDATI_"-RB")) K @ENRBNA
 S ENUSER=$P(^VA(200,DUZ,0),U)
 S %DT="T",Y=$$NOW^XLFDT() D DD^%DT
 S ENXTMPNA=ENUSER_": "_Y_" -- EN Equipment file # 6914 - imported data"
 S @ENNA@(0)=$$FMADD^XLFDT(DT,90)_U_DT_U_ENXTMPNA
 I ENRUNTYPE="IMPORT" D
 . S ENCHKFI=1,ENRUNTYPE="CHECKFILE" ;If IMPORT - make sure all error free first
 . ;Display current LAST record in file #6914
 I ENRUNTYPE="CHECKFILE"!(ENRUNTYPE="IMPORT") D  G:ENRUNTYPE="^" EN
 . S ENX=0,Y=1
 . I ENRUNTYPE="IMPORT" D  Q:ENRUNTYPE="^"
 .. W !!,"The log file for this run will be: ",!,ENXTMPNA,!,"Please make a note of this, you may need it for a rollback."
 .. S DIR(0)="Y",DIR("B")="YES",DIR("A")="Continue?" D ^DIR I 'Y S ENRUNTYPE="^" Q
 .. W !,"Last record in the EQUIPMENT INV. file is: ",$O(^ENG(6914,"@"),-1)
 . ;The following file load will be executed for both CHECKING and IMPORT
 . W !!,"Loading tab-delimited file into VistA log file from ",ENPATH,ENFILE,"..."
 . S ENX=$$FTG^%ZISH(ENPATH,ENFILE,ENXTMP,2) ;Create XTMP file from input file
 . I 'ENX W !!!,"********* Unable to read file - please check file path and name **********",!! S ENRUNTYPE="^",Y=0 Q
 ;
 W ! S DIR(0)="Y",DIR("A")="Start LOGGING your screen now, and accept if you are ready to continue",DIR("B")="YES"
 D ^DIR G:Y=0!($D(DUOUT))!($D(DTOUT)) EN W !
 W !,"Log file for this run is: "_ENXTMP," ",$P(@ENNA@(0),U,3),!
 S ENFLDS=$$GETOVF(ENNA,3),ENERRCT=0
 K ENERRL,ENFNAMES
 ;
 ;Load fields from FLDS list at bottom
 F ENLI=1:1 S ENX=$T(FLDS+ENLI) Q:ENX=" ;//"  D
 . S ENCOL=$P(ENX," "),ENY=$$UP($P(ENX,";",2))
 . S:ENY'="IGNORE" ENFNAMES(ENY)=$P(ENX,";",3,99),$P(ENFNAMES(ENY),";",10)=ENCOL
 ;
 S ENHD=$$UP($$GETOVF(ENNA,1))
REENTER ;this entry point is for IMPORT after CHECKING for error free file
 S ENLI=3,(ENABORT,ENBAD,ENGOOD,ENRECSET,ENROWS)=0 ;Data starts at line 3
 F  S ENLI=$O(@ENNA@(ENLI)) Q:(ENLI="")!(ENABORT)  Q:$P(ENRUNTYPE,U)="CHECKING"&(ENROWS'<ENMAXROW)  D
 . S ENX=$$GETOVF(ENNA,ENLI) I $P(ENX,$C(9))="END" S ENABORT=1 Q
 . S ENROWS=ENROWS+1
 . W:'(ENROWS#10) !,ENRUNTYPE," - Now on row #",ENLI
 . K ENERR,ENFDA,ENWP S ENBADIND=0
 . I ENX]"" F ENFLD=1:1:$L(ENX,$C(9)) D
 .. S ENDATA=$P(ENX,$C(9),ENFLD)
 .. Q:ENDATA=""
 .. S ENDATA=$TR(ENDATA,ENQUOT),ENDATA=$$TRIM^XLFSTR(ENDATA),ENDATA=$$UP(ENDATA)
 .. S ENFLDNA=$P(ENHD,$C(9),ENFLD),ENPARM=$G(ENFNAMES(ENFLDNA))
 .. S ENVNAME=$P(ENPARM,";",1),ENVFILE=$P(ENPARM,";",2),ENVFLD=$P(ENPARM,";",3) Q:ENVFILE'?1.N.".".N
 .. S ENVPTR=$P(ENPARM,";",4),ENVTYPE=$P(ENPARM,";",5),ENHARD=$P(ENPARM,";",6),ENVAL=$P(ENPARM,";",7)
 .. S ENCOL=$$GETCOL(ENFLD)
 .. K ENDID D FIELD^DID(ENVFILE,ENVFLD,"","*","ENDID")
 .. S ENFLDLTH=$G(ENDID("FIELD LENGTH")) S:ENFLDLTH="" ENFLDLTH=999
 .. S ENVSPEC=$G(ENDID("SPECIFIER"))
 .. I ENVTYPE="AUTO" Q
 .. I ENDATA["^" D  Q
 ... S ENBADIND=1
 ... S ENERR=" - data contains a ""^"" character"
 ... S ENERRTYP="Validation Failed"
 ... S ENERRCT=ENERRCT+1 D ERRMSG("VALIDATION FAILURE",ENVNAME,ENERRTYP,ENERR)
 .. I ENVAL]"" S ENRES="" D @ENVAL I ENRES]"" D  S ENBADIND=1 Q
 ... S ENERR=" - "_ENRES,ENERRTYP="Validation Failed",ENERRCT=ENERRCT+1
 ... D ERRMSG("VALIDATION FAILURE",ENVNAME,ENERRTYP,ENERR)
 .. I ENVSPEC?1"R".E,ENDATA="" D  Q
 ... S ENBADIND=1
 ... S ENERR=" - missing required field in file #"_ENVFILE_" ("_ENVFILNA_" ) field #"_ENVFLD
 ... S ENERR=ENERR_" ("_ENVFLDNA_")"
 ... S ENERRTYP="Missing required field in file"
 ... S ENERRCT=ENERRCT+1 D ERRMSG("MISSING DATA",ENVNAME,ENERRTYP,ENERR)
 .. I ENVPTR?1"P"1N.N.".".N.E!(ENVPTR?1"RP"1N.N.".".N.E) D  Q:ENBADIND
 ... S ENRES=$$CHKPTR() S:'ENRES ENBADIND=1
 .. I ENVTYPE="SET" S ENRES=$$CHKSET() I ENRES S ENBADIND=1 Q
 .. ;If field is regular data field, not pointer or SET, check length of data
 .. I ENVTYPE'="SET",ENVPTR="",$L(ENDATA)>ENFLDLTH D  Q
 ... S ENERRTYP="Data exceeds maximum length for field"
 ... S ENERR=" - ["_ENDATA_"] is "_$L(ENDATA)_" chs long and exceeds the maximum length"
 ... S ENERR=ENERR_" for INVENTORY INV. file (#6914) field "_ENVNAME_" (#"_ENVFLD_") which is "_ENFLDLTH_" chs"
 ... S ENERRCT=ENERRCT+1 D ERRMSG("DATA TOO LONG",ENVNAME,ENERRTYP,ENERR)
 ... S ENBADIND=1
 .. I ENVPTR="" D ENVFDA
 .. I ENVSPEC?."*"1"P"1.N.N.".".N.E!(ENVSPEC?1"RP"1.N.N.".".N.E) D ENVPTR Q
 .. I ENVTYPE="WP" S ENWP(6914,ENVFLD,1,0)=ENDATA
 .. Q:ENRUNTYPE="CHECKFILE"
 . ;End Of row
 . I 'ENBADIND D SETGOOD
 . I ENBADIND S ENBAD=ENBAD+1
 . Q:ENRUNTYPE="CHECKFILE"
 . ;Now file if entries in ENFDA
 . Q:'$D(ENFDA)
 . S ZTQUEUED=1 ;This supresses the "Setting up new record" mesasge in ENR^ENEQ1
 . D ENR^ENEQ1 ;File stub for next recrd in 6914 (with lock)
 . I 'ENNXL W !,"Row # ",ENLI," Error while filing new Equipment Inventory record "_$G(ENERR) S DIR(0)="E" D ^DIR K DIR,ENERR Q
 . ; lock new record
 . L +^ENG(6914,ENNXL):1 I '$T D   Q
 .. W !!,"Row # ",ENLI," Error - another user is editing Entry # ",ENNXL Q
 . ; populate serial #
 . I $G(ENSERIAL)]"" S DIE="^ENG(6914,",DR="5////"_ENSERIAL,DA=ENNXL D ^DIE
 . ;ENNXL is the new IEN in file #6914. Now change the FDA
 . M ENFDA(6914,ENNXL_",")=ENFDA(6914,"+1,") K ENFDA(6914,"+1,")
 . K ENERR D FILE^DIE("","ENFDA","ENERR")
 . I $D(ENERR) W !,"Row # ",ENLI," - error on filing - aborting run.",! S ENABORT=1 Q
 . S ENRECSET=ENRECSET+1,@ENRBNA@(ENRECSET)=ENNXL
 . I $D(ENWP(6914)) D
 .. S ENWP1="" F  S ENWP1=$O(ENWP(6914,ENWP1)) Q:ENWP1=""  D
 ... K ENERR D WP^DIE(6914,ENNXL_",",ENWP1,"K","ENWP(6914,"_ENWP1_")","ENERR")
 ... I $D(ENERR) W !,"Row # ",ENLI," - error on filing - aborting run.",! S ENABORT=1 Q
 . ; unlock entry
 . L -^ENG(6914,ENNXL)
 S ENDASH="",$P(ENDASH,"-",61)=""
 I ENCHKFI,'ENBAD S $P(ENRUNTYPE,U)="IMPORT",ENCHKFI=0 G REENTER
 ;
 I $D(ENERRL) W !!,ENDASH,!,"Summary of error types:",! S ENT=0 D  W !,ENDASH,!
 . S ENI="" F  S ENI=$O(ENERRL(ENI)) Q:ENI=""  S ENT=ENT+1 W !?5,ENT,". ",ENI,": ",ENERRL(ENI)
 W !,"#ERROR RECORDS: ",ENBAD,!,"#GOOD RECORDS : ",ENGOOD,"   ",!,"Last record in the EQUIPMENT INV. file is: ",$O(^ENG(6914,"@"),-1)
 I $P(ENRUNTYPE,U)="CHECKFILE",'$D(ENERRL) D ENDLOG Q
 I $P(ENRUNTYPE,U)="CHECKFILE",$D(ENERRL),ENCHKFI W !!,"**** ERRORS FOUND **** - no updates made",! D:ENGOOD>0 GOODRECS("B") D ENDLOG Q
 I $P(ENRUNTYPE,U)="IMPORT" D
 . I ENRECSET>0 W !!,ENRECSET," record",$S(ENRECSET>1:"s were",1:" was")," added to the EQUIPMENT INV file (#6914)"
 . I ENRECSET=0 W !!,"No records were added to the EQUIPMENT INV file (#6914)"
 D ENDLOG
 Q
 ;
ENDLOG ;
 W !!,"End the LOGGING to your screen now then press Enter" R " ",ENX:20
 Q
 ;
SETGOOD ;
 ;Update count for good records found, even though there may be errors
 ;On the Import run, it first checks for any bad records anywhere in the file. If any at all
 ;are found, it will not update ANY records. It does this by setting the run type to CHECKFILE
 ;first. If there are no errors, it will then change the run type to IMPORT, and drop through
 ;the "Q:ENRUNTYPE="CHECKFILE"" command at appx. line 82
 S ENGOOD=ENGOOD+1
 Q
 ;
GOODRECS(ENWH) ;
 I $G(ENWH)="A" W !,ENGOOD_" good record",$S(ENGOOD>1:"s",1:"")," found.",! Q
 I $G(ENWH)="B" W "but ",ENGOOD_" good record",$S(ENGOOD>1:"s",1:"")," found.",!
 Q
 ;
ENVFDA ;Set entry into ENFDA array for this file and field
 N ENDA,ENI,ENX,X
 I ENVTYPE="" S ENFDA(ENVFILE,"+1,",ENVFLD)=ENDATA Q
 I ENVTYPE="DA" D  Q
 . S X="" D DT^DILF("",ENDATA,.X)
 . S ENFDA(ENVFILE,"+1,",ENVFLD)=X
 I ENVTYPE="SET" D  Q
 . S ENDATA=$$UP(ENDATA)
 . I ENHARD'="" S ENDATA=ENHARD ;Hardcoded value
 . D FIELD^DID(ENVFILE,ENVFLD,"","POINTER","ENOUT")
 . S ENSET=$G(ENOUT("POINTER"))
 . F ENI=1:1:$L(ENSET,";") S ENX=$P(ENSET,";",ENI) D
 .. I $P(ENX,":",2)=ENDATA S ENFDA(ENVFILE,"+1,",ENVFLD)=$P(ENX,":")
 Q
 ;
CHKPTR() ;Check if the field is a good pointer to the file
 N ENERR,ENFLDLTH,ENIEN,ENOUT,ERR,ENVFILNA,ENVFLDNA,ENVPFILE
 S ENIEN=0
 S ENDATA=$$UP(ENDATA),ENVPFILE=$P(ENVPTR,"P",2)
 S ENFLDLTH=$$GET1^DID(ENVPFILE,.01,"","FIELD LENGTH")
 K ENOUT D FILE^DID(ENVPFILE,"","NAME","ENOUT")
 S ENVFILNA=$G(ENOUT("NAME")) S:ENVFILNA="" ENVFILNA="File Name not found in DD"
 I $L(ENDATA)>ENFLDLTH D  Q 0
 . S ENERRTYP="Data exceeds maximum length for field"
 . S ENERR=" - ["_ENDATA_"] is "_$L(ENDATA)_" chs long and exceeds the maximum length for POINTER to "_ENVFILNA_" file (#"_ENVPFILE_")"
 . S ENERRCT=ENERRCT+1 D ERRMSG("DATA TOO LONG",ENVNAME,ENERRTYP,ENERR)
 K ENOUT,ENERR D FIND^DIC(ENVPFILE,"","","",ENDATA,"","B","","","ENOUT","ENERR")
 S ENIEN=+$G(ENOUT("DILIST",2,1))
 I 'ENIEN!($D(ERR("DIERR"))) D  Q 0
 . S ENVFLDNA=$$GET1^DID(ENVPFILE,ENVFLD,"","LABEL")
 . S ENERR=" - "_ENQUOT_ENDATA_ENQUOT_" not found in "_ENVFILNA_" file (#"_ENVPFILE_")"
 . S ENERRTYP="Missing entries in POINTED-TO file"
 . S ENERRCT=ENERRCT+1,ENRES=1 D ERRMSG("MISSING DATA",ENVNAME,ENERRTYP,ENERR)
 Q ENIEN
 ;
ENVPTR ;Data is a pointer to another file
 N ENTFILE,ENERR,ENOUT,ENX
 S ENTFILE=$P(ENVPTR,"P",2),ENDATA=$$UP(ENDATA)
 ;Check if entry exists in pointed-to file
 K ENOUT,ENERR D FIND^DIC(ENTFILE,"","","",ENDATA,"","B","","","ENOUT","ENERR")
 S ENX=+$G(ENOUT("DILIST",2,1))
 I ENX S ENFDA(ENVFILE,"+1,",ENVFLD)=ENX Q
 Q
 ;
GETCOL(ENI) ;
 N EN1,EN2
 I ENI<27 Q $C(ENI+64)
 S EN1=ENI-1\26,EN2=ENI-1#26+1
 Q $C(EN1+64)_$C(EN2+64)
 ;
ROLLBACK ;
 ;How many days to go back?
 N DA,DIK,ENDA,ENFN,ENI,ENL,ENN,ENX
 K DIR S DIR(0)="N^0:90:3",DIR("A")="How many days back (0=Today only)",DIR("B")=0 D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 I Y=0 S ENDA=DT
 E  S ENDA=$$FMADD^XLFDT(DT,"-"_Y)
 S ENX=$$FMTE^XLFDT(ENDA,7) F ENI=2,3 S $P(ENX,"/",ENI)=$E("00",1,2-$L($P(ENX,"/",ENI)))_$P(ENX,"/",ENI)
 S ENFN="EN-IMPORT-"_$TR(ENX,"/"),ENN=0
 F  S ENFN=$O(^XTMP(ENFN)) Q:ENFN=""!(ENFN'?1"EN-IMPORT-".E)  D
 . S ENX=$G(^XTMP(ENFN,0)) Q:ENX=""
 . S ENN=ENN+1,ENL(ENN)=ENFN
 . W !,ENN,". ",$P(ENX,U,3)
 I ENN=1 D  Q:$D(DUOUT)!($D(DTOUT))
 . W !! K DIR S DIR(0)="Y",DIR("A")="Is this the file you need",DIR("B")="YES" D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 . I Y=1 S ENFN=ENL(1)
 I ENN>1 D  Q:$D(DUOUT)!($D(DTOUT))
 . W ! K DIR S DIR(0)="N^1:"_ENN D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 . S ENFN=ENL(ENN)
 . S ENX=$G(^XTMP(ENFN,0)) W !!,$P(ENX,U,3) S DIR(0)="Y",DIR("B")="YES",DIR("A")="Please confirm" D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 . Q:'Y
 W ! S DIR(0)="Y",DIR("A")="Start LOGGING your screen now, and accept if you are ready to continue",DIR("B")="YES"
 D ^DIR G:Y=0!($D(DUOUT))!($D(DTOUT)) ROLLBACK W !
 S ENFN=ENFN_"-RB",ENN="",DIK="^ENG(6914,"
 F  S ENN=$O(^XTMP(ENFN,ENN)) Q:ENN=""  S DA=^XTMP(ENFN,ENN),ENX=$P($G(^ENG(6914,DA,0)),U,2) I ENX]"" D ^DIK W !,"IEN ",DA,"  ",ENX," removed"
 D ENDLOG
 Q
 ;
ASKUSER() ;
 N ANS,DIR
ASKTYPE ;
 S DIR(0)="S^C:Check the input file for errors;I:Import the input file;R:Roll back an import"
 S DIR("B")="C" D ^DIR
 I $D(DUOUT)!($D(DTOUT)) S ENRUNTYPE="^" Q "^"
 S ANS=Y
 S ENRUNTYPE=$S(Y="C":"CHECKFILE",Y="I":"IMPORT",1:"ROLLBACK")
ASKFPATH ;
 I ANS="R" Q "ROLLBACK"
 K DIR S DIR(0)="FU^3:60",DIR("A")="Enter PATH to file ex:  /home/myfolder/"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) ASKTYPE
 S ENPATH=Y S:$E(ENPATH,$L(ENPATH))'="/" ENPATH=ENPATH_"/"
 S $P(ENRUNTYPE,U,2)=ENPATH
ASKFNAME ;
 K DIR S DIR(0)="FU^3:60",DIR("A")="Enter FILE NAME ex:  New_Equip.txt  "
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) ASKFPATH
 S $P(ENRUNTYPE,U,3)=Y
ASKNUMREC ;
 K DUOUT,DROUT
 S Y=""
 I $P(ENRUNTYPE,U)="CHECKFILE" K DIR S DIR(0)="NO^1:999999",DIR("A")="Number of rows/records to process (Skip for complete file)" D ^DIR
 G:$D(DUOUT)!($D(DTOUT)) ASKFNAME
 S ENMAXROW=$S(Y="":"999999",1:Y)
 S $P(ENRUNTYPE,U,4)=ENMAXROW
 Q ENRUNTYPE
 ;
CHKSET() ;Check if entry is valid for the set
 N ENERR,ENFLDNAM,ENI,ENRES,ENSET,ENX
 S ENRES=0,ENDATA=$$UP(ENDATA)
 S ENSET=$$GET1^DID(ENVFILE,ENVFLD,"","POINTER")
 S ENFLDNAM=$$GET1^DID(ENVFILE,ENVFLD,"","LABEL")
 S ENERR=" SET field ["_ENFLDNAM_"] does not contain "_ENQUOT_ENDATA_ENQUOT_". File #6914, "_ENFLDNAM_" (#"_ENVFLD_")"
 F ENI=1:1:$L(ENSET,";") Q:ENERR=""  S ENX=$P(ENSET,";",ENI) Q:ENX=""  D
 . I $P(ENX,":",2)=ENDATA S ENERR=""
 I ENERR]"" D
 . S ENERRTYP="SET field does not contain field value"
 . S ENERRCT=ENERRCT+1,ENRES=1 D ERRMSG("MISSING SET",ENVNAME,ENERRTYP," - "_ENERR)
 Q ENRES
 ;
ERRMSG(ENERRPRE,ENVNAME,ENERRTYP,ENERR) ;Output error message
 W !,"Err# "_ENERRCT_" Row: ",ENLI," Col: ",ENQUOT,ENCOL,ENQUOT," (",ENVNAME,") ",ENERRPRE," ",ENERR
 S ENERRL(ENERRTYP)=$G(ENERRL(ENERRTYP))+1
 Q
 ;
GETOVF(ENNA,ENN) ;Consolidate line to include "OVF" (Overflows)
 N ENI,ENOUT,ENX
 S ENOUT=$G(@ENNA@(ENN)) Q:ENOUT="" ""
 F ENI=1:1 S ENX=$G(@ENNA@(ENN,"OVF",ENI)) Q:ENX=""  S ENOUT=ENOUT_ENX
 Q ENOUT
 ;
VALDA ;
 N ENR
 S ENRES="" Q:$G(ENDATA)=""
 D DT^DILF("",ENDATA,.ENR)
 I ENR=-1 S ENRES=ENDATA_" is an invalid date"
 Q
 ;
VALLCLID ;
 S ENRES=""
 Q  ;Disabled 1/20/24 per user. DO not check for duplicate.
 I $G(ENDATA)]"",$D(^ENG(6914,"L",ENDATA)) S ENRES="LOCAL ID "_ENDATA_" is already in use"
 Q
 ;
VALSN ;
 S ENRES=""
 Q  ;Disabled 1/20/24 per user. Do not check for duplicates.
 I $G(ENDATA)]"",$D(^ENG(6914,"F",ENDATA)) S ENRES="Serial number "_ENDATA_" already in use"
 Q
 ;
VALMAX ;maximum value 9999999 cols L and M
 S ENRES="" Q:ENDATA'?1.N.".".N
 I ENDATA>9999999 S ENRES=ENDATA_" maximum value of 9,999,999 exceeded"
 Q
 ;
VALPARNT ;
 S ENRES="" Q:ENDATA'?1.N
 I '$D(^ENG(6914,ENDATA)) S ENRES=ENDATA_" Parent record does not exist in file #6914"
 Q
 ;
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
FLDEXP ;The following lines are the ";" pieces in the list at label FLDS
 ;1=Fld name in XL
 ;2=VistA Fld Name
 ;3=VistA file #
 ;4=VistA field #
 ;5=P-VistA file pointed to
 ;6="AUTO" if automatically created on filing,   OR "SET", OR "DA"
 ;7=Hardcoded value if any
 ;8=Validation Code
 ;9=Comments
 ;
FLDS ;There are 37 columns in the input spreadsheet as follows:
A ;MANUFACTURER;MANUFACTURER;6914;1;RP6912
B ;SERIAL #;SERIAL #;6914;5;;;;VALSN
C ;MODEL;MODEL;6914;4
D ;CATEGORY STOCK NUMBER;CATEGORY STOCK NUMBER;6914;18;P6917
E ;IGNORE;LIFE EXPECTANCY;6914;15;;AUTO;;;Triggered by CSN field COl D
F ;MFGR. EQUIPMENT NAME;MFGR. EQUIPMENT NAME;6914;3
G ;CMR;CMR;6914;19;P6914.1
H ;EQUIPMENT CATEGORY;EQUIPMENT CATEGORY;6914;6;P6911
I ;IGNORE;ADDITIONAL INFORMATION
J ;PURCHASE ORDER #;PURCHASE ORDER #;6914;11
K ;ACQUISITION METHOD;ACQUISITION METHOD;6914;20.1;;SET
L ;IGNORE;VENDOR POINTER;6914;10;P440;AUTO;;;Triggered by Purchase Order # field Col J
M ;LEASE COST;LEASE COST;6914;12.5;;;;VALMAX
N ;TOTAL ASSET VALUE;TOTAL ASSET VALUE;6914;12;;;;VALMAX
O ;ACQUISITION DATE;ACQUISITION DATE;6914;13;;DA;;VALDA
P ;WARRANTY EXP. DATE;WARRANTY EXP. DATE;6914;14;;DA;;VALDA
Q ;IGNORE;REPLACEMENT DATE;6914;16;;AUTO;;;Triggered by CSN field Col D
R ;ACQUISITION SOURCE;ACQUISITION SOURCE;6914;13.5;P420.8
S ;TYPE OF ENTRY;TYPE OF ENTRY;6914;7;;SET
T ;USE STATUS;USE STATUS;6914;20;;SET
U ;PARENT SYSTEM;PARENT SYSTEM;6914;2;P6914;;;VALPARNT
V ;IGNORE;SERVICE POINTER;6914;21;P49;AUTO;;;;Triggered by CMR field Col G
W ;IGNORE;Location of item;Col X on spreadsheet is used
X ;LOCATION;LOCATION;6914;24;P6928;;;;
Y ;LOCAL IDENTIFIER;LOCAL IDENTIFIER;6914;26;;;;VALLCLID
Z ;STATION NUMBER;STATION NUMBER;6914;60;;;;;See OWNING STATION NUMBER on screen 1
AA ;CONTROLLED ITEM?;CONTROLLED ITEM?;6914;33;;SET
AB ;INVESTMENT CATEGORY;INVESTMENT CATEGORY;6914;34;;SET
AC ;FUND;FUND;6914;62;P6914.6P
AD ;FUND CONTROL POINT;FUND CONTROL POINT;6914;35;
AE ;BUDGET OBJECT CODE;BUDGET OBJECT CODE;6914;61;P6914.4
AF ;IGNORE;STANDARD GENERAL LEDGER;6914;38;P6914.3;AUTO;;;Triggered by BOC field
AG ;ADMINSTRATIVE OFFICE;ADMINSTRATIVE OFFICE;6914;63;P6914.7;;10
AH ;EQUITY ACCOUNT;EQUITY ACCOUNT;6914;64;;SET
AI ;IGNORE;ASSET TAG #
AJ ;IGNORE;MACHINE TYPE
AK ;COMMENTS;COMMENTS;6914;40;;WP
 ;//
 ;
