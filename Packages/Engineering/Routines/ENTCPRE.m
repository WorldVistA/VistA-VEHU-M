ENTCPRE ;(WASH ISC)/DH-Check for Training Environment ;10-30-92
 ;;6.5;ENGINEERING;;November 11, 1992
 ;Question if in production UCI
 ;Abort if not ENGINEERING 6.5
 ;Abort if Equipment File contains over 100 entries
 X ^%ZOSF("UCI") I Y=^%ZOSF("PROD") D
 . W *7,!!,"This looks like a production account."
 . W !!,"Are you sure you want to install a training database in this UCI?",!
 . S DIR(0)="Y",DIR("B")="NO" D ^DIR I Y'=1 D
 .. K DIFQ
 .. W !!,"Installation aborted.  Nothing changed."
 Q:'$D(DIFQ)
 I '$D(^ENG("VERSION")) D
 . W *7,!!,"You should install Engineering 6.5 before installing"
 . W !,"this training database."
 . K DIFQ
 . W !!,"Installation aborted.  Nothing changed."
 Q:'$D(DIFQ)
 I ^ENG("VERSION")'=6.5 D
 . W *7,!!,"You must upgrade to Engineering 6.5 before installing"
 . W !,"this training database."
 . K DIFQ
 . W !!,"Installation aborted.  Nothing changed."
 Q:'$D(DIFQ)
 I $D(^ENG(6914,0)),$P(^(0),U,4)>100 D
 . W !!,*7,"You already have over 100 entries in your Equipment File.  You should purge",!,"those entries before installing this training database."
 . K DIFQ
 . W !!,"Installation aborted.  Nothing changed."
 Q
 ;ENTCPRE
