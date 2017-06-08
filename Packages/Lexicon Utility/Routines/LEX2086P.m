LEX2086P ;ISL/KER - LEX*2.0*86 Pre/Post Install ;12/19/2014
 ;;2.0;LEXICON UTILITY;**86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables 
 ;    ^LEXM(              N/A
 ;               
 ; External References
 ;    DELIX^DDMOD         ICR   2916
 ;    ^DIC                ICR  10006
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$PKGPAT^XPDIP      ICR   2067
 ;    MES^XPDUTL          ICR  10141
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
 ;      LEXLREV    Revision - nn
 ;      LEXREQP    Required Builds - build;build;build
 ;      
 ; Note:  The section IPL (Informational Patch List) must
 ;        be updated with each patch
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST,LEXOK,X,Y S LEXOK=0 D IMP
 S LEXEDT=$G(^LEXM(0,"CREATED")) D:LEXOK>0 LOAD,CON,IP,UPD,NOT
 Q
LOAD ; Load Data - N/A for LEX*2.0*86
 ;             
 ;      LEXSHORT   Send Short Message
 ;      LEXMSG     Flag to send Message
 ;      LEXSUBH    Alternate Message Sub-Header      
 Q
 N LEXSHORT,LEXMSG S LEXSHORT="",LEXMSG=""
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:$G(LEXBUILD)=""
 D:LEXB=LEXBUILD EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;             
KLEXM ; Subscripted Kill of ^LEXM
 H 2 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 N LEX S LEX=$G(^LEXM(0,"PRO")) K ^LEXM(0)
 Q
 ;
IP ; Informational Patches - N/A for LEX*2.0*86
 Q
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
 ;;;;;;
PRE ; Pre-Install              (N/A for this patch)
 Q
NOT ; Notify
 N LEX,LEXP,LEXPS,LEXSQ,LEXT,LEXI,LEXE,LEXX,LEXC,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXSUB,LEXSHORT,LEXOK,LEXSUBH
 D IMP H 1 S (LEXIGHF,LEXSHORT)="",LEXSUBH="ICD-10 API Fixes" D POST^LEXXFI
 Q
CON ; Conversion of data
 N ND S ND="^DD(757.333,1,1,2,0)" W:$D(@ND) !," Deleting STATUS field TRIGGER" D:$D(@ND) DELIX^DDMOD(757.333,1,2)
 Q
UPD ; Update Data
 D UPD1,UPD2
 Q
UPD1 ; Update Clinical Reminders Taxonomy
 N DA,DIK S DA=28,DIK="^LEXT(757.2," I $D(^LEXT(757.2,DA)) D ^DIK
 S DA=28,^LEXT(757.2,DA,0)="Clinical Reminders Taxonomy"
 S ^LEXT(757.2,DA,1)="^LEX(757.01,"
 S ^LEXT(757.2,DA,2)="XTLK^LEXHLP"
 S ^LEXT(757.2,DA,3)="XTLK^LEXPRNT"
 S ^LEXT(757.2,DA,4)="ICD/ICP/10D/10P/CPT/CPC/SCT"
 S ^LEXT(757.2,DA,5)="CR1^WRD^0^811.2^PXRM^^1"
 S ^LEXT(757.2,DA,7)="ICD/ICP/10D/10P/CPT/CPC/SCT"
 S ^LEXT(757.2,DA,100,0)="^757.22^2^2^3141001^^^^"
 S ^LEXT(757.2,DA,100,1,0)="This subset contains the entire Lexicon (unfiltered)"
 S ^LEXT(757.2,DA,100,2,0)="and user defaults are not allowed."
 S DA=28,DIK="^LEXT(757.2," D IX1^DIK
 N DA,DIK S DA=14,DIK="^LEX(757.31," I $D(^LEX(757.31,DA)) D ^DIK
 S DA=14,^LEX(757.31,DA,0)="Clinical Reminders Taxonomy^C"
 S ^LEX(757.31,DA,1)="ICD/ICP/10D/10P/CPT/CPC/SCT"
 S ^LEX(757.31,DA,2,0)="^^5^5^2960724^^^^"
 S ^LEX(757.31,DA,2,1,0)="Displays classification codes from the International"
 S ^LEX(757.31,DA,2,2,0)="Classification of Diseases/Diagnosis (ICD), Current"
 S ^LEX(757.31,DA,2,3,0)="Procedure Terminology (CPT), Healthcare Common Procedure"
 S ^LEX(757.31,DA,2,4,0)="Coding System  (HCPCS), Systematized Nomenclature of"
 S ^LEX(757.31,DA,2,5,0)="Medicine, Clinical Terms (SNOMED CT)."
 S DA=14,DIK="^LEX(757.31," D IX1^DIK
 K ^LEX(757.2,29)
 Q
UPD2 ; Update Title 38 Service Connected
 S DA=29,DIK="^LEXT(757.2," I $D(^LEXT(757.2,DA)) D ^DIK
 S DA=29,^LEXT(757.2,DA,0)="Title 38 Service Connected"
 S ^LEXT(757.2,DA,1)="^LEX(757.01,"
 S ^LEXT(757.2,DA,2)="XTLK^LEXHLP"
 S ^LEXT(757.2,DA,3)="XTLK^LEXPRNT"
 S ^LEXT(757.2,DA,4)="SCC"
 S ^LEXT(757.2,DA,5)="SCC^WRD^0^^^^1"
 S ^LEXT(757.2,DA,6)="I $$SO^LEXU(Y,""SCC"",+($G(LEXVDT)))"
 S ^LEXT(757.2,DA,7)="SCC"
 S ^LEXT(757.2,DA,100,0)="^757.22^4^4^3141001^^^^"
 S ^LEXT(757.2,DA,100,1,0)="This subset is artificially created through the use of a "
 S ^LEXT(757.2,DA,100,2,0)="filter (not a physical subset), and contains only those "
 S ^LEXT(757.2,DA,100,3,0)="expressions which are linked to an Title 38 Service "
 S ^LEXT(757.2,DA,100,4,0)="Conected disability code."
 S DA=29,DIK="^LEXT(757.2," D IX1^DIK
 S DA=15,DIK="^LEX(757.31," I $D(^LEXT(757.2,DA)) D ^DIK
 S DA=15,^LEX(757.31,DA,0)="Title 38 Service Connected^C"
 S ^LEX(757.31,DA,1)="SCC"
 S ^LEX(757.31,DA,2,0)="^^1^1^3141001^^^^"
 S ^LEX(757.31,DA,2,1,0)="Displays Title 38 disability Service Connected Codes."
 S DA=15,DIK="^LEX(757.31," D IX1^DIK
 Q
 ;            
 ; Miscellaneous
PIEN(X) ;   Package IEN
 N DIC,DTOUT,DTOUT,Y S X=$G(X),DIC="^DIC(9.4,",DIC(0)="B" D ^DIC S X=+Y
 Q X
IMP ;   Call IMP in Environment Check
 K LEXBUILD,LEXFY,LEXIGHF,LEXLREV,LEXPTYPE,LEXQTR,LEXREQP N LEXF
 S LEXF=$P($T(+1)," ",1) S:$E(LEXF,$L(LEXF))="P" LEXF=$E(LEXF,1,($L(LEXF)-1)) Q:'$L(LEXF)
 S LEXF="IMP^"_LEXF Q:'$L($T(@LEXF))  D @LEXF S:$L(LEXBUILD) LEXOK=1
 Q
