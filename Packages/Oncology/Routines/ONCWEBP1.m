ONCWEBP1 ;HINES OIFO/RTK - PARSER DISPLAY FOR CLOUD SERVER  ; 2/5/24 1:07pm
 ;;2.2;ONCOLOGY;**19**;Jul 31, 2013;Build 4
 ;
 ;--- EDITS RESPONSE FROM THE CLOUD WEB SERVICE
 ; 
 ; <EditResponse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance...
 ;     <ResponseSummary>
 ;         <RequestID>
 ;         <RequestType>
 ;         <NumberOfError>
 ;         <IsSuccessful>
 ;         <SummaryMessage>
 ;         <IsLoadError>
 ;     <AppVersion>
 ;         <Version>
 ;         <MetaFileVersion>
 ;         <EditLibraryVersion>
 ;         <CstageLibraryVersion>
 ;     <Messages>
 ;         <Message>
 ;         ...
 ;           <EditTag>
 ;           <Code>
 ;           <ErrorType>
 ;           <ErrorMessage>
 ;         ...
 ;         <>
 ;     <EngineError/>
 ;
 ;
 ;--- ATTRIBUTES
 ;
 ; ErrorType    E - Error, W - Warning, M - Message
 ;
 Q
 ;
PARSE ;parse response message from cloud server
 ;
 ;Supported IA #3561 reference to ^MXMLDOM
 ;
 ;ONCRHDL = response handle from the MXML parser
 ;ONCTAG1 = 1st level tags; ONCTAG2 = 2nd level tags; ONCTAG3 = 3rd level tags
 ;ONCPARR = array of server response values; ^TMP("ONCPARSE" = errors
 ;ERRFLG SET = 0 if NO EDITs errors, 
 ;           = 1 if there are EDITs errors set
 ;           = 2 if there is XML request/response failure
 N ONCRHDL,ONCTAG1,ONCTAG2,ONCTAG3
 S ERRFLG=0 S ONCRHDL=$$EN^MXMLDOM($NA(^TMP("ONCSED01R",$J)),"W")
 I $D(^TMP("MXMLERR",$J)) D  Q
 .N HDL S HDL=^TMP("MXMLERR",$J)
 .W !!?3,"XML message",!
 .N X S X=^TMP("MXMLERR",$J,HDL,"MSG") S DIWL=3,DIWR=77 D ^DIWP,^DIWW
 .W !?3,"XML error",!
 .N X S X=^TMP("MXMLERR",$J,HDL,"XML") S DIWL=3,DIWR=77 D ^DIWP,^DIWW
 .S ERRFLG=2
 ;--- Traverse top level child(ren) nodes
 K ONCPARR,^TMP("ONCPARSE",$J)
 N CT S CT=1 F  S CT=$$CHILD^MXMLDOM(ONCRHDL,1,CT) Q:CT=0  D
 .N ONCTAG1 S ONCTAG1=$$NAME^MXMLDOM(ONCRHDL,CT)
 .;--- Traverse second level child(ren) nodes
 .N CT2,N1 S N1=0,CT2=1 F  S CT2=$$CHILD^MXMLDOM(ONCRHDL,CT,CT2) Q:CT2=0  D
 ..N ONCTAG2 S ONCTAG2=$$NAME^MXMLDOM(ONCRHDL,CT2)
 ..N OUT S OUT=""
 ..N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT2,"TXT") OUT=TXT(1)
 ..S ONCPARR(ONCTAG2)=OUT
 ..I ONCTAG2="Message" S N1=N1+1
 ..;--- Traverse third level child(ren) nodes
 ..N CT3,N2 S N2=1,CT3=1 F  S CT3=$$CHILD^MXMLDOM(ONCRHDL,CT2,CT3) Q:CT3=0  D
 ...N ONCTAG3 S ONCTAG3=$$NAME^MXMLDOM(ONCRHDL,CT3)
 ...N OUTPT S OUTPT=""
 ...N TXT1 S:$$TEXT^MXMLDOM(ONCRHDL,CT3,"TXT1") OUTPT=TXT1(1)
 ...S ^TMP("ONCPARSE",$J,N1,N2)=OUTPT S N2=N2+1
 ...Q
 ..Q
 .Q
 I $G(ONCPARR("IsSuccessful"))="false" S ERRFLG=1
 D DELETE^MXMLDOM(ONCRHDL)
 K ONCRHDL
 Q
 ;
DISPLAY ; display EDITS and totals
 ;
 K ^UTILITY($J,"W")
 S PG=0,EX="",LINE=$S($E(IOST,1,2)="C-":IOSL-2,1:IOSL-6),TTLE=0,TTWRN=0
 S ONCMFV=$G(ONCPARR("MetaFileVersion"))
 S ONCELV=$G(ONCPARR("EditLibraryVersion"))
 S ONCSUMSG=$G(ONCPARR("SummaryMessage"))
 D HDR
 F N1=0:0 S N1=$O(^TMP("ONCPARSE",$J,N1)) Q:N1'>0  D  Q:EX=U
 .S ONCEDTG=$G(^TMP("ONCPARSE",$J,N1,1)),ONCEDCD=$G(^TMP("ONCPARSE",$J,N1,2))
 .S ONCEDTY=$G(^TMP("ONCPARSE",$J,N1,3)),ONCEDMG=$G(^TMP("ONCPARSE",$J,N1,4))
 .W !?1,N1,". Edit Tag: ",ONCEDTG,?24,"Code: ",ONCEDCD
 .I (ONCEDTY="E")!(ONCEDTY="M") S TTLE=TTLE+1
 .I ONCEDTY="W" S TTWRN=TTWRN+1
 .N X S X=ONCEDTY_": "_ONCEDMG S DIWL=4,DIWR=77 D ^DIWP,^DIWW D P Q:EX=U
 .D P Q:EX=U
 .K ONCEDTG,ONCEDCD,ONCEDTY,ONCEDMG
 I TTLE=0,TTWRN=0 W !!,"Engine Error: ",ONCSUMSG,!
 D TOTALS
 K ONCMFV,ONCELV,ONCSUMSG,TTLE,TTMSG,TTWRN
 Q
 ;
P ;
 I ($Y'<(LINE-1)) D  Q:EX=U  W !
 .I IOST?1"C".E W ! K DIR S DIR(0)="E",DIR("A")="Enter RETURN to continue"
 .D ^DIR I 'Y S EX=U Q
 .D HDR Q
 Q
HDR ; Header
 W @IOF S PG=PG+1
 W !!,"VHA - Hosp: (Metafile Version: ",ONCMFV,"  Edit Library Version: ",ONCELV,")"
 W !,"---------------------------------------------------------------------------"
 Q
 ;
TOTALS ;
 W !!,"Edit Set",?60,"Errors",?68,"Warnings"
 W !,"-------------------------------------------------------"
 W ?60,"------",?68,"--------"
 W !,"VHA - Hosp: (Metafile Version: ",ONCMFV,")",?64,TTLE,?72,TTWRN,?75,!
 Q
