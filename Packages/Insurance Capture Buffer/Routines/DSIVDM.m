DSIVDM ;DSS/SGM - DOCMANAGER TO VISTA IMAGING RPCS ;06/30/2005 22:11
 ;;2.2;INSURANCE CAPTURE BUFFER;;May 19, 2009;Build 12
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;This routine is the only callable DSIVDM* routine from external sources
 ;It may be called as an RPC, a M API, or by the VistA Imaging via the
 ;callback routine
 ;
 ; Integration Agreements
 ; 10021  $$GET1^DID
 ;
OUT Q:$D(FUN) DSIV Q
 ;
IMPCK(DSIV,FUN) ; RPC: DSIV DM CHECK
 ;This rpc will check to see if VistA Imaging Import is supported
 ;As of 7/1/2003 - VI did not support import if the site had multiple
 ;VistA Imaging servers
 S DSIV=$$IMP^DSIVDM01 G OUT
 ;
DEL(DSIV,DSIVL) ; RPC: DSIV DM DEL QUEUE ENTRIES
 ;This RPC will allow for the deletion of one or more entries in file
 ;19621.
 ; DSIVL() = tranID or IEN of field .01
 ; Returns 1^msg or -1^msg
 G DEL^DSIVDM01
 ; 
STAT(DSIV,DSIVDAT) ; DSIV DM GET STATUS1
 ; this replaces the get status call by changing the format of the input
 ; parameter.  The old get status call will continue to work.  All new
 ; uses of this api should use this version.
 ; Documentation note: TX equals transaction ID (19621 .01 field value)
 ; DSIVDAT() - req - subscript value of DSIVDAT() is arbitrary
 ;   dsivdat() = label^value  where
 ;     Label   Req  Value
 ;     ------  ---  ---------------------------------------------------------
 ;     DEL          Boolean - default 0 - if 1 then delete records which were
 ;                  successfully imported and retrieved by this call
 ;     APP      x   Only return TXs for this APP CODE
 ;     SDT          get TXs >= this date, can be FM or external date format
 ;     EDT          get TXs <= this date, can be FM or external date format
 ;     MAX          Maximum number of transactions to retrieve
 ;     TRANID       TX
 ;     OVERRIDE     This RPC is hardcoded to get as many statuses as possible
 ;                    meeting the input filters in one minute.  This timer
 ;                    function can be overridden by this Boolean input param.
 ;                    I $G(OVERRIDE) then do not honor timer
 ;     WHICH        flag indicating which transactions to retrieve
 ;                  If TRANID is passed, ignore value of WHICH
 ; WHICH contains A - get all TX statuses - default
 ;                E - get all TX in error state
 ;                S - get all successfully imported TX
 ;                P - get all TXs still pending import
 ;                * - get TXs whether or not the TX was previously retrieved
 ;                    Default - get only those TXs not previously retrieved
 ;
 ;There is a hard-coded timer on this rpc call.  If the RPC has taken more
 ;one minute to run, then it will stop and return what it has retrieved up
 ;to that point.
 ;
 ;RETURN:
 ; if error(s) return -1^error message
 ; else for each tranID return a multiline data of the form
 ;  array[n] = tranID^status
 ;  array[n+j] = message from VistA Imaging where j = 1,2,3,...
 ;  array[n+m] = $END where m is 1 more than the last j
 ;  sorted by status and within status by tranID
 ;
 ;^tmp("dsivdm",$j,1,#)=ien_u_STAT [list of successful entries retrieved]
 ;^tmp("dsivdm",$j,2,#)=text [list of all errors]
 ;^tmp("dsivdm",$j,3,status,tranid,n)=tranid^status [good data]
 ;  if any warning messages or errors from VistA Imaging, then
 ;^tmp("dsivdm",$j,3,status,tranid,n+i)=text  for i=1,2,3,4,
 ;^tmp("dsivdm",$j,3,status,tranid,n+(max i)+1)=$END
 ;
 G STAT^DSIVDM01
 ;
STATUS(DSIV,TRANID,WHICH,DEL,APP) ;  RPC: DSIV DM GET STATUS
 ; 6/20/2005 - old RPC, please start using DSIV DM GET STATUS1
 N X,Y,Z,DSIVDAT
 S Z=0 F X="TRANID","WHICH","DEL","APP","OVERRIDE" D
 .S Y=$G(@X)
 .I Y="",X="TRANID"!(X="DEL") Q
 .I X="APP",Y="" S Y="DM"
 .I X="WHICH" S:Y="" Y="A*" S:Y'["*" Y=Y_"*"
 .I X="OVERRIDE" S Y=1
 .S Z=Z+1,DSIVDAT(Z)=X_U_Y
 .Q
 G STAT^DSIVDM01
 ;
UPD(DSIV,ACT,TRANID,QUEUE,APP,TIU,FUN) ; RPC: DSIV DM ADD/DELETE QUEUE
 ; This will allow you to add or delete a record from file 19621
 ; Input   Req  Description
 ; ------  ---  --------------------------------------------------------
 ; ACT      o   A:add a record; D:delete a record - default to A
 ; TRANID   ?   Req for delete, opt for add if non-DocManager application
 ;              transaction ID sent to VistA Imaging import queue
 ;              this must be a unique name
 ; APP      x   code assigned by Jay for a specific DSS application
 ; TIU      o   TIU DOCUMENT (#8925) pointer
 ; QUEUE    o   queue number return from VistA Imaging Import API
 ; add/delete a record.  Updates to existing records done by CALLBK
 ;
 ; If successful, return 1^message^transaction ID
 ; Else, return -1^error message
 ;
 D UPD^DSIVDM01 G OUT
 ;
 ;---------------  callback called from VI  --------------
CALLBK(DSIV) ;  callback routine expected by the VistA Imaging Bkgd Proc
 ;DSIV(0) = status code^message
 ;            where status code>=1 if success, else 0
 ;    (1) = tracking id
 ;    (2) = queue number
 ;(3...n) = warning messages
 G CALLBK^DSIVDM01
 ;
 ;---------------  called from DD  ---------------
DD06 ; input transform ^DD(19621,.06)
 N A,B,I,Y,Z,T,DSIV,DSIVE,DSIVX
 S DSIV=X,Y=$$GET1^DID(19621,.06,,"DESCRIPTION","DSIVX","DSIVE")
 S (B,I)=0 F  S I=$O(DSIVX(I)) Q:'I  D  Q:B=2
 .S T=DSIVX(I)
 .I 'B S:T?1" Prefix ".E B=1 Q
 .I $P(T," ",2)=DSIV S B=2
 .Q
 K X I B=2 S X=DSIV
 Q
