ISIJLS1 ; ISI/JHC - ISIRAD exam list functions ; 10/17/2022
 ;;1.1;ESL ISI IMAGING;**99,103,110**;Dec 21, 2022;Build 41
 ;; This routine is the property of ViTel Net, and should not be modified.
 ;; This software is a medical device and is subject to FDA regulation.
 ;; Modifications to this software may only be made under the terms of
 ;; 21CFR820 regulation.  21CFR Subpart A 820.1: "The failure to comply
 ;; with any applicable provision in this part renders a device
 ;; adulterated under section 501(h) of the act. Such a device,
 ;; as well as any person responsible for the failure to comply,
 ;; is subject to regulatory action."
 ; Reference to SVMAG2A^MAGJLS3 in ICR #7403
 ; Reference to GETEXAM2^MAGJUTL1 in ICR #7404
 ; Reference to File #2006.631 in ICR #7409
 Q
 ;;
 ;
 ; entry point for List Type = "I" lists, called from magjls3
 ;
INDXBLD ; compile Indexed exam data (List Type = "I")
 ; look up compile routine entry-point & call the subroutine
 ; else, quit with problem error code
 N NOGO,INDXTAG,INDXRTN,X
 S NOGO=0,REPLY=""  ; reply variable controlled by calling routine (magjls3)
 S X=$G(^MAG(2006.631,LSTID,"ISI")),INDXTAG=$P(X,U),INDXRTN=$P(X,U,2)
 D  I NOGO Q
 . I INDXTAG]"",(INDXRTN]"")
 . I $T(@(INDXTAG_U_INDXRTN))]""  ;  test for routine in env.
 . E  S NOGO=1,REPLY="0^1~Problem with compile specification for this Index list (LISTID="_LSTID_")."
 D @(INDXTAG_U_INDXRTN_"(.REPLY)")
 I REPLY="" S REPLY="0^1~No results found for Indexed exams list."
 ;
 Q
 ;
FAVCOMP(REPLY) ; compile Favorites exam list
 N DASH,EXAMIEN,FIL,MAGRET,USERIEN,USERFILE,RADFN,RADTI,RACNI
 N KEYWD1,KEYWD2,FAVNOTE,FAVICT,FAVCT
 S REPLY="",FAVCT=0
 S USERFILE=23451,DASH="-"
 S USERIEN=$$USERIEN^ISIJFAV(DUZ)
 I 'USERIEN S REPLY="0^1~Current user has not stored any Favorites exams." Q
 S FIL=$NA(^ISI(USERFILE,USERIEN)),EXAMIEN=0
 F FAVICT=0:1 S EXAMIEN=$O(@FIL@(1,EXAMIEN)) Q:'EXAMIEN  S X=^(EXAMIEN,0),Y=$P(X,U) D
 . S RADFN=$P(Y,DASH),RADTI=$P(Y,DASH,2),RACNI=$P(Y,DASH,3)
 . S KEYWD1=$P(X,U,2),KEYWD2=$P(X,U,3)
 . S FAVNOTE=$$FAVNOTE()
 . D GETEXAM2^MAGJUTL1(RADFN,RADTI,RACNI,0,.MAGRET)
 . I MAGRET D
 . . S X=$P(^TMP($J,"MAGRAEX",1,2),U,11)
 . . I X]"",("EW")[X Q  ; exclude if in Waiting or Examined status
 . . S FAVCT=FAVCT+1
 . . ; stuff Favorites data into list compile results
 . . S $P(^TMP($J,"MAGRAEX",1,"ISI"),U,4)=KEYWD1,$P(^("ISI"),U,5)=KEYWD2,$P(^("ISI"),U,6)=FAVNOTE
 . . D SVMAG2A^MAGJLS3()
 I 'FAVCT D
 . I 'FAVICT S REPLY="0^1~No Favorites exams found for current user."
 . E  S REPLY="0^1~Current user's Favorites exams are all in Waiting or Examined status; display not permitted."
 Q
 ;
FAVNOTE() ; determine what to return for the notes
 ;  because regular list columns cannot manage W-P data
 N RET,I,X,Y
 S RET=""
 S X=$G(@FIL@(1,EXAMIEN,1,0))
 I X]"" S Y=$P(X,U,4) D
 . I Y=1 D  Q:(RET]"")  ; only one notes line; return only if short enough
 . . S I=$O(@FIL@(1,EXAMIEN,1,0))
 . . S:I RET=$G(^(I,0))
 . . I $L(RET)>40 S RET=""
 . . E  I '$L(RET) S RET=" "
 . I RET="" S RET="Use 'View/Edit' to display notes"
 Q:$Q RET Q
 ;
STATUS(STS) ; return a status "value" for the input Status IEN
 ; Returns Status ORDER if = 0/1/9; else return Vrad Category "equivalent"
 N X
 I STS]"" D
 . S X=^RA(72,STS,0)
 . S STS=$P(X,U,3) ; status order
 . I STS=0!(STS=1)!(STS=9) Q  ; Cancelled/Waiting/Complete
 . S STS=$P(X,U,9) ; vrad category
 . I STS="D"!(STS="T") S STS="I" Q  ; Dict or Transcribe == "I" (interpreted)
 Q:$Q STS Q
 ; 
END ;
