VEJDINST ;DSS/SGM - VEJD CORE INSTALL ROUTINE ;12/04/2002 15:47
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine contains any environmental checks, pre-install calls,
 ;  and post install calls for the KIDS build for the VEJD DSS CORE
 ;  RPCS package.
 ;
ENV ;  environmental check
 ;  must have a DSIC package installed
 Q:$$VERSION^XPDUTL("DSIC")
 W !!,"This build expects that the DSIC package to have been installed"
 W !,"Please install the latest version of VA CERTIFIED COMPONENTS - DSSI"
 W !!
 S:XPDENV=1 XPDQUIT=2
 Q
 ;
PRE ;  pre-install
 Q
 ;
POST ;  post install
 D INSTOBJ
 I $T(VA^VEJDICIB)'="" D ^VEJDICIB
 I $T(VA^VEJDICIP)'="" D ^VEJDICIP
 Q
INSTOBJ ;Install Objects if needed
 N OBJ,GUID,EGUID,FIL,MES,II,IEN,VEJD,ROOT
 F II=1:1 S OBJ=$P($T(GUI+II),";;",2) Q:OBJ="**END OBJ**"  D
 .S GUID=$P(OBJ,U,2),OBJ=$P(OBJ,U)
 .S IEN=+$O(^ORD(101.15,"B",OBJ,0)) S EGUID=$P($G(^ORD(101.15,IEN,0)),U,2)
 .I IEN S MES="OE/RR COM OBJECT FOUND FOR "_OBJ_"!" D MES^DSICXPDU(MES,1) D:EGUID'=GUID  Q
 ..S FIL=101.15,ROOT(FIL,IEN_",",.02)=GUID D FILE^DIE("","ROOT")
 .S FIL=101.15,ROOT(FIL,"+1,",.01)=OBJ,ROOT(FIL,"+1,",.02)=GUID
 .D UPDATE^DIE("","ROOT","VEJD")
 .I $G(VEJD(1))>0 S MES="OE/RR COM OBJECT "_OBJ_" ADDED!" D MES^DSICXPDU(MES,1) Q
 .S MES="UNABLE TO ADD OE/RR COM OBJECT "_OBJ_"! PLEASE CONTACT DSSI." D MES^DSICXPDU(MES,1)
 Q
GUI ;;
 ;;CNT Navigator^{DE3A8A0C-F552-482F-A6A6-4CE23BC85209}
 ;;VRM COM TEMPLATE^{C54549B2-B943-43C8-B3F7-4C4E67C1194A}
 ;;**END OBJ**
