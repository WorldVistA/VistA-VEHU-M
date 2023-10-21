IBCNINSC ;AITC/DG/TAZ - GENERAL INSURANCE UTILITIES - INSURANCE COMPANY LOOKUP ;02/01/23
 ;;2.0;INTEGRATED BILLING;**752**;21-MAR-94;Build 20
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
INSOCAS(ARRY,IBNE,IBLIMIT,IBSCR) ; lookup for case insensitive
 ;INPUT:
 ; ARRY   - REQUIRED return array passed by reference
 ; IBNE    - OPTIONAL single lookup or many   single=1  many=0 or null  default is many
 ; IBLIMIT - OPTIONAL limiting the number of found/selected items default is no limit
 ; IBSCR    - OPTIONAL screen for item passed by reference (like DIC("S")) Default is no screen
 ;              ( If a screen is used, variable 'X' is the input value, 'Y' is the IEN if one.
 ;                Naked references should not be used, unless the screen has initiated the reference
 ;                to the file/level that the naked is working with. )
 ;
 ;
 ;OUTPUT:
 ; ARRY   - The return array:
 ;           ARRY=number of insurances selected
 ;           ARRY(IEN of insurance company) = insurance company IEN ^ the complete zero node for that insurance company
 ;           ARRY='^' If the person quits (enters an '^' up-caret at the select Insurance prompt and no other selected)
 ;           ARRY='Insurance company name as entered by user' IF optional single lookup is one (IBNE=1)
 ;                 AND the name entered is not found.
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBA,IBB,IBC,IBCT,IBD,IBFILTER,IBFND,IBI,IBINDX,IBJ,IBK,IBL,IBLKNM,IBLKX,IBLM
 N IBLKUNM,IBN,IBNMA,IBNMR,IBNML,IBOK,IBOK1,IBPROMPT,IBR,IBRNM,IBTMPA,IBTMPFIL,IBTMPTRK,IBTN,IBX,IBXN,X,Y
 ;
 I $G(U)'="^" S U="^"
 I '+DT S DT=$$DT^XLFDT
 ;
 S IBPROMPT="INSURANCE COMPANY"
 S IBNE=+$G(IBNE),IBLIMIT=$G(IBLIMIT),IBSCR=$G(IBSCR)
 ; get IDENTIFIED BY: for display
 K IBLKX S IBI="" F  S IBI=$O(^DD(36,0,"ID",IBI)) Q:'IBI  S IBLKX(IBI)=$G(^DD(36,0,"ID",IBI))
 S IBI=""
 ;
 K ARRY S ARRY=""
