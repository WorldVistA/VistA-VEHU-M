IBCF23 ;ALB/ARH - HCFA 1500 19-90 DATA (block 24, procs and charges) ;12-JUN-93
 ;;2.0;INTEGRATED BILLING;**52,80,106,122,51,152,137,402,432,488,547,592**;21-MAR-94;Build 58
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;requires IBIFN,IB(0),IB("U"),IB("U1"), returns # of line items in IBFLD(24)
 ;rev code array: IBRC("proc^division^basc flag^bedsection^rev code^unit chrg^Rx seq #")=units
 ;proc array:    IBCP(initial print ord)=proc date^proc^division^basc flag^dx^pos^tos^modifier^unit chrg^purch chrg amt^anesthesia mins^emerg indicator
 ;                    IBCP(initial print order,seq #)=auxillary data
 ;proc array:    IBSS("proc^division^basc flag^dx^pos^tos^modifier^unit chrg^Rx seq #")=lowest inital print order
 ;print order array:  IBPO(final print ord,emerg indicator,initial print order)=""
 ;print array:        IBFLD(24,I)=begin dt^end dt^pos^tos^proc^dx^unit chrg^units^modifier pointer ien(s) separated by commas^purch chrg amt^anesthesia mins^emerg indicator
 ;                    IBFLD(24,I,"AUX")=[auxillary data]
 ;                                 = "AUX" node of proc entry
 ;                    IBFLD(24,I,"RX")= soft link to file 362.4 or null
 ;                         if service is Rx, but no soft link
 ;                                   
 ;charge item link:   IBLINK(CPT IFN in multiple,RCIFN) = proc^division^basc flag^bedsection^rev code^unit chrg^rx seq #
 ;
 ; dx's used in arrays are ref #s
 ; IB*547 added backwards compatibility so that MRAs and EOBs would still roll/split procedures the same way as when the claim
 ;        was created.  Any claim transmitted before IB*547 was installed will roll/split the original way and any new
 ;        claim or claim transmitted after IB*547 was transmitted will roll/split the new way.
 ;        When updating in the future care must be taken to disable/remove older code so that only new changes are
 ;        affected by the IBNWPTCH variable.
 ;
RVC ; charges array
 D RVCE(,IBIFN)
 Q
 ;
RVCE(IBXIEN,IBIFN) ;Entry for EDI formatter call (IBXIEN will be defined)
 ; IBIFN required
 N IBRC,IBCP,IBSS,IBSSO,IBSS1,IBPO,IBLINK,IBLINK1,IBLINKRX,IBK,IBAUXLN
 ;JWS;IB*2.0*592;US131
 N IBI,IBJ,IB11,IBLN,IBPDT,IBCHARG,IBMOD,IBPC,IBRX,IBRXF,IBPO2A,IBAUX,IBNWPTCH,IBDEN,IBDEN1,IBDEND
 ;
 ; IB*547/TAZ - Add IBNWPTCH variable.
 S IBRX=0,IBNWPTCH=$$IBNWPTCH^IBCF23A(IBIFN,"IB*2.0*547")
 S IBI=0 F  S IBI=$O(^DGCR(399,IBIFN,"RC",IBI)) Q:'IBI  S IBLN=^(IBI,0) D
 . S IBSS="",IBPC=0 F IBJ=6,7,0,5,1,2,14 S IBPC=IBPC+1 S:IBJ $P(IBSS,U,IBPC,IBPC+1)=($P(IBLN,U,IBJ)_U)
 . I $P(IBSS,U,2)="" S $P(IBSS,U,2)=$P(^DGCR(399,IBIFN,0),U,22)
 . I +IBSS S $P(IBSS,U)=$P(IBSS,U)_";ICPT("
 . S $P(IBSS,U,3)=$S($D(^DGCR(399,"ASC1",+$P(IBLN,U,6),IBIFN,IBI)):1,1:"")
 . I +$P(IBLN,U,10)=3 D  Q  ; Rx
 .. I '$P(IBLN,U,15) S IBRX=IBRX+1,$P(IBSS,U,8)=(100+IBRX)
 .. I $P(IBLN,U,15) S $P(IBSS,U,8)=$P(IBLN,U,15)
 .. S IBRC(IBSS,"RX")=$P(IBLN,U,11)_U_IBI_U_$P(IBLN,U,15)
 .. S IBRC(IBSS)=$G(IBRC(IBSS))+1
 . ;
 . S IBRC(IBSS)=$G(IBRC(IBSS))+$P(IBLN,U,3) ; total units for similar RC
 . I "4"[+$P(IBLN,U,10),$P(IBLN,U,11) D  ; Soft-link proc with the rev cd
 .. S IBLINK(+$P(IBLN,U,11),IBI)=IBSS
 .. S $P(IBLINK(+$P(IBLN,U,11),IBI),U,7)=$P(IBLN,U,14)
 . I $P(IBLN,U,10) D
 .. S IBLINK1(IBSS,IBI)=$P(IBLN,U,10)_U_+$P(IBLN,U,11)
 . S IBRC(IBSS,"LNK")=IBI
 ;
 S IBSSO="" F  S IBSSO=$O(IBRC(IBSSO)) Q:IBSSO=""  I $D(IBRC(IBSSO,"RX")) D
 . S IBSS=IBSSO,IBI=$P(IBRC(IBSSO,"RX"),U,2),IB11=$P(IBRC(IBSSO,"RX"),U,3)
 . S IBRC(IBSSO)=1,IBLINKRX($S($P(IBSSO,U)>0:$P(IBSSO,U),$P($G(^DGCR(399,IBIFN,"CP",+IB11,0)),U)'="":$P(^(0),U),1:0),+IB11,+IBRC(IBSSO,"RX"))=IBSSO K IBRC(IBSSO,"RX")
 ;
 D PRC^IBCF23A ; Extract procedures
PO ; print order array w/chrgs
 ; combine multiple entries of same proc onto one line item via print order
 ;if both have print orders defined then they should not be combined onto one line item
 ;"proc^division^basc^dx^pos^tos^modifier(s)^unit chrg^purchased chg" must all be the same as well as the emergency indicator and all 'aux flds'
 N IBP,Z,IBPO11
 ;IB*547/TAZ - set entire node into IBSS for post IB*547 claims
 ;S IBPO="" F  S IBPO=$O(IBCP(IBPO)) Q:'IBPO  S IBCP=IBCP(IBPO),IBSS=$P(IBCP,U,2,9),IBSS1="*"_$G(IBCP(IBPO,"AUX")),IBAUX=0 D
 S IBPO="" F  S IBPO=$O(IBCP(IBPO)) Q:'IBPO  S IBCP=IBCP(IBPO),IBSS=$P(IBCP,U,2,$S(IBNWPTCH:$L(IBCP,U),1:9)),IBSS1="*"_$G(IBCP(IBPO,"AUX")),IBAUX=0 D
 . I $D(IBSS(IBSS)),'$D(IBCP(IBPO,"RX")),IBPO>1000 D  Q  ; combine lines
 .. I 'IBAUX S IBAUX=$$AUXOK^IBCF23A(.IBSS,IBSS1)
 .. S IBPO1=$S(IBAUX:IBSS(IBSS,IBAUX),1:IBPO)
 .. I 'IBAUX S Z=+$O(IBSS(IBSS,"A"),-1)+1,IBSS(IBSS,Z)=IBPO
 .. I IBPO>1000!(IBPO1>1000) S IBPO(IBPO1,+$P(IBCP,U,12),IBPO)="" D
 ... I $O(IBCP(IBPO,"L",0)) S Z=$O(IBCP(IBPO,"L",0)),IBPO(IBPO1,+$P(IBCP,U,12),IBPO,"L",Z)=IBCP(IBPO,"L",Z) K IBCP(IBPO,"L",Z)
 . S IBAUX=+$O(IBSS(IBSS,"A"),-1)+1,IBSS(IBSS,"AUX-X",IBAUX)=IBSS1
 . S IBSS(IBSS,IBAUX)=+IBPO,IBPO(+IBPO,+$P(IBCP,U,12),IBPO)=""
 . S Z=0 F  S Z=$O(IBCP(IBPO,Z)) Q:'Z  S IBPO(+IBPO,+$P(IBCP,U,12),IBPO,Z)=""
 . I $O(IBCP(IBPO,"L",0)) S Z=$O(IBCP(IBPO,"L",0)),IBPO(+IBPO,+$P(IBCP,U,12),IBPO,"L",Z)=IBCP(IBPO,"L",Z) K IBCP(IBPO,"L",Z)
 . S IBSS(IBSS,IBAUX,"AUX")=IBSS1,IBPO(+IBPO,+$P(IBCP,U,12),IBPO,"AUX")=$E(IBSS1,2,$L(IBSS1))
 . I $D(IBCP(IBPO,"RX")) S IBPO(+IBPO,+$P(IBCP,U,12),IBPO,"RX")=IBCP(IBPO,"RX"),IBSS(IBSS,IBAUX,"RX")=IBCP(IBPO)
 . ;JWS;IB*2.0*592;US131
 . I $D(IBCP(IBPO,"DEND")) S IBPO(+IBPO,+$P(IBCP,U,12),IBPO,"DEND")=IBCP(IBPO,"DEND")
 . I $D(IBCP(IBPO,"DEN")) S IBPO(+IBPO,+$P(IBCP,U,12),IBPO,"DEN")=IBCP(IBPO,"DEN")
 . I $D(IBCP(IBPO,"DEN1")) M IBPO(+IBPO,+$P(IBCP,U,12),IBPO,"DEN1")=IBCP(IBPO,"DEN1")
 . ;end ;JWS;IB*2.0*592;US131;
 ; Find any remaining rev codes w/units that ref existing procedures
 S IBP(0)=0
 F IBP=3,2 Q:$G(IBP(0))  S IBRV="" F  S IBRV=$O(IBRC(IBRV)) Q:IBRV=""  I IBRV,IBRC(IBRV) D
 . S IBSS1=$O(IBSS($P(IBRV,U,1,IBP))) Q:$P(IBRV,U,1,IBP)'=$P(IBSS1,U,1,IBP)
 . S IBP(0)=1,Z=0
 . F  S Z=$O(IBSS(IBSS1,Z)) Q:'Z  I $G(IBSS(IBSS1,Z)) D  Q
 .. I $D(IBCP(IBSS(IBSS1,Z))),$P(IBCP(IBSS(IBSS1,Z)),U,9)=$P(IBSS1,U,8) D
 ... N Q,Q0
 ... ; S Q=$O(IBCP(""),-1)+1,Q0=$P(IBCP(IBSS(IBSS1,Z)),U,12) ; WCJ;IB*488
 ... S Q=IBSS(IBSS1,Z),Q0=$P(IBCP(IBSS(IBSS1,Z)),U,12) ; WCJ;IB*488
 ... ;M IBPO(Q,$P(IBCP(IBSS(IBSS1,Z)),U,12),Q)=IBPO(IBSS(IBSS1,Z),$P(IBCP(IBSS(IBSS1,Z)),U,12),IBSS(IBSS1,Z)),IBCP(Q)=IBCP(IBSS(IBSS1,Z))  ; WCJ;IB*488
 ... ;S $P(IBCP(Q),U,9)=$P(IBRV,U,6) ; WCJ;IB*488
 ... ;F Z0=1:1:(IBRC(IBRV)-1) S IBPO(Q,Q0,Q+(Z0*.01))=IBPO(Q,Q0,Q)  I Z0=99,(IBRC(IBRV)'=100) S IBPO(Q,Q0,Q_".991")=(IBRC(IBRV)-1)_"^99" Q  ; Only put first 99 in array
 ... F Z0=1:1:(IBRC(IBRV)) S IBPO(Q,Q0,Q+(Z0*.001))=IBPO(Q,Q0,Q)  ; changing to .001 allows us up to 999 and the units field only allows 800. ; WCJ;IB*488
 ... S IBRC(IBRV)=0
 ;
PRTARR ;print proc array
 S IBREV="",IBPO1="",IBI=0 F  S IBPO1=$O(IBPO(IBPO1)) Q:IBPO1=""  D
 . ;JWS;IB*2.0*592; NEED TO CLEAR IBDEN1 array
 . K IBRXF,IBDEN1
 . S IBEMG="" F  S IBEMG=$O(IBPO(IBPO1,IBEMG)) Q:IBEMG=""!("01"'[IBEMG)  S IBPO2="" D
 .. S IBDT1=99999999,IBDT2="",(IBMIN,IBUNIT)=0,(IBCHARG,IBAUX)=""
 .. F  S IBPO2=$O(IBPO(IBPO1,IBEMG,IBPO2)) Q:IBPO2=""  D
 ... I IBPO2#1=.991 D  Q:IBPO2#1=.991
 .... N Z
 .... S Z=$G(IBPO(IBPO1,IBEMG,IBPO2)) Q:'Z
 .... I ($P(Z,U,2)+1)>Z Q
 .... S $P(IBPO(IBPO1,IBEMG,IBPO2),U,2)=($P(Z,U,2)+1),IBPO2=(IBPO2\1)_".99"
 ... S Z=0 F  S Z=$O(IBPO(IBPO1,IBEMG,IBPO2,Z)) Q:'Z  S IBUNIT=IBUNIT+1
 ... I $D(IBCP(IBPO1)) S IBPO11=IBPO1
 ... S IBPO2A=$S($D(IBCP(IBPO2\1)):IBPO2\1,'$D(IBCP(IBPO2)):IBPO11,1:IBPO2)
 ... S IBCHARG=$P(IBCP(IBPO2A),U,9),IBPCHG=$P(IBCP(IBPO2A),U,10)
 ... ; I IBCHARG<10000,IBCHARG*(IBUNIT+1)'<10000 D  Q  ;$9,999 limit per line ;WCJ IB*488
 ... I IBCHARG<10000000,IBCHARG*(IBUNIT+1)'<10000000 D  Q  ; increased to $9,999,999 charge limit per line since that is printed form space limit ;WCJ IB*488
 .... N Z S Z=$O(IBPO(IBPO1\1+1),-1),Z=Z+$S(IBPO1+.001'=Z:.001,1:0) M IBPO(Z,IBEMG,IBPO2)=IBPO(IBPO1,IBEMG,IBPO2) K IBPO(IBPO1,IBEMG,IBPO2)
 ... S IBUNIT=IBUNIT+1,IBSS=IBCP(IBPO2A),IBMIN=IBMIN+$P(IBSS,U,11)
 ... S IBSS=$G(IBSS)_U_$G(IBCP(IBPO2A,"LNK"))
 ... S Z=$O(IBPO(IBPO1,IBEMG,IBPO2,"L",0)) I Z D
 .... S Z0=0
 .... F Z=Z:1 Q:'$O(IBPO(IBPO1,IBEMG,IBPO2,"L",0))!(Z0=IBUNIT)  I $D(IBPO(IBPO1,IBEMG,IBPO2,"L",Z))  S IBSS("L",Z)=IBPO(IBPO1,IBEMG,IBPO2,"L",Z),Z0=Z0+1 K IBPO(IBPO1,IBEMG,IBPO2,"L",Z)
 ... S:IBDT1>+IBSS IBDT1=+IBSS S:IBDT2<+IBSS IBDT2=+IBSS
 .. S IBAUX=$G(IBCP(IBPO1,"AUX")) S:$D(IBCP(IBPO1,"RX")) IBRXF=IBCP(IBPO1,"RX")
 .. ;JWS;IB*2.0*592;US131
 .. S IBDEN=$G(IBCP(IBPO1,"DEN"))
 .. S IBDEND=$G(IBCP(IBPO1,"DEND"))
 .. I $D(IBCP(IBPO1,"DEN1")) M IBDEN1=IBCP(IBPO1,"DEN1")
 .. ;end ;JWS;IB*2.0*592;US131
 .. I IBUNIT D B24^IBCF23A
 .. K IBRXF
 ;
 ;print any chrgs not associated with a proc (ie. not enough procs or proc not in "CP" level)
 S IBRV="" F  S IBRV=$O(IBRC(IBRV)) Q:IBRV=""  I +IBRC(IBRV) D  D B24^IBCF23A K IBRXF
 . S IBUNIT=+IBRC(IBRV),IBCHARG=$P(IBRV,U,6),IBDT1=+IB("U"),IBDT2=$P(IB("U"),U,2),IBREV=$P(IBRV,U,5),IBEMG=0,IBAUX=""
 . S IBSS="^"_$S(+IBRV:$P(IBRV,U),1:$P($G(^DGCR(399.1,+$P(IBRV,U,4),0)),U))
 . S IBSS=$G(IBSS)_U_$$RC2CP^IBCEF22(IBIFN,+$G(IBRC(IBRV,"LNK")))
 . S Z=$O(IBLINK1(IBRV,0)) I Z D
 .. S Z0=0
 .. F Z=Z:1 Q:'$O(IBLINK1(IBRV,0))!(Z0=IBUNIT)  I $D(IBLINK1(IBRV,Z)) S IBSS("L",Z)=IBLINK1(IBRV,Z),Z0=Z0+1 K IBLINK1(IBRV,Z)
 ;
OFFSET ;
 S IBFLD(24)=IBI ;line item count
 K IBRC,IBCP,IBSS,IBPO,IBPO1,IBPO2,IBLN,IBRV,IBRV1,IBPDT,IBDT1,IBDT2,IBCHARG,IBMIN,IBUNIT,IBREV,IBLINK,IBLINK1,IBEMG,IBPCHG,Z
 Q
 ;
DATE(X) ; Fm dt in X ==> YYYYMMDD
 Q $$DT^IBCEFG1(X,,"D8")
 ;
B24 ; Moved to IBCF23A for space
 D B24^IBCF23A
 Q
 ;
