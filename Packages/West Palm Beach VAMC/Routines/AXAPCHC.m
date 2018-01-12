AXAPCHC ;WPB/JLTP ; Check Patches for Timely Install ; 13-JUL-2001
 ;;2.0;WPB Patch Tracking;10-SEP-1998;;Build 2
 N DAYS,DPR,IEN,LINE,TXT,XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,ZERO
 S LINE=0
 S DPR="" F  S DPR=$O(^AXA(548261,"ADR",DPR),-1) Q:'DPR  D
 .S IEN=0 F  S IEN=$O(^AXA(548261,"ADR",DPR,IEN)) Q:'IEN  D
 ..S E=$G(^AXA(548261,IEN,1))["EMERGENCY",ZERO=^(0),CD=$P(ZERO,U,8)
 ..S RD=$S(CD:CD,E:$$FMADD^XLFDT(DPR,2),1:$$FMADD^XLFDT(DPR,30))
 ..S DAYS=$$FMDIFF^XLFDT(RD,DT),STAT=$$ST^AXAPCHU(IEN),MSG=$P(ZERO,U,20)
 ..S TEST=$P(ZERO,U,4)]""
 ..I "1$2$3$7$"[((+STAT)_"$") D
 ...I DAYS=10,'TEST D RSP1 ; First response to ADPACs
 ...I DAYS'>5 D RPT ;        Programmers Report
 ...I DAYS=3,'TEST D RSP2 ;  Immediate Install Notification
 D BUL
 Q
BUL ; Send E-mail Bulletin
 S XMSUB="Patch Timeliness Report",XMTEXT="TXT(",XMY("G.IRM AP")=""
 S (XMDUZ,XMDUN)="WPB PATCHMAN"
 I '$O(TXT(0)) D
 .D ADD("All patches seem to be up-to-date.  Good work, team!")
 D ^XMD
 Q
ADD(X) ; Add text to message body
 S LINE=LINE+1,TXT(LINE,0)=X
 Q
RPT ; Found a late patch.  Build the record.
 N DAYSX,DES,MSG,MSGX,STATX,SUB,X
 I 'LINE D HDR
 S X=$G(^AXA(548261,IEN,0))
 S TV=$S($P(X,U,4)]"":"* ",E:"! ",1:"  ")
 S DES=$P(X,U),SUB=$P(X,U,17),MSG=$P(X,U,20),STAT=$P(STAT,U,2)
 S DES=$$J(DES,15),SUB=$$J(SUB,25),STATX=$$J(STAT,10)
 S MSGX=$$J(MSG,10,1),DAYSX=$$J(DAYS,6,1)
 D ADD(TV_DES_SUB_STATX_DAYSX_MSGX)
 Q
RSP1 ;
 N TEXT
 S TEXT(1,0)="This patch must be installed in the live account by "
 S TEXT(2,0)=$$FMTE^XLFDT(RD)_".  It will be installed in live within "
 S TEXT(4,0)="the next few days."
 S X=$$ENT^XMA2R(MSG,"Mandatory Install",.TEXT,"","WPB PATCHMAN")
 Q
RSP2 ;
 N TEXT
 S TEXT(1,0)="This patch must be installed in the live account "
 S TEXT(2,0)="immediately.  The deadline for install is "_$$FMTE^XLFDT(RD)_"."
 S X=$$ENT^XMA2R(MSG,"Mandatory Install",.TEXT,"","WPB PATCHMAN")
 Q
HDR ; Build message heading
 N H1,H2,H3,H4,H5,X
 S X="",$P(X,"-",69)=""
 S H1=$$J("DESIGNATION",15)
 S H2=$$J("SUBJECT",25)
 S H3=$$J("STATUS",10)
 S H4=$$J("LEFT",8)
 S H5=$$J("MSG #",10)
 D ADD("The following patches must be installed as soon as possible!")
 D ADD("* NOTE: Patches preceded by an asterisk are test versions and")
 D ADD("        their timeliness is not tracked nationally.")
 D ADD("! NOTE: Emergency patches must be installed within 48 hours")
 D ADD("        of receipt.")
 D ADD(" "),ADD($$J("DAYS",57,1)),ADD("  "_H1_H2_H3_H4_H5),ADD(X)
 Q
J(X,L,D) ; Pad & Trim
 N X1,Y
 S X1="",$P(X1," ",L)=" "
 I '$G(D) S Y=$E(X,1,L-2)_X1,Y=$E(Y,1,L)
 E  S Y=X1_$E(X,1,L-2)_"  ",Y=$E(Y,$L(Y)-L,$L(Y))
 Q Y
