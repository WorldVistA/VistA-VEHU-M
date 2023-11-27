ORACCESS ;SLC/AGP - User Read/Write Access to CPRS ; Apr 20, 2023@17:48
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**588**;Dec 17, 1997;Build 29
 ;
 ; Direct reads of PARAMETERS File (#8989.5) - IA #2686
 ; Direct reads of PARAMETER DEFINITION File (#8989.51) - IA #2685
 ; Reference to CRNRSITE^VAFCCRNR in ICR #7346
 ;
 Q
 ;
PROMPT(USER) ;
 N DIR,Y
 S DIR(0)="S^A:Copy/Add settings;O:Copy/Overwrite settings;S:Skip User"
 S DIR("A")="Select copy access for "_USER
 S DIR("?")="Select the copy action, enter ?? for more information"
 S DIR("??")=U_"D HELP^ORACCESS"
 D ^DIR
 Q Y
 ;
ASKYN(DEF,TEXT,RTN,HLP) ;
 N DIR,X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y0"
 S DIR("A")=TEXT
 S DIR("B")=DEF
 S DIR("?")="Enter Y or N."
 I $G(RTN)'="",$G(HLP)'="" D
 . S DIR("?")="Enter Y or N. For detailed help type ??"
 . S DIR("??")=U_"D HELP^"_RTN_"(HLP)"
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S Y=0
 Q Y
 ;
ACCESS(RESULTS,USER,GETNOTES,NOTES) ;
 D ACCESS^ORACCES2(.RESULTS,$G(USER),$G(GETNOTES),.NOTES)
 Q
 ;
GETNOTES(ORY,USER) ;
 N TEMP
 D ACCESS^ORACCES2(.TEMP,USER,2,.ORY)
 Q
 ;
CHECK(IEN,NAME) ;
 N ACT,ARRAY,CARRAY,HASDATA,RESULT,YN
 S HASDATA=0,RESULT="O"
 D DATA(.ARRAY,TABS,IEN)
 I $D(ARRAY) S HASDATA=1
 I HASDATA=0 D
 .D DATA(.ARRAY,OTHER,IEN)
 .I $D(ARRAY) S HASDATA=1
 I HASDATA=0 D
 .D DATA(.ARRAY,ORDERS,IEN)
 .I $D(ARRAY) S HASDATA=1
 I HASDATA=1 D
 .W !,NAME_" has settings already defined",!
 .D DISPLAY^ORACCES3(IEN,.CARRAY)
 .W !
 .S ACT=$$PROMPT(NAME)
 .I ACT=-1!(ACT="S") S RESULT="S" Q
 .S RESULT=ACT
 .;S YN=$$ASKYN("N","Replace "_NAME_" settings")
 .;I YN'=1 S RESULT=0 W !,"Settings not copied over!"
 Q RESULT
 ;
COPY ;
 N ACT,CARRAY,IEN,INITIAL,NAME,TEXT,UARRAY,YN,CRLF
 N ORPARAM,ORTABS,ORPIEN,TABS,OTHER,ORDERS,ERROR
 D GETPARAMS(1) S CRLF=$C(13,10)
 S TEXT=CRLF_"Only users with write access settings are selectable."_CRLF
 S TEXT=TEXT_"May take a few seconds to display a list of users."_CRLF
 S TEXT=TEXT_"Select user to copy from: "
 S INITIAL=$$SELECT(TEXT,1)
 I INITIAL=-1 Q
 W !
 D DISPLAY^ORACCES3(+INITIAL,.CARRAY)
 W !
 S YN=$$ASKYN("N","Copy "_$P(INITIAL,U,2)_" settings")
 Q:$D(DTOUT)  G:$D(DUOUT) COPY
 I 'YN Q
 W !
 D GETUSER(.UARRAY)
 I '$D(UARRAY) W !,"   No user selected" Q
 S IEN=0 F  S IEN=$O(UARRAY(IEN)) Q:IEN'>0  D
 .S NAME=UARRAY(IEN)
 .S ACT=$$CHECK(IEN,NAME)
 .I ACT'="O",ACT'="A" Q
 .D SETUSER(IEN,NAME,INITIAL,ACT,.CARRAY)
 Q
 ;
CLEAR ;
 N DA,DIR,DA,DIC,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DLAYGO,DINUM,USERLEVEL,LVLTXT,DONE
 N ENT,ENT2,ORENT,ORCNT,LVLPREFIX,IEN,NAME,LVLNAME,USR,DIV,IDX,ORERR,TXT,CRLF
 N ORPARAM,ORTABS,ORPIEN,TABS,OTHER,ORDERS,ERROR,DSPLVL,DSPNAME
 D GETPARAMS(1)
 S CRLF=$C(13,10)
 S DONE=0 F  D  Q:DONE
 . K DA,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 . S DIR(0)="SO^S:System;D:Division;U:User"
 . S DIR("A")="Remove Settings for System, Division or User?"
 . D ^DIR I $D(DIRUT) S DONE=1 Q
 . I $G(Y)="S" D  S DONE=1 Q
 . . S DSPLVL=2 D GETINST(DSPLVL,"",.DSPNAME)
 . . W !!!,"Current settings for System "_DSPNAME_":",!
 . . D DISPLAY^ORACCES3(0,"",0,0,DSPLVL,DSPNAME)
 . . S TXT="All settings will be removed and CPRS Write Access for"_CRLF
 . . S TXT=TXT_"the system will revert to package level settings."_CRLF
 . . S TXT=TXT_"Are you sure you want to remove all system level settings"
 . . I $$ASKYN("N",TXT) D  I 1
 . . . D CLEARSYS
 . . . W !!,"*** System level settings removed ***",!!
 . . E  W !!,"System level settings not removed.",!!
 . S USERLEVEL=$S($G(Y)="U":1,$G(Y)="D":0,1:-1),LVLTXT=$$LOW^XLFSTR($G(Y(0)))
 . I USERLEVEL<0 S DONE=1 Q
 . I USERLEVEL S ENT="VA(200,",LVLPREFIX="USR",ORCNT=3
 . E  S ENT="DIC(4,",LVLPREFIX="DIV",ORCNT=4
 . S ORENT=";"_ENT,ENT2=LVLPREFIX_".`"
 . F  D  Q:DONE
 . . K DIC,X,Y,DTOUT,DUOUT
 . . S DIC=U_ENT
 . . S DIC("A")=CRLF_"Only "_LVLTXT_"s with write access settings are selectable."_CRLF
 . . I USERLEVEL S DIC("A")=DIC("A")_"May take a few seconds to display a list of users."_CRLF
 . . S DIC("A")=DIC("A")_"Remove all settings for which "_LVLTXT_"? ",DIC(0)="AEQM"
 . . S DIC("S")="N ORX F ORX=1:1:ORCNT I $D(^XTV(8989.5,""AC"",ORPIEN(ORX),Y_ORENT)) Q"
 . . D ^DIC I $D(DTOUT)!$D(DUOUT) S DONE=1 Q
 . . S IEN=$P(Y,U),NAME=$P(Y,U,2),LVLNAME=LVLTXT_" "_NAME
 . . I IEN'>0 S DONE=1 Q
 . . S USR=$S(USERLEVEL:IEN,1:0),DIV=$S(USERLEVEL:0,1:IEN)
 . . W !!!,"Current settings for "_LVLNAME_":",!
 . . D DISPLAY^ORACCES3(USR,"",DIV)
 . . S TXT="All settings will be removed and CPRS Write Access for "_LVLTXT_CRLF
 . . S TXT=TXT_NAME_" will revert to the "_$S(USERLEVEL:"Division",1:"System")_" level settings."_CRLF
 . . S TXT=TXT_"Are you sure you want to remove all settings for this "_LVLTXT
 . . I $$ASKYN("N",TXT) D  I 1
 . . . F IDX=1:1:ORCNT D
 . . . . K ORERR
 . . . . D NDEL^XPAR(ENT2_IEN,ORPARAM(IDX),.ORERR)
 . . . . I +$G(ORERR)'=0 W !,"ERROR: "_ORERR
 . . . W !!!,"New settings for "_LVLNAME_":",!
 . . . D DISPLAY^ORACCES3(USR,"",DIV)
 . . . W !!,"*** Settings removed for "_LVLNAME_" ***",!!
 . . E  W !!,"Settings not removed for "_LVLNAME_".",!!
 Q
 ;
GETINST(LVL,ENT,NAME) ;
 I LVL=1 D
 . N PKG,NAM
 . S NAM=$P(^XTV(8989.51,ORPIEN(TABS),0),"^",1),PKG=NAM
 . F  S PKG=$O(^DIC(9.4,"C",PKG),-1) Q:$E(NAM,1,$L(PKG))=PKG
 . S PKG=$O(^DIC(9.4,"C",PKG,0))
 . I PKG S ENT=PKG_";DIC(9.4,",NAME=$P($G(^DIC(9.4,PKG,0)),U)
 I LVL=2 D
 . S ENT=$$FIND1^DIC(4.2,"","QX",$$KSP^XUPARAM("WHERE"))_";DIC(4.2,"
 . S NAME=$P($G(^DIC(4.2,+ENT,0)),U)
 Q
 ;
EDITOR ;
 N INST,ORERR,TEMPLATE,ENT,DIC,DTOUT,DUOUT,IDX,Y,MESSAGE
 N ORPARAM,ORTABS,ORPIEN,TABS,OTHER,ORDERS,ERROR,NAME
 N USER,DIV,DSPLVL,DSPNAME,ASKLVL
 S (USER,DIV,DSPLVL)=0,(DSPNAME,ASKLVL)=""
 D GETPARAMS(1)
 S (ENT,NAME)="",INST=$$SELECTINST
 I "^U^S^P^D^"'[(U_INST_U) Q
 S TEMPLATE="OR TABS WRITE ACCESS BY "_$S(INST="U":"USER",INST="S":"SYS",INST="P":"PKG",INST="D":"DIV",1:"")
 I INST="P" D
 . S DSPLVL=1 D GETINST(DSPLVL,.ENT,.DSPNAME)
 . S ASKLVL="PKG",NAME="Package: "_DSPNAME
 I INST="S" D
 . S DSPLVL=2 D GETINST(DSPLVL,.ENT,.DSPNAME)
 . S ASKLVL="SYS",NAME="System: "_DSPNAME
 I INST="D" D
 .S DIC=4,DIC(0)="AEMQ"
 .D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<1) S ENT="" Q
 .S DIV=+Y,DSPLVL=3,DSPNAME=$P($G(^DIC(4,DIV,0)),U)
 .S ENT=+Y_";DIC(4,",NAME="Division: "_DSPNAME
 I INST="U" D
 .S DIC=200,DIC(0)="AEMQ"
 .D ^DIC I $D(DTOUT)!$D(DUOUT)!(Y<1) S ENT="" Q
 .S USER=+Y,DSPLVL=4,DSPNAME=$P($G(^VA(200,+Y,0)),U)
 .S ENT=+Y_";VA(200,",NAME="User: "_DSPNAME
 I ENT="" Q
 D DISPLAY^ORACCES3(USER,"",DIV,0,DSPLVL,DSPNAME)
 D VALUEMSG^ORACCES2(ENT,,,1,.MESSAGE,NAME)
 I $D(MESSAGE) D  K MESSAGE
 .S IDX=0 F  S IDX=$O(MESSAGE(IDX)) Q:'IDX  W !,MESSAGE(IDX)
 .W ! F IDX=1:1:78 W "-"
 .W !
 I ASKLVL'="" D ASK4RESET(ASKLVL)
 D TEDH^XPAREDIT(TEMPLATE,"",ENT)
 D DISPLAY^ORACCES3(USER,"",DIV,0,DSPLVL,DSPNAME)
 D VALUEMSG^ORACCES2(ENT,,,1,.MESSAGE,NAME)
 I $D(MESSAGE) D
 .S IDX=0 F  S IDX=$O(MESSAGE(IDX)) Q:'IDX  W !,MESSAGE(IDX)
 .W ! F IDX=1:1:78 W "-"
 .W !
 .R "Type <Enter> to continue: ",IDX:DTIME
 Q
 ;
GETIINST(DESC) ;
 N IDX,RESULT
 S RESULT=""
 S IDX=0 F  S IDX=$O(ORTABS(IDX)) Q:IDX'>0!(RESULT'="")  D
 .I $G(ORTABS(IDX,4))=DESC S RESULT=$G(ORTABS(IDX,2))
 Q RESULT
 ;
