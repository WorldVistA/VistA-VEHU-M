DSICXPDU ;DSS/SGM - KIDS UTILITIES ;05/19/2006 22:13
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;  This routine has common apis (and RPCs) that should be called from
 ;  various DSS packages
 ;
 ; DBIA#   Supported References
 ; -----   ----------------------------------------------------
 ;  2051   $$FIND1^DIC
 ;  2171   UPDATE^XPDID
 ;  3281   Fileman read of fields .01,.02,17 in INSTALL file
 ; 10048   Fileman read of all fields in PACKAGE file
 ; 10103   $$FMTE^XLFDT
 ; 10104   $$UP^XLFSTR
 ; 10141   ^XPDUTL: BMES, MES, PATCH, PKG, VER,VERSION
 ;
INSLIST(DSIC,DSIKID,DSIALL,DSISTAT,LAST) ; RPC: DSIC GET ALL INSTALLS
 ;Return a list of INSTALL file entries sorted by Build pkg and
 ;within Build pkg sort by Installed Completed Date in inverse
 ;chronological order.
 ; DSIC(n)=<INSTALL file ifn>^<Build name>^<date installed completed>
 ;   for n=1,2,3,4,...
 ;   Note: date installed completed should only have a value for
 ;         those entries whose status is 3 [Install Completed]
 ; DISKID - req - KIDS build name or partial name
 ;   Lookup will be done on the name portion of the Build name
 ;   For new version Build names, always use name portion only
 ;   For patch Build names, use the entire Build name with "*" unless
 ;     DSIALL=1, then ony use the first "*"-piece of the Build name
 ; DSIALL - opt - Boolean flag - default=0, see DSIKID
 ; DSISTAT - opt - numbers indicating which statuses to return, 0-4
 ;                 default to 23
 ;         0:loaded  1:Queued  2:Started  3:Completed  4:De-installed
 ; LAST - opt - Boolean - only set if coming from $$LAST
 ;If no matches found, or problems, return -1^message
 ;
 N I,L,X,Y,Z,DATE,IDT,IFN,LDT,LDTE,NAME,NM,RET,ROOT,STAT
 S NAME=$$NAME(DSIKID,+$G(DSIALL)) I $P(NAME,U)=-1 S DSIC(1)=NAME Q
 S DSISTAT=$G(DSISTAT) S:DSISTAT="" DSISTAT=23
 S X=$$FIND I X<0 S DSIC(1)=X Q
 S ROOT=$NA(^TMP("DSIC",$J,"DILIST"))
 K Z S I=0 F  S I=$O(@ROOT@(I)) Q:'I  S X=^(I,0) D
 .S STAT=$P(X,U,3) Q:DSISTAT'[STAT
 .S LDT=+$P(X,U,6),IDT=-$P(X,U,4),IFN=+X
 .S DATE=$P(X,U,5)
 .S NAME=$P(X,U,2),NM=$$NAME(NAME,1) Q:NM=""
 .I DATE="",LDT S DATE=$$FMTE^XLFDT(LDT)
 .S DATE=$TR($P(DATE,":",1,2),"@"," ")
 .S Z(NM,IDT,-LDT,IFN)=IFN_U_NAME_U_$S('$G(LAST):DATE,1:-IDT)
 .Q
 S Y="Z",I=0 F  S Y=$Q(@Y) Q:Y=""  S I=I+1,DSIC(I)=@Y
 I '$D(DSIC) S DSIC(1)=$$ERR(4)
 K ^TMP("DSIC",$J)
 Q
 ;
LAST(DSIKID) ;  API to return the latest installed version of a DSS package
 ;Since there is no PACKAGE file entry, get from INSTALL file
 ; DSIKID req - name of kids package to get last install
 ; Return
 ;   On error, return -1^error message
 ;   Successfully find install, return version ^ date.time installed
 ;     where version taken from .01 field value of INSTALL entry of
 ;     the entry with the most recent INSTALL DATE.TIME (field 17)
 ;   If no matches found to DSIKID, return 0^message
 ;
 ;  Install KIDS names expected to be in the format:
 ;    name*version*patch   or   <name><space><version>
 N I,X,Y,Z,DSIC,RET
 D INSLIST(.DSIC,$G(DSIKID),,3,1)
 S RET=$G(DSIC(1)) I RET="" S RET=$$ERR(3),$P(RET,U)=0
 I +RET=-1,RET["No matches" S $P(RET,U)=0
 I +RET>0 S RET=$$VER^XPDUTL($P(RET,U,2))_U_$P(RET,U,3)
 Q RET
 ;
MES(XMES,BLANK) ;  API to send message to KIDS install to display
 ;  this one call combines both MES^XPDUTL and BMES^XPDUTL
 ;  BLANK - optional - default 0
 ;  [.]XMES - required - string (or array) to pass to KIDS
 ;            remember XMES array must be in form XMES(#)=text
 ;            and # = 1,2,3,4,....
 ;
 Q:$D(XMES)=0  N I,X,Y,Z,DSIARR
 S Z=$G(XMES),I=0
 I +$G(BLANK) S DSIARR(1)="",I=1
 I $G(XMES)'="" S I=I+1,DSIARR(I)=XMES
 S Y=0 F  S Y=$O(XMES(Y)) Q:'Y  S I=I+1,DSIARR(I)=XMES(Y)
 D MES^XPDUTL(.DSIARR)
 Q
 ;
PATCH(XRET,PKG,FUN) ;  RPC: DSIC XPD PATCH
 ;  This calls the KIDS API which will check the patch application
 ;  history multiple in the version multiple in the Package file
 ;  RETURN 1 if patch is installed, 0 otherwise
 ;  PKG - required - patch designation (e.g., LR*5.2*200)
 ;  FUN - optional - I $G(FUN) then extrinsic api, else RPC
 ;
 S XRET=$$PATCH^XPDUTL($G(PKG))
OUT Q:$G(FUN) XRET Q
 ;
PKG(X) ;  API to return pointer to PACKAGE file
 ;  X - opt - package namespace or PACKAGE file name
 ;      if $G(X)="" then return pointer for the DSIC package
 ;  return PACKAGE file pointer or 0 if not found
 ;
 N DIERR,DSIERR S:$G(X)="" X="DSIC"
 Q +$$FIND1^DIC(9.4,,"MOQ",X,"B^C",,"DSIERR")
 ;
RLAST(RET,PKG,FUN) ; RPC: DSIC XPD LAST INSTALL
 ;  see description on line label LAST
 ;  PKG - req
 ;  FUN - opt - I $G(FUN) then extrinsic api, else RPC
 N XRET S (RET,XRET)=$$LAST($G(PKG))
 G OUT
 ;
UPDSTAT(TOT,NUM,INIT) ;  API to update the KIDS status bar during KIDS
 ;  pre/post installs.  The percentage is NUM/TOT*100
 ;  TOT - req - total number of items
 ;  NUM - req - current item number
 ; INIT - opt - if INIT=1 then initialize status bar
 ;              TOT,NUM not needed to initialize
 ;
 N XPDIDTOT I '$D(XPDIDVT) N XPDIDVT S XPDIDVT=0
 I $G(INIT) S XPDIDTOT=0 D UPDATE^XPDID(0)
 Q:$G(TOT)'?1N.N  Q:$G(NUM)'?1N.N  S:NUM>TOT NUM=TOT
 S XPDIDTOT=TOT D UPDATE^XPDID(NUM)
 Q
 ;
VERSION(XRET,PKG,FUN) ;  RPC: DSIC XPD VERSION
 ;  get current version of package from PACKAGE file
 ;   PKG - req - namespace or full package name
 ;   FUN - opt - I $G(FUN) then extrinsic api, else RPC
 ;  RETURN: XRET - package version number or -1 if not found
 ;
 I $G(PKG)="" S XRET=-1
 E  S XRET=$$VERSION^XPDUTL(PKG) S:XRET="" XRET=-1
 G OUT
 ;
 ;---------------  subroutines  ---------------
ERR(A) ;
 N B
 I A=1 S B="No KIDS INSTALL name received"
 I A=2 S B="Invalid lookup value received: "_DSIKID
 I 34[A S B="No matches found for "_DSIKID
 I A=4 S B=B_" with a status codes: "_DSISTAT
 Q "-1^"_B
 ;
FIND() ; call find^dic
 ;Return 1:data returned or -1^message if none found or problems
 ;Expects Z(n) array
 ; FIND^DSICFM will put data in ^TMP("DSIC",$J,"DILIST",n,0)
 ;
 N X,Y,Z,RET
 S Z(1)="VAL^"_NAME,Z(2)="FILE^9.7",Z(3)="FLAGS^PQ",Z(4)="INDEX^B"
 S Z(5)="NUMBER^*",Z(6)="FIELDS^.01;.02I;17I;17;2I"
 D FIND^DSICFM(.RET,.Z)
 S X=$G(^TMP("DSIC",$J,"DILIST",1,0)) I +X=-1 Q X
 I X="" Q $$ERR(3)
 Q 1
 ;
NAME(X,PA) ; return name portion of Build name
 ; I 'PA then return entire patch designation, not just the name part
 N L,Y,Z
 I $G(X)="" Q $$ERR(1)
 I X["*",$G(PA) S X=$P(X,"*")
 I X'["*" D
 .S L=$L(X," "),Y=$P(X," ",L)
 .I Y?1.N.1"."1.N.E S X=$P(X," ",1,L-1)
 .Q
 I X="" S X=$$ERR(2)
 I X?.E1L.E S X=$$UP^XLFSTR(X)
 Q X
