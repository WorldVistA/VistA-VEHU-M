YS187PST ;BAL/KTL- Patch 187 Post-Init ; 07/28/2021 3:19pm
 ;;5.01;MENTAL HEALTH;**187**;Dec 30, 1994;Build 74
 ;
 ; Routine ICR
 ; Name                                      ICR#
 ; -------------------------------------    -----
 ; SUPPORTED PARAMETER TOOL ENTRY POINTS    2263
 ; KERNEL XLFJSON                           6682 
 ;
 Q
POST ;
 ; Delete namespaced logging for MCMI4
 N J
 K ^TMP("YKTL")
 S J="" F  S J=$O(^YKTL(J)) Q:J=""  D
 . K ^YKTL(J)
 ; Update Case Mix Tool
 D POST^YS187CMT
 D MKBAT
 D SSRRTN
 Q
MKBAT ;Find all users with Battery definitions and create PARAMETER entries
 ;     for MHA Web
 N YSUSR,JARR,YSJSON,PRES
 N YSWDGT,YSWPARR,YSDUZ
 S YSUSR=0 F  S YSUSR=$O(^YTT(601.781,"AC",YSUSR)) Q:YSUSR=""  D
 . S YSWDGT=1
 . S YSDUZ=YSUSR_";VA(200,"
 . K YSWPARR
 . D GETWP^XPAR(.YSWPARR,YSDUZ,"YS MHA_WEB BATTERIES",YSWDGT)
 . I '$D(YSWPARR) D
 .. K JARR,YSJSON
 .. D BATTC(YSUSR,.JARR)
 .. D ENCODE^XLFJSON("JARR","YSJSON")
 .. S PRES=$$SETPARAM("YS MHA_WEB BATTERIES",.YSJSON,YSUSR)
 Q
BATTC(YSUSR,JARR) ;battery content
 ; OUTPUT: BATTERY NAME ^ INSTRUMENT list sorted by BATTERY & SEQUENCE
 N G7,YSBATS,YSBID,YSCONID,YSNAME,YSUB,YS1,YSBNAME,BATNUM,ISEQ,INAM
 S YSUB=0 F  S YSUB=$O(^YTT(601.781,"AC",YSUSR,YSUB)) Q:YSUB'>0  D
 . S YSBID=$P(^YTT(601.781,YSUB,0),U,3)
 . S YSBNAME=$P($G(^YTT(601.77,YSBID,0)),U,2)
 . S:$L(YSBNAME) YS1(YSBNAME)=YSBID
 S BATNUM=0
 S YSNAME="" F  S YSNAME=$O(YS1(YSNAME)) Q:YSNAME=""  S YSBID=YS1(YSNAME) D
 . S BATNUM=BATNUM+1
 . S YSBATS=0 F  S YSBATS=$O(^YTT(601.78,"AC",YSBID,YSBATS)) Q:YSBATS'>0  D
 .. S YSCONID=$O(^YTT(601.78,"AC",YSBID,YSBATS,0))
 .. S G7=$G(^YTT(601.78,YSCONID,0))
 .. S ISEQ=$P(G7,U,3)
 .. S INAM=$$GET1^DIQ(601.78,YSCONID_",",3)
 .. S JARR("batteries",BATNUM,"name")=YSNAME
 .. S JARR("batteries",BATNUM,"instruments",ISEQ)=INAM
 Q
SETPARAM(YSPNAM,YSJSON,YSUSR)  ;Set Parameter
 ; Batteries=YS MHA_WEB BATTERIES
 N II,YSDUZ
 N FDA,IENS,FDAIEN,YSMSG
 N YSINST
 S YSINST=1
 S YSDUZ=YSUSR_";VA(200,"
 D EN^XPAR(YSDUZ,YSPNAM,YSINST,.YSJSON,.YSMSG)
 I +YSMSG'=0 Q "ERROR: "_$P(YSMSG,U,2)
 Q "OK"
SSRRTN ; Set the Suicide TAG & ROUTINE fileds in 601.71
 N TEMP,CNT,TEST,YSFDA,INSTIEN,XXX,TAG,YSERR
 K YSFDA
 S TEMP=""
 F CNT=1:1:2 D
 . S TEMP=$T(INSTF+CNT)
 . S TEMP=$P(TEMP,";;",2)
 . S TEST=$P(TEMP,U,1) D
 . S INSTIEN="" S INSTIEN=$O(^YTT(601.71,"B",TEST,""))
 . S XXX=INSTIEN_","
 . S YSFDA(601.71,XXX,95)="YTQRQAD6"
 . S TAG=$P(TEMP,U,2)
 . I TAG="zzzzz" Q
 . S YSFDA(601.71,XXX,96)=TAG
 D FILE^DIE("K","YSFDA","YSERR")
 I $G(YSERR)'="" W !,"ERROR= ",YSERR
 Q
 ;
INSTF ;HIGH RISK/POSTIIVE RESPONSE Instrument updates
 ;;BDI2^BDI2
 ;;CCSA-DSM5^CCSA
 ;;zzzzz
 ;
 Q
