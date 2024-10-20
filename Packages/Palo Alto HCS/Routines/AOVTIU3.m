AOVTIU3 ; PAVA/ELZ routine to print from tiu for date range signed ;1/21/98
 ;;1.0;TEXT INTEGRATION UTILITIES;**1**
 ; several parts of this routine are copied from TIURA
EN ; -- main entry point
 N RANGE,DIR,X,Y,TYPE,%ZIS,DIRUT,ZTRTN,ZTDESC,ZTSAVE,ZTSK
 S RANGE=$$DATRNG^AOXUTL02(0) Q:RANGE<1
 S DIR(0)="S^P:PROGRESS NOTES;D:DISCHARGE SUMMARIES" D ^DIR
 S TYPE=Y Q:$D(DIRUT)
 S %ZIS="MQ" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . S ZTRTN="DQ^AOVTIU3",ZTDESC="TIU Print of notes"
 . S (ZTSAVE("RANGE"),ZTSAVE("TYPE"))=""
 . D ^%ZTLOAD,HOME^%ZIS K IO("Q") W " Task#",ZTSK
DQ ; -- tasked entry point
 ;    first search file for entries
 N SIGN,AOVIEN,COUNT
 U IO
 S SIGN=$P(RANGE,U)-1+.99999999,COUNT=0
 F  S SIGN=$O(^TIU(8925,"AOVZ",SIGN)) Q:SIGN<1!(SIGN>($P(RANGE,U,2)+1))  S AOVIEN=0 F  S AOVIEN=$O(^TIU(8925,"AOVZ",SIGN,AOVIEN)) Q:AOVIEN<1  D
 . S VALMY(AOVIEN)=""
 . S ^TMP("TIURIDX",$J,AOVIEN)=U_AOVIEN
 . S COUNT=COUNT+1
 . I COUNT#100=0 D PRINTN K ^TMP("TIURIDX",$J),VALMY U IO(0) W "."
 I $D(^TMP("TIURIDX",$J)),$D(VALMY) D PRINTN
 K ^TMP("TIURIDX",$J),VALMY
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRINTN ; Loop through selected doc's & invoke print code as appropriate
 N TIUI,TIUTYP,TIUDARR,DFN K ^TMP("TIUPR",$J)
 U IO
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(DIROUT)
 . N TIUPMTHD,TIUDTYP,TIUPFHDR,TIUPFNBR,TIUPGRP,TIUPRINT
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI)),TIUFLAG=1
 . S TIUDA=+$P(TIUDATA,U,2),TIUTYP=$P(^TIU(8925,TIUDA,0),U)
 . ; Quits if type is not correct *** inserted ***
 . Q:TYPE="D"&(TIUTYP'=1)!(TYPE="P"&(TIUTYP=1))
 . ; *** end insert ***
 . ; Evaluate whether user can print record
 . S TIUPRINT=1 ;*** changed to always allow printing ***
 . I +TIUPRINT'>0 D  Q  ; Exclude records user can't print
 . . W !!,"Item #",TIUI,": ",!,$P(TIUPRINT,U,2),!
 . . I IO=IO(0),'$D(ZTQUEUED),$$READ^TIUU("EA","RETURN to continue...")
 . S DFN=$P($G(^TIU(8925,+TIUDA,0)),U,2)
 . I +TIUTYP D
 . . S TIUPMTHD=$$PRNTMTHD^TIULG(+TIUTYP)
 . . S TIUPGRP=$$PRNTGRP^TIULG(+TIUTYP)
 . . S TIUPFHDR=$$PRNTHDR^TIULG(+TIUTYP)
 . . S TIUPFNBR=$$PRNTNBR^TIULG(+TIUTYP)
 . I $G(TIUPMTHD)']"",+$$ISADDNDM^TIULC1(TIUDA) D
 . . S TIUDTYP=+$G(^TIU(8925,+$P($G(^TIU(8925,TIUDA,0)),U,6),0))
 . . I +TIUDTYP S TIUPMTHD=$$PRNTMTHD^TIULG(+TIUDTYP),TIUPGRP=$$PRNTGRP^TIULG(+TIUDTYP),TIUPFHDR=$$PRNTHDR^TIULG(+TIUDTYP),TIUPFNBR=$$PRNTNBR^TIULG(+TIUDTYP)
 . . S TIUDA=+$P($G(^TIU(8925,TIUDA,0)),U,6)
 . I $G(TIUPMTHD)]"",+$G(TIUPGRP),($G(TIUPFHDR)]""),($G(TIUPFNBR)]"") S TIUDARR(TIUPMTHD,$G(TIUPGRP)_"$"_TIUPFHDR_";"_DFN,TIUI,TIUDA)=TIUPFNBR
 . E  S TIUDARR(TIUPMTHD,DFN,TIUI,TIUDA)=""
 . ;D:'$D(ZTQUEUED) RESTORE^TIULM(+TIUI)
 S TIUPMTHD="" F  S TIUPMTHD=$O(TIUDARR(TIUPMTHD)) Q:TIUPMTHD=""  D
 . D PRNTDOC(TIUPMTHD,.TIUDARR)
 Q
