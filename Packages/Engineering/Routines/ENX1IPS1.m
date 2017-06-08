ENX1IPS1 ;WIRMFO/SAB- POST-INIT (continued) ;11/5/97
 ;;7.0;ENGINEERING;**46**;Aug 17, 1993
 Q
 ;
XSGL(ENDA) ; Change SGL
 ; input ENDA   - equipment entry
 ; returns 1 if sucessfull or 0 if failure
 ;
 N DA,DIC,DIE,DLAYGO,DR,ENBAT,ENDT,ENEQ,ENFAP,ENFD,I,X,Y
 S ENEQ("DA")=ENDA
 F I=2,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 ; create pseudo FD Document
 ; create FD
 S DIC="^ENG(6915.5,",DIC(0)="L",DLAYGO=6915.5
 S X=ENEQ("DA"),DIC("DR")="1///NOW;1.5////^S X=DUZ"
 K DD,DO D FILE^DICN K DLAYGO I Y'>0 Q 0
 S ENFD("DA")=+Y
 L +^ENG(6915.5,ENFD("DA")):0 I '$T Q 0
 S ENFD("TYPE")="D"
 S DR="100////D;102////^S X=DT;33////0.00;103////7;34////00000"
 S DIE="^ENG(6915.5,",DA=ENFD("DA") D ^DIE
 S ENFAP("DOC")="FD"
 S ENFAP(0)=$G(^ENG(6915.5,DA,0)),ENFAP(5)=$G(^(5)),ENFAP(100)=$G(^(100))
 S $P(^ENG(6915.5,ENFD("DA"),100),U,2)=$$GET1^DIQ(6914,ENEQ("DA"),12)
 S X=$P(ENFAP(100),U,3) I X]"" S $P(ENFAP(5),U,5)=$E(X,1,3)+1700,$P(ENFAP(5),U,6)=$E(X,4,5),$P(ENFAP(5),U,7)=$E(X,6,7)
 S X=$P(ENFAP(100),U,4) S:X $P(ENFAP(5),U,4)=$$GET1^DIQ(6914.8,X,.01)
 S ^ENG(6915.5,ENFD("DA"),5)=ENFAP(5)
 ; update $ balance
 D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),-$P(ENEQ(2),U,3))
 K X F I=0:1:3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 S ENFAP("STATION")=$P(ENEQ(9),U,5) ;Owning station
 I '$D(ENFAP("FY")) S ENFAP("FY")=$E($E(DT,1,3)+$E(DT,4),2,3)
 ;Update document counter
 S:'$D(ENFAP("SITE")) ENFAP("SITE")=+^ENG(6915.1,1,0)
 S DIC="^ENG(6915.1,",DIC(0)="M",X=ENFAP("SITE") D ^DIC
 L +^ENG(6915.1,+Y):5
 S X=$S(ENFAP("DOC")="FR":6,1:$A(ENFAP("DOC"),2)-63) ; piece in node
 S ENFAP("COUNT")=$P(^ENG(6915.1,+Y,0),U,X)+1
 S:ENFAP("COUNT")>9999 ENFAP("COUNT")=1
 S $P(^ENG(6915.1,+Y,0),U,X)=ENFAP("COUNT")
 L -^ENG(6915.1,+Y)
 S ENFAP("COUNT")="000"_ENFAP("COUNT"),ENFAP("COUNT")=$E(ENFAP("COUNT"),$L(ENFAP("COUNT"))-3,$L(ENFAP("COUNT")))
 ;  set up first 4 fields of first data segment
 S ENFAP("AO")=$$GET1^DIQ(6914,ENEQ("DA"),63)
 S ENFAP("FUND")=$$GET1^DIQ(6914,ENEQ("DA"),62)
 S ENFAP("CFO")=$S(ENFAP("AO")=10:"01",ENFAP("AO")=40:"05",ENFAP("AO")=20:"02",ENFAP("AO")="00":"05",1:10)
 S ENFAP("TRANS")=$S(ENFAP("STATION")]"":$E(ENFAP("STATION"),1,3),1:ENFAP("SITE"))_$E(ENFAP("FY"),2)_"N"_ENFAP("COUNT")
 S X(1)=ENFAP("DOC")_"1"_U_ENFAP("DOC")_U_ENFAP("AO")_U_ENFAP("TRANS")
 I ENFAP("DOC")="FD" D
 . S X(1)=X(1)_"^^^^^"
 . D BUDFY^ENFAXMT3($P(ENEQ(9),U,7))
 . S $P(X(1),U,12)="~"
 I ENFAP("DOC")="FD" D
 . ; FD2 not defined
 . S X(3)="LIN^~"
 . S X(4)="FDA"
 . D FANUM^ENFAXMT3(4) S X(4)=X(4)_U_$P(ENFAP(5),U,4,9)_"^~"
 ; save copy of code sheet in ENG log file
 S ENDT=($E(DT,1,3)+1700)_$E(DT,4,7) ; date
 S ENDT=ENDT_U_$$LJ^XLFSTR($P($$NOW^XLFDT,".",2),6,0) ; time
 S ENX="CTL^AMM^FMS^"_ENFAP("SITE")_U_"DOC^FD^"_$$LJ^XLFSTR(ENFAP("AO"),4)_"^      ^"_$$LJ^XLFSTR(ENFAP("TRANS"),11)_U_ENDT_"^001^001^001"
 S ^ENG(6915.5,ENFD("DA"),1)=ENX
 S ^ENG(6915.5,ENFD("DA"),2)="DOC"
 S ^ENG(6915.5,ENFD("DA"),3)=$P(X(1),U,1,4)_U_$P(X(1),U,10)
 S ^ENG(6915.5,ENFD("DA"),4)=$P(X(3),"^~")
 S ^ENG(6915.5,ENFD("DA"),5)=$P(X(4),"^~")
 ; enter adjustment voucher
 K ENX
 S ENX(1,0)="This FD document (and a corresponding FA Document) were"
 S ENX(2,0)="created during installation of patch EN*7*46. The patch"
 S ENX(3,0)="moves Trust equipment from SGL 1754 to SGL 1750 on your"
 S ENX(4,0)="local system. The FAP documents are not actually sent to"
 S ENX(5,0)="Fixed Assets since that system already made this change."
 D WP^DIE(6915.5,ENFD("DA")_",",310,"","ENX") D MSG^DIALOG() K ENX
 S DIE="^ENG(6915.5,",DA=ENFD("DA"),DR="303///O;301///NOW" D ^DIE
 ; unlock FD record
 L -^ENG(6915.5,ENFD("DA"))
 ;
 ; update Equipment file
 S $P(^ENG(6914,ENEQ("DA"),8),U,6)=2 ; set SGL = 1750
 ;
 ; create pseudo FA Document
 H 1 ; pause 1 sec. to ensure FA document after FD document
 S ENBAT("SILENT")=1
 D SETUP^ENFAACQ
 D VALEQ^ENFAACQ S ENDO=1
 D ADDFA^ENFAACQ I 'ENDO Q 0
 ; save current value in adjusted value field on code sheet
 S ^ENG(6915.2,ENFA("DA"),200)=$P(ENEQ(2),U,3)
 ; update FAP Balance
 D ADJBAL^ENFABAL($P(ENEQ(9),U,5),$P(ENEQ(9),U,7),$P(ENEQ(8),U,6),$P($P(ENFAP(0),U,2),"."),$P(ENEQ(2),U,3))
 ;
 K X F I=0:1:3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 S ENFAP("STATION")=$P(ENEQ(9),U,5) ;Owning station
 I '$D(ENFAP("FY")) S ENFAP("FY")=$E($E(DT,1,3)+$E(DT,4),2,3)
 ;Update document counter
 S:'$D(ENFAP("SITE")) ENFAP("SITE")=+^ENG(6915.1,1,0)
 S DIC="^ENG(6915.1,",DIC(0)="M",X=ENFAP("SITE") D ^DIC
 L +^ENG(6915.1,+Y):5
 S X=$S(ENFAP("DOC")="FR":6,1:$A(ENFAP("DOC"),2)-63) ; piece in node
 S ENFAP("COUNT")=$P(^ENG(6915.1,+Y,0),U,X)+1
 S:ENFAP("COUNT")>9999 ENFAP("COUNT")=1
 S $P(^ENG(6915.1,+Y,0),U,X)=ENFAP("COUNT")
 L -^ENG(6915.1,+Y)
 S ENFAP("COUNT")="000"_ENFAP("COUNT"),ENFAP("COUNT")=$E(ENFAP("COUNT"),$L(ENFAP("COUNT"))-3,$L(ENFAP("COUNT")))
 ;  set up first 4 fields of first data segment
 S ENFAP("AO")=$$GET1^DIQ(6914,ENEQ("DA"),63)
 S ENFAP("FUND")=$$GET1^DIQ(6914,ENEQ("DA"),62)
 S ENFAP("CFO")=$S(ENFAP("AO")=10:"01",ENFAP("AO")=40:"05",ENFAP("AO")=20:"02",ENFAP("AO")="00":"05",1:10)
 S ENFAP("TRANS")=$S(ENFAP("STATION")]"":$E(ENFAP("STATION"),1,3),1:ENFAP("SITE"))_$E(ENFAP("FY"),2)_"N"_ENFAP("COUNT")
 S X(1)=ENFAP("DOC")_"1"_U_ENFAP("DOC")_U_ENFAP("AO")_U_ENFAP("TRANS")
 ; add remaining data to first segment
 I ENFAP("DOC")="FA" D
 . D FANUM^ENFAXMT3(1)
 . S ENFAP("GRP")=$$GROUP^ENFAVAL($$GET1^DIQ(6914,ENEQ("DA"),18))
 . S ENFAP("LOC")=$$LOC^ENFAVAL($$GET1^DIQ(6914,ENEQ("DA"),19))
 . S X(1)=X(1)_U_ENFAP("GRP")_U_ENFAP("LOC")
 . D BUDFY^ENFAXMT3($P(ENEQ(9),U,7))
 . S X(1)=X(1)_"^^"_ENFAP("FUND")_U_ENFAP("AO")
 . D XORG^ENFAXMT,XPROG^ENFAXMT3
 . S X(1)=X(1)_U_$$GET1^DIQ(6914,ENEQ("DA"),61)_U_$$GET1^DIQ(6914,ENEQ("DA"),18)
 . D ACQTIME^ENFAXMT,ACQMETH^ENFAXMT,XAREA^ENFAXMT,FUNDSRC^ENFAXMT
 . I ENFAP("TY")="X" S X(1)=X(1)_"^^^^^^" ; excessed
 . E  D REPLTIME^ENFAXMT,LIFEXP^ENFAXMT,SALDEPM^ENFAXMT
 . D SUMAV^ENFAXMT,COSTCEN^ENFAXMT
 . D SUBORG^ENFAXMT
 . S $P(X(1),U,33)="~"
 I ENFAP("DOC")="FA" D
 . ; don't send FA2
 . S X(3)="LIN^~"
 . S X(4)="FAA"_U_$P(ENEQ(9),U,9) ; equity account 1
 . S X(4)=X(4)_"^^^^^^^^"_$P(ENEQ(2),U,3) ; asset value 1
 . S X(4)=X(4)_"^^^^^^^^~"
 ; save copy of code sheet in ENG log file
 S ENDT=($E(DT,1,3)+1700)_$E(DT,4,7) ; date
 S ENDT=ENDT_U_$$LJ^XLFSTR($P($$NOW^XLFDT,".",2),6,0) ; time
 S ENX="CTL^AMM^FMS^"_ENFAP("SITE")_U_"DOC^FA^"_$$LJ^XLFSTR(ENFAP("AO"),4)_"^      ^"_$$LJ^XLFSTR(ENFAP("TRANS"),11)_U_ENDT_"^001^001^001"
 S ^ENG(6915.2,ENFA("DA"),1)=ENX
 S ^ENG(6915.2,ENFA("DA"),2)="DOC"
 S ^ENG(6915.2,ENFA("DA"),3)=$P(X(1),U,1,9)_U_$P(X(1),U,11,20)_U_$P(X(1),U,22,32)
 S ^ENG(6915.2,ENFA("DA"),6)=$P(X(3),"^~")
 S ^ENG(6915.2,ENFA("DA"),7)=$P(X(4),U,1,2)_U_$P(X(4),U,10)
 ;
 ; enter adjustment voucher
 K ENX
 S ENX(1,0)="This FA document (and a corresponding FD Document) were"
 S ENX(2,0)="created during installation of patch EN*7*46. The patch"
 S ENX(3,0)="moves Trust equipment from SGL 1754 to SGL 1750 on your"
 S ENX(4,0)="local system. The FAP documents are not actually sent to"
 S ENX(5,0)="Fixed Assets since that system already made this change."
 D WP^DIE(6915.2,ENFA("DA")_",",310,"","ENX") D MSG^DIALOG() K ENX
 S DIE="^ENG(6915.2,",DA=ENFA("DA"),DR="303///O;301///NOW" D ^DIE
 ;
 D WRAPUP^ENFAACQ
 Q 1
 ;
