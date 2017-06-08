ORB3P9 ; slc/CLA - Post INIT for OR*3*9 v2 ;5/13/98  13:34
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 ;
EN ;fix ORB PROCESSING FLAG parameter values ("E" values are now invalid)
 ;
 N X
 S X="Converting ""no valued"" OE/RR entries for parameter ORB PROCESSING FLAG..."
 D BMES^XPDUTL(X)
 D PKGCHG
 S X="ORB PROCESSING FLAG ""no value"" conversion complete."
 D BMES^XPDUTL(X)
 Q
PKGCHG ;change package (OE/RR) "no valued" notifications to "E"nabled
 N ORPIEN,ORENT,ORBN,ORPKG,ORBERR,X
 S ORPIEN=0
 S ORPIEN=$O(^XTV(8989.51,"B","ORB PROCESSING FLAG",ORPIEN)) Q:ORPIEN=""
 Q:+$G(ORPIEN)<1
 S ORENT="" F  S ORENT=$O(^XTV(8989.5,"AC",ORPIEN,ORENT)) Q:ORENT=""  D
 .I $P(ORENT,";",2)="DIC(9.4," D
 ..S ORBN=0
 ..F  S ORBN=$O(^ORD(100.9,ORBN)) Q:+$G(ORBN)<1  D
 ...I $G(^XTV(8989.5,"AC",ORPIEN,ORENT,ORBN))="" D
 ....S X="   Converting OE/RR 'no value' to 'Enabled' for notification "_$P(^ORD(100.9,ORBN,0),U)_"..."
 ....D BMES^XPDUTL(X)
 ....D EN^XPAR("PKG","ORB PROCESSING FLAG","`"_ORBN,"E",.ORBERR)
 ....I +ORBERR>0 D
 .....S X="Error: "_ORBERR_" - converting OE/RR 'no value' to 'E' for notification "_$P(^ORD(100.9,ORBN,0),U)_"!"
 .....D BMES^XPDUTL(X)
 Q
