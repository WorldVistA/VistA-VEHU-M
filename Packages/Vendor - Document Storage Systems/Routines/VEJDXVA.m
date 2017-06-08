VEJDXVA ;AMC - Document Storage Systems ;New Person File RPC's
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
USERCLS(AXY,DFN)        ;Return Person Classes from file 200
 ;DFN - User internal number
 I '$G(DFN) S AXY(0)="-1^Invalid Input!" Q
 I '$O(^VA(200,DFN,"USC1",0)) S AXY(0)="0^No Person Classes Found!" Q
 N EFFDT,EXPDT,FIL,FLDS,XX,YY,II S FIL=8932.1,FLDS=".01:6",(AXY,XX)=0
 F  S XX=$O(^VA(200,DFN,"USC1",XX)) Q:'XX  S YY=$G(^(XX,0)) D:YY
 .N GET,IENS S EFFDT=$P(YY,U,2),EXPDT=$P(YY,U,3),IENS=+YY_","
 .D GETS^DIQ(FIL,IENS,FLDS,"EI","GET")
 .S AXY=AXY+1,AXY(AXY)=XX_U_+YY_U_$G(GET(FIL,IENS,5,"E"))_U_EFFDT_U_EXPDT
 .S AXY(AXY)=AXY(AXY)_U_$S($G(GET(FIL,IENS,3,"I"))]"":GET(FIL,IENS,3,"I")_";"_GET(FIL,IENS,3,"E"),1:"")
 .S AXY(AXY)=AXY(AXY)_U_$G(GET(FIL,IENS,6,"E"))
 .S AXY(AXY)=AXY(AXY)_U_$G(GET(FIL,IENS,4,"I"))
 .F II=.01,1,2 S AXY(AXY)=AXY(AXY)_U_$G(GET(FIL,IENS,II,"E"))
 Q
