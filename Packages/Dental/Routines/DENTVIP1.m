DENTVIP1 ;DSS/SGM - PRE/POST FILE 228 ;02/10/2004 18:09
 ;;1.2;DENTAL;**33,34,35,36,39,45,53,56,57**;Aug 10, 2001;Build 8
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;  DBIA#  SUPPORTED
 ;  -----  ---------  --------------------------------------
 ;                    ^XTMP - SACC allowed
 ;   2053      x      FILE^DIE
 ;   2172      x      UPDATE^XPDID
 ;  10013      x      IX1^DIK
 ;  10103      x      XLFDT:  $$FMADD, $$NOW
 ;
 ;  Following tags called from either pre or post install routines
 ;
 ;  This routine should only be invoked when exporting file 228
 ;
 ;  local variables expect to exist
 ;  XPDNM - from KIDS install process
 ;
SAVE ;  save local changes made to national mapping of icd9 to cpt
 ;  delete the old ADA mapping table
 ;     NODE = DENT228*<patch number>
 ;  ^xtmp(node,0) = p1^p2^p3^p4^p5^p6^p7  where
 ;     p1 = purge date.time          p5 = 1 if save completed
 ;     p2 = date.time save started   p6 = 1 if restore started
 ;     p3 = duz of installer         p7 = 1 if restore completed
 ;     p4 = 1 if save started        p8 = total count of nodes saved
 ;                          C = VACO   L = local code
 ;  ^xtmp(node,cpt_ien)   = C/L^icd9-1^icd9-2^icd9-3^icd9-4^icd9-5^VA cost^Private cost^RVU^VA-DSS Group
 ;  ^xtmp(node,cpt_ien,3) = ADMIN GUIDELINE
 ;   
 N I,X,Y,Z,CNT,CPT,NODE,TYPE,DATA,NEWDD,TOTMAP
 D MSG(1,2,1),NODE
 S X=$G(^XTMP(NODE,0))
 ;
 ;  check to see if previous aborted install had saved table
 ;  if previous save never completed, then that process failed to
 ;  finish pre-installation process
 ;
 I X'="",'$P(X,U,5) K ^XTMP(NODE)
 I $P(X,U,5)!$P(X,U,6) Q
 I $$VFIELD^DSICFM06(,228,1.02,1)<0 S NEWDD=1
 E  S NEWDD=0
 S X=$$FMADD^XLFDT(DT,7)_U_$$NOW^XLFDT_U_DUZ_U_1
 S ^XTMP(NODE,0)=X,I=0
 F  S I=$O(^DENT(228,I)) Q:'I  S X=^(I,0),Y=$G(^(1)) D
 .S CPT=$P(X,U),TYPE=$S($P(X,U,7)="NATIONAL CODES":"C",1:$P(X,U,15)) Q:'CPT
 .S DATA=TYPE_U_$P(Y,U,1,5),$P(DATA,U,7)=$P(Y,U,14),$P(DATA,U,8)=$P(Y,U,15)
 .S $P(DATA,U,9)=$P(X,U,18),$P(DATA,U,10)=$P(X,U,16),$P(DATA,U,11)=NEWDD
 .S ^XTMP(NODE,CPT)=DATA
 .S ^XTMP(NODE,CPT,3)=$P($G(^DENT(228,I,3)),U)
 .I TYPE="L",$D(^DENT(228,I,5)) M ^XTMP(NODE,CPT,5)=^DENT(228,I,5)
 .I 'NEWDD Q
 .S TOTMAP=+Y Q:'TOTMAP  F  S TOTMAP=$O(^DENT(228,I,5,TOTMAP)) Q:'TOTMAP  D
 ..S ^XTMP(NODE,CPT,5,TOTMAP,0)=$G(^DENT(228,I,5,TOTMAP,0)) ;save site added Dxs
 ..Q
 .Q
 ;  Mark save completed, kill off the old table
 D SET(5),MES(3)
 S X=$P(^DENT(228,0),U,1,2) K ^DENT(228) S ^DENT(228,0)=X
 Q
 ;
