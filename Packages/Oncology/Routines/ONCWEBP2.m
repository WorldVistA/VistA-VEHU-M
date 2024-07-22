ONCWEBP2 ;HINES OIFO/RTK - PARSER DISPLAY FOR CLOUD SERVER  ; 2/5/24 1:07pm
 ;;2.2;ONCOLOGY;**19**;Jul 31, 2013;Build 4
 ;
 Q
 ;
 ;--- CS SCHEMA RESPONSE FROM THE CLOUD WEB SERVICE
 ;
 ; <CsGetSchemaResponse xmlns:xsi=""http://www.w3.org/2001/XMLSchema...
 ;  <IsRequestValid>false</IsRequestValid>
 ;  <Schema>106</Schema>
 ;  <SchemaName>Breast</SchemaName>
 ;  <Discriminator />
 ; </CsGetSchemaResponse>
 ;
 ;
PARSESCR ;parse CS Schema response message from cloud server
 ;
 ;Supported IA #3561 reference to ^MXMLDOM
 ;
 ;ONCRHDL = response handle from the MXML parser
 ;ONCTAG1 = 1st level tags
 ;ONCPARR = array of server response values; ^TMP("ONCPARSE" = errors
 ;ERRFLG SET = 0 if NO CS errors, if there are CS errors set = 1
 N ONCRHDL,ONCTAG1
 S ONCCSSCH="E",ONCCSSNM=""
 S ERRFLG=0 S ONCRHDL=$$EN^MXMLDOM($NA(^TMP("ONCSCRSP",$J)),"W")
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
 .N OUT S OUT=""
 .N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT,"TXT") OUT=TXT(1)
 .S ONCPARR(ONCTAG1)=OUT
 .I ONCTAG1="Schema" S ONCCSSCH=OUT
 .I ONCTAG1="SchemaName" S ONCCSSNM=OUT
 .Q
 D DELETE^MXMLDOM(ONCRHDL)
 K ONCRHDL
 Q
 ;
 ;--- CS TABLE RESPONSE FROM THE CLOUD WEB SERVICE
 ;
 ; <CsGetSchemaResponse xmlns:xsi=""http://www.w3.org/2001/XMLSchema...
 ;   <IsRequestValid></IsRequestValid>
 ;   <CrResponse></CrResponse>
 ;     <SCHEMA></SCHEMA>
 ;     <TABLE>
 ;       <ROWS>
 ;         <ROW>
 ;           <CODE>
 ;           <DESCR>
 ;           <ACS>
 ;           . . .
 ;       <NUMBER></NUMBER>
 ;         <PATTERN></PATTERN>
 ;         <SUBTITLE></SUBTITLE>
 ;         <TITLE></TITLE>
 ;         <NOTES>
 ;            <TNS>
 ;               <TN>
 ;               . . .
 ;            </TNS>
 ;            <FNS/>
 ;         </NOTES>
 ;      </TABLE>
 ;   </CrResponse>
 ;</TableRecordCompleteResponse>
 ;
 ;
