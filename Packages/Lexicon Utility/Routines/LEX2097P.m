LEX2097P ;ISL/KER - LEX*2.0*97 Pre/Post Install ;10/02/2014
 ;;2.0;LEXICON UTILITY;**97**;Sep 23, 1996;Build 3
 ;               
 ;               
 ; Global Variables
 ;    ^LEX(757.32         N/A
 ;    ^LEX(757.33         N/A
 ;    ^LEXM(              N/A
 ;    ^ORD(101            ICR    872
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^DIC                ICR  10006
 ;    UPDATE^DIE          ICR   2053
 ;    ^DIK                ICR  10013
 ;    $$GET1^DIQ          ICR   2056
 ;    RBLDUID^PXRMTAXD    ICR   6120
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$PKGPAT^XPDIP      ICR   2067
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;    EN^XQOR
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    None
 ;               
 Q
POST ; Post-Install
 ;            
 ; From IMP in the Environment Check
 ;            
 ;      LEXBUILD   Build Name - LEX*2.0*nn
 ;      LEXPTYPE   Patch Type - Remedy or Quarterly
 ;      LEXFY      Fiscal Year - FYnn
 ;      LEXQTR     Quarter - 1st, 2nd, 3rd, or 4th
 ;      LEXIGHF    Name of Host File - LEX_2_nn.GBL
 ;      LEXLREV    Revision - nn
 ;      LEXREQP    Required Builds - build;build;build
 ;      
 ; Note:  The section IPL (Informational Patch List) must
 ;        be updated with each patch
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST,LEXOK,LEXNOPRO,X,Y S LEXOK=0 D IMP
 S LEXEDT=$G(^LEXM(0,"CREATED")),LEXNOPRO=1 D:LEXOK>0 LOAD,CON,IP,NOT
 Q
LOAD ; Load Data
 ;             
 ;      LEXSHORT   Send Short Message
 ;      LEXMSG     Flag to send Message
 ;            
 N LEXSHORT,LEXMSG K LEXSHORT,LEXMSG
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:$G(LEXBUILD)=""
 S LEXNOPRO=1 D:LEXB=LEXBUILD EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;             
KLEXM ; Subscripted Kill of ^LEXM
 H 2 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 N LEX S LEX=$G(^LEXM(0,"PRO")) K ^LEXM(0)
 Q
 ;
IP ; Informational Patches
 N LEX,LEXP,LEXPS,LEXSQ,LEXT,LEXI,LEXE,LEXX,LEXC,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXSUB,LEXOK D IMP S LEXSUB=""
 I $G(LEXPTYPE)="Code Set Update",$G(LEXFY)["FY",$L($G(LEXQTR)) S LEXSUB="Code Set "_LEXFY_" "_LEXQTR_" Qtr Update"
 S LEXC=0 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXE="S LEXX=$T(IPL+"_LEXI_")" X LEXE S:'$L($TR($G(LEXX),";","")) LEXX="" Q:'$L(LEXX)  S LEXPS=$P(LEXX,";;",2) S:$L(LEXPS,"*")=3 LEXC=LEXC+1
 I LEXC>0 S LEXT=" Informational Patch"_$S(+($G(LEXC))>1:"es",1:"") S:$L(LEXSUB) LEXT=LEXT_" for the "_LEXSUB S LEXT=LEXT_":" D MES^XPDUTL(LEXT)
 S LEXC=0 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXE="S LEXX=$T(IPL+"_LEXI_")" X LEXE S:'$L($TR($G(LEXX),";","")) LEXX="" Q:'$L(LEXX)  S LEXPS=$P(LEXX,";;",2) S:'$L(LEXPS) LEXX="" Q:'$L(LEXX)
 . S LEXSQ=+($P(LEXX,";;",3)) S:+LEXSQ>0 LEXPS=LEXPS_" SEQ #"_LEXSQ S LEXC=LEXC+1 D:LEXC=1 MES^XPDUTL(" ")
 . W:$D(LEXTEST) !,?5,LEXPS D:'$D(LEXTEST) IPU(LEXPS)
 D:LEXC>0 MES^XPDUTL(" ") N LEXTEST
 Q
IPU(X) ;   Patch Update
 N LEXID,LEXOP,LEXPC,LEXPK,LEXPKI,LEXPN,LEXPTI,LEXSQ,LEXT,LEXVR,LEXVRI,LEXAR
 S LEXPC=$G(X),LEXSQ=$P(LEXPC," ",2,299),LEXID=$P(LEXPC," ",1),LEXOP=""
 S LEXPK=$S($P(LEXPC,"*",1)="ICD":"DRG GROUPER",$P(LEXPC,"*",1)="ICPT":"CPT/HCPCS CODES",$P(LEXPC,"*",1)="LEX":"LEXICON UTILITY",1:"") Q:'$L(LEXPK)
 S LEXPKI=$$PIEN(LEXPK) Q:+LEXPKI'>0  S LEXVR=$P(LEXPC,"*",2) Q:'$L(LEXVR)  Q:LEXVR'["."  S LEXPN=$P(LEXPC,"*",3) Q:'$L(LEXPN)  Q:+LEXPN'>0
 S LEXAR=LEXPN_"^"_$$NOW^XLFDT_"^"_$G(DUZ)
 I $L($G(LEXBUILD)) S LEXOP=$$PKGPAT^XPDIP(LEXPKI,LEXVR,.LEXAR)
 S LEXVRI=$P(LEXOP,"^",1),LEXPTI=$P(LEXOP,"^",2)
 S LEXT="   "_LEXID,LEXT=LEXT_$J(" ",(17-$L(LEXT)))_LEXSQ,LEXT=LEXT_$J(" ",(28-$L(LEXT)))_LEXPK
 I $L(LEXOP),LEXPTI>0 S LEXT=LEXT_$J(" ",(46-$L(LEXT)))_"Patch History updated" D MES^XPDUTL(LEXT)
 I $L(LEXOP),LEXPTI'>0 S LEXT=LEXT_$J(" ",(46-$L(LEXT)))_"Patch History not updated" D MES^XPDUTL(LEXT)
 I '$L(LEXOP) D MES^XPDUTL(LEXT)
 Q
IPL ;   Patch List  ;;Patch;;Sequence #
 ;;ICPT*6.0*69;;
 ;;ICD*18.0*76;;
 ;;;;;;
PRE ; Pre-Install          
 D DELMAP,DELSUB
 Q
DELMAP ; Remove the ICD to SCT Mapping IENs
 N IEN,MDES,TXT S TXT="   Remove the ICD to SNOMED CT Mapping entries in the MAPPINGS file #757.33"
 D BMES^XPDUTL(TXT) W "  " S IEN="",MDES="",MDES=$O(^LEX(757.32,"B","SCT2ICD",MDES))
 F  S IEN=$O(^LEX(757.33,"AMAPDEF",MDES,IEN)) Q:'IEN  D
 . N DIK,DA S DIK="^LEX(757.33,",DA=IEN D ^DIK
 Q
DELSUB ; Remove the CLF and PL Standard subset IENs
 N IEN,SUB,WORD,TXT S TXT="   Remove the ""CLF"" and ""PLS"" subsets from the SUBSET file #757.21"
 D MES^XPDUTL(TXT) W "  " S IEN="",MDES="",MDES=$O(^LEX(757.32,"B","SCT2ICD",MDES))
 F SUB="ACLF","APLS" D
 . S WORD="" F  S WORD=$O(^LEX(757.21,SUB,WORD)) Q:WORD=""  D
 . . S IEN="" F  S IEN=$O(^LEX(757.21,SUB,WORD,IEN)) Q:IEN=""  D
 . . . N DA,DIK S DIK="^LEX(757.21,",DA=IEN D ^DIK
 Q
CON ; Conversion of data
 N TXT S TXT="   Fix HCPCS code ""Q9974"" Description" D BMES^XPDUTL(TXT) W "  "
 K FDA S FDA(81.621,"1,1,111351"_",",.01)="INJECTION, MORPHINE SULFATE, PRESERVATIVE-FREE FOR EPIDURAL OR INTRATHECAL USE," D UPDATE^DIE(,"FDA")
 N TXT S TXT="   Rebuild Clinical Reminders ""AUID"" Index" D MES^XPDUTL(TXT) W "  " D RBLDUID^PXRMTAXD D MES^XPDUTL(" ")
 Q
NOT ; Notify via Protocols
 N DIFROM,LEXPRO,LEXPRON,LEXLAST,LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD
 N LEXP,LEXSTR,LEXLAST,LEXOK,LEXNOPRO,LEXSHORT,LEXMSG,LEXID,LEXPROC,LEXSCHG,LEXPOST,LEXPC,IREC,FREC,OR
 N I,C,J,X,Y,ZTSK,ZTQUEUED,ZTRTN,ZTDESC S LEXID="LEXKID",LEXOK=0 D IMP S LEXPOST=""
 S LEXSHORT="",LEXMSG="",LEXSCHG("LEX")=0,LEXSCHG("ICD")=0,LEXSCHG("CPT")=0
 S LEXP=+($O(^ORD(101,"B","LEXICAL SERVICES UPDATE",0))) I LEXP>0 D
 . S X=LEXP_";ORD(101," D EN^XQOR S ^LEXM(0,"PRO")=$$NOW^XLFDT
 I +($G(LEXSCHG("LEX")))>0 D
 . N X,LEXED S X="  'LEXICAL SERVICES UPDATE' ",X=X_$J(" ",(30-$L(X)))
 . S LEXED=$$EDT($G(LEXSCHG("LEX"))) S:$L(LEXED) X=X_" "_LEXED S LEXPC=+($G(LEXPC))+1 S:$L(LEXED) LEXPROC((LEXPC+1))=X
 I +($G(LEXSCHG("ICD")))>0 D
 . N X,LEXED S X="  'ICD CODE UPDATE EVENT'   ",X=X_$J(" ",(30-$L(X)))
 . S LEXED=$$EDT($G(LEXSCHG("ICD"))) S:$L(LEXED) X=X_" "_LEXED S LEXPC=+($G(LEXPC))+1 S:$L(LEXED) LEXPROC((LEXPC+1))=X
 I +($G(LEXSCHG("CPT")))>0 D
 . N X,LEXED S X="  'CPT CODE UPDATE EVENT'   ",X=X_$J(" ",(30-$L(X)))
 . S LEXED=$$EDT($G(LEXSCHG("CPT"))) S:$L(LEXED) X=X_" "_LEXED S LEXPC=+($G(LEXPC))+1 S:$L(LEXED) LEXPROC((LEXPC+1))=X
 I $O(LEXPROC(" "),-1)>1,'$D(LEXPROC(1)) S LEXPROC(1)="Protocols invoked:"
 I +($G(DUZ))>0,$L($$GET1^DIQ(200,(+($G(DUZ))_","),.01)) D
 . D HOME^%ZIS N DIFROM,LEXPRO,LEXPRON,LEXLAST S LEXPRON="LEXICAL SERVICES UPDATE",LEXPRO=$G(^LEXM(0,"PRO"))
 . D POST^LEXXFI
 K ^LEXM(0,"PRO")
 Q
 ;            
 ; Miscellaneous
PIEN(X) ;   Package IEN
 N DIC,DTOUT,DTOUT,Y S X=$G(X),DIC="^DIC(9.4,",DIC(0)="B" D ^DIC S X=+Y
 Q X
EDT(LEX) ;   External Date
 S LEX=$$FMTE^XLFDT($G(LEX),"1Z") S:LEX["@" LEX=$P(LEX,"@",1)_"  "_$P(LEX,"@",2,299)
 Q LEX
IMP ;   Call IMP in Environment Check
 K LEXBUILD,LEXFY,LEXIGHF,LEXLREV,LEXPTYPE,LEXQTR,LEXREQP N LEXF
 S LEXF=$P($T(+1)," ",1) S:$E(LEXF,$L(LEXF))="P" LEXF=$E(LEXF,1,($L(LEXF)-1)) Q:'$L(LEXF)
 S LEXF="IMP^"_LEXF Q:'$L($T(@LEXF))  D @LEXF S:$L(LEXBUILD) LEXOK=1
 Q
