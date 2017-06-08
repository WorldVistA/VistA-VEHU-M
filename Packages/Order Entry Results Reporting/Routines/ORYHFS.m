ORYHFS ; ALB/MJK,dcm Report Calls ;9/18/96  15:02
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**TEST**;Dec 17, 1997
 ;
EN ; test HFS file...write text whether successful or not
 N I,FLAG
 D ZIS
 D START(80,"TEST")
 S FLAG=0
 F I=0:0 S I=$O(^TMP("ORDATA",$J,1,I)) Q:'I  W !,^(I) S FLAG=1
 I FLAG W !!!,"Test was SUCCESSFUL...HFS defined properly!"
 I 'FLAG W !!!,"Test was NOT successful...please check HFS settings!!"
 Q
START(RM,GOTO) ;
 ;RM=Right margin
 S:'$G(RM) RM=80
 N ZTQUEUED,ORHFS,ORSUB,ORIO
 S ORHFS=$$HFS(),ORSUB="ORDATA"
 D OPEN(.RM,.ORHFS,"W",.ORIO)
 D @GOTO
 D CLOSE(.ORRM,.ORHFS,.ORSUB,.ORIO)
 Q
HFS() ; -- get hfs file name
 ; -- need to define better unique algorithm
 Q "ORU_"_$J_".DAT"
 ;
OPEN(ORRM,ORHFS,ORMODE,ORIO) ; -- open WORKSTATION device
 ;   ORRM: right margin
 ;  ORHFS: host file name
 ; ORMODE: open file in 'R'ead or 'W'rite mode
 S ZTQUEUED="" K IOPAR
 S IOP="OR WORKSTATION;"_$G(ORRM,80)
 S %ZIS("HFSMODE")=ORMODE,%ZIS("HFSNAME")=ORHFS
 D ^%ZIS K IOP,%ZIS
 U IO S ORIO=IO
 Q
 ;
CLOSE(ORRM,ORHFS,ORSUB,ORIO) ; -- close WORKSTATION device
 ; ORSUB: unique subscript name for output 
 I IO=ORIO D ^%ZISC
 U IO
 D USEHFS
 U IO
 Q
USEHFS ; -- use host file to build global array
 N IO,OROK,SECTION
 S SECTION=0
 D INIT
 S OROK=$$FTG^%ZISH(,ORHFS,$NA(@ROOT@(1)),4) I 'OROK Q
 D STRIP
 N ORARR S ORARR(ORHFS)=""
 S OROK=$$DEL^%ZISH("",$NA(ORARR))
 Q
 ;
INIT ; -- initialize counts and global section
 S (INC,CNT)=0,SECTION=SECTION+1
 S ROOT=$NA(^TMP(ORSUB,$J,SECTION))
 K @ROOT
 Q
 ;
STRIP ; -- strip off control chars
 N I,X
 S I=0 F  S I=$O(@ROOT@(I)) Q:'I  S X=^(I) D
 . I X[$C(8) D  ;BS
 .. I $L(X,$C(8))=$L(X,$C(95)) S (X,@ROOT@(I))=$TR(X,$C(8,95),"") Q  ;BS & _
 .. S (X,@ROOT@(I))=$TR(X,$C(8),"")
 . I X[$C(7)!(X[$C(12)) S @ROOT@(I)=$TR(X,$C(7,12),"") ;BEL or FF
 Q
ZIS ; set-up device for testing
 N DA,DIC,DIE,DLAYGO,X,Y
 S DIC(0)="LQMZ",(DIC,DLAYGO)=3.5,X="OR WORKSTATION" D ^DIC
 I Y,$P(Y,"^",3) D  ; if newly added
 . S DA=+Y,DIE=DIC
 . S DR=".02///^S X=""OR Workstation HFS Device"";1///^S X=""ORDEV.DAT"""
 . S DR=DR_";1.95////0;2///^S X=""HFS"";4////0;5////0;5.1////0;5.2////0"
 . S DR=DR_";3///^S X=""`""_"_$$SUBTYPE()
 . D ^DIE
 Q
SUBTYPE() ; get subtype for P-OTHER
 N DIC,X
 S DIC(0)="QMXZ",DIC="^%ZIS(2,",X="P-OTHER" D ^DIC
 Q +Y
TEST ; write test message
 W !!,"This is a test"
 Q
