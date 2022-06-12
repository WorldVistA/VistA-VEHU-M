ISIIMP05 ;ISI Group/MLS -- Appointment Create Utility
 ;;1.0;;;Jun 26,2012;Build 30
 Q
VALIDATE() 
 ;
 S ADATE=$G(ISIMISC("ADATE"))
 S SC=$G(ISIMISC("CLIN"))
 S DFN=$G(ISIMISC("PATIENT"))
 ;
 D:$G(ISIPARAM("DEBUG"))>0
 .W !,"ADATE:",$G(ADATE)," SC:",$G(SC)," DFN:",DFN
 .W !,"<HIT RETURN TO PROCEED>" R X
 .Q
 ;
 ; Validate import array contents
 S ISIRC=$$VALAPPT^ISIIMPU2
 Q ISIRC
 ;
MAKEAPPT()      ;
 ; Create Appointment
 S ISIRC=$$APPT(ADATE,SC,DFN)
 Q ISIRC
 ;
APPT(ADATE,SC,DFN)
 ; Input -  ADATE (Appointment Date [internal fileman format])
 ;          SC    (Hospital Location #44)
 ;          DFN   (Patient DFN #2)
 ;
 ; Output - ISIRC [return code]
 ;      
 N COLLAT,SDY,COV,SDYC,OEPTR
 S ^DPT(DFN,"S",ADATE,0)=SC
 S ^SC(SC,"S",ADATE,0)=ADATE 
 S:'$D(^DPT(DFN,"S",0)) ^(0)="^2.98P^^" 
 S:'$D(^SC(SC,"S",0)) ^(0)="^44.001DA^^"
 F SDY=1:1 I '$D(^SC(SC,"S",ADATE,1,SDY)) S:'$D(^(0)) ^(0)="^44.003PA^^" S ^(SDY,0)=DFN_U_15 Q
 S COLLAT=0,COV=3,SDYC="",COV=$S(COLLAT=1:1,1:3),SDYC=$S(COLLAT=7:1,1:"")
 S:ADATE<DT SDSRTY="W" ; Walk-In
 S ^DPT(DFN,"S",ADATE,0)=SC_"^"_""_"^^^^^"_COV_"^^^^"_SDYC_"^^^^^"_9_U_$G(SD17)_"^^"_DT_"^^^^^"_$G(SDXSCAT)_U_$P($G(SDSRTY),U,2)_U_$$NAVA^SDMANA(SC,ADATE,$P($G(SDSRTY),U,2))
 S ^DPT(DFN,"S",ADATE,1)=$G(ADATE)_U_$G(SDSRFU)
 ;xref DATE APPT. MADE field
 D
 .N DIV,DA,DIK
 .S DA=ADATE,DA(1)=DFN,DIK="^DPT(DA(1),""S"",",DIK(1)=20 D EN1^DIK
 .Q
 ;Check in appt
 Q:ISIRC<0 ISIRC ; in case error during reindex
 D ONE^SDAM2(DFN,SC,ADATE,SDY,0,ADATE)
 Q:+ISIRC<0 ISIRC
 N CDATE S CDATE=ADATE+.01
 ;Create encounter
 D ENCOUNTER Q:+ISIRC<0 ISIRC
 ;
 ;Outpatient diagnosis
 ;D DIAG(OEPTR,ICD) Q:+ISIRC<0 ISIRC
 ;
 ;Check out
 D DT^SDCO1(DFN,ADATE,SC,SDY,0,CDATE,"")
 Q:+ISIRC<0 ISIRC ;in case error
 ;
 ;Finish up
 D PATAPPT
 Q ISIRC
 ;
ENCOUNTER ;
 N DIE,FDA,MSG
 I '$D(^SCE(0)) S ISIRC="-1^VistA Error.  No top level node for OUTPATIENT ENCOUNTER (SCE(0))" Q
 S OEPTR=$P($G(^SCE(0)),U,3)
 K DIE,FDA,MSG
 S FDA(409.68,"+1,",.01)=ADATE
 S FDA(409.68,"+1,",.02)=DFN
 S FDA(409.68,"+1,",.03)=$P($G(^SC(SC,0)),U,7)
 S FDA(409.68,"+1,",.04)=SC
 S FDA(409.68,"+1,",.07)=CDATE
 S FDA(409.68,"+1,",.08)=1
 S FDA(409.68,"+1,",.09)=SDY
 S FDA(409.68,"+1,",.1)=9
 S FDA(409.68,"+1,",.11)=$S($P(^SC(SC,0),U,15):$P(^(0),"^",15),1:+$O(^DG(40.8,0)))
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG) S ISIRC="-1^Problem saving Outpatient Encounter information (#409.68) "_$G(MSG("DIERR",1,"TEXT",1))
 Q:+ISIRC<0
 I $P($G(^SCE(0)),U,3)'>OEPTR S ISIRC="-1^Problem getting Oupatient Encounter pointer (#409.69" Q
 S OEPTR=$P($G(^SCE(0)),U,3)
 S ISIRC=1
 Q
 ;
DIAG(OEPTR,ICD)
 ;DIAGNOSIS (409.43,.01) POINTER TO ICD DIAGNOSIS FILE (#80)
 ;OUTPATIENT ENCOUNTER (409.43,.02) POINTER OUTPATIENT ENCOUNTER FILE (#409.68)
 ;DIAGNOSIS RANKING (409.43,.03)    FREE TEXT
 Q
 ;
PATAPPT ;
 N FDA,MSG,IENS
 K FDA,MSG
 S IENS=ADATE_","_DFN_","
 S FDA(2.98,IENS,3)="I"
 S FDA(2.98,IENS,9)=3
 S FDA(2.98,IENS,19)=DUZ
 S FDA(2.98,IENS,21)=OEPTR
 S FDA(2.98,IENS,22)=1
 S FDA(2.98,IENS,25)="O"
 S FDA(2.98,IENS,26)=0
 K ^ZMIKE("PATAPPT")
 M ^ZMIKE("PATAPPT")=FDA
 D FILE^DIE(,"FDA","MSG")
 I $D(MSG) S ISIRC="-1^Problem saving  Appointment info (#2.98) - "_$G(MSG("DIERR",1,"TEXT",1))
 Q:+ISIRC<0
 S ISIRC=1
 Q
