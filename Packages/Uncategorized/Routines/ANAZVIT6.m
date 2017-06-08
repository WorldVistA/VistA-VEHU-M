ANAZVIT6 ;Process routine for Welch Allyn Vitals Monitor Pilot [7/15/08 7:47am]
 ;;1.0;;;11/18/05
 ;=================================================================
 ;Routine to send ADT messages to, and process result messages from Welch Allyn Vitals monitors and store results in the Vitals Package.
 ;==================================================================
 ;Added code to get Provider DUZ from 11th piece of OBX 7/8/08.
EN ; Entry Point for Message Array in MSG to process results.
 K MSG,ERRTX
 N X,J,I,PID,ZNUM,VADM,ZZY,ZDUZ
 S (RES,BP,HR,TEMP,PO2,PN,RESP,HT,WT,BMI,MAP,ZDUZ)=""
 S (TQL,TQLZ,PQSZ,PQMZ,PQM,PQPZ,PQP,RQM,RQMZ,RQPZ,RQP,BPQL,BPQLZ,BPQPZ,BPQP,BPQCSZ,BPQCS,HTQQ,HTQQZ,WTQQ,WTQQZ,WTQMZ,WTQM,SPO2MZ,FLOW,CONC)=""  ;SET QUALIFIERS TO NULL
 ;Read the entire message and store into the array MSG
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S MSG(I)=HLNODE Q:+I'>0   D
 .S Z=$P(MSG(I),"|") D
 ..I $L(Z)>3 S Z=$E(Z,$L(Z)-2,$L(Z))
 ..I Z="MSH" D MSH
 ..I Z="PID" D PID
 ..I Z="OBR" D OBR
 ..I Z="OBX" D OBX
 S ZSTR=SSN_"^"_TEMP_"^"_HR_"^"_RESP_"^"_BP_"^"_HT_"^"_WT_"^"_ZDATE_"^"_PN_"^"_PO2_"^"_ZDUZ
 D LOAD
 D ACK("Received by VistA")
 Q
MSH ; Decode MSH
 K SEG
 S HLFS=HL("FS"),HLCOMP=$E(HL("ECH"))
 Q:'$D(MSG(I))
 S X=$G(MSG(I))
 I $E(X,1,3)'="MSH" S ERRTX="MSH not first record" D NAK
 Q
CVT ; Convert to FM date
 Q:ZDATE=""
 S ZYR=$E(ZDATE,1,4)-1700,ZTIME=$E(ZDATE,9,$L(ZDATE))
 I $L(ZTIME)=5 S ZTIME=0_ZTIME
 S ZHR=$E(ZTIME,1,2),MIN=$E(ZTIME,3,4),SEC=$E(ZTIME,5,6)
 S ZTIME=ZHR_MIN_SEC
 S ZDATE=ZYR_$E(ZDATE,5,8)
 I ZTIME,$E(ZTIME,1,2)=24 S X1=ZDATE,X2=1 D C^%DTC S ZDATE=X,ZTIME="0001"
 K X1,X2
 S ZDATE=ZDATE_$S(ZTIME:"."_ZTIME,1:"")
 Q
PID ;Check PID Need SSN
 S X=MSG(I)
 S ZNAM=$P(X,HLFS,6),SSN=$P(X,HLFS,20) I SSN="" S SSN=$P(X,HLFS,4)
 S SSN=$P(SSN,HLCOMP,1) I SSN'?9N S SSN=$TR(SSN,"- ","")
 S:SSN'?9N SSN=" " S DFN=$O(^DPT("SSN",SSN,0))
 I 'DFN S ERRTX="SSN "_SSN_" not found in patient file. Please check data and resend." D NAK
 Q
OBR ;Get date/time vitals taken from OBR
 ;Added code to set ZDUZ in OBR if found 7/8/08 
 S X=MSG(I),ZDUZ=0
 S ZDATE=$P(X,HLFS,8),ZDUZ=$P(X,HLFS,11)
 D CVT
 Q
