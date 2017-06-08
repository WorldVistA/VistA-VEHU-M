PRCACV1 ;WASH-ISC@ALTOONA,PA/RGY-Check AR V3.7 database ;10/12/93  1:17 PM
V ;;4.0;ACCOUNTS RECEIVABLE;;11/22/93
 I $G(^DD(340,0,"VR"))["4.0" W !,*7,"PRE-CONVERSION APPEARS TO HAVE ALREADY BEEN RUN.",!,"IF YOU REALLY WANT TO RUN PRE-CONVERSION AGAIN, RUN 'EN^PRCACV1'" S ERROR="" G Q
EN NEW X,Y,ERROR,DIE,DA,DR,HLD
 I '$$SYS() S ERROR=1 G Q
 S HLD=0 F  S HLD=$O(^DIC(9.4,"B","AR (ACCOUNTS RECEIVABLE)",HLD)) Q:'HLD  S DIE="^DIC(9.4,",DA=HLD,DR=".01////^S X=""ACCOUNTS RECEIVABLE""" D ^DIE
 S ERROR="" W !
 I '$O(^PRC(411,"AC","Y",0)),$O(^PRC(411,$O(^PRC(411,0)))) W !,"WARNING: Your IFCAP file ^PRC(411, does not have a",!,"primary station defined.  I would really like to know this information!" Q
 F X="430^8^4","430^9^8","430^7^2","433^.03^3","433^12^1" I $O(^DD(+X,$P(X,"^",2),1,$P(X,"^",3))) D
 .W !,"Warning: You appear to have a local xref on file ",+X," field ",$P(X,"^",2),!,"This field is being deleted and re-installed so be sure to re-add"
 .W !,"your x-ref after installation!"
 .Q
 I $O(^PRCA(430.2,0)) F X=1:1:26 D
 .S Y=$P($T(CAT+X),";;",2)
 .I $P(Y,"^")'=$P($G(^PRCA(430.2,X,0)),"^")!($P(Y,"^",2)'=$P($G(^PRCA(430.2,X,0)),"^",2))!($P(Y,"^",6)'=$P($G(^PRCA(430.2,X,0)),"^",6)) S ERROR=1 W !,"You have a corrupt entry #",X," in file 430.2!!"
 .Q
 I $O(^PRCA(430.2,26)) S ERROR=1 W !,"You have more entries in file 430.2 than what is normal" S ERROR=1
 I $O(^PRCA(430.3,0)) F X=1:1:44 D
 .S Y=$P($T(TRA+X),";;",2)
 .I $P(Y,"^")'=$P($G(^PRCA(430.3,X,0)),"^")!($P(Y,"^",2)'=$P($G(^PRCA(430.3,X,0)),"^",2))!($P(Y,"^",3)'=$P($G(^PRCA(430.3,X,0)),"^",3)) S ERROR=1 W !,"You have a corrupt entry #",X," in file 430.3!!"
 .Q
 I $O(^PRCA(430.3,44)) D
 .I $D(^PRCA(430.3,45,0)),^(0)'="COMMENT^CM^17^0^0" W !,"Internal entry number '45' in file 430.3 is corrupt" S ERROR=1 G Q1
 .I $D(^PRCA(430.3,46,0)),^(0)'="UNSUSPENDED^US^18^0^0" W !,"Internal entry number '46' in file 430.3 is corrupt" S ERROR=1 G Q1
 .I $O(^PRCA(430.3,46)) S ERROR=1 W !,"You have more entries in file 430.3 than what is normal" S ERROR=1
Q1 .Q
 W !,"Checking file 412 ..."
 S X=0 F  S X=$O(^PRC(412,X)) Q:'X  W:'(X#1000) "." D
 .S Y=$P($G(^PRC(412,X,0)),"^")
 .I +Y'=$P(Y,";")!("^PRC(440,^DPT(^DIC(36,^DIC(4,^VA(200,^"'[("^"_$P(Y,";",2,999)_"^")) W !,"Oops, I can't convert entry #",Y," from file 412 to file 340!" S ERROR=1
 .Q
 W !
 I ERROR]"" W !,"Due to an error in pre-conversion, the conversion or installation will not run" G Q
 D ^PRCACV2
Q I ERROR]"" W *7,!!,"INSTALLATION ABORTED!",! K DIFQ
 Q
SYS() ;Check system vairables
 I '$D(DT)!'$D(IOM)!'$D(IOF)!'$D(ION)!'$D(IOST)!'$D(IOSL)!'$D(DUZ)!'$D(IO)!'$D(DTIME) W !,"Some of your system variables are not defined!!",! Q 0
 Q 1
