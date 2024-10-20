PXRMART ;SLC/DAN - ART computed finding ;09/11/2018
 ;;2.0;CLINICAL REMINDERS;**26,42**;Feb 04, 2005;Build 245
 ;Refererences to ^GMR(120.8 covered by DBIA #905.
ARTCL(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;
 S TEST=$$UP^XLFSTR(TEST)
 S NFOUND=0
 Q:TEST=""!(NGET=0)!("^IN:^DR:^"'[("^"_$E(TEST,1,3)_"^"))
 N WILD,ITEM,SUB,ING,INGT,TERM
 S WILD=$S(TEST["*":1,1:0),SUB=$S($E(TEST,1,2)="IN":"API",1:"APC")
 S TEST=$P(TEST,":",2)
 I 'WILD S ITEM=$S(SUB="API":+$O(^PS(50.416,"B",TEST,0)),1:TEST) Q:ITEM=0  D GETINFO Q
 S ITEM=$E(TEST,1,$L($P(TEST,"*")))
 I SUB="APC" F  S ITEM=$O(^GMR(120.8,SUB,DFN,ITEM)) Q:ITEM=""!(ITEM'[($E(TEST,1,$L($P(TEST,"*")))))!(NFOUND=NGET)  D GETINFO
 I SUB="API" S TERM=ITEM,ING=0 F  S ING=$O(^GMR(120.8,SUB,DFN,ING)) Q:'+ING  S INGT=$P(^PS(50.416,ING,0),U) I $E(INGT,1,$L(TERM))=TERM S ITEM=ING D GETINFO
 Q
 ;
GETINFO ;
 N EDATE,IEN,GMRAR0,GMRDATA
 S IEN="" F  S IEN=$O(^GMR(120.8,SUB,DFN,ITEM,IEN),-1) Q:'+IEN!(NFOUND=NGET)  D
 .S GMRAR0=^GMR(120.8,IEN,0)
 .S EDATE=$P(GMRAR0,U,4)
 .Q:EDATE<BDT!(EDATE>EDT)
 .S NFOUND=NFOUND+1,TEST(NFOUND)=1,DATE(NFOUND)=EDATE
 .S DATA(NFOUND,"REACTANT")=$P(GMRAR0,U,2)
 .S DATA(NFOUND,"OBSERVED/HISTORICAL")=$$EXTERNAL^DILFD(120.8,6,"",$P(GMRAR0,U,6))
 .S DATA(NFOUND,"MECHANISM")=$$EXTERNAL^DILFD(120.8,17,"",$P(GMRAR0,U,14))
 .S DATA(NFOUND,"ALLERGY TYPE")=$P(GMRAR0,U,20)
 .S TEXT(NFOUND)="Documented reaction "_$S(SUB="API":"that includes the ingredient ",1:"to an agent in class ")_$S(SUB="APC":ITEM,1:$P(^PS(50.416,ITEM,0),U))_", reactant was: "_DATA(NFOUND,"REACTANT")_"."
 Q
