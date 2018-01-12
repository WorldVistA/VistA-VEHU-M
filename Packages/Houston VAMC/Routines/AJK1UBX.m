AJK1UBX ;580/MRL - Collections, Post-Initialization; 06-Dec-97
 ;;2.0T8;AJK1UB;;Sep 15, 1999
 ;
 ;This routine is called to run the post-initialization process for
 ;the collections module.
 ;
 D T("HOUSTON VAMC, COLLECTIONS PROCESSOR, VERSION 2.0T7",0,1,0,0)
 D T("POST-INITIALIZATION",1,1,0,0)
 ; W !! F I=0:0 S I=$O(^DIZ(580950.1,1,"IT",I)) Q:I'>0  D
 ; .W !,^(I,0)
 F AJKCTR=1:1 S AJKORD=$P($T(JOB+AJKCTR),";;",2) Q:AJKORD=""  D
 .F I=1,2,3,4 S AJKORD(I)=$P($P(AJKORD,";",I),";",1)
 .I AJKORD(4),$$VER^AJK1UBVR>0 Q  ;quit if previously installed
 .D T(AJKORD(2)_" ...",2,0,1,AJKORD(3)) ;write what you're doing
 .D @(AJKORD(1)) ;run process
 .D T(AJKORD(2),2,0,2,AJKORD(3)) ;all done
 D T("POST-INITIALIZATION COMPLETED",2,0,3,0)
 D T("INITIALIZATION OF V2.0T7, COLLECTIONS, COMPLETED",2,0,3,0)
 D T("Use the Supervisor Menu to update/define your",2,0,3,0)
 D T("    Collection System Parameters.  Best of Luck",1,0,0,0)
 S ^DIZ(580950.1,1,"VER")="2.0T7"
 D T("CURRENT VERSION SET TO 2.0T7 IN PARAMETER FILE",2,0,3,0)
 K %,A,AJKCTR,AJKORD,B,C,D,I,GRP,OLD,X1,X2 Q
 ;
FNAME ; --- clean/check parameter file
 ;
 I '$D(^DIZ(580950.1,1,0)) K DD,DO D
 .S X=$G(^DD("SITE")) I '$L(X) S X="VA Facility #"_+$G(^DD("SITE",1))
 .S (DA,DINUM)=1,DIC="^DIZ(580950.1,",DIC(0)="L" D FILE^DICN
 I $D(^DIZ(580950.1,2,0)) D
 .S DA=2,DIK="^DIZ(580950.1," D ^DIK
 K DD,DO,X,DA,DINUM,DIK,DIC Q
 ;
TT ; --- update transaction types (430.3)
 ;
 N CAT
 S CAT="0400001111000000002003100100100003000012000000200"
 F I=1:1:47 S X1=+$E(CAT,I) I X1 S X2=$G(^PRCA(430.3,I,0)) D:$L(X2)
 .S X="'"_$P(X2,"^",1)_"' updated to reflect status of "
 .S X=X_$P("CANCELLED^SUSPENDED^PAID (FULL)^PAID (PARTIAL)","^",+X1)
 .D T(X,1,0,4,0)
 .S ^PRCA(430.3,+I,580000)=+X1
 Q
 ;
COL ; --- update collectable categories (430.2)
 ;
 S X=$P($G(^PRCA(430.2,9,0)),"^",1) Q:'$L(X)
 D T("'"_X_"' updated to reflect COLLECTABLE",1,0,4,0)
 S ^PRCA(430.2,9,"AJK1UB")=1
 Q
 ;
MENU ; --- menus assigned
 ;
 D T("Please be sure the AJK1UB SUPERVISOR menu is assigned",1,0,4,0)
 Q
 ;
