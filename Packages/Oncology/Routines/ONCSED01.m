ONCSED01 ;HINES OIFO/SG - EDITS 'RUN BATCH' REQUEST ; 11/6/06 11:48am
 ;;2.2;ONCOLOGY;**1,16,19,20**;Jul 31, 2013;Build 5
 ;..P19
 ;P16 - hwsc encrytion function
 ;--- SOAP REQUST TO THE ONCOLOGY WEB SERVICE
 ;
 ; <?xml version="1.0" encoding="utf-8"?>
 ; <soap:Envelope
 ;   xmlns:soap="http://www.w3.org/2001/12/soap-envelope"
 ;   soap:encodingStyle="http://www.w3.org/2001/12/soap-encoding">
 ;   <soap:Body>
 ;     <ED-RUN-BATCH [edits-config="..."] ver="2.0"
 ;       xmlns="http://domaindomain.ext/oncology">
 ;       <NAACCR-RECORD> ... </NAACCR-RECORD>
 ;     </ED-RUN-BATCH>
 ;   </soap:Body >
 ; </soap:Envelope>
 ;
 ;--- ATTRIBUTES
 ;
 ; edits-config  Name of the configuration that should be used by
 ;               the server to validate the data.  By default,
 ;               the "DEFAULT" name is used.
 ;
 Q
 ;
 ;***** EXECUTES THE 'RUN BATCH' EDITS REQUEST
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; .ONC8REQ      Reference to a local variable that stores the
 ;               closed root of the request.
 ;
 ;               Sub-nodes of the variable are used internally
 ;               (see ^ONCSNACR and ^ONCSAPIR for details).
 ;
 ; [ONC8MSG]     Closed root of the buffer for error messages. By
 ;               default ($G(ONC8MSG)=""), the ^TMP("ONCSED01M",$J)
 ;               global node is used.
 ;
 ; @ONC8MSG@(
 ;   0)                  Result descriptor
 ;                         ^01: Number of errors
 ;                         ^02: Number of warnings
 ;                         ^03: Web-service version
 ;                         ^04: Metafile version
 ;   set#,
 ;     0)                Edit set descriptor
 ;                         ^01: Number of errors
 ;                         ^02: Number of warnings
 ;     1)                Edit set name
 ;     "E",
 ;       edit#,
 ;         0)            Edit descriptor
 ;                         ^01: Number of errors
 ;                         ^02: Number of warnings
 ;                         ^03: Edit index
 ;         1)            Edit name
 ;         "F",
 ;           fld#,
 ;             0)        Field descriptor
 ;                         ^01: Start position
 ;           1)          Field name
 ;           2)          Field value
 ;
 ;         "M",
 ;           msg#,
 ;             0)        Message descriptor
 ;                         ^01: Code
 ;                         ^02: Type
 ;             1)        Message text
 ;
 ;   "ES",
 ;     edit#)            set#
 ;
 ; The ^TMP("ONCSED01R",$J) and ^TMP("ONCSED01M",$J) global nodes
 ; are used by this function.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-6^Parameter 'ONC8REQ' has an invalid value: ''^
 ;              RBQEXEC+3^ONCSED01"
 ;
 ;        0  Ok
 ;
 ;        1  EDITS Warnings
 ;
 ;        2  EDITS Errors
 ;