INSOCAS1 ; entry point for loop back
 ;
 S IBA="Select "_($S(+$G(ARRY)>0:"another ",1:""))_IBPROMPT
 S IBTMPFIL="^TMP("_$J_",""IBCNINSC_LKUP"")" K @IBTMPFIL
 S IBTMPTRK="^TMP("_$J_",""IBCNINSC_TRK"")" K @IBTMPTRK
 S IBFILTER=1  ; 1 - begins with
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="FO^1:30"
 S DIR("A")=IBA
 S DIR("?")="^D HLPLST^IBCNINSC"
 S DIR("??")="^D HLPLSA^IBCNINSC"
 D ^DIR
 I $E(Y)=U!($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) S:'$G(ARRY) ARRY=U G INSOCASX
 I Y="" G INSOCASX
 S IBFND=""
 S IBX=X
 S IBLKNM=Y,IBLKUNM=$$UP^XLFSTR(IBLKNM),IBNML=$L(IBLKUNM),X=IBLKNM
 ; collect names
 K @IBTMPFIL
 K @IBTMPTRK
 S @IBTMPFIL@(0)=0,IBOK=0
 ; check B and C indexes
 F IBINDX="B","C" S (IBFND,IBNMA,IBNMR)="" D
 . F  S IBNMA=$O(^DIC(36,IBINDX,IBNMA)) Q:IBNMA=""  S IBOK="" D
 .. S IBA=IBNMA,IBB=$$UP^XLFSTR(IBNMA)
 .. S IBOK=$$FILTER^IBCNINSU(IBB,IBFILTER_U_IBLKUNM) I 'IBOK Q
 .. S IBNMR="" F  S IBNMR=$O(^DIC(36,IBINDX,IBNMA,IBNMR)) Q:'IBNMR  D
 ... S IBN=IBNMR
 ... S IBOK1=1 I IBSCR'="" S IBOK1=0,Y=+IBN X IBSCR I  S IBOK1=1
 ... I 'IBOK1 Q
 ... I $G(@IBTMPTRK@(IBN))=1 Q  ; only select the item once
 ... S IBC=@IBTMPFIL@(0)+1,@IBTMPFIL@(0)=IBC
 ... S @IBTMPFIL@(IBC)=IBA_U_IBN
 ... I IBINDX="C" S @IBTMPFIL@(IBC)=@IBTMPFIL@(IBC)_U_$P($G(^DIC(36,IBN,0)),U,1)
 ... S @IBTMPTRK@(IBN)=1
 ;
 ; display / select displayed names
 ; no insurance found
 I '@IBTMPFIL@(0) S IBFND="",IBOK=0 D  G INSOCAS1:'IBOK,INSOCASX
 . I IBNE,'ARRY S ARRY=X,IBOK=1 Q  ; if only one insurance allowed treat as a new insurance if an insurance has not been selected
 . W "   No Insurance names found that match the criteria."
 ;
 ; if only one item found
 S IBOK=0 I +$G(@IBTMPFIL@(0))=1 D  G INSOCASX:'IBOK,INSOCAS1  ;exit if only one insurance is allowed
 . S IBE=$$IBESET($G(@IBTMPFIL@(1)))
 . S IBFND=$$FNDSET(IBE)
 . D ARSET(IBFND)
 . S IBXN=$E($P(IBE,U,2),($L(IBX)+1),($L($P(IBE,U,2))))
 . D DISPADDR(IBXN,+IBE,"",1,$P(IBE,U,3))
 . I 'IBNE S IBOK=1
 ;
 ;
 S IBFND="",IBCT=$G(@IBTMPFIL@(0)),IBR="",IBTN=$FN((IBCT/5),"",1),IBR=+$P(IBTN,".",1)*5,IBTN=$P(IBTN,".",2)
 S:IBTN IBR=IBR+5 K IBTMPA
 S IBTN="" I IBCT<6 M IBTMPA=@IBTMPFIL K IBTMPA(0) D  G INSOP
 . S IBK=IBCT,IBFND=$$INSD(.IBTMPA,0,IBK)
 . I +IBFND D DISPADDR("  "_$P(IBFND,U,2),+IBFND,"",1)
 S IBK=0
 F IBI=0:5:IBR Q:IBFND!(IBFND=U)  K IBTMPA F IBJ=1:1:5 S IBK=IBI+IBJ D  Q:IBFND!(IBFND=U)!(IBK>IBCT)
 . S IBD=$G(@IBTMPFIL@(IBK)),IBFND="" I IBD'="" S IBTMPA(IBK)=IBD
 . I IBD=""!(IBJ=5) S IBL=$S(IBK<IBCT:1,IBK=IBCT:0,1:0) D
 . . S IBLM=IBK I 'IBL&(IBK>IBCT) S IBLM=IBCT
 . . S IBFND=$$INSD(.IBTMPA,IBL,IBLM)
 . . I +IBFND D DISPADDR("  "_$P(IBFND,U,2),+IBFND,"",1)
 ;
INSOP ; process return
 I IBFND=U G INSOCAS1
 I 'IBFND G INSOCAS1
 D ARSET(IBFND)
 I +IBNE G INSOCASX
 I +IBLIMIT,(+ARRY=+IBLIMIT) D  G INSOCASX
 . W !,"Maximum allowed selected items of "_IBLIMIT_" has been reached"
 G INSOCAS1
 ;
INSOCASX ; insurance lookup exit point
 K @IBTMPFIL
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBA,IBB,IBC,IBCT,IBFILTER,IBFND,IBI,IBJ,IBK,IBL
 K IBLKNM,IBLM,IBLKUNM,IBN,IBNMA,IBNMR,IBNML,IBOK,IBOK1,IBPROMPT,IBR,IBTMPA,IBTMPFIL,IBTN,X,Y
 ;END
 Q
 ;
IBESET(IBSTR) ; set IBE equal to array item
 ;
 ; IBSTR - item string to parse
 ;
 N IBA S IBA=""
 S IBA=$P(IBSTR,U,2)_U_$P(IBSTR,U,1)_U_$P(IBSTR,U,3)
 Q IBA
 ;
