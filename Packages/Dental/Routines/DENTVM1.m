DENTVM1 ;DSS/KC - QUEUE AND POLL MONITORS;02/12/2009 09:46
 ;;1.2;DENTAL;**57,64**;Aug 10, 2001;Build 3
 ;Copyright 1995-2009, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  ICR#   SUPPORTED
 ;  -----  --------- 
 ;  2053   FILE^DIE
 ;  10063  ^%ZTLOAD, $$TM^%ZTLOAD
 ;  2056   $$GET1^DIQ,GETS^DIQ
 ;  10103  $$FMADD^XLFDT
 ;
 Q
QUE(RET,DFN) ;RPC: DENTV MONITOR QUEUE
 ;Queue a background job to process patient monitors (fluoride for example)
 ;or other things that take a long time.
 ;returns -1^error message or
 ;fluoride monitor value^other monitor (if we add this)
 ;fluoride monitor = 0 (in process), =1 (no flag) = 2 (flag)
 ; if =2 then must call POLL to get the monitor details
 ;
 I '$G(DFN) S RET="-1^Missing Patient param" Q
 N MON S MON=$G(^DENT(220,"AM",DFN,DT))
 I MON S RET=$S(MON=2:MON_U_"Call POLL to get monitor details",1:MON) Q
 N X,LV,IEN,QUIT,CLAS S QUIT=0,LV=""
 S CLAS=+$$GET1^DIQ(2,DFN,220,"I") I 'CLAS D
 .F  S LV=$O(^DENT(228.1,"AE",DFN,LV),-1) Q:'LV!(QUIT)  D
 ..S IEN="" F  S IEN=$O(^DENT(228.1,"AE",DFN,LV,IEN),-1) Q:'IEN!(QUIT)  D
 ...Q:+$G(^DENT(228.1,IEN,1))  ;deleted
 ...S CLAS=$P($G(^DENT(228.1,IEN,0)),U,13)
 ...Q
 ..Q
 .Q
 I 'CLAS S RET="-1^Unknown Patient/Dental class" Q
 I ",9,13,15,"'[(","_CLAS_",") S RET="-1^Monitor not applicable for Class "_CLAS Q
 ;I '$$TM^%ZTLOAD S RET="-1^TaskMan not running" Q
 N DENTV,DENTERR S DENTV(220,DFN_",",5)=DT
 D FILE^DIE("K","DENTV","DENTERR")
 ;
 D DQ ;run the monitor real time
 S MON=$G(^DENT(220,"AM",DFN,DT))
 S RET=$S(MON=2:MON_U_"Call POLL to get monitor details",1:1) ;force 1 or 2 if real time
 Q
Q ;QUEUE the job (future use if this process takes too long)
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTDESC="DENTAL MONITOR "_DFN,ZTDTH=$H,ZTIO="",ZTRTN="DQ^DENTVM1"
 S ZTSAVE("DFN")=""
 D ^%ZTLOAD I $G(ZTSK)'>0 S RET="-1^Attempt to schedule task failed" Q
 S RET=0
 Q
 ;
POLL(RET,DFN) ;RPC: DENTV MONITOR POLL
 ;Poll to see if the monitor background job has finished and if so,
 ;get the results.  Or get existing results from a previous monitored job
 ;Results are array: results(1)=fluoride monitor value^other monitor
 ;                   results(2)=F$1st ien^first code^date^2nd ien^second code^date
 ;                   results(n)=other monitor data (if we add this)
 I '$G(DFN) S RET(1)="-1^Missing Patient param" Q
 N MON S MON=$G(^DENT(220,"AM",DFN,DT)) S RET(1)=MON
 I MON="" S RET(1)="-1^no results for this date"
 Q:MON<2  ;only flagged result returns codes
 N DENT1,DENT2,DEN,DENTV
 S DENT1=$$GET1^DIQ(220,DFN,3,"I"),DENT2=$$GET1^DIQ(220,DFN,4,"I")
 I 'DENT1&'DENT2 Q
 S RET(2)="F$"
 D GETS^DIQ(228.2,+DENT1,".04;.05;1.05","E","DENTV")
 S DEN="DENTV(228.2,"""_DENT1_","")"
 S RET(2)=RET(2)_DENT1_U_@DEN@(.04,"E")_"-"_@DEN@(.05,"E")_U_@DEN@(1.05,"E")
 K DENTV D GETS^DIQ(228.2,+DENT2,".04;.05;1.05","E","DENTV")
 S DEN="DENTV(228.2,"""_DENT2_","")"
 S RET(2)=RET(2)_U_DENT2_U_@DEN@(.04,"E")_"-"_@DEN@(.05,"E")_U_@DEN@(1.05,"E")
 Q
 ;