SELECTINST() ;
 N DIR,Y
 S DIR(0)=$S($G(DUZ(0))="@":"S^P:PACKAGE;S:SYSTEM;D:DIVISION;U:USER",1:"S^S:SYSTEM;D:DIVISION;U:USER")
 D ^DIR
 Q Y
 ;
GETUSER(UARRAY) ;
 N STOP,USER
 S STOP=0
 F  D  Q:STOP=1
 .S USER=$$SELECT("Select user to copy setting to: ")
 .I +USER=-1 S STOP=1 Q
 .S UARRAY($P(USER,U))=$P(USER,U,2)
 Q
 ;
DATA(ARRAY,PARM,USER,DIV) ;
 N EXT,EXT1,FILE,IEN,ORPARMS,PARAM,TYPE,TYPE1,VALUE,X
 S PARAM=$G(ORPARAM(PARM))
 I PARAM="" Q
 D ENVAL^XPAR(.ORPARMS,PARAM,"",.ERR,0)
 S DIV=$G(DIV)
 S X="" F  S X=$O(ORPARMS(X)) Q:X=""  D
 .S TYPE="" F  S TYPE=$O(ORPARMS(X,TYPE)) Q:TYPE=""  D
 ..S VALUE=$S(PARM<4:$S(ORPARMS(X,TYPE)=1:"Yes",1:"No"),1:ORPARMS(X,TYPE))
 ..I (PARM=1)!(PARM=2) D
 ...S EXT=$$TABDESC2(PARM,TYPE)
 ..I PARM=3 D
 ...S EXT=$P($G(^ORD(100.98,TYPE,0)),U)
 ..I PARM=4 S EXT=-1
 ..I $G(EXT)="" Q
 ..S FILE=$S(X["DIC(9.4":9.4,X["VA(200":200,X["DIC(4.2":4.2,X["DIC(4,":4,1:"")
 ..I FILE="" Q
 ..S EXT1=$S(FILE=200:+X,1:$$GET1^DIQ(FILE,+X,.01))
 ..S TYPE1=$S(FILE=9.4:"Package",FILE=4.2:"Systems",FILE=200:"Users",FILE=4:"Division",1:"")
 ..I TYPE1="" Q
 ..I USER>0,TYPE1'="Users" Q
 ..I USER>0,+X'=USER Q
 ..I DIV>0,TYPE1'="Division" Q
 ..I DIV>0,+X'=DIV Q
 ..S ARRAY(TYPE1,EXT1,EXT)=VALUE
 Q
 ;
SETUSER(IEN,NAME,INITIAL,ACT,CARRAY) ;
 N INST,ORERR,PARAM,PARAMID,SETINST,VALUE,ENT,RARRAY
 W !,"Updating user: "_NAME
 S ENT="USR.`"_IEN
 I ACT="A" D DISPLAY^ORACCES3(IEN,.RARRAY,"",1)
 I ACT="O" D  I +$G(ORERR)'=0 Q
 .F PARAMID=1,2,3 D
 ..S PARAM=$G(ORPARAM(PARAMID))
 ..I PARAM="" Q
 ..D NDEL^XPAR(ENT,PARAM,.ORERR)
 ..I +$G(ORERR)'=0 W !,"ERROR clearing user parameter: "_ORERR
 F PARAMID=1,2,3 D
 .S PARAM=$G(ORPARAM(PARAMID))
 .I PARAM="" Q
 .K ORERR
 .I '$D(CARRAY(PARAMID)) Q
 .S INST=""
 .F  S INST=$O(CARRAY(PARAMID,"Users",+INITIAL,INST)) Q:INST=""  D
 ..I ACT="A",$G(RARRAY(PARAMID,"Users",IEN,INST))'="" Q
 ..S VALUE=CARRAY(PARAMID,"Users",+INITIAL,INST)
 ..I VALUE="" Q
 ..K ORERR
 ..S SETINST=$S(PARAMID<3:$$GETIINST(INST),1:INST)
 ..I SETINST="" Q
 ..W !,PARAM_" instance "_INST
 ..D EN^XPAR(ENT,PARAM,SETINST,VALUE,.ORERR)
 ..I +$G(ORERR)'=0 W !,"ERROR: "_ORERR Q
 ..W !,"    done"
 W !,"User "_NAME_" settings:"
 D DISPLAY^ORACCES3(IEN,"","",0)
 Q
 ;
SELECT(TEXT,SCREEN) ;
 N DIC,Y
 S DIC="^VA(200,",DIC("A")=TEXT,DIC(0)="AEQM"
 I $G(SCREEN) S DIC("S")="N ORX F ORX=1:1:3 I $D(^XTV(8989.5,""AC"",ORPIEN(ORX),Y_"";VA(200,"")) Q"
 D ^DIC
 Q Y
 ;
POST ;
 N ORPARAM,ORTABS,TABS,OTHER,ORDERS,ERROR,NODEPENDENCIES
 S NODEPENDENCIES=1
 D GETPARAMS
 D POSTTABS
 D POSTDG
 D POSTERR
 Q
 ;
POSTDG ;
 N IEN,ERR
 S IEN=0 F  S IEN=$O(^ORD(100.98,IEN)) Q:IEN'>0  D
 .D EN^XPAR("PKG",ORPARAM(ORDERS),"`"_IEN,1,.ERR)
 Q
 ;
POSTERR ;
 N ERR,TXT
 S TXT="New information cannot be added into CPRS.  Exceptions: contact CACs."
 D EN^XPAR("PKG",ORPARAM(ERROR),1,TXT,.ERR)
 I +ERR>0 D
 .D BMES^XPDUTL("  Problem updating error message")
 Q
 ;
POSTTABS ;
 N TAB,ERR
 S TAB=0 F  S TAB=$O(ORTABS(TAB))  Q:'TAB  D
 .D EN^XPAR("PKG",ORPARAM(ORTABS(TAB,1)),ORTABS(TAB,2),1,.ERR)
 .I +ERR>0 D
 ..D BMES^XPDUTL("  Problem updating "_ORTABS(TAB,4)_" level")
 Q
 ;
ASK4RESET(LEVEL) ;
 N TAB,VALUE,ASK,IEN,DIR,Y,TXT,YN,LVLTXT,EXPECTED,ERR,NODEPENDENCIES
 I LEVEL="PKG" S EXPECTED=1
 E  S EXPECTED=0
 S (ASK,TAB)=0 F  S TAB=$O(ORTABS(TAB))  Q:'TAB  D  Q:ASK
 . S VALUE=$$GET^XPAR(LEVEL,ORPARAM(ORTABS(TAB,1)),ORTABS(TAB,2))
 . I VALUE'=EXPECTED S ASK=1
 I 'ASK D
 . S IEN=0 F  S IEN=$O(^ORD(100.98,IEN)) Q:IEN'>0  D  Q:ASK
 . . S VALUE=$$GET^XPAR(LEVEL,ORPARAM(ORDERS),"`"_IEN)
 . . I VALUE'=EXPECTED S ASK=1
 I 'ASK Q
 I EXPECTED S YN="Yes"
 E  S YN="No"
 I LEVEL="SYS" S LVLTXT="System"
 E  S LVLTXT="Package"
 S DIR(0)="YO"
 S TXT="Not all "_LVLTXT_" level settings are set to "_YN
 S TXT=TXT_".  Do you want to set all "_LVLTXT_" level settings to "_YN
 S TXT=TXT_"? (Yes or No): "
 D WRAP^ORUTL(TXT,"DIR(""A"")",1,0,2,0,70)
 S IDX=$O(DIR("A",99999),-1) S DIR("A")=DIR("A",IDX) K DIR("A",IDX)
 D ^DIR I $D(DIRUT) S Y=0
 I '+Y Q
 S NODEPENDENCIES=1
 S TAB=0 F  S TAB=$O(ORTABS(TAB))  Q:'TAB  D
 .D EN^XPAR(LEVEL,ORPARAM(ORTABS(TAB,1)),ORTABS(TAB,2),EXPECTED,.ERR)
 S IEN=0 F  S IEN=$O(^ORD(100.98,IEN)) Q:IEN'>0  D
 .D EN^XPAR(LEVEL,ORPARAM(ORDERS),"`"_IEN,EXPECTED,.ERR)
 W !,"Done"
 Q
 ;
CLEARPKG ;
 N ORERR,IDX,ORPARAM,ORTABS,TABS,OTHER,ORDERS,ERROR
 D GETPARAMS
 S IDX=0 F  S IDX=$O(ORPARAM(IDX)) Q:'IDX  D NDEL^XPAR("PKG",ORPARAM(IDX),.ORERR)
 Q
CLEARSYS ;
 N ORERR,IDX,ORPARAM,ORTABS,TABS,OTHER,ORDERS,ERROR
 D GETPARAMS
 S IDX=0 F  S IDX=$O(ORPARAM(IDX)) Q:'IDX  D NDEL^XPAR("SYS",ORPARAM(IDX),.ORERR)
 Q
 ;
GETPARAMS(GETCODE) ;
 I '$D(ORPARAM) D
 . S TABS=1,ORPARAM(TABS)="OR CPRS TABS WRITE ACCESS"
 . S OTHER=2,ORPARAM(OTHER)="OR CPRS OTHER WRITE ACCESS"
 . S ORDERS=3,ORPARAM(ORDERS)="OR CPRS ORDERS WRITE ACCESS"
 . S ERROR=4,ORPARAM(ERROR)="OR CPRS WRITE ACCESS ERROR"
 I +$G(GETCODE),'$D(ORPIEN) D
 . N IDX F IDX=1:1:4 S ORPIEN(IDX)=$O(^XTV(8989.51,"B",ORPARAM(IDX),0))
 ; ORTABS 2nd Index  1:Parameter, 2:Code  3:Internal Name  4:Display Name  5=1=Template access, 2=Cover Sheet param
 I '$D(ORTABS) D
 . N IDX,DATA,LINE,SUB
 . S IDX=0,LINE="ORTABINFO"
 . F  S IDX=IDX+1,DATA=$P($T(@LINE+IDX),";;",2) Q:DATA=""  D
 .. F SUB=1:1:5 S ORTABS(IDX,SUB)=$P(DATA,U,SUB)
 Q
 ;
TABIDX(PARAM,CODE) ;
 N IDX,TAB
 S (IDX,TAB)=0
 F  S TAB=$O(ORTABS(TAB)) Q:'TAB  D  Q:IDX
 . I PARAM=ORTABS(TAB,1),CODE=ORTABS(TAB,2) S IDX=TAB
 Q IDX
 ;
TABDESC(IDX,EXTRA) ;
 N DESC
 S DESC=ORTABS(IDX,4)
 I +$G(EXTRA) D
 . I ORTABS(IDX,5)=1 S DESC=DESC_", template access allowed"
 . I ORTABS(IDX,5)=2 S DESC="Cover Sheet "_DESC
 Q DESC
 ;
TABDESC2(PARAM,CODE,EXTRA) ;
 N DESC,TAB
 S TAB=0,DESC=""
 F  S TAB=$O(ORTABS(TAB)) Q:'TAB  D  Q:DESC'=""
 . I PARAM=ORTABS(TAB,1),CODE=ORTABS(TAB,2) D
 . . S DESC=$$TABDESC(TAB,$G(EXTRA))
 Q DESC
 ;
 ;
ORTABINFO ; Pieces: 1:ORPARAM idx  2:Code  3:Internal Name  4:Display Name  5:1=Template access, 2=Cover Sheet param
 ;;1^C^consults^Consults^1
 ;;1^D^dcSumm^Discharge Summaries^1
 ;;1^M^meds^Meds
 ;;1^N^notes^Notes^1
 ;;1^O^orders^Orders
 ;;1^P^problems^Problems
 ;;1^S^surgery^Surgery^1
 ;;2^A^allergy^Allergies
 ;;2^D^delayedOrders^Delayed Orders
 ;;2^E^encounters^Encounters
 ;;2^I^immunization^Immunizations^2
 ;;2^R^reminderEditor^Reminders List Editor^2
 ;;2^V^vital^Vitals^2
 ;;2^W^womenHealth^Women's Health^2
 ;;
ONEHR() ;
 N ORPRIMARY
 ;
 ; For testing purposes, OR SIMULATE ON EHR can be used to have this API return a 1 in a non-prod account
 I '$$PROD^XUPROD,$$GET^XPAR("ALL","OR SIMULATE ON EHR",1,"I") Q 1
 ;
 S ORPRIMARY=$P($$SITE^VASITE,U,3)
 Q $$CRNRSITE^VAFCCRNR(ORPRIMARY)  ;ICR #7346
 ;
EHRACTIVE(ORY) ;
 S ORY=$$ONEHR
 Q
 ;
TABNAMES(TABS) ;
 N IDX,DATA,LINE,SUB
 S IDX=0,LINE="ORTABINFO"
 F  S IDX=IDX+1,DATA=$P($T(@LINE+IDX),";;",2) Q:DATA=""  D
 .;F SUB=1:1:5 S ORTABS(IDX,SUB)=$P(DATA,U,SUB)
 .S TABS($P(DATA,U,3))=$P(DATA,U,4)
 Q
 ;
HELP ;
 W !,"Select the copy action:",!
 W !,"  Copy/Add settings - Select Copy/Add settings to add the settings"
 W !,"    from the initial user to the receiving user, without overwriting"
 W !,"    any existing settings.",!
 W !,"  Copy/Overwrite settings - Select Copy/Overwrite settings to replace"
 W !,"    the receiving user settings with the initial user settings.",!
 W !,"  Skip User - do not copy any of the user settings."
 Q
