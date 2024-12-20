WVUTL12 ;ISP/RFR - TERATOGENIC DRUGS UTILITY FUNCTIONS;Dec 14, 2020@12:09
 ;;1.0;WOMEN'S HEALTH;**26**;Sep 30, 1998;Build 624
 Q
GETORDRS(WVDFN,WVLAC) ;Entry point for retrieving harmful orders
 ; INPUT: WVLAC - 1 to indicate calling context is lactation
 ;                0 (default) to indicate calling context is not lactation
 ; OUTPUT: $$GETORDRS - Global node address where orders are stored
 S WVDFN=+$G(WVDFN),WVLAC=+$G(WVLAC)
 Q:WVDFN<1 ""
 N INPUT,WVRETURN,WVORN,WVORDCHK,WVEXPDATE,WVNODE
 S INPUT("SUB")="WVDATA",INPUT("DFN")=WVDFN
 S INPUT("ROC","ALL")=""
 S INPUT("ROC DISPLAY GROUPS","PHARMACY")="",INPUT("ROC DISPLAY GROUPS","IMAGING")=""
 S INPUT("ROC DISPLAY GROUPS","IMAGING","START")=$$GET^XPAR("ALL","WV IMAGING ORDER START DT",1,"I")
 S INPUT("ROC DISPLAY GROUPS","IMAGING","STOP")=DT
 S INPUT("ROC STATUS","HOLD")=""
 S INPUT("ROC STATUS","PENDING")=""
 S INPUT("ROC STATUS","SCHEDULED")=""
 S INPUT("ROC STATUS","ACTIVE")=""
 S INPUT("ROC STATUS","EXPIRED")=""
 S INPUT("ROC RETURN TYPE","RULES")="",INPUT("ROC RETURN TYPE","OI")=""
 D EN^PXRMGEV(.WVRETURN,.INPUT)
 S WVEXPDATE=$$FMADD^XLFDT($$DT^XLFDT,-90)
 S WVORN=0 F  S WVORN=$O(^TMP($J,"WVDATA",WVORN)) Q:'+WVORN  D
 .S WVORDCHK=0 F  S WVORDCHK=$O(^TMP($J,"WVDATA",WVORN,"RULES",WVORDCHK)) Q:WVORDCHK=""  D
 ..I $E(WVORDCHK,1,13)'="VA-WH HIRISK " K ^TMP($J,"WVDATA",WVORN,"RULES",WVORDCHK) Q
 ..S WVNODE=$G(^TMP($J,"WVDATA",WVORN))
 ..I WVORDCHK'["IMAGING" D
 ...I $P(WVNODE,U,6)="EXPIRED",$P(WVNODE,U,5)<WVEXPDATE K ^TMP($J,"WVDATA",WVORN) Q
 ...I WVLAC D
 ....N WVOIN,WVAGENT,WVPKG
 ....S WVOIN=0 F  S WVOIN=$O(^TMP($J,"WVDATA",WVORN,"OI",WVOIN)) Q:'+WVOIN!($G(WVAGENT))  D
 .....S WVPKG=$P($G(^TMP($J,"WVDATA",WVORN,"OI",WVOIN)),U,2) Q:WVPKG'["PSP"
 .....S WVAGENT=$$IMGAGNT(+WVPKG)
 ....S ^TMP($J,"WVDATA",WVORN,"IMGAGNT")=+$G(WVAGENT)
 ..I WVORDCHK["IMAGING",$P(WVNODE,U,6)="EXPIRED" K ^TMP($J,"WVDATA",WVORN)
 .I '$D(^TMP($J,"WVDATA",WVORN,"RULES")) K ^TMP($J,"WVDATA",WVORN) Q
 I $O(^TMP($J,"WVDATA",0))="" S ^TMP($J,"WVDATA",0)=0
 Q $G(WVRETURN)
IMGAGNT(WVOIIEN) ;Return true if the orderable item resolves to an imaging agent
 ;INPUT: WVOIIEN - IEN of entry in PHARMACY ORDERABLE ITEM file (#50.7)
 S WVOIIEN=+$G(WVOIIEN)
 Q:WVOIIEN<1 -1
 N WVDIENS,WVDIEN,WVRET,WVGNAME
 S WVGNAME="VA-WH HIRISK IMAGING AGENTS GROUP"
 D ITEMLIST^PXRMAPI("",WVGNAME,"A","WVROCDATA")
 D DRGIEN^PSS50P7(WVOIIEN,DT,"WVDRUGS")
 I $G(^TMP($J,"WVDRUGS",0))>0 M WVDIENS=^TMP($J,"WVDRUGS") K WVDIENS(0)
 K ^TMP($J,"WVDRUGS")
 S WVDIEN=0 F  S WVDIEN=$O(WVDIENS(WVDIEN)) Q:'+WVDIEN!($G(WVRET))  D
 .I $D(^TMP($J,"WVROCDATA",WVGNAME,"P",WVDIEN_";PS(50,")) S WVRET=1 Q  ;DRUG IEN
 .D DATA^PSS50(WVDIEN,,,,,"WVDRUG")
 .I $D(^TMP($J,"WVROCDATA",WVGNAME,"P",$P($G(^TMP($J,"WVDRUG",WVDIEN,25)),U)_";PS(50.605,")) S WVRET=1 ;VA CLASSIFICATION
 .I $D(^TMP($J,"WVROCDATA",WVGNAME,"P",$P($G(^TMP($J,"WVDRUG",WVDIEN,20)),U)_";PSNDF(50.6,")) S WVRET=1 ;VA GENERIC
 .I $D(^TMP($J,"WVROCDATA",WVGNAME,"P",$P($G(^TMP($J,"WVDRUG",WVDIEN,22)),U)_";PSNDF(60.58,")) S WVRET=1 ;VA PRODUCT
 .K ^TMP($J,"WVDRUG")
 K ^TMP($J,"WVROCDATA")
 Q +$G(WVRET)
