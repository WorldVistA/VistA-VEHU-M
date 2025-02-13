SD53191P ;WCIOFO/KEITH/ERC - POST INSTALL SD*5.3*191 ; 03/30/99
 ;;5.3;Scheduling;**191**;Aug 13 1993
 ;
SEED ;Seed NPCD ENCOUNTER MONTH multiple (#404.9171) of the SCHEDULING
 ; PARAMETER file (#404.91) with workload close-out dates for FY1999
 ;
 ;Declare variables
 N XPDIDTOT,LINE,DATES,WLMONTH,DBCLOSE,WLCLOSE,TMP
 ;Print header
 D BMES^XPDUTL(">>> Store revised close-out dates for Fiscal Year 1999")
 S TMP=$$INSERT^SCDXUTL1("Workload","",7)
 S TMP=$$INSERT^SCDXUTL1("Database",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Workload",TMP,47)
 D BMES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("Occurred In","",6)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,27)
 S TMP=$$INSERT^SCDXUTL1("Close-Out",TMP,47)
 D MES^XPDUTL(TMP)
 S TMP=$$INSERT^SCDXUTL1("------------","",5)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,25)
 S TMP=$$INSERT^SCDXUTL1("------------",TMP,45)
 D MES^XPDUTL(TMP)
 ;Loop through list of dates
 S XPDIDTOT=12
 F LINE=2:1:13 S TMP=$T(FY99+LINE),DATES=$P(TMP,";",3) Q:(DATES="")  D
 .;Break out info
 .S WLMONTH=$P(DATES,"^",1)
 .S DBCLOSE=$P(DATES,"^",2)
 .S WLCLOSE=$P(DATES,"^",3)
 .;Print close-out info
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLMONTH,"1D"),"",7)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(DBCLOSE,"1D"),TMP,25)
 .S TMP=$$INSERT^SCDXUTL1($$FMTE^XLFDT(WLCLOSE,"1D"),TMP,45)
 .D MES^XPDUTL(TMP)
 .;Store close-out info
 .S TMP=$$AECLOSE^SCDXFU04(WLMONTH,DBCLOSE,WLCLOSE)
 .;Write error message if datebase or workload dates not updated
 .I TMP<0 D MES^XPDUTL("       >>>>Could not update closeout dates for above month.")
 .;If KIDS install, show progress through status bar
 .D:($G(XPDNM)'="") UPDATE^XPDID(LINE-1)
 D BMES^XPDUTL("")
 Q
 ;
FY99 ;Revised Close-out dates for fiscal year 1999
 ;  Month ^ Database Close-Out ^ Workload Close-Out
 ;;2981000^2990416^2981106
 ;;2981100^2990416^2981211
 ;;2981200^2990416^2990108
 ;;2990100^2990416^2990212
 ;;2990200^2990416^2990312
 ;;2990300^2990416^2990409
 ;;2990400^2991015^2990507
 ;;2990500^2991015^2990611
 ;;2990600^2991015^2990709
 ;;2990700^2991015^2990806
 ;;2990800^2991015^2990910
 ;;2990900^2991015^2991008
 ;
