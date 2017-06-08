ZRWSERVE ;ALB/REW - PATCH ADMINISTRATION;22-APR-97 [ 05/12/97  5:03 PM ]
 ;;1;T3
 ; - send to self first
SERVER ;SERVER
 ;INPUT  : (As defined by MailMan)
 ;         XMFROM, XMREC, XMZ
 ;OUTPUT : None
 ;
 ;CHECK FOR EXISTANCE OF TRANSMISSION
 Q:('$D(^XMB(3.9,XMZ)))
 N DOLLAR,RWLINE,DIC,ERR
WS S (DOLLAR,RWLINE)=0
 S X="WHELAN,ROB"
 S DIC=200
 S DIC(0)="MQZ"
 D ^DIC
 Q:Y'>0
 S XMDUZ=+Y
 S ERR=$$ENT^XMDF(+Y,1,XMZ,DUZ)
 S XMCHAN=1
 S XMY("G.ROB-SUP")=""
 D ENT1^XMD
 K XMCHAN
 F  D  Q:(DOLLAR>1)!(RWLINE>1000)
 .X XMREC
 .S RWLINE=RWLINE+1
 .IF $E(XMRG,1)="$" D
 ..S DOLLAR=DOLLAR+1
 .ELSE  D
 ..S ^XTMP("REW",$J,RWLINE)=XMRG
 IF $D(^XTMP("REW",$J)) D
 .N RWLINE,RWHEAD,RWP
 .S X="A102/16/8/UP [SMA]"
 .S DIC=3.5
 .S DIC(0)="MQZ"
 .D ^DIC
 .Q:(Y'>0)
 .S IOP="`"_+Y
 .S %ZIS="0Q"
 .D ^%ZIS
 .U IO
 .S RWHEAD=$$NET^XMRENT(XMZ)
 .W !,"Subj: ",$P(RWHEAD,U,6),"   [#",XMZ,"]   ",$P(RWHEAD,U,1)
 .W !,"From: ",$P(RWHEAD,U,3)
 .S RWLINE=0
 .F  S RWLINE=$O(^XTMP("REW",$J,RWLINE)) Q:'RWLINE  W !,^(RWLINE)
 .D ^%ZISC
 D EXIT
 Q
EXIT ;
 K ^XTMP("REW",$J)
 Q
 ;
PATCH ;Give status of package
 ; - MailMan in
 ; - Loaded in Instal File
 ; - Installed
 N NS,PCKIEN,DIC,OLDPAT,PAT,VERIEN,X,Y,RW
 ;ABREV,OKMISS,TEMP,VERNUM,VERNAME
 S DIC=9.4
 S DIC(0)="AEMQZ"
 D ^DIC
 Q:(Y'>0)  ;BAD LOOKUP
 S PCKIEN=+Y
 S ABREV=$P(^DIC(9.4,PCKIEN,0),U,2)
 W !,"Ien: ",PCKIEN,"   Namespace: ",ABREV
 S DIC("B")=+$O(^DIC(9.4,PCKIEN,22,"B",""),-1)
 S DIC="^DIC(9.4,"_PCKIEN_",22,"
 D ^DIC
 Q:(Y'>0)
 S VERIEN=+Y
 S VERNUM=$P(Y,U,2)
 S VERNAME=ABREV_"*"_VERNUM
 W !,"Version: ",$P(Y,U,2)," Version Ien: ",VERIEN
 S PAT="" F  S PAT=$O(^DIC(9.4,PCKIEN,22,VERIEN,"PAH","B",PAT)) Q:PAT=""  D
 .IF PAT'?1.3N1" SEQ #"1.3N D  Q
 ..Q:$$OKINST(PAT,VERNAME)
 ..S RW("PART",PAT)=PAT
 .S RW($P(PAT,"SEQ #",2))=PAT
WRITE S PAT=0
 S OKMISS=""
 F I=1:1 S TEMP=$P($T(MISSING+I),";;",2) Q:TEMP=""  S:$P(TEMP,U,1)=ABREV OKMISS=$P(TEMP,U,2,99)
 ;F I=1:1 S TEMP=$P($T(SEQUEN+I),";;",2) Q:TEMP=""  S:$P(TEMP,U,1)=ABREV
 F  S PAT=$O(RW(PAT)) Q:'PAT  D
 .IF $D(OLDPAT) D
 ..N RWX
 ..F RWX=1:1 S RWXX=OLDPAT+RWX Q:RWXX=+PAT  D
 ...W !," *** Missing SEQ #"
 ...W RWXX
 ...W:OKMISS'[(U_RWXX_U) "  *** Not in Missing Patch list**"
 .W !,RW(PAT)
 .S OLDPAT=PAT
 W !,"Patches w/o sequence number: "
 S PAT="" F  S PAT=$O(RW("PART",PAT)) Q:PAT=""  W !,PAT
 Q
 ;
MAIL(NS) ;List MailMan messages in
 ; MS = patchname (E.G.. "SD*5.3*130")
 ;   ZALL - IF =1 INGNORE DUZ ISSUES
 N WHO,DIR,Y
 S DIR(0)="Y"
 S DIR("B")="N"
 W:'$G(ACTION) !,"SET 'ACTION=1' to get mail"
 W:'$G(ZALL) !,"SET 'ZALL=1' to see if mail was sent elsewhere"
 S DIR("A")="EMERGENCY"
 D ^DIR
 Q:$G(DIRUT)
 S MSG="Released "_NS
 S:Y MSG="EMERGENCY "_MSG
 S ENDMSG=MSG_9999
 F  S MSG=$O(^XMB(3.9,"B",MSG)) Q:MSG]ENDMSG!(MSG="")  D
 .S MSGNO=$O(^XMB(3.9,"B",MSG,0))
 .Q:'MSGNO
 .IF '$G(ZALL) D
 ..IF $D(^XMB(3.9,MSGNO,1,"C",DUZ)) W !,MSG," [#"_MSGNO_"]"
 .ELSE  D
 ..W !,MSG," [#"_MSGNO_"]"
 ..IF '$D(^XMB(3.9,MSGNO,1,"C",DUZ)) W " Not Recipient" D:$G(ACTION)
 ...S XMZ=MSGNO,XMY(DUZ)=""
 ...S WHO=$O(^XMB(3.9,MSGNO,1,"C",0))
 ...S RWDUZ=DUZ
 ...S DUZ=WHO
 ...S X=$$ENT^XMDF(RWDUZ,1,XMZ,DUZ)
 ...S DUZ=RWDUZ
 Q
OKINST(PAT,VERNAME) ;look in install file
 N PATNAME,INSTIEN,OK,SEQ
 S OK=0
 S PATNAME=VERNAME_"*"_PAT
 S INSTIEN=0
 F  S INSTIEN=$O(^XPD(9.7,"B",PATNAME,INSTIEN)) Q:'INSTIEN  D
 .Q:($P(^XPD(9.7,INSTIEN,0),U,9)'=3)
 .S SEQ=$P($G(^XPD(9.7,INSTIEN,2)),"SEQ #",2)
 .IF SEQ D
 ..S OK=1
 ..S RW(+SEQ)=PAT_"SEQ # "_SEQ_" **"
QTOKIN Q OK
MISSING ;namespace^^SEQpatch1^SEQpatch2...^SEQpatchn^
 ;;SD^^38^69^76^115^126^
 ;;DG^^101^87^94^105^115^122^140^141^77^79^81^144^146^
 ;;DVBA^^
