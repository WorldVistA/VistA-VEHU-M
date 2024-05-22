IBCSC10 ;ALB/MJB - MCCR SCREEN 10 (UB-82 BILL SPECIFIC INFO)  ;27 MAY 88 10:20
 ;;2.0;INTEGRATED BILLING;**432,547,574,592,759**;21-MAR-94;Build 24
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;MAP TO DGCRSC8
 ;
 ; DEM;432 - Moved IBCSC8* billing screen routines to IBCSC10* billing screen
 ;           routines and created a new billing screen 8 routine IBCSC8.
 ;
 ;JWS;IB*2.0*592 US1108 - Dental form 7
EN S IBCUBFT=$$FT^IBCU3(IBIFN) I IBCUBFT=2!(IBCUBFT=7) K IBCUBFT G ^IBCSC10H ; hcfa 1500 ;JWS 3/6/17 Dental Form
 I IBCUBFT=3 K IBCUBFT G ^IBCSC102 ; ub-92
 ;I $P(^DGCR(399,IBIFN,0),"^",19)=2 G ^IBCSC10H ;hcfa 1500
 D ^IBCSCU S IBSR=10,IBSR1="",IBV1="000000000" S:IBV IBV1="111111111" F I="U","U1",0 S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 D H^IBCSCU
 S Z=1,IBW=1 X IBWW W " Bill Remark    : ",$S($P(IB("U1"),U,8)]"":$P(IB("U1"),U,8),1:IBUN)
 S IBX="^^^2^9^27^45" F I=4:1:7 S Z=(I-2),IBW=1 X IBWW W " Form Locator ",$P(IBX,U,I),$S($E($P(IBX,U,I),2)="":" : ",1:": "),$S($P(IB("U1"),U,I)]"":$P(IB("U1"),U,I),1:IBUN)
 S IBX=91 F I=13,14 S Z=(I-7),IBW=1,IBX=IBX+1 X IBWW W " Form Locator ",IBX,": ",$S($P(IB("U1"),U,I)]"":$P(IB("U1"),U,I),1:IBUN)
 S Z=8,IBW=1 X IBWW W " Tx Auth. Code  : ",$S($P(IB("U"),U,13)]"":$P(IB("U"),U,13),1:IBUN)
 G ^IBCSCP
Q Q
 ;
 ;WCJ;IB*2.0*547
ACINTEL(IBINSDAT,IBNEXT) ; build some intelligence in this Alternate ID branching logic called from both screen 10 templates.
 ;
 ; assumes IBIFN = the ien to file 399
 ;
 ; Input:
 ; IBINSDAT - INS DATA node
 ; IBNEXT - where to branch if not correct plan
 ;
 ; Returns - where to branch to
 ; kind of misleading.  It either changes IBNEXT to null or leaves it alone.
 ; Assumes calling routine knew where to branch to if it failed
 ;
 N IBPLAN,IBEPT,IBINSPRF
 S IBPLAN=$P(IBINSDAT,U,18)
 I IBPLAN=""  Q IBNEXT
 S IBPLAN=$G(^IBA(355.3,+IBPLAN,0))
 I IBPLAN="" Q IBNEXT
 S IBEPT=$P(IBPLAN,U,15)
 I IBEPT="" Q IBNEXT
 I IBEPT="MX" Q:'$D(^IBE(350.9,1,81,"B")) IBNEXT  ; no medicare set up in site parameters
 I IBEPT'="MX" Q:'$D(^IBE(350.9,1,82,"B")) IBNEXT   ; no commercial set up in site parameters
 ;
 ; Use form type not charge type 09/07/2016
 ;S IBINSPRF=$$INSPRF^IBCEF(IBIFN)
 S IBINSPRF=$$FT^IBCEF(+IBIFN)=3  ; set IBINST flag=1 if it is institutional,0 for professional.
 ;
 ; Institutional
 I IBINSPRF=1 Q:'$D(^DIC(36,+IBINSDAT,15,"B")) IBNEXT   ; this insurance company has no institutional set up
 ;
 ; Professional
 I IBINSPRF=0 Q:'$D(^DIC(36,+IBINSDAT,16,"B")) IBNEXT  ; this insurance company has no professional set up
 ;
 ; now it gets complicated :)
 ; there needs to be one set up for this form type in the ins comp file
 ; and also set up for medicare/commercial in the site parameter file
 N IBTMPINS,IBTMPSP,IBLOOP,IBFOUND
 M IBTMPINS=^DIC(36,+IBINSDAT,$S(IBINSPRF=1:15,1:16),"B")
 M IBTMPSP=^IBE(350.9,1,$S(IBEPT="MX":81,1:82),"B")
 S IBLOOP="",IBFOUND=0
 F  S IBLOOP=$O(IBTMPINS(IBLOOP)) Q:IBLOOP=""  D  Q:IBFOUND
 . Q:'$D(IBTMPSP(IBLOOP))
 . S IBFOUND=1
 I IBFOUND Q ""
 Q IBNEXT
 ;
 ;WCJ;IB759
BBB(IBIFN) ; aka Baby Bird Beaks
 ; this is an API to tell if any insurer on the claim has Alternate Payer IDs properly defined.
 ; If not, it returns a 0 and the section of the billing screen is uneditable
 ; which shows as <#> to the biller
 ;
 ; Input:
 ; IBIFN - Internalk Entry Number to file 399
 ;
 ; Returns 1 or 0, yay or nay
 N IBDATA,IBRESULT,IBLOOP,IBX
 S IBRESULT=0
 F IBLOOP=1:1:3 S IBDATA=$G(^DGCR(399,IBIFN,"I"_IBLOOP)) I IBDATA]""  S IBX=$$ACINTEL(IBDATA,"@WHATEVER") I IBX'="@WHATEVER" S IBRESULT=1 Q
 Q IBRESULT
 ;
 ;IBCSC10
