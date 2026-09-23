XTHCURL ;HCIOFO/SG - HTTP 1.0 CLIENT (URL TOOLS) ; Oct 01, 2025  10:54
 ;;7.3;TOOLKIT;**123,162**;Apr 25, 1995;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ;***** ENCODES THE STRING
 ;
 ; STR           String to be encoded
 ;
ENCODE(STR) ;
 N CH,I
 I $G(STR)="" Q "" ;XT162
 F I=1:1  S CH=$E(STR,I)  Q:CH=""  I CH?1CP  D
 . I CH="." Q
 . I CH=" "  S $E(STR,I)="+"  Q
 . S $E(STR,I)="%"_$$RJ^XLFSTR($$CNV^XLFUTL($A(CH),16),2,"0"),I=I+2
 Q STR
 ;
 ;##### CREATES URL FROM COMPONENTS
 ;
 ; HOST          Host name
 ; [PORT]        Port number (80, by default)
 ; [PATH]        Resource path ("/", by default)
 ;
 ; [.QUERY]      Reference to a local variable containing values of
 ;               the query parameters: QUERY(Name)=Value.
 ;
 ; Return values:
 ;           <0  Error Descriptor
 ;          ...  Resulting URL
 ;
MAKEURL(HOST,PORT,PATH,QUERY) ;
 N NAME,QSTR,VAL
 I $G(HOST)=""!('$D(QUERY)) Q "" ;XT162
 I HOST'["://" S HOST=$S(PORT=443:"https://",1:"http://")_HOST ;XT162
 S PORT=$S($G(PORT)>0:":"_(+PORT),1:"")
 ;---
 S (NAME,QSTR)=""
 F  S NAME=$O(QUERY(NAME))  Q:NAME=""  D
 . S VAL=$G(QUERY(NAME))
 . S QSTR=QSTR_"&"_$$ENCODE(NAME)_"="_$$ENCODE(VAL)
 S:QSTR'="" $E(QSTR,1)="?"
 ;---
 S:$G(PATH)="" PATH="/"
 Q HOST_PORT_$$NORMPATH($G(PATH)_QSTR)
 ;
 ;##### RETURNS "NORMALIZED" PATH
 ;
 ; PATH          Source path
 ;
NORMPATH(PATH) ;
 ;--- Make sure the path has a leading slash if it
 ;--- is not empty and has no query string.
 I $E(PATH,1)'="/",PATH'="" S:$E(PATH,1)'="?" PATH="/"_PATH ;XT162
 ;--- The logic to append a trailing slash has been removed as it
 ;--- can break modern RESTful URLs (e.g. /api/resource/123)
 Q PATH
 ;
 ;##### PARSES THE URL INTO COMPONENTS
 ;
 ; URL           Source URL
 ;
 ; .HOST         Reference to a local variable for the host name
 ; .PORT         Reference to a local variable for the port number
 ; .PATH         Reference to a local variable for the path
 ;
 ; Return values:
 ;           <0  Error Descriptor
 ;            0  Ok
 ;
PARSEURL(URL,HOST,PORT,PATH) ;
 ;XT162 Updated entire function to also handle https
 N ISHTTPS
 I $G(URL)="" Q "-1^No URL to parse."
 S ISHTTPS=($$UP^XLFSTR(URL)?1"HTTPS://".E)
 S:$F(URL,"://") URL=$P(URL,"://",2,999)
 S HOST=$TR($P(URL,"/")," ")
 S PATH=$$NORMPATH($P(URL,"/",2,999))
 S PORT=$P(HOST,":",2),HOST=$P(HOST,":")
 Q:HOST?." " "-1^Missing host name"
 I PORT'>0 S PORT=$S(ISHTTPS:443,1:80)
 Q 0
