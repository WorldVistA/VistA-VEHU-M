DENTVRP8 ;DSS/KC - QUEUE THE DENTAL EXTRACT ;03/15/2004 09:37
 ;;1.2;DENTAL;**38,39,43**;Aug 10, 2001
 ;Copyright 1995-2005, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  DBIA#  SUPPORTED  Description
 ;  -----  ---------  --------------------------------------
 ;  10063      X      %ZTLOAD
 ;  10103      x      $FMTH^XLFDT
 ;   2118      x      %ZISTCP
 ;
Q(RET,DATA) ;Queue the extract RPC: DENTV NEW EXTRACT
 ; input is data array:
 ;    STARTDT = external date MM/dd/yyyy
 ;    ENDDT = external date MM/dd/yyyy
 ;    RUNDTTM = external date MM/YY/YYYY@hh:mm
 ;    FILE = location of file (e.g. "D:\TEMP\EXTRACT.TXT")
 ;    IPADX = IP address of server waiting to process file
 ;    PORT = port# of server
 ;    PROVIEN = p1^p2^p3^p4 where p1=ALL, or list of prov ids
 ;             *OLD*internal provider ID (get only these records)
 ;    FORMAT = 0 Excel, 1 Access (break files if Excel and rows > 65K)
 ;    STN = null for all stations, or Station#
 ;    TXN = CPFO or any combination of transaction statuses (compl/plan/find/obs)
 ; returns Taskman Task#^success message or -1^error message
 N X,SDT,EDT,RDT,IP,PORT,PROV,FORMAT,STN,FILE,ZTSK,ZTIO,ZTRTN,ZTDTH,ZTSAVE,ZTDESC
 D CNVT^DSICDT(.SDT,$G(DATA("STARTDT")),"E","F") I $P(SDT,U)="ERR"!(SDT="") D ERR(1) Q
 D CNVT^DSICDT(.EDT,$G(DATA("ENDDT")),"E","F") I $P(EDT,U)="ERR"!(EDT="") D ERR(2) Q
 D CNVT^DSICDT(.RDT,$G(DATA("RUNDTTM")),"E","F") I $P(RDT,U)="ERR"!(RDT="") D ERR(3) Q
 S FILE=$G(DATA("FILE")),IP=$G(DATA("IPADX")),PORT=$G(DATA("PORT"))
 S PROV=$G(DATA("PROVIEN")),FORMAT=$G(DATA("FORMAT")),TXNS=$G(DATA("TXNS")),STN=$G(DATA("STN"))
 I STN]"" S STN=$$FIND1^DIC(4,,"MX",STN,,,"DENERR") I 'STN D ERR(8) Q  ;add station sort patch 43
 S STN=$G(DATA("STN")) ; after checking validity, reset back so that DENTVRP9 can convert old/new extract calls
 S FILE=$E(FILE,0,$L(FILE)-4)
 I FILE="" D ERR(4) Q
 I IP=""!(IP'?1.3N1P1.3N1P1.3N1P1.3N) D ERR(5) Q
 I PORT="" D ERR(6) Q
 S ZTIO="",ZTDTH=$$FMTH^XLFDT(RDT),ZTRTN="RUN^DENTVRP8"
 S ZTDESC="GET HISTORICAL RECORDS FOR DENTAL EXTRACT"
 F X="FILE","IP","PORT","PROV","SDT","EDT","EXCEL","TXNS","STN" S ZTSAVE(X)=""
 D ^%ZTLOAD
 I $G(ZTSK) S RET=ZTSK_"^Extract successfully queued on "_$G(DATA("RUNDTTM")) Q
 D ERR(7)
 Q
 ;
ERR(X,Y,Z) ;  error messages from this routine - expects X=1,2,3
 ;;Invalid Start Date
 ;;Invalid End Date
 ;;Invalid Run Date/Time
 ;;Invalid File location
 ;;Invalid IP address
 ;;Invalid Port#
 ;;Unable to task the Extract - try again later!
 ;;Invalid Station
 I +X=X S X=$P($T(ERR+X),";",3)
 S:$G(Y)'="" X=X_Y
 S RET="-1^"_X
 Q
 ;
RUN ;entry point for tasked job to run the extract
 N I,DENTER,POP,TRACE,NODE,CRC,DATA,X,ROWS,INCR,HDR
 S (I,DENTER,NODE,ROWS,INCR)=0
 S HDR="",POP=1 ;pop=1 is failure, pop=0 is okay
 S TRACE=$NA(^TMP("DENTEX",$J)) K @TRACE
 D EXCEL^DENTVRP9(.RET,SDT,EDT,PROV,"",TXNS,STN)
 I '$D(@RET) Q
 D CALL^%ZISTCP(IP,PORT,1)
 I POP D TRACE("-1^TCP/IP Connection Failed") G OUT
 ;D SEND("DEBUGON"),CREAD ;debug the service
 ;send filename to start conversation
 D FILE(FILE) G:DENTER OUT
 ;get the header row in case we have to split files >65K rows
 S I=$O(@RET@(I)) I I S HDR=$G(^(I))
 I HDR]"" D HDR G:DENTER OUT
 ;start sending extract data
 F  S I=$O(@RET@(I)) Q:'I!DENTER  S DATA=$G(^(I)) I DATA'="$" D
 .S ROWS=ROWS+1
 .I ROWS=64999 D END(1),DONE H 3 S INCR=INCR+1 D FILE(FILE_INCR) Q:DENTER  D HDR S ROWS=1
 .D SEND(DATA),CREAD
 .Q
 I DENTER D SEND("ABORT") G OUT
 D END(0),DONE
 ;D SEND("DEBUGOFF"),CREAD ;debug the service
 G OUT
 Q
FILE(FLNAME) D SEND("FILENAME$$"_FLNAME_".TXT"),CREAD Q
HDR D SEND(HDR),CREAD Q
END(M) D SEND("END OF FILE"_$S(M=0:"",1:" (CONT...)")),CREAD Q
DONE D SEND("DONE"),CREAD Q
OUT ;make sure connection is closed before leaving
 K @RET ;clean up the extract temp global
 D SEND("SHUTDOWN") ;stop the DRMExtract process running on the client
 D CLOSE^%ZISTCP ;close the Vista/Client TCP/IP connection
 Q
 ;
SEND(MSG) ;Send a cmd MSG
 ;S CRC=$$CRC32^XLFCRC(MSG) S MSG=CRC_"$$"_MSG
 W "$$",MSG,$C(13,10),!
 D TRACE("Cmd Send "_MSG)
 Q
CREAD ;Read a string
 N Y S Y=""
 R X:10 S:'$T DENTER=1 Q:DENTER  S Y=X
 S:+Y<0 DENTER=1
 D TRACE("Cmd Read "_Y)
 Q
TRACE(S1) ;
 Q  S NODE=$G(NODE)+1,@TRACE@(NODE)=S1
 Q
