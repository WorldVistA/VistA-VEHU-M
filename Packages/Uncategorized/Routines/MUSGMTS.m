MUSGMTS ; SLC/JER,MAM - Ad Hoc Summary Driver ;4/7/94  14:48
 ;;2.5;Health Summary;;Dec 16, 1992
MAIN S LRDFNSAV=LRDFN I DRDA']"" G PAT^ZRESUTL1
 N C,GMTSEG,GMTSEGI,GMTSEGC,GMTSQIT,GMTSTYP,GMTSTITL,GMW,X,Y
 N DIC,DIPGM,I,POP,% S DFN=+DRDA G MUS
 I $L($T(PATIENT^ORU1)),($G(^DD(100,0,"VR"))>2.19) D MAIN^GMTSADHC Q
MUS S DIC=142,DIC(0)="MZF",X="GMTS HS ADHOC OPTION" D ^DIC K DIC S GMTSTYP=+Y,GMTSTITL="AD HOC" I $D(HEALTH) S Y($P(HEALTH,"^",1))=HEALTH,Y=+$P(HEALTH,"^",1),GMPSAP=1,DFN=DRDA G MUD
 D BUILD Q:$D(GMTSQIT)!($D(DIROUT))  W !! Q:DFN'>0  D HSOUT^GMTS,END^GMTS S:$D(DTOUT) GMTSQIT="" Q:$D(GMTSQIT)!($D(DIROUT))
 D END
 Q
BUILD ; Conducts Dialogue to build ad hoc summary
 N GMI,GMJ,GMW,X,XQORM,Y
 Q:$D(GMTSQIT)!($D(DIROUT))
 W @IOF
 S XQORM("S")="I $D(^GMT(142,DA(1),1,DA,0)),($P(^GMT(142.1,$P(^GMT(142,DA(1),1,DA,0),U,2),0),U,6)'=""T"")",XQORM("M")=6
 S XQORM=GMTSTYP_";GMT(142,",XQORM(0)="AD",XQORM("A")="Select NEW set of COMPONENT(S): ",XQORM("??")="D HELP^GMTSADH" D ^XQORM I Y'>0 S GMTSQIT="" Q
 I +Y,(X?1"^^".E) D RJUMP^GMTSUP1 G BUILD
MUD S GMTSEGC=Y
 S (X,GMI,GMJ)=0 F GMW=0:0 S GMI=$O(Y(GMI)) Q:'GMI  D LOAD
 I $D(HEALTH) D EN^GMTS1 Q
 D GETLIM^GMTSADH1
 Q
LOAD ; Load enabled components into GMTSEG
 N SREC,STRN
 S STRN=+Y(GMI),SREC=^GMT(142,GMTSTYP,1,STRN,0)
LOAD1 ; Load an individual component into GMTSEG( and GMTSEGI(
 S GMJ=GMJ+1,GMTSEG(GMJ)=SREC,GMTSEGI($P(SREC,U,2))=GMJ D LOADSEL
 Q
LOADSEL ; Loads GMTSEG(J,FN,IFN), when Selection items are present
 N S2,SJ,SEL
 S S2=0,SJ=GMJ F GMW=0:0 S S2=$O(^GMT(142,GMTSTYP,1,STRN,1,S2)) Q:'S2  S SEL=^(S2,0),GMTSEG(GMJ,($P($P(SEL,"(",2),",")),S2)=$P(SEL,";") I S2=1 S GMTSEG(SJ,$P($P(SEL,"(",2),","),0)="^"_$P(SEL,";",2)
 Q
END ; Cleans up any residual locals
 K GMTSQIT,FROM,GMI,I1,ISVALID,LRDFN,PTR,SEX,TO,VAOA,VASD,VASV,X
 Q
HELP ; 
 N GMJ,GMTSTXT,HLP
 S HLP=$S(X="??":"HTX2",X="?":"HTX1",1:"") I $L(HLP) W ! F GMJ=1:1 S GMTSTXT=$T(@HLP+GMJ) Q:GMTSTXT["ZZZZ"  W !,$P(GMTSTXT,";",3,99)
 I X="???" W !! D HELP2^GMTSUP1
 D REDISP
 Q
REDISP ; Ask Whether or not to redisplay menu
 N I,DIR,X,Y
 S DIR(0)="Y",DIR("A")="Redisplay items",DIR("B")="YES" D ^DIR Q:'Y
 W @IOF
 D DISP^XQORM1 W !
 Q
HTX1 ;;Help Text for "?" and "??"
 ;;Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;;Enter: ??  to see HELP for MULTIPLE SELECTION
 ;;       ??? to see HELP for "^^"-jump
 ;;
 ;;ZZZZ
HTX2 ; HELP for ??
 ;;
 ;;The Health Summary components you select at this prompt create
 ;;an ADHOC Health Summary.
 ;;
 ;;Select ONE or MORE items from the menu, separated by commas.
 ;;
 ;;ALL items may be selected by typing "ALL".
 ;;
 ;;EXCEPTIONS may be entered by preceding them with a minus.
 ;;  For example, "ALL,-THIS,-THAT" selects all but "THIS" and "THAT".
 ;;
 ;;ZZZZ