CAT ;
 ;;INELIGIBLE HOSP.^I^251^1213^^P^20^2
 ;;EMERGENCY/HUMANITARIAN^H^252^1221^^P^25^2
 ;;NURSING HOME CARE(NSC)^NC^243^1221^^P^3
 ;;OUTPATIENT CARE(NSC)^OC^244^1221^^P^2
 ;;HOSPITAL CARE (NSC)^HC^245^1221^183^P^1
 ;;WORKMAN'S COMP.^WC^246^1212^^T^23^2
 ;;NO-FAULT AUTO ACC.^NA^247^1212^^T^26^2
 ;;CRIME OF PER.VIO.^CP^248^1212^192^T^27^2
 ;;REIMBURS.HEALTH INS.^RI^^1212^^T^21^2
 ;;TORT FEASOR^TF^0^1228^^T^22^2
 ;;
 ;;MILITARY^M^0^1211^^V^17^1
 ;;FEDERAL AGENCIES-REFUND^F2^0^1218^^V^15^1
 ;;FEDERAL AGENCIES-REIMB.^F1^0^1211^^T^16^1
 ;;EX-EMPLOYEE^E^0^1228^^O^13^2
 ;;CURRENT EMP.^CE^0^1228^^O^14^2
 ;;VENDOR^V^0^1228^^V^11^2
 ;;C (MEANS TEST)^C^240^1221^^C^24^2
 ;;SHARING AGREEMENTS^SA^0^1228^^N^18
 ;;INTERAGENCY^IA^0^1228^^N^19^1
 ;;MEDICARE^MC^0^1228^^N^28^2
 ;;RX CO-PAYMENT/SC VET^PS^298^1212^192^P^29^2
 ;;RX CO-PAYMENT/NSC VET^PN^294^1212^192^P^30^2
 ;;NURSING HOME CARE PER DIEM^NP^296^1221^^P^31^2
 ;;HOSPITAL CARE PER DIEM^HP^295^1221^^P^32^2
 ;;PREPAYMENT^PP^0^1212^192^P^33^2
TRA ;;
 ;;INCREASE ADJUSTMENT^AJ^1^1
 ;;PAYMENT (IN PART)^PP^2^1
 ;;REFER TO DC^RC^3^0
 ;;REFER TO DOJ^RJ^4^0
 ;;REESTABLISH TO DC/DOJ^RR^5^0
 ;;RETURNED BY DC/DOJ^RD^6^0
 ;;CASH COLLECTION BY DC/DOJ^CJ^7^1
 ;;TERM.BY FIS.OFFICER^TO^8^1
 ;;TERM.BY COMPROMISE^TC^9^1
 ;;WAIVED IN FULL^WF^10^1
 ;;WAIVED IN PART^WP^11^1
 ;;ADMIN.COST CHARGE^AC^12^0
 ;;INTEREST/ADM. CHARGE^IC^13^0
 ;;EXEMPT INT/ADM. COST^E^14^0
 ;;INCOMPLETE^IN^101^0
 ;;ACTIVE^A^102^0^1
 ;;IN-ACTIVE^IA^103^0^1
 ;;NEW BILL^N^104^0
 ;;SUSPENSE^S^105^0^1
 ;;PENDING APPROVAL^PA^205^0
 ;;PENDING CALM CODE^PC^107^0^1
 ;;COLLECTED/CLOSED^CC^108^0^1
 ;;WRITE-OFF^WO^109^0^1
 ;;MARSHAL/COURT COST^ML^15^0
 ;;REPAYMENT PLAN^RP^16^0
 ;;CANCELLED BILL^CB^210^0
 ;;BILL INCOMPLETE^BI^201^0
 ;;OLD BILL^OB^106^0
 ;;TERM.BY DC/DOJ^TJ^29^1
 ;;DEBIT VOUCHER (SF 5515)^DV^30^1
 ;;RETURNED FROM AR (NEW)^RT^220^0
 ;;RETURNED FOR AMENDMENT^RA^230^0
 ;;AMENDED BILL^AB^110^1
 ;;PAYMENT (IN FULL)^PF^20^1
 ;;DECREASE ADJUSTMENT^DA^21^1
 ;;DELETE (AMEND)^DL^301^0
 ;;ADD (AMEND)^AD^302^0
 ;;AMEND^AM^303^0
 ;;CANCELLATION^CN^111^1^0
 ;;SUSPENDED^SP^240^0^0
 ;;REFUNDED^RF^120^1^0
 ;;OPEN^OP^112^1^0
 ;;RE-EST. WRITE-OFF^RW^250
 ;;REFUND REVIEW^PR^113^0^0
