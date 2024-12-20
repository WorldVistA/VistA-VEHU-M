SDHL7APT ;MS/TG,PH - TMP HL7 Routine;AUG 17, 2018
 ;;5.3;Scheduling;**704,714,754,773,780,798,810,817,821,848,859,863**;Aug 13, 1993;Build 14
 ;
 ;  Integration Agreements:
 Q
 ;
PROCSIU ;Process SI^S12 messages from the "TMP VISTA" Subscriber protocol
 ;ENT ;
 ;EN ;
 ;
 ; This routine and subroutines assume that all VistA HL7 environment
 ; variables are properly initialized and will produce a fatal error
 ; if they are missing.
 ;
 ;  The message will be checked to see if it is a valid SIU. If valid - the SIU will process the 1st RGS group
 ;  on the current facility. Any subsequent RGS groups will be sent to facilities as specified in AIL.3.4
 ;  In the event the appointment does not file on the remote facility (ie; an AE is received from that remote facility)
 ;  an AE (with the appropriate error text) will be returned to HealthShare.
 ;  Input:
 ;          HL7 environment variables
 ;
 ; Output:
 ;          Positive (AA) or negative acknowledgement (AE - with appropriate error text)
 ;
 ;  Integration Agreements: NONE
 ;
 N MSGROOT,DATAROOT,QRY,XMT,ERR,RNAME,IX,REQIEN     ;817 reqien
 K SDTMPHL
 S (MSGROOT,QRY,XMT,ERR,RNAME)=""
 S U="^"
 ;
 ; Inbound SIU messages are small enough to be held in a local array.
 ; The following lines commented out support use of temporary globals and are
 ; left for debugging purposes.
 ;
 S MSGROOT="SDHL7APT"
 K @MSGROOT
 N EIN S EIN=HL("EID") ;ien of HL7 server receiving msg 821
 D LOADXMT^SDHL7APU(.HL,.XMT)         ;Load inbound message information
 K ACKMSG S ACKMSG=$G(HL("MID"))
 S RNAME=XMT("MESSAGE TYPE")_"-"_XMT("EVENT TYPE")_" RECEIVER"
 ;
 N CNT,SEG
 K @MSGROOT
 D LOADMSG^SDHL7APU(MSGROOT)
 D PARSEMSG^SDHL7APU(MSGROOT,.HL)
 ;
 N APPTYPE,AILNTE,DFN,RET,CNT,PID,PV1,RGS,AIS,AIG,AISNTE,OVB,OFFSET,AIP,RTCID,AIPNTE,INP,SETID,EXTIME,SCHNTE,SCH,SDMTC,QRYDFN,MSGCONID,LST,MYRESULT,HLA,PTIEN,SCPER,ATYPIEN
 N AIGNTE,AIL,ARSETE,CURDTTM,ERROR,FLMNFMT,EESTAT,GRPCNT,GRPNO,OBX,PREVSEG,PTIEN,SCHDFN,SCPERC,SDDDT,SDECATID,SDUSER,CHILD,MSAHDR,SDECTYP
 N SDECCR,SDECEND,SDECLEN,SDECNOTE,SDECRES,SDECSTART,SDECY,SDEKG,SDEL,SDID,SDLAB,SDMRTC,SDPARENT,SDCHILD,SDECAPTID,SDECDATE,FIRST
 N SDREQBY,SDSVCP,SDSVCPR,INTRA,SDXRAY,SEGTYPE,INST,FLMNFMT2,SDAPTYP,STA,STATUS,STOP,PROVIEN,ERRCND,ERRSND,ERRTXT,URL,MSH,SDECNOT,RTN,SDCL
 ;
 S (MSGCONID,SCHDFN)=""
 S CNT=1,SETID=1,PREVSEG="",GRPCNT=0,PTIEN="",ERRTXT="",ERRSND=""
 ;
 ; Loop to receive HL7 message segments.
 S ERR=0
 F  Q:'$D(@MSGROOT@(CNT))  Q:ERR  D  S CNT=CNT+1,PREVSEG=SEGTYPE
 .S SEGTYPE=$G(@MSGROOT@(CNT,0))
 .I SEGTYPE="MSH" M MSH=@MSGROOT@(CNT) Q
 .I SEGTYPE="SCH" M SCH=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="SCH") M SCHNTE=@MSGROOT@(CNT) Q
 .I SEGTYPE="PID" M PID=@MSGROOT@(CNT) Q
 .I SEGTYPE="PV1" M PV1=@MSGROOT@(CNT) Q
 .I SEGTYPE="OBX" M OBX=@MSGROOT@(CNT) Q
 .I SEGTYPE="RGS" D  Q
 ..S SETID=$G(@MSGROOT@(CNT,1))
 ..I +SETID=0 S ERR=1,ERRTXT="Invalid RGS SetID received" Q
 ..M RGS(SETID)=@MSGROOT@(CNT)
 ..S GRPCNT=GRPCNT+1
 .I SEGTYPE="AIS" M AIS(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIS") M AISNTE(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="AIG" M AIG(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIG") M AIGNTE(SETID)=@MSGROOT@(CNT) Q 
 .I SEGTYPE="AIL" M AIL(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIL") M AILNTE(SETID)=@MSGROOT@(CNT) Q 
 .I SEGTYPE="AIP" M AIP(SETID)=@MSGROOT@(CNT) Q
 .I SEGTYPE="NTE",(PREVSEG="AIP") M AIPNTE(SETID)=@MSGROOT@(CNT)
 I $G(AIL(2,4))="R" D  ;Check to see if this is an intrafacility rtc order and set the rtc number to null on the second AIL second so both appts file.
 .I $G(AIL(2,4))=$G(AIL(1,4)) S AIL(2,4)="",AIL(2,4)=""
 ;
 S MSAHDR="MSA^1^^100^AE^"
 I +ERR D  Q
 .S ERR=$G(MSAHDR)_$E(ERRTXT,1,52)
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 K SCHNW,INP,PCE,SCPER,ATYPIEN
 ; Loop to populate MSGARY, INP arrays which are used in ^SDECAR2 (to create appt request) and ^SDEC07 (to create appt)
 N MSGARY,SDCL,SDCL2,SDCL3
 D MSH^SDHL7APU(.MSH,.INP,.MSGARY)
 D SCH^SDHL7APU(.SCH,.INP,.MSGARY)
 I +ERR D  Q   ;859-check Cancel Reason
 .S ERR=$G(MSAHDR)_$E(ERRTXT,1,52)
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 D SCHNTE^SDHL7APU(.SCHNTE,.INP,.MSGARY)
 D PID^SDHL7APU(.PID,.INP,.MSGARY)
 D PV1^SDHL7APU(.PV1,.INP,.MSGARY)
 D OBX^SDHL7APU(.OBX,.INP)
 F IX=1:1:GRPCNT D
 .D RGS^SDHL7APU(.RGS,IX,.INP)
 .D AIS^SDHL7APU(.AIS,IX,.INP,.MSGARY)
 .D AISNTE^SDHL7APU(.AISNTE,IX,.INP)
 .D AIG^SDHL7APU(.AIG,IX,.INP)
 .D AIGNTE^SDHL7APU(.AIGNTE,IX,.INP)
 .D AIL^SDHL7APU(.AIL,IX,.INP,.MSGARY)
 .D AILNTE^SDHL7APU(.AILNTE,IX,.INP)
 .D AIP^SDHL7APU(.AIP,IX,.INP,.MSGARY)
 .D AIPNTE^SDHL7APU(.AIPNTE,IX,.INP)
 N %,NOW
 D NOW^%DTC S CURDTTM=$$TMCONV^SDTMPHLA(%,$$KSP^XUPARAM("INST")) ;773
 S NOW=$$HTFM^XLFDT($H),INP(3)=$$FMTE^XLFDT(NOW)
 S INP(11)=INP(3)
 S INP(5)="APPT"
 S INP(8)="FUTURE"
 ;
 N X11 S X11=$P($G(SDAPTYP),"|") S:$G(X11)="" X11="A"
 S INP(9)=$S(X11="A":"PATIENT",1:"PROVIDER") ;request by provider or patient. RTC orders and consults will always be PROVIDER otherwise it is PATIENT
 K DFN
 S (DFN,INP(2))=$$GETDFN^MPIF001(MSGARY("MPI"))
 I $P(DFN,U,2)="NO ICN"!($P(DFN,U,2)="ICN NOT IN DATABASE") D  Q
 .S ERR=$G(MSAHDR)_"PATIENT ICN NOT FOUND"
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 ;
 N STOPME
 I $P($G(SDAPTYP),"|",1)="C"!($P($G(SDAPTYP),"|",1)="R") D CHKCON^SDHLAPT2(DFN,SDAPTYP) I $G(STOPME)=1 Q
 I $G(SDCL)="" D  Q
 .S ERR=$G(MSAHDR)_"CLINIC ID IS NULL",STOPME=1
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 Q:$G(STOPME)=1
 I '$D(^SC($G(SDCL),0)) D  Q
 .Q:$G(AIL(1,3,1,4))'=$P(^DIC(4,$$KSP^XUPARAM("INST"),99),"^")
 .S ERR=$G(MSAHDR)_"NOT A CLINIC AT THIS SITE "_$G(SDCL)
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 S STOPME=0
 I $G(SDCL2)>0 D
 .Q:$G(AIL(2,3,1,4))'=$P(^DIC(4,$$KSP^XUPARAM("INST"),99),"^")
 .I '$D(^SC($G(SDCL2),0)) S ERR=$G(MSAHDR)_"NOT A CLINIC AT THIS SITE "_$G(SDCL2),STOPME=1 D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 Q:$G(STOPME)=1
 K INP D INP^SDHL7APU
 ;
 S RET=""
 ;IF a regular appt, not rtc or consult check to see if the appointment is in 409.85
 I $P(SDAPTYP,"|",1)="A" D
 .Q:$$UPPER^SDUL1(MSGARY("HL7EVENT"))'="S12"
 .I $G(AIL(2,4,1,4))=$G(SDPARENT) S (INP(25),SCH(24,1,1),SDPARENT)=""  ;859 prevent adding parent in ARSET below
 .S:INP(3)="" INP(3)=DT S RTN=0 D ARSET^SDECAR2(.RTN,.INP)
 .S REQIEN=+$P(RTN,$c(30),2),SDAPTYP="A|"_REQIEN      ;817- define REQIEN for later  ;810- SDECAR2 routine should be used instead of SDHLAPT1 version of ARSET
 I $G(SDMTC)=1 D CHKCHILD^SDHL7APU ; if multi check to see if the child order is in 409.85, if not add it
 ;714 - PB get the division associated with the clinic and pass to the function to convert utc to local time
 N TMPSTART,D1,D2
 S:$G(SDCL)>0 D1=$P(^SC(SDCL,0),"^",15),D2=$$GET1^DIQ(40.8,D1_",",.07,"I")
 S FLMNFMT=$$JSONTFM^SDHLAPT2(SDECSTART,D2),TMPSTART=FLMNFMT,SDECSTART=$$FMTE^XLFDT(FLMNFMT)
 I FLMNFMT<1 D  Q
 .S ERR=$G(MSAHDR)_"Invalid Start Date sent"
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 ;
 ;PB - 714 fix to stop duplicate appointments for the patient
 S STOPME=0
 I $G(^DPT(DFN,"S",FLMNFMT,0))&($G(MSGARY("HL7EVENT"))="S12") D
 .Q:$P($G(^DPT(DFN,"S",FLMNFMT,0)),"^",2)["C"
 .S ERR=$G(MSAHDR)_"PATIENT ALREADY HAS AN APPT AT ON "_$$FMTE^XLFDT(FLMNFMT),STOPME=1
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 Q:$G(STOPME)=1
 S STOPME=0
 I $G(INTRA)=1 D
 .S FLMNFMT2=$$FMADD^XLFDT(FLMNFMT,,,5)
 .Q:$G(MSGARY("HL7EVENT"))'="S12"
 .I $D(^DPT(DFN,"S",FLMNFMT,0)) D
 ..I $P($G(^DPT(DFN,"S",FLMNFMT,0)),"^",2)'["C" D
 ...S ERR=$G(MSAHDR)_"PATIENT ALREADY HAS AN APPT AT ON "_$$FMTE^XLFDT(FLMNFMT2),STOPME=1
 ...D SENDERR^SDHL7APU(ERR)
 ...K @MSGROOT
 .Q:$G(STOPME)=1
 .I $D(^DPT(DFN,"S",FLMNFMT2,0)) D
 ..I $P($G(^DPT(DFN,"S",FLMNFMT2,0)),"^",2)'["C" D
 ...S ERR=$G(MSAHDR)_"PATIENT ALREADY HAS AN APPT AT ON "_$$FMTE^XLFDT(FLMNFMT2),STOPME=1
 ...D SENDERR^SDHL7APU(ERR)
 ...K @MSGROOT
 Q:$G(STOPME)=1
 I $L(SDECLEN),$L($G(SCH(10))) D
 .I $G(SCH(10))="MIN" S SDECEND=$$FMADD^XLFDT(FLMNFMT,,,$G(SDECLEN))
 .I $G(SCH(10))="HR" S SDECEND=$$FMADD^XLFDT(FLMNFMT,,$G(SDECLEN))
 ;
 N TMPARR,LEN
 S LEN=0,ERRSND=0,ERRTXT="",MSGROOT="SDTMPHL"
 K @MSGROOT
 ;
 ; Loop to send RGS>1 groups to remote facilities. Abort entire SIU if any facility returns AE from remote.
 F GRPNO=2:1:GRPCNT D  Q:+ERRSND
 .K @MSGROOT
 .S CNT=1,INTRA=0
 .I $D(SCH) S:$G(FCHILD)>0 SCH(7,1,4)=FCHILD S @MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.SCH,.HL),LEN=LEN+$L(@MSGROOT@(CNT)) K FCHILD
 .I $D(SCHNTE) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.SCHNTE,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .I $D(PID) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.PID,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .I $D(PV1) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.PV1,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .M TMPARR=RGS(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIS(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AISNTE(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIG(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIL(GRPNO)
 .I $D(TMPARR) D
 ..S STA=$G(TMPARR(3,1,4)) S STA=$$GETSTA^SDHL7APU(STA)
 ..S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AILNTE(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIP(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .M TMPARR=AIPNTE(GRPNO)
 .I $D(TMPARR) S CNT=CNT+1,@MSGROOT@(CNT)=$$BLDSEG^SDHL7UL(.TMPARR,.HL),LEN=LEN+$L(@MSGROOT@(CNT))
 .K TMPARR
 .S:$G(AIL(1,3,1,4))=$G(AIL(2,3,1,4)) INTRA=1
 .I $G(INTRA)=1 D NEWTIME^SDHLAPT2
 .N HLRESLT,X
 .I $G(INTRA)=0,'$$CHKLL^HLUTIL($G(STA)) D  Q     ;821 quit@single dot, so errtxt can be sent now
 ..S ERRSND=1,ERRTXT=$E("Invalid Link assoc with institution: "_$G(STA),1,52)
 .N HLA,HLEVN   ;821 new instead of kill
 .N MC,HLFS,HLCS,IXX
 .F IXX=1:1:CNT S HLA("HLS",IXX)=$G(@MSGROOT@(IXX))
 .M HLA("HLA")=HLA("HLS")
 .;the following HL* variables are created by DIRECT^HLMA
 .N HL,HLCS,HLDOM,HLECH,HLFS,HLINST,HLINSTN,HLMTIEN,HLNEXT,HLNODE,HLPARAM,HLPROD,HLQ,HLQUITQ,SDLINK,OROK,MSASEG,ERRRSP
 .N SDPARENT,SDCHILD,SDMRTC,SDAPTYP,AIL  ;Fix 2464
 .;  more HL News, to protect Orig incoming HL* variables vs Intra/Inter msgs occurring real time below.   ;821
 .N HLL,HLMTIENS,HL771RF,HL771SF,HLARTYP,HLASTMSG,HLASTRSP,HLDBACK,HLDBSIZE,HLDP,HLDREAD,HLDRETR,HLDWAIT,HLIED,HLEIDS,HLENROU,HLFORMAT,HLHDRO,HLLSTN,HLMIDAR
 .N HLORNOD,HLOS,HLP,HLPID,HLPROU,HLQUIT,HLREC,HLRESLT,HLRETRA,HLFREQ,HLTCP,HLTCPADD,HLTCPCS,HLTPCI,HLTCPLNK,HLTCPO,HLTCPORT,HLTCPRET,HLTMBUF,HLEXROU,HLMTIENA
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 ..K HL
 ..D:$G(INTRA)=0 INIT^HLFNC2("SD IFS EVENT DRIVER",.HL)
 ..D:$G(INTRA)=1 INIT^HLFNC2("SD TMP SEND INTRAFACILITY",.HL) ;if intra
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 ..K HL
 ..D:$G(INTRA)=0 INIT^HLFNC2("SD TMP S15 SERVER EVENT DRIVER",.HL)
 ..D:$G(INTRA)=1 INIT^HLFNC2("SD TMP SEND CANCEL INTRA",.HL) ;if intra
 .I $G(STA)="" S STA=$G(AIL(2,3,1,4)),STA=$$GETSTA^SDHL7APU(STA)
 .D LINK^HLUTIL3(STA,.SDLINK,"I")
 .S SDLINK=$O(SDLINK(0))
 .I SDLINK="" D  Q
 ..Q:$G(INTRA)=1
 ..S ERRSND=1,ERRTXT=$E("Message link undefined for facility: "_$G(STA),1,52)
 .S SDLINK=SDLINK(SDLINK)
 .;817 removed code setting HLL("LINKS") for INTRA type appts. Not used for internal HL7 processing. TMP-1559
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 ..S:$G(INTRA)=0 HLL("LINKS",1)="SD IFS SUBSCRIBER"_U_$G(SDLINK)
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 ..S:$G(INTRA)=0 HLL("LINKS",1)="SD TMP S15 CLIENT SUBSCRIBER"_U_$G(SDLINK)
 .S HLMTIEN=""
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 ..D:$G(INTRA)=0 DIRECT^HLMA("SD IFS EVENT DRIVER","LM",1,.OROK)
 ..I $G(INTRA)=1 D GENERATE^HLMA("SD TMP SEND INTRAFACILITY","LM",1,.OROK) S HLMTIEN=+OROK
 .I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 ..D:$G(INTRA)=0 DIRECT^HLMA("SD TMP S15 SERVER EVENT DRIVER","LM",1,.OROK)
 ..I $G(INTRA)=1 D GENERATE^HLMA("SD TMP SEND CANCEL INTRA","LM",1,.OROK) S HLMTIEN=+OROK
 .I 'HLMTIEN S ERRSND=1,ERRTXT=$E("ERROR-PROVIDER FACILITY #"_$G(STA)_":"_$P(OROK,U,2)_":"_$P(OROK,U,3),1,99) Q   ;821 increase all Errtxt from 48 to 99
 .K @MSGROOT
 .;Process response
 .I $G(INTRA)=0 D
 ..N HLNODE,SEG,I,RESP,IK
 ..F IK=1:1 X HLNEXT Q:HLQUIT'>0  D
 ...S RESP(IK)=HLNODE
 ..S MSASEG=$G(RESP(2))
 ..I $E(MSASEG,1,3)="MSA",$P(MSASEG,"|",2)="AE" S ERRSND=1,ERRTXT=$$STRIP^SDHL7APU($P(MSASEG,"|",4)),ERRTXT=$E(ERRTXT,1,52)
 ;
 I +ERRSND D  Q   ;**** Provider side error, exit and do not file patient side appt. ****
 .S ERR=$G(MSAHDR)_ERRTXT
 .D SENDERR^SDHL7APU(ERR)
 .K @MSGROOT
 ;Begin Appt filing
 K @MSGROOT
 S (SDSVCP,SDSVCPR,SDEKG,SDXRAY,SDLAB,SDECCR,SDECY,SDID,APPTYPE,EESTAT,SDEL)="",SDCL=$G(AIL(1,3,1,1))
 S SDECRES=$$RESLKUP^SDHL7APU($G(SDCL))
 S SDECRES=SDECRES,OVB=1
 S (SDMRTC,MSGARY("SDMRTC"))=$S($G(SDMRTC)=1:"TRUE",1:"FALSE"),SDLAB="",PROVIEN=MSGARY("PROVIEN")
 I $P(SDAPTYP,"|",1)="R" D
 .S $P(SDAPTYP,"|",1)="A"
 .I $G(SDPARENT)]"",$P(SDAPTYP,"|",2)=$G(SDPARENT),$P($G(^SDEC(409.85,$G(SDPARENT),3)),"^")="" S SDPARENT=""   ;SDPARENT with no SDCHILD scenario-erase parent. 863 fix 2562, prevent null subscript
 K INP D INP^SDHL7APU
 S (ERRCND,ERRTXT)=""
 N SUCCESS
 S SUCCESS=0
 S (PROVIEN,DUZ)=$G(MSGARY("DUZ"))
 S:$G(DUZ)="" (PROVIEN,DUZ)=.5
 S:$G(DUZ(2))="" DUZ(2)=$G(MSGARY("HLTHISSITE"))
 S (INP(11),SDDDT)=$G(SCH(11,1,8))
 ;   Begin S12 processing (make)
 I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S12" D
 .S URL=$G(AILNTE)
 .I $P($G(SDAPTYP),"|")="A"&($G(SDAPT)>0) D
 ..;S $P(SDAPTYP,"|",2)=SDAPT      ; *848 - this 409.84 ien should not be set in SDAPTYP, which is a 409.85 file variable
 ..S:$G(SDDDT)="" (INP(11),SDDDT)=$P(SDECSTART,"@",1),SDECATID="WALKIN"
 .S:$P($G(SDAPTYP),"|",1)="R" $P(SDAPTYP,"|",1)="A"
 .S:$G(SDPARENT)=$P(SDAPTYP,"|",2) SDPARENT=""
 .I $$APPTYPE^SDHL7APU(SDCL)=1 S APPTYPE=1  ;780
 .I $$PATCH^XPDUTL("SD*5.3*694") S SDECEND=$$FMTE^XLFDT(SDECEND)
 .D APPADD^SDEC07(.SDECY,SDECSTART,SDECEND,DFN,SDECRES,SDECLEN,SDECNOTE,SDECATID,SDECCR,SDMRTC,SDDDT,SDREQBY,SDLAB,PROVIEN,SDID,SDAPTYP,SDSVCP,SDSVCPR,SDCL,SDEKG,SDXRAY,APPTYPE,EESTAT,OVB,$G(SDPARENT),SDEL) ;ADD NEW APPOINTMENT
 .K SDAPT S SDAPT=+$P($G(^TMP("SDEC07",$J,2)),"^") ;if appointment is made this is the appointment number ien from 409.84
 .S URL=$G(AILNTE)
 .D:$L(URL) GETAPT^SDHL7APU(URL,SDCL,$G(TMPSTART)) ; If the appointment has been made in SDEC(409,84, update the url in the Hospital Location file.
 .N TMP2 S TMP2=$G(^TMP("SDEC07",$J,2))
 .I ((+$P(TMP2,"^",1)>0)&($L($P(TMP2,"^",3))<1)) S SUCCESS=1
 .I SUCCESS=0 S ERRTXT=$P($G(^TMP("SDEC07",$J,2)),"^",3)
 .I ((SUCCESS=0)&(ERRTXT="")) D
 ..S ERRTXT=$P($G(^TMP("SDEC07",$J,3)),"^",2)
 .I $L(ERRTXT) S ERRCND=9999
 .S DUZ(2)=$G(STA)
 .I $G(SUCCESS)>0 D
 ..N INPA S INPA(1)=$S($G(REQIEN):REQIEN,1:$P(SDAPTYP,"|",2)),INPA(2)="SA",INPA(3)=$G(DUZ),DUZ(2)=$G(STA)    ;INPA(1) is the IEN of the PARENT order  ;817 If RTC, then add new Req (i.e. REQIEN) will exist.
 ..S INPA(4)=$$FMTE^XLFDT(DT)
 ..N RET D ARCLOSE^SDECAR(.RET,.INPA) ; Dispositions the order.
 ..I $G(SDPARENT)'="" N CLOSEOUT S CLOSEOUT=0 I $G(RTCID)>0 S:$G(RTCID)=$P($G(^SDEC(409.85,+$G(SDPARENT),3)),"^",3) CLOSEOUT=1
 ..I $G(CLOSEOUT)=1 D   ;if this is the last child close out the parent and all child orders
 ...N INP S INP(1)=+SDPARENT,INP(2)="SA",INP(3)=$G(DUZ),DUZ(2)=$G(STA)
 ...S INP(4)=$$FMTE^XLFDT(DT)
 ...D ARCLOSE^SDECAR(.RET,.INP)
 ...;Parent Appointment Request Closed now loop thru the 3 node and update each of the children to disposition of "MC"
 ...I $G(SDPARENT)>0 K X12 S X12=0 F  S X12=$O(^SDEC(409.85,SDPARENT,2,X12)) Q:X12'>0  D
 ....S INP(1)=$P(^SDEC(409.85,SDPARENT,2,X12,0),"^"),INP(2)="MC",INP(3)=$G(DUZ),DUZ(2)=$G(STA)
 ....S INP(4)=$$FMTE^XLFDT(DT)
 ....D ARCLOSE^SDECAR(.RET,.INP)
 ;  Begin S15 processing (cancel)
 I $$UPPER^SDUL1(MSGARY("HL7EVENT"))="S15" D
 .N XDT,%D,X,Y,STARTDT,ERRTXT,ERRCND
 .S SDECCR=$G(SCH(6,1,2)),SDUSER=$G(MSGARY("DUZ"))
 .S:$G(SDUSER)="" SDUSER=.5
 .S %DT="RXT",X=SDECSTART D ^%DT S STARTDT=Y
 .S SDECAPTID=$$GETAPP^SDHLAPT1(DFN,SDECRES,STARTDT)
 .S DUZ=$G(MSGARY("DUZ"))
 .S:$G(DUZ)="" DUZ=.5
 .S:$G(DUZ(2))="" DUZ(2)=$G(MSGARY("HLTHISSITE"))
 .D APPDEL^SDEC08(.SDECY,SDECAPTID,SDECTYP,$G(SDECCR),$G(SDECNOT),$G(SDECDATE),$G(SDUSER))
 .S ERRTXT=$P($G(^TMP("SDEC",$J,2)),"^")
 .I +$L(ERRTXT)>0 S ERRCND=9999
 .D CHKCAN^SDHLAPT2(DFN,SDCL,STARTDT)
 ;
 I +ERRCND S ERRTXT=$$ERRLKP^SDHL7APU(ERRTXT)
 S ERRTXT=$$STRIP^SDHL7APU(ERRTXT)
 ;
 D ACK^SDHL7APU
 Q