PARSETBR ;parse CS Table response message from cloud server
 ;
 ;Supported IA #3561 reference to ^MXMLDOM
 ;
 ;ONCRHDL = response handle from the MXML parser
 ;ONCTAG1 = 1st level tags; ONCTAG2 = 2nd level tags; ONCTAG3 = 3rd level tags
 ;ONCPARR = array of server response values; ^TMP("ONCPARSE" = errors
 ;ERRFLG SET = 0 if NO EDITs errors, if there are EDITs errors set = 1
 N ONCRHDL,ONCTAG1,ONCTAG2,ONCTAG3,ONCTAG4,ONCTAG5
 S ERRFLG=0 S ONCRHDL=$$EN^MXMLDOM($NA(^TMP("ONCTBRSP",$J)),"W")
 I $D(^TMP("MXMLERR",$J)) D  Q
 .N HDL S HDL=^TMP("MXMLERR",$J)
 .W !!?3,"XML message",!
 .N X S X=^TMP("MXMLERR",$J,HDL,"MSG") S DIWL=3,DIWR=77 D ^DIWP,^DIWW
 .W !?3,"XML error",!
 .N X S X=^TMP("MXMLERR",$J,HDL,"XML") S DIWL=3,DIWR=77 D ^DIWP,^DIWW
 .S ERRFLG=2
 ;--- Traverse top level child(ren) nodes
 K ONCPARR,ONCVLARR,^TMP("ONCPARSE",$J)
 N CT,NUM,NOTE S NUM=0,NOTE=1
 S CT=1 F  S CT=$$CHILD^MXMLDOM(ONCRHDL,1,CT) Q:CT=0  D
 .N ONCTAG1 S ONCTAG1=$$NAME^MXMLDOM(ONCRHDL,CT)
 .;--- Traverse second level child(ren) nodes
 .N CT2 S CT2=1 F  S CT2=$$CHILD^MXMLDOM(ONCRHDL,CT,CT2) Q:CT2=0  D
 ..N ONCTAG2 S ONCTAG2=$$NAME^MXMLDOM(ONCRHDL,CT2)
 ..N OUT S OUT=""
 ..N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT2,"TXT") OUT=TXT(1)
 ..;S ONCPARR(ONCTAG2)=OUT
 ..;--- Traverse third level child(ren) nodes
 ..N CT3 S CT3=1 F  S CT3=$$CHILD^MXMLDOM(ONCRHDL,CT2,CT3) Q:CT3=0  D
 ...N ONCTAG3 S ONCTAG3=$$NAME^MXMLDOM(ONCRHDL,CT3)
 ...N OUT S OUT=""
 ...N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT3,"TXT") OUT=TXT(1)
 ...S ONCPARR(ONCTAG3)=OUT
 ...;--- Traverse fourth level child(ren) nodes
 ...N CT4 S CT4=1 F  S CT4=$$CHILD^MXMLDOM(ONCRHDL,CT3,CT4) Q:CT4=0  D
 ....N ONCTAG4 S ONCTAG4=$$NAME^MXMLDOM(ONCRHDL,CT4)
 ....N OUT S OUT=""
 ....N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT4,"TXT") OUT=TXT(1)
 ....I ONCTAG4="ROW" S NUM=NUM+1
 ....;--- Traverse fifth level child(ren) nodes
 ....N CT5 S CT5=1 F  S CT5=$$CHILD^MXMLDOM(ONCRHDL,CT4,CT5) Q:CT5=0  D
 .....N ONCTAG5 S ONCTAG5=$$NAME^MXMLDOM(ONCRHDL,CT5)
 .....N OUT S OUT=""
 .....N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT5,"TXT") OUT=TXT(1)
 .....I ONCTAG5="CODE" S ^TMP("ONCPARSE",$J,NUM,"CODE")=OUT D
 ......I OUT?3N1"-"3N D RANGE Q
 ......I OUT="000" S ONCVLARR(0)=""
 ......S ONCVLARR(OUT)=""
 .....I ONCTAG5="DESCR" S ^TMP("ONCPARSE",$J,NUM,"DESCR")=OUT ;txt runs 1 line?
 .....I ONCTAG5="TN" S ^TMP("ONCPARSE",$J,"NOTE",NOTE)=OUT,NOTE=NOTE+1
 ...Q
 ..Q
 .Q
 D DELETE^MXMLDOM(ONCRHDL)
 K ONCRHDL
 Q
 ;
 ;--- CS COMPUTE COLLABORATIVE STAGE RESPONSE FROM THE CLOUD WEB SERVICE
 ;
 ; CS ERRORS
 ; <CsCalculateResponse xmlns:xsi="http://www.w3.org/2001/...XMLSchema">
 ; <NumberOfError>0</NumberOfError>
 ; <IsRequestValid>false</IsRequestValid>
 ; <Message>Lookup of codes (988, 988, 988) in Serum Tumor Marker S Value Table
 ;      Based on CS SSF 1, 2, 3 returns "ERROR".
 ; </Message>
 ; </CsCalculateResponse>
 ;
 ; CS SUCCESS
 ; <CsCalculateResponse xmlns:xsi=""http://www.w3.org/2001/XMLSchema-inst...
 ; <NumberOfError>0</NumberOfError>
 ; <IsRequestValid>true</IsRequestValid>
 ; <CS-STOR>
 ;   <T>30</T>
 ;   <TDESCR>p</TDESCR>
 ;   <N>00</N>
 ;   <NDESCR>c</NDESCR>
 ;   <M>00</M>
 ;   <MDESCR>c</MDESCR>
 ;   <AJCC>30</AJCC>
 ;   <AJCC7-T></AJCC7-T>
 ;   <AJCC7-TDESCR></AJCC7-TDESCR>
 ;   <AJCC7-N></AJCC7-N>
 ;   <AJCC7-NDESCR></AJCC7-NDESCR>
 ;   <AJCC7-M></AJCC7-M>
 ;   <AJCC7-MDESCR></AJCC7-MDESCR>
 ;   <AJCC7-STAGE></AJCC7-STAGE>
 ;   <SS1977>2</SS1977>
 ;   <SS2000>2</SS2000>
 ; </CS-STOR>
 ; <CS-DISP>
 ;   <T>T3</T>
 ;   <TDESCR>p</TDESCR>
 ;   <N>N0</N>
 ;   <NDESCR>c</NDESCR>
 ;   <M>M0</M>
 ;   <MDESCR>c</MDESCR>
 ;   <AJCC>II</AJCC>
 ;   <AJCC7-T></AJCC7-T>
 ;   <AJCC7-TDESCR></AJCC7-TDESCR>
 ;   <AJCC7-N></AJCC7-N>
 ;   <AJCC7-NDESCR></AJCC7-NDESCR>
 ;   <AJCC7-M></AJCC7-M>
 ;   <AJCC7-MDESCR></AJCC7-MDESCR>
 ;   <AJCC7-STAGE></AJCC7-STAGE>
 ;   <SS1977>RE</SS1977>
 ;   <SS2000>RE</SS2000>
 ; </CS-DISP>
 ; <APIVER>020550</APIVER>
 ; <VERSION>2.00P</VERSION>
 ; </CS-RESPONSE>
 ;