RESTORE ;  restore locally added cpt codes and icd9 changes
 ;  Definition of codes not added back
 ;  ------------------------------------------------------------
 ;  ^tmp("dent",$j,cpt_code) = 1 if non-ADA code is inactive
 ;  ^tmp("dent",$j,cpt_code,icd9_code) = "" if the CPT code was
 ;                  active but the prior ICD9 code was inactive
 ;  $D(^tmp("dent",$j,cpt_code)) = 10 if the active cpt code had
 ;                         inactive diagnosis codes mapped to it
 ;
 ;  Definition of some key local variables  where n = 1,2,3,4,5
 ;  -----------------------------------------------------------
 ;  n=1,2,3,4,5   DENT() redefined per cpt code
 ;  DENT("LICD",icdien)=locally mapped (added) icd9
 ;
 N I,X,X1,Y,ACT,CNT,CPT,CPTN,DATA,IEN,NODE,DENT,DENTX,DATA3,NEWDD,NI,NX,IC,SP
 D NODE Q:'$D(^XTMP(NODE))  D MES(5)
 F I=1:1:10 L +^DENT(228):2 Q:$T
 ;
 D SET(6) K ^TMP("DENT",$J)
 S (CNT,CPT)=0
 F  S CPT=$O(^XTMP(NODE,CPT)) Q:'CPT  S DATA=^(CPT),DATA3=$G(^(CPT,3)) D
 .K DENT S CNT=CNT+1,NEWDD=$P(DATA,U,11)
 .S X=$$CPT^DSICCPT(,CPT,,,,1),CPTN=$P(X,U,2),ACT=$P(X,U,7)
 .;
 .;  check for inactive local cpt codes
 .;  we will leave inactive codes here for reporting P53
 .;I 'ACT S:CPTN'?1"D"4N ^TMP("DENT",$J,CPTN)=1 Q
 .;
 .; Get IEN if cpt exist in new table
 .S IEN=$O(^DENT(228,"B",CPT,0))
 .; ALWAYS put $Values back and/or admin guideline
 .I IEN I $P(DATA,U,7)!$P(DATA,U,8)!(DATA3]"") K DENTX D
 ..S:$P(DATA,U,7) DENTX(228,IEN_",",1.14)=$P(DATA,U,7)
 ..S:$P(DATA,U,8) DENTX(228,IEN_",",1.15)=$P(DATA,U,8)
 ..S:DATA3]"" DENTX(228,IEN_",",3)=DATA3 ; ADMIN GUIDELINE
 ..D FILE^DIE(,"DENTX")
 ..Q
 .;  setup local icd9 array with codes we want to add back
 .I 'NEWDD,$P(DATA,U)="L" F I=2:1:6 S NX=$P(DATA,U,I) I NX D
 ..S Y=$$ICD9^DSICDRG(,NX,,DT,,1)
 ..I '$P(Y,U,10) S ^TMP("DENT",$J,CPTN,$P(Y,U,2))="" Q
 ..I IEN,$D(^DENT(228,IEN,5,"B",NX)) Q  ;already in the multiple
 ..S DENT("LICD",NX)=""
 ..Q
 .I NEWDD S NI=0 F  S NI=$O(^XTMP(NODE,CPT,5,NI)) Q:'NI  D
 ..S NX=+$G(^XTMP(NODE,CPT,5,NI,0)) Q:'NX
 ..S Y=$$ICD9^DSICDRG(,NX,,DT,,1)
 ..I '$P(Y,U,10) S ^TMP("DENT",$J,CPTN,$P(Y,U,2))="" Q
 ..I IEN,$D(^DENT(228,IEN,5,"B",NX)) Q  ;already in the multiple
 ..S DENT("LICD",NX)=""
 ..Q
 .;  if cpt is not in file 228, then add only if a local code and has ICD codes
 .I 'IEN,$P(DATA,U)="L",$D(DENT("LICD")) D
 ..N X0,X1,DA,DD,DO,DIC,DIE,DIK,IC
 ..S (X,X0,DA)=CPT
 ..S Y=^DENT(228,0),$P(Y,U,3)=DA,$P(Y,U,4)=1+$P(Y,U,4),^(0)=Y
 ..S $P(X0,U,6)="LOCAL CODES",$P(X0,U,15)="L"
 ..S $P(X0,U,16)=$P(DATA,U,10),$P(X0,U,18)=$P(DATA,U,9) ;VA-DSS Group and RVU
 ..S $P(X1,U,14)=$P(DATA,U,7),$P(X1,U,15)=$P(DATA,U,8) ;$Values
 ..S ^DENT(228,DA,0)=X0,^(1)=X1 S:DATA3]"" ^(3)=DATA3
 ..S DIK="^DENT(228," D IX1^DIK
 ..S IEN=CPT
 ..Q
 .Q:'IEN  Q:'$O(DENT("LICD",0))
 .;
 .;site added to natl icd9 mapping, put back local icd9(s) OR add local icd for new codes
 .S IC=0 F  S IC=$O(DENT("LICD",IC)) Q:'IC  D ICD(IEN,IC)
 .Q
 L -^DENT(228)
 K ^XTMP(NODE)
 Q:'$D(^TMP("DENT",$J))
 ;
 ;  some problems encountered during restore, send message
 D MSG(7,9) S I=3,CPTN=0,X="   ",SP="          "
 F  S CPTN=$O(^TMP("DENT",$J,CPTN)) Q:CPTN=""  D:$G(^(CPTN))
 .K ^TMP("DENT",$J,CPTN) S X=X_$E(CPTN_SP,1,10)
 .I $L(X)>70 S I=I+1,Z(I)=X,X="   "
 .Q
 I $L(X)>3 S I=I+1,Z(I)=X
 I $D(Z) D M
 Q:'$D(^TMP("DENT",$J))
 ;
 D MSG(11,13) S I=3,CPTN=0
 F  S CPTN=$O(^TMP("DENT",$J,CPTN)) Q:CPTN=""  D
 .S X="   "_CPTN_":  ",Y=0
 .F  S Y=$O(^TMP("DENT",$J,CPTN,Y)) Q:Y=""  S X=X_$E(Y_SP,1,10)
 .S I=I+1,Z(I)=X
 .Q
 D M K ^TMP("DENT",$J)
 Q
 ;-------------------------  SUBROUTINES  -------------------------
 ;