XFUND(ENDA,ENFUNDI) ; Change FUND
 ; input   ENDA    - equipment entry
 ;         ENFUNDI - new fund ien
 ; returns 1 if success or 0 if failed
 ;
 N DA,ENBAT,ENDO,ENEQ,ENFA,ENFAP,ENFR,ENX,I
 S ENEQ("DA")=ENDA
 S ENBAT("SILENT")=1
 S ENX=$$CHKFA^ENFAUTL(ENEQ("DA"))
 S ENFA("DA")=$P(ENX,U,4)
 F I=1,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 ; create FR document to change fund
 S ENDO=1,ENFR("DA")=""
 D ADDFR^ENFAXFR
 D:ENDO
 . ; populate FR Document
 . S ENFAP(100)=$G(^ENG(6915.6,ENFR("DA"),100))
 . S $P(ENFAP(100),U,2)=ENFUNDI ; fund (required)
 . S $P(ENFAP(100),U,3)=$P(ENEQ(9),U,8) ; a/o (required)
 . S $P(ENFAP(100),U,5)=$P(ENEQ(9),U,6) ; boc (deleted when blank sent)
 . S $P(ENFAP(100),U,6)=$P(ENEQ(2),U,9) ; cmr (determines cost ctr)
 . S ^ENG(6915.6,ENFR("DA"),100)=ENFAP(100)
 D:ENDO CVTDATA^ENFAXFR
 D:ENDO
 . S ENFAP("DOC")="FR" D ^ENFAVAL
 . I $D(^TMP($J,"BAD",ENEQ("DA"))) S ENDO=0
 I 'ENDO,$G(ENFR("DA"))]"" D
 . S DA=ENFR("DA"),DIK="^ENG(6915.6," D ^DIK K DIK
 D:ENDO UPDATE^ENFAXFR
 I $G(ENFR("DA"))]"" L -^ENG(6915.6,ENFR("DA"))
 Q ENDO
 ;
 ;ENX1IPS
