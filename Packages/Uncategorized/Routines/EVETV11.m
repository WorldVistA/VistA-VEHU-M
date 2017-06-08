EVETV11 ;;DALOI/DS - Extraction procedures for CHEMISTRY/HEMATOLOGY data to be stored on eVault ; 12/3/02 9:59am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ; usage of GMTSLRCE supported by subscription to IA# 892
GET(EVETDFN,EVSDAT,EVREQID)     ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVD,LRDFN,GMTS1,GMTS2,EVCNT,EVSQN,EVDAT,EVT,X,Y,MAX
 S LRDFN=$G(^DPT(EVETDFN,"LR"))
 ; if no LRDFN, exit after writing headers
 I LRDFN="" D  Q
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Chem")=""
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Chem")=""
 . Q
 S MAX=99999
 S GMTS2=9999999.999999-EVSDAT
 S GMTS1=9999999.999999-$$NOW^XLFDT()
 D ^GMTSLRCE
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Chem")=""
 S EVCNT=EVCNT+1
 S EVD=""
 F  S EVD=$O(^TMP("LRC",$J,EVD)) Q:EVD=""  D
 . S EVSQN=""
 . F  S EVSQN=$O(^TMP("LRC",$J,EVD,EVSQN)) Q:EVSQN=""  D
 . . S EVDAT=$G(^TMP("LRC",$J,EVD,EVSQN))
 . . Q:EVDAT=""
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ien")=$TR(LRDFN_$P(EVDAT,"^",1)_$P(EVDAT,"^",3),"&<>","")
 . . S X=$P($P(EVDAT,"^",1)," ",1),EVT=$P($P(EVDAT,"^",1)," ",2)
 . . D ^%DT  ;convert to va format
 . . S Y=Y_"."_$E(EVT,1,2)_$E(EVT,4,5)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"collection_date")=$$XMLDATE^EVETU1(Y)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"test_name")=$P(EVDAT,"^",3)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"test_result")=$P(EVDAT,"^",4)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"units")=$P(EVDAT,"^",6)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ref_low")=$P(EVDAT,"^",7)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ref_high")=$P(EVDAT,"^",8)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"indicator")=$P(EVDAT,"^",5)
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"specimen_type")=$P(EVDAT,"^",2)
 . . S EVCNT=EVCNT+1
 . . Q
 . Q
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Chem")=""
 Q
