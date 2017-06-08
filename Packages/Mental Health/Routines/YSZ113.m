YSZ113 ;SLC/GDU - PATCH YS*5.01*113 CODE; 3/24/14 15:32
 ;;5.01;MENTAL HEALTH;**113**;Dec 30, 1994;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Data Base Integration Agreement LIST
 ; EN^DDIOL            DBIA # 10142
 ; $$FIND1^DIC         DBIA # 2051
 ; FILE^DIE            DBIA # 2053
 ; GETS^DIQ            DBIA # 2056
 ; $$REPEAT^XLFSTR     DBIA # 10104
 ; ^XMD                DBIA # 10070
 ;Routine is to be called by entry point
 Q
EN ;Entry point
 S YSCNT=1,YSFILE=601.91
 S YSMAIL(1)="YS*5.01*113 INSTALLATION MESSAGES"
 D EN1,EN2,SMM
 K YSCNT,YSFILE,YSMAIL
 Q
EN1 ;INC000000970159 - Two Barthel Index MH SCORING KEYS values are incorrect.
 S YSMSG(1)="INC000000970159 - Two Barthel Index MH SCORING KEYS values are incorrect."
 S YSMSG(1,"F")="!!"
 D UM
 F YSIEN=7086,7087 D
 . S YSIENS=YSIEN_","
 . D GR I $D(YSFLD)=0 Q
 . ;If the value is already corrected, alert user and quit loop
 . I YSFLD(.01)=7086,YSFLD(4)=10 D VAC,UM Q
 . I YSFLD(.01)=7087,YSFLD(4)=15 D VAC,UM Q
 . ;Correct the value
 . I YSFLD(.01)=7086 S YSFDA(YSFILE,YSIENS,4)=10 D VIC,FILE^DIE("","YSFDA","YSERR")
 . I YSFLD(.01)=7087 S YSFDA(YSFILE,YSIENS,4)=15 D VIC,FILE^DIE("","YSFDA","YSERR")
 . I $D(YSERR) S YSERL=6 D PEM
 . D UM
 . K YSIENS,YSERR,YSFDA
 D KYSV
 Q
 ;
VAC ;Value Already Correct
 S YSMSG(5.1)="Value is already correct."
 S YSMSG(5.1,"F")="!?8"
 Q
 ;
VIC ;Value Is Corrected
 S YSMSG(5.1)="Value will be set to the correct value of "_YSFDA(YSFILE,YSIENS,4)
 S YSMSG(5.1,"F")="!?8"
 Q
 ;
EN2 ;INC000001016218 - Scoring issue with AAQ-2.
 S BTV="Seldon true",GTV="Seldom true"
 S YSMSG(1)="INC000001016218 - Scoring issue with AAQ-2."
 S YSMSG(1,"F")="!!"
 D UM
 S YSACI=615,YSIEN=0
 F  S YSIEN=$O(^YTT(YSFILE,"AC",YSACI,YSIEN)) Q:YSIEN=""  D
 . S YSIENS=YSIEN_","
 . D GR I $D(YSFLD)=0 Q
 . I YSFLD(3)=GTV D  Q
 .. S YSMSG(4.1)="Target is already correct."
 .. S YSMSG(4.1,"F")="!?8"
 .. D UM
 . I YSFLD(3)=BTV D  Q
 .. S YSFDA(YSFILE,YSIENS,3)=GTV
 .. S YSMSG(4.1)="Target will be set to the correct value of: "_GTV
 .. S YSMSG(4.1,"F")="!?8"
 .. D FILE^DIE("","YSFDA","YSERR")
 .. I $D(YSERR) S YSERL=6 D PEM
 .. D UM
 D KYSV
 K BTV,GTV
 Q
 ;