OBX ;Check OBX segments and set variables.
 S X=MSG(I)
 S SEG=$P(X,HLFS,4),ZSEG=$P(SEG,"^",1),RES=$P(X,HLFS,6)
 I ZDUZ<1 S ZDUZ=$P($P(X,HLFS,17),"^",2)
 I ZSEG="SYS" S BP=RES
 I ZSEG="DIA" S BP=BP_"/"_RES
 I ZSEG="BPSITE" S BPQL=RES,BPQLZ=$S(RES="L Arm":2,RES="R Arm":1,RES="L Leg":4,RES="R Leg":3,1:"")
 I ZSEG="BPPP" S BPQP=RES,BPQPZ=$S(RES="Lying":52,RES="Sitting":50,RES="Standing":51,1:"")
 I ZSEG="BPCUFF" S BPQCS=RES,BPQCSZ=$S(RES="Child":112,RES="Sm. Adult":116,RES="Adult":93,RES="Lg. Adult":107,RES="Thigh":119,1:"")
 I ZSEG="HR" S HR=RES
 I ZSEG="HRSITE" S PQS=RES,PQSZ=$S(RES="Left":63,RES="Right":62,1:"")
 I ZSEG="HRMETH" S PQM=RES,PQMZ=$S(RES="Auscultate":61,RES="Doppler":60,RES="Palpated":59,1:"")
 I ZSEG="HRPP" S PQP=RES,PQPZ=$S(RES="Lying":52,RES="Sitting":50,RES="Standing":51,1:"")
 I ZSEG="TEMP" S TEMP=RES
 I ZSEG="TEMPSITE" S TQL=RES,TQLZ=$S(RES="Axillary":5,RES="Oral":6,RES="Rectal":7,RES="Tympanic":45,1:"")
 I ZSEG="SPO2" S PO2=RES
 I ZSEG="SPO2METH" S SPO2M=RES,SPO2MZ=$S(RES="Aerosol/humidified mask":83,RES="Face tent":82,RES="Mask":80,RES="Nasal cannula":84,RES="Non re-breather":85,RES="Partial re-breather":86,RES="T-piece":81,1:"") D
 .S:SPO2MZ="" SPO2MZ=$S(RES="Tracheostomy collar":87,RES="Ventilator":88,RES="Venturi mask":89,RES="Room air":114,RES="Oxymizer":91,1:"")
 I ZSEG="SPO2FLOW" S FLOW=RES
 I ZSEG="SPO2CONC" S CONC=RES
 I ZSEG="PAIN" S PN=RES
 I ZSEG="RESP" S RESP=RES
 I ZSEG="RESPMETH" S RQM=RES,RQMZ=$S(RES="Assisted ventilator":49,RES="Controlled ventilator":48,RES="Spontaneous":47,1:"")
 I ZSEG="RESPPP" S RQP=RES,RQPZ=$S(RES="Lying":52,RES="Sitting":50,RES="Standing":51,1:"")
 I ZSEG="HT" S HT=RES
 I ZSEG="HTQUAL" S HTQQ=RES,HTQQZ=$S(RES="Actual":42,RES="Estimated":43,1:"")
 I ZSEG="WT" S WT=RES
 I ZSEG="WTQUAL" S WTQQ=RES,WTQQZ=$S(RES="Actual":42,RES="Dry":44,RES="Estimated":43,1:"")
 I ZSEG="WTMETH" S WTQM=RES,WTQMZ=$S(RES="Bed":72,RES="Chair":71,RES="Standing":117,1:"")
 I ZSEG="BMI" S BMI=RES
 I ZSEG="MAP" S MAP=RES
 Q
CHECK ;Check qualifiers
 ;I FLAG=1 S ^JCG("CHK",ZM)=GMRSITE(X)_"^"_DA
 Q
