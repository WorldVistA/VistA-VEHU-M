ZZFIND ;
 S N=$ZO(^XTV(8989.5,0))
 S M=@N
 D CHECKIT(M,N)
NEXT ;
 S N=$ZO(@N)
 I N'["XTV(8989.5" S DIK="^XTV(8989.5," W !,"Indexing Parameter File " D IXALL^DIK D FINISH Q
 S M=@N
 D CHECKIT(M,N)
 G NEXT
 Q
CHECKIT(X,Y)      ;
 I X["DIC(4.2," D
 . S Z=X
 . I ^%ZOSF("PROD")="CPA" S $P(X,";",1)=401
 . I ^%ZOSF("PROD")="CPB" S $P(X,";",1)=402
 . W !,Y,?15," = ",?25,X
 . S @Y=X
 Q
FINISH ;
 W !,"FINISHING....."
 I ^%ZOSF("PROD")="CPA" S ^XMB("NUM")=401,$P(^XMB(1,1,0),"^",1)=401,$P(^XTV(8989.3,1,0),"^",1)=401,$P(^HLCS(869.3,1,0),"^",2)=401,$P(^HLCS(869.3,1,0),"^",4)=17034
 I ^%ZOSF("PROD")="CPB" S ^XMB("NUM")=402,$P(^XMB(1,1,0),"^",1)=402,$P(^XTV(8989.3,1,0),"^",1)=402,$P(^HLCS(869.3,1,0),"^",2)=402,$P(^HLCS(869.3,1,0),"^",4)=17035
 Q
