DVBAUDNEW1  ;ALB/CP - UTL NEW variables with indirection #1 ; 10/11/18 12:42pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;
 ;          ******    F I L E M A N   C A L L S   ******
 ;
%DT()    Q "%DT,%DTX,%T,%Y,A1,DDH,DTOUT,DUOUT,X,Y"
 ;... ^%DT,DD^%DT
%DTC()   Q "%,%H,%I,%T,%Y,X,X1,X2,X3,Y"
 ; ^%DTC,C^%DTC,H^%DTC,DW^%DTC,NOW^%DTC,YMD^%DTC,YX^%DTC,S^%DTC,HELP^%DTC,COMMA^%DTC
%RCR()   Q "%X,%Y"
 ;%XY^%RCR
DD()     Q "Y"
 ;........................................ X ^DD("DD")
DDS()    Q "%,%ZISOS,DA,DDSCHANG,DDSFILE,DDSPAGE,DDSPARM,DDSSAVE,DIMSG,DINUM,DILOCKTM,DR,DTOUT,DUTOUT,I,IOPAR,IOUPAR,XPARSYS"
 ; ^DDRS
DIAC()   Q "%,DIAC,DIFILE"
 ;............................ ^DIAC
DIB()    Q "%,%H,D0,DDH,DIDEL,DIE"
 ;.................... EN^DIB
DIC()    Q "%,%H,%I,%X,%Y,C,D,D0,DA,DBT,DDH,DG,DIALLVAL,DIC,DILN,DINUM,DIPGM,DISYS,DIY,DLAYGO,DST,DTOUT,DUOUT,DZ,I,X,Y"
 ;..... ^DIC,IX^DIC,MIX^DIC1
DIC1()   Q "DIC,DO"
 ;................................... DO^DIC1
DICN()   Q "%,%Y,D0,DA,DD,DIC,DIG,DIH,DINUM,DIU,DIV,DO,X,Y,DTOUT,DUOUT"
 ;FILE^DICN, YN^DICN
DICQ()   Q "DIC,DILN,D,DZ"
 ;............................ DQ^DICQ
DID()    Q "D0,DIC,DIFORMAT,IOPAR,IOUPAR"
 ;............. EN^DID
DIE()    Q "%,%X,%Y,D,D0,D1,DA,DDH,DG,DI,DIC,DIDEL,DIE,DIERR,DIW,DQ,DR,DTOUT,DZ"
 ; ^DIE,FILE^DIE
DIK()    Q "%,%H,D0,DA,DG,DH,DIC,DIG,DIH,DIIX,DIK,DIKJ,DIU,DIV,DIW,DV,DW,X,Y"
 ;other entry pts: EN,ENALL,ENALL2,EN1,EN2,IX,IX1,IX2,IXALL,IXALL2
DIM()    Q "X"
 ;........................................ ^DIM
DIO2()   Q "Y"
 ;........................................ DT^DIO2
DIP()    Q "%H,%T,BY,D0,DCOPIES,DHD,DHIT,DIASKHD,DIC,DIOBEG,DIOEND,DIPCRIT,DIS,DISPAR,DISTOP,DISUPNO,DIWF,DK,DQTIME,FLDS,FR,IOHG,IOP,IOPAR,IOUPAR,IOX,IOY,L,PG,TO,X1"
 ;. EN1^DIP
DIPT()   Q "%,D0,DY,X"
 ;................................ ^DIPT,DIBT^DIPT
DIPZ()   Q "DMAX,DXS,X,Y"
 ;............................. ^DIPZ, EN^DIPZ
DIQ()    Q "%,C,D0,I,X,Y"
 ;............................ D^DIQ, DT^DIQ, EN^DIQ, Y^DIQ
DIQ1()   Q "%,%Y,A,C,D0,DA,DDC,DDH,DIC,DIERR,DIQ,DIQ0,DIQ1,DIQ2,DIW,DIWT,DK,DR,I,S,Y"
 ; EN^DIQ1, EN^DIQ1
DIR()    Q "%,%Y,DA,DIR,DIRUT,DTOUT,DUOUT,I,X,Y"
 ;...... ^DIR
