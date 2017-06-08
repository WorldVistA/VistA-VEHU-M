XPARZUTL ; SLC/KCM - Temporary Utilities for Parameters
 ;;7.3;TOOLKIT;**26**;Apr 25, 1995
 ;
 Q
LIST(NSP) ; procedure
 ; lists all parameter values in a namespace
 N X,PAR,ENT,INST,ENTNAME,VAL
 S X=NSP
 F  S X=$O(^XTV(8989.51,"B",X)) Q:$E(X,1,$L(NSP))'=NSP  D
 . S PAR=$O(^XTV(8989.51,"B",X,0))
 . S ENT="" F  S ENT=$O(^XTV(8989.5,"AC",PAR,ENT)) Q:ENT=""  D
 . . S INST="" F  S INST=$O(^XTV(8989.5,"AC",PAR,ENT,INST)) Q:INST=""  D
 . . . S ENTNAME=$P(@("^"_$P(ENT,";",2)_+ENT_",0)"),"^",1)
 . . . S VAL=^XTV(8989.5,"AC",PAR,ENT,INST)
 . . . W $E(ENTNAME,1,20),?21,$E($P(^XTV(8989.51,PAR,0),"^",1),1,30),?52
 . . . W $E($$EXT^XPARDD(INST,PAR,"I"),1,10),?65
 . . . W $E($$EXT^XPARDD(VAL,PAR,"V"),1,12),!
 Q
CHKPAR ; search parameters file for broker pointers
 N IEN,ENT,PAR,BROKE
 S IEN=0 F  S IEN=$O(^XTV(8989.5,IEN)) Q:'IEN  D
 . S X=^XTV(8989.5,IEN,0),ENT=$P(X,U),PAR=$P(X,U,2),BROKE=""
 . I '$D(@(U_$P(ENT,";",2)_+ENT_",0)")) S BROKE="Missing Entity"
 . I '$D(^XTV(8989.51,PAR,0)) S BROKE="Missing Param"
 . I $L(BROKE) W !,BROKE," IEN:",IEN," Data:",^XTV(8989.5,IEN,0)
 Q
TEST ; test parameter calls
 D ADD^XPAR("PKG","XPAR TEST NUMERIC",1,98,.ERR) W !,"ADD:",ERR
 D CHG^XPAR("PKG","XPAR TEST NUMERIC",1,22,.ERR) W !,"CHG:",ERR
 W !,"GET:",$$GET^XPAR("ALL","XPAR TEST NUMERIC")
 D DEL^XPAR("PKG","XPAR TEST NUMERIC",1,.ERR) W !,"DEL:",ERR
 Q
SCDVC ; convert service copy device
 N LST,ENT,PKG,VAL,ERR
 D ENVAL^XPAR(.LST,"ORPF SERVICE COPY PRINT DEVICE")
 S ENT=0 F  S ENT=$O(LST(ENT)) Q:'ENT  D
 . S PKG=0 F  S PKG=$O(LST(ENT,PKG)) Q:'PKG  D
 . . S VAL=LST(ENT,PKG)
 . . D EN^XPAR(ENT,"ORPF SERVICE COPY DEFLT DEVICE",PKG,VAL,.ERR)
 . . I ERR W !,ERR," Pkg: ",PKG
 . . ; D EN^XPAR(ENT,"ORPF SERVICE COPY PRINT DEVICE",PKG,"@",.ERR)
 Q
