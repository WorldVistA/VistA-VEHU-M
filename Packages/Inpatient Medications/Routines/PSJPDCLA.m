PSJPDCLA ;BIR/MA/MC - PADE HL7 - CLINIC CHECK ;07/08/15
 ;;5.0;INPATIENT MEDICATIONS;**317,337,362,432**;16 DEC 97;Build 18
 ;Reference to EN^VAFCPID supported by DBIA 3015
 ;Reference to IN^VAFHLPV1 supported by DBIA 3018
 ;Reference to $$PIVCHK^VAFHPIVT supported by DBIA 6606
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;Reference to ^PS(52.6 supported by DBIA 1231
 ;Reference to ^PS(52.7 supported by DBIA 2173
 ;Reference to ^DIC(42 supported by DBIA 10039
 ;Reference to ^ORD(101 supported by DBIA 872
 ;Reference to ^SC supported by DBIA 10040
 ;Reference to ^DPT supported by DBIA 10035
 ;Reference to ^PSDRUG supported by DBIA 2192
 ;Reference to ^SRF supported by DBIA 103
 ;Reference to ^SRS supported by DBIA 3362
 Q
 ;
EN ; Get SDAM Message and send to PADE.
 Q:$G(SDAMEVT)'=4!($P($G(SDATA),"^",4)<1)
 N PSJAP S PSJAP=0
EN1 ;
 Q:'$P($$SEND^VAFHUTL(),"^",2)
 Q:$O(^PS(58.7,"B",""))=""
 N I,J S I=0
 F  S I=$O(^PS(58.7,I)) Q:'I  S J=$$PDACT(I)
 Q:'PSJAP
 Q:$G(PSJPA)
 Q:'$G(HLEID)
 I $G(HL("ETN"))="" D INIT^HLFNC2(HLEID,.HL) Q:$D(HL)=1
 N FS,ECH S FS=HL("FS"),ECH=$E(HL("ECH"),1)
 N SNM,CNM S SNM="PSJ SIU-S12 SERVER",CNM="PSJ SIU-S12 CLIENT"
 Q:'$O(^ORD(101,"B",SNM,0))
 Q:'$O(^ORD(101,"B",CNM,0))
 D INIT^HLFNC2(SNM,.NHL) Q:$D(NHL)=1
 N NFS,NECH,HLFS,HLECH,Y S (HLFS,NFS)=NHL("FS"),NECH=$E(NHL("ECH"),1)
 N PSJX,PSJQ,NSEG,SEQ,PSJORN,PSJOR,PSJDTM,PSJDIV,PSJDNM,PSJPV50,PDL
 S (PSJQ,SEQ)=0,PSJX=1,(PSJPV50,PSJORN)=""
 F I=1:1 X HLNEXT Q:HLQUIT'>0!(PSJORN]"")  D
 . I $E(HLNODE,1,3)="PV1" S PSJORN=$P(HLNODE,FS,4),PSJPV50=$P(HLNODE,FS,51)
 Q:PSJORN=""
 D CHKINPF
 Q:'$O(PSJAP(0))
 N PSJBAP,FTS M PSJBAP=PSJAP
 K NSEG N PSJQW,PSJNIP S PSJNIP=0,FTS=""
 I $P($G(^DPT(DFN,.1)),"^")]"" D
 . D IN5^VADPT
 . N PSJQ,PSJWD,PSJRBD
 . S PSJWD=$P(VAIP(5),"^",2),PSJRBD=$P(VAIP(6),"^",2)
 . S PSJQ=$$CHKPD^PSJPDCL(PSJWD,PSJRBD)
 . I 'PSJQ S PSJNIP=1 Q
 . M PSJQW=PSJQ
 . S FTS=$P(VAIP(8),"^")_NECH_$P(VAIP(8),"^",2)
 M PSJAP=PSJBAP
 K PSJQ S PSJQ=$$CHKPDCL(PSJORN)
 Q:'PSJQ
 S PSJDTM=$G(HLP("DT"))
 S PSJOR=$O(^SC("B",PSJORN,0))
 S PSJDIV=+$P($G(^SC(PSJOR,0)),"^",15)
 S PSJDNM=$P($$SITE^VASITE(,PSJDIV),"^",3)
 S ZTIO=""
 S ZTRTN="CLCI^PSJPDCLA"
 F XX="PSJPV50","PSJQ(","PSJOR","PSJORN","PSJDTM","PSJDIV","PSJDNM","DFN","PSJQW(","NHL(","SNM","CNM","FTS" S ZTSAVE(XX)=""
 S ZTDESC="Send PADE HL7 Checkin Message"
 S ZTDTH=$H
 D ^%ZTLOAD
 Q
 ; 
CLCI ;
 N XX,ZZ1 S XX=0 F  S XX=$O(PSJQ(XX)) Q:'XX  D
 . S PSJND=$G(^PS(58.7,XX,0))
 . S PSJVNM=$P(PSJND,"^"),PSJDNS=$P(PSJND,"^",2),PSJVP=$P(PSJND,"^",3)
 . S ZZ1="",PSJNIP=0
 . ;I 'PSJNIP,$P(PSJND,"^",6)'="Y" Q
 . I $P($G(^DPT(DFN,.1)),"^")]"",$P(PSJND,"^",6)'="Y" Q  ;*362 - if inpatient and the flag SEND CHECKIN/SURG HL7 FOR INPT is not "Y" then quit
 . I $D(PSJQW(XX)),$P(PSJQW(XX),"^",2)'="" S ZZ1=$P(PSJQW(XX),"^",2)
 . I '$D(PSJQW(XX)) S PSJNIP=1
 . S (HLFS,NFS)=NHL("FS"),NECH=$E(NHL("ECH"),1),HLECH=NHL("ECH")
 . K NSEG S SEQ=0 N HL M HL=NHL D SRBLD N ZZ2 S ZZ2=$S($P(PSJQ(XX),"^",2)'="":$P(PSJQ(XX),"^",2),1:"")
 . S SEQ=SEQ+1,NSEG(SEQ)="ZZZ"_HL("FS")_$S(ZZ1'="":ZZ1,1:"")_HL("FS")_ZZ2_HL("FS")_FTS
 . K HLP,HLA S HLP="",HLP("SUBSCRIBER")="^^^^~"_PSJDNS_":"_PSJVP_"~DNS"
 . D PV19^PSJPDAPP M HLA("HLS")=NSEG
 . D GENERATE^HLMA(SNM,"LM",1,.PSJSND,"",.HLP)
 . D LOG^PSJPADE
 . ;check for O11 re-send
 . D GETPSARS^PSJPDAPP(XX,DFN,3)  ; Build PADE clinics/send areas per parameter info
 . D RESNDORDS^PSJPDCLA(DFN,PSJOR,PSJDIV,XX,2) ; Resend all orders for the input CLINIC's SEND AREA
 D KILLTMP^PSJPDAPP
 Q
 ;
SEND ;
 N XX,PSJND,PSJVNM,PSJDNS,PSJVP,VR,HLA,CT
 M HLA("HLS")=NSEG
 D INIT^HLFNC2(SNM,.HL) Q:$D(HL)=1
 S XX=0,CT=$O(NSEG(9999),-1)+1
 F  S XX=$O(PSJQ(XX)) Q:'XX  D   ;sends HL7 message for each PADE SERVER
 .S PSJND=$G(^PS(58.7,XX,0))
 .Q:PSJND=""
 .S PSJVNM=$P(PSJND,"^"),PSJDNS=$P(PSJND,"^",2),PSJVP=$P(PSJND,"^",3)
 .Q:PSJVNM=""!(PSJDNS="")!('PSJVP)
 .N HLP,PSJSND S HLP=""
 .S HLP("SUBSCRIBER")="^^^^~"_PSJDNS_":"_PSJVP_"~DNS"
 .I '$D(HL) M HL=NHL
 .N ZZ2,ZZ1 S ZZ2=$P(PSJQ(XX),"^",2)
 .S ZZ1=$S($P($G(PSJQS(XX)),"^",2)]"":$P($G(PSJQS(XX)),"^",2),1:"")
 .S NSEG(CT)="ZZZ"_HL("FS")_ZZ1_HL("FS")_ZZ2_HL("FS")_FTS
 .D PV19^PSJPDAPP
 .K HLA M HLA("HLS")=NSEG
 .D GENERATE^HLMA(SNM,"LM",1,.PSJSND,"",.HLP)
 .D LOG^PSJPADE
 Q
 ;
TR(SEG) ; Translate the VAFC message delimiters to HL7 delimiters for PADE
 N CSEG
 S CSEG=$TR(SEG,HL("FS")_HL("ECH"),NHL("FS")_NHL("ECH"))
 S CSEG=$TR(CSEG,"""","")
 Q CSEG
 ;
PDACT(PSJPD) ;
 Q:'$D(^PS(58.7,PSJPD,0)) 0
 N PSJVNM,PSJDNS,PSJVP,PSJACT,PSJND S PSJND=$G(^PS(58.7,PSJPD,0))
 S PSJVNM=$P(PSJND,"^"),PSJDNS=$P(PSJND,"^",2),PSJVP=$P(PSJND,"^",3)
 I PSJVNM=""!(PSJDNS="")!('PSJVP) Q 0
 S PSJACT=$P(PSJND,"^",4)
 I PSJACT&(PSJACT<DT) Q 0
 S PSJAP(PSJPD)="",PSJAP=1
 Q 1
 ;
CHKPDCL(PSJCL) ;
 N PSJCLI S PSJCLI=$S($G(PSJPDO):PSJCL,1:$O(^SC("B",PSJCL,"")))
 Q:'PSJCLI 0
 N PSJDIV S PSJDIV=+$P($G(^SC(PSJCLI,0)),"^",15)
 Q:'PSJDIV 0
 S PSJCL=$P(^SC(PSJCLI,0),"^")
 N PSJPD,PSJSAR S (PSJQ,PSJPD)=0
 F  S PSJPD=$O(^PS(58.7,"AD",PSJDIV,PSJPD)) Q:'PSJPD  D
 . Q:'$D(PSJAP(PSJPD))
 . N DN S DN=$G(^PS(58.7,PSJPD,"DIV",PSJDIV,0)) Q:DN=""
 . N DC S DC=$P(DN,"^",2)
 . I DC&(DC<DT) Q  ;DIV INACTIVE
 . I $G(PSJPDO)=1 N I S I=0 D  Q:I 
 .. I $P($G(^(2)),"^")'="Y" S I=1 Q  ;DON'T SEND ORDER MESSAGES
 .. I $G(RXO)["V",$P(DN,"^",7)'="Y" S I=1 Q  ;DON'T SEND CLINIC IV
 .. I $G(RXO)["V" I ($P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,3)),"^")="Y"),('$$CSIV) S I=1 Q  ;CS ONLY
 .. I $G(RXO)["U" I ($P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,3)),"^")="Y"),('$$CSUD) S I=1 Q  ;CS ONLY
 . S PSJX=0
 . S PSJSAR=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"CL","B",PSJCLI,0))
 . I PSJSAR D
 .. S PSJSAR=$P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,"CL",PSJSAR,0)),"^",2)
 .. S:PSJSAR PSJSAR=$P($G(^PS(58.71,PSJSAR,0)),"^")
 .. S PSJQ(PSJPD)=1_$S(PSJSAR]"":"^"_PSJSAR,1:""),(PSJQ,PSJX)=1
 . Q:PSJX
 . S PSJSAR=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"PCG","C",PSJCLI,0))
 . I PSJSAR D
 .. S PSJSAR=$P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,"PCG",PSJSAR,0)),"^",2)
 .. S PSJSAR=$P($G(^PS(58.71,PSJSAR,0)),"^") S:PSJSAR]"" PSJQ(PSJPD)="1^"_PSJSAR,(PSJQ,PSJX)=1
 . Q:PSJX
 . I $O(^PS(57.8,"AC",PSJCLI,0)) D
 .. S PSJSAR=$O(^PS(57.8,"AC",PSJCLI,0))
 .. S PSJSAR=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"VCG","B",PSJSAR,0))
 .. Q:'PSJSAR
 .. S PSJSAR=$P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,"VCG",PSJSAR,0)),"^",2)
 .. S:PSJSAR PSJSAR=$P($G(^PS(58.71,PSJSAR,0)),"^")
 .. S PSJQ(PSJPD)="1"_$S(PSJSAR]"":"^"_PSJSAR,1:""),(PSJQ,PSJX)=1
 . Q:PSJX
 . S PSJSAR=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"WCN","B",0)) I PSJSAR'="" D
 .. N PSJWC,PSJLEN S PSJWC="" F  S PSJWC=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"WCN","B",PSJWC)) Q:PSJWC=""  D
 ... I $E(PSJCL,1,$L(PSJWC))=PSJWC S PSJLEN($L(PSJWC),PSJWC)=""
 .. I $D(PSJLEN) D
 ... S PSJSAR=$O(PSJLEN(999),-1)
 ... S PSJSAR=$O(PSJLEN(PSJSAR,0))
 ... S PSJSAR=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"WCN","B",PSJSAR,0))
 ... S PSJSAR=$P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,"WCN",PSJSAR,0)),"^",2)
 ... S:PSJSAR PSJSAR=$P($G(^PS(58.71,PSJSAR,0)),"^")
 ... S PSJQ(PSJPD)="1"_$S(PSJSAR]"":"^"_PSJSAR,1:""),(PSJQ,PSJX)=1
 . Q:PSJX
 . I $P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,0)),"^",3)="Y" D
 .. S PSJSAR=$P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,0)),"^",4)
 .. S:PSJSAR PSJSAR=$P($G(^PS(58.71,PSJSAR,0)),"^")
 .. S PSJQ(PSJPD)="1"_$S(PSJSAR]"":"^"_PSJSAR,1:""),PSJQ=1
 Q PSJQ
 ;
CHKINPF ;
 N VAIP D IN5^VADPT Q:'VAIP(5)
 N PSJDIV S PSJDIV=+$P($G(^DIC(42,+VAIP(5),0)),"^",11)
 Q:'PSJDIV
 N PSJPD S PSJPD=0
 F  S PSJPD=$O(^PS(58.7,"AD",PSJDIV,PSJPD)) Q:'PSJPD  D
 . Q:'$D(PSJAP(PSJPD))
 . I $P(^PS(58.7,PSJPD,0),"^",6)'="Y" K PSJAP(PSJPD) Q   ;SEND CHECKIN/SURG HL7 FOR INPT
 . N DN S DN=$G(^PS(58.7,PSJPD,"DIV",PSJDIV,0)) I DN="" K PSJAP(PSJPD) Q
 . N DC S DC=$P(DN,"^",2)
 . I DC&(DC<DT) K PSJAP(PSJPD) Q  ;DIV INACTIVE
 Q
 ;
SRCS ;Surgery case nightly task
 N PSJAP,PSJPA S PSJAP=0,PSJPA=1 D EN1 I 'PSJAP W !!,"PADE not setup - Quitting..." Q
 N SNM,CNM S SNM="PSJ SIU-S12 SERVER",CNM="PSJ SIU-S12 CLIENT"
 I '$O(^ORD(101,"B",SNM,0))!('$O(^ORD(101,"B",CNM,0))) W !!,"PADE HL7 Protocols are not setup - Quitting..." Q
 K %DT
 S %DT(0)=DT,%DT("B")="T",%DT("A")="Enter date of Surgery cases to send to PADE: "
 S %DT="EPXA" D ^%DT Q:Y<0
 N SDT,BDT,EDT
 S SDT=Y K %DT
 S BDT=SDT-.1,EDT=SDT+.9,BDT=$O(^SRF("AC",BDT))
 I 'BDT!(BDT>EDT) W !,"No data to send for the given date - Quitting..." Q
 K DIR S DIR("B")="NO",DIR(0)="Y",DIR("A")="Do you want to continue"
 D ^DIR Q:Y<1
 S ZTDTH="",ZTRTN="TASK^PSJPDCLA",ZTDESC="Surgery appt. sent to PADE",ZTIO=""
 F XX="PSJAP(","SDT","EDT","SNM","CNM" S ZTSAVE(XX)=""
 D ^%ZTLOAD W:$D(ZTSK) !!,"Task Queued !",! K ZTSK,ZTIO S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
TASK ;
 I $G(PSJTASK) N PSJAP,PSJPA S PSJAP=0,PSJPA=1 D EN1 Q:'PSJAP  N SNM,CNM D  Q:'PSJAP
 .S SNM="PSJ SIU-S12 SERVER",CNM="PSJ SIU-S12 CLIENT"
 .S:'$O(^ORD(101,"B",SNM,0))!('$O(^ORD(101,"B",CNM,0))) PSJAP=0
 N NHL D INIT^HLFNC2(SNM,.NHL) Q:$D(NHL)=1
 N NFS,NECH,HL,BDT,DFN,PSJPD,PSJDIV,PSJDNM,PSJOR,PSJORN,PSJT,PSJQ,SEQ,PSJSAR,NSEG,PSJDTM,II,PSJNIP,PSJBAP,FTS
 M HL=NHL,PSJBAP=PSJAP S (NFS,HLFS)=HL("FS"),NECH=$E(HL("ECH"),1)
 I '$G(SDT) N SDT S SDT=DT
 S BDT=SDT-.1,EDT=SDT+.9
 F  S BDT=$O(^SRF("AC",BDT)) Q:'BDT!(BDT>EDT)  D
 .S II=0 F  S II=$O(^SRF("AC",BDT,II)) Q:'II  D
 ..S DFN=+$G(^SRF(II,0)) Q:'DFN
 ..Q:$P($G(^SRF(II,30)),"^")]""  ;cancel node
 ..S PSJOR=+$P(^SRF(II,0),"^",2)
 ..Q:'PSJOR
 ..S PSJDTM=$P($G(^SRF(II,31)),"^",4) Q:'PSJDTM
 ..S PSJOR=$P($G(^SRS(PSJOR,0)),"^")
 ..Q:'PSJOR
 ..S PSJDIV=+$P($G(^SC(PSJOR,0)),"^",15)
 ..Q:'PSJDIV  S PSJDNM=$P($$SITE^VASITE(,PSJDIV),"^",3) Q:PSJDNM=""
 ..S PSJORN=$P(^SC(PSJOR,0),"^"),PSJNIP=0,FTS=""
 ..K PSJT,PSJQ M PSJT=PSJAP
 ..S (SEQ,PSJPD)=0 K NSEG
 ..F  S PSJPD=$O(^PS(58.7,"AD",PSJDIV,PSJPD)) Q:'PSJPD  D
 ...Q:'$D(PSJT(PSJPD))
 ...I $P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,0)),"^",8)'="Y" K PSJT(PSJPD) Q
 ...I $P($G(^DPT(DFN,.1)),"^")]""&($P(^PS(58.7,PSJPD,0),"^",6)'="Y") K PSJT(PSJPD) Q
 ...S PSJSAR=$O(^PS(58.7,PSJPD,"DIV",PSJDIV,"OR","B",PSJOR,0))
 ...I 'PSJSAR K PSJT(PSJPD) Q
 ...S PSJSAR=$P($G(^PS(58.7,PSJPD,"DIV",PSJDIV,"OR",PSJSAR,0)),"^",2)
 ...S:PSJSAR PSJSAR=$P($G(^PS(58.71,PSJSAR,0)),"^")
 ...S PSJQ(PSJPD)=1_$S(PSJSAR]"":"^"_PSJSAR,1:""),PSJQ=1
 ..Q:'$O(PSJQ(""))
 ..N PSJQS I $P($G(^DPT(DFN,.1)),"^")]"" D
 ...N PSJQ,PSJWD,PSJRBD
 ...D IN5^VADPT
 ...S PSJWD=$P(VAIP(5),"^",2),PSJRBD=$P(VAIP(6),"^",2)
 ...S PSJQ=$$CHKPD^PSJPDCL(PSJWD,PSJRBD)
 ...M PSJAP=PSJBAP
 ...I 'PSJQ S PSJNIP=1 Q
 ...M PSJQS=PSJQ
 ...S FTS=$P(VAIP(8),"^")_NECH_$P(VAIP(8),"^",2)
 ..D SRBLD,SEND
 Q
 ;
SRBLD ;
 N SEG,VAFSTR,EVNTHL7,EVNTDATE,VAFPID,HLQ
 S VAFSTR="1,5,7,8,19",HLQ=""
 N VAFPID,M
 S VAFPID=$$EN^VAFCPID(DFN,VAFSTR)
 S SEQ=SEQ+1
 S NSEG(SEQ)=$TR(VAFPID,"""""","")
 S M=$O(VAFPID(0)) I M S NSEG(SEQ,M)=$TR(VAFPID(M),"""""","")
 S VAFSTR=",2,3,10,18,21,39"
 I $G(PSJNIP) S VAFSTR=",2,10,18,21,39"
 S SEG=$$IN^VAFHLPV1(DFN,"",VAFSTR,"","",1,"")
 S SEG=$TR(SEG,"""""","")
 S:$P(SEG,HLFS,4)="" $P(SEG,HLFS,3)="O"
 S $P(SEG,HLFS,12)=PSJORN,$P(SEG,HLFS,40)=PSJDNM
 S:$G(PSJPV50) $P(SEG,HLFS,51)=PSJPV50
 S SEQ=SEQ+1
 S NSEG(SEQ)=SEG
 D AGY^PSJPDCL
 D SCH
 Q
 ;
DIVCHK(DIV) ;
 N PSJPD
 F  S PSJPD=$O(^PS(58.7,"AD",DIV,PSJPD)) Q:'PSJPD  D
 . Q:'$D(PSJAP(PSJPD))
 Q
 ;
CSIV() ;
 N J,SCH,DIN,QQ S (J,SCH,QQ)=0 F  S J=$O(^PS(55,DFN,"IV",+RXO,"AD",J)) Q:'J!(QQ)  D
 . S DIN=$P($G(^PS(55,DFN,"IV",+RXO,"AD",J,0)),"^")
 . S DIN=$P($G(^PS(52.6,DIN,0)),"^",2) Q:DIN=""
 . S SCH=$P($G(^PSDRUG(DIN,0)),"^",3)
 . I SCH["2"!(SCH["3")!(SCH["4")!(SCH["5") S QQ=1
 Q:QQ 1
 S J=0 F  S J=$O(^PS(55,DFN,"IV",+RXO,"SOL",J)) Q:'J!(QQ)  D  Q:QQ
 . S DIN=$P($G(^PS(55,DFN,"IV",+RXO,"SOL",J,0)),"^")
 . S DIN=$P($G(^PS(52.7,J,0)),"^",2) Q:DIN=""
 . S SCH=$P(^PSDRUG(DIN,0),"^",3)
 . I SCH["2"!(SCH["3")!(SCH["4")!(SCH["5") S QQ=1
 Q QQ
 ;
CSUD() ;
 N J,SCH,QQ S (J,QQ,SCH)=0 F  S J=$O(^PS(55,DFN,5,+RXO,1,"B",J)) Q:'J!(QQ)  D  Q:QQ
 . S SCH=$P($G(^PSDRUG(J,0)),"^",3)
 . I SCH["2"!(SCH["3")!(SCH["4")!(SCH["5") S QQ=1
 Q QQ
 ;
AIL ;
 S SEG="AIL"
 S $P(SEG,HLFS,2)=1
 S $P(SEG,HLFS,3)=PSJDIV_NECH_NECH_NECH_PSJDNM
 S $P(SEG,HLFS,4)=PSJOR_NECH_PSJORN
 S SEQ=SEQ+1
 S NSEG(SEQ)=SEG
 Q
 ;
SCH ;
 S SEG="SCH"
 S $P(SEG,HLFS,2)=DFN_":"_PSJOR_":"_$$FMTHL7^XLFDT(PSJDTM)
 S $P(SEG,HLFS,5)="S12"
 S $P(SEG,HLFS,12)=NECH_NECH_NECH_$$FMTHL7^XLFDT(PSJDTM)
 S SEQ=SEQ+1,PDL(16)=PSJDTM
 S NSEG(SEQ)=SEG
 Q
 ;
PIVOT(DFN,PSJON,PSWARDH,PSRBDH,PSFTSH) ; Get pivot # for patient=DFN and order=PSJON
 Q:'$G(DFN) ""
 Q:'$G(PSJON) ""
 N PSJOTYP,PSJOLIDT,PSJPIVOT,ADMDT,VAIP
 S PSWARDH="",PSRBDH=""
 S PSJOTYP=$E(PSJON,$L(PSJON))
 I PSJOTYP="U" S PSJOLIDT=$P($G(^PS(55,+DFN,5,+PSJON,0)),"^",16)
 I PSJOTYP="V" S PSJOLIDT=+$G(^PS(55,+DFN,"IV",+PSJON,2))
 Q:'$G(PSJOLIDT) ""  ; No log-in date; bad order #
 S VAIP("D")=PSJOLIDT D IN5^VADPT  ; Get admission info related to order's login date
 S ADMDT=+VAIP(13,1)
 S PSWARDH=$P($G(VAIP(5)),"^",2)
 S PSRBDH=$P($G(VAIP(6)),"^",2)
 S PSFTSH=$P(VAIP(8),"^")_NECH_$P(VAIP(8),"^",2)
 S PSJPIVOT=+$$PIVCHK^VAFHPIVT(DFN,ADMDT,1,VAIP(13)_";DGPM(")
 Q PSJPIVOT
 ;
LOGPIVOT(DFN,PSJON) ; Get pivot for Patient DFN, order PSJON, from log file
 Q:'$G(DFN)
 Q:'$G(PSJON)
 N PSJPIVOT,PSJLOGEN,II,PSJLOGND,PSJORACT,PSJLOGOR,PSPIVTMP
 S PSJPIVOT=""
 S II=0 F  S II=$O(^PS(58.72,"C",DFN,II)) Q:'II!$G(PSPIVTMP)  D
 .S PSJLOGND=$G(^PS(58.72,II,0))
 .S PSJORACT=$P(PSJLOGND,"^",16) Q:PSJORACT'="NW"
 .S PSJLOGOR=$P(PSJLOGND,"^",3) Q:PSJLOGOR'=PSJON
 .S PSPIVTMP=$P(PSJLOGND,"^",7)
 I $G(PSPIVTMP) S PSJPIVOT=PSPIVTMP
 I '$G(PSPIVTMP) S PSJPIVOT=-1
 Q PSJPIVOT
 ;
RESNDORDS(DFN,PSJOR,PSJDIV,PDSYS,FILTER) ; Resend all orders for the input CLINIC's SEND AREA 
 ;INPUT:
 ;    DFN: Patient Identifier from PATIENT file #2
 ;  PSJOR: Clinic IEN from HOSPITAL LOCATION file #44
 ; PSJORN: Clinic NAME from HOSPITAL LOCATION file #44
 ; PSJDIV: PADE Division
 ;  PDSYS: PADE System from file #58.7
 ;
 N PCLSAS,SENDAREA,RESNDCL,PSJSYDIV,PTSNDLOG
 ;
 ; Re-send orders for checked-in clinic
 S PCLSAS=$$GETSAR^PSJPDAPP(PDSYS,PSJDIV,PSJOR,FILTER)
 I $L(PCLSAS) D
 . D GETPTO^PSJPADE(DFN,PSJOR)
 . S ^TMP($J,"PSJCLSA",PDSYS,"DFN",DFN,"CL",PSJOR)=1  ; Orders sent for this patient/clinic, don't send again
 ; 
 ; Get SEND AREA for checked-in clinic
 S PCLSAS=$$GETSAR^PSJPDAPP(PDSYS,PSJDIV,PSJOR,0)
 S SENDAREA=$P(PCLSAS,"^",6)
 Q:'SENDAREA
 ;
 ; Send orders in SEND AREA of checked-in clinic
 S PSJSYDIV=0 F  S PSJSYDIV=$O(^TMP($J,"PSJCLSA",PDSYS,PSJSYDIV)) Q:'PSJSYDIV  D
 . S RESNDCL=0 F  S RESNDCL=$O(^TMP($J,"PSJCLSA",PDSYS,PSJSYDIV,"SA",SENDAREA,RESNDCL)) Q:'RESNDCL  D
 .. Q:$G(^TMP($J,"PSJCLSA",PDSYS,"DFN",DFN,"CL",RESNDCL))   ; Don't send orders for patient/clinic if already sent
 .. D GETPTO^PSJPADE(DFN,RESNDCL)
 .. S ^TMP($J,"PSJCLSA",PDSYS,"DFN",DFN,"CL",RESNDCL)=1     ; Orders sent for this patient/clinic, don't send again
 Q
