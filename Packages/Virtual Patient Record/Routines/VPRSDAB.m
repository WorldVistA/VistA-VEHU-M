VPRSDAB ;SLC/MKB -- SDA Lab utilities ;4/11/19  21:05
 ;;1.0;VIRTUAL PATIENT RECORD;**20,26,27,31,35**;Sep 01, 2011;Build 16
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DDE                          7008
 ; ^LAB(60                      10054
 ; ^LR                            525
 ; ^OR(100                       5771
 ; ^ORD(100.98                   6982
 ; ^ORD(101.43                   2843
 ; DIC                           2051
 ; DIQ                           2056
 ; LR7OR1,  ^TMP("LRRR",$J       2503
 ; LR7OSUM, ^TMP("LR"*,$J        2766
 ; LR7OU1                        2955
 ; LRPXAPIU                      4246
 ; ORQ1,    ^TMP("ORR",$J)       3154
 ; ORX8                     2467,3071
 ;
ORDERS ; -- Return DLIST(#)=order# of Lab orders
 ; Includes VBECS/BB orders [not in use yet]
 ; Expects DFN, DSTRT,DSTOP, DMAX
 N ORDG,VBECS,ORIGVIEW,ORKID,ORLIST,VPRI,VPRN,ORDER,X0,X3
 S ORDG=+$O(^ORD(100.98,"B","LAB",0))
 S VBECS=+$$FIND1^DIC(9.4,,"QX","VBEC","C")
 ; return original view, child orders
 S ORIGVIEW=2,ORKID=1
 D EN^ORQ1(DFN_";DPT(",ORDG,6,,DSTRT,DSTOP,,,,1) S VPRN=0
 S VPRI=0 F  S VPRI=$O(^TMP("ORR",$J,ORLIST,VPRI)) Q:VPRI<1  S ORDER=$G(^(VPRI)) D  Q:VPRN'<DMAX
 . I $P($P(ORDER,U),";",2)>1 Q  ;skip order actions
 . S ORDER=+ORDER,X0=$G(^OR(100,ORDER,0)),X3=$G(^(3))
 . Q:$P(X3,U,3)=13  Q:$P(X3,U,3)=14  ;cancelled or lapsed
 . ; only VBECS parent orders, to get to veiled child orders
 . I $O(^OR(100,ORDER,2,0)) Q:$P(X0,U,14)'=VBECS  D  Q
 .. S ORKID=0 F  S ORKID=$O(^OR(100,ORDER,2,ORKID)) Q:ORKID<1  D
 ... Q:$P($G(^OR(100,ORKID,0)),U,14)'=VBECS  ;VBECS child orders
 ... S VPRN=VPRN+1,DLIST(VPRN)=ORKID
 . I $P(X3,U,9),$P($G(^OR(100,+$P(X3,U,9),0)),U,14)=VBECS Q
 . S VPRN=VPRN+1,DLIST(VPRN)=ORDER
 K ^TMP("ORR",$J)
 Q
 ;
ONE(ID) ; -- ID processing for Lab order returns: [not in use yet]
 ;    ORPK = Lab order/data string
 ;   ORDAD = parent order#
 ;  VPRCDT = Lab collection (start) date.time
 ; VPRVBEC = 1 or 0, if VBECS order
 ;   ORLAB = associated Lab child order#, if VBECS
 ;
 S ID=+$G(ID) Q:ID<1  S ORLAB=""
 S VPRCDT=$P($G(^OR(100,ID,0)),U,8),ORDAD=$P($G(^(3)),U,9),ORPK=$G(^(4))
 S VPRVBEC=$$VB(ID) I VPRVBEC D  Q  ;get lab child#
 . S ORLAB=$$VALUE^ORX8(ID,"LAB") I 'ORLAB S DDEOUT=1 Q
 . S VPRCDT=$P($G(^OR(100,ORLAB,0)),U,8),ORPK=$G(^(4))
 Q
 ;
VB(ORIFN) ; -- return 1 or 0, if order is for Blood Bank
 N X,Y,DG S Y=0
 S X=$P($G(^OR(100,+$G(ORIFN),0)),U,11),DG=$P($G(^ORD(100.98,+X,0)),U,3)
 I DG?1"VB".E S Y=1
 Q Y
 ;
DG(DG) ; -- convert DG to section, if needed
 ; Returns LRSUB = DG abbreviation
 N X,Y S X="",Y=0 D  ;get LR section
 . S X=$P($G(ORPK),";",4) Q:$L(X)
 . S X=$P($G(^ORD(101.43,+$G(ORIT),"LR")),U,6) Q:$L(X)
 . I $G(VPRVBEC) S X="VBEC"
 I X'="" S Y=$O(^ORD(100.98,"B",X,0)) S:Y DG=Y
 S LRSUB=$P($G(^ORD(100.98,+$G(DG),0)),U,3)
 Q
 ;
LRDFN(ORIFN) ; -- set up LRDFN for Lab Order
 I '$G(DFN),$G(ORIFN) S DFN=+$$GET1^DIQ(100,+ORIFN_",",.02,"I")
 S LRDFN=$S($G(DFN):$$LRDFN^LRPXAPIU(DFN),1:0)
 Q
 ;
RSLT ; -- get Entity for LabOrder Result
 ; Returns VALUE, ENTITY, DATA
 N SUB,IDT S SUB=$S($G(VPRVBEC):"BB",1:$G(LRSUB))
 I SUB="BB" S DDEOUT=1 Q  ;for now
 S IDT=$P($G(ORPK),";",5) S:'IDT IDT=9999999-$G(VPRCDT)
 S VALUE=IDT_","_+$G(LRDFN),ENTITY="VPR LR"_SUB_" RESULT"
 S ENTITY=+$O(^DDE("B",ENTITY,0)) I ENTITY<1 S DDEOUT=1 Q
 S DATA=+$P($G(ORIT),U,3) ;#60 ien ordered
 Q
 ;
CH(TEST) ; -- builds DLIST(#) of result nodes for TEST
 ; called from ResultItems in VPR LRCH RESULT, expects DIEN
 Q:'$P($G(LR0),U,3)  ;only return final results
 N T,X S TEST=+$G(TEST)
 D EXPAND^LR7OU1(TEST,.DLIST)
 S T=0 F  S T=$O(DLIST(T)) Q:T<1  D
 . S X=$P($G(^LAB(60,T,0)),U,3) I X'="O",X'="B" Q  ;not displayable
 . ; DLIST(60 ien) = CH data node#,LRIDT,LRDFN
 . S DLIST(T)=$$LRDN^LRPXAPIU(T)_","_DIEN
 Q
 ;
VALRNG(LOW,HIGH) ; -- Validate that range values will be accepted in SDA format for <ResultNormalRange> post REFRNG execution
 ;LOW - Range low value
 ;HIGH - range high value
 ;RESULT - Ture/False value, will pass or fail SDA <ResultNormalRnage> format
 N RESULT
 S RESULT=1
 S LOW=$G(LOW),HIGH=$G(HIGH)
 ;Strip any surrounding quotes
 I LOW?1"""".E1"""" S LOW=$E(LOW,2,$L(LOW)-1)
 I HIGH?1"""".E1"""" S HIGH=$E(HIGH,2,$L(HIGH)-1)
 ;If both parameters are defined, we have a ##-## range and the first character of LOW and HIGH must be numeric.
 I LOW'="",(HIGH'="") D
 .I $E(LOW)'?1N,($E(LOW,1,2)'?1"."1N) S RESULT=0
 .I $E(HIGH)'?1N,($E(HIGH,1,2)'?1"."1N) S RESULT=0
 Q RESULT
 ;
REFRNG(RLV,RHV) ; -- format low-high ref range string
 ;RLV - Range low value
 ;RHV - Range high value
 ;Based on supported EN^LRLRRVF
 S RLV=$G(RLV),RHV=$G(RHV)
 I RLV="",RHV="" Q RLV
 ;Strip any surrounding quotes
 I RLV?1"""".E1"""" S RLV=$E(RLV,2,$L(RLV)-1)
 I RHV?1"""".E1"""" S RHV=$E(RHV,2,$L(RHV)-1)
 ;If only the low is defined
 I RLV'="",RHV="" D  Q RLV
 . I RLV=0 S RLV=">"_RLV Q
 . I ($E(RLV)="<")!($E(RLV)=">") Q   ;ok
 . I (RLV?.N.".".N) S RLV=">"_RLV Q  ;numeric
 . ;else return RLV as is (non-numeric)
 ;If only the high is defined
 I RLV="",RHV'="" D  Q RHV
 . I RHV=0 S RHV="<"_RHV Q
 . I ($E(RHV)="<")!($E(RHV)=">") Q   ;ok
 . I (RHV?.N.".".N) S RHV="<"_RHV Q  ;numeric
 . S RHV="-"_RHV
 ;If both are defined
 Q RLV_"-"_RHV
 ;
MI1(D0,D1) ; -- return MI approval node
 N GBL,N,X,Y
 S D0=+$G(D0),D1=+$G(D1),GBL=$NA(^LR(D0,"MI",D1)),Y=""
 F N=1,5,8,11,16 S X=$G(@GBL@(N)) I X,$P(X,U,2)="F" D  Q
 . S Y=$P(X,U,1,2)_U_$S(N=11:$P(X,U,5),1:$P(X,U,3))
 Q Y
 ;
APRPTS ; -- Anatomic Pathology reports query [from DDEGET]
 ; Expects DFN, DSTRT,DSTOP, DMAX, LRDFN
 ; Return DLIST(#) = IDT,LRDFN~SUB
 N SUB,IDT,VPRN,CTR S VPRN=0
 D RR^LR7OR1(DFN,,DSTRT,DSTOP,"AP")
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB=""  D
 . S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  I $O(^(IDT,0)) D  Q:VPRN'<DMAX
 .. Q:$O(^LR(LRDFN,SUB,IDT,.05,0))        ;report in TIU
 .. Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,11)  ;not final results
 .. S VPRN=VPRN+1,DLIST(VPRN)=IDT_","_LRDFN_"~"_SUB
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
MIRPTS ; -- Microbiology reports query [from DDEGET]
 ; Expects DFN, DSTRT,DSTOP, DMAX, LRDFN
 ; Return DLIST(#) = IDT,LRDFN~SUB
 N IDT,VPRN,CTR S VPRN=0
 D RR^LR7OR1(DFN,,DSTRT,DSTOP,"MI")
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,"MI",IDT)) Q:IDT<1  I $O(^(IDT,0)) D  Q:VPRN'<DMAX
 . ;Q:'$P($G(^LR(LRDFN,"MI",IDT,0)),U,3)  ;not final results
 . Q:'$$MI1^VPRSDAB(LRDFN,IDT)  ;not final results
 . S VPRN=VPRN+1,DLIST(VPRN)=IDT_","_LRDFN_"~MI"
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
AP1(ID) ; -- parse ID='IDT,LRDFN~SUB' for AP,MI report
 ; Returns DIFN, LRSUB, updated ID, LR0=^LR(LRDFN,SUB,IDT,0)
 ;     and LR1=^LR(LRDFN,"MI",IDT,#) report approval if MI
 S ID=$G(ID),LRSUB=$P(ID,"~",2),ID=$P(ID,"~")
 I LRSUB D  ;sub-file#
 . S DIFN=LRSUB,LRSUB=$S(DIFN=63.05:"MI",DIFN=63.09:"CY",DIFN=63.02:"EM",DIFN=63.08:"SP",1:"AP")
 E  S DIFN=$S(LRSUB="MI":63.05,LRSUB="CY":63.09,LRSUB="EM":63.02,LRSUB="SP":63.08,1:0)
 I DIFN<1 S DDEOUT=1 Q
 S:'$G(LRDFN) LRDFN=+$P(ID,",",2)
 S LR0=$G(^LR(LRDFN,LRSUB,+ID,0))
 I LRSUB="MI" S LR1=$$MI1(LRDFN,+ID)
 Q
 ;
RR ; -- returns addl reports for order in DLIST(#) = IDT;SUB or IEN;TIU
 ; Expects DFN, ORPK, LRDFN
 N SUB,IDT,X,CNT
 Q:$G(DFN)<1  Q:$P($G(ORPK),";",4)=""
 D RR^LR7OR1(DFN,ORPK)
 S SUB=$P(ORPK,";",4),CNT=0
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  D
 . Q:$P(ORPK,";",5)=IDT  ;returned in Result.DocumentNumber
 . I SUB="MI" Q:'$$MI1(LRDFN,IDT)  S X=IDT_";MI"
 . I SUB'="MI" Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,11)  S X=$$LRTIU(SUB,IDT)
 . S CNT=CNT+1,DLIST(CNT)=X
 Q
 ;
LRTIU(IDT,SUB) ; -- return TIU ien of lab report
 N I,IEN,X,Y
 S IDT=$G(IDT),SUB=$G(SUB),Y=IDT_";"_SUB
 S I=0 F  S I=$O(^LR(LRDFN,SUB,IDT,.05,I)) Q:I<1  S IEN=+$P($G(^(I,0)),U,2),X=+$$GET1^DIQ(8925,IEN,.05,"I") I (X=7)!(X=8) S Y=IEN_";TIU" Q
 Q Y
 ;
RPT(SUB,IDT) ; -- return report text in WP(), expects DFN
 N I,DATE,NAME,VPRS,VPRY,X,LRAU
 N LRSUB,TAG,FILE,FIELD,IEN ;protect
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 S DATE=9999999-+$G(IDT),NAME=$S(SUB="EM":"EM",1:$$NAME^VPRDLRA(SUB)),VPRS(NAME)=""
 D EN^LR7OSUM(.VPRY,DFN,DATE,DATE,,,.VPRS)
 S I=+$G(^TMP("LRH",$J,NAME)) ;LRH=header
 F  S I=$O(^TMP("LRC",$J,I)) Q:I<1  S X=$G(^(I,0)) Q:X?1."="  S WP(I)=X
 K ^TMP("LRC",$J),^TMP("LRH",$J),^TMP("LRT",$J)
 Q
