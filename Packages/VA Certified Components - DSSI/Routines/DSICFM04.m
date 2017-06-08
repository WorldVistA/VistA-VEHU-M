DSICFM04 ;DSS/SGM - FILEMAN FILER RPC ;11/21/2002 14:05
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  SUPPORTED
 ; -----  -----------------------------------
 ;  2053  ^DIE:  FILE, WP
 ;  2055  ^DILFD: VFIELD, VFILE
 ;
FILE(DSIC,FILE,IENS,FLAG,INPUT) ; RPC: DSIC FM FILER
 ;  this invokes the Fileman filer to update fields for an existing
 ;  entry.  This will allow you to update any field at the level of
 ;  the FILE including word processing fields.  It does not allow for
 ;  updating different levels of the file.  If you wish to update a
 ;  subfile, then you will have to make multiple calls to this RPC
 ;  for each file or subfile.
 ;
 ;  DSIC - return array where
 ;         DSIC(1) = 1^  if everything was successfully filed
 ;                 = -1^error message if any problems encountered
 ;         DSIC(2...n) = additional error messages
 ;
 ;  FILE - required - this is the file (or subfile#) which is to be
 ;                    updated
 ;  IENS - required - this is the standard Fileman DBS IENS which is
 ;                    the record# to be updated
 ;                    IENS="27," - update record# 27 in the file
 ;                    IENS="3,27," - update the 3rd record in the
 ;                         multiple indicated by the subfile# for the
 ;                         27th record in the file
 ;  FLAG - optional - only acceptable value is "T" - transaction
 ;                    processing, that is, all the fields must be
 ;                    successfully updated or none of them are
 ; INPUT - required - list where
 ;         LIST[#] = p1^p2^p3 where
 ;                   p1 - required - field #
 ;                   p2 - optional - default value I
 ;                        if p2="" then field value in internal format
 ;                             ="E" then field value in external format
 ;                             ="I" then field value in internal format
 ;                             ="W" then field is a word processing
 ;                                  see notes below
 ;                   p3 - value for field# - if value is <null> or "@"
 ;                        then that field will be deleted
 ;
 ;  NOTES on word processing fields
 ;  ===============================
 ;  if LIST[#]=field#^W^@ - delete any existing text for that record
 ;  if LIST[#]=field#^W^text - this will first remove any existing text
 ;                             for this field in this record and then add
 ;                             the new text
 ;  if LIST[#]=field#^WA^text - this will append the new text to any
 ;                              existing text which may be there
 ;  you cannot mix W and WA for any one field.  p2 must be the same
 ;  for all the LIST[#] elements.
 ;  Deletion of text, i.e. the "@" takes precedence over anything else
 ;
 N X,Y,Z,CNT,DIERR,DSI,DSIERR,DSIFDAE,DSIFDAI,DSIFDAW,DSITMP,DSIX,WP
 S CNT=1,DSITMP(1)="-1^Invalid input parameters received"
 S FILE=$G(FILE) I FILE="" D ERR(1)
 I '$$VFILE^DILFD(FILE) D ERR(2)
 S IENS=$G(IENS) I IENS="" D ERR(3)
 E  S:$E(IENS,$L(IENS))'="," IENS=IENS_","
 S FLAG=$G(FLAG) I FLAG]"" S:$E(FLAG)="t" FLAG="T" S:FLAG'="T" FLAG=""
 I $O(INPUT(""))="" D ERR(4)
 ;  create the FDA arrays
 S DSI="",WP=0
 F  S DSI=$O(INPUT(DSI)) Q:DSI=""  S DSIX=INPUT(DSI) D
 .I '$$VFIELD^DILFD(FILE,+DSIX) D ERR(5) Q
 .S Z=$P(DSIX,U,2) I $L(Z)>1 D ERR(6) Q
 .I Z]"" S Z=$TR(Z,"IEWAiewa","IEWAIEWA") I Z="" D ERR(6) Q
 .S:"I"[Z X="DSIFDAI" S:Z="E" X="DSIFDAE"
 .I Z["W" D  Q
 ..N P1,P2,P3 S P1=+DSIX,P2=$P(DSIX,U,2),P3=$P(DSIX,U,3)
 ..I $G(DSIFDAW(P1))="@" Q
 ..I P3="@" S DSIFDAW(+DSIX)="@" Q
 ..I $D(DSIFDAW("F",P1)),DSIFDAW("F",P1)'=P2 D ERR(8) Q
 ..S WP=WP+1,DSIFDAW(+DSIX,WP)=P3,DSIFDAW("F",P1)=P2
 ..Q
 .I Z="E" S DSIFDAE(FILE,IENS,+DSIX)=$P(DSIX,U,3)
 .E  S DSIFDAI(FILE,IENS,+DSIX)=$P(DSIX,U,3)
 .Q
 I '$D(DSIFDAI),'$D(DSIFDAE),'$D(DSIFDAW) D ERR(7)
 I CNT>1 M DSIC=DSITMP K DSITMP Q
 K DSITMP,DIERR,DSIERR S FLAG=FLAG_"KS"
 I $D(DSIFDAI) D FILE^DIE(FLAG,"DSIFDAI","DSIERR")
 I $D(DIERR) D EMSG G:FLAG="T" F1
 I $D(DSIFDAE) D FILE^DIE(FLAG_"E","DSIFDAE","DSIERR")
 I $D(DIERR) D EMSG G:FLAG="T" F1
 I $D(DSIFDAW) F DSIX=0:0 S DSIX=$O(DSIFDAW(DSIX)) Q:'DSIX  D
 .S X="K" S:$G(DSIFDAW("F",DSIX))["A" X="KA"
 .D WP^DIE(FILE,IENS,DSIX,X,$NA(DSIFDAW(DSIX)),"DSIERR")
 .I $D(DIERR) D EMSG K:FLAG="T" DSIFDAW
 .Q
F1 I '$D(DSITMP) S DSIC(1)="1^"
 E  M DSIC=DSITMP S DSIC(1)="-1^Problems encountered while filing data"
 Q
 ;
ERR(A) ;  builld error message prior to calling FILE^DIE
 N X S:A=1 X="No file number received"
 S:A=2 X="Invalid file number received: "_FILE
 S:A=3 X="No IENS received"
 S:A=4 X="No field values received"
 S:A=5 X="Invalid field number received: "_(+DSIX)
 S:A=6 X="Invalid field type received for field "_(+DSIX)_": "_Z
 S:A=7 X="No valid fields received"
 S:A=8 X="Received conflicting flags for WP field "_P1
 S CNT=CNT+1,DSITMP(CNT)=X
 Q
 ;
EMSG ;  if errors encountered with filing data record that data here
 N X,Y,Z,ERR
 D MSG^DSICFM01(,.ERR,,,"DSIERR")
 S X=$O(DSITMP("A"),-1) S:'X X=1
 F Y=0:0 S Y=$O(ERR(Y)) Q:Y=""  S X=X+1,DSITMP(X)=ERR(Y)
 K DIERR,DSIERR
 Q
