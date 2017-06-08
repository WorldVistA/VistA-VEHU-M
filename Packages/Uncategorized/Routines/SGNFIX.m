SGNFIX ;ALB/CAW - CLINIC ENROLLMENT ; 7/18/94
 ;
LOOP ; Loop through the enrollment info
 N SDCLIN,SDCLN,SDPAT
 S SDPAT=0
 F  S SDPAT=$O(^DPT(SDPAT)) Q:'SDPAT  D
 .S SDCLN=0 F  S SDCLN=$O(^DPT(SDPAT,"DE",SDCLN)) Q:'SDCLN  S SDCLIN=$G(^(SDCLN,0)) D
 ..I 'SDCLIN W !,"Zeroth node missing on entry "_SDCLN_"for patient "_$P(^DPT(SDPAT,0),U)
 ..I '$D(^SC(+SDCLIN,0)) W !,"Clinic missing from hospital location file on entry "_SDCLN_"for patient "_$P(^DPT(SDPAT,0),U)
 Q
