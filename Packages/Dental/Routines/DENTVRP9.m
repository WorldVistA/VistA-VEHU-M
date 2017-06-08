DENTVRP9 ;DSS/SGM - RETURN DATA FROM HISTORY FILE ;08/12/2003 19:37
 ;;1.2;DENTAL;**30,32,34,31,38,39,43,45,47,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------------------
 ; 10035      x      Direct global read of Patient's SSN
 ; 10060      x      FM read of all fields in file 200
 ; 10103      x      $$FMADD^XLFDT
 ; 3744       x      $$TESTPAT^VADPT    
 ;
 ;  documentation for excel rpc call
 ;  RET is returned as the global reference ^TMP("DENT",$J)
 ;   SDT - optional - start date for extract [default T-180]
 ;   EDT - optional - end date for extract [default TODAY]
 ;  PROV - optional - provider ien - if present only return prov's recs
 ;   DFN - optional - patient ien - if present only return pat's recs
 ;   FLG - required - CPFO for txn type (C=compl,P=planned,F=findg,O=obs)
 ;
 ;  Format of returned global array.
 ;  Each transaction will consist of the following:
 ;  $ indicates end of individual record (or row in a spreadsheet)
 ;
 ;  all lines preceding the ending $ line consists of one record.
 ;  On the PC side, the lines should be joined together to form one
 ;  string.  This string will be delimiter with the "^"
 ;   p1 = ien to file 228.1                       p20 = DAS pat category
 ;   p2 = name of patient                         p21 = DAS bed section
 ;   p3 = SSN of patient                          p22 = DAS division
 ;   p4 = group flag (y)                          p23 = DAS disposition
 ;   p5 = date record created                     p24 = tooth # (0-32)
 ;   p6 = name of person who entered record       p25 = surfaces
 ;   p7 = name of provider                        p26 = cpt code
 ;   p8 = ien to visit file                       p27 = cpt short desc
 ;   p9 = date of encounter                       p28 = quadrants
 ;  p10 = time of encounter                       p29 = # canals
 ;  p11 = date/time of DAS entry                  p30 = primary flag (y)
 ;  p12 = location                                p31 = icd9 (primary)
 ;  p13 = service connected (y)                   p32 = ctv value
 ;  p14 = agent orange related (y)                p33 = data to PCE (y)
 ;  p15 = ionizing rad related (y)                p34 = icd9 (secondary)
 ;  p16 = env contaminant related (y)             p35 = icd9 (secondary)
 ;  p17 = military sexual trauma related (y)      p36 = icd9 (secondary)
 ;  p18 = head & neck cancer related (y)          p37 = icd9 (secondary)
 ;  p19 = primary pce diagnosis                   p38 = RVU
 ;                                                p39 = Status
 ;                                                p40 = TransactionId
 ;                                                p41 = Distributed Provider
 ;
 ;  p42,p43,p44,... - optional - secondary pce providers
 ; 
 ;The program receiving this data needs a loop:
 ;  1. Get first line
 ;  2. Get second line, if line does not equal $ then append this line
 ;     to the first line
 ;  3. Get next line, if line does not equal $ then append this line
 ;     also
 ;  4. Continue getting lines until the ending $ is read
 ;  5. You now have a spreadsheet row
 ;  6. Repeat steps 1-4 until no more data to be processed
 ;  7. User should now have a .TXT file for importing into Excel to be
 ;     parsed using the ^ as a delimiter.
 ;