DIS()    Q "DIC"
 ;...................................... EN^DIS
DIWP()   Q "DIWF,DIWL,DIWR,X,Y"
 ;....................... ^DIWP
DIU2()   Q "DISYS,DIU"
 ;............................... EN^DIU2
 ;
 ;           ******    K E R N E L   C A L L S   ******
 ;
XPD()    Q "ZTCPU"
 ; Kids installations
%ZIS()   Q "%L,%Z4,%ZY,DA,IOHG,IOPAR,IOUPAR,NVSDFDIR,POP,ZISIOST,ZTSK"
 ; ^%ZIS, HOME^%ZIS
%ZISC()  Q "%L,IOHG,IOPAR,IOUPAR,POP"
 ; ^%ZISC (output vars. same as ^%ZIS)
%ZTLOAD() Q "%L,%ZTLOAD,ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL,ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI"
 ; ^%ZTLOADPSETZISP() Q "IOBAROFF,IOBARON,IOCLROFF,IOCLRON,IODPLXL,IODPLXS,IOITLOFF,IOITLON,IOSMPLX,IOSPROFF,IOSPRON,IOSUBOFF,IOSUBON" ; PSET^%ZISP
 ;
 ;         ******    M A I L M A N   C A L L S   ******
 ;
XMA2()   Q "%,%H,%I,X,XMDUZ,XMSUB,XMZ"
 ;................... XMZ^XMA2,ENT^XMA2
XMAH()   Q "XMDUN,XMDUZ,XMZ"
 ;............................... ENT8^XMAH
XMD()    Q "%,%Y,D,D0,D1,D2,DG,DIC,DICR,DICW,DIW,X,X,XCNP,XMDR,XMDUN,XMDUZ,XMK,XMROU,XMSUB,XMSTRIP,XMTEXT,XMY,XMZ,Y,ZTCPU"
 ; ^XMD, EN1^XMD, ENL^XMD, ENT^XMD, ENT1^XMD, ENT2^XMD
XMXAPI() Q "XMATTACH,XMBODY,XMDUZ,XMFULL,XMINSTR,XMK,XMKZ,XMKZA,XMMSG,XMSUBJ,XMTO,XMZ"
 ;-> covers all entry points into XMXAPI (too numerous to list)
 ;
 ;           ******    V A D P T   C A L L S   ******
 ;
VAADD()  Q "VACNTRY,VAPA,VAERR,VAHOW,VAPTYP,VAROOT,VATEST"
 ;. ADD^VADPT
VAADM()  Q "VADMVT,VAERR,VAINDT"
 ;........................... ADM^VADPT2
VADEM()  Q "VA,VADM,VAERR,VAHOW,VATEST,VAPTYP,VAROOT"
 ;...... DEM^VADPT
VAELIG() Q "VAEL,VAERR,VAHOW,VAROOT"
 ;....................... ELIG^VADPT
VAIN5()  Q "%,%H,%I,VAERR,VAIP,VAROOT"
 ;..................... IN5^VADPT
VAINP()  Q "%,%H,%I,VAERR,VAHOW,VAIN,VAINDT,VAROOT"
 ;........ INP^VADPT
VAMB()   Q "VAERR,VAHOW,VAMB,VAROOT"
 ;........................ MB^VADPT
VAOAD()  Q "VAERR,VAHOW,VAOA,VAROOT"
 ;....................... OAD^VADPT
VAOPD()  Q "VAERR,VAHOW,VAPD,VAROOT"
 ;....................... OPD^VADPT
VAPID()  Q "VAERR,VATYP"
 ;....................... PID^VADPT & PID^VADPT6
VAREG()  Q "VAERR,VAHOW,VAROOT,VARP"
 ;....................... REG^VADPT
VASDA()  Q "%,%I,VAERR,VASD"
 ;............................... SDA^VADPT
VASDE()  Q "VAERR"
 ;......................................... SDE^VADPT
VASVC()  Q "VAHOW,VAERR,VAROOT,VASV"
 ;....................... SVC^VADPT
 ;
