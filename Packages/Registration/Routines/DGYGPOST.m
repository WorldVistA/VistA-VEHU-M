DGYGPOST ;ALB/AAS/REW - MAS COPAY PATCH POST INIT ; 02 Apr 91  1:08 PM
 ;;5.2;REGISTRATION;**22**;JUL 29,1992
 ;
 ;  -run every installation
 D HOME^%ZIS
 D ^DGYGPT
 ;
 ;
TIME ; -get stop time
 D NOW^%DTC S DGEDT=$H W !!,">>> Initialization Complete at " S Y=% D DT^DIQ
 I $D(DGBDT) D
 .S DGDAY=+DGEDT-(+DGBDT)*86400 ;additional seconds of over midnight
 .S X=DGDAY+$P(DGEDT,",",2)-$P(DGBDT,",",2) W !,"    Elapse time for initialization was: ",X\3600," Hours,  ",X\60-(X\3600*60)," Minutes,  ",X#60," Seconds"
 K DGBDT,DGEDT,DGDAY,X
 D MSG Q
 ;
MSG ; -- print message at end
 W !!,"REGISTRATION/ADT Initialization Complete."
 W !,"If you have not already done so, install the Scheduling portion"
 W !,"of the Copay Exemption Patch."
 W !,"The Scheduling portion consists of one routine, SDPP (SD*5.2*9)."
 Q
