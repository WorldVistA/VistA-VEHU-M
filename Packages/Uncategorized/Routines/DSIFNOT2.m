DSIFNOT2 ;DSS/AMC - FEE BASIS (DSIF) RPC'S ;03/01/2009
 ;;3.2;FEE BASIS CLAIMS SYSTEM;**2**;Jun 05, 2009;Build 22
 ;Copyright 1995-2012, Document Storage Systems, Inc., All Rights Reserved
 ; 
 ; Integration Agreements
 ;   315  EN3^PRCS58
 ;   831  ^PRCS58CC
 ;  5379  $$STATUS^DGENA
 ;  4436  $$DELETE^DGPTFEE
 ;  5090  SITEP^FBAAUTL
 ;  5090  SITEP^FBAAUTL
 ;  5300  ^PRC(424,"E",^PRC(424,"B"
 ; 10000  NOW^%DTC
 ; 10018  ^DIE
 ; 10013  ^DIK
 ;  5090  SITEP^FBAAUTL
 ;  5272  ^FBAAA
 ;  5104  ^FB7078
 ; 10076  ^XUSEC
 ;  5214  EN3^PRCS58
 ; 10061  IN5^VADPT,KVAR^VADPT
 ;  2171  $$NS^XUAF4
 ;  
 ;
CANCHK(AXY,IEN) ;RPC - DSIF INP CHECK CANCEL 7078
 ;Input Parameters
 ;     IEN - Pointer to file 162.4 VA FORM 10-7078 (Required)
 ;     
 ;Return Values
 ;     -1 ^ Invalid Input!
 ;     -1 ^ FEE BASIS Site Parameters not set!
 ;     -1 ^ 7078 Already Cancelled!
 ;     -1 ^ 7078 is not for a CIVIL HOSPITAL.
 ;     -1 ^ Invoice entered for this hospitalization. Cannot delete!
 ;     -1 ^ Ancillary services entered against this authorization. Cannot delete!
 ;     1 = Record OK for deletion.
 ;     
 N FBSITE,FBPSA,FB7078,FBAAOB,FBPOP,FB0,FB,DFN,FBMM,FBADDT,FBVEN,DSIFEX
 I '$D(^FB7078(+$G(IEN),0)) S AXY="-1^Invalid Input!" Q
 D SITEP^FBAAUTL I FBPOP S AXY="-1^FEE BASIS Site Parameters not set!" Q
 S FBPSA=$P($$NS^XUAF4($P(FBSITE(1),U,3)),U,2)
 S FB7078=IEN_";FB7078(",FB0=$G(^FB7078(IEN,0)),FBAAOB=FBPSA_"-"_$P($P(FB0,U),".")_"-"_$P($P(FB0,U),".",2)
 S DFN=$P(FB0,U,3),FB(161)=+$O(^FBAAA("AG",FB7078,DFN,0)),FBMM=$E($P(FB0,U,4),4,5)
 S FBADDT=$P(FB0,U,4),FBVEN=$P(FB0,U,2)
 I $P(FB0,U,9)="DC" S AXY="-1^7078 Already Cancelled!" Q
 I $P(FB0,U,11)'=6 S AXY="-1^7078 is not for a CIVIL HOSPITAL." Q
 ; DSIF*3.2*2 (added call to a revised API to see if a payment exists for the 7078, this call uses standard FM not direct global reads)
 S DSIFEX="" D EDTCHK^DSIFUTL(.DSIFEX,IEN) I +DSIFEX=-1 S AXY="-1^Payment exists for this 7078. Cannot delete" Q
 S AXY=1
 Q
CAN7078(AXY,IEN) ;RPC - DSIF INP CANCEL 7078
 ;Input Parameters
 ;     IEN - Pointer to file 162.4 VA FORM 10-7078 (Required)
 ;     
 ;Return Values
 ;     -1 ^ Invalid Input!
 ;     -1 ^ FEE BASIS Site Parameters not set!
 ;(0 in first piece means that the 7078 was set to a cancel state but PTF or 1358 problems occured)
 ;     0 ^ Unable to delete Non-VA PTF Record.
 ;     0 ^ Unable to locate reference number on 1358.
 ;     0 ^ 1358 Not available for posting.
 ;     0 ^ No data string passed
 ;     0 ^ Data element in string missing
 ;     0 ^ Invalid Transaction or Transaction previously closed
 ;     0 ^ Authorization amount can't be adjusted.
 ;     0 ^ Unauthorized control point user
 ;     0 ^ Insufficent obligation funds to adjust authorization to post bill
 ;     0 ^ Credit bill amount will exceed total bill amount
 ;     0 ^ Unable to create Authorization Line Item
 ;     1 = Everything went fine
 ;     
 N FBSITE,FBPSA,FB7078,FBAAOB,DSINOT,FBPOP,FB0,FB,DFN,FBMM,FBADDT,FBVEN,DA,DIK,DIE,PRCS,PRCSX,%,DR,FBNH,Y,FBERR,DSIFEX
 S AXY=1,FBERR=0
 I '$D(^FB7078(+$G(IEN),0)) S AXY="-1^Invalid Input!" Q
 D SITEP^FBAAUTL I FBPOP S AXY="-1^FEE BASIS Site Parameters not set!" Q
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) S AXY="-1^You must be a holder of the 'FBAASUPERVISOR' key to cancel a 7078." Q
 S FBPSA=$P($$NS^XUAF4($P(FBSITE(1),U,3)),U,2)
 S FB7078=IEN_";FB7078(",FB0=$G(^FB7078(IEN,0)),FBAAOB=FBPSA_"-"_$P($P(FB0,U),".")_"-"_$P($P(FB0,U),".",2)
 ;check if payments or Invoies made against the 7078   ;if so do not allow a user to cancel
 ; DSIF*3.2*2 (added call to a revised API to see if a payment exists for the 7078, this call uses standard FM not direct global reads)
 S DSIFEX="" D EDTCHK^DSIFUTL(.DSIFEX,IEN) I DSIFEX<1 S AXY="-1^Payment exists for this 7078. Cannot delete" Q
 S DSINOT=$P(FB0,U,17),DFN=$P(FB0,U,3),FB(161)=+$O(^FBAAA("AG",FB7078,DFN,0)),FBMM=$E($P(FB0,U,4),4,5)
 S FBADDT=$P(FB0,U,4),FBVEN=$P(FB0,U,2)
 S DA(1)=DFN,DA=$O(^FBAAA("AG",FB7078,DFN,0)) I DA S DIK="^FBAAA("_DFN_",1," D ^DIK K DIK,DA
 S DA=+FB7078,DIE="^FB7078(",DR=".013///^S X=DUZ;.014///^S X=DT;9////^S X=""DC""" D ^DIE K DIE,DA
 S DA=$O(^FBAA(162.2,"AM",IEN,0)) I DA S DIE="^FBAA(162.2,",DR="16////@" D ^DIE K DIE,DA
 D 1358 I FBERR S AXY="0^Unable to affect 1358 adjustment.  Use appropriate IFCAP options." Q
 N FBX
 S FBX=$$DELETE^DGPTFEE(DFN,FBADDT)
 I FBX'=1 S AXY="0^Unable to delete Non-VA PTF Record."
 Q
 ;
1358 ;  subtract estimated dollar amount from 1358
 ;FBAAOB=FULL OBLIGATION NUMBER (STATION #-OBLIGATION #-REF #)
 ;FBERR returned if IFCAP call fails
 ;internal entry # in 424 = $O(^PRC(424,"B",FBAAOB,0))
 ;check if 1358 available for posting
 I '$$INTER() S AXY="0^Unable to locate reference number on 1358." Q
 S PRCS("X")=$P(FBAAOB,"-",1,2),PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 S AXY="0^1358 Not available for posting." Q
 D NOW^%DTC
 S PRCSX=$$INTER()_"^"_%_"^"_0_"^"_"Authorization has been cancelled"_"^"_1_"^"
 S PRCS("TYPE")="FB" D ^PRCS58CC I Y'=1 S AXY="O^"_$P(Y,U,2) Q
 Q
 ;
INTER() ;get internal entry number from file 424
 ;first check interface id x-ref
 ;second check is to "B" x-ref to stay backward compatible with IFCAP3.6
 ;
 I '$G(FBNH),$D(^PRC(424,"E",DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2))) Q $O(^(DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2),0))
 ; DSIF*3.2*2 added FBMM line below
 I $G(FBNH),$D(^PRC(424,"E",DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2)_";"_FBMM)) Q $O(^(DFN_";"_+FB7078_";"_$P(FBAAOB,"-",2)_";"_FBMM,0))
 I $D(^PRC(424,"B",FBAAOB)) Q $O(^PRC(424,"B",FBAAOB,0))
 Q 0
 ;
RECREQ(FBOUT,PRT,DFN,ADMAREA) ;RPC: 
 ;  COPIED FROM D BEGINREG^DGREG(DFN)  D ADM^RTQ3
 Q  ; Code is not currently in use, future enhancement
PATCHK(AXY,DFN) ;RPC - DSIF CHECK PATIENT
 ;Patient level checks that produce warnings
 N YY S YY=0
 I '$G(DFN) S YY=YY+1,AXY(YY)="-1^Invalid Input!" Q
 ;
 N STAT S STAT=$$STATUS^DGENA(DFN)
 ;
 D IN5^VADPT I $S(VAIP(13)']"":0,1:1) S YY=YY+1,AXY(YY)="0^***PATIENT IS CURRENTLY AN INPATIENT***"
 I $S('$D(^DPT(DFN,.107)):0,$P(^(.107),"^",1)']"":0,1:1) S YY=YY+1,AXY(YY)="0^***PATIENT IS CURRENTLY A LODGER***"
 S:'YY AXY(0)=1
 D KVAR^VADPT
 Q
