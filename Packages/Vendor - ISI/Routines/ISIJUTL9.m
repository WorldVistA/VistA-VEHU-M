ISIJUTL9 ; ISI/JHC - ISI Rad subroutines ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**100,101,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to File #2006.631 in ICR #7409
 ; Reference to File #2006.69 in ICR #7410
 Q
 ;
ERR ;
 S @MAGRY@(0)="0^4~ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q:$Q 1 Q
 ;
 ;
MGRREV2(CLIENT) ; Return 1/0 for Manager Revision-2 is enabled
 ;  Input CLIENT optional:
 ;    "CLIENT" indicates Client-side Tab changes only concern
 ;      Else, concern is Server-side processes disabled/enabled
 N X S X=$P($G(^MAG(2006.69,1,"ISI")),U,5)
 I +X D
 . S CLIENT=$G(CLIENT)="CLIENT"
 . I CLIENT S X=1        ; Level-1 or Level-2 true/enable
 . E  S X=$S(X=2:1,1:0)  ; Server-side processes enable for Level-2 only
 Q:$Q X Q
 ;
UJOCHECK(OUT) ;
 ; Check to see if UJO National Patient ID (#2,400000000) exists.
 ;   Used to verify this is an EHS/EHSI system
 N $ETRAP,$ESTACK S $ETRAP="D ERR^ISIJUTL9"
 K OUT
 S OUT=$$VFIELD^DILFD(2,400000000)
 Q:$Q OUT Q
 ;
LSTSTATU(LSTID,HDATE) ; Exam list statistics update
 ;   LSTID = ien of Exam list requested by user
 ;   HDATE = $H of date to be filed; default is today
 N CT,DAT,IEN,IENDAT,IENSIT,FIL,X
 S HDATE=$G(HDATE,$H) ;  programmer's test routine is the only use of passed in value
 S FIL=$NA(^ISI(23452))  ; statistics file
 I '$D(@FIL) Q
 I '$D(^MAG(2006.631,LSTID)) Q  ;  should never happen
 ;
 S DAT=$$WEEKOF(HDATE)  ; stats are aggregated weekly
 ;
 L +@FIL@(0):1
 E  Q  ; should not happen, but don't bother if lock fails
 S IEN=$O(@FIL@("B",LSTID,""))
 I 'IEN D  ; create new list entry
 . S X=@FIL@(0),IEN=$P(X,U,3)+1,CT=$P(X,U,4)+1,$P(X,U,3)=IEN,$P(X,U,4)=CT,^(0)=X
 . S @FIL@(IEN,0)=LSTID,@FIL@("B",LSTID,IEN)=""
 L -@FIL@(0)
 ;
 L +@FIL@(IEN):1
 E  Q  ; ditto
 S IENDAT=$O(@FIL@(IEN,1,"B",DAT,""))
 I 'IENDAT D  ; create new DATE for this list
 . S X=$G(@FIL@(IEN,1,0)),IENDAT=$P(X,U,3)+1,CT=$P(X,U,4)+1,$P(X,U,3)=IENDAT,$P(X,U,4)=CT,^(0)=X
 . S @FIL@(IEN,1,IENDAT,0)=DAT,@FIL@(IEN,1,"B",DAT,IENDAT)=""
 L -@FIL@(IEN)
 ;
 L +@FIL@(IEN,DUZ(2)):1
 E  Q  ; ditto
 S IENSIT=$O(@FIL@(IEN,1,IENDAT,1,"B",DUZ(2),""))
 I 'IENSIT D  ; create new SITE for this list/date
 . S X=$G(@FIL@(IEN,1,IENDAT,1,0)),IENSIT=$P(X,U,3)+1,CT=$P(X,U,4)+1,$P(X,U,3)=IENSIT,$P(X,U,4)=CT,^(0)=X
 . S @FIL@(IEN,1,IENDAT,1,IENSIT,0)=DUZ(2)_U_0,@FIL@(IEN,1,IENDAT,1,"B",DUZ(2),IENSIT)=""
 S X=$G(@FIL@(IEN,1,IENDAT,1,IENSIT,0)),CT=$P(X,U,2)+1,$P(X,U,2)=CT,^(0)=X
 ;
 L -@FIL@(IEN,DUZ(2))
 Q
 ;
WEEKOF(H) ; Calculate a "week-of" date for input $H value
 S %H=H D YMD^%DTC  ; returns fman date in X
 I H#7 D
 . S X1=X,X2=-(H#7) D C^%DTC  ; returns fman date in X
 Q:$Q X Q
 ;
LSTSTATD ; Exam list statistics dump
 ;
 S DIC=23452,L=0
 S DHD=""
 S FLDS="[LIST STATS",BY="[LIST STATS"
 S DIOEND="D LISTDEFS^ISIJUTL9"
 D EN1^DIP
 Q
 ;
LISTDEFS ; dump out exam list definitions
 ; 
 W !!,"LIST DEFINITIONS:",!
 N FIL,IEN,I,LSTNUM,X
 S FIL=$NA(^MAG(2006.631))
 S LSTNUM=""
 F  S LSTNUM=$O(@FIL@("C",LSTNUM)) Q:LSTNUM>9799  S IEN=$O(^(LSTNUM,"")) D
 . W !,$J(LSTNUM,4)," "
 . I 'IEN W " * * *  No report defined for List # * * *",! Q
 . S X=@FIL@(IEN,0)
 . F I=3,6,7,1 W " ",U," ",$P(X,U,I)
 . I $D(@FIL@(IEN,"DEF",5,1)) F I=1:1 S X=$G(^(I)) Q:X=""  W !,?6,X
 . W !
 W !!,"<END>",!
 Q
 ;
END Q
 ;
