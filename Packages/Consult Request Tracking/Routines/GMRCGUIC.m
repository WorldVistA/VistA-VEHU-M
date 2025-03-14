GMRCGUIC ;SLC/DCM,JFR - GUI actions for editing consults; 3/13/03 12:21 ;Sep 14, 2020@11:26:29
 ;;3.0;CONSULT/REQUEST TRACKING;**4,12,20,15,22,33,66,73,85,81,145**;DEC 27, 1997;Build 18
 ;
 ; This routine invokes IA #2698 (ORD(101.42)), #872(ORD(101)), #2713 (ORB3F1), #2051 (FIND1^DIC)
 ;                         #2053 (DIE), #2056 (GET1^DIQ), #2690 (ORB3FUP1), #5679 (LEXU), #10103 (XLFDT), #10104 (XLFSTR), #5747 (ICDEX)
 ;
RFQ(GMRCO,MSG,ND,NOW) ;File Reason For Request field 20
 N GMRCND,GMRCNT
 S GMRCND=$O(^GMR(123,GMRCO,20,0)) I GMRCND="" S GMRCFLD(20)="Reason For Request: No Previous Value^20" Q
 M ^TMP("GMRCFLD20",$J,20)=^GMR(123,GMRCO,20)
 S GMRCFLD(20)=$NAME(^TMP("GMRCFLD20",$J,20))
 K ^GMR(123,GMRCO,20)
 S ^GMR(123,GMRCO,20,0)="^^^^"_DT_"^"
 S GMRCND="",GMRCNT=1 F  S GMRCND=$O(@MSG@(ND,GMRCND)) Q:GMRCND=""  S ^GMR(123,GMRCO,20,GMRCNT,0)=@MSG@(ND,GMRCND),GMRCNT=GMRCNT+1
 S $P(^GMR(123,GMRCO,20,0),"^",3)=GMRCNT-1,$P(^(0),"^",4)=GMRCNT-1
 Q
