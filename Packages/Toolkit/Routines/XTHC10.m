XTHC10 ;HCIOFO/SG - HTTP 1.1 CLIENT ; Oct 01, 2025  10:54
 ;;7.3;TOOLKIT;**123,566,162**;Apr 25, 1995;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;##### GETS THE DATA FROM THE PROVIDED URL USING HTTP 1.1
 ;
 ; URL           URL (http://host:port/path) (https://host:port/path)
 ;
 ; [XT8FLG]      (Optional) Timeout and flags to control processing.
 ;               If a value of this parameter starts with a number
 ;               then this number is used as a value of the timeout
 ;               (in seconds). Otherwise, the default value of 5
 ;               seconds is used.
 ;
 ; [XT8RDAT]     (Optional) Closed root of the variable where the message
 ;               body is returned. Data is stored in consecutive
 ;               nodes (numbers starting from 1). If a line is
 ;               longer than 245 characters, only 245 characters
 ;               are stored in the corresponding node. After that,
 ;               overflow sub-nodes are created. For example:
 ;
 ;                 @XT8DATA@(1)="<html>"
 ;                 @XT8DATA@(2)="<head><title>VistA</title></head>"
 ;                 @XT8DATA@(3)="<body>"
 ;                 @XT8DATA@(4)="<p>"
 ;                 @XT8DATA@(5)="Beginning of a very long line"
 ;                 @XT8DATA@(5,1)="Continuation #1 of the long line"
 ;                 @XT8DATA@(5,2)="Continuation #2 of the long line"
 ;                 @XT8DATA@(5,...)=...
 ;                 @XT8DATA@(6)="</p>"
 ;                 ...
 ;
 ; [.XT8RHDR]    (Optional) Reference to a local variable where the parsed
 ;               headers are returned. Header names are converted to
 ;               upper case and the values are left "as is". The root
 ;               node contains the status line. For example:
 ;
 ;                 XT8HDR="HTTP/1.1 200 OK"
 ;                 XT8HDR("ACCEPT-RANGES")="bytes"
 ;                 XT8HDR("CONNECTION")="close"
 ;                 XT8HDR("CONTENT-LENGTH")="16402"
 ;                 XT8HDR("CONTENT-TYPE")="text/html; charset=UTF-8"
 ;                 XT8HDR("DATE")="Thu, 25 Jun 2015 14:43:01 GMT"
 ;                 XT8HDR("ETAG")="a93a2-4012-5180156550680"
 ;                 XT8HDR("LAST-MODIFIED")="Mon, 08 Jun 2015 13:08:26 GMT"
 ;                 XT8HDR("SERVER")="Apache/2.2.15 (CentOS)"
 ;
 ; [XT8SDAT]     (Optional) Reference to a local variable containing the
 ;               request message body. Data should be formatted as in
 ;               variable XT8RDAT above.
 ;
 ; [.XT8SHDR]    (Optional) Reference to a local variable containing header
 ;               values, which will be added to the request.
 ;                 XT8SHDR("CONTENT-TYPE")="text/html"
 ;
 ; [XT8METH]     (Optional) Flag to indicate the request method.
 ;                    "GET"     - Default if XT8SDAT contains no data
 ;                    "POST"    - Default if XT8SDAT contains data
 ;                    "HEAD"
 ;                    "PUT"
 ;                    "OPTIONS"
 ;                    "DELETE"
 ;                    "TRACE"
 ;
 ; Return values:
 ;
 ;           <0  Error Descriptor
 ;           >0  HTTP Status Code^Description
 ;
 ;    Common HTTP status codes returned:
 ;          200  OK
 ;          301  Moved Permanently
 ;          400  Bad Request
 ;          401  Unauthorized
 ;          402  Payment Required
 ;          403  Forbidden
 ;          404  Not Found
 ;          405  Method Not Allowd
 ;          406  Not Acceptable
 ;          407  Proxy Authentication Required
 ;          408  Request Time-out
 ;          500  Internal Server Error
 ;          501  Not Implemented
 ;          502  Bad Gateway
 ;          503  Service Unavailable
 ;          504  Gateway Time-out
 ;          505  HTTP Version not supported
 ;
 ; See: www.ietf.org/rfc/rfc2616.txt (HTTP/1.1)
 ;      www.ieft.org/rfc/rfc2617.txt (HTTP Authentication)
 ;
GETURL(URL,XT8FLG,XT8RDAT,XT8RHDR,XT8SDAT,XT8SHDR,XT8METH) ;
 ;ZEXCEPT: %Net,%New,ContentType,HttpRequest,Https,Location,OpenTimeout,Port,Server,SSLCheckServerIdentity,SSLConfiguration,class   ; Cache ObjectScript methods and properties
 ;ZEXCEPT: Data,Get,GetHeader,GetNextHeader,Head,HttpResponse,Post,Put,ReadLine,ReasonPhrase,Send,SocketTimeout,StatusCode,StatusLine    ; Cache ObjectScript methods and properties
 N EOL,ERR,ESTATUS,HOST,I,J,K,LINENUM,NEWLINE,OVERFLOW,PATH,PORT,RDLEN,REQUEST,RESPONSE,STATUS,X,Y
 N REDIRECTCOUNT,MAXDIRECTS,XX,XLENGTH,XPIECE,XLEFTOVER,YY,HASLF
 ;
 S $ZT="ERROR"
 ;
 S URL=$G(URL) I URL="" Q "-1^Missing URL"
 S XT8FLG=$G(XT8FLG)  S:XT8FLG'?1.N.E XT8FLG="5"_XT8FLG
 ;
 I $G(XT8METH)'?1(1"GET",1"POST",1"HEAD",1"PUT",1"OPTIONS",1"DELETE",1"TRACE") D
 . I $D(XT8SDAT) S XT8METH="POST"
 . I '$D(XT8SDAT) S XT8METH="GET"
 ;
 ;Check IO
 I '$D(IO(0)) D HOME^%ZIS
 ;
 S STATUS=0,MAXDIRECTS=5
 F REDIRECTCOUNT=1:1:MAXDIRECTS  D  Q:+STATUS'=""&(+STATUS'?1"3".E)
 . S REQUEST=##class(%Net.HttpRequest).%New()
 . I '$IsObject(REQUEST) S STATUS="-1^Unable to create HTTP Request object" Q
 . S REQUEST.SSLConfiguration="encrypt_only_tlsv12" ;"encrypt_only_all"
 . S REQUEST.SSLCheckServerIdentity=1
 . S I=$$PARSEURL^XTHCURL(URL,.HOST,.PORT,.PATH) I I<0 S STATUS=I Q
 . ;
 . S REQUEST.Https=($$UP^XLFSTR(URL)?1"HTTPS://".E)
 . S REQUEST.Server=HOST
 . S REQUEST.Port=PORT
 . I $G(PATH)'="" S REQUEST.Location=PATH
 . S REQUEST.ContentType="text/html" ;Default. Can be overwritten by a custom header in XT8SHDR
 . S REQUEST.UserAgent="VistA/2.0" ;Default. Can be overwritten by a custom header in XT8SHDR
 . S REQUEST.OpenTimeout=+XT8FLG
 . S REQUEST.SocketTimeout=0
 . ;
 . ;Set custom headers
 . S I="" F  S I=$O(XT8SHDR(I))  Q:I=""  D REQUEST.SetHeader(I,XT8SHDR(I))
 . ;
 . I XT8METH?1(1"POST",1"PUT",1"OPTIONS",1"DELETE",1"TRACE") D
 . . S I=""
 . . F  S I=$O(@XT8SDAT@(I)) Q:I=""  D  ;load an entire page, not just key/value pairs
 . . . S NEWLINE=$G(@XT8SDAT@(I))
 . . . D REQUEST.EntityBody.Write(NEWLINE)
 . . . S J=""
 . . . F  S J=$O(@XT8SDAT@(I,J)) Q:J=""  D REQUEST.EntityBody.Write($G(@XT8SDAT@(I,J)))
 . . . D REQUEST.EntityBody.WriteLine("")
 . ;
 . S REQUEST.FollowRedirect=0 ;disable redirects, we will handle it
 . S ESTATUS=REQUEST.Send(XT8METH,"")
 . I 'ESTATUS D $system.Status.DecomposeStatus(ESTATUS,.ERR) S STATUS="-1^"_ERR(1) D APPERROR^%ZTER(ERR(1)) Q
 . ;
 . S RESPONSE=REQUEST.HttpResponse ;Sets the %Net.HttpResponse object
 . I '$IsObject(RESPONSE) S STATUS="-1^Did not receive HTTP Response" Q
 . S STATUS=RESPONSE.StatusCode_"^"_RESPONSE.ReasonPhrase
 . I +STATUS?1"3".E D
 . . S URL=RESPONSE.GetHeader("Location") I URL="" S STATUS="-1^Missing redirection URL." Q
 . . I XT8METH'="GET" S XT8METH="GET"
 . . D REQUEST.EntityBody.Clear()
 . . Q
 . ;
 . ;--- Header - Enter header into XT8RHDR
 . S XT8RHDR=RESPONSE.StatusLine
 . S I=""
 . F  D  Q:I=""
 . . S I=RESPONSE.GetNextHeader(I) Q:I=""  ;Name of header
 . . S XT8RHDR(I)=RESPONSE.GetHeader(I)    ;Value of header I
 . ;--- Data - Read stream one line at a time and enter into XT8RDAT
 . S LINENUM=1
 . S OVERFLOW=0
 . S (XLEFTOVER,HASLF)=""
 . F J=1:1 D  Q:(RESPONSE.Data.AtEnd)!(+STATUS=-1)  ;quit if at end of data stream or error
 . . S ESTATUS="" ;Status object
 . . S EOL=""
 . . S RDLEN=245
 . . S X=RESPONSE.Data.ReadLine(.RDLEN,.ESTATUS,.EOL) I X[$C(10),HASLF="" S HASLF=1
 . . I 'ESTATUS D
 . . . D $system.Status.DecomposeStatus(ESTATUS,.ERR) S STATUS="-1^"_ERR(1)
 . . E  I $D(XT8RDAT)>0 D
 . . . I HASLF D
 . . . . S X=XLEFTOVER_X I X'[$C(10) S XLEFTOVER=X Q
 . . . . S XLENGTH=$L(X,$C(10))
 . . . . F XX=1:1:XLENGTH D
 . . . . . I XX=XLENGTH S XLEFTOVER=$P(X,$C(10),XX) Q
 . . . . . S XPIECE=$P(X,$C(10),XX)
 . . . . . I $L(XPIECE)>RDLEN D
 . . . . . . S YY=$E(XPIECE,1,RDLEN)
 . . . . . . S @XT8RDAT@(LINENUM)=YY
 . . . . . . S XPIECE=$E(XPIECE,RDLEN+1,$L(XPIECE))
 . . . . . . D OVERFLOW(XPIECE,XT8RDAT,RDLEN,LINENUM)
 . . . . . E  S @XT8RDAT@(LINENUM)=XPIECE
 . . . . . S LINENUM=LINENUM+1
 . . . E  D
 . . . . I 'OVERFLOW S @XT8RDAT@(LINENUM)=X
 . . . . I OVERFLOW S @XT8RDAT@(LINENUM,OVERFLOW)=X
 . . . . S OVERFLOW=OVERFLOW+1
 . . . . I EOL D
 . . . . . S LINENUM=LINENUM+1
 . . . . . S OVERFLOW=0
 I +STATUS?1"3".E S STATUS="-1^Too many redirects"
 Q STATUS
 ;
OVERFLOW(DATA,XT8RDAT,RDLEN,LINENUM) ;XT162
 I $G(DATA)=""!($G(XT8RDAT)="")!($G(LINENUM)="") Q
 ;
 S $ZT="ERROR"
 S RDLEN=$G(RDLEN,245)
 N DONE,OVERFLOW,XDATA
 S DONE="",OVERFLOW=0
 F  D  Q:DONE
 . S XDATA=$E(DATA,1,RDLEN) I $L(DATA)<=RDLEN S DONE=1
 . S OVERFLOW=OVERFLOW+1
 . S @XT8RDAT@(LINENUM,OVERFLOW)=XDATA
 . S DATA=$E(DATA,RDLEN+1,$L(DATA))
 Q
 ;
ERROR  ;capture the error
 S $ZT=""
 D BACK^%ETN
 Q
