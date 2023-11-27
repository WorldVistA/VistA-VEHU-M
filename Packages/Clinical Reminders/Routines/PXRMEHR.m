PXRMEHR ;SLC/AGP - Computed findings for EHR cutover. ;Apr 25, 2023@13:17
 ;;2.0;CLINICAL REMINDERS;**82**;Feb 4, 2005;Build 28
 ;
 ; Reference to ACCESS^ORACCESS in ICR #7356
 ; Reference to TABNAMES^ORACCESS in ICR #7356
 ;
CUTOVER(DFN,NGET,BDT,EDT,NFOUND,TEST,DATE,DATA,TEXT) ;
 N ACCESS,ALLORDERS,CNT,CUTOVER,DG,DGACCESS,NOTES,OTHACCESS,PXRMWA,SRT,TAB,TABS,TCNT,TXT
 S NFOUND=0,TCNT=0
 ;I '$$ONEHR^ORACCESS Q
 ;format write access into local array
 D ACCESS^ORACCESS(.PXRMWA,DUZ,2,.NOTES)
 F TAB="consults","dcSumm","meds","notes","orders","problems","surgery" D
 .I $G(PXRMWA("cprsAccess",TAB,"writeAccess"))'=1 Q
 .S ACCESS(TAB)=""
 F TAB="allergy","delayedOrders","encounters","immunization","reminderEditor","vital","womenHealth" D
 .I $G(PXRMWA("cprsAccess",TAB,"writeAccess"))'=1 Q
 .S OTHACCESS(TAB)=""
 I $D(ACCESS("orders")) D
 .S ALLORDERS=1
 .S CNT=0 F  S CNT=$O(PXRMWA("cprsAccess","orders","displayGroups",CNT)) Q:CNT'>0  D
 ..I $G(PXRMWA("cprsAccess","orders","displayGroups",CNT,"writeAccess"))'=1 S ALLORDERS=0 Q
 ..S DG=$G(PXRMWA("cprsAccess","orders","displayGroups",CNT,"name")) I DG="" Q
 ..S DGACCESS(DG)=""
 ;
 I '$D(ACCESS),'$D(OTHACCESS) D  Q
 .S NFOUND=1
 .S TEST(1)=1
 .S DATE(1)=DT
 .S DATA(1,"NO ACCESS")="No CPRS write access allowed"
 .I $D(NOTES) D
 ..S DATA(NFOUND,"ADDITIONAL INFO")="",TXT="\\"
 ..S CNT=0 F  S CNT=$O(NOTES(CNT)) Q:'CNT  D
 ...S TCNT=TCNT+1,TEXT(TCNT)="\\"_NOTES(CNT)
 ...I NOTES(CNT)="" S TXT="\\ \\"
 ...E  D
 ....S DATA(NFOUND,"ADDITIONAL INFO")=DATA(NFOUND,"ADDITIONAL INFO")_TXT_NOTES(CNT)
 ....S TXT="\\"
 D TABNAMES^ORACCESS(.TABS)
 S NFOUND=1,TEST(1)=1
 S DATE(1)=DT
 S TCNT=0
 ;evaluate CPRS Tab write functionality
 S DATA(NFOUND,"TAB ACCESS")="No write access to Consults, Discharge Summaries, Meds, Notes, Orders, Problems, Surgery"
 I $D(ACCESS) D
 .S DATA(NFOUND,"TAB ACCESS")="Write access allow for the following tabs:"
 .S TCNT=TCNT+1,TEXT(TCNT)=DATA(NFOUND,"TAB ACCESS")
 .S TAB="",CNT=0 F  S TAB=$O(ACCESS(TAB)) Q:TAB=""  D
 ..S CNT=CNT+1,DATA(NFOUND,"TABS",CNT)=$G(TABS(TAB))_$$TEMPLATE(.PXRMWA,TAB)
 ..S TCNT=TCNT+1,TEXT(TCNT)="\\   "_DATA(NFOUND,"TABS",CNT)
 ;
 ;evaluate other information write access
 S DATA(NFOUND,"OTHER ACCESS")="No write access for Allergies, Encounters, Immunizations, Reminder Coversheet Editor, Vitals, Women Health"
 I $D(OTHACCESS) D
 .S DATA(NFOUND,"OTHER ACCESS")="Write access allow for the following additional functionality:"
 .I TCNT>0 S TCNT=TCNT+1,TEXT(TCNT)="\\  \\Write access allow for the following functionality"
 .S TAB="",CNT=0 F  S TAB=$O(OTHACCESS(TAB)) Q:TAB=""  D
 ..I TAB="delayedOrders" Q
 ..S CNT=CNT+1,DATA(NFOUND,"OTHER",CNT)=$G(TABS(TAB))
 ..S TCNT=TCNT+1,TEXT(TCNT)="\\   \\"_DATA(NFOUND,"OTHER",CNT)
 ;
 I $D(NOTES) D
 .S DATA(NFOUND,"ADDITIONAL INFO")="",TXT="\\"
 .S CNT=0 F  S CNT=$O(NOTES(CNT)) Q:'CNT  D
 ..S TCNT=TCNT+1,TEXT(TCNT)="\\"_NOTES(CNT)
 ..I NOTES(CNT)="" S TXT="\\ \\"
 ..E  D
 ...S DATA(NFOUND,"ADDITIONAL INFO")=DATA(NFOUND,"ADDITIONAL INFO")_TXT_NOTES(CNT)
 ...S TXT="\\"
 ;
 ;evaluate ordering write access
 I '$D(ACCESS("orders")) Q
 I $G(ALLORDERS)=1,$D(OTHACCESS("delayedOrders")) D  Q
 .S TCNT=TCNT+1,TEXT(TCNT)="All order functionality is enabled"
 .;S DATA(NFOUND,"ORDER TEXT")="All order functionality is enabled"
 S TCNT=TCNT+1,TEXT(TCNT)="\\Ordering write access allow for the following display groups:"
 S DATA(NFOUND,"ORDER ACCESS")="Ordering write access is allow for the following display groups"
 S DG="",CNT=0 F  S DG=$O(DGACCESS(DG)) Q:DG=""  D
 .S CNT=CNT+1,DATA(NFOUND,"DISPLAY GROUPS",CNT)=DG
 .S TCNT=TCNT+1,TEXT(TCNT)="\\   "_DG
 ;
 S DATA(NFOUND,"DELAYED ORDER")=$S('$D(OTHACCESS("delayedOrders")):"Delayed Order not allowed",1:"Delayed Orders allowed")
 S TCNT=TCNT+1,TEXT(TCNT)="\\   \\Delayed Orders "_$S('$D(OTHACCESS("delayedOrders")):"is not allowed",1:"is allowed")
 ;
 Q
 ;
TEMPLATE(PXRMWA,TAB) ;
 I TAB'="consults",TAB'="dcSumm",TAB'="notes",TAB'="surgery" Q ""
 I PXRMWA("cprsAccess",TAB,"writeAccess")=1 Q ", template access allowed"
 Q ", template access not allowed"
 ;
