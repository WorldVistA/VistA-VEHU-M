XWBUTL ;OIFO-Oakland/REM - M2M Programmer Utilities ; 8/28/2013 10:44am
 ;;1.1;RPC BROKER;**28,34,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBUTL is not callable at the top
 ;
 ; Change History:
 ;
 ; 2002 08 10 OIFO/REM: XWB*1.1*28 SEQ #25, M2M Broker. Original routine
 ; created. 
 ;
 ; 2005 10 26 OIFO/REM: XWB*1.1*34 SEQ #33, M2M Bug Fixes. Corrected typo
 ; changing ">" to "<" in QUIT:STR'[">". Added "[]" as escape characters.
 ; in CHARCHK.
 ;
 ; 2013 08 28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Log error events. Refactor ERROR for clarity. Change History added.
 ; in XWBUTL, ERROR, EOR.
 ;
 ;
XMLHDR() ; -- provides current XML standard header
 QUIT "<?xml version=""1.0"" encoding=""utf-8"" ?>"
 ;
 ;
ERROR(XWBDAT) ; -- log & send error type message
 ; input: XWBDAT array (see documentation in BUILD, below)
 ; output:
 ;   error is logged in the Broker's troubleshooting log
 ;   error is transmitted via socket to the client
 ;
 ; 1. conditionally log error in Broker troubleshooting log
 ;
 I $G(XWBDEBUG) D  ; if debugging is on
 . N XWBENAME ; name of error
 . I XWBDEBUG=1 D  ; if debug=1, "on"
 . . S XWBENAME="Error"
 . E  D  ; if debug=2 or 3, "verbose" or "very verbose"
 . . S XWBENAME="Error: "_$G(XWBDAT("ERRORS",1,"MESSAGE",1))
 . N XWBARRAY ; error array, usually empty & not passed
 . N XWBANAME S XWBANAME="" ; name of error array to pass
 . I XWBDEBUG=3 D  ; if debug="very verbose"
 . . M XWBARRAY=XWBDAT ; include the whole error type message
 . . S XWBANAME="XWBARRAY" ; set name to pass
 . D LOG^XWBDLOG(XWBENAME,XWBANAME) ; log the error
 ;
 ; 2. build XML error message to transmit
 ;
 N XWBMSG ; array to record XML error message
 D BUILD("XWBMSG",.XWBDAT) ; build XML
 ;
 ; 3. transmit XML error message to client
 ;
 D PRE^XWBRL ; prepare socket for writing
 N XWBLINE S XWBLINE=0 ; line # in XML message
 F  D  Q:'XWBLINE  ; traverse all lines in msg
 . S XWBLINE=$O(XWBMSG(XWBLINE)) ; traverse each line in msg
 . Q:'XWBLINE  ; end loop when we're out of lines
 . D WRITE^XWBRL(XWBMSG(XWBLINE)) ; write a line to the client
 D POST^XWBRL ; send EOT and flush socket buffer
 ;
 QUIT  ; end of ERROR
 ;
 ;
BUILD(XWBY,XWBDAT) ;  -- build xml in passed store reference (XWBY)
 ; -- input format
 ; XWBDAT("MESSAGE TYPE") = type of message (ex. Gov.VA.Med.RPC.Error)
 ; XWBDAT("ERRORS",<integer>,"CODE") = error code
 ; XWBDAT("ERRORS",<integer>,"ERROR TYPE") = type of error (system/application/security)
 ; XWBDAT("ERRORS",<integer>,"MESSAGE",<integer>) = error message
 ;
 NEW XWBCODE,XWBI,XWBERR,XWBLINE,XWBETYPE
 SET XWBLINE=0
 ;
 DO ADD($$XMLHDR())
 DO ADD("<vistalink type="""_$G(XWBDAT("MESSAGE TYPE"))_""" >")
 DO ADD("<errors>")
 SET XWBERR=0
 FOR  SET XWBERR=$O(XWBDAT("ERRORS",XWBERR)) Q:'XWBERR  DO
 . SET XWBCODE=$G(XWBDAT("ERRORS",XWBERR,"CODE"),0)
 . SET XWBETYPE=$G(XWBDAT("ERRORS",XWBERR,"ERROR TYPE"),0)
 . DO ADD("<error type="""_XWBETYPE_""" code="""_XWBCODE_""" >")
 . DO ADD("<msg>")
 . IF $G(XWBDAT("ERRORS",XWBERR,"CDATA")) DO ADD("<![CDATA[")
 . SET XWBI=0
 . FOR  SET XWBI=$O(XWBDAT("ERRORS",XWBERR,"MESSAGE",XWBI)) Q:'XWBI  DO
 . . DO ADD(XWBDAT("ERRORS",XWBERR,"MESSAGE",XWBI))
 . IF $G(XWBDAT("ERRORS",XWBERR,"CDATA")) DO ADD("]]>")
 . DO ADD("</msg>")
 . DO ADD("</error>")
 DO ADD("</errors>")
 DO ADD("</vistalink>")
 ;
 QUIT
 ;
ADD(TXT) ; -- add line
 SET XWBLINE=XWBLINE+1
 SET @XWBY@(XWBLINE)=TXT
 QUIT
 ;
CHARCHK(STR) ; -- replace xml character limits with entities
 NEW A,I,X,Y,Z,NEWSTR
 SET (Y,Z)=""
 IF STR["&" SET NEWSTR=STR DO  SET STR=Y_Z
 . FOR X=1:1  SET Y=Y_$PIECE(NEWSTR,"&",X)_"&amp;",Z=$PIECE(STR,"&",X+1,999) QUIT:Z'["&"
 ;
 ;*p34-typo, change ">" to "<" in Q:STR'[...
 IF STR["<" FOR  SET STR=$PIECE(STR,"<",1)_"&lt;"_$PIECE(STR,"<",2,99) Q:STR'["<"
 IF STR[">" FOR  SET STR=$PIECE(STR,">",1)_"&gt;"_$PIECE(STR,">",2,99) Q:STR'[">"
 IF STR["'" FOR  SET STR=$PIECE(STR,"'",1)_"&apos;"_$PIECE(STR,"'",2,99) Q:STR'["'"
 IF STR["""" FOR  SET STR=$PIECE(STR,"""",1)_"&quot;"_$PIECE(STR,"""",2,99) QUIT:STR'[""""
 ;
 ;*p34-add "[]" as escape characters.
 IF STR["[" FOR  SET STR=$PIECE(STR,"[",1)_"&#91;"_$PIECE(STR,"[",2,99) Q:STR'["["
 IF STR["]" FOR  SET STR=$PIECE(STR,"]",1)_"&#93;"_$PIECE(STR,"]",2,99) Q:STR'["]"
 ;
 ;Remove ctrl char's
 S STR=$TR(STR,$C(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31))
 ;FOR I=1:1:$LENGTH(STR) DO
 ;. SET X=$EXTRACT(STR,I)
 ;. SET A=$ASCII(X)
 ;. IF A<31 S STR=$P(STR,X,1)_$P(STR,X,2,99)
 QUIT STR
 ;
 ;D=0 STR 2 NUM, D=1 NUM 2 STR
NUM(STR,D) ;Convert a string to numbers
 N I,Y
 S Y="",D=$G(D,0)
 I D=0 F I=1:1:$L(STR) S Y=Y_$E(1000+$A(STR,I),2,4)
 I D=1 F I=1:3:$L(STR) S Y=Y_$C($E(STR,I,I+2))
 Q Y
 ;
 ;
EOR ; end of routine XWBUTL
