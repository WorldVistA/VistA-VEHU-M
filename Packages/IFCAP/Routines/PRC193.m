PRC193 ;FOR KIDS INSTALL WITH PATCH prc*5*193;CC;032699
V ;;5.0;IFCAP;**193**;4/21/95
 ; This routine is temporary and intended only to be used when installing
 ; patch PRC*5*193
1 G 2:$O(^PRCF(423.9,"B","PHM",""))]""
 K DO,DD
 S DIC="^PRCF(423.9,"
 S DLAYGO=423.9
 S DIC(0)="LZ"
 S X="PHM"
 S DINUM=14
 S LBL="PHM",SITE="XXX@Q-ISM.VA.GOV",ANS="Y"
 S DIC("DR")="1////^S X=1;3////^S X=ANS;4////^S X=LBL;5////^S X=14;7////^S X=SITE"
 D FILE^DICN
2 I $O(^PRCD(420.4,"B","PHM",""))]"" Q
 K DO,DD
 S DIC="^PRCD(420.4,"
 S DLAYGO=420.4
 S DIC(0)="LZ"
 S X="PHM"
 S DINUM=$A(X,1)_$A(X,2)_$A(X,3)
 S LBL="PHM",SITE="Procurement History Modification",ANS="Y"
 S DIC("DR")=".7////^S X=14;1////^S X=ANS;2////^S X=SITE;3////^S X=LBL"
 D FILE^DICN