PARSECS ;parse CS Schema response message from cloud server
 ;
 ;Supported IA #3561 reference to ^MXMLDOM
 ;
 ;ONCRHDL = response handle from the MXML parser
 ;ONCTAG1 = 1st level tags, ONCTAG2 = 2nd level tags
 ;ONCPARR = array of server response tags and values
 ;ONCSTORE = array for derived values to store in 165.5, returned if successful
 ;ONCDISPL = array for derived values to display, returned if successful
 ;ONCCSERR = array of error messages, returned if unsuccessful
 ;ONCAPIVR = CS version number, ONCVERSN = version
 ;ERRFLG SET = 0 if NO CS errors, success
 ;           = 1 if there are CS errors set
 ;           = 2 if there is XML request/response failure
 N ONCRHDL,ONCTAG1
 S ONCCSSCH="E",ONCCSSNM=""
 S ERRFLG=0 S ONCRHDL=$$EN^MXMLDOM($NA(^TMP("ONCCSRSP",$J)),"W")
 I $D(^TMP("MXMLERR",$J)) D  Q
 .S ERRFLG=2
 .N HDL S HDL=^TMP("MXMLERR",$J)
 .W !!?3,"XML message",!
 .N X S X=^TMP("MXMLERR",$J,HDL,"MSG") S DIWL=3,DIWR=77 D ^DIWP,^DIWW
 .W !?3,"XML error",!
 .N X S X=^TMP("MXMLERR",$J,HDL,"XML") S DIWL=3,DIWR=77 D ^DIWP,^DIWW
 .K ONCRHDL,^TMP("ONCCSRSP",$J)
 ;--- Traverse top level child(ren) nodes
 K ONCPARR,ONCSTORE,ONCDISPL,ONCAPIVR,ONCVERSN,ONCCSERR
 N CT S CT=1 F  S CT=$$CHILD^MXMLDOM(ONCRHDL,1,CT) Q:CT=0  D
 .N ONCTAG1 S ONCTAG1=$$NAME^MXMLDOM(ONCRHDL,CT)
 .N OUT S OUT=""
 .N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT,"TXT") OUT=TXT(1)
 .;W !?2,"onctag1=",ONCTAG1,"---> out=",OUT
 .S ONCPARR(ONCTAG1)=OUT
 .;I ONCTAG1="IsRequestValid",OUT="false" S ERRFLG=1
 .I ONCTAG1="Message" S ONCCSERR(ONCTAG1)=OUT S ERRFLG=1 Q
 .I ONCTAG1="ErrorMessage" S ONCCSERR(ONCTAG1)=OUT S ERRFLG=1 Q
 .;--- Traverse second level child(ren) nodes
 .N CT2 S CT2=1 F  S CT2=$$CHILD^MXMLDOM(ONCRHDL,CT,CT2) Q:CT2=0  D
 ..N ONCTAG2 S ONCTAG2=$$NAME^MXMLDOM(ONCRHDL,CT2)
 ..N OUT S OUT=""
 ..N TXT S:$$TEXT^MXMLDOM(ONCRHDL,CT2,"TXT") OUT=TXT(1)
 ..;W !,?8,"onctag2=",ONCTAG2,": ",OUT
 ..S ONCPARR(ONCTAG2)=OUT
 ..I ONCTAG1="CsStor" S ONCSTORE(ONCTAG2)=OUT
 ..I ONCTAG1="CsDisp" S ONCDISPL(ONCTAG2)=OUT
 ..Q
 .I ONCTAG1="Apiver" S ONCAPIVR=OUT
 .I ONCTAG1="Version" S ONCVERSN=OUT
 D DELETE^MXMLDOM(ONCRHDL)
 K ONCRHDL,^TMP("ONCCSRSP",$J)
 Q
 ;
