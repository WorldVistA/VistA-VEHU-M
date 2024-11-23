PXCOMPACTBKGRND ;ALB/BPA,CMC - Background job routine for COMPACT Act processing ;04/29/2024 4:03OM
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**240**;Aug 12, 1996;Build 55
 ; *240* Background routine for COMPACT Act administrative eligibility
 ; 
 Q
 ;
BCKGRDJOB ;
 N DFN,ENDDT,PXLASTSEQ,PXEOCNUM,PXTY
 ;this is a background job that will identify episodes of care that have expired and end them
 S DFN=""
 F  S DFN=$O(^PXCOMP(818,"B",DFN)) Q:DFN=""  D
 . S PXEOCNUM=$$GETEOC^PXCOMPACT(DFN)
 . ;check EOC OPEN/CLOSE flag (1 = open, 0 = closed)
 . I $P(^PXCOMP(818,PXEOCNUM,0),"^",2)=0 Q
 . ;check if episode is Inpatient or Outpatient
 . S PXTY=$P(^PXCOMP(818,PXEOCNUM,0),"^",3)
 . I PXTY="" Q
 . ;get latest episode of care sequence
 . S PXLASTSEQ=$$GETEOCSEQ^PXCOMPACT(DFN)
 . ;now verify the corresponding Inpatient/Outpatient benefit end date and compare to today
 . I PXTY="I" S ENDDT=$P($G(^PXCOMP(818,PXEOCNUM,10,PXLASTSEQ,0)),"^",4)
 . I PXTY="O" S ENDDT=$P($G(^PXCOMP(818,PXEOCNUM,10,PXLASTSEQ,0)),"^",5)
 . I ENDDT="" Q
 . I DT>ENDDT D
 . . D SETENDDT^PXCOMPACT(DFN,ENDDT,"TE",,"Time expired")
 Q
 ;
