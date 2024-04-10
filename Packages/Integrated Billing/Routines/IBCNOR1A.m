IBCNOR1A ;AITC/DTG - PATIENT MISSING COVERAGE REPORT ;08/14/23
 ;;2.0;INTEGRATED BILLING;**771**;21-MAR-94;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
COMPILE(IBCNORRTN,IBCNOR) ; Entry Point called from EN^XUTMDEVQ.
 ; IBCNORRTN = Routine name for ^TMP($J,...
 ;    IBCNOR = Array of params
 ; Input:
 ; IBCNOR("IBI")  = select INS 0 some, 1 all
 ; IBCNOR("IBIA") = only 1-Active Insurance Companies
 ; IBCNOR("IBIG") = 0-Selected, 1-All Group Plans
 ; IBCNOR("IBIGA")= only 1-Active Group Plans
 ; IBCNOR("IBIGN")= 1-Group Name, 2-Group Number, 3-Both Group Name and Group Number
 ; IBCNOR("IBFIL")= A^B^C where"
 ;                    A - 1-Begin with, 2-Contains, 3-Range
 ;                    B - A=1 Begin with text, A=2 Contains text, A=3 Range start text
 ;                    C - only if A=3 Range End text
 ; IBCNOR("IBOUT")  E-EXCEL, R-REPORT
 ;
 ;
 ; Compile and Print Report
 N CRT,GDATA,GCT,GIEN,IBA,IBAR,IBC,IBCT,IBDOB,IBDOBI,IBEFFDT,IBEXPDT,IBIF,IBINS,IBITM,IBLNC,IBNA,IBNAM
 N IBNM,IBPGN,IBSSN,IBPTI,IBTMP,IBTYPE,IBXTFEED,ICT,IIEN,PLANOK,IBSCRCT,MAXCNT,X,Y
 ;
 S MAXCNT=IOSL-3,IBXTFEED=21,CRT=1,IBLNC=0
 I IOST'["C-" S MAXCNT=IOSL-6,IBXTFEED=50,CRT=0
 ; if selected insurances
 I 'IBCNOR("IBI") D
 . I $O(^TMP(IBJOB,"IBCNOR","FND",IBJOB,"INS","")) D
 . . K ^TMP("IBCNOR",$J,"INS") M ^TMP("IBCNOR",$J,"INS")=^TMP(IBJOB,"IBCNOR","FND")
 . I IBCNOR("IBIG") D
 . . D BLDINSGR^IBCNOR1  ; build insurance groups
 ;
 ; If ALL Insurance Companies, add to ^TMP("IBCNOR")
 I IBCNOR("IBI") D
 . S IIEN=0,INSCT=0 F  S IIEN=$O(^DIC(36,IIEN)) Q:'IIEN  D
 . . ; check insurance
 . . S INACT=+$$GET1^DIQ(36,IIEN_",",.05,"I") ;1=Inactive, 0=Active
 . . I INACT Q  ; only select active insurances
 . . S IBINAME=$$GET1^DIQ(36,IIEN_",",.01,"I")
 . . S IBOK=1 D CHKNM^IBCNOR1(IBINAME) Q:'IBOK  ; do not select if name is on exclusion list
 . . S INSCT=INSCT+1
 . . S ^TMP("IBCNOR",$J,"INS",INSCT)=IIEN
 . I $G(IOST)["C-" W !,"Build Insurance Groups...",!
 . D BLDINSGR^IBCNOR1  ; build insurance groups
 ;
 ;
 ; collect patients
 I $G(IOST)["C-" W !,"Collecting Subscribers ...",!
 D BLDPT  ; collect all patients (subscribers) associated to insurance / groups
 ;
 S IBSCRCT=0
 K ^TMP($J,"PR")
 ;
 S IBTMP="^TMP(""IBCNOR"","_$J_")"
 ; build pt list of insurances
 S IBPTI=0,IBCT=0 K @IBTMP@("OUT")
 I $G(IOST)["C-" W !,"Building Output ...",!
 F  S IBPTI=$O(@IBTMP@("P-PT",IBPTI)) Q:'IBPTI  K ^TMP($J,"PR") D  D COMPF
 . ; PT name
 . S IBITM=$G(@IBTMP@("P-PT",IBPTI))
 . S IBNAM=$P(IBITM,U,1)
 . S:IBNAM="" IBNAM="<Pt. "_IBPTI_" Name Missing>"
 . ; Retrieve last 4 of SSN (last 5 if pseudo SSN)
 .S X=$$GET1^DIQ(2,IBPTI_",",.09,"I")         ; Patient's SSN
 .S X=$S($E(X,$L(X))="P":$E(X,$L(X)-4,$L(X)),1:$E(X,$L(X)-3,$L(X)))
 .S IBSSN=X
 .S IBDOBI=$$GET1^DIQ(2,IBPTI_",",.03,"I"),IBDOB=$$DTC(IBDOBI)         ; Patient's DOB
 . ;
 . S IBIF=0 F  S IBIF=$O(^DPT(IBPTI,.312,IBIF)) Q:'IBIF  D
 . . ;
 . . S IBCT=IBCT+1 I $G(IOST)["C-"&(IBCT#1000=0) W "."
 . . ;
 . . K IBAR S IBA=IBIF_","_IBPTI_"," D GETS^DIQ(2.312,IBA,".01;8;3","EI","IBAR")
 . . S IBI36=$G(IBAR(2.312,IBA,.01,"I")) I 'IBI36 Q  ; if no insurance go back
 . . S IBNM=$G(IBAR(2.312,IBA,.01,"E"))
 . . S IBOK=1 D CHKNM^IBCNOR1(IBNM) I 'IBOK Q  ; insurance name was restricted
 . . S IBOK=1 D CHKINS^IBCNOR1(IBI36) I 'IBOK Q  ; insurance type not allowed or ins is inactive
 . . ; is pt insurance active
 . . S IBEFFDT=$G(IBAR(2.312,IBA,8,"I"))  ; Effective Date
 . . S IBEXPDT=$G(IBAR(2.312,IBA,3,"I"))  ; Expiration Date
 . . I IBEFFDT="" Q  ; if the effective date is null it is inactive
 . . I (IBEFFDT&(IBEFFDT>DT)) Q  ; if a valid effective date and the date is greater than today it is inactive
 . . I (IBEXPDT&(IBEXPDT<DT)) Q  ; if the expiration date is less than today it is inactive
 . . S IBTYPE=$$GET1^DIQ(36,IBI36_",",.13,"E")
 . . ;
 . . ;  PT DFN ^ .312 RECID ^ INS NAME ^INSURANCE TYPE ^ EFFECTIVE DATE ^ EXPIRE DATE ^ PT NAME ^ PT SSN ^ PT DOB ^ INTERNAL DOB
 . . S ^TMP($J,"PR",IBPTI,IBI36)=IBI36_U_IBIF_U_IBNM_U_IBTYPE_U_IBEFFDT_U_IBEXPDT_U_IBNAM_U_IBSSN_U_IBDOB_U_IBDOBI
 . . S IBC=$G(^TMP($J,"PR",IBPTI,0)),IBC=IBC+1,^TMP($J,"PR",IBPTI,0)=IBC
 ;
 G PRINT
 ;
COMPF ; process the found items
 ;
 N IBA,IBB,IBC,IBD,IBE,IBF,IBPHM,IBQ
 I '+$G(^TMP($J,"PR",IBPTI,0)) Q  ; no active insurances left
 S IBQ=0 I +$G(^TMP($J,"PR",IBPTI,0))=1 D  I IBQ Q
 . S IBA=$O(^TMP($J,"PR",IBPTI,0))
 . S IBD=$G(^TMP($J,"PR",IBPTI,IBA)) I $P(IBD,U,4)="PRESCRIPTION ONLY" S IBQ=1
 S IBA=0,IBPHM=1
 F  S IBA=$O(^TMP($J,"PR",IBPTI,IBA)) Q:'IBA  D  Q:'IBPHM
 . S IBB=$G(^TMP($J,"PR",IBPTI,IBA))
 . S IBC=$P(IBB,U,3)
 . S IBD=$P(IBB,U,4)
 . S IBE=$P(IBB,U,10)  ; internal pt dob
 . I IBD["PRESCRIPTION ONLY" S IBPHM=0
 I IBPHM D
 . S @IBTMP@("OUT",IBNAM,IBDOBI)=IBPTI_U_IBSSN_U_IBDOB
 . S IBF=$G(@IBTMP@("OUT",0))+1,@IBTMP@("OUT",0)=IBF
 Q
 ;
PRINT ; print out
 ;
 N EORMSG,HDRDATE,HDRNAME,NONEMSG,IBDATA,IBDASHES,IBDFN,IBDOB,IBDOBI,IBEORM,IBPGC,IBPTNM,IBSPACES,IBT
 S IBT=$E($G(IBCNOR("IBOUT")),1) S:IBT'="R"&(IBT'="E") IBT="R"
 S IBPGC=0,IBEORM=0
 S EORMSG="*** End of Report ***"
 S NONEMSG="* * * N o   D a t a   F o u n d * * *"
 S HDRNAME="PATIENT MISSING COVERAGE REPORT"
 D NOW^%DTC
 S HDRDATE=$$DAT2^IBOUTL($E(%,1,12))
 S $P(IBDASHES,"-",80)=""
 S $P(IBSPACES," ",80)=""
 S IBLNC=0
 W !   ; add line between 'waiting dots' when compiling and the printing of the rpt
 D EHDR:IBT="E",HDR:IBT="R"
 I '+$G(^TMP("IBCNOR",$J,"OUT",0)) D  G EXIT
 . W !,NONEMSG,!,EORMSG
 . S IBLNC=IBLNC+2,IBEORM=1
 . D QLINE
 ; loop
 S IBPTNM=""
P1 S IBPTNM=$O(@IBTMP@("OUT",IBPTNM)) I IBPTNM="" W !,EORMSG S IBLNC=IBLNC+2,IBEORM=1 D QLINE G EXIT
 S IBDOBI=""
P2 S IBDOBI=$O(@IBTMP@("OUT",IBPTNM,IBDOBI)) I 'IBDOBI G P1
 S IBDATA=$G(@IBTMP@("OUT",IBPTNM,IBDOBI)),IBLNC=IBLNC+1
 I IBT="R" S IBSTOP=0 D  I IBSTOP G EXIT
 . W !,IBPTNM,?32,$P(IBDATA,U,3),?48,$P(IBDATA,U,2)
 . I (IBPGC>0),(IBLNC+1>MAXCNT) D
 . . D QLINE Q:IBSTOP
 . . D HDR
 I IBT="E" D
 . W !,IBPTNM,U,$P(IBDATA,U,3),U,$P(IBDATA,U,2)
 ;
 G P2
 ;
EHDR ; EXCEL header
 ;
 S IBPGC=IBPGC+1,IBLNC=2
 W !,HDRNAME_U_HDRDATE
 I IBPGC=1 D
 . W !,"Filters: ",$S(IBCNOR("IBI")=1:"All",1:"Selected")," Insurances, "
 . W $S(IBCNOR("IBIG")=1:"All",1:"Selected")," Group Plans"
 . W " ,NAME Between ",$S(IBRF="":"'FIRST'",1:IBRF)," and ",$S(IBRL="zzzzzz":"'LAST'",1:IBRL)
 . S IBLNC=4
 W !,"Patient Name"_U_"DOB"_U_"SSN"
 Q
 ;
HDR ; report header
 ;
 N IBA,IBF,IBG
 S IBPGC=IBPGC+1 W:$G(IOF)'="" @IOF W:$G(IOF)="" !
 S IBA=$E(IBSPACES,1,(4-$L(IBPGC)))_IBPGC,IBLNC=4
 W HDRNAME,?40,HDRDATE,?69,"Page: ",IBA,!
 I IBPGC=1 D
 . S IBLNC=5,IBF="Filters: "_$S(IBCNOR("IBI")=1:"All",1:"Selected")_" Insurances, "
 . S IBF=IBF_$S(IBCNOR("IBIG")=1:"All",1:"Selected")_" Group Plans"
 . S IBG="NAME Between "_$S(IBRF="":"'FIRST'",1:IBRF)_" and "_$S(IBRL="zzzzzz":"'LAST'",1:IBRL)
 . W IBF
 . I ($L(IBF)+($L(IBG)+2)>80) W ! S IBLNC=6
 . E  W ", "
 . W IBG,!
 W !,"Patient Name",?32,"DOB",?48,"SSN"
 W !,$E(IBDASHES,1,79)
 Q
 ;
EXIT ; leave option
 ;
 K ^TMP($J)
 K @IBTMP
 K ^TMP(IBJOB,"IBCNOR")
 ;
 Q
 ;
QLINE ; cr to continue
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51&('IBEORM) F LIN=1:1:(IBXTFEED-IBLNC) W !
 I 'CRT Q
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBSTOP=1
 Q
 ;
DTC(IBDTCK) ; check date return external if valid
 ;
 N IBDT,IBBK S IBDT=""
 I 'IBDTCK G DTCO
 S IBBK=$$VALIDDT^IBCNINSU($P(IBDTCK,".",1))
 I IBBK="-1"!(IBBK="") G DTCO
 S IBDT=$$FMTE^XLFDT(IBBK,"5DZ")
 I IBDT="00/00/00" S IBDT=""
 G DTCO
 ;
DTCO ; date check exit
 ;
 Q IBDT
 ;
BLDPT ; collect the subscribers for the policies/groups
 ;
 N IBA,IBAR35,IBC,IBCT,IBDTH,IBF,IBFC,IBGC,IB3553,IB36,IBIN,IBPNM,IBPNMA,IBPTDFN,IBPTINS
 ;
 ; clear found patients
 K ^TMP("IBCNOR",$J,"P-PT")
 S IBC=0,IBF=0,IBCT=0,IBFC=0
 F  S IBC=$O(^TMP("IBCNOR",$J,"INS",IBC)) Q:'IBC  S IB36=$G(^TMP("IBCNOR",$J,"INS",IBC)) I IB36 D
 . S IBGC=0 K IBAR35
 . F  S IBGC=$O(^TMP("IBCNOR",$J,"INS",IBC,"GRP",IBGC)) Q:'IBGC  D
 . . S IB3553=$G(^TMP("IBCNOR",$J,"INS",IBC,"GRP",IBGC)) I IB3553 S IBAR35(IB3553)=1
 . ; walk patient file for found combos.
 . S IBPTDFN=0,IBF=0 F  S IBPTDFN=$O(^DPT("AB",IB36,IBPTDFN)) Q:'IBPTDFN  S IBPTINS=0 D
 . . ;
 . . I $G(^TMP("IBCNOR",$J,"P-PT",IBPTDFN))'="" Q  ; only put pt in list once
 . . ;
 . . S IBDTH="",IBDTH=$$GET1^DIQ(2,IBPTDFN_",",.351) I IBDTH'="" Q  ; only look at living patients
 . . S IBPNM=$$GET1^DIQ(2,IBPTDFN_",",.01,"E"),IBPNMA=$$UP^XLFSTR(IBPNM)
 . . F  S IBPTINS=$O(^DPT("AB",IB36,IBPTDFN,IBPTINS)) Q:'IBPTINS  D  Q:IBF
 . . . S IBCT=IBCT+1  I $G(IOST)["C-" W:IBCT#2000=0 "."
 . . . S IBA=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",.18,"I") I IBA D
 . . . . I $G(IBAR35(IBA))'=1 Q
 . . . . I $G(^TMP("IBCNOR",$J,"P-PT",IBPTDFN))'="" Q  ; only put pt in list once
 . . . . I $E(IBPNM,1,$L(IBRLU))]IBRLU Q
 . . . . I IBRFU]$E(IBPNM,1,$L(IBRFU)) Q
 . . . . ; NM from DPT ^ ins ien ^ group ien ^ NM uppercase
 . . . . S ^TMP("IBCNOR",$J,"P-PT",IBPTDFN)=IBPNM_U_IB36_U_IB3553_U_IBPNMA,IBF=1
 . . . . S IBFC=$G(^TMP("IBCNOR",$J,"P-PT",0))+1,^TMP("IBCNOR",$J,"P-PT",0)=IBFC
 S $P(^TMP("IBCNOR",$J,"P-PT",0),U,2)=+$G(IBCT)
 Q
 ;