EXCEL(DEN,SDT,EDT,PROV,DFN,FLG,STN) ; RPC: DENTV EXCEL EXTRACT
 ;
 N I,X,Y,Z,DATE,DENX,FLD1,FLD2,HIT,IDX,IEN,NODE,OUT,ROOT,SECPRV,STOP,STR,PROVS
 ;  initialize and validate input parameters
 S PROVS=$G(PROV),STN=$G(STN)
 I STN]"" S STN=$$FIND1^DIC(4,,"MX",STN,,,"DENERR") ;add station sort patch 43
 Q:'$$VAL  S:$G(FLG)="" FLG="C"
 ;  build first header row
 D HDR
 ;  loop on records in file 228.1 (get first of mult providers)
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  D GET Q:$G(OUT)
 ;  get other providers selected
 I $P(PROVS,U,2) S OUT=0 F I=2:1 S PROV=$P(PROVS,U,I) Q:'PROV  D
 .S ROOT=$NA(^DENT(228.1,"AG",PROV,SDT))
 .S STOP=$P(ROOT,",",1,3)_","
 .F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  D GET Q:$G(OUT)
 .Q
 ;  if secondary providers add columns to header row
 I SECPRV D
 .F I=1:1 S X=$G(@DEN@(I)) Q:"$"[X
 .S I=I-1,Z=@DEN@(I),X="SECONDARY PROVIDER^"
 .F Y=1:1:SECPRV D
 ..I $L(Z)+$L(X)<512 S Z=Z_X Q
 ..S @DEN@(I)=Z,Z=X,I=I+.1
 ..Q
 .I $L(Z) S @DEN@(I)=Z
 .Q
 Q
 ;
 ;  --------------------  subroutines  --------------------
GET ;  get data for 228.1 and all associated transactions
 N A,I,L,X,Y,Z,CPT,DATA,DATE,DENT,DENTER,DENX,DENZ,DIERR,FLD,ICD
 N IEN,IENS,SEC,VSTX,DFO
 S I=$QL(ROOT),IEN=$QS(ROOT,I),DATE=$QS(ROOT,I-1),IENS=IEN_","
 I DATE>EDT S OUT=1 Q
 D GETS^DIQ(228.1,IENS,STR(11),"EI","DENT","DENTER")
 Q:$D(DIERR)  M DENZ=DENT(228.1,IENS) K DENT
 I STN,$G(DENZ(.18,"I"))'=STN Q  ;not selected station
 I $$TESTPAT^VADPT(+DENZ(.02,"I")) Q  ;test pt, don't extract P47
 ;
 ;  set up data(1-37) which will be used to construct return string
 F I=1:1:41 S DATA(I)=""
 S A=$L(STR(1),U)
 F I=1:1:A S FLD=$P(STR(1),U,I) S:FLD DATA(I)=DENZ(FLD,"E")
 S DATA(41)=$G(DENZ(.08,"E"))
 ;
 ;  get SSN
 S X=$P($G(^DPT(+DENZ(.02,"I"),0)),U,9),DATA(3)=X
 ;
 ;  get visit data
 S SEC="",X=DENZ(.05,"I") I X D  K @VSTX
 .D VSTALL^DSICPX2(.VSTX,X) Q:@VSTX@(1)<1  S X=@VSTX@(1)
 .;  set ENC DATE^ENC TIME
 .S Y=$P(X,U,2),DATA(9)=$P(Y,"@"),DATA(10)=$P(Y,"@",2)
 .;  set PRIM PCE
 .S DATA(19)=$P(X,U,4)
 .;  set SC^AO^IR^EC^MST^HNC
 .F I=7:1:12 S DATA(I+6)=$P(X,U,I)
 .;  set secondary provider if any
 .F I=2:1 Q:'$D(@VSTX@(I))  S X=@VSTX@(I),SEC=SEC_$P(X,U,2)_U
 .Q
 ;
 ;  if no visit then set encounter date to date record created
 I DATA(9)="" S Y=DENZ(.03,"E") S:Y="" DATA(9)=$P(Y,"@"),DATA(10)=$P(Y,"@",2)
 ;
 ;  loop on transactions "AG" index, if 1 then marked as deleted
 ;
 S IENS=0 F  S IENS=$O(^DENT(228.2,"AG",IEN,IENS)) Q:'IENS  D:'^(IENS)
 .K A,I,X,Y,Z,DENT,DENTER,DENZ,DIERR,DFO
 .I $$GET1^DIQ(228.2,IENS_",",.29,"I")>1 Q  ;don't send Perio, PSR, HNC
 .D GETS^DIQ(228.2,IENS_",",STR(12),"EI","DENT","DENTER")
 .Q:$D(DIERR)  K DENZ M DENZ=DENT(228.2,IENS_",") K DENT
 .S X=$$GET1^DIQ(228.2,IENS_",",.09,"I")
 .S Y=$$GET1^DIQ(228.2,IENS_",",.22,"I")
 .I X=23,Y>1 Q  ;P45 only get the first tooth for partials.
 .;  following code is for code set versioning aware coding
 .;  get cpt code
 .S DFO=0
 .I DENZ(.05,"E")="Diagnostic Finding" S DFO=1 ;set flag for findings to NOT QUIT below!
 .I DENZ(.05,"E")="Observe" S DFO=2 ;set flag for Obs to NOT QUIT below!
 .S X=DENZ(.04,"I") Q:'X&'DFO  D  ;quit for connbar/bridge placeholder txns (no ADA code)
 ..S Y=$$CPT^DSICCPT(,X,DATE,,,1)
 ..S DENZ(.04,"E")=$S(Y>0:$P(Y,U,2),1:"")
 ..Q
 .;
 .;  get icd9 codes
 .F Z=1.06,1.07,1.08,1.09,1.1 S X=DENZ(Z,"I") I X D
 ..S Y=$$ICD9^DSICDRG(,X,,DATE,,1)
 ..S DENZ(Z,"E")=$S(Y>0:$P(Y,U,2),1:"")
 ..Q
 .;
 .;  set tooth to null if quadrant present
 .I DENZ(1.8,"E")'="" S DENZ(.15,"I")="",DENZ(.15,"E")=""
 .;  set tooth to null if not tooth related 6.10.05 P45
 .I 'DFO,'$E($P($G(^DENT(228.2,IENS,1.2)),U,2)) S DENZ(.15,"I")="",DENZ(.15,"E")="" ;P55 keep tooth# for findings/obs
 .I DENZ(.05,"E")="Diagnostic Finding" D  ;P55 add condition for findings
 ..S X=$E($$GET1^DIQ(228.2,IENS_",",.09),4,99) S:X="Decayed" X="Caries"
 ..S DENZ(.05,"E")=DENZ(.05,"E")_"-"_X
 ..Q
 .;  get the status field
 .S DENZ(.12,"E")=$E($P($G(^DENT(228.3,+$G(DENZ(.12,"I")),0)),U),3,99)
 .I FLG'[$E(DENZ(.12,"E")) Q  ;only selected statuses
 .I DFO=2&(FLG'["O") Q  ;this is Observe txn and Observe is not selected so QUIT
 .S A=$L(STR(2),U) F I=1:1:A S Y=$P(STR(2),U,I) I Y D
 ..S X=DENZ(Y,"E") I X["@" S X=$P($TR(X,"@"," "),":",1,2)
 ..S DATA(I)=X
 ..Q
 .K DENZ S A=41
 .I SEC'="" F I=1:1 S X=$P(SEC,U,I) Q:X=""  S A=A+1,DATA(A)=X
 .;  now construct return string
 .S DENX="" F I=1:1:A S X=DATA(I) D
 ..S Z=$L(DENX)+$L(X)+1 D:Z>510 SET S DENX=DENX_X_U
 ..Q
 .D:U'[DENX SET S DENX="$" D SET
 .;
 .;  number of secondary providers for column headers
 .Q
 Q
 ;
HDR ;  build first row column header
 N A,I,X,Y,Z,DATA,DENER,DENI,DENX,DIERR,FLD
 F I=1:1:41 S DATA(I)=""
 S A=$L(STR(1),U) F DENI=1:1:A S FLD=$P(STR(1),U,DENI) D:FLD
 .S X=$$GET1^DID(228.1,FLD,,"LABEL",,"DENTER")
 .S:X'="" DATA(DENI)=$S($E(X,1,4)="DAS ":$E(X,5,99),1:X)
 .Q
 S A=$L(STR(2),U) F DENI=1:1:A S FLD=$P(STR(2),U,DENI) D:FLD
 .S X=$$GET1^DID(228.2,FLD,,"LABEL",,"DENTER")
 .S:X'="" DATA(DENI)=X
 .Q
 S A=$L(STR(3),U) F I=1:1:A S X=$P(STR(3),U,I) S:X'="" DATA(I)=X
 S DENX="" F I=1:1:41 S X=DATA(I) D
 .S Z=$L(DENX)+$L(X)+1 D:Z>510 SET S DENX=DENX_X_U
 .Q
 D:U'[DENX SET S DENX="$" D SET
 Q
 ;
SET S NODE=NODE+1,@DEN@(NODE)=DENX,DENX="" Q
 ;
VAL() ;  validate input params
 ;;.01^.02^^.09^.03^.04^.07^.05^^^.06^.11^^^^^^^^.13^.14^.15^.16^^^^^^^^^^.19^.18^^^^^^^.08^
 ;;.15^.16^.04^.05^1.8^1.17^.18^1.06^1.11^^1.07^1.08^1.09^1.1^1.12^.12^.01^
 ;;^^SSN^^^^^^ENC DATE^ENC TIME^^^SC^AO^IR^EC^MST^HNC^PRIM PCE
 N I,X,Y,Z,ERR
 S SDT=$G(SDT),EDT=$G(EDT),PROV=$G(PROV),DFN=$G(DFN)
 S (HIT,NODE,OUT,SECPRV)=0
 S DEN=$NA(^TMP("DENT",$J)) K @DEN,ROOT
 I 'SDT S SDT=$$FMADD^XLFDT(DT,-999)
 S X=$$DATE^DSICUTL(.SDT,.EDT) I +X=-1 S ERR=$P(X,U,2)_"; "
 I DFN'="" S X=$$DFN^DENTVRF0(DFN) I X<1 S ERR=$G(ERR)_$P(X,U,2)_"; "
 I PROVS F I=1:1 S PROV=$P(PROVS,U,I) Q:PROV=""  D
 .I '$D(^VA(200,PROV,0)) S ERR=$G(ERR)_"Invalid provider received"
 .Q
 I PROVS S PROV=+PROVS
 I DFN S ROOT=$NA(^DENT(228.1,"AE",DFN,SDT)),Y=3
 I 'DFN,PROV S ROOT=$NA(^DENT(228.1,"AG",PROV,SDT)),Y=3
 I '$D(ROOT) S ROOT=$NA(^DENT(228.1,"AF",SDT)),Y=2
 S STOP=$P(ROOT,",",1,Y)_","
 F I=1:1:3 S STR(I)=$P($T(VAL+I),";",3)
 S X=STR(2),STR(2)="",$P(STR(2),U,24)=X
 S X=STR(1),Y="" F I=1:1:$L(X,U) S Z=$P(X,U,I) S:Z Y=Y_Z_";"
 S STR(11)=Y,X=STR(2),Y=""
 F I=1:1:$L(X,U) S Z=$P(X,U,I) S:Z Y=Y_Z_";"
 S STR(12)=Y
 I $G(ERR)'="" S DENX="-1^"_ERR D SET
 Q $G(ERR)=""