FNDSET(IBIN) ; set string to be saved in the return array
 ;
 ; IBIN - string to be parsed
 ;
 N IBF S IBF=""
 S IBF=+IBIN_U_($S($P(IBIN,U,3)'="":$P(IBIN,U,3),1:$P(IBIN,U,2)))_U_$P($G(^DIC(36,+IBIN,0)),U,2,999)
 Q IBF
 ;
ARSET(IBITM) ; set item into ARRY
 ;
 ; IBITM - data to be set into ARRY (form IEN^NAME^zero node minus .01)
 ;
 I IBITM="" Q
 S ARRY(+IBITM)=IBITM,ARRY=$G(ARRY)+1
 Q
 ;
INSD(IBARY,IBO,IBLM) ; display up to 5 insurances for selection at a time.
 ; IBARY - 5 items to display
 ; IBO - are there more to display
 ; IBLM - max number counter
 ;
 I $O(IBARY(0))="" Q ""
 N DIR,DIRUT,DIROUT,IBA,IBB,IBD,IBE,IBM,X,Y
 ; array is insurance name ^ insurance #36 ien ^ insurance real name(.01) if synonym is beibg used
INSDA ; loop back point
 K DIR
 S DIR(0)="LCO^1:"_IBLM,IBA=0 F  S IBA=$O(IBARY(IBA)) Q:'IBA  D
 . S IBD=IBARY(IBA)
 . S IBM=$P(IBD,U,1)
 . D DISPADDR(IBM,$P(IBD,U,2),IBA,"",$P(IBD,U,3))
 S DIR("?")="Enter the Item Number for the Insurance desired"
 S DIR("A")="CHOOSE"
 I IBO=1 D
 . S DIR("A",1)="Press "_($S(IBO=1:"<Enter> to see more, ",1:""))_"'^' to exit this list,  OR"
 D ^DIR
 I $E(Y)=U S IBFND=U Q IBFND
 I 'Y Q ""
 S IBE=$$IBESET($G(@IBTMPFIL@(+Y)))
 I $D(ARRY(+IBE)) D  G INSDA
 .W !!?3,"Already selected. Choose another insurance company.",!,*7
 ; return ien ^ name ^ zero node
 S IBFND=$$FNDSET(IBE)
 Q IBFND
 ;
DISPADDR(IBNAME,IBNMIEN,IBNUM,IBPCK,IBRNM) ; display the item with identifying info
 ;
 ; IBNAME - Item name to display
 ; IBIEN - Item IEN
 ; IBNUM - item number
 ; IBPCK - is this a picked item
 ; IBRNM - If IBNAME is a synonym this is the real name (.01)
 ;
 N DIC,IBAA,IBAB,IBAC,X,Y
 S DIC="^DIC(36,",IBNUM=$G(IBNUM),IBPCK=+$G(IBPCK),IBRNM=$G(IBRNM)
 I 'IBPCK W !
 I IBNUM W ?5,IBNUM,?10
 W IBNAME
 I IBRNM'="" W "  ",IBRNM
 S Y=IBNMIEN S IBAC=$G(^DIC(36,Y,0)),IBAA=""
 W " " F  S IBAA=$O(IBLKX(IBAA)) Q:'IBAA  S IBAB=$G(IBLKX(IBAA)) I IBAB'="" X IBAB
 ;
 Q
 ;
HLPLST ; list out Insurance cos. in 'B' index in groups of 20
 ;
 N DIC,DIR,DTOUT,DUOUT,IBA,IBB,IBC,IBD,IBOK,X,Y
 W !,"Answer with INSURANCE COMPANY NAME, or SYNONYM"
 S IBD=$P($G(^DIC(36,0)),U,4)
 K DIR S DIR("A")="Do you want the entire "_IBD_"-Entry INSURANCE COMPANY List",DIR(0)="YO"
 D ^DIR
 I 'Y!(Y=U) Q
 D HLPLSA
 Q
 ;
HLPLSA ; to list all without question
 N DIC,DIR,DTOUT,DUOUT,IBA,IBB,IBC,IBD,IBOK,X,Y
 S IBA="",IBC=0 K DIR
 F  S IBA=$O(^DIC(36,"B",IBA)) Q:IBA=""  S IBOK=1 D  Q:'IBOK
 . S IBB="" F  S IBB=$O(^DIC(36,"B",IBA,IBB)) Q:IBB=""  S IBC=IBC+1 D  Q:'IBOK
 .. D DISPADDR(IBA,IBB,"","")
 .. I IBC#20'=0 Q
 .. S DIR(0)="E" D ^DIR K DIR
 .. I $D(DTOUT)!($D(DUOUT)) S IBOK=0
 W !!,"        You may enter a new INSURANCE COMPANY, if you wish"
 W !,"        Answer must be 3-30 characters in length."
 Q
 ;
