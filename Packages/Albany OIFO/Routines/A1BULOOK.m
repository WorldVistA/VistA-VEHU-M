A1BULOOK ;CODE TO OPEN DOS FILE FROM MSM FOR READ ACCESS [ 07/03/96  2:18 PM ]
 ;;
 ;;check which node you are on first
 I $ZU(1,0)="MGR,SNT"&($ZU(0)="CUR,SMA") J ^A1BUJOB["MGR","SMZ"] Q
 I $ZU(1,0)="MGR,DNT"&($ZU(0)="GEN,DMA") J ^A1BUJOB["MGR","DMZ"] Q
 ;;add others here when ready
EN I '$D(DT) S X="T" D ^%DT S DT=Y
 S X=DT D DW^%DTC S TODAY=X I TODAY="SATURDAY"!(TODAY="SUNDAY") G EXIT
 O 51:("C:\SYPLUS\SYFILES\SYJRN\JOURNAL.LOG")
 F II=1:1 U 51 R XX Q:XX=$C(12)  S:XX'="" ^RPE(II)=XX
 C 51 K ^RPE(1)
MAILIT S XMDUZ=.5,U="^",DUZ=.5
GETINT S QQ="" F XX=0:0 S QQ=$O(^XMB(3.8,"B","BACKUP",QQ)) Q:QQ=""  S INT=QQ
GETDUZ S QQ="" F XX=0:0 S QQ=$O(^XMB(3.8,INT,1,QQ)) S:QQ>0 XMY(^XMB(3.8,INT,1,QQ,0))="",XMY($P(^VA(200,^(0),0),U,1)_"@ISC-ALBANY.VA.GOV")="" Q:QQ=""
 S XMSUB="BACKUP MESSAGE"
 S XMTEXT="^RPE("
 D ^XMD
EXIT K XMY,^RPE,INT,XMSUB,XMTEXT,XMDUZ,DUZ,U,II,XX,QQ,X,TODAY
LOCAL ;S XMY(^XMB(3.8,INT,1,QQ,0))="" Q  ;Local receipients
REMOTE ;S XMY($P(^VA(200,^(0),0),U,1)_"@ISC-ALBANY.VA.GOV")="" Q  ;Remote receipients