RBQEXEC(ONCSAPI,ONC8REQ,ONC8MSG) ;
 N ONC8RDAT,RC,TMP,URL,X
 ;--- Validate parameters
 Q:$G(ONC8REQ)?." " $$ERROR^ONCSAPIE(-6,,"ONC8REQ",$G(ONC8REQ))
 S:$G(ONC8MSG)?." " ONC8MSG=$NA(^TMP("ONCSED01M",$J))
 ;--- Initialize variables
 S ONC8RDAT=$NA(^TMP("ONCSED01R",$J))
 K @ONC8RDAT,@ONC8MSG
 ;
 ;--- Finish preparation of the NAACCR record
 D END^ONCSNACR(.ONC8REQ)
 ;
 ;--- Complete the request
 D TRAILER^ONCSAPIR(.ONC8REQ)
 ;
 ;--- Get the server URL ;commented url to use HWSC
 S URL=$$GETCSURL^ONCSAPIU()  Q:URL<0 URL
 ;
 S RC=0  D
 . ;--- Call the web service ; commented run batch request and use HWSC
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONC8REQ,"*** 'RUN BATCH' REQUEST ***")
 . ;S RC=$$REQUEST^ONCSAPIR(URL,ONC8RDAT,ONC8REQ) Q:RC<0
 . ; P16
 . S ONCEXEC="P" D T3^ONCWEB1
 . D:$G(ONCSAPI("DEBUG"))
 . . D ZW^ONCSAPIU(ONC8RDAT,"*** 'RUN BATCH' RESPONSE ***")
 . ;--- Parse the response
 . D PARSE^ONCWEBP1
 . ;S RC=$$PARSE^ONCSED02(.ONCSAPI,ONC8RDAT,ONC8MSG)
 ;
 ;--- Cleanup
 K ^TMP("ONCSED01R",$J)
 D:RC'<0
 . S TMP=$G(@ONC8MSG@(0))
 . S RC=$S($P(TMP,U,1)>0:2,$P(TMP,U,2)>0:1,1:0)
 Q RC
 ;
 ;***** STARTS PREPARATION OF THE 'RUN BATCH' EDITS REQUEST
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; .ONC8REQ      Reference to a local variable that stores the
 ;               closed root of the buffer for the request.
 ;
 ;               Sub-nodes of the variable are used internally
 ;               (see ^ONCSNACR and ^ONCSAPIR for details).
 ;
 ; [CFGNAME]     Name of the configuration that should be used by
 ;               the server to validate the data.  By default,
 ;               the default configuration is used.
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-6^Parameter 'ONC8REQ' has an invalid value: ''^
 ;              RBQPREP+3^ONCSED01"
 ;
 ;        0  Ok
 ;
RBQPREP(ONCSAPI,ONC8REQ,CFGNAME) ;
 N ATTS
 D CLEAR^ONCSAPIE()
 ;--- Validate parameters
 Q:$G(ONC8REQ)?." " $$ERROR^ONCSAPIE(-6,,"ONC8REQ",$G(ONC8REQ))
 ;
 ;--- Standard request header
 S:'($G(CFGNAME)?." ") ATTS("edits-config")=CFGNAME
 D HEADER^ONCSAPIR(.ONC8REQ,"ED-RUN-BATCH",.ATTS)
 ;
 ;--- Start preparation of the NAACCR record
 D BEGIN^ONCSNACR(.ONC8REQ)
 ;---
 Q 0
 ;
 ;***** PRINTS 'EDITS' REPORT ON THE CURRENT DEVICE
 ;
 ; [.ONCSAPI]    Reference to the API descriptor (see ^ONCSAPI)
 ;
 ; ONC8MSG       Closed root of the list of parsed error messages
 ;               (generated by the RBQEXEC^ONCSED0101)
 ;
 ; [FLAGS]       Flags that control the output (can be combined):
 ;                 M  Include messages
 ;                 T  Include totals
 ;
 ; Return values:
 ;
 ;       <0  Error Descriptor (see ^ONCSAPI for details)
 ;           For example:
 ;             "-6^Parameter 'ONC8REQ' has an invalid value: ''^
 ;              RBQEXEC+3^ONCSED01"
 ;
 ;        0  Ok
 ;
 ;        1  Timeout
 ;        2  User canceled the output ('^' was entered) 
 ;
