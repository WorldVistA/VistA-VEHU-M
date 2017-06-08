DSIV05 ;DSS/KC - POST INSTALL P5 ;08/30/2011
 ;;2.2;INSURANCE CAPTURE BUFFER;**5**;May 19, 2009;Build 10
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Control Registrations
 ; 5323   MES^DSICXPDU
 ; 2263   ^XPAR, GETLST,ADD,NDEL
 ; 10086  %ZIS, HOME^%ZIS
 ; 10089  %ZISC
 ;
PRE ;pre-install
 Q
POST ;set new param system default
 N DSIV05,DSIVERR,IEN,X,Y,T,SITE,GUID,PAR
 S PAR="DSIV VI INDEX TEMPLATES"
 D MES^DSICXPDU("Removing site#/duplicates from "_PAR)
 S DSIV05=$NA(^TMP("DSIV05",$J)) K @DSIV05 ;contains existing param data
 K ^TMP("DSIV05A",$J),^XTMP("DSIV05X")
 D GETLST^XPAR(DSIV05,"ALL",PAR,"Q",.DSIVERR,1)
 S IEN=0 F  S IEN=$O(^TMP("DSIV05",$J,IEN)) Q:'IEN  S X=$G(^(IEN)) D
 .S Y=$P(X,U,2),X=$P(X,U)
 .S T=$P(X,"-"),SITE=$P(X,"-",2),GUID=$P(X,"-",3,99) I SITE="" Q  ;already converted
 .I GUID="" Q  ;bad data
 .I $D(^TMP("DSIV05A",$J,T,GUID)) D  Q
 ..S ^XTMP("DSIV05X",T,GUID,1)=$G(^TMP("DSIV05A",$J,T,GUID))
 ..S ^XTMP("DSIV05X",T,GUID,2)=Y ;contains data to report as duplicate
 ..Q
 .S ^TMP("DSIV05A",$J,T,GUID)=Y ;contains new param data (removing the site)
 .Q
 I '$D(^TMP("DSIV05A",$J)) D MES^DSICXPDU("Conversion previously run...nothing to convert") D END Q
 ;delete the data from parameter
 D NDEL^XPAR("SYS",PAR,.DSIVERR)
 ;add the data back into the parameter without the site
 S T=0 F  S T=$O(^TMP("DSIV05A",$J,T)) Q:'T  S GUID="" S GUID=$O(^TMP("DSIV05A",$J,T,GUID)) Q:GUID=""  D
 .S X=$G(^TMP("DSIV05A",$J,T,GUID))
 .I X="" Q
 .D ADD^XPAR("SYS",PAR,T_"--"_GUID,X)
 .Q
 D END
 ;report on the duplicates
 I '$D(^XTMP("DSIV05X")) D MES^DSICXPDU("No duplicates to report") Q
 D MES^DSICXPDU("***Duplicate parameters found!!***")
 D MES^DSICXPDU("***Generate the report and deliver to the FBCS DocManager admin user(s)***")
 D MES^DSICXPDU("")
 D MES^DSICXPDU("Generate the duplicate report by making the following call:")
 D MES^DSICXPDU("at a terminal prompt, enter D RPT^DSIV05")
 D MES^DSICXPDU("")
 D MES^DSICXPDU("Select HOME and copy the screen output or...")
 D MES^DSICXPDU("Select HFS and create a .txt file output.")
 D MES^DSICXPDU("")
 D MES^DSICXPDU("You may rerun this report by calling RPT^DSIV05 up to 5 days after the install.")
 H 15
 Q
END K ^TMP("DSIV05",$J),^TMP("DSIV05A",$J) Q
RPT ;report entry point, in case the site needs to re-run this information
 ;the data will only be available for five days in the XTMP global
 I '$D(^XTMP("DSIV05X")) W !,"No duplicates to report" Q
 S ^XTMP("DSIV05X",0)=$$FMADD^XLFDT(DT,5)_U_DT_U_"DSIV*2.2*5 conversion report"
 N POP,%ZIS,Y,GUID,X,Y K IOP
 D ^%ZIS I POP Q  ;get device to print
 U IO
 W !!,"DSIV*2.2*5 Parameter DSIV VI INDEX TEMPLATES conversion"
 W !,"-------------------------------------------------------"
 W !,"Note: A DocManager IRM or AdminIRM user must review these duplicates"
 W !,"and take appropriate action within DocManager to map titles.",!
 W !,"You may rerun this report by calling RPT^DSIV05 up to 5 days after the install.",!
 S T=0 F  S T=$O(^XTMP("DSIV05X",T)) Q:'T  S GUID="" S GUID=$O(^XTMP("DSIV05X",T,GUID)) Q:GUID=""  D
 .S X=$G(^XTMP("DSIV05X",T,GUID,1)),Y=$G(^(2))
 .W !!,"Duplicate Entry Preserved (kept in parameter):"
 .W !,"Template IEN: ",T,?30,"GUID: ",GUID
 .W !?5,X
 .W !!,"Duplicate Entry DELETED for the above IEN/GUID:"
 .W !?5,Y
 .Q
 D ^%ZISC ;close device
 D HOME^%ZIS
 Q
 ;
TEST ;add data to test this parameter conversion
 N PAR,X S PAR="DSIV VI INDEX TEMPLATES"
 D NDEL^XPAR("SYS",PAR,.DSIVERR)
 S X="V=VA|80=CONSULT|31=BLOOD BANK|83=BLOOD COMPONENT FORM|BLEEDING DISORDER CONSULT"
 D ADD^XPAR("SYS",PAR,"563-515.6-{AEE6FC67-8521-4047-A94F-0C0B27D5BE74}",X)
 S X="V=VA|85=PROGRESS NOTE|41=ALLERGY & IMMUNOLOGY|46=MISCELLANEOUS|MISCELLANEOUS - ALLERGY & IMMUNOLOGY"
 D ADD^XPAR("SYS",PAR,"898-500-{AEE6FC67-8521-4047-A94F-0C0B27D5BE74}",X)
 D ADD^XPAR("SYS",PAR,"898-500.1-{AEE6FC67-8521-4047-A94F-0C0B27D5BE74}",X)
 Q
