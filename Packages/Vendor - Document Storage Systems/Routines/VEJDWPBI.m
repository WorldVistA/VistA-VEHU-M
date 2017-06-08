VEJDWPBI ;WPB/CAM routine modified for dental GUI;8/1/98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;;;SLC/DCM - List Manager routine - Activity Log Detailed Display ;5/14/98  14:05
 ;GMRCSLM4;3.0;CONSULT/REQUEST TRACKING;**4**;DEC 27,1997
ACTLOG(GMRCO) ;Print activity log
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Activity"_$E(TAB,1,17)_"Date/Time"_$E(TAB,1,6)_"Responsible Clin"_$E(TAB,1,4)_"Entered By",GMRCCT=GMRCCT+1
 N GMRCD,GMRCDA
 S GMRCD=0 F  S GMRCD=$O(^GMR(123,+GMRCO,40,"B",GMRCD)) Q:'GMRCD  S GMRCDA="" F  S GMRCDA=$O(^GMR(123,+GMRCO,40,"B",GMRCD,GMRCDA)) Q:'GMRCDA  D BLDALN(GMRCO,GMRCDA)
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 Q
 ;
BLDALN(GMRCO,GMRCDA) ;Build Activity Log Lines for an activity
 ; GMRCO=  consult internal entry number
 ; GMRCDA= activity internal entry number
 N GMRCACT,GMRCSLN,XDT1,XDT2,FLG,LN,LINE,DASH,X,GMRCX,GMRCDEV
 S GMRCDA(0)=^GMR(123,+GMRCO,40,GMRCDA,0)
 S GMRCACT=$P(GMRCDA(0),"^",2)
 D BLDLN1
 D BLDLN2
 D BLDCMTS
 Q
 ;
BLDLN1 ;Build the first line for the activity
 ;GMRCX is scratch pad variable
 S GMRCX=$P($G(^GMR(123.1,+GMRCACT,0)),"^",1)
 S:'$L(GMRCX) GMRCX=GMRCACT_" action?"
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCX
 ;
 ;Add to line for Printed to (action 22) when device name <13 characters
 I GMRCACT=22 D
 . S GMRCDEV=$P($G(^%ZIS(1,+$P(GMRCDA(0),"^",8),0)),"^")
 . I '$L(GMRCDEV) S GMRCDEV=$P(GMRCDA(0),"^",8)
 . I $L(GMRCDEV)<13 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^TMP("GMRCR",$J,"DT",GMRCCT,0)_" "_GMRCDEV K GMRCDEV
 ;
 ;Add on generic fields that apply to every activity
 ;Date/time of Actual Activity, Who's Responsible for Activity,
 ;and Who entered activity
 S X=$P(GMRCDA(0),"^",3) D REGDTM^VEJDWPBJ S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$S($D(^TMP("GMRCR",$J,"DT",GMRCCT,0)):^TMP("GMRCR",$J,"DT",GMRCCT,0)_$E(TAB,1,25-$L(^(0)))_X,1:X)
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^TMP("GMRCR",$J,"DT",GMRCCT,0)_$E(TAB,1,40-$L(^(0)))_$S($P(GMRCDA(0),"^",4):$E($P($G(^VA(200,$P(GMRCDA(0),"^",4),0)),"^"),1,18),1:$E(TAB,1,19))
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^TMP("GMRCR",$J,"DT",GMRCCT,0)_$E(TAB,1,60-$L(^(0)))_$S($P(GMRCDA(0),"^",5):$E($P($G(^VA(200,$P(GMRCDA(0),"^",5),0)),"^"),1,19),1:$E(TAB,1,19))
 S GMRCCT=GMRCCT+1
 Q
 ;