FILE(GMRCO,MSG,GMRCLM) ;File Edit changes
 ;GMRCO=Record IEN,  GMRCCOM=Comment Array
 ;MSG=^TMP global where the data resides, i.e., MSG="^TMP(""GMRCR"",$J)"
 ;    Data is stored in subscripted nodes: ^TMP("GMRCR",$J,1)="GMRCSS^2"
 ;    Word processing data is stored in second subscripted node:
 ;    ^TMP("GMRCR",$J,9,1)="This is word processing data."
 ;GMRCSS=To Service     GMRCPROC=procedure/Request Type
 ;GMRCURG=Urgency       GMRCPL=Place Of Consultation
 ;GMRCATN=Attention To  GMRCINO=Service is In/Out Patient
 ;GMRCDIAG=Provisional Diagnosis  .GMRCRFQ=Reason For Request array
 ;GMRCREQ=Procedure or Request; i.e., GMRCRQT=1727=^ORD(101,1727,0)='Procedure';GMRCRQT=1296=^ORD(101,1296,0)='Consult'
 ;GMRCITM=Item ordered for field .1 (stored in ^GMR(123,GMRCO,1.11,
 ;GMRCLM=coming from List Manager instead of the GUI
 ;GMRCERDT=Clinically Indicated Date   GMRCDSID=DST ID
 ;GMRCCSYS=coding system for provisional dx GMRCDXDT=Date of provisional dx   GMRCLABL=label applied to dx code for display purposes e.g. "ICD-9-CM"
 ;
 I '$D(GMRCO)!('+GMRCO) Q
 N GMRCSS,GMRCPROC,GMRCURG,GMRCPL,GMRCATN,GMRCRQT
 N GMRCION,GMRCDIAG,GMRCDXCD,GMRCACTN,GMRCERDT,GMRCCSYS,GMRCDXDT,GMRCLABL,CODINTXT,GMRCDSID
 S GMRCDT=$$NOW^XLFDT
 S GMRCMSG="",GMRCNOD=0
 F  S GMRCNOD=$O(@MSG@(GMRCNOD)) Q:GMRCNOD=""  S GMRCMSG=@MSG@(GMRCNOD) D
 .I $P(GMRCMSG,"^",1)="COMMENT" D COMMENT^GMRCGUIU(GMRCO,MSG,GMRCNOD,$P(GMRCMSG,"^",2)) Q
 .I $P(GMRCMSG,"^",1)="GMRCRFQ" D RFQ(GMRCO,MSG,GMRCNOD,GMRCDT) Q
 .I $P(GMRCMSG,"^",1)="GMRCSS" S GMRCSS=$P(GMRCMSG,"^",2),GMRCFLD(1)=$P(^GMR(123.5,$P(^GMR(123,GMRCO,0),"^",5),0),"^",1)_"^1" Q
 .I $P(GMRCMSG,"^",1)="GMRCITM" S GMRCITM=$P(GMRCMSG,"^",2),GMRCFLD(.1)=^GMR(123,GMRCO,1.11)_"^.1" Q
 .I $P(GMRCMSG,"^",1)="GMRCPROC" Q  ;S GMRCFLD(4)=+$P(^GMR(123,+GMRCO,0),"^",8)_"^4" D  Q ;ignore procedure, can't be changed currently
 .; ..S GMRCPROC=$P(GMRCMSG,"^",2) I $L($P(^GMR(123,GMRCO,0),"^",8)),$P(GMRCMSG,"^",2)="" S GMRCPROC="DELETE"
 .I $P(GMRCMSG,"^",1)="GMRCURG" S GMRCURG=$P(GMRCMSG,"^",2),GMRCFLD(5)=$S(+$P(^GMR(123,+GMRCO,0),"^",9):$P(^ORD(101,+$P(^GMR(123,+GMRCO,0),"^",9),0),"^",2),1:"")_"^"_$P(^GMR(123,+GMRCO,0),"^",9) Q
 .I $P(GMRCMSG,"^",1)="GMRCPL" D  Q
 ..S GMRCPL=$P(GMRCMSG,"^",2) I '+GMRCPL D
 ...S GMRCPL="GMRCPLACE - "_$S(GMRCPL="C":"ON CALL",GMRCPL="B":"BEDSIDE",GMRCPL="E":"EMERGENCY ROOM",1:GMRCPL),GMRCPL=$O(^ORD(101,"B",GMRCPL,0))
 ..S GMRCFLD(6)=$S(+$P(^GMR(123,+GMRCO,0),"^",10):$P($P(^ORD(101,+$P(^GMR(123,+GMRCO,0),"^",10),0),"^",1)," - ",2),1:"")_"^6"
 ..Q
 .I $P(GMRCMSG,"^",1)="GMRCATN" S GMRCATN=$P(GMRCMSG,"^",2),GMRCFLD(7)=$S(+$P(^GMR(123,+GMRCO,0),"^",11):$$GET1^DIQ(200,+$P(^GMR(123,+GMRCO,0),"^",11),.01),1:"")_"^7" Q
 .I $P(GMRCMSG,"^",1)="GMRCREQ" S GMRCREQ=$P(GMRCMSG,"^",2),GMRCFLD(13)=$S($P(^GMR(123,+GMRCO,0),"^",17)="P":"Procedure",1:"Consult")_"^13" Q
 .I $P(GMRCMSG,"^",1)="GMRCION" S GMRCION=$P(GMRCMSG,"^",2),GMRCFLD(14)=$S($P(^GMR(123,+GMRCO,0),"^",18)="I":"Inpatient",$P(^(0),"^",18)="O":"Outpatient",1:"")_"^14" Q
 .I $P(GMRCMSG,"^",1)="GMRCERDT" S GMRCERDT=$P(GMRCMSG,"^",2),GMRCFLD(17)=$S(+$P(^GMR(123,+GMRCO,0),"^",24)>0:$$FMTE^XLFDT($P(^GMR(123,+GMRCO,0),"^",24)),1:"")_"^17" Q
 .I $P(GMRCMSG,"^",1)="GMRCDSID" D  Q
 ..S:$D(^GMR(123,+GMRCO,75)) GMRCDSID=$P(GMRCMSG,"^",2),GMRCFLD(85)=$S(^GMR(123,+GMRCO,75)>0:^GMR(123,+GMRCO,75),1:"")_"^85"
 ..S:'$D(^GMR(123,+GMRCO,75)) GMRCDSID=$P(GMRCMSG,"^",2),GMRCFLD(85)=GMRCDSID_"^85"
 .I $P(GMRCMSG,"^",1)="GMRCDIAG" D  Q
 ..S GMRCDIAG=$P(GMRCMSG,"^",2)
 ..S GMRCFLD(30)=$G(^GMR(123,+GMRCO,30))_"^30"
 ..I $P(GMRCFLD(30),U)="" S $P(GMRCFLD(30),U)="No Previous Value"
 ..I $L($P(GMRCMSG,U,3)) D
 ...S GMRCDXCD=$P(GMRCMSG,"^",3)
 ...S GMRCCSYS=$$CODECS^ICDEX($G(GMRCDXCD),80) S GMRCCSYS=$S($P(GMRCCSYS,U)=1:"ICD",$P(GMRCCSYS,U)=30:"10D",1:"")
 ...S GMRCLABL=$P($G(^GMR(123,+GMRCO,30.1)),U,3)
 ...S GMRCLABL=$S($G(GMRCLABL)="ICD":"ICD-9-CM",$G(GMRCLABL)="10D":"ICD-10-CM",1:"")
 ...S GMRCFLD(30.1)=$P($G(^GMR(123,+GMRCO,30.1)),U)_"("_$G(GMRCLABL)_")"_"^30.1"
 ...S GMRCDXDT=$P($G(^GMR(123,+GMRCO,30.1)),U,2)
 ...S:$G(GMRCDXDT)="" GMRCFLD(30.2)="No Previous Value"_"^30.2"
 ...S:DT>+$G(GMRCDXDT) GMRCFLD(30.2)=$$FMTE^XLFDT(GMRCDXDT,"D")_"^30.2"
 ...I GMRCCSYS'=$P($G(^GMR(123,+GMRCO,30.1)),U,3) S GMRCFLD(30.3)=$S($P($G(^GMR(123,+GMRCO,30.1)),U,3)="ICD":"ICD-9-CM",$P($G(^GMR(123,+GMRCO,30.1)),U,3)="10D":"ICD-10-CM",1:"")_"^30.3"
 ..I $G(GMRCDXCD)'="" S CODINTXT="("_GMRCDXCD_")" D
 ... I GMRCDIAG[CODINTXT S GMRCDIAG=$E(GMRCDIAG,0,($L(GMRCDIAG)-$L(CODINTXT))) S GMRCDIAG=$$TRIM^XLFSTR(GMRCDIAG,"R")
 .Q
 S:'$D(GMRCLM) GMRCGUIF=1
 S GMRCACTN=$$EN^GMRCEDT3(GMRCO)
 S DR=$$SETDA^GMRCGUIU($G(GMRCSS),$G(GMRCPROC),$G(GMRCURG),$G(GMRCPL),$G(GMRCATN),$G(GMRCRQT),$G(GMRCION),$G(GMRCERDT),$G(GMRCDIAG),$G(GMRCDXCD),$G(GMRCDSID)) I $L(DR) D
 .S DIE="^GMR(123,",DA=GMRCO
 .L +^GMR(123,GMRCO):$S($G(DILOCKTM)>0:DILOCKTM,1:5) ;WAT/66 added timeout
 .D ^DIE
 .S DR="8////^S X=5;9////^S X=11"
 .D ^DIE
 .L -^GMR(123,GMRCO)
 .K DIE,DR,DA
 .Q
 S DFN=$P(^GMR(123,+GMRCO,0),"^",2),GMRCPROV=$P(^(0),"^",14),GMRCTYPE=$P(^(0),"^",17),GMRCTRLC="XX^RESUBMIT",VISIT="",RMBED=""
 D EN^GMRCHL7(DFN,+GMRCO,GMRCTYPE,RMBED,GMRCTRLC,$G(DUZ),VISIT,.GMRCOM)
 S GMRCSVC=$S($G(GMRCSS):GMRCSS,1:$P(^GMR(123,+GMRCO,0),U,5))
 S GMRCORTX="Resubmitted consult "_$$ORTX^GMRCAU(+GMRCO)
 S GMRCORTX=GMRCORTX_$S($G(GMRCURG):" ("_$P(^ORD(101,+GMRCURG,0),"^",2)_")",+$P(^GMR(123,+GMRCO,0),U,9):"( "_$P(^ORD(101,+$P(^GMR(123,+GMRCO,0),U,9),0),"^",2)_" )",1:"")
 S GMRCFL=1
 D MSG^GMRCP(DFN,GMRCORTX,+GMRCO,27,.GMRCADUZ,GMRCFL) ;Send notification of NEW consult
 D PRNT^GMRCUTL1(+$P(^GMR(123,+GMRCO,0),U,5),+GMRCO) ;send 513 to service
 ;Next line gets rid of alert
 I $D(XQAID),$L(XQAID) D
 . N GMRCCORY
 . S XQAKILL=$$XQAKILL^ORB3F1 D DEL^ORB3FUP1(.GMRCCORY,XQAID)
 I $P($G(^GMR(123,+GMRCO,12)),U,5)="P" D
 . D TRIGR^GMRCIEVT(GMRCO,GMRCACTN)
 D GUIC^GMRCGUIU
 Q
SEND(GMRCO,GLOBAL) ;Get data fields to send to GUI for editing consult
 ;GMRCO=record being edited GLOBAL=Global Referece, i.e., "^TMP("GMRCR",$J)"
 K @GLOBAL
 N ND,GMRCSX,TYPE,NDX,GMRCCPTR,GMRCCSYS,GMRCCODE,CODINTXT
 S ND=1,GMRCSX=""
 I '$D(GMRCO)!('+GMRCO) Q
 S GMRC(0)=$G(^GMR(123,+GMRCO,0)) Q:'$L(GMRC(0))
 S GMRCSS=$P(GMRC(0),"^",5),GMRCPROC=$P(GMRC(0),"^",8)
 S GMRCURG=$P(GMRC(0),"^",9),GMRCPL=$P(GMRC(0),"^",10)
 S GMRCATN=$P(GMRC(0),"^",11),GMRCINO=$P(GMRC(0),"^",18)
 S GMRCREQ=$P(GMRC(0),"^",17),GMRCERDT=$P(GMRC(0),"^",24)
 S:$D(^GMR(123,+GMRCO,75)) GMRCDSID=$P(^GMR(123,+GMRCO,75),U)
 S GMRCDIAG=$G(^GMR(123,+GMRCO,30)) I $L($G(^(30.1))) D
 . S GMRCCODE=$P($G(^GMR(123,+GMRCO,30.1)),"^",1)
 . S GMRCCSYS=$P($G(^GMR(123,+GMRCO,30.1)),"^",3)
 . S GMRCCPTR=$S(GMRCCSYS="ICD":1,1:30)
 . I $G(GMRCCODE)'="" D  ;users expect to see prov dx text and dx code in edit/resubmit dialog
 .. S CODINTXT=" ("_GMRCCODE_")"
 .. Q:GMRCDIAG[CODINTXT
 .. S GMRCDIAG=GMRCDIAG_CODINTXT
 . S GMRCDIAG=GMRCDIAG_U_$G(GMRCCODE)
 S GMRCPROV=$S($P(^GMR(123,+GMRCO,0),U,14):$$GET1^DIQ(200,+$P(^(0),U,14),.01),1:"")
 S @GLOBAL@(ND,0)="~SERVICE",ND=ND+1
 I +GMRCSS S GMRCSX=$P(^GMR(123.5,GMRCSS,0),"^",1),@GLOBAL@(ND,0)="d"_GMRCSX_"^"_GMRCSS_"^",ND=ND+1,GMRCSX=""
 E  S @GLOBAL@(ND,0)="d"_"^^",ND=ND+1
 S @GLOBAL@(ND,0)="~PROCEDURE",ND=ND+1
 I $L(GMRCPROC),+GMRCPROC D
 .S GMRCSX=$$UP^XLFSTR($$GET1^DIQ(123.3,+GMRCPROC,.01))
 .S GMRCSY=$$FIND1^DIC(101.43,,"QX",+GMRCPROC_";99PRC","ID")
 .I +GMRCSY D
 ..S @GLOBAL@(ND,0)="d"_GMRCSY_"^"_GMRCSX,ND=ND+1
 ..Q
 E  S @GLOBAL@(ND,0)="d^^"
 S @GLOBAL@(ND,0)="~TYPE",ND=ND+1
 I $L(GMRCREQ) D  I '$L(GMRCREQ) S @GLOBAL@(ND,0)="d^^"
 . S GMRCSX=$S(GMRCREQ="P":"PROCEDURE",1:"CONSULT")
 . S @GLOBAL@(ND,0)="d"_$E(GMRCSX,1)_"^"_GMRCSX_"^"_GMRCREQ
 . S GMRCSX=""
 S ND=ND+1
 S @GLOBAL@(ND,0)="~CATEGORY",ND=ND+1
 I $L(GMRCINO) D  S ND=ND+1,GMRCSX=""
 .S @GLOBAL@(ND,0)="d"_GMRCINO_"^"_$S(GMRCINO="I":"INPATIENT",1:"OUTPATIENT")_"^"
 .S @GLOBAL@(ND,0)=@GLOBAL@(ND,0)_$S(GMRCINO="I":$O(^ORD(101,"B","GMRCURGENCYM CSLT - INPATIENT",0)),1:$O(^ORD(101,"B","GMRCURGENCYM - OUTPATIENT",0)))
 .Q
 E  S @GLOBAL@(ND,0)="d^^"
 S @GLOBAL@(ND,0)="~DIAGNOSIS",ND=ND+1
 I $L(GMRCDIAG) S @GLOBAL@(ND,0)="d"_GMRCDIAG,ND=ND+1
 E  S @GLOBAL@(ND,0)="d"
 S @GLOBAL@(ND,0)="~PLACE",ND=ND+1
 I +GMRCPL D  S ND=ND+1,GMRCSX=""
 .S GMRCSX=$P($P(^ORD(101,GMRCPL,0),"^",1),"GMRCPLACE - ",2),GMRCSX=$S(GMRCSX="ON CALL":"CONSULTANTS CHOICE",1:GMRCSX),@GLOBAL@(ND,0)="d"_$E(GMRCSX,1)_"^"_GMRCSX_"^"_GMRCPL
 .Q
 E  S @GLOBAL@(ND,0)="d^^",ND=ND+1
 S @GLOBAL@(ND,0)="~ATTENTION",ND=ND+1
 I +GMRCATN S GMRCSX=$$GET1^DIQ(200,GMRCATN,.01),@GLOBAL@(ND,0)="d"_GMRCATN_"^"_GMRCSX_"^"_GMRCATN,ND=ND+1,GMRCSX=""
 E  S @GLOBAL@(ND,0)="d^^",ND=ND+1
 S @GLOBAL@(ND,0)="~CLINICALLY",ND=ND+1
 I GMRCERDT S @GLOBAL@(ND,0)="d"_"^"_GMRCERDT,ND=ND+1
 E  S @GLOBAL@(ND,0)="d^"
 S @GLOBAL@(ND,0)="~URGENCY",ND=ND+1
 I +GMRCURG S GMRCSX=$P($P(^ORD(101,GMRCURG,0),"^",1),"GMRCURGENCY - ",2),GMRCURGY=$O(^ORD(101.42,"S.GMRCO",GMRCSX,0)) I $L(GMRCSX) D
 .S GMRCSY=$O(^ORD(101.42,"B",GMRCSX,0))
 .S @GLOBAL@(ND,0)="d"_GMRCSY_"^"_GMRCSX_"^"_GMRCURG,ND=ND+1
 .S GMRCSX="" K GMRCSY
 .Q
 S @GLOBAL@(ND,0)="~DSTID",ND=ND+1
 I $G(GMRCDSID) S @GLOBAL@(ND,0)="d"_"^"_GMRCDSID,ND=ND+1
 E  S @GLOBAL@(ND,0)="d^^",ND=ND+1
 ;Get reason for request
 S @GLOBAL@(ND,0)="~REASON",ND=ND+1
 I $O(^GMR(123,+GMRCO,20,0)) S NDX=0 F  S NDX=$O(^GMR(123,+GMRCO,20,NDX)) Q:NDX=""  S @GLOBAL@(ND,0)="t"_^GMR(123,+GMRCO,20,NDX,0),ND=ND+1
 E  S @GLOBAL@(ND,0)="~REASON",ND=ND+1,@GLOBAL@(ND,0)="tREASON "
 ;Get Comments, including Deny Comments
 D SENDCOMT^GMRCGUIU(GMRCO,.ND)
 D GUIC^GMRCGUIU
 Q