DQ ;come in from tasked call
 ;DFN was saved with TaskMan
 ;For CLASS I, IIC or IV patients...
 ;We need to find at least 2 restorative codes for the patient within the 
 ;last 12 months (can be on the same date) - this TURNS ON THE FLUORIDE FLAG...
 ;then check to see if there's a fluoride code or the fluoride date in file 220
 ;(replacement for a fluoride Rx) was given either 12 months prior to
 ;the first code or 6 months after the second code.  This TURNS OFF THE FLAG.
 ;**save the flag setting each day for each patient so we don't have to do
 ;**this each time they bring up the patient for time savings.
 ;****having a fluoride code or rx in the last 12 months turns off the flag by default
 N DR,DF,RCI,FCI,RCOMPDT,FCOMPDT,QUIT,LV,IEN,NODE,FCODE,FDATA,FRXDT,DENTV,PC,RDATA
 S RCOMPDT=$$FMADD^XLFDT(DT,-365) ;1 year ago
 S FCOMPDT=$$FMADD^XLFDT(DT,-730) ;2 years ago
 D PARM(.DR,.DF,RCOMPDT,FCOMPDT)
 ;get all non-deleted fluoride codes given in last 2 years
 S FCI=0,QUIT=0,FRXDT=""
 F  S FCI=$O(DF(FCI)) Q:'FCI  D
 .S LV="" F  S LV=$O(^DENT(228.2,"AC",DFN,FCI,LV),-1) Q:'LV!QUIT!(LV<FCOMPDT)  D
 ..S IEN="" F  S IEN=$O(^DENT(228.2,"AC",DFN,FCI,LV,IEN),-1) Q:'IEN!QUIT  D
 ...S NODE=$G(^DENT(228.2,IEN,0)) Q:NODE=""!+$P($G(^DENT(228.2,IEN,1)),U,3)  ;deleted
 ...I LV>RCOMPDT S QUIT=1 Q  ;this ends the monitor
 ...S FDATA(LV)=IEN
 ...Q
 ..Q
 .Q
 I 'QUIT S FRXDT=$$GET1^DIQ(220,DFN,6,"I") I FRXDT>RCOMPDT S QUIT=1 ;fluoride RX given w/i year
 I FRXDT,FRXDT<FCOMPDT S FDATA(FRXDT)="" ;rx given within 2 years
 ;if QUIT exists, fluoride was given in last year - Monitor is Met (flag is OFF)
 I QUIT D FILE(1) Q
 ;else we have array of fluoride dates older than 1 year less than 2 years
 ;now get most recent two restoration codes RDATA=CODE1^CODE2
 S RCI=0,QUIT=0,PC=1,RDATA=""
 F  S RCI=$O(DR(RCI)) Q:'RCI  D
 .S LV="" F  S LV=$O(^DENT(228.2,"AC",DFN,RCI,LV),-1) Q:'LV!(QUIT>1)!(LV<RCOMPDT)  D
 ..S IEN="" F  S IEN=$O(^DENT(228.2,"AC",DFN,RCI,LV,IEN),-1) Q:'IEN!(QUIT>1)  D
 ...S NODE=$G(^DENT(228.2,IEN,0)) Q:NODE=""!+$P($G(^DENT(228.2,IEN,1)),U,3)  ;deleted
 ...S:RDATA PC=2 S $P(RDATA,U,PC)=IEN_";"_LV,QUIT=QUIT+1
 ...Q
 ..Q
 .Q
 ;
 I '$P(RDATA,U,2) D FILE(1) Q  ;if no restorations, set flag=1 and quit
 I '$D(FDATA) D FILE(2,+$P(RDATA,U),+$P(RDATA,U,2)) Q  ;if rest/no fluo/flag=2/quit
 ;compare dates
 N C1DT,C2DT,C1CDT,C2CDT
 S C1DT=$P($P(RDATA,U),";",2),C2DT=$P($P(RDATA,U,2),";",2)
 S C1CDT=$$FMADD^XLFDT(C1DT,-366) ;1 year before 1st code
 S C2CDT=$$FMADD^XLFDT(C1DT,182) ;6 months afer 2nd code
 I C2CDT>DT S C2CDT=DT ;can't be in the future obviously
 I $O(FDATA(C1CDT))>0 D FILE(1) Q  ;Fluoride w/i 12 months of code1, monitor is off
 I $O(FDATA(C2DT))>C2CDT D FILE(1) Q  ;Fluoride w/i 6 months of code2, monitor is off
 D FILE(2,+$P(RDATA,U),+$P(RDATA,U,2))
 Q
