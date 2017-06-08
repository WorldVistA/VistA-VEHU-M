VEJDSD02 ;DSS/SGM - VARIOUS SCHEDULING/PCE UTILITIES ;12/04/2002 14:04
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
PCMM(RET,DFN,DATE,ROLE) ; RPC: VEJDSD PRIMARY CARE PROV
 ;  return patient's primary care provider or attending
 ;  DFN - required - file 2 ien or any name lookup value
 ; DATE - optional - default DT - relevant date
 ; ROLE - optional - default = 1
 ;        1 for PC provider,  2 for attending
 ; On error return -1^error message
 ; Else return file 200 ien^name
 N X
 S X=$$GET^DSICDPT1($G(DFN)) I X>0 S DFN=+X
 E  S RET=X Q
 S DATE=$G(DATE) S:'DATE DATE=DT
 S X=$$OUTPTPR^SDUTL3(DFN,DATE,$G(ROLE))
 S RET=$S(X>0:X,1:"-1^Not found")
 Q
