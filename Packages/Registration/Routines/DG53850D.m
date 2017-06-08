DG53850D ;ALB/AAS -  IMPORT WIZARD FOR ICD-10 CODES INTO FILE 27.17;6/21/13 1328
 ;;5.3;Registration;**850**;Aug 13, 1993;Build 172
 ;
 Q
 ;DG2717ST - start IEN for adding new entries
UPD(DG2717ST) ; - Top level entry point
 N DGCNT1,DGCNT2,DGSTRT
 D BMES^XPDUTL("Adding Entries to Catastophic Disability Reasons File")
 N DGIDX
 S DGIDX=$$MAXIEN()
 I (DGIDX>49) D MES^XPDUTL("Nationally controlled file Catastrophic Disability Reasons contains local codes - File 27.17 Not Nationally compliant!")
 ;
 D SETVER(DG2717ST)
 S DGSTRT=DG2717ST
 D DIAG2717(.DGSTRT)
 D PROC2717(.DGSTRT)
 D MES^XPDUTL("     Total Diagnosis Entries added to Catastophic disability Reasons: "_DGCNT1)
 D MES^XPDUTL("     Total Procedure Entries added to Catastophic disability Reasons: "_DGCNT2)
 I DGCNT1+DGCNT2=138 D BMES^XPDUTL("ALL ENTRIES ADDED SUCCESSFULY")
 I DGCNT1+DGCNT2'=138 D BMES^XPDUTL("Problem exists, entry totals should be 17 and 121")
 Q
 ;set coding system field for ICD-9 entries
 ;DG2717ST - the IEN where ICD-10 entries are supposed to start
SETVER(DG2717ST) ; Set ICD version on first entries, updates piece 9 
 N DGIEN1,DGNDE,DGTYP,DGICDVAL
 N DGCSYS,DGFILE
 F DGIEN1=0:0 S DGIEN1=$O(^DGEN(27.17,DGIEN1)) Q:('DGIEN1)!(DGIEN1'<DG2717ST)  D
 . S DGNDE=$G(^DGEN(27.17,DGIEN1,0)) Q:DGNDE=""
 . S DGTYP=$P(DGNDE,"^",2),DGICDVAL=$P(DGNDE,"^",3)
 . S DGFILE=0
 . I DGTYP="P",DGICDVAL["ICD0" S DGFILE=80.1
 . I DGTYP="D",DGICDVAL["ICD9" S DGFILE=80
 . Q:DGFILE=0
 . S DGCSYS=$$CSI^ICDEX(DGFILE,+DGICDVAL)
 . I 'DGCSYS Q
 . I +$$FILLFLDS^DG53850B(27.17,9,DGIEN1,DGCSYS)=0 D MES^XPDUTL("Code "_$$CODEC^ICDEX(DGFILE,+DGICDVAL)_" wasn't updated")
 Q
 ;
DIAG2717(DGDINUM) ; - Store Diagnosis DATA in file 27.17
 ; .01 - Name fill with DGDSCR     0;2
 ;  1  - Type, fill with D or P  0;2
 ;  4  = Affected Limb (mult)    node 1, 0;1 
 ;  8  - HL7 value               0;4
 ;  9  - ICD10 code (variable)   0;9
 ;   10 - Long description        5;1
 ;
 N DGI,DGTXTSTR,DGTYP,DGCODVAL,DGDSCR,DIC,DA,X,Y,DGIEN1,ERR
 N DINUM
 S Y=1,DGCNT1=0
 F DGI=1:1 S DGTXTSTR=$P($T(DIAG+DGI^DG53850E),";;",2,10) Q:DGTXTSTR=""  D
 .  S DGTYP=$P(DGTXTSTR,"^",1)
 .  S DGCODVAL=$P(DGTXTSTR,"^",4)
 .  S DGDSCR=$P(DGTXTSTR,"^",5)
 .  I '$O(^DGEN(27.17,"C",DGCODVAL,0)) D
 ..  K DIC,DA,DR,DD,DO,X
 ..  S DIC=27.17,DIC(0)="LEFZ",X=$E(DGDSCR,1,79)
 ..  S DIC("DR")="1///"_$E(DGTYP,1)_";8////"_DGCODVAL_";10////"_DGDSCR_";3///"_DGCODVAL
 ..  S DINUM=DGDINUM
 ..  D FILE^DICN
 ..  S DGDINUM=DGDINUM+1
 ..  I +Y>0 W "." S DGCNT1=DGCNT1+1
 ..  I Y=-1 S ERR=$G(ERR)+1
 Q
 ;
PROC2717(DGDINUM) ; - Store Procedure DATA in file 27.17
 N DGI,DGTXTSTR,DGTYP,DGCODVAL,DGDSCR,DGLMB,DGTSTVL,DGABBRV,DIC,DA,X,Y,DGIEN1
 S Y=1,DGCNT2=0
 F DGI=1:1 S DGTXTSTR=$P($T(PROC+DGI^DG53850E),";;",2,10) Q:DGTXTSTR=""  D
 .  S DGTYP=$P(DGTXTSTR,"^",1)
 .  S DGABBRV=$P(DGTXTSTR,"^",2)
 .  S DGLMB=$P(DGTXTSTR,"^",3)
 .  S DGCODVAL=$P(DGTXTSTR,"^",4)
 .  S DGDSCR=$P(DGTXTSTR,"^",5)
 .  I '$O(^DGEN(27.17,"C",DGCODVAL,0)) D
 ..  K DIC,DA,DR,DD,DO,X
 ..  S DIC=27.17,DIC(0)="LEFZ",X=$E(DGDSCR,1,79)
 ..  S DIC("DR")="1///"_$E(DGTYP,1)_";8////"_DGCODVAL_";10////"_DGDSCR_";3///"_DGCODVAL
 ..  S DINUM=DGDINUM
 ..  D FILE^DICN S DGIEN1=+Y
 ..  S DGDINUM=DGDINUM+1
 ..  I +Y>0 W "." S DGCNT2=DGCNT2+1
 ..  I Y=-1 S ERR=$G(ERR)+1
 ..  Q:DGIEN1<1
 ..  K DIC("V"),DIC("DR")
 ..  S DGTSTVL="RUE;RLE;LUE;LLE;BLE;BUE"
 ..  I 'DGTSTVL[DGLMB Q
 ..  S DA(1)=DGIEN1,DIC="^DGEN(27.17,"_DGIEN1_",1,"
 ..  S X=DGABBRV D FILE^DICN
 Q
 ;
MAXIEN() ; Return Max IEN
 Q $O(^DGEN(27.17,"AAAA"),-1)
 ;