FILE(MON,C1,C2) ;Set the fluoride monitor and quit.  Setting the flag updates the run date
 ; field 5 and the "AM" x-ref in file 220
 Q:'$G(DFN)
 N DENTV S DENTV(220,DFN_",",7)=MON
 S DENTV(220,DFN_",",3)=$G(C1) ;code 1 - may be removed if flag=1
 S DENTV(220,DFN_",",4)=$G(C2) ;code 2 - may be removed if flag=1
 D FILE^DIE("K","DENTV")
 Q
 ;
PARM(REST,FLUO,RCOMP,FCOMP) ;Get restorative codes and fluoride codes from parameters
 ;restorative codes are those in range D2100-D2798
 ;fluoride codes are D1201,D1203,D1204,D1205,D1206,D1208,D5986
 ;throw out the inactive codes outside of the dates we'll be checking
 N X,Y,XI,OK,VADSS,FCODE,DENT
 S VADSS=U F XI=17:1:26 S VADSS=VADSS_+$O(^DENT(228.42,"B","DES0"_XI,0))_U
 S FCODE=$P($T(FCODE),";",3),XI=100200
 F  S XI=$O(^DENT(228,XI)) Q:'XI  S DENT=$G(^DENT(228,XI,0)) D
 .S OK=0,X=$$CPT^DSICCPT(,+DENT,,,,1)
 .I VADSS[(U_$P(DENT,U,16)_U) S OK=1 ;restoration code
 .I FCODE[(","_$P(X,U,2)_",") S OK=2 ;fluoride code
 .Q:'OK  ;not one of the codes we're checking
 .I $P(DENT,U,2) Q:$S(OK=1:$P(DENT,U,2)<RCOMP,OK=2:$P(DENT,U,2)<FCOMP,1:"")
 .I OK=1 S REST(XI)=$P(X,U,2)
 .E  S FLUO(XI)=$P(X,U,2)
 Q
RRUN(DFN,DHIST) ;called from DENTVTPA when txns filed
 ;reset the monitor to run for the day
 Q:'$G(DFN)
 N CLAS S CLAS=+$$GET1^DIQ(2,DFN,220,"I") I 'CLAS D
 .I $G(DHIST) S CLAS=$$GET1^DIQ(228.1,DHIST,.13,"I")
 .Q
 I 'CLAS Q
 I ",9,13,15,"'[(","_CLAS_",") Q
 N DENTV S DENTV(220,DFN_",",5)="@"
 D FILE^DIE("K","DENTV")
 Q
FCODE ;;,D1201,D1203,D1204,D1205,D1206,D1208,D5986,
