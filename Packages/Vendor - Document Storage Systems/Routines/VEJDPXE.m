VEJDPXE ;DBB;PCE VALIDATION
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
FINAL(AXY,VISIT) ;,PXKVST)
 N VALMDDF
 ;INPUT  VISIT - the IEN of the visit at hand.
 ;Q:$D(SDIEMM)
 ;Q:'$D(VISIT)
 I $G(VISIT)="" S AXY(0)="-1^VISIT MUST BE SPECIFIED" Q
 Q:$D(VALSTP)
 Q:$D(^TMP("PXKSAVE",$J))
 N ENC,CLN,XMT,SDMODE
 S ENC=0
 F  S ENC=$O(^SCE("AVSIT",VISIT,ENC)) Q:ENC=""  I $P(^SCE(ENC,0),U,6)="" Q
 I ENC="" S AXY(0)="-1^NO ENCOUNTER FOR THIS VISIT" Q
 Q:'$D(^SCE(ENC,0))
 Q:'$$COMPL(^SCE(ENC,0))
 S CLN=$P(^SCE(ENC,0),U,4)
 S XMT=+$O(^SD(409.73,"AENC",ENC,0))
 I 'XMT S AXY(0)="-1^NO XMIT RECORD FOR VISIT: "_VISIT Q
 S SDMODE=0
 ;D PID^VADPT
 D VALIDATE(.AXY,XMT,CLN)
 Q
COMPL(NODE) ;this function call returns whether or not the check out
 ;process is complete or not.  1 for complete  0 for not
 Q $S(+$P(NODE,U,7):1,1:0)
TEST D FINAL(.AXY,4182)
 Q
VALIDATE(AXY,XMIT,CLINIC) ;this entry point performs the validation at check out.
 ;INPUT - XMIT this is the IEN of an entry in the transmit file 409.73
 S XMIT=+$G(XMIT),SDXPTR=XMIT
 S CLINIC=+$G(CLINIC)
 I XMIT<1!(CLINIC<1) G VALQ
 N VAL
 S VAL=$$VALWL^SCMSVUT2(+$G(CLINIC))
 I VAL<1 S AXY(0)="0^" G VALQ
 ;I 'SDMODE,'$D(ZTQUEUED),'$D(VALQUIET) W !!,"Performing Ambulatory Care Validation Checks.",!
 S ERR=$$VALIDATE^SCMSVUT2(XMIT) S AXY(0)=ERR
 I ERR<1 S AXY(0)="0^" Q  ;"-1^No validation errors found!" Q
 .Q
 ;S DIR("A")="Do you wish to correct the validation errors"
 ;D ENP^SCENI0(XMIT)
 S VALMDDF("INDEX")="INDEX^2^5",VALMDDF("SOURCE")="SOURCE^9^7^Source",VALMDDF("ERROR")="ERROR^18^6^Error"
 S VALMDDF("DESCRIPTION")="DESCRIPTION^26^80^Error Description"
 D INIT
 S I=0 F  S I=$O(^TMP("SCENI ERR",$J,I)) Q:'I  S AXY(I)=^(I,0),AXY(0)=I_"^"
 K ^TMP("SCENI ERR",$J)
VALQ Q
INIT ; -- init variables and list array
 ;     Variables
 ;       IW,IC,EC,EW,DC,DW,SC,SW - Col widths and positions
 ;       SDECNT - Counter
 ;
 K ^TMP("SCENI ERR",$J)
 ;D CLEAN^VALM10
 S BL="",$P(BL," ",30)=""
 S X=VALMDDF("INDEX"),IC=$P(X,U,2),IW=$P(X,U,3)
 S X=VALMDDF("SOURCE"),SC=$P(X,U,2),SW=$P(X,U,3)
 S X=VALMDDF("ERROR"),EC=$P(X,U,2),EW=$P(X,U,3)
 S X=VALMDDF("DESCRIPTION"),DC=$P(X,U,2),DW=$P(X,U,3)
 D BLD
 I '$D(^TMP("SCENI ERR",$J)) B  D  Q
 . S (SDECNT,VALMCNT)=0
 . D SET(" "),SET("No Errors found.")
 Q
BLD ;  Build display global for error entries in the error file
 ;
 S (SDECNT,VALMCNT)=0,SDEPTR=""
 F  S SDEPTR=$O(^SD(409.75,"B",SDXPTR,SDEPTR)) Q:'SDEPTR  D
 . Q:'$D(^SD(409.75,SDEPTR))
 . D BLD1(SDEPTR)
 Q
BLD1(SDEPTR) ;   Build display line
 ;    Input
 ;         SDEPTR - Ptr to #409.75
 ;
 ;    Variables
 ;        SDX     - Local variable
 ;        ERNODE  - Error table node 0
 ;        ERNODE1 - Error table node 1
 ;        SDERR   - Error code
 ;
 N SDSRC  S VALMWD=0
 S SDECNT=SDECNT+1,SDX="",$P(SDX," ",VALMWD+1)=""
 S SDERR=$P(^SD(409.75,SDEPTR,0),U,2)
 Q:'SDERR
 S ERNODE=$G(^SD(409.76,SDERR,0))
 S ERNODE1=$G(^SD(409.76,SDERR,1))
 ;
 S SDX=$E(SDX,1,IC-1)_$E(SDECNT_BL,1,IW)_$E(SDX,IC+IW+1,VALMWD)
 S SDSRC=$P(ERNODE,U,2)
 S SDX=$E(SDX,1,SC-1)_$E($S(SDSRC="V":"VISTA",SDSRC="N":"NPCD ",1:"UNK  ")_BL,1,SW)_$E(SDX,SC+SW+1,VALMWD)
 S SDX=$E(SDX,1,EC-1)_$E($P(ERNODE,U)_BL,1,EW)_$E(SDX,EC+EW+1,VALMWD)
 S SDX=$E(SDX,1,DC-1)_$E(ERNODE1_BL,1,DW)_$E(SDX,DC+DW+1,VALMWD)
 D SET(SDX)
 Q
SET(X) ;   Sets formatted display string into TMP global
 S VALMCNT=VALMCNT+1,^TMP("SCENI ERR",$J,VALMCNT,0)=X
 Q:'SDECNT
 S ^TMP("SCENI ERR",$J,"IDX",VALMCNT,SDECNT)=SDEPTR_U_$P(ERNODE,U)
 S ^TMP("SCENI ERR",$J,"DA",SDECNT,SDEPTR)=""
 S ^TMP("SCENI ERR",$J,"XMT",SDECNT,SDXPTR)=""
 Q