GR ;Get Record
 I YSIEN="" Q
 K YSFLD
 D GETS^DIQ(YSFILE,YSIENS,"*","","YSREC","YSERR")
 I $D(YSERR) D PEM G GRQ
 S YSX=0 F  S YSX=$O(YSREC(YSFILE,YSIENS,YSX)) Q:YSX=""  S YSFLD(YSX)=YSREC(YSFILE,YSIENS,YSX)
 S YSMSG(1)="MH SCORING KEY # "_YSFLD(.01)
 S YSMSG(2)="Scale: "_YSFLD(1)
 S IENS=YSFLD(1)_","
 S YSMSG(2)=YSMSG(2)_" - "_$$GET1^DIQ(601.87,IENS,3) K IENS
 S YSMSG(3)="Question: "_YSFLD(2) D GQ
 S YSMSG(4)="Target: "_YSFLD(3)
 S YSMSG(5)="Value: "_YSFLD(4)
 S YSMSG(1,"F")="!"
 F YSX=2:1:5 S YSMSG(YSX,"F")="!?4"
GRQ K YSERR,YSREC,YSX
 Q
 ;
GQ ;Get Question
 S IENS=YSFLD(2)_","
 S YSX=$$GET1^DIQ(601.72,IENS,1,,"YSQUES","YSERR"),YSX1=0,YSX2=""
 I $D(YSERR) G GQE
 I '$D(YSQUES) G GQE
 S YSX=0
 F  S YSX=$O(YSQUES(YSX)) Q:YSX=""  D
 . S YSX1=YSX1+1,YSX2=3_"."_YSX1
 . S YSMSG(YSX2)=YSQUES(YSX),YSMSG(YSX2,"F")="!?8"
GQE K IENS,YSQUES,YSERR,YSX,YSX1,YSX2
 Q
 ;
PEM ;Process Error Message
 ;Add Error Text to User Message
 I '$D(YSERR) Q
 I '$D(YSERL) S YSERL=1
 S YSX=$P(YSERR("DIERR"),U)
 F YSX1=1:1:YSX D
 . S YSMSG(YSERL)="Error Code: "_YSERR("DIERR",YSX1)
 . S YSMSG(YSERL,"F")="!"
 . S YSX2=0
 . F  S YSX2=$O(YSERR("DIERR",YSX1,"TEXT",YSX2)) Q:YSX2=""  D
 . . S YSERL=YSERL+YSX2
 . . S YSMSG(YSERL)=YSERR("DIERR",YSX1,"TEXT",YSX2)
 . . S YSMSG(YSERL,"F")="!"
 K YSERL,YSERR,YSX,YSX1,YSX2
 Q
 ;
UM ;User Messages
 ;Display messages to the user
 D EN^DDIOL(.YSMSG)
 ;Build MailMan Message from user messages
 S YSX=0
 F   S YSX=$O(YSMSG(YSX)) Q:YSX=""  D
 . S YSX1=YSMSG(YSX)
 . I YSMSG(YSX,"F")="!!" S YSCNT=YSCNT+1,YSMAIL(YSCNT)=""
 . I YSMSG(YSX,"F")["?" D
 . . S YSX2=$$REPEAT^XLFSTR(" ",$P(YSMSG(YSX,"F"),"?",2))
 . . S YSX1=YSX2_YSX1
 . S YSCNT=YSCNT+1
 . S YSMAIL(YSCNT)=YSX1
 K YSMSG,YSX,YSX1,YSX2
 Q
 ;
SMM ;Send MailMan message to user
 N DIFROM
 S XMDUZ=.5
 S XMSUB=YSMAIL(1)
 S XMY(DUZ)=""
 S XMTEXT="YSMAIL("
 D ^XMD
 I '$D(XMMG) D EN^DDIOL("Report successfully sent.","","!!")
 K XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 Q
 ;
KYSV ;Kill YS Variables
 K YSACI,YSDEX,YSERR,YSFDA,YSFLD,YSFLG,YSIEN
 K YSIENS,YSML,YSMSG,YSREC,YSSCR,YSVAL
 Q
