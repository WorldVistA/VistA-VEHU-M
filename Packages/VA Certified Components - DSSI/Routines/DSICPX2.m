DSICPX2 ;DSS/SGM - VISIT TRACKING RPC CALLS ;07/21/2003 11:54
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  This routine supports calls to the VSIT package.  These can be
 ;  called as RPCs or extrinsic functions
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ------------------------------------
 ;  1894  Cont Sub   ENCEVENT^PXAPI
 ;  2056      x      $$GET1^DIQ
 ;  3065      x      $$NAMEFMT^XLFNAME
 ; 10060      x      All fields in file 200 allow FM read
 ; 10103      x      $$FMTE^XLFDT
 ;
VSTALL(DSIC,IEN,FUN) ; RPC: DSIC PX GET VISIT INFO
 ;  get all related data for visit = ien
 ;  This API was developed to extract all encounter data for a single
 ;  encounter.  The data represents elements that are stored in the
 ;  Visit file (9000010) and other PCE files.
 ;
 ;  IEN - required - pointer to 9000010
 ;  If $G(FUN) then from M routine - return all data as returned
 ;   by ENCEVENT^PXKENC.  It returns the global internal file structure
 ;   for each entry.  Thus it presumes you are familiar with the
 ;   corresponding DDs.  See example at bottom of routine.
 ;   Also this is an extrinsic function call which returns 1 if
 ;   successful, otherwise -1^error message
 ;
 ;   PLEASE NOTE: if called from a M routine it is the responsibility
 ;   of the calling M routine to K @DSIC.  DSIC=$NA(^TMP("DSIC",$J))
 ;
 ;  If '$G(FUN) return a subset of this info mostly in external format
 ;     @DSIC@(1)=p1^p2^p3^...^p12 where
 ;       p1 = fm visit date.time
 ;       p2 = external visit date.time
 ;       p3 = primary PCE diagnosis short description
 ;       p4 = primary PCE diagnosis code
 ;       p5 = primary PCE provider duz
 ;       p6 = primary PCE provider name (1st m last)
 ;       p7 = service connected (y)
 ;       p8 = agent orange (y)
 ;       p9 = ionizing radiation (y)
 ;      p10 = Persian Gulf exposure (y)
 ;      p11 = military sexual trauma (y)
 ;      p12 = head & neck cancer (y)
 ;     @DSIC@(n)=secondary provider duz^sec prov name (1st m last)
 ;       where n=2,3,4,5,...  for each secondary provider
 ;
 N I,X,Y,Z,RET,VST
 S DSIC=$NA(^TMP("DSIC",$J))
 K ^TMP("PXKENC",$J),@DSIC
 S IEN=$G(IEN)
 I 'IEN S RET="-1^No Visit ien received" G VOUT
 D ENCEVENT^PXAPI(IEN) I '$D(^TMP("PXKENC",$J,IEN)) G VOUT
 ;  check if API
 I $G(FUN) M @DSIC=^TMP("PXKENC",$J,IEN) S RET=1 G OUT
 ;  return RPC data
 S VST=$$VST
 I VST S RET(1)=VST_U_$$FMTE^XLFDT(VST)
 S X=$TR($P($G(^TMP("PXKENC",$J,IEN,"VST",IEN,800)),U,1,6),1,"y")
 S $P(RET(1),U,7)=X ; sc,ao,ir,ec,mst,hnc
 ;  get primary diag
 S X=$$V1 I X'="" S $P(RET(1),U,3)=$P(X,U,3),$P(RET(1),U,4)=$P(X,U,2)
 S (I,X)=0
 ;  get providers
 S X=$$V2 I X'="" D
 .S $P(RET(1),U,5)=$P(X,";"),$P(RET(1),U,6)=$P($P(X,U),";",2)
 .F I=2:1:$L(X,U) S Y=$TR($P(X,U,I),";",U),RET(I)=Y
 .Q
VOUT I +$G(RET)=-1 S @DSIC@(1)=RET
 I $D(RET),$G(RET)="" M @DSIC=RET K RET S RET=1
 I '$D(RET) S RET=$$ERR,@DSIC@(1)=RET
OUT K ^TMP("PXKENC",$J)
 Q:$G(FUN) RET Q
 ;
ERR() Q "-1^Unexpected problem encounterd"
 ;
PCE(DSIC,IEN,FUN) ;  RPC: DSIC PX PRIMARY
 ;  return pce primary diagnosis and pce primary provider
 ;  IEN - required - pointer to VISIT file
 ;  FUN - optional - if $G(FUN) then extrinsic function, else RPC
 ;  Return -1^error message if problems or none found
 ;  If $G(FUN) return:
 ;     icd9 ien^diag code^diag short desc^prov duz^prov name
 ;  If RPC return:
 ;     diag short desc^diag code^prov duz^prov name
 ;
 N I,X,Y,Z,RET,VST
 K ^TMP("PXKENC",$J)
 S IEN=$G(IEN) I 'IEN S (DSIC,RET)="-1^No Visit ien received" G OUT
 D ENCEVENT^PXAPI(IEN)
 I '$D(^TMP("PXKENC",$J,IEN)) S (DSIC,RET)=$$ERR G OUT
 S VST=$$VST,RET=$$V1,$P(RET,U,4)=$TR($$V2(1),";",U)
 I '$G(FUN) S X=$P(RET,U,3)_U_$P(RET,U,2)_U_$P(RET,U,4,5),RET=X
 S DSIC=RET
 G OUT
 ;
 ;  --------------------  subroutines  --------------------