REPORT(ONCSAPI,ONC8MSG,FLAGS) ;
 N RC,TMP
 S TMP=$G(@ONC8MSG@(0))
 Q:($P(TMP,U,1)'>0)&($P(TMP,U,2)'>0) 0
 S FLAGS=$G(FLAGS)
 I $TR(FLAGS,"MT")'=FLAGS  W:$E(IOST,1,2)="C-" @IOF
 ;--- EDITS messages
 I FLAGS["M"  D  Q:RC RC
 . S RC=$$MESSAGES^ONCSED03(.ONCSAPI,ONC8MSG,FLAGS)
 ;--- EDITS totals
 I FLAGS["T"  D  Q:RC RC
 . S RC=$$TOTALS^ONCSED03(.ONCSAPI,ONC8MSG,FLAGS)
 ;---
 Q 0
 ;
XMLHDR ;XML header for Edits
 S ONCXMHR="EDIT"  ;for EDIT testing
 S ONCSKEY="d27e1428f71e47239327d7e77e1439c6"
 I $D(ONCCSTP) S:ONCCSTP="U" ONCCSTP="Update"  S:ONCCSTP="N" ONCCSTP="New"
 S ONCT=$$NOW^XLFDT(),ONCTZONE=$$TZ^XLFDT()
 ;S ONCT=$$HLDATE^HLFNC($$NOW^XLFDT())  ;USE this code instead
 S ONCTHR=$E(ONCT,9,10),ONCTMN=$E(ONCT,11,12),ONCTSN=$E(ONCT,13,14)
 S:ONCTSN="" ONCTSN="00"
 S:($L(ONCTSN)=1) ONCTSN="0"_ONCTSN
 S ONCTSN=ONCTSN_".000"_$E(ONCTZONE,1,3)_":"_$E(ONCTZONE,4,5)
 S ONCDTNW=""""_(1700+$E(ONCT,1,3))_"-"_$E(ONCT,4,5)_"-"_$E(ONCT,6,7)_"T"_ONCTHR_":"_ONCTMN_":"_ONCTSN_""""
 S ONCX21=1,ONCXML=6
 S ONCDIC="""http://naaccr.org/naaccrxml/naaccr-dictionary-230.xml"""
 S ONC11=" baseDictionaryUri="
 S ONC22=" recordType=",ONC33=" timeGenerated=",ONC44=" specificationVersion="
 ;For Edits and Collaborative Staging (CS)
 S:ONCXMHR="EDIT" ONCREQT="EditCheckRequest"
 S:ONCXMHR="CS" ONCREQT="CsCheckRequest"
 S ^TMP("ONC",$J,1)="<?xml version=""1.0"" encoding=""utf-8""?>"
 ;S ^TMP("ONC",$J,2)="<soap:Envelope xmlns:soap=""http://www.w3.org/2001/12/soap-envelope"""
 ;S ^TMP("ONC",$J,3)=" soap:encodingStyle=""http://www.w3.org/2001/12/soap-encoding"">"
 ;S ^TMP("ONC",$J,4)="<soap:Body>"
 ;S ^TMP("ONC",$J,5)="<"_ONCREQT_">"
 ;S ^TMP("ONC",$J,6)="<requestId>"_ONCREID_"</requestId>"
 ;S ^TMP("ONC",$J,7)="<caseId>"_ONCCSID_"</caseId>"
 ;S ^TMP("ONC",$J,8)="<caseType>"_ONCCSTP_"</caseType>"
 ;S ^TMP("ONC",$J,9)="<NaaccrData baseDictionaryUri=""http://naaccr.org/naaccrxml/naaccr-dictionary-230.xml"" recordType=""C"" timeGenerated="_ONCDTNW_" specificationVersion=""1.4"" xmlns=""http://naaccr.org/naaccrxml"""_">"
 S ^TMP("ONC",$J,2)="<"_ONCREQT_">"
 ;S ^TMP("ONC",$J,3)="<requestId>"_ONCREID_"</requestId>"
 S ^TMP("ONC",$J,3)="<requestId>"_ONCREID_"</requestId>"  ;test failure
 S ^TMP("ONC",$J,4)="<caseId>"_ONCCSID_"</caseId>"
 S ^TMP("ONC",$J,5)="<caseType>"_ONCCSTP_"</caseType>"
 ;S ^TMP("ONC",$J,6)="<ocpApimSubscriptionKey>"_ONCSKEY_"</ocpApimSubscriptionKey>"
 S ^TMP("ONC",$J,6)="<NaaccrData baseDictionaryUri=""http://naaccr.org/naaccrxml/naaccr-dictionary-230.xml"" recordType=""C"" timeGenerated="_ONCDTNW_" specificationVersion=""1.4"" xmlns=""http://naaccr.org/naaccrxml"""_">"
 Q
XMLEDIT ;Prepares EDIT xml data
 N ONCDE
 ;
 N ONCRTYP,ONCOLD,ONCPOS
 S ONCOLD="TEST",(ONCPOS,POS)="A",ONCRTYP="",ONCIE160(IEN)=IEN
 F  S POS=$O(^ONCO(160.16,EXTRACT,"FIELD","D",POS)) Q:POS=""  D
 .N NODE,ONCXDATA S NODE=0
 .I POS="P" S ONCRTYP="<Patient>"
 .I POS="T" S ONCRTYP="<Tumor>"
 .F  S NODE=$O(^ONCO(160.16,EXTRACT,"FIELD","D",POS,NODE)) Q:NODE<1  D  Q:OUT
 ..N STRING,DEFAULT,FILL,LEN,ONCXDATA
 ..Q:$G(^ONCO(160.16,EXTRACT,"FIELD",NODE,0))=""
 ..S ONCXDATA=$P(^ONCO(160.16,EXTRACT,"FIELD",NODE,0),U,5)
 ..Q:ONCXDATA=""
 ..I (POS'=ONCPOS),(ONCOLD'=ONCRTYP),(ONCRTYP'="") D
 ...S:POS="P" ^TMP("ONC",$J,ONCXML+1)=ONCRTYP,ONCXML=ONCXML+1
 ...S:POS="T" ^TMP("ONC",$J,ONCXML+1)=ONCRTYP,ONCXML=ONCXML+1
 ...S ONCOLD=ONCRTYP,ONCPOS=POS
 ..S LEN=$P(^ONCO(160.16,EXTRACT,"FIELD",NODE,0),U,2)
 ..S STRING=$TR(^ONCO(160.16,EXTRACT,"FIELD",NODE,1),"~","^")
 ..S DEFAULT=$P(^ONCO(160.16,EXTRACT,"FIELD",NODE,2),U,1)
 ..S FILL=$P(^ONCO(160.16,EXTRACT,"FIELD",NODE,3),U,1)
 ..;D DATA^ONCACD1(IEN,ACD160,STRING,DEFAULT,FILL,LEN,JUMP,NODE,POS)
 ..D DATA
 .S ONCXPRT=1
 S ^TMP("ONC",$J,ONCXML+1)="</Tumor>",ONCXML=ONCXML+1
 S ^TMP("ONC",$J,ONCXML+1)="</Patient>",ONCXML=ONCXML+1
 S ^TMP("ONC",$J,ONCXML+1)="</NaaccrData>",ONCXML=ONCXML+1
 S ^TMP("ONC",$J,ONCXML+1)="</EditCheckRequest>",ONCXML=ONCXML+1
 ;S ^TMP("ONC",$J,ONCXML+1)="</soap:Body>",ONCXML=ONCXML+1
 ;S ^TMP("ONC",$J,ONCXML+1)="</soap:Envelope>",ONCXML=ONCXML+1
 ;B  K ^TMP("ONC",$J)
 ;F I=1:1:167 S ^TMP("ONC",$J,I)=^XMB(3.9,3108776,2,I,0)
 ;B
 Q
DATA ;
 N ACDANS,EXIT S EXIT=0
 S:'$D(ONCPHI) ONCPHI=0   ;P2.2*4
 I $G(ONCX21)=1 D
 .;I $G(ONCPRNT)>20,(POS="N") Q
 .X STRING
 .;If value = "", extract DEFAULT value
 .I (ACDANS=""),(DEFAULT="BLANK") Q
 .N I,X S X=""
 .I DEFAULT=8 D
 ..F I=1:1:LEN S ACDANS=ACDANS_@DEFAULT
 .I @DEFAULT="09" S ACDANS=@DEFAULT
 .I (ACDANS["&")!(ACDANS["<")!(ACDANS[">") D STRIP^ONCACD1
 .D XFILL^ONCACD1
 .;S:POS="N" ONCTAB="  "
 .;S:POS="P" ONCTAB="     "
 .;S:POS="T" ONCTAB="       "
 .Q:ACDANS=""
 .S ^TMP("ONC",$J,ONCXML+1)="<Item naaccrId="""_ONCXDATA_""">"_ACDANS_"</Item>",ONCXML=ONCXML+1
 .;S ONCPRNT=ONCPRNT+1
 .Q
 Q
