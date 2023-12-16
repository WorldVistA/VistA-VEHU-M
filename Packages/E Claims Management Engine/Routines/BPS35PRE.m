BPS35PRE ;AITC/PED - Pre-install routine for BPS*1*35 ;01/2023
 ;;1.0;E CLAIMS MGMT ENGINE;**35**;JUN 2004;Build 14
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*35 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL(" Starting pre-install for BPS*1*35")
 ;
 D BPS21
 D BPS42
 D BPS93
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1*35")
 ;
 Q
 ;
BPS21 ; Update File 9002313.21
 ;
 N BPSA,BPSFN,BPSID,BPSREC
 ;
 S BPSID=$O(^BPS(9002313.21,"B","NM",""))
 I BPSID="" Q
 S BPSFN=9002313.21
 S BPSREC=BPSID_","
 S BPSA(BPSFN,BPSREC,1)="Non-Medication Counseling"
 D FILE^DIE("","BPSA","")
 ;
 Q
 ;
BPS42 ; Update File 9002313.42
 ;
 N BPSA,BPSFN,BPSID,BPSREC
 ;
 S BPSID=$O(^BPS(9002313.42,"B","07",""))
 I BPSID="" Q
 S BPSFN=9002313.42
 S BPSREC=BPSID_","
 S BPSA(BPSFN,BPSREC,.02)="DEA - Active Controlled Substances Act (CSA)"
 D FILE^DIE("","BPSA","")
 ;
 Q
 ;
BPS93 ; Update File 9002313.93
 ;
 N BPSA,BPSFN,BPSID,BPSREC
 ;
 S BPSID=$O(^BPSF(9002313.93,"B","Yes",""))
 I BPSID="" Q
 S BPSFN=9002313.93
 S BPSREC=BPSID_","
 S BPSA(BPSFN,BPSREC,.01)="@"
 D FILE^DIE("","BPSA","")
 ;
 Q
 ;