LOAD ;Load vitals to file 120.5
 N I,X,Y,%,%H,%I,%DT,ZD,ZLOC,ZZY,DA,DFN,DIK,GDATE,GLAST,GMRDAT
 N GMRDATE,GMREDB,GMRENTY,GMRSITE,GMRSTR,GMRVHLOC,GMRVIDT,GMRVIT
 N GMRVITY,GMRVLST,GMRX
 S X=$P(ZSTR,U)
 I X="" S ZSTR(1)="NO SSN REQUESTED" Q
 D DFN I DFN="" S ZSTR(0)="INCORRECT SSN" Q
 D IN5^VADPT S ZLOC=$P(VAIP(5),U,2)
 S GMRVHLOC="" S:ZLOC'="" GMRVHLOC=$O(^SC("B",ZLOC,0))
 S:GMRVHLOC="" GMRVHLOC=6637  ; SET DEFAULT INPATIENT LOCATION (REMOVE FROM PRODUCTION CODE)
 S ZD=$$NOW^XLFDT,GMRVIDT=$P(ZSTR,U,8)
 ;This is loaded into variable GMRDAT
 S GMREDB="P",GMRENTY=3,GLAST(1)=0
 F ZM=2,3,4,5,6,7,9,10 S ZZ=$P(ZSTR,U,ZM) D:ZZ]""
 .I ZM=2 S X="T",GMRSITE("T")=TEMP_"^"_TQL D
 ..I TQL]"" S GMRINF("T",1,0)=TQLZ_"^"_TQL
 .I ZM=3 S X="P",GMRSITE("P")=HR_"^"_PQSZ D
 ..I PQM]"" S GMRINF("P",1,0)=PQMZ_"^"_PQM
 ..I PQP]"" S GMRINF("P",1,1)=PQPZ_"^"_PQP
 .I ZM=4 S X="R",GMRSITE("R")=RQM_"^"_RQMZ D
 ..I RQPZ]"" S GMRINF("R",1,0)=RQPZ_"^"_RQP
 .I ZM=5 S X="BP",GMRSITE("BP")=BPQL_"^"_BPQLZ D
 ..I BPQPZ]"" S GMRINF("BP",1,0)=BPQPZ_"^"_BPQP
 ..I BPQCSZ]"" S GMRINF("BP",1,1)=BPQCSZ_"^"_BPQCS
 .I ZM=6 S X="HT",GMRSITE("HT")=HTQQ_"^"_HTQQZ
 .I ZM=7 S X="WT",GMRSITE("WT")=WTQQ_"^"_WTQQZ D
 ..I WTQMZ]"" S GMRINF("WT",1,0)=WTQMZ_"^"_WTQM
 .I ZM=9 S X="PN",GMRSITE("PN")=""
 .I ZM=10 S X="PO2",GMRSITE("PO2")=PO2_"^"_SPO2MZ D
 ..I FLOW]"" D
 ...S:$P(FLOW,".",2)="" FLOW=FLOW_".0"
 ..S GMRO2(X)=FLOW_" l/min "_CONC_"%"
 .S GMRDAT(X)=ZZ,GMRSTR(0)=";"_X_";",B=ZM
 .S ZZDUZ=DUZ,DUZ=$P(ZSTR,U,11)
 .N I D EN4^GMRVED2
 .I $G(DA)]"" S DIK="^GMR(120.5," D IX1^DIK ;  SET CROSS REFERENCES IN THE VITALS FILE
 .S DUZ=ZZDUZ
 S ZZY="DONE"
 D KVA^VADPT
 ;CLEAN UP VARIABLES
 K RES,BP,HR,TEMP,PO2,PN,RESP,HT,WT,BMI,MAP,ZDUZ,X,Z,J,B,I,PID,ZNUM,VADM,ZZY
 K TQL,TQLZ,PQSZ,PQMZ,PQM,PQPZ,PQP,RQM,RQMZ,RQPZ,RQP
 K BPQL,BPQLZ,BPQPZ,BPQP,BPQCSZ,BPQCS,HTQQ,HTQQZ,WTQQ,WTQQZ,WTQMZ,WTQM,SPO2MZ,FLOW,CONC
 K ZSTR,SSN,ZDATE,ZYR,ZTIME,HR,MIN,SEC,ZNAM,ZSEG,DFN,ZLOC,ZD,ZM,ZZ,GMRSITE("T"),GMRINF("T",1,0),GMRSITE("P"),GMRINF("P",1,0),GMRINF("P",1,1),GMRSITE("R"),GMRINF("R",1,0)
 K GMRSITE("BP"),GMRINF("BP",1,0),GMRINF("BP",1,1),GMRSITE("HT"),GMRSITE("WT"),GMRINF("WT",1,0)
 K GMRSITE("PN"),GMRSITE("PO2"),GMRO2("PO2"),GMRSTR(0),ZZDUZ
 Q
 ;
DFN ;Get DFN for patient from SSN
 S DFN=$O(^DPT("SSN",X,0))
 Q
 ;
ACK(VITMSG) ;Acknowledge message processing
 N RES,FS,AT
 S HLA("HLA",1)="MSA"_"^"_"AA"_"^"_HL("MID")_"^"_VITMSG
 S RES=""
 S AT="LM"
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),AT,1,.RES)
 Q
