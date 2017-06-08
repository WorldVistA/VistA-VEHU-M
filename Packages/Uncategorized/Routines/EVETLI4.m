EVETLI4 ;SLC/GPM - Evet Listener, read response ; 2/9/04 10:11am
 ;;1.0;HEALTH EVET;**1,2**;Nov 05, 2002
 ;
 Q
 ;
GETRESP(MSGTYPE,BLKSIZE,EOM) ;Get response from server, builds ^TMP("EVET_XML_PARSE"), assumes port is open
 ; MSGTYPE - message type
 ; BLKSIZE - Block size for reads
 ;     EOM - End of Message character
 N EVDEBUG
 S EVDEBUG=0
 N ERR
 S ERR=0
 I $G(EOM)="" S EOM=$C(3)
 I $G(BLKSIZE)<255 S BLKSIZE=255
 K ^TMP("EVET_XML_PARSE",$J,MSGTYPE)
 K ^TMP("EVETCOMM",$J,MSGTYPE)
 D
 .D READMSG Q:ERR
 .D DCRYPMSG Q:ERR
 .D PARSEMSG Q:ERR
 Q:'ERR
 S ^TMP("EVET_XML_PARSE",$J,MSGTYPE,"ERROR","result")=$P(ERR,";",2)
 I EVDEBUG M ^TMP("EVET_DEBUG_TR",$J,$H,"EVETCOMM")=^TMP("EVETCOMM") Q
 K ^TMP("EVET_DEBUG_TR",$J,"EVETCOMM")
 M ^TMP("EVET_DEBUG_TR",$J,"EVETCOMM")=^TMP("EVETCOMM")
 Q
 ;
READMSG ;Read message, store in ^TMP("EVETCOMM",$J,message type,"RAW")
 N I,J,BLK
 S X="READERR^EVETLI4",@^%ZOSF("TRAP")
 S ERR=0
 F I=1:1 D  Q:BLK[EOM!ERR
 .R BLK#BLKSIZE:1 E  F J=1:1:15 R BLK#BLKSIZE:60 I  Q
 .I BLK="" S ERR="1;Error: READ TIMEOUT" Q
 .S ^TMP("EVETCOMM",$J,MSGTYPE,"RAW",I)=BLK
 Q
READERR ;Error trap for read loop
 S ERR="1;Error: READ ERROR"
 Q
 ;
DCRYPMSG ;Decrypt message, store in ^TMP("EVETCOMM",$J,message type,"DEC")
 N I,J,BLK
 S ERR=0,BLK="",J=0
 F I=1:1 Q:'$D(^TMP("EVETCOMM",$J,MSGTYPE,"RAW",I))  D  Q:ERR
 .S BLK=BLK_^TMP("EVETCOMM",$J,MSGTYPE,"RAW",I)
 .I $L(BLK)<BLKSIZE,BLK'[EOM Q
 .I $L(BLK)'>BLKSIZE,BLK[EOM S DATA=$P(BLK,EOM),BLK="" Q:DATA=""
 .E  S DATA=$E(BLK,1,BLKSIZE),BLK=$E(BLK,BLKSIZE+1,$L(BLK))
 .S J=J+1,^TMP("EVETCOMM",$J,MSGTYPE,"DEC",J)=$$DECRYP^EVETENC(DATA)
 I BLK'="",BLK[EOM S ^TMP("EVETCOMM",$J,MSGTYPE,"DEC",J+1)=$$DECRYP^EVETENC($P(BLK,EOM)) Q
 I BLK'="" S ERR="1;Error: END OF MESSAGE NOT SENT",^TMP("EVETCOMM",$J,MSGTYPE,"DEC",J+1)=BLK Q
 Q
 ;
PARSEMSG ;Parse Message, Build ^TMP("EVET_XML_PARSE")
 N I,BLKNUM,BLK,EVREQID,XMLSTR,TAG,DATA
 S EVREQID=$J                       ;Evault Request ID
 S ERR=0
 ;
 ;Check for communication errors
 S BLKNUM=$O(^TMP("EVETCOMM",$J,MSGTYPE,"DEC",0)) Q:BLKNUM=""
 S BLK=^TMP("EVETCOMM",$J,MSGTYPE,"DEC",BLKNUM)
 I BLK["Error" D  Q:ERR
 .I $P($P(BLK,"<result>",2),"</result>")["Error" Q
 .S ERR=$E("1;(Server) "_BLK,1,246)
 ;
 ;Check Header
 I $P(BLK," ")'="<?xml" Q           ;Only handle XML for now
 S XMLSTR=BLK
 D GETTAG("HEADER")                 ;Get XML Header
 ;
 ;Parse Body
 D GETTAG("OPEN")                   ;Get message type
 I $P(TAG," ")'?1"eVault"1A.A1"Response_1" S ERR="1;Error: INVALID MESSAGE TYPE" Q
 D GETDATA
 D GETTAG("CLOSE")
 I XMLSTR'="" S ERR="1;Error: UNABLE TO PARSE XML"
 Q
 ;
GETDATA ;Retrieve data and subtags between tags
 I TAG="update_requested" D GETREQS Q
 I XMLSTR'["<" D ADDBLK
 I $E(XMLSTR)="<",$E(XMLSTR,2)'="/" D  Q
 .F  D GETTAG("OPEN") Q:TAG=""  D GETDATA,GETTAG("CLOSE")
 S DATA=$P(XMLSTR,"<")
 I DATA'="" S XMLSTR=$P(XMLSTR,DATA,2,9999)
 I TAG="sequence_id" S EVREQID=DATA
 I TAG="request_id" S EVREQID=DATA
 S ^TMP("EVET_XML_PARSE",$J,MSGTYPE,EVREQID,TAG)=DATA
 Q
 ;
GETTAG(TYPE) ;Get tag at head of string XMLSTR
 I XMLSTR'[">" D ADDBLK
 I TYPE="OPEN",$E(XMLSTR,2)="/" S TAG="" Q
 S TAG=$P($P(XMLSTR,">"),"<",2)
 S XMLSTR=$P(XMLSTR,TAG_">",2,9999)
 Q
 ;
GETREQS ;Get individual subject areas
 F I=1:1 D  Q:$E(XMLSTR)="<"
 .I XMLSTR'["^",XMLSTR'["<" D ADDBLK
 .I XMLSTR["^" S DATA=$P(XMLSTR,"^"),XMLSTR=$P(XMLSTR,DATA_"^",2,9999)
 .E  S DATA=$P(XMLSTR,"<") S:DATA'="" XMLSTR=$P(XMLSTR,DATA,2,9999)
 .S:DATA'="" ^TMP("EVET_XML_PARSE",$J,MSGTYPE,EVREQID,TAG,I)=DATA
 Q
 ;
ADDBLK ;Add a block to XMLSTR
 S BLKNUM=$O(^TMP("EVETCOMM",$J,MSGTYPE,"DEC",BLKNUM)) Q:BLKNUM=""
 S BLK=^TMP("EVETCOMM",$J,MSGTYPE,"DEC",BLKNUM)
 S XMLSTR=XMLSTR_BLK
 Q
 ;