BLDLN2 ;SECOND line for activity
 ;Get Incomplete Report and Complete result # for second line of action
 N GMRCSLN S GMRCSLN="" ;saved SECOND line
 I +$P(GMRCDA(0),"^",9) D
 . S GMRCSLN=$E(TAB,1,5)_"Note# "_+$P(GMRCDA(0),"^",9)
 ;
 ;If GMRCDEV is defined, than print the device name on the second line
 I GMRCACT=22,$D(GMRCDEV) D
 . S GMRCSLN=$E(TAB,1,5)_$E(GMRCDEV,1,17) K GMRCDEV
 ;
 ;Build line for forwarded to (action 17)
 I GMRCACT=17 D
 . S GMRCX=$P($G(^GMR(123.5,+$P(GMRCDA(0),"^",6),0)),"^")
 . S:'$L(GMRCX) GMRCX=$P(GMRCDA(0),"^",6)_" ??"
 . S GMRCSLN=$E(TAB,1,5)_GMRCX
 ;
 ; Check if the entry date and specified actual date are different
 S XDT1=$P(GMRCDA(0),"^",1),XDT2=$P(GMRCDA(0),"^",3),GMRCX=0
 S:XDT2>XDT1 X=XDT1,XDT1=XDT2,XDT2=X
 S GMRCDIF=$$FMDIFF^XLFDT(XDT1,XDT2,3)
 I $L(GMRCDIF) D
 . I +$P(GMRCDIF," ",1)>0 S GMRCX=1 Q  ;Check Days
 . S GMRCDIF=$P(GMRCDIF," ",2)
 . I +$P(GMRCDIF,":",1)>0 S GMRCX=1 Q  ;Check Hours
 . I +$P(GMRCDIF,":",2)>1 S GMRCX=1 Q  ;Check Minutes
 . Q
 I GMRCX D
 . S X=$P(GMRCDA(0),"^",1)
 . ; blj/dss 14/6/2000  Routine ^VEGMRCU doesn't exist.
 . ; D REGDTM^VEGMRCU
 . S GMRCSLN=$E(GMRCSLN_TAB,1,25)_X_" (entered)"
 . Q
 ;
 I $L(GMRCSLN) D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCSLN
 . S GMRCCT=GMRCCT+1
 . Q
 Q
 ;
BLDCMTS ;Build lines for Comment activity.
 I GMRCACT=11 D BLDCMT Q
 ;
 ;Build lines for general comments on any activity
 I $D(^GMR(123,+GMRCO,40,+GMRCDA,1)) D  Q
 . S LN=$O(^GMR(123,+GMRCO,40,+GMRCDA,1,0)) Q:'+LN
 . ;Check for edited fields generated text with lines <75 characters
 . I $G(^GMR(123,+GMRCO,40,+GMRCDA,1,LN,0))["EDITED FIELDS" D BLDCMT Q
 . D BLDCMT
 . Q
 . I $L($G(^GMR(123,+GMRCO,40,+GMRCDA,1,LN,0)))'>75 D BLDCMT Q
 . ;Use utilities for long line formating
 . S FLG=1,LINE="     "
 . ; blj/dss 14/6/2000  Routine VEGMRCUTIL doesn't exist anymore.
 . ;D WPSET^VEGMRCUTIL("^GMR(123,+GMRCO,40,GMRCDA,1)","^TMP(""GMRCR"",$J,""DT"")",LINE,.GMRCCT,TAB,FLG)
 . D BLDASH
 . Q
 Q
 ;
BLDCMT ;Build comment lines
 ;DASH is 1 or "" for print dash line after comment
 S LN=0
 F  S LN=$O(^GMR(123,+GMRCO,40,+GMRCDA,1,LN)) Q:'+LN  D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^GMR(123,+GMRCO,40,GMRCDA,1,LN,0) ;$P(^GMR(123,+GMRCO,40,GMRCDA,1,LN,0),"^",1)
 . S GMRCCT=GMRCCT+1
 . Q
 ;D BLDASH
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 Q
 ;
BLDASH ;Build separater line with dashes
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",$P(^(0),"-",80)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 Q
