OR529P ;SPFO/AJB - VISTA CUTOVER ;Feb 11, 2021@09:04:47
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**529**;Dec 17, 1997;Build 17
 Q
POST ;
 N DATA,I F I=1:1 S DATA=$P($T(DATA+I),";;",2) Q:DATA=""  D
 . N ERR,FDA,MENU,OPT
 . S MENU=$$LU(19,$P(DATA,U)),OPT=$$LU(19,$P(DATA,U,2)) I '+MENU!('+OPT) Q
 . I +$$LU(19.01,$P(DATA,U,2),"","","",","_MENU_",") Q
 . S MENU="+1,"_MENU_","
 . S FDA(19.01,MENU,.01)=OPT
 . S FDA(19.01,MENU,2)=$P(DATA,U,3)
 . D UPDATE^DIE("","FDA","",.ERR)
 Q
DATA ;
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07A FLAG INPT ORD^1
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07B FLAG INPT ORD PR^2
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07C FLAG INPT RESULTS^3
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07D FLAG INPT RSLTS PR^4
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07E FLAG INPT EXP ORD^5
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07F FLAG INPT EO PR^6
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07G FLAG OUTPT ORD^7
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07H FLAG OUTPT ORD PR^8
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07I FLAG OUTPT RESULTS^9
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07J FLAG OUTPT RSLT PR^10
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07K FLAG OUTPT EXP ORD^11
 ;;ORB3 LM 07 FLAG ORD ITEMS MENU^ORB3 LM 07L FLAG OUTPT EO PR^12
 ;;ORB3 LM 09  FORWARD NOTIF MENU^ORB3 LM 09A FOR UNP NOT SUP^1
 ;;ORB3 LM 09  FORWARD NOTIF MENU^ORB3 LM 09B FOR UNP NOT SUR^2
 ;;ORB3 LM 09  FORWARD NOTIF MENU^ORB3 LM 09C FOR UNP NOT BKR^3
 ;;ORB3 LM 10 SET DELAYS MENU^ORB3 LM 10A DELAY UNV ORDERS^1
 ;;ORB3 LM 10 SET DELAYS MENU^ORB3 LM 10B DEL UNV MED ORDERS^2
 ;;
LU(FILE,NAME,FLAGS,SCREEN,INDEXES,IENS) ;
 N DILOCKTM,DISYS
 Q $$FIND1^DIC(FILE,$G(IENS),$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN),"ERR")