NAK ;Acknowledge message processing error
 N RES,FS,AT
 S HLA("HLA",1)="MSA"_HL("FS")_"AE"_HL("FS")_HL("MID")_HL("FS")_ERRTX
 S RES=""
 S AT="LM"
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),AT,1,.RES)
 I +$P(RES,"^",2) D
 .S ^JCG("VITALE","AE",$J)=HLMTIENS
 Q
 ;
REC1 ;Internal Appl ADT processing routine
 ;Processing routine for VITALS-INT-A0x-SUB client protocols.
 ;Modifies class 1 message
 ;Generates a new HL7 message to VITALS-EXT-A0x-EV
 ;
 N ARHQFL,HLNODE,KK,ZZF,ZZC,ZZR,ARHEVTYP
 ;
 ;Separators
 S ZZF=HL("FS")
 S ZZC=$E(HL("ECH"),1)
 S ZZR=$E(HL("ECH"),2)
 ;
 S ARHFL=0,ARHQFL=0
 ;
 D ADTMOD
 ;
 ;Quit if outpatient message
 ;Q:ARHQFL>0
 N ZTRTN,ZTSK,ZTSAVE,ZTDTH,ZTDESC,ZTIO
 S ZTREQ="@"
 S ZTSAVE("HLA(")="",ZTSAVE("ZTREQ")=""
 S ZTSAVE("ARHEVTYP")=""
 S ZTSAVE("ARHQFL")=""
 S ZTRTN="SEND1^ANAZVIT1"
 S ZTDTH=$H,ZTIO="",ZTDESC="REC1 ROUTINE"
 D ^%ZTLOAD
 ;
 D ACK("Received by ANAZVIT1 REC1")
 Q
 ;
ADTMOD ;Change   the ADT message
 N ARHDFN,ZSN,ZVN,ZVD,JJ,KK
 S KK=0
 F JJ=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I $E(HLNODE,1,3)="MSH" Q
 .S KK=KK+1
 .S HLA("HLS",KK)=HLNODE
 .;
 .;Event type need to kick off correct event protocol for MARQUETTE-INT
 .I $E(HLNODE,1,3)="EVN" D  Q
 ..S ARHEVTYP=$P(HLNODE,ZZF,2)
 ..;S HLA("HLS",KK)=HLNODE
 .;
 .I $E(HLNODE,1,3)="PID" D  Q
 ..S ARHDFN=$P($P(HLNODE,ZZF,4),ZZC,1),ZSN=$P(^DPT(ARHDFN,0),"^",9)
 ..I ARHEVTYP="A08" D
 ...S DFN=ARHDFN D INP^VADPT
 ...;I VAIN(1)="" S ARHQFL=1 Q 
 ...S HLNODE=HLNODE_"^^^^^^^^^^"
 ...I $P(HLNODE,ZZF,20)="" S $P(HLNODE,ZZF,20)=ZSN
 ...S HLA("HLS",KK)=HLNODE
 .;
 .I $E(HLNODE,1,3)="PV1" D  Q
 ..D PV1
 ..S:ZVN>0 $P(HLNODE,ZZF,20)=ZVN
 ..S HLA("HLS",KK)=HLNODE
 .;
 .I $E(HLNODE,1,3)="ZPD" D  Q
 ..S DD=$P(HLNODE,ZZF,10)
 ;
 Q
 ;
PV1 ; Add Visit # to 19th piece
 S ZVD=0,ZVN=0,ZVD=$O(^AUPNVSIT("AA",ARHDFN,ZVD)) Q:+ZVD'>0  D
 .S ZVN=$O(^AUPNVSIT("AA",ARHDFN,ZVD,ZVN))
 Q
SEND1 ;Called by REC1 to send modified ADT HL7 message to CONNEX
 N ARHIEN,HL,HLP,ARHSRVP,II
 S ARHSRVP="VITALS-INT-"_$G(ARHEVTYP)_"-EV"
 S ARHIEN=$O(^ORD(101,"B",ARHSRVP,0))
 D INIT^HLFNC2(ARHIEN,.HL)
 I $O(HL(""))="" D  Q
 .W !,"Init in Part 2 failed!"
 S HLP("PRIORITY")="I"
 D GENERATE^HLMA(ARHIEN,"LM",1,.HLRST,"",.HL)
 W !,"Finished sending message from internal application."
 Q
 ;
KIL ; Kill Variables
 K MSG,DFN,SEG Q
 Q