PRINT1 ; Print a single document
 N TIUDARR,TIUDEV,TIUTYP,DFN,TIUPMTHD,TIUD0,TIUDPRM,TIUFLAG,TIUDTYPE
 N TIUPGRP,TIUPFHDR,TIUPFNBR,TIUPRINT,POP
 D CLEAR^VALM1
 S TIUPRINT=$$CANDO^TIULP(TIUDA,"PRINT RECORD")
 I +TIUPRINT'>0 D  Q  ; Exclude records user can't print
 . W !!,$C(7),$P(TIUPRINT,U,2),! ; Echo denial message
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 S TIUD0=$G(^TIU(8925,TIUDA,0))
 S TIUTYP=$P(TIUD0,U),DFN=$P(TIUD0,U,2)
 I +TIUTYP'>0 Q
 S TIUPMTHD=$$PRNTMTHD^TIULG(+TIUTYP)
 S TIUPGRP=$$PRNTGRP^TIULG(+TIUTYP)
 S TIUPFHDR=$$PRNTHDR^TIULG(+TIUTYP)
 S TIUPFNBR=$$PRNTNBR^TIULG(+TIUTYP)
 I $G(TIUPMTHD)']"",+$$ISADDNDM^TIULC1(TIUDA) D
 . S TIUDTYP=+$G(^TIU(8925,+$P($G(^TIU(8925,TIUDA,0)),U,6),0))
 . I +TIUDTYP S TIUPMTHD=$$PRNTMTHD^TIULG(+TIUDTYP),TIUPGRP=$$PRNTGRP^TIULG(+TIUDTYP),TIUPFHDR=$$PRNTHDR^TIULG(+TIUDTYP),TIUPFNBR=$$PRNTNBR^TIULG(+TIUDTYP)
 . S TIUDA=+$P($G(^TIU(8925,TIUDA,0)),U,6)
 D DOCPRM^TIULC1(+TIUTYP,.TIUDPRM,TIUDA)
 I +$P($G(TIUDPRM(0)),U,9) S TIUFLAG=$$FLAG^TIUPRPN3
 I (+$P($G(TIUDPRM(0)),U,9)'>0),+$$ISA^USRLM(DUZ,"MEDICAL INFORMATION SECTION") S TIUFLAG=$$FLAG^TIUPRPN3
 I $G(TIUPMTHD)]"",+$G(TIUPGRP),($G(TIUPFHDR)]""),($G(TIUPFNBR)]"") S TIUDARR(TIUPMTHD,$G(TIUPGRP)_"$"_TIUPFHDR_";"_DFN,1,TIUDA)=TIUPFNBR
 E  S TIUDARR(TIUPMTHD,DFN,1,TIUDA)=""
 I $G(TIUPMTHD)']"" W !,$C(7),"No Print Method Defined for ",$P($G(^TIU(8925.1,+TIUTYP,0)),U) H 2 G PRINT1X
 S TIUDEV=$$DEVICE^TIUDEV(.IO) ; Get Device/allow queueing
 I $S(IO']"":1,TIUDEV']"":1,1:0) G PRINT1X
 I $D(IO("Q")) D QUE^TIUDEV("PRINTQ^TIURA",TIUDEV) G PRINT1X
 D PRINTQ
