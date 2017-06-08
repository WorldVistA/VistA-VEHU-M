IBDY303 ;ALB/TMP - POST INSTALL FOR PATCH IBD*3*3 ; 23-JUN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3**;APR 24, 1997
 ;
EN ; Recompile all forms in file 359.2
 N C,X,COUNT,CNT,COLWIDTH,IBDFSA,IBFORMID,IBBDT,IBEDT,IBDAY,LBEGIN,LEND,NODE10,POP,PRIORPG,QUIT
 ;
 S IBBDT=$H
 S COUNT=$P(^IBD(359.2,0),"^",4)
 ;
 D MES^XPDUTL(">>> I am going to recompile all "_COUNT_" entries in your FORM SPECS file (359.2)")
 D MES^XPDUTL(">>> Recompilation Started at "_$$HTE^XLFDT(IBBDT))
 D MES^XPDUTL(">>> This may take awhile...")
 ;
 S CNT=0
 S IBFORMID=0 F  S IBFORMID=$O(^IBD(359.2,IBFORMID)) Q:'IBFORMID  D
 .D SCAN^IBDFBKS(IBFORMID)
 .S CNT=CNT+1
 .I '$D(ZTQUEUED),'(CNT#10) D MES^XPDUTL("    "_CNT_" done, "_(COUNT-CNT)_" to go.")
 ;
 S IBEDT=$H
 D MES^XPDUTL("")
 D MES^XPDUTL(">>> Recompilation Complete at "_$$HTE^XLFDT(IBEDT))
 I $D(IBBDT) D
 .S IBDAY=+IBEDT-(+IBBDT)*86400 ;additional seconds of over midnight
 .S X=IBDAY+$P(IBEDT,",",2)-$P(IBBDT,",",2)
 .D MES^XPDUTL(">>> Elapse time for recompilation was: "_(X\3600)_" Hours,  "_(X\60-(X\3600*60))_" Minutes,  "_(X#60)_" Seconds")
 .S X=(X/COUNT)
 .D MES^XPDUTL(">>> Average Time per Entry was: "_(X\60-(X\3600*60))_" Minutes,  "_(X#60)_" Seconds")
 Q