DISERR ;
 I $D(ONCPARR("Message")) W !?3,ONCPARR("Message"),!!
 I $D(ONCPARR("ErrorMessage")) W !?3,ONCPARR("ErrorMessage"),!!
 ; W N N F N=1:1 S N=$O(ONCCSERR(N)) W !,N
 Q
 ;
RANGE ;
 N LOW,HIGH,Z
 S LOW=$P(OUT,"-",1),HIGH=$P(OUT,"-",2)
 F Z=LOW:1:HIGH S ONCVLARR(Z)=""
 Q
 ;
DISPLAY ; display CS table codes, descriptions and notes
 ;
 K ^UTILITY($J,"W")
 S PG=0,EX="",LINE=$S($E(IOST,1,2)="C-":IOSL-2,1:IOSL-6)
 W @IOF
 I $D(ONCPARR("TITLE")) W !?4,ONCPARR("TITLE")
 I $D(ONCPARR("SUBTITLE")) W !?4,ONCPARR("SUBTITLE")
 W !
 N CODE,DESCR S CODE="",DESCR=""
 F N=0:0 S N=$O(^TMP("ONCPARSE",$J,N)) Q:N'>0  D
 .S CODE=^TMP("ONCPARSE",$J,N,"CODE"),DESCR=^TMP("ONCPARSE",$J,N,"DESCR")
 .N X S X=CODE_"  "_DESCR S DIWL=3,DIWR=77 D ^DIWP,^DIWW D P Q:EX=U
 F N=0:0 S N=$O(^TMP("ONCPARSE",$J,"NOTE",N)) Q:N'>0  D
 .W ! N X S X=^TMP("ONCPARSE",$J,"NOTE",N)
 .S DIWL=3,DIWR=77 D ^DIWP,^DIWW D P Q:EX=U
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
 Q
