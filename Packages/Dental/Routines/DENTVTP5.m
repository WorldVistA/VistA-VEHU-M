DENTVTP5 ;DSS/KC - TREATMENT PLAN DATA RETRIEVAL ;11/03/2003 16:54
 ;;1.2;DENTAL;**39,45,47,53,55**;Aug 10, 2001;Build 5
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine contains subroutines to retrieve DSS Dental Treatment 
 ;  plan data for Transaction data types.  It also retrieves the other
 ;  types using DENTVTP3 and appends that data into one large global
 ; DBIA#  SUPPORTED
 ; -----  ---------  ----------------------------------
 ;  2056      x      GETS^DIQ
 ;  10103     x      FMTE^XLFDT
 ;
TXN(RET,DATA)        ; RPC: DENTV TP GET TXN
 ;  get all of the TXN data for a specified patient
 ;  RET = name of global array which stores the results to be returned
 ;  RET=^TMP("DENT",$J)
 ;  ^TMP("DENT",$J,#) = txnid^provider^adacode^adadesc^aspect^charttp^
 ;       condition^material^region^status^date^time cntr^tooth#^surface^
 ;       phase^isjuv^chart#^visible^next appt^group^deleted^cost^catgy^
 ;       seq index^plaque index^read only^dt created^icd1^icd2^icd3^
 ;       icd4^icd5^ctv^rvu^encounter^product line^canal#^treatment flag^
 ;       visitDate (P53)
 ;  DATA = DFN (patient ien)
 ;  Errors returned as -1^error message
 N X,Y,TIEN,IEN,NODE,DFN,DENT,DENTERR,FROM,TMP,INT,I,VIEN,VDT
 S RET=$NA(^TMP("DENT",$J)),NODE=0,DFN=$G(DATA) K ^TMP("DENT",$J)
 S INT=",2,5,6,7,8,9,10,11,16,18,19,21,26,27,38,39,"
 S X=$$DFN^DENTVRF0(DFN) I X<0 S ^TMP("DENT",$J,1)=X Q
 F TIEN=0:0 S TIEN=$O(^DENT(228.2,"AD",DFN,1,TIEN)) Q:'TIEN  D
 .S IEN=TIEN_"," D GETS^DIQ(228.2,IEN,".01:1.18","IE","DENT","DENTERR")
 .K TMP M TMP=DENT(228.2,IEN) K DENT
 .;S VIEN=$$GET1^DIQ(228.1,+TMP(1.15,"I")_",",.05,"I") ;P47 use visit dt in txn list
 .S VIEN=0 ;P47 T5 this didn't work, take it out for now
 .S VDT=$S(VIEN:$$GET1^DIQ(9000010,VIEN,.01,"I"),1:+TMP(1.01,"I")),VDT=VDT\1
 .S Y=".01^.03^.04^.05^.07^.08^.09^.1^.11^.12^.13^.14^.15^.16^.17^.18^.19^.2^.21^.22^.23^"
 .S Y=Y_".24^.25^.26^.27^.28^1.01^1.06^1.07^1.08^1.09^1.1^1.11^1.12^1.15^1.16^1.17^.06^1.05" ;P53
 .;get external data for everthing except pointers to 228.3
 .F I=1:1:39 S FROM=$P(Y,U,I),$P(X,U,I)=$G(TMP(FROM,$S(INT[(","_I_","):"I",1:"E")))
 .;convert TRUE/FALSE, YES/NO to -1/0
 .F I=16,18,19,21,26,38 S $P(X,U,I)=$S(+$P(X,U,I):-1,1:0)
 .;set the 228.3 data to the VALUE field
 .F I=5:1:10 S $P(X,U,I)=$P($G(^DENT(228.3,+$P(X,U,I),0)),U,3) S:$P(X,U,I)="" $P(X,U,I)=0
 .I $P(X,U,10)=1 S $P(X,U,26)=0 ;P53 read only is false for Planned items
 .I $P(X,U,10)=1,$P(X,U,21) Q  ;P55 if planned and DELETED flag then QUIT (don't return these)
 .;format dates to MM/DD/YYYY@HH:MM
 .S:+$P(X,U,11) $P(X,U,11)=$$FMTE^XLFDT(VDT,5)
 .S:+$P(X,U,27) $P(X,U,27)=$$FMTE^XLFDT($E($P(X,U,27),1,12),5)
 .I +$P(X,U,39) S $P(X,U,39)=$P(X,U,39)\1,$P(X,U,39)=$$FMTE^XLFDT($P(X,U,39),5) ;P53 visit dt
 .E  S $P(X,U,39)=$P($P(X,U,27),"@") ;use date created
 .;default old txns with a Tooth# to region=areWholeTooth to show Tooth# in txn list
 .I $P(X,U,38)=0,$P(X,U,9)=0,$P(X,U,13) S $P(X,U,9)=5
 .I $P(X,U,2)'>0 S $P(X,U,2)=0 ;P45 error in gui if Provider IEN missing
 .S NODE=NODE+1,^TMP("DENT",$J,NODE)=X
 .Q
 I '$O(^TMP("DENT",$J,0)) S ^(1)="-1^No TXN data found for the patient"
 Q
 ;
ENC(RET,DATA) ; RPC : DENTV TP GET OLD ENCOUNTERS
 ; get a list of all complete/terminated episode dates
 ; RET = ^TMP("DENTV",$J,#) = p1^p2
 ;     where p1 = date created
 ;           p2 = COMPLETE or TERMINATED
 ; DATA = DFN (patient ien)
 N X,DFN,CNT,DENT,DENTERR,IEN,EIEN,TMP,GO
 S RET=$NA(^TMP("DENT",$J)),DFN=$G(DATA),CNT=0,GO=1 K ^TMP("DENT",$J)
 S X=$$DFN^DENTVRF0(DFN) I X<0 S @RET@(1)=X Q
 F EIEN=0:0 S EIEN=$O(^DENT(228.1,"C",DFN,EIEN)) Q:'EIEN  K DENTERR D
 .S IEN=EIEN_"," D GETS^DIQ(228.1,IEN,".03;.16;1.01","IE","DENT","DENTERR")
 .Q:$D(DENTERR)
 .K TMP M TMP=DENT(228.1,IEN) K DENT
 .Q:TMP(1.01,"I")  ;don't return if deleted encounter
 .I +TMP(.16,"I")<2  S GO=1 Q  ;only return compl/term enc
 .I 'GO Q  ;only return the first compl/term enc after the active encs
 .S GO=0,CNT=CNT+1,@RET@(CNT)=$$FMTE^XLFDT(TMP(.03,"I"),5)_U_TMP(.16,"E")
 .Q
 I '$D(@RET@(1)) S @RET@(1)="-1^no data for selected patient"
 ;
 Q
 ;
GET(RET,DATA) ;
 ;  get all of the Treatment plan data for a patient
 ;   including TXN, PSR, Perio, and HNC
 ;  RET = name of the global array which stores the results
 ;      = ^TMP("DENTV",$J,#) = transaction data (see TXN above)
 ;      = ^TMP("DENTV",$J,#) = $START PSR
 ;      = ^TMP("DENTV",$J,#) = PSR data (see PSR^DENTVTP3)
 ;      = ^TMP("DENTV",$J,#) = $START HNC
 ;      = ^TMP("DENTV",$J,#) = HNC data (see HNC^DENTVTP3)
 ;      = ^TMP("DENTV",$J,#) = $START PERIO
 ;      = ^TMP("DENTV",$J,#) = $START ien (perio ien)
 ;      = ^TMP("DENTV",$J,#) = Perio data (see PERIO^DENTVTP3)
 ;      = ^TMP("DENTV",$J,#) = $END ien (perio ien)
 ;  DATA = DFN (patient ien)
 ;  Errors returned as -1^error message on the appropriate node
 ;  No data for a particular transaction type will return
 ;                -1^no data message like so:
 ;         TMP("DENTV",$J,#)=$START PERIO
 ;         TMP("DENTV",$J,#)=-1^No PERIO data found for the patient
 N TXN,I,J
 S RET=$NA(^TMP("DENTV",$J)) K ^TMP("DENTV",$J)
 D TXN(.TXN,DATA) M @RET=@TXN K @TXN
 F J="PSR","HNC","PERIO" D
 .S I=$O(@RET@(""),-1)+1,@RET@(I)="$START "_J
 .S J=J_"^DENTVTP3(.TXN,DATA,"_I_")" D @J M @RET=@TXN K @TXN
 Q
 ;
LST(RET,DFN) ;RPC: DENTV TP GET LAST STATUS
 ; input is patient dfn
 ; Returns Status^DAS Disposition^EncounterIEN
 ; Return is 0 for Active, 1 for Inactive, 2 for Maintenance
 ;    from DAS DISPOSITION field .16 in 228.1:
 ;    where 1=In Progress, 2=Completed, 3=Terminated, 4=Maintenance
 I $G(DFN)="" S RET=0 Q  ;default active
 N LV,IEN,N0 S LV="",RET="",N0=0
 F  S LV=$O(^DENT(228.1,"AE",DFN,LV),-1) Q:'LV!N0  D
 .S IEN="" F  S IEN=$O(^DENT(228.1,"AE",DFN,LV,IEN),-1) Q:'IEN!N0  D
 ..Q:+$G(^DENT(228.1,IEN,1))  ;deleted
 ..S N0=$P($G(^DENT(228.1,IEN,0)),U,16),RET=$S(N0=1:0,N0=4:2,1:1)_U_N0_U_IEN
 ..Q
 .Q
 Q
