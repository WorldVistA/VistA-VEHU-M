GMPLZVHU ;NTEO/JFR - STUFF PROBLEMS IN ON VEHU PATIENTS;;3/21/06 9:03
 ;;1.0
VEHU ; START HERE
 N GMPLPRB,GMPLARR,GMPROV,GMPSAVED,GMPVAMC,GMPLPT,GMPDFN,GMPPROV,DIC,FLD
 D SEARCH(,.GMPLPRB)  ; get the problem to stuff
 I '$L($G(GMPLPRB(1))) W !,"Can't proceed without a problem." Q
 S $P(GMPLARR(.05),U,2)=$P(GMPLPRB,U,2)
 S GMPLARR(1.01)=GMPLPRB
 S GMPLARR(.01)=$P(GMPLPRB(1),U,2)
 I GMPLARR(.01)=0 W !,"No DX found, can't go on!" Q
 S GMPLARR(.12)=$$ACTV
 S GMPLARR(.13)=$$ONSET()
 S GMPLARR(1.14)=$$PRIOR
 S GMPLARR(1.04)=$$PROV
 I '+GMPLARR(1.04) W !,"Have to have a provider, quitting now. TaTa..." Q
 S GMPLARR(1.05)=GMPLARR(1.04)
 S GMPLARR(1.03)=GMPLARR(1.05)
 S GMPLARR(.03)=0
 S (GMPLARR(.08),GMPLARR(1.09))=DT
 F FLD=1.1:.01:1.13 S GMPLARR(FLD)=0
 S GMPLARR(1.06)=1018
 F FLD=7,8,15,16 S GMPLARR(1+(FLD/100))=""
 S GMPLARR(10,0)=0
 ;
 D PATS
 I '$O(^TMP("GMPLVHU",$J,0)) W !,"Gotta have patient! Can't go on!" Q
 ;loop pats
 S GMPLPT=0
 F  S GMPLPT=$O(^TMP("GMPLVHU",$J,GMPLPT)) Q:'GMPLPT  D
 . N GMPFLD
 . S GMPDFN=GMPLPT
 . S GMPPROV=GMPLARR(1.04)
 . S GMPVAMC=$$KSP^XUPARAM("INST")
 . M GMPFLD=GMPLARR
 . D NEW^GMPLSAVE
 . I $D(DA) W !,"Patient ",$E($P(^DPT(GMPLPT,0),U,9),6,9)," ...done"
 K ^TMP("GMPLVHU",$J)
 Q
 ;
PRIOR() ;get 
 N DIR,X,Y,DUOUT,DTOUT,DIRUT
 S DIR(0)="SA^A:Acute;C:Chronic",DIR("A")="Is the Problem Acute or Chronic? "
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S Y="A"
 Q Y
 ;
ONSET() ;get onset date
 N DIR,X,Y,DUOUT,DTOUT,DIRUT
 S DIR(0)="D^:NOW:E",DIR("A")="Date of Onset"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S Y=DT
 Q Y
 ;
ACTV() ; get whether active or inactive
 N DIR,X,Y,DUOUT,DTOUT,DIRUT
 S DIR(0)="SA^A:Active;I:Inactive",DIR("A")="Status of Problem: "
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S Y="A"
 Q Y
 ;
PROV() ; GET RESPONSIBLE PROVIDER
 N DIC,X,Y,DUOUT,DTOUT,D
 S DIC="^VA(200,",DIC(0)="AEMNQ",DIC("S")="I $D(^VA(200,""AK.PROVIDER"",$P(^(0),U))),$$ACTIVE^XUSER(Y)"
 S DIC("A")="PROVIDER: ",D="AK.PROVIDER"
 D ^DIC I +Y<1 S Y=0
 Q +Y
 ;
PATS ; GET LIST OF PATIENTS TO UPDATE
 N PTARR
 W !!,"Select patients to enter the selected problem for. Select numbers between"
 W !,"0 and 900 with the number corresponding to the VeHU patient that you want to"
 W !,"update.  For example, choosing number 12 will update VeHU patient twelve",!!
 S DIR("A")="Select patient(s) to be updated"
 S DIR(0)="LO^0:900" D ^DIR K DIR Q:Y=""!($D(DUOUT))!($D(DTOUT))
 D PARSE(Y,.PTARR) S J=0 F  S J=$O(Y(J)) Q:'+J  D PARSE(Y(J),.PTARR)
 M ^TMP("GMPLVHU",$J)=PTARR
 Q
 ;
PARSE(ARRAY,LIST) ;
 N NUM,R,LNUM,L4,SSN
 S NUM=$L(ARRAY,",")-1
 F R=1:1:NUM S LNUM=$P(ARRAY,",",R) S L4=$S(LNUM=0:"0000",1:$E("000",1,(4-$L(LNUM)))_LNUM) D
 .S SSN="66600"_L4
 .I $D(^DPT("SSN",SSN)) S LIST($O(^DPT("SSN",SSN,0)))=""
 Q
SEARCH(X,RES,PROMPT,UNRES,VIEW) ; Search Lexicon for Problem X
 N DIC,COD,CIEN,SYS,NAME,D
 S:'$L($G(VIEW)) VIEW="PL1" D CONFIG^LEXSET("GMPL",VIEW,DT)
 S DIC("A")=$S($L($G(PROMPT)):PROMPT,1:"Select PROBLEM: ")
 S DIC="^LEX(757.01,",DIC(0)=$S('$L($G(X)):"A",1:"")_"EQMZ"
 S:'$G(UNRES) LEXUN=0 D ^DIC Q:+Y<1
 M RES=Y ; JFR gotta protect Y
 ;  could use $$ICDONE^LEXU to get cod if no Y(1)
 I $D(Y(1)) S COD=Y(1),CIEN=+$$CODEN^ICDCODE(COD,80)
 I $L(Y,"ICD-9-CM ")>1 D
 . S COD="",CIEN="",SYS=""
 . S SYS="ICD-9-CM "
 . S COD=$P($P(VAL1,SYS,2),")")
 . S:COD["/" COD=$P(COD,"/",1)
 . S CIEN=+$$CODEN^ICDCODE(COD,80)
 S RES(1)=COD_U_CIEN
 Q
