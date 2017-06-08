DGPM5ES1 ;ALB/MJK - DGPM Global Estimator ; 14 DEC 1990
 ;;MAS VERSION 4.7;;**25**;
 ;
INTRO ; -- display text
 W @IOF
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="END"  W X,! I $Y>20 S DIR(0)="E" D ^DIR K DIR Q:'Y  W @IOF
 Q
 ;
MAIL ; -- put in mm
 W !
 S DIR(0)="Y",DIR("A")="Place above text in a Mailman Message",DIR("B")="No"
 D ^DIR K DIR G MAILQ:'Y
 K ^UTILITY("DGPMEST",$J)
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="END"  S ^UTILITY("DGPMEST",$J,I,0)=X
 S XMSUB="DGPM Global Estimator",XMDUZ=.5,XMY(DUZ)="",XMTEXT="^UTILITY(""DGPMEST"",$J,"
 D ^XMD W !,"...mailed"
MAILQ K XMY,XMDUZ,XMTEXT,XMSUB,^UTILITY("DGPMEST",$J)
 Q
 ;
TEXT ;
 ;;               *** ^DGPM Global Estimator ***
 ;;
 ;;Purpose:
 ;;--------
 ;;In previous versions of MAS, a patient's ADT information was
 ;;stored in the ADMISSION DATE/TIME multiple of the PATIENT
 ;;file.  In MAS v5, this data will reside in the new PATIENT
 ;;MOVEMENT file.  The MUMPS global for this file is ^DGPM.
 ;;
 ;;The purpose of this utility is the following:
 ;;             1.  estimate what the size of ^DGPM will
 ;;                 be after your site has converted to
 ;;                 the new structure
 ;;            
 ;;             2. estimate a one year rate of growth for
 ;;                ^DGPM using as a base the ADT activity
 ;;                for the previous 365 days
 ;;
 ;;Using these estimates, you can make a better determination
 ;;as to where to place this new ^DGPM global before the
 ;;conversion is executed.
 ;;
 ;;Also, when deciding where to place ^DGPM, remember that
 ;;the options that made use of the old structure will now
 ;;be using ^DGPM instead.  Users needing access to this data
 ;;for bed control, inquiries and reports should be considered
 ;;for performance reasons.
 ;;
 ;;
 ;;Algorithm:
 ;;----------
 ;;This utility will scan your site's ADMISSION DATE/TIME
 ;;multiple of your PATIENT file.  It will count the number
 ;;of admissions, transfers, treating specialty transfers and
 ;;discharges.
 ;;
 ;;After obtaining these counts, they will be applied against
 ;;the estimated block size needed for each type of transaction.
 ;;
 ;;For example, the estimated block size for one transfer is
 ;;.3692 blocks. If your site has 25,000 transfers then it
 ;;is estimated that you will need 9,230 1K blocks just for
 ;;transfers(25,000 x .3692).
 ;;
 ;;Each type of movement transaction needs will be estimated
 ;;then added together in order to obtain the overall global
 ;;disk space needs.
 ;;
 ;;The estimation algorithm takes into account the following factors:
 ;;         o pointer blocks needed
 ;;         o blocks needed for actual data
 ;;         o blocks needed for cross references
 ;;
 ;;Also, the algorithm is based on a global efficiency of 74%.
 ;;
 ;;
 ;;
 ;;Results Reporting:
 ;;------------------
 ;;After the estimations are calculated, the results will be
 ;;reported to the user via a MailMan message.
 ;;END
