ZORCCPAR ;SLC/JFR - Set CM params for ITC/Camp ; 7/31/03 15:17
 ;;1.0
 ;
EN ; START HERE
 N PERS,USR,ANERR
 S PERS="CAMP,"
 F  S PERS=$O(^VA(200,"B",PERS)) Q:$E(PERS,1,5)'="CAMP,"  D
 . S USR=$O(^(PERS,0))
 . D EN^XPAR(USR_";VA(200,","XHD PRISM PERSPECTIVE SELECTOR",1,"`12347",.ANERR) I $G(ANERR) W !,PERS," Perspectives" K ANERR
 . D EN^XPAR(USR_";VA(200,","ORRC NURSE RESULT DATE MIN",1,"T-180",.ANERR) I $G(ANERR) W !,PERS,"Nurse Results" K ANERR
 . D EN^XPAR(USR_";VA(200,","ORRC NURSE UNVERIFIED DATE MAX",1,"T-180",.ANERR) I $G(ANERR) W !,PERS," Nurse Unv. orders" K ANERR
 . D EN^XPAR(USR_";VA(200,","ORRC NURSE UNVERIFIED DATE MIN",1,"T",.ANERR) I $G(ANERR) W !,PERS," Nurse Unv. orders min." K ANERR
 . D EN^XPAR(USR_";VA(200,","ORRC NURSE VITALS DATE MIN",1,"T-180",.ANERR) I $G(ANERR) W !,PERS K ANERR
 Q
