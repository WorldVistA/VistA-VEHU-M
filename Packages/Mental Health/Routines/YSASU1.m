YSASU1 ;ASF/ALB,HIOFO/FT - ASI MANAGEMENT UTILITITIES CONT ;1/30/13  4:09pm
 ;;5.01;MENTAL HEALTH;**38,121**;Dec 30, 1994;Build 61
 ;Reference to XUP API supported by DBIA #4409
 ;Reference to VADPT APIs supported by DBIA #10061
 ;Reference to XMD API supported by DBIA #10070
PTLST ;patient list
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=" "
 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)="Name"_$E(YSASS,1,17)_"SSN   Interview Class Special        Transmitted Queued"
 S YSFL="" F  S YSFL=$O(^TMP("YSASU",$J,"A",YSFL)) Q:YSFL=""  D
 . S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=$E(YSFL_YSASS,1,20)
 . S YSIFN=0,J=0 F  S YSIFN=$O(^TMP("YSASU",$J,"A",YSFL,YSIFN)) Q:YSIFN'>0  S J=J+1 D
 .. S G=^TMP("YSASU",$J,YSIFN)
 .. I J=1 S DFN=$P(G,U,2),VA("BID")="    " D:DFN DEM^VADPT S ^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_" "_$E(VA("BID")_"       ",1,6)
 .. I J>1 S YSASN=YSASN+1,^TMP("YSASU",$J,"M",YSASN)=$E(YSASS,1,27)
 .. S Y=+G,^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_$E(Y,4,5)_"/"_$E(Y,6,7)_$S(Y>2999999:"/20",1:"/19")_$E(Y,2,3)
 .. S ^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_"  "_$S($P(G,U,3)=1:"Full",$P(G,U,3)=2:"Lite",$P(G,U,3)=3:"F-up",1:"    ")
 .. S ^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_"  "_$S($P(G,U,4)="":" ",1:$P(G,U,4))
 .. S ^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_"  "_$S($P(G,U,6)=1:"  signed",1:"unsigned")
 .. S Y=$P(G,U,9),^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_"  "_$S(Y>1:$E(Y,4,5)_"/"_$E(Y,6,7)_$S(Y>2999999:"/20",1:"/19")_$E(Y,2,3),1:"          ")
 .. S ^TMP("YSASU",$J,"M",YSASN)=^TMP("YSASU",$J,"M",YSASN)_"  "_$S($P(G,U,8)=1:"queued",1:"")
 Q
MAIL2 ; SEND MAILMAN
 S YSASMCNT=0,YSASMTC=(YSASN\1000)+1
 S YSASCNT=0,YSASCNT2=0 F  S YSASCNT=$O(^TMP("YSASU",$J,"M",YSASCNT)) Q:(YSASCNT'>0)  D
 .S YSASCNT2=YSASCNT2+1,^TMP("YSASM",$J,YSASCNT)=^TMP("YSASU",$J,"M",YSASCNT)
 .I (YSASCNT2=1000)!(YSASCNT=YSASN) D
 ..S YSASMCNT=YSASMCNT+1
 ..S DTIME=600
 .. S XMSUB="ASI Stats "_YSASITE_"  ("_YSASMCNT_" OF "_YSASMTC_")"
 ..S XMTEXT="^TMP(""YSASM"",$J,"
 ..S XMY("G.ASI PERFORMANCE MEASURES")=""
 ..S XMY(DUZ)=""
 ..S XMDUZ="AUTOMATED MESSAGE"
 ..D ^XMD
 ..S YSASCNT2=0
 ..K ^TMP("YSASM",$J)
 ..S DTIME=$$DTIME^XUP(DUZ)
 Q
