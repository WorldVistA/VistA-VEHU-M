%AAHRRZ1 ;402,DJB,6/21/92**Identify Mumps System
 ;;GEM III;;
 ;;David Bolduc - Augusta ME
START ;
 D OS G:FLAGQ EX ;Get MUMPS System
 D ^%AAHRRZ2 ;Set up System variables
EX ;
 Q
 ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
OS ;SET GEMSYS = Mumps Implementation
 I $D(^%ZOSF("OS")) S GEMSYS=+$P(^("OS"),"^",2) Q:GEMSYS>0
 I $D(^DD("OS")) S GEMSYS=+^("OS") Q:GEMSYS>0
 I $D(^%AAHE("OS")) S GEMSYS=+^("OS") Q:GEMSYS>0
 S FLAGQ=1 W *7,!!?2,"You need to identify your MUMPS System. DO SET^%AAHRRZ1",!
 Q
SET ;Get MUMPS System
 NEW X
 W !!?2,"ARR needs to know what type of Mumps system you are running."
 W !?2,"Select from the following choices. Selecting a system other"
 W !?2,"than the one you are running, will cause errors or unpredictable"
 W !?2,"results. DO SET^%AAHRRZ1 again to correct."
 W !!?10,"1 MSM",!?10,"2 DTM",!?10,"3 VAX DSM",!?10,"4 M/UX",!
SET1 R !?2,"Enter number: ",X:300 S:'$T X="^" I "^"[X W ! Q
 I X'?1N!(X<1)!(X>4) W "   Enter a number from 1 to 4" G SET1
 S X=$S(X=1:8,X=2:9,X=3:16,X=4:101,1:"") I X']"" S FLAGQ=1 Q
 W !!?2,"Finished.." S ^%AAHE("OS")=X
 Q
