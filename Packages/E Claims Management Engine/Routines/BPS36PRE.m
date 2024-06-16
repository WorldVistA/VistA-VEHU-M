BPS36PRE ;AITC/PED - Pre-install routine for BPS*1*36 ;06/2023
 ;;1.0;E CLAIMS MGMT ENGINE;**36**;JUN 2004;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*36 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL(" Starting pre-install for BPS*1*36")
 ;
 D BPS21
 D BPS23
 ;
 D MES^XPDUTL(" Finished pre-install of BPS*1*36")
 ;
 Q
 ;
BPS21 ; Update File 9002313.21
 ;
 N BPSA,BPSCD,BPSFN,BPSID,BPSREC
 ;
 ; Update Description
 S BPSID=$O(^BPS(9002313.21,"B","MB",""))
 I BPSID="" Q
 S BPSFN=9002313.21
 S BPSREC=BPSID_","
 S BPSA(BPSFN,BPSREC,1)="MEDICATION BENEFIT OUTWEIGHS RISK"
 D FILE^DIE("","BPSA","")
 ;
 ; Inactivate Codes
 F BPSCD="FE","PH","TC" D
 . S BPSID=$O(^BPS(9002313.21,"B",BPSCD,""))
 . I BPSID="" Q
 . S BPSFN=9002313.21
 . S BPSREC=BPSID_","
 . S BPSA(BPSFN,BPSREC,2)=1
 . D FILE^DIE("","BPSA","")
 ;
 Q
 ;
BPS23 ; Update File 9002313.23
 ;
 N BPSA,BPSCD,BPSFN,BPSID,BPSREC
 ;
 ; Update Description
 S BPSID=$O(^BPS(9002313.23,"B","TD",""))
 I BPSID="" Q
 S BPSFN=9002313.23
 S BPSREC=BPSID_","
 S BPSA(BPSFN,BPSREC,1)="THERAPEUTIC DUPLICATION"
 D FILE^DIE("","BPSA","")
 ;
 ; Inactivate Codes
 F BPSCD="CH","LK","SD" D
 . S BPSID=$O(^BPS(9002313.23,"B",BPSCD,""))
 . I BPSID="" Q
 . S BPSFN=9002313.23
 . S BPSREC=BPSID_","
 . S BPSA(BPSFN,BPSREC,2)=1
 . D FILE^DIE("","BPSA","")
 ;
 Q
 ;
