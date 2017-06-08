ENXPIEN ;(WIRMFO)/DH-Environment Check for Templates, Old Work Orders ;1.23.97
 ;;7.0;ENGINEERING;**35**;Aug 17,1993
EN ;
 Q:$$PATCH^XPDUTL("EN*7.0*35")  ;No need to do any of this more than
 ;                               once   
 ; Check for local versions of patched input templates
 ; Only executed if patch not previously installed
 I '$$PATCH^XPDUTL("EN*7.0*35") D
 . N ENY
 . W !!,"  Checking for local versions of patched input templates..."
 . D LINPT
 . ; report existence of local input templates
 . I '$D(ENY) W !,"    none found."
 . I $D(ENY) D
 . . N ENTEXT,ENTYP,ENX
 . . W !!,"  Local versions of patched input template(s) exist. These local template(s)"
 . . W !,"  are used in lieu of the national template(s) modified by this patch."
 . . W !,"  Due to important changes to the patched input templates, the local"
 . . W !,"  versions of these templates will automatically be deleted during"
 . . W !,"  the patch installation. You may wish to print out the local templates"
 . . W !,"  before installing this patch."
 . . W !,"  If the local changes are still desired, the ENZ templates can be"
 . . W !,"  recreated after patch installation by copying the corresponding"
 . . W !,"  national template and making appropriate changes to the ENZ template."
 . . W !!,"    The following local input template(s) will be deleted:"
 . . S ENTEXT="    Local Template             Type   File      Patched National Template"
 . . W !!,ENTEXT
 . . S ENTEXT="    -------------------------  -----  --------  -------------------------"
 . . W !,ENTEXT
 . . F ENTYP="INP" D
 . . . S ENTYP("E")=$S(ENTYP="INP":"Input",ENTYP="SRT":"Sort ",ENTYP="PRT":"Print",1:"")
 . . . S ENX("L")="" F  S ENX("L")=$O(ENY(ENTYP,ENX("L"))) Q:ENX("L")=""  D
 . . . . S ENTEXT="    "_$$LJ^XLFSTR(ENX("L"),25)
 . . . . S ENTEXT=ENTEXT_"  "_ENTYP("E")
 . . . . S ENTEXT=ENTEXT_"  "_$$LJ^XLFSTR($P(ENY(ENTYP,ENX("L")),U,3),8)
 . . . . S ENTEXT=ENTEXT_"  "_$P(ENY(ENTYP,ENX("L")),U,2)
 . . . . W !,ENTEXT
 . . S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
PMCHK ;  Check for old incomplete PM work orders 
 ;  Sets global node if appropriate
 ;  Delete question will be asked at PREINIT if global set
 ;  Executed only during PACKAGE LOAD
 Q:$G(XPDENV)'=0
 I $P($G(^ENG(6920,0)),U,4)'>5000 Q  ;Why bother?
 N DA,ENDA,SHOP,COUNT,LINE D HOME^%ZIS
 S DA=$O(^ENG(6920,9999999999),-1),COUNT("TOT")=0
 F  S DA=DA-500 Q:DA'>0  S X=$P($G(^ENG(6920,DA,0)),U,2) I X]"",X<2960101 Q
 F  Q:$P($G(^ENG(6920,DA+1,0)),U,2)>2951231  S DA=DA+1
 S DA("START")=DA
 S SHOP=0 F  S SHOP=$O(^ENG(6920,"AINC",SHOP)) Q:'SHOP  D
 . S ENDA=9999999999-DA("START"),COUNT(SHOP)=0
 . F  S ENDA=$O(^ENG(6920,"AINC",SHOP,ENDA)) Q:'ENDA  D
 .. S DA=9999999999-ENDA
 .. I $E($P($G(^ENG(6920,DA,0)),U),1,3)="PM-" S COUNT("TOT")=COUNT("TOT")+1,COUNT(SHOP)=COUNT(SHOP)+1
 .. I '(DA#100) W "." I $X>IOM W !
 I COUNT("TOT")>500 D
 . S Y=DT X ^DD("DD") W !,Y
 . W !,"There are about "_COUNT("TOT")_" incomplete PM work orders on your system that were"
 . W !,"created prior to Jan 1, 1996. The following is a breakout by shop:"
 . K X S $P(X,"-",79)="-" W !,X S LINE=4
 . S SHOP=0 F  S SHOP=$O(COUNT(SHOP)) Q:'SHOP  D:COUNT(SHOP)>0
 .. S ^ENG("PATCH 7*35 PM DELETE",SHOP)=COUNT(SHOP)
 .. I $D(^DIC(6922,SHOP,0)) W !,$P(^(0),U),?30,COUNT(SHOP) S LINE=LINE+1
 .. I (IOSL-LINE)'>2 R !,"Press <RETURN> to continue...",X:DTIME S LINE=2
 . W !!,"You will have the option of automatically deleting these old work orders.",!,"That question will be asked when EN*7*35 is installed."
 . S ^ENG("PATCH 7*35 PM DELETE",0)=COUNT("TOT")_U_DA("START")_U_DT
 Q
LINPT ; find local input templates
 ; out ENY("INP",local template name) = ien^national template name^file
 N ENX
 K ENY("INP")
 F ENX="ENEQDISP^6914","ENEQENTER^6914","ENEQPMP^6914","ENEQTURN^6914","ENPMCLOSE^6920","ENWOBIOCLSE^6920","ENWOCLOSE^6920","ENWODISAP^6920","ENWOEDIT^6920","ENWONEW^6920","ENWONEWCLOSE^6920","ENWOWARD^6920" D
 . S ENX("L")=$E($P(ENX,U),1,2)_"Z"_$E($P(ENX,U),3,99)
 . S ENX("L","IEN")=$$FIND1^DIC(.402,"","X",ENX("L"),"B")
 . I ENX("L","IEN") S ENY("INP",ENX("L"))=ENX("L","IEN")_U_ENX
 Q
LSRTT ; find local sort templates
 ; out ENY("SRT",local template name) = ien^national template name^file
 N ENX
 K ENY("SRT")
 ;F ENX= D
 ;. S ENX("L")=$E($P(ENX,U),1,2)_"Z"_$E($P(ENX,U),3,99)
 ;. S ENX("L","IEN")=$$FIND1^DIC(.401,"","X",ENX("L","B")
 ;. I ENX("L","IEN") S ENY("SRT",ENX("L"))=ENX("L","IEN")_U_ENX
 Q
LPRTT ; find local print templates
 ; out ENY("PRT",local template name) = ien^national template name^file
 N ENX
 K ENY("PRT")
 F ENX="EN EQ HIST^6920","EN EQ HIST HD^6920","ENCMR^6914","ENEQ EQUIP. LIST^6914","ENEQ REPLACEMENT^6914" D
 . S ENX("L")=$E($P(ENX,U),1,2)_"Z"_$E($P(ENX,U),3,99)
 . S ENX("L","IEN")=$$FIND1^DIC(.4,"","X",ENX("L"),"B")
 . I ENX("L","IEN") S ENY("PRT",ENX("L"))=ENX("L","IEN")_U_ENX
 Q
 ;ENXPIEN