PRINT1X ; Exit single document print
 D ^%ZISC
 Q
PRINTQ ; Entry point for queued single document print
 D PRNTDOC(TIUPMTHD,.TIUDARR)
 Q
PRNTDOC(TIUPMTHD,TIUDARR) ; Print a single document type
 ; Receives TIUPMTHD & TIUDARR
 N TIUDA
 I '+$D(TIUDARR) W !,"No Documents selected." Q
 M ^TMP("TIUPR",$J)=TIUDARR(TIUPMTHD)
 I TIUPMTHD']"" D  G PRNTDOCX
 . W !!,"No Print Method Defined for ",$P(TIUTYP,U,2) H 2
 X TIUPMTHD
PRNTDOCX ; Exit single document type print
 K ^TMP("TIUPR",$J)
 Q
DISPLAY ; Detailed Display (audit trail) of Selected Documents
 N TIUDA,TIUD,TIUDATA,TIUI,Y,DIROUT,TIUQUIT
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(TIUQUIT)
 . N TIUVIEW
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . D CLEAR^VALM1
 . W !!,"Reviewing #",+TIUDATA
 . S TIUDA=+$P(TIUDATA,U,2)
 . S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 . I +TIUVIEW'>0 D  Q  ; Exclude records user can't print
 . . W !!,$C(7),$P(TIUVIEW,U,2),! ; Echo denial message
 . . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 . . D RESTORE^TIULM(+TIUI)
 . D EN^TIUAUDIT
 . I +$G(TIUQUIT) D FIXLST^TIULM Q
 . D RESTORE^TIULM(+TIUI)
 K VALMY S VALMBCK="R"
 Q
BROWSE(TIULTMP) ; Browse selected discharge summaries
 ; TIULTMP is list template name
 N TIUDA,DFN,TIU,TIUCHNG,TIUDATA,TIUI,Y,DIROUT,TIUQUIT
 I '$D(VALMY) D EN^VALM2(XQORNOD(0))
 S TIUI=0
 F  S TIUI=$O(VALMY(TIUI)) Q:+TIUI'>0  D  Q:$D(TIUQUIT)
 . N TIUVIEW
 . S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI))
 . S TIUDA=+$P(TIUDATA,U,2)
 . D CLEAR^VALM1
 . W !!,"Reviewing Item #",TIUI D BROWS1(TIULTMP)
 . I +$G(TIUCHNG)=1 D
 . . I $D(^TMP("TIUR",$J,"CTXT")) Q
 . . I $D(VALMDDF("ADMISSION DATE")) D UPDATEM^TIURL(TIUDATA) Q
 . . I '$D(^TMP("TIUR",$J,"CTXT")),$D(VALMDDF("REF DATE")) D UPDATE^TIURL(TIUDATA)
 . I '+$G(TIUCHNG)!$D(^TMP("TIUR",$J,"CTXT")) D RESTORE^TIULM(+TIUI)
 ; Revise list as appropriate and cycle back
 I $D(^TMP("TIUR",$J,"CTXT")) D RBLD^TIUROR
 K VALMY S VALMBCK="R"
 Q
BROWS1(TIULTMP) ; Browse single summary
 ; Receives: TIUDA     Calls EN^VALM
 N %DT,C,D0,DIQ2,FINISH,TIU,TIUVIEW
 S TIUVIEW=$$CANDO^TIULP(TIUDA,"VIEW")
 I +TIUVIEW'>0 D  Q  ; Exclude records user can't view
 . W !!,$C(7),$P(TIUVIEW,U,2),! ; Echo denial message
 . I $$READ^TIUU("EA","RETURN to continue...") ; pause
 I '$D(TIUPRM0)!'$D(TIUPRM1) D SETPARM^TIULE
 D EN^VALM(TIULTMP)
 K ^TMP("TIUVIEW",$J)
 Q
