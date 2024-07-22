ONCWEBCS ;HINES OIFO/RTK - Input transform and help for CS fields ;02/21/24
 ;;2.2;ONCOLOGY;**19**;Jul 31, 2013;Build 4
 ;
 Q
 ;
INPUT(TABLE,CODELEN,IEN) ;
 S X=$$TRIM^XLFSTR($G(X))
 I X'?@(CODELEN_"N")  K X  Q
 D:$G(IEN)>0
 .S SITE=$TR($$GET1^DIQ(165.5,IEN,20.1,,,"ONCMSG"),".")
 .S HIST=$E($$HIST^ONCFUNC(IEN),1,4)
 .S DISCRIM=$$GET1^DIQ(165.5,IEN,240)
 ;
 ; send server request for CS schema
 D GETSCHM
 ;
 ; get the Schema and SchemaName from the Schema response
 K ONCCSSCH,ONCCSSNM D PARSESCR^ONCWEBP2
 ;
 ; send server request for CS table
 I ONCCSSCH="E" W !!,"PROBLEM GETTING SCHEMA" K X,ONCCSSCH,ONCCSSNM Q
 S ONCCSTBL=TABLE D GETTBL
 ;
 ; get the Table info from the Table response and use it to validate data
 D PARSETBR^ONCWEBP2
 I '$D(ONCVLARR(X)),'$D(ONCVLARR(+X)) K X,ONCVLARR Q
 K ONCVLARR
 Q
HELP(TABLE,IEN) ;
 N ONCCSSCH,ONCCSSNM
 D:$G(IEN)>0
 .S SITE=$TR($$GET1^DIQ(165.5,IEN,20.1,,,"ONCMSG"),".")
 .S HIST=$E($$HIST^ONCFUNC(IEN),1,4)
 .S DISCRIM=$$GET1^DIQ(165.5,IEN,240)
 ;
 ; send server request for CS schema
 D GETSCHM
 ;  
 ; get the Schema and SchemaName from the Schema response
 K ONCCSSCH,ONCCSSNM D PARSESCR^ONCWEBP2
 ;
 ; send server request for CS table
 I ONCCSSCH="E" W !!,"PROBLEM GETTING SCHEMA" K X,ONCCSSCH,ONCCSSNM Q
 S ONCCSTBL=TABLE D GETTBL
 ;
 ; get the Table info from the Table response and display it
 D PARSETBR^ONCWEBP2
 D DISPLAY^ONCWEBP2
 Q
 ;
GETSCHM ;
 K ^TMP("ONCCSCMA",$J)
 S ^TMP("ONCCSCMA",$J,1)="<?xml version=""1.0"" encoding=""UTF-8""?>"
 S ^TMP("ONCCSCMA",$J,2)="<SchemaRecordCompleteRequest>"
 S ^TMP("ONCCSCMA",$J,3)="<requestId>1</requestId>"
 S ^TMP("ONCCSCMA",$J,4)="<requestType>New</requestType>"
 S ^TMP("ONCCSCMA",$J,5)="<site>"_SITE_"</site>"
 S ^TMP("ONCCSCMA",$J,6)="<hist>"_HIST_"</hist>"
 S ^TMP("ONCCSCMA",$J,7)="<discriminator>"_DISCRIM_"</discriminator>"
 S ^TMP("ONCCSCMA",$J,8)="</SchemaRecordCompleteRequest>"
 S ONCEXEC="P",ONCCSRQT="SCHEMA"
 K ^TMP("ONCSCRSP",$J) D T3^ONCWEB2
 Q
 ;
GETTBL ;
 K ^TMP("ONCCSTBL",$J)
 S ^TMP("ONCCSTBL",$J,1)="<CsGetTablesRequest>"
 S ^TMP("ONCCSTBL",$J,2)="<schema>"_ONCCSSCH_"</schema>"
 S ^TMP("ONCCSTBL",$J,3)="<table>"_ONCCSTBL_"</table>"
 S ^TMP("ONCCSTBL",$J,4)="<requestId>1234</requestId>"
 S ^TMP("ONCCSTBL",$J,5)="<requestType>test</requestType>"
 S ^TMP("ONCCSTBL",$J,5)="</CsGetTablesRequest>"
 S ONCEXEC="P",ONCCSRQT="TABLE"
 K ^TMP("ONCTBRSP",$J) D T3^ONCWEB2
 Q
