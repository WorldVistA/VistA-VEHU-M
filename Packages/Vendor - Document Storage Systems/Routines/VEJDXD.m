VEJDXD ;AMC - Document Storage Systems; File utilities
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
REVLU(AXY,FILE,FIELDS,RCRDS,START)      ;Reverse file retrieval
 S AXY=$NA(^TMP("VEJDXD1",$J)) K ^TMP("VEJDXD1",$J)
 I '$G(FILE)!'$G(FIELDS)!'$G(RCRDS) S ^TMP("VEJDXD1",$J,0)="-1^Invalid Input!" Q
 N GLNM,GET,Y,X,XLIN,REC,FLDS,ZZ S START=$S($G(START):START,1:"A")
 S GLNM=$G(^DIC(FILE,0,"GL")),FLDS=$TR(FIELDS,U,";"),ZZ=0 I GLNM="" S ^TMP("VEJDXD1",$J,0)="-1^Unkonwn File Number!" Q
 S XLIN="F X=1:1:RCRDS S Y=$O("_GLNM_"Y),-1) Q:'Y  ZW  D GET"
 S Y=START X XLIN
 I '$O(^TMP("VEJDXD1",$J,0)) S ^TMP("VEJDXD1",$J,0)="-1^No Records Found!" Q
 Q
GET ;
 N IENS,PP,PP1 S IENS=Y_","
 D GETS^DIQ(FILE,IENS,FLDS,"EI","GET")
 S REC=Y F PP=1:1:$L(FIELDS,U) S PP1=$P(FIELDS,U,PP),REC=REC_U_$S($G(GET(FILE,IENS,PP1,"I"))]"":GET(FILE,IENS,PP1,"I")_";"_$G(GET(FILE,IENS,PP1,"E")),1:"")
 S ZZ=ZZ+1,^TMP("VEJDXD1",$J,ZZ)=REC
 K GET Q
GETKEY(AXY)     ;
 L +^VEJDTMP(0) N X S X=$P(^VEJDTMP(0),U,3)
 F X=X:1 Q:'$D(^VEJDTMP(X))
 S ^VEJDTMP(X,0)=X,^VEJDTMP(X,1,0)="^19619.991^^",$P(^VEJDTMP(0),U,3)=X,$P(^(0),U,4)=$P(^(0),U,4)+1
 S AXY=X L -^VEJDTMP(0)
 Q
ADDATA(AXY,IEN,DATA)    ;
 I '$G(IEN) S AXY="-1^Invalid Input!" Q
 I '$D(^VEJDTMP(IEN,1,0)) S AXY="-1^Entry not found!" Q
 N X,Y S Y=+$P(^VEJDTMP(IEN,1,0),U,3)+1,X=0
 F Y=Y:1 S X=$O(DATA(X)) Q:'X  S ^VEJDTMP(IEN,1,Y,0)=DATA(X)
 S $P(^VEJDTMP(IEN,1,0),U,3)=Y-1
 S AXY=1 Q
MOVEDATA(AXY,FILE,TOIEN,MULT,GETFROM)   ;
 I '$G(FILE)!'$G(TOIEN)!'$G(MULT)!'$G(GETFROM) S AXY="-1^Invalid Input!" Q
 N ROOT,X
 S ROOT=^DIC(FILE,0,"GL")_TOIEN_","_$P($P(^DD(FILE,MULT,0),U,4),";")_",",@(ROOT_"0)")="^"_$P(^DD(FILE,MULT,0),U,2)_"^"
 S X=0 F  S X=$O(^VEJDTMP(GETFROM,1,X)) Q:'X  S @(ROOT_X_",0)")=^(X,0)
 S DA=GETFROM,DIK="^VEJDTMP(" D ^DIK
 S AXY=1 Q
GETWORD(AXY,FILE,IEN,FIELD)     ;
 K ^TMP("VEJDXD2",$J) S AXY=$NA(^TMP("VEJDXD2",$J))
 I '$G(FILE)!'$G(IEN)!'$G(FIELD) S ^TMP("VEJDXD2",$J,0)="-1^Invalid Input!" Q
 I '$D(^DIC(FILE,0,"GL"))!'$D(^DD(FILE,FIELD,0)) S ^TMP("VEJDXD2",$J,0)="-1^File Dictionary not found!" Q
 N ROOT,X,Y S Y=0
 S ROOT=^DIC(FILE,0,"GL")_IEN_","_$P($P(^DD(FILE,FIELD,0),U,4),";")_","
 F X=1:1 S Y=$O(@(ROOT_Y_")")) Q:'Y  S ^TMP("VEJDXD2",$J,X)=^(Y,0)
 I '$D(^TMP("VEJDXD2",$J)) S ^TMP("VEJDXD2",$J,0)="0^No Text Found!"
 Q
DATECNV(AXY,DATE,TIME) ;RPC - VEJD XUTIL DATE CONVERSION
 I $G(DATE)="",$G(TIME)="" S AXY="-1^Invalid Input!" Q
 S AXY="",DATE=$G(DATE),TIME=$G(TIME),NODT=DATE=""
 N %DT,Y,X S %DT="STX",X=$S(DATE]"":DATE_$S(TIME]"":"@"_TIME,1:""),1:"TODAY@"_TIME) D ^%DT
 S AXY=$S('NODT:Y,1:$P(Y,".",2))
 Q