V1() ;  expects ^TMP("PXKENC",$J), VST = visit date (fm)
 ;  return primary icd9 data - icd9 ien ^ code ^ short desc or <null>
 N X,Y,Z,DSI S X=0
 F  S X=$O(^TMP("PXKENC",$J,IEN,"POV",X)) Q:'X  S Z=^(X,0) D  Q:$D(DSI)
 .Q:$P(Z,U,12)'="P"  S Y=$$ICD9^DSICDRG(,+Z,,VST\1,,1)
 .I Y>0 S DSI=$P(Y,U,1,2)_U_$P(Y,U,4)
 .Q
 Q $G(DSI)
 ;
V2(PRI) ;  expects ^TMP("PXKENC",$J)
 ;  PRI - optional - if $G(P) then only return primary provider
 ;  return <null> or p1^p2^p3^p4^...  where
 ;    pn = provider duz;provider name
 ;    p1 = visit primary pce provider
 ;    p2,p3,p4,... secondary pce providers
 ;  provider names in format FIRST M LAST
 N I,X,Y,Z,DIERR,DSI,DSIERR,PROV
 S PRI=$G(PRI),X=0,DSI=U
 F  S X=$O(^TMP("PXKENC",$J,IEN,"PRV",X)) Q:X=""  S PROV=+^(X,0) D
 .K DIERR,DSIERR S Z=$$GET1^DIQ(200,PROV_",",.01,,,"DSIERR") Q:Z=""
 .S Z=PROV_";"_$$NAMEFMT^XLFNAME(Z,,"MD")
 .I $P(PROV,U,4)="P" S $P(DSI,U)=Z ;  primary pce provider
 .E  S DSI=DSI_Z_U
 .Q
 S DSI=$P(DSI,U,$L(DSI,U)-1) S:PRI DSI=$P(DSI,U)
 Q DSI
 ;
VST() Q $P($G(^TMP("PXKENC",$J,IEN,"VST",IEN,0)),U) ;  visit date.time
 ;
 ;  ----------  Documentation from Forum DBA IA# 1894 ----------
 ;  as of 4/23/2003
 ;The data is stored in a ^TMP global array with subscripts denoting the 
 ;category of returned data.  The data returned in @DSIC@() represents 
 ;data from one encounter.  Format of returned structure:
 ;  @DSIC@(subscript1 , subscript2, subscript3)=DATA  where:
 ;    subscript1 = v file string
 ;                 code representing the V file data category:
 ;                 "CPT"   = V CPT (procedure)     #9000010.18
 ;                 "HF"    = V Health Factors      #9000010.23
 ;                 "IMM"   = V Immunization        #9000010.11
 ;                 "PED"   = V Patient Ed          #9000010.16
 ;                 "POV"   = V POV (diagnosis)     #9000010.07
 ;                 "PRV"   = V Provider            #9000010.06
 ;                 "SK"    = V Skin Test           #9000010.12
 ;                 "TRT"   = V Treatment           #9000010.15
 ;                 "VST"   = Visit file            #9000010
 ;                 "XAM"   = V Exam                #9000010.13
 ;                 "CSTP"  = Visit file            #9000010
 ;                           This subscript contains child visits
 ;                           used to store additional Stop Codes.
 ;
 ;    subscript2 = v file ien 
 ;                 Internal entry number of the entry in the file
 ;                 represented in subscript1
 ;
 ;    subscript3 = dd-subscript
 ;                 Subscript or DD node on which the data is stored.
 ;                 Every DD node is published whether or not there is
 ;                 ny data for that node. e.g. 0, 12, and 811
 ;
 ;    Data:
 ;    The DATA that exists to the right of the global node is a
 ;    reflection of data as it appears in the global node of the IEN
 ;    of the file (subscript1) and the NODE of that IEN (subscript3)
 ;
 ;    Data Capture of Example output:
 ;    Included below is a capture of  the ^TMP("PXKENC" global.
 ;    @DSIC@("CPT",135,0) = 34510^1030^78^176^^^^^^^^^^^^1
 ;          ("CPT",135,1,0) = ^^1^1
 ;          ("CPT",135,1,1,0) = 16
 ;          ("CPT",135,12) = ^^^108
 ;          ("CPT",135,802) =
 ;          ("CPT",135,811) =
 ;          ("POV",96,0) = 9054^1030^78^177^^^^^^^^S
 ;          ("POV",96,12) = ^^^108
 ;          ("POV",96,800) = 0
