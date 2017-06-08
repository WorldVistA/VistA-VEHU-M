DENTVRH ;DSS/SGM - RPCs To Return Dental History ;01/21/2004 21:43
 ;;1.2;DENTAL;**31,37,38,39,45,47**;Aug 10, 2001
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine contains those RPCs that return data to the GUI
 ;  from files 228.1, 228.2
 ;  Replaced DENTVRP8
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  --------------------------------------------------
 ;  2056      x      ^DIQ: $$GET1, GETS
 ;  3512  Cont Sub   Direct global read of #9000010, flds .01;.05;15002
 ; 10103      x      $$FMTE^XLFDT
 ; 10104      x      $$UP^XLFSTR
 ;
ENC(DENTV,IEN) ;  RPC: DENTV DENT HISTORY ENC
 ;  this returns all data associated with a dental encounter (#228.1)
 ;  IEN - required - ien to file 228.1
 ;  Return List: - all return values in external format unless indicated
 ;  List[1] = p1^p2^...^p15              List[2] = p1^p2^p3^p4^p5
 ;    p1 = Date Created                    p1 = DAS date
 ;    p2 = Creator                         p2 = DAS Patient Category
 ;    p3 = Provider                        p3 = DAS Bed Section
 ;    p4 = Visit date.time                 p4 = DAS Division
 ;    p5 = Location                        p5 = DAS Disposition
 ;    p6 = primary pce ICD9 description
 ;    p7 = primary pce ICD9 code
 ;    p8 = primary PCE provider duz
 ;    p9 = primary pce provider name
 ;    10-15 = Service Connected conditions
 ;             SC^AO^IR^EC^MST^HNC  
 ;
 N I,X,Y,Z,DENER,DENT,DIERR,FROM,TMP,TO,VST
 I $D(^DENT(228.1,+$G(IEN),0)) S IEN=IEN_","
 E  S DENTV(1)="-1^Invalid record number '"_IEN_"'" Q
 D GETS^DIQ(228.1,IEN,".01:.16","IE","DENT","DENER")
 I $D(DENER) S DENTV(1)="-1^"_$$MSG^DSICFM01("VE",,,,"DENER") Q
 M TMP=DENT(228.1,IEN) K DENT
 S FROM=".03^.04^.07^.05^.11"
 F TO=1:1:5 S $P(DENTV(1),U,TO)=$G(TMP($P(FROM,U,TO),"E"))
 S FROM=".06^.13^.14^.15^.16"
 F TO=1:1:5 S $P(DENTV(2),U,TO)=$G(TMP($P(FROM,U,TO),"E"))
 S X=$G(TMP(.05,"I")) K TMP D VSTALL^DSICPX2(.TMP,X)
 S X=$G(@TMP@(1))
 I X>0 S Y="3^4^5^6^7^8^9^10^11^12" D
 .F I=1:1:10 S TO=I+5,FROM=$P(Y,U,I),$P(DENTV(1),U,TO)=$P(X,U,FROM)
 .Q
 K @TMP
 Q
 ;
TH(DENT,DATA) ;  RPC: DENTV TOOTH HISTORY
 ;  return tooth history
 ;  DATA - required - dfn ^ tooth# ^ fmdate
 ;  Return global array:
 ;  returned data will be sorted by tooth number and descending date
 ;  within tooth number
 ;  ^TMP("DENT",$J,tooth number,negative date,ien)  =p1^p2^...^p13^p14
 ;    where ien = ien to file 228.2
 ;     p1 = tooth # (0-32)          p10 = pce primary icd9 short desc
 ;     p2 = record date             p11 = pce primary icd9 code
 ;     p3 = cpt short description   p12 = ien file 228.1
 ;     p4 = cpt code                p13 = visit date
 ;     p5 = provider's name         p14 = ctv value
 ;     p6 = surfaces                p15 = boolean flag indicating
 ;     p7 = quadrant                      current episode of care (1/0)
 ;     p8 = # canals                p16 = distributed provider *P47
 ;     p9 = primary (YES/null)
 ;
 ;  Any associated diagnoses for the procedure, then
 ;  ^TMP("DENT",$J,tooth number, negative date,ien,0)=$p1^p2^...^p10
 ;    where p1,p2 = primary dental diagnoses
 ;          p3,p4  p5,p6  p7,p8  p9,p10 are any secodary dental diagnoses  
 ;    with each pair of diagnosis codes,
 ;    the first value is the icd9 short description
 ;       second value is the icd9 diagnosis code
 ;
 ;  Notes on local variable names
 ;  QSTOP - stop FOR loop for getting records
 ;   ASCR - screen for specific records
 ;   STOP - additional stop of FOR loop
 ;   ROOT - $Query variable
 N I,X,Y,Z,DATE,DATEX,DENIEN,DFN,IEN,IEN1,PATCH,QSTOP,ROOT,STOP,TOOTH,CUR,NOC
 S DENT=$NA(^TMP("DENT",$J)) K @DENT,^TMP("DENTV",$J)
 F I=1:1:3 S @$P("DFN^TOOTH^DATEX",U,I)=$P(DATA,U,I)
 S X=$$GET^DSICDPT1(DFN) I X<1 S @DENT@(1)=X G OUT
 S X="-1^Patient has no dental history on file"
 I '$D(^DENT(228.1,"C",DFN)) S @DENT@(1)=X G OUT
 S:'DATEX DATEX=1 S DATEX=DATEX-.000001
 I TOOTH?.E1L.E S TOOTH=$$UP^XLFSTR(TOOTH)
 S CUR=$$CUR,PATCH=$$PATCH
 S ROOT=$NA(^DENT(228.1,"AE",DFN,DATEX))
 S QSTOP=$P(ROOT,",",1,3)_","
 F  S ROOT=$Q(@ROOT) Q:ROOT'[QSTOP  Q:$QS(ROOT,4)>(DT+.25)  D
 .S DATE=$QS(ROOT,4),IEN=$QS(ROOT,5)
 .Q:$D(^TMP("DENTV",$J,IEN))  ;   record data already retrieved
 .S ^TMP("DENTV",$J,IEN)="" ;     track records already retrieved
 .S STUB=$$STUB
 .S IEN1=0 F  S IEN1=$O(^DENT(228.2,"AG",IEN,IEN1)) Q:'IEN1  D:'^(IEN1)
 ..N DATA,DENTER,DENTX,DIERR,FLDS
 ..S FLDS=".03;.04;.06;.12;.13;.15;.16;.18;1.03;1.06:1.11;1.17;1.8;1.202;.29;.22;.09"
 ..D GETS^DIQ(228.2,IEN1_",",FLDS,"EI","DENTX","DENTER") Q:'$D(DENTX)
 ..M DATA=DENTX(228.2,IEN1_",") K DENTX
 ..I (DATA(.29,"I")=2)!(DATA(.29,"I")=3)!(DATA(.29,"I")=4) Q  ;only TXN items (not perio/psr/hnc)
 ..I $G(DATA(.06,"I")),DATA(.12,"I")'=104 Q  ;only include completed TP items
 ..I $G(DATA(.06,"I")),DATA(1.03,"I") Q  ;don't include deleted TP items
 ..I $G(DATA(.06,"I")),$G(DATA(.09,"I"))=23,$G(DATA(.22,"I"))>1 Q  ;only get the first tooth for partials P45
 ..S X=DATA(.15,"I") I $S(TOOTH="ALL":1,TOOTH>0:X=TOOTH,1:0[X) D GET
 ..Q
 .Q
 I '$D(@DENT) S @DENT@(1)="-1^No dental records found"
OUT K ^TMP("DENTV",$J)
 Q
 ;  -------------------  subroutines  --------------------
CKIEN(IEN) ;  check that ien is valid
 ;  return 1 if valid and converted, else return -1^message
 N X,Y S IEN=$G(IEN)
 I '$D(^DENT(228.1,+IEN,0))!'IEN Q "-1^Invalid record number '"_IEN_"'"
 Q 1
 ;
CUR() ;  get the last date which has a status of complete or terminated
 N X,Z,QUIT S X=0,QUIT=0,NOC=0
 S Z="A" F  S Z=$O(^DENT(228.1,"C",DFN,Z),-1) Q:'Z!QUIT  D
 .I $P($G(^DENT(228.1,Z,0)),U,16)>1 S X=Z,QUIT=1
 .Q
 I 'X S X=$O(^DENT(228.1,"C",DFN,0)),NOC=1 ;NO Complete/term txns flag
 Q $P($G(^DENT(228.1,X,0)),U,3)
 ;
FIRST() ; get the first date which has a status of completed or terminated before the next in progress encounter
 ; (for records where there are multiple completes/terms in a row)
 N X,Z,QUIT S X=0,QUIT=0
 S Z="A" F  S Z=$O(^DENT(228.1,"C",DFN,Z),-1) Q:'Z!QUIT  D
 .I $P($G(^DENT(228.1,Z,0)),U,16)>1 S X=Z Q
 .I $P($G(^DENT(228.1,Z,0)),U,16)=1 S:X QUIT=1
 .Q
 I 'X S X=$O(^DENT(228.1,"C",DFN,0))
 Q $P($G(^DENT(228.1,X,0)),U,3)
 ;
ICD(X,DATE) N Z S Z=$$ICD9^DSICDRG(,X,,DATE,,1)
 Q $S(Z<1:"",1:$P(Z,U,4)_U_$P(Z,U,2))
 ;
GET ;  get data from file 228.2
 ;  data() defined from above
 N I,X,Y,Z,CODE,DEN,DENX,FROM,TO,TOOTH
 S DENX=STUB
 ;  get visit ptr, pce prim diag
 ;  reset tooth number to zero if quad present
 S TOOTH=+$G(DATA(.15,"I"))
 I $G(DATA(1.8,"E"))'="" S TOOTH=0,DATA(.15,"I")=0,DATA(.15,"E")=0
 I $G(DATA(.06,"I")),+$G(DATA(1.202,"E"))=0 S TOOTH=0,DATA(.15,"I")=0,DATA(.15,"E")=0
 ;  tooth^provider^surf^quad^canals^ctv
 S FROM=".15^.03^.16^1.8^1.17^.18^1.11",TO="1^5^6^7^8^9^14"
 F X=1:1:7 S $P(DENX,U,$P(TO,U,X))=$G(DATA($P(FROM,U,X),"E"))
 I 'DENX S $P(DENX,U)=0
 I $G(DATA(.18,"I"))=1 S $P(DENX,U,9)="YES" ; is juvenile
 ;  get code set versioning compliant cpt data
 S Y=$G(DATA(.13,"I")) ; transaction date
 S CODE=$G(DATA(.04,"E")) ; cpt code
 S X=$$CPT^DSICCPT(,CODE,Y,,,1) S:X<1 X=""
 S $P(DENX,U,3)=$P(X,U,3),$P(DENX,U,4)=$P(X,U,2)
 S @DENT@(TOOTH,-DATE,-IEN1)=DENX,DENX="$"
 ;  now get dental diagnosis data code set versioning compliant
 ;  check first to see if px*1.0*124 has data
 ;  ^TMP("DSIC",$J) defined in STUB module
 I PATCH D  K ^TMP("DSIC",$J)
 .F DEN=0:0 S DEN=$O(^TMP("DSIC",$J,"CPT",DEN)) Q:'DEN  S X=^(DEN,0) D
 ..F I=5,9,10,11 S Z=$P(X,U,I) I Z>0 S Z=$$ICD(Z,Y) S:Z>0 DENX=DENX_Z_U
 ..Q
 .Q
 E  I DENX="$" F DEN=1.06:.01:1.09 S CODE=$G(DATA(DEN,"E")) D:CODE'=""
 .S X=$$ICD(CODE,Y) S:X>0 DENX=DENX_X_U
 .Q
 I DENX'="$" S @DENT@(TOOTH,-DATE,-IEN1,0)=DENX
 Q
 ;
PATCH() Q $$PATCH^DSICXPDU(,"PX*1.0*124",1)
 ;
STUB() ;  create stub return value for an encounter
 ;  expects IEN = pointer to 228.1
 N I,X,Y,Z,DENTER,DSIC,STUB,VSTIEN
 S X=$G(^DENT(228.1,+IEN,0)) I X="" Q U
 S Y=$P(X,U,3) S:Y $P(STUB,U,2)=$$FMTE^XLFDT(Y)
 S $P(STUB,U,12)=IEN,VSTIEN=$P(X,U,5) ;  pointer 9000010
 I NOC,$P(X,U,3)'<CUR S $P(STUB,U,15)=1 ;if no completes, get inclusive current list
 I 'NOC,$P(X,U,3)>CUR S $P(STUB,U,15)=1 ;if completes, get non-inclusive list
 I 'VSTIEN Q STUB
 S Y=$$GET1^DIQ(9000010,VSTIEN_",",.01,,,"DENTER")
 S $P(STUB,U,13)=Y
 S $P(STUB,U,16)=$$GET1^DIQ(228.1,+IEN,.08)
 ;  px*1.0*124 will defined linked diagnoses in vcpt file
 ;  dsicpx2 S DSIC=$NA(^TMP("DSIC",$J)) and Kills it on entry
 D VSTALL^DSICPX2(.DSIC,VSTIEN)
 S Z=0
 F  S X=$O(@DSIC@("POV",X)) Q:'X  I $P(^(X,0),U,12)="P" S Z=+^(0) Q
 I Z S Y=$$ICD(+Z,Y\1) S:Y'="" $P(STUB,U,10,11)=Y
 Q STUB
