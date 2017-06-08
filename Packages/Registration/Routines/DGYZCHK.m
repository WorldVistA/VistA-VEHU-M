DGYZCHK ;ALB/MIR - SEARCH FOR NON-CROSS-REFERENCED ENTRIES IN DGPM ;AUG 12, 1991
 ;;MAS VERSION 5.0;;**9**;
 ;
 D DT^DICRW,HOME^%ZIS
 I 'DUZ W !,"You must have DUZ defined in order to continue!!",!! Q
 S ZTDESC="Search for non-cross-referenced entries in ^DGPM",ZTRTN="EN^DGYZCHK",ZTIO="" D ^%ZTLOAD
 K ZTDESC,ZTRTN,ZTIO,ZTSK
 Q
 ;
EN ;begin search
 ;DGYZXRF = Number of non-x-ref'd entries in DGPM
 ;DGYZPRG = Number of non-x-ref'd, duplicate entries in DGPM
 ;DGYZDUP = Number of duplicate entries found and reported
 ;
 ;Search for non-cross-referenced entries
 D NOW^%DTC S DGSTART=%
 S (DGYZXRF,DGYZPRG,DGYZDUP)=0
 F DGYZI=0:0 S DGYZI=$O(^DGPM(DGYZI)) Q:'DGYZI  I $D(^DGPM(DGYZI,0)) S DGYZX=^(0) I '$D(^DGPM("B",+DGYZX,DGYZI)) D XRF
 ;
 ;Search for duplicates
 F I=1:1:3 S XRF="APTT"_I F DFN=0:0 S DFN=$O(^DGPM(XRF,DFN)) Q:'DFN  F J=0:0 S J=$O(^DGPM(XRF,DFN,J)) Q:'J  S CT=0 F K=0:0 S K=$O(^DGPM(XRF,DFN,J,K)) Q:'K  I $D(^DGPM(K,0)),($P(+^(0),".",2)]"") S CT=CT+1 I CT>1 S DGYZDUP=DGYZDUP+1
 ;
 D NOW^%DTC S DGEND=%
 D BULL
 ;
 K %,CT,DFN,DGEND,DGSTART,DGYZDUP,DGYZPRG,DGYZXRF,DGYZI,DGYZX,I,J,K,X,XRF,Y
 Q
 ;
XRF ;If non-cross-referenced:
 S X=$O(^DGPM("APTT"_$P(DGYZX,"^",2),+$P(DGYZX,"^",3),+DGYZX+($P(DGYZX,"^",22)/10000000),0)) I X,(X'=DGYZI) S DGYZPRG=DGYZPRG+1 Q
 S DGYZXRF=DGYZXRF+1
 Q
 ;
BULL ;Fire off bulletin of findings when complete
 K ^UTILITY("DGYZXRF",$J,"TEXT")
 S XMSUB="Search of DGPM is now complete",XMY(DUZ)="",XMTEXT="^UTILITY(""DGYZXRF"",$J,""TEXT"",",DGYZLINE=0,XMDUZ=.5
 S DGYZL="The search for non-cross-referenced and duplicate entries in the PATIENT" D SET
 S DGYZL="MOVEMENT file is now complete." D SET
 S DGYZL=" " D SET
 S Y=DGSTART X ^DD("DD") S DGYZL=" Job started:  "_Y D SET
 S Y=DGEND X ^DD("DD") S DGYZL="Job finished:  "_Y D SET
 S DGYZL=" " D SET
 S DGYZL="Report of findings:" D SET
 S DGYZL="   Number of entries in the PATIENT MOVEMENT file     : "_$J($P(^DGPM(0),"^",4),6) D SET
 S DGYZL="   Non-cross-referenced, non-duplicate entries found  : "_$J(DGYZXRF,6) D SET
 S DGYZL="   Non-cross-referenced, duplicate entries found      : "_$J(DGYZPRG,6) D SET
 S DGYZL="   Cross-referenced duplicates found                  : "_$J(DGYZDUP,6) D SET
 S DGYZL=" " D SET
 S DGFL=DGYZDUP!DGYZXRF!DGYZPRG
 I DGFL S DGYZL="To obtain the diagnostic routine to aid you in cleaning up these entries," D SET S DGYZL="contact your local ISC." D SET G FIRE
 S DGYZL="You do not need to run the diagnostic routine.  No problems were found." D SET
 ;
FIRE ;fire bulletin off
 S DGYZL=" " D SET
 D ^XMD K XMDUZ
 K DGFL,DGYZL,DGYZLINE,XMY,XMSUB,XMTEXT,^UTILITY("DGYZXRF",$J)
 Q
 ;
SET ; -- set line in xmtext array
 S DGYZLINE=DGYZLINE+1
 S ^UTILITY("DGYZXRF",$J,"TEXT",DGYZLINE,0)=DGYZL
 Q
