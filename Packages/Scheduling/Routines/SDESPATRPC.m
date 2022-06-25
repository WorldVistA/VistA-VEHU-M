SDESPATRPC ;;ALB/TAW - PATIENT RPCS ;July 27, 2021@13:07
 ;;5.3;Scheduling;**792**;Aug 13, 1993;Build 9
 ;
 ;  IRC #
 ;
 Q
INSURVERIFYREQ(RETURN,DFN) ;
 N POP,SDPAT,FLG,SDPAT
 S (FLG,POP)=0
 I $G(DFN)="" S POP=1 D ERRLOG^SDESJSON(.SDPAT,1)
 I $G(DFN)'="",'$D(^DPT(DFN,0)) S POP=1 D ERRLOG^SDESJSON(.SDPAT,2)
 I 'POP D NEEDVERIFY(.FLG,DFN,180,90) S SDPAT("NeedInsuranceVerification","YesNo")=FLG
 D BUILDER
 Q
NEEDVERIFY(NEEDVERIFY,DFN,LASTVERFWINDOW,NOCOVWINDOW) ;
 ; LASTVERFWINDOW - How many days in the past to look for a Last Verified Date
 ; NOCOVWINDOW    - How many days in the past to loof for a No Coverage Date
 ;
 ; Return
 ;  1 = Verification needed (Default)
 ;  0 = Has active insurance or verification started
 N IENS,SDMSG,PATDATA,BILLPATDATA,NOCOVDT,COVBYHI,SUBIEN,XDT,TMPDT
 S NEEDVERIFY=1,SUBIEN=""
 ;Check the Insurance Verification Processor file
 ; The assumption is that once verification is complete all
 ; references to the patient are removed.
 I $D(^IBA(355.33,"C",DFN)) S NEEDVERIFY=0 Q
 ;Check the Insurance Types (sub file .321) of the Patient File (#2)
 S SUBIEN=0
 F  S SUBIEN=$O(^DPT(DFN,.312,SUBIEN)) Q:SUBIEN=""!(NEEDVERIFY=0)!('SUBIEN)  D
 .S IENS=SUBIEN_","_DFN_","
 .K PATDATA
 .D GETS^DIQ(2.312,IENS,"1.03;3","I","PATDATA","SDMSG")
 .;Check the Insurance Experiation Data is active
 .S TMPDT=PATDATA(2.312,IENS,3,"I")
 .I 'TMPDT!(+TMPDT<DT) Q
 .;Check the Date Last Verified
 .S TMPDT=$P(PATDATA(2.312,IENS,1.03,"I"),".")
 .I TMPDT D
 ..S XDT=$$FMADD^XLFDT(DT,-LASTVERFWINDOW)
 ..I XDT<TMPDT S NEEDVERIFY=0  ;_"^File 2 last verified. Insur Cnt="_IENS_" Last Verify="_TMPDT_" Expir Dt"_TMPDT
 Q:'NEEDVERIFY
 ;
 ;If no insurance on file then check the Covered by Health Insurance
 D GETS^DIQ(2,DFN,".3192","I","PATDATA","SDMSG")
 S COVBYHI=PATDATA(2,DFN_",",.3192,"I")
 I COVBYHI="N"!(COVBYHI="U") D
 .D GETS^DIQ(354,DFN,"60","I","BILLPATDATA","SDMSG")
 .S NOCOVDT=$G(BILLPATDATA(354,DFN_",",60,"I"))
 .I NOCOVDT D
 ..S XDT=$$FMADD^XLFDT(DT,-NOCOVWINDOW)
 ..I XDT<NOCOVDT S NEEDVERIFY=0 ;_"^Coverd by Health Insur = "_COVBYHI_" No Cov Dt="_NOCOVDT
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDPAT,.RETURN,.JSONERR)
 Q