ICD(ADAI,ICDI) ;FILE^DICN returns new ien of multiple^icd ien (.01) field^1 (added)
 I $D(^DENT(228,ADAI,5,"B",ICDI)) Q  ;already there
 K DO,DD,DIC,DA S DA(1)=ADAI,DIC="^DENT(228,"_DA(1)_",5,",X=ICDI,DIC(0)="L" D FILE^DICN
 Q
MES(X) ;  display messages during install
 ;;Saving your $Value mappings to ADA/CPT codes
 ;;Saving any locally added codes from your ADA/CPT Mapping table
 ;;Deleting entries in old ADA mapping file (#228)
 ;;
 ;;Restoring local CPT codes and $Values to ADA/CPT Mapping table
 ;;
 ;;The following is a list of locally added CPT codes which were not put
 ;;back into the ADA Mapping Table (file 228) as these codes are
 ;;inactive:
 ;;
 ;;The following CPT codes had one or more inactive diagnosis codes
 ;;mapped to them.  These inactive diagnosis codes were not put back
 ;;into the ADA Mapping Table (file 228):
 ;;
 I +X=X S X=">>>>> "_$P($T(MES+X),";",3)_" <<<<<"
 D MES^DSICXPDU(X,1)
 Q
 ;
MSG(X,Y,A) ;
 K Z N I,J S J=0
 F I=X:1:Y S J=J+1,Z(J)=$TR($T(MES+I),";"," ")
 Q:'$G(A)
M D MES^DSICXPDU(.Z)
 Q
 ;
NODE N P,V,X,Y S X=$T(+2),V=$P(X,";",3),Y=$P(X,"**",2),P=$P(Y,",",$L(Y,","))
 S NODE="DENT228*"_$S(P:P,1:V)
 Q
 ;
SET(X) S $P(^XTMP(NODE,0),U,X)=1 Q