KEY ; --- check for security key
 ;
 S X=$O(^DIC(19.1,"B","AJK1UB SUPERVISOR",0))
 I '$D(^DIC(19.1,+X,0)) D  Q
 .D T("AJK1UB SUPERVISOR Security Key doesn't exist",1,0,4,0)
 .D T("Please define in SECURITY KEY file and establish users",1,0,4,0)
 I $O(^XUSEC("AJK1UB SUPERVISOR",0))'>0 D  Q
 .D T("AJK1UB SUPERVISOR Security is not assigned to any users",1,0,4,0)
 .D T("Please consider assigning to MCCR Supervisory personnel",1,0,4,0)
 D T("AJK1UB SUPERVISOR Security Key is properly set up",1,0,4,0)
 Q
 ;
MAIL ; --- check mail groups
 ;
 S GRP="COLLECTIONS^TRANSMISSION"
 F I=1,2 S Y="AJK1UB "_$P(GRP,"^",I) D
 .S X=$O(^XMB(3.8,"B",Y,0))
 .I '$D(^XMB(3.8,+X,0)) D  Q
 ..D T("'"_Y_"' not defined in MAIL GROUP file...please define",1,0,4,0)
 .I $O(^XMB(3.8,+X,1,0))'>0 D  Q
 ..D T("'"_Y_"' Mail Group doesn't have members assigned",1,0,4,0)
 ..D T("Please assign members to the group as soon as possible",1,0,4,0)
 .D T("'"_Y_"' Mail Group is set up with members....",1,0,4,0)
 .I Y["TRANSMISSION" D
 ..D T("    Don't forget to assign the collection agency as a REMOTE",1,0,4,0)
 ..D T("    MEMBER to this TRANSMISSION mailgroup.  For example, if",1,0,4,0)
 ..D T("    you use Transworld Systems (TSI), you would enter",1,0,4,0)
 ..D T("    vadmin@TRANSWORLDSYSTEMS.COM (case-sensitive).",1,0,4,0)
 Q
 ;
XRF ; --- build AJK1 xref on file 430
 ;
 N I,CT,X1,X2
 I $D(^PRCA(430,"AJK1")) D  Q
 .D T("Cross-reference already exists in ACCOUNTS RECEIVABLE",1,0,4,0)
 S (CT,I)=0 F  S I=$O(^PRCA(430,I)) Q:I'>0  S X=^(I,0) D
 .S X1=+$P(X,"^",8) Q:X1'=16  ;not active
 .S X2=$P(X,"^",10) Q:'+X2  ;no date prepared
 .S ^PRCA(430,"AJK1",X2,I)="",CT=CT+1 W:'(CT#100) "."
 Q
 ;
T(V,W,X,Y,Z) ; --- write comment
 ;             V = text to be written
 ;             W = line feeds to issue
 ;             X = Center (>0)
 ;             Y = Prefix
 ;             Z = action
 ;                 1)  Moving
 ;                 2)  Updating
 ;                 3)  Checking
 ;
 N I
 I W F I=1:1:W W !
 I Z S V=$P("Mov^Updat^Check","^",+Z)_"ing "_V
 I Y S V=$S(Y=1:">>>",Y=2:"$$$",Y=3:"===",1:"   ")_" "_V
 I X S X=(IOM-$L(V)\2) D
 .S X=$E("                                                    ",1,X)
 .S V=X_V
 I V["$$$" S V=V_" completed."
 W V
 Q
 ;
JOB ; --- do these things in this order
 ;;XRF;'AJK1' CROSS-REFERENCE;2;1
 ;;FNAME;FACILITY NAME;2;0
 ;;TT;ACCOUNTS RECEIVABLE TRANS.TYPE;2;1
 ;;COL;ACCOUNTS RECEIVABLE CATEGORIES;2;1
 ;;KEY;SECURITY KEY DATA;3;0
 ;;MAIL;MAIL GROUP DATA;3;0
 ;;^AJK1UBX1;VERSION 1.0 DATA INTO NEW FILES;1;1
 ;;MENU;PRIMARY MENUS;3;0
