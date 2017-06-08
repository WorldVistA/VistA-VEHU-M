SD53200P ;BP-CIOFO/NDH - POST INSTALL SD*5.3*200 ; 20 Aug 99  09:00 AM
 ;;5.3;Scheduling;**200**;Aug 13 1993
 ; Mark unsent FY1999 Q1 & Q2 NPCDB activity for transmission
 ;
EN I DT>2991015 W !!,$C(7),"It is too late to run this utility!" Q
 S SDSTAT=$O(^SD(409.63,"B","CHECKED OUT",0)) I 'SDSTAT W !!,"CHECKED OUT encounter status could not be identified!" K SDSTAT Q
 N ZTSAVE S ZTSAVE("SDSTAT")="",ZTSAVE("SDFORCE")=""
 W ! D EN^XUTMDEVQ("START^SD53200P","Re-flag NPCDB activity",.ZTSAVE) Q
 ;
START ;Search for activity to re-flag for transmission
 K ^TMP("SD200",$J)
 S SDLINE="",$P(SDLINE,"-",(IOM+1))=""
 S SDTIT="<*>  RE-FLAG UNSENT FY1999 Q1 & Q2 NPCDB ACTIVITY FOR TRANSMISSION  <*>"
 S SDPAGE=1 D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=Y
 S SDDT=2981000
 F  S SDDT=$O(^SCE("B",SDDT)) Q:'SDDT!(SDDT>2990399)  S SDOE=0 F  S SDOE=$O(^SCE("B",SDDT,SDOE)) Q:'SDOE  D
 .S SDOE0=$G(^SCE(SDOE,0)) Q:'$L(SDOE0)
 .I $P(SDOE0,U),$P(SDOE0,U,2),$P(SDOE0,U,4),$P(SDOE0,U,12)=SDSTAT,'$P(SDOE0,U,6),"2^3^6"[$P($$STX^SCRPW8(SDOE,SDOE0),U) D
 ..S ^TMP("SD200",$J,SDOE)=SDOE0
 ..Q
 .Q
 S (SDOE,SDCT)=0 F  S SDOE=$O(^TMP("SD200",$J,SDOE)) Q:'SDOE  S SDCT=SDCT+1
 ;
 ;Too many to send!
 I '$G(SDFORCE),SDCT>3000 D  G EXIT
 .D HDR N C S C=(IOM-80\2) S:C<0 C=0
 .W !!?(C),"This process found ",SDCT," encounters that appear not to have been",!?(C),"transmitted.  This may be due to transmission data being purgedat this site"
 .W !?(C),"through the use of the 'Purge Ambulatory Care Reporting files' [SCDX AMBCAR",!?(C),"PURGE ACRP FILES] option.",!!?(C),"If the purge has beenperformed for this date range, there is no way to"
 .W !?(C),"identify encounters that were not transmitted due to the workload closeout",!?(C),"date.",!!?(C),"If this count exceeds 3000 and you do notbelieve that the purge has been"
 .W !?(C),"performed at your site, please contact National VistA Support (NVS) for",!?(C),"assistance in retransmitting the encounters at your site."
 .Q
 ;
 ;Re-flag encounters for transmission
 S SDOE=0 F  S SDOE=$O(^TMP("SD200",$J,SDOE)) Q:'SDOE  D
 .S SDDT=+^TMP("SD200",$J,SDOE)
 .S SDXP=$$CRTXMIT^SCDXFU01(SDOE,,SDDT)
 .Q:SDXP'>0
 .D STREEVNT^SCDXFU01(SDXP,0)
 .D XMITFLAG^SCDXFU01(SDXP,0)
 .Q
 ;
 ;Report the results
 D HDR S SDTIT1="This process re-flagged "_SDCT_" encounter"_$S(SDCT=1:"",1:"s")_" for transmission." W !!?(IOM-$L(SDTIT1)\2),SDTIT1
 ;
EXIT K %,%H,%I,SDCT,SDDT,SDFORCE,SDLINE,SDOE,SDOE0,SDPAGE,SDPNOW,SDSTAT,SDTIT,SDTIT1,SDXP,X,Y,^TMP("SD200",$J) Q
 ;
FORCE ;Force the reflagging of all applicable encounters
 ;
 ;  CAUTION!!!  Do not use this entry point unless you are SURE that
 ;              the site has not purged transmission data for this
 ;              date range!
 ;
 S SDFORCE=1 G EN
 ;
HDR ;Print report header
 W:SDPAGE>1 @IOF
 W SDLINE,!?(IOM-$L(SDTIT)\2),SDTIT,!,SDLINE,!,"Date printed:",SDPNOW,?(IOM-6-$L(SDPAGE)),"Page: ",SDPAGE,!,SDLINE S SDPAGE=SDPAGE+1 Q
