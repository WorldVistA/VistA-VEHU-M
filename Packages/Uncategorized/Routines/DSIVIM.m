DSIVIM ;DSS/KC - Save Ins Data to Audit File ;05/21/2012
 ;;2.2;INSURANCE CAPTURE BUFFER;**7**;May 19, 2009;Build 1
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; Integration Agreements
 ;  2053  FILE^DIE, UPDATE^DIE, WP^DIE
 Q
IN(RET,DSIVAUD,DATA) ;RPC: DSIV FILE INSURANCE TO AUDIT
 ;DSIVAUD=ien to file 19625
 ;DATA(n)=field^multi-id^value
 ;e.g. DATA(1)="6.01^0^1"
 ;     DATA(2)="6.02^0^2"
 ;     DATA(3)="8^1^SYN1"   SYNONYM is field 8, subfile 19625.08 (multiple)
 ;     DATA(4)="8^2^SYN2"
 ;     DATA(5)="9^1^FIRST LINE OF REMARKS"  REMARKS is field 9, word processing
 ;     DATA(6)="9^2^SECOND LINE OF REMARKS"
 ;RET(n) will exist based on what data is sent, if only 6.01-6.09 is sent then only RET(1) is returned
 ;RET(1)=-1^error or 0^Record updated for fields 6.01-6.09 (NOT 6.08)
 ;RET(2)=-1^error or 0^Synonym(s) updated
 ;RET(3)=-1^error or 0^Remarks updated
 I '$D(^DSI(19625,$G(DSIVAUD))) S RET(1)="-1^Audit Entry does not exist" Q
 N I,D,DSIVD,DSIVDS,DSIVDW,CNTS,CNTW,DSIVERR,DSIVERRS,DSIVERRW
 S (I,CNTS,CNTW)=0 F  S I=$O(DATA(I)) Q:'I  S D=DATA(I) D
 .I $P(D,U,2)=0 S DSIVD(19625,DSIVAUD_",",$P(D,U))=$P(D,U,3),RET(1)="" Q
 .I +D=8 S CNTS=CNTS+1,DSIVDS(19625.08,"+"_CNTS_","_DSIVAUD_",",.01)=$P(D,U,3),RET(2)="" Q
 .S CNTW=CNTW+1,DSIVDW(CNTW)=$P(D,U,3),RET(3)=""
 .Q
 L +^DSI(19625,DSIVAUD):2 E  S RET(1)="-1^Unable to lock the record - NO UPDATES" Q
 I $D(DSIVD) D FILE^DIE(,"DSIVD","DSIVERR")
 I $D(DSIVERR) S RET(1)="-1^"_$G(DSIVERR("DIERR",1,"TEXT",1))
 I $D(DSIVDS) K ^DSI(19625,DSIVAUD,8) D UPDATE^DIE(,"DSIVDS",,"DSIVERRS")
 I $D(DSIVERRS) S RET(2)="-1^"_$G(DSIVERRS("DIERR",1,"TEXT",1))
 I $D(DSIVDW) K ^DSI(19625,DSIVAUD,9) D WP^DIE(19625,DSIVAUD_",",9,,"DSIVDW","DSIVERRW")
 I $D(DSIVERRW) S RET(3)="-1^"_$G(DSIVERRW("DIERR",1,"TEXT",1))
 L -^DSI(19625,DSIVAUD)
 I $D(RET(1)),$G(RET(1))="" S RET(1)="0^Record updated"
 I $D(RET(2)),$G(RET(2))="" S RET(2)="0^Synonym(s) updated"
 I $D(RET(3)),$G(RET(3))="" S RET(3)="0^Remarks updated"
 Q
