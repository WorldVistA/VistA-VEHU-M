PSO574P ; HEC/hrubovcak - NCC Pre-install;1 Oct 2019 12:31:04
 ;;7.0;OUTPATIENT PHARMACY;**574**;DEC 1997;Build 53
 ;
 Q
 ;
START ; pre-init for PSO*7*574 - 1 October 2019
 D DT^DICRW
 N RGZRO,STNUM,Y
 D  ; lookup PSOCLOZ Mail Group, set TYPE to PUBLIC, ALLOW SELF ENROLLMENT? to NO
 . N DA,DIE,DR,PSFMERR
 . S DA=$$FIND1^DIC(3.8,"","B","PSOCLOZ","","","PSFMERR") Q:'(DA>0)
 . S DIE="^XMB(3.8,",DR="4///PU;7///n" D ^DIE
 . D BMES^XPDUTL("PSOCLOZ Mail Group updated.")
 ;
 D XTMPZRO^PSOCLOU
 S STNUM=1000+$P($$SITE^VASITE,U,3),RGZRO=$G(^XTMP("PSJ CLOZ",0)),$P(RGZRO,U,4)="Z"_$E(STNUM,2,4)_"999"
 S ^XTMP("PSJ CLOZ",0)=RGZRO
 D BMES^XPDUTL("CLOZAPINE WEEKEND REGISTRATION list updated in "_$NA(^XTMP("PSJ CLOZ")))
 Q
 ;
