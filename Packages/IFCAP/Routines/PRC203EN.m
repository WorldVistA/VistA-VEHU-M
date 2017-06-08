PRC203EN ;WCIOFO/LKG-ENVIRONMENTAL CHECK RTN ;7/26/99  11:29
 ;;5.0;IFCAP;**203**;4/21/95
 ;
 I '$$PATCH^XPDUTL("XU*8.0*108") W !,"You must first install XU*8*108 KIDS Master Build Improvements" S XPDQUIT=2
 I '$$PATCH^XPDUTL("XU*8.0*112") W !,"You must first install XU*8*112 NOIS fixes and API's" S XPDQUIT=2
 I '$$PATCH^XPDUTL("PRC*5.0*143") W !,"You must first install PRC*5*143 RFQ RELATED ISSUES" S XPDQUIT=2
 I '$$PATCH^XPDUTL("PRC*5.0*155") W !,"You must first install PRC*5*155 Y2K RENOVATIONS" S XPDQUIT=2
 I '$$PATCH^XPDUTL("PRC*5.0*156") W !,"You must first install PRC*5*156 Y2K & SHOW 2237# ON DELIV, PCARD ORDERS" S XPDQUIT=2
 I '$$PATCH^XPDUTL("PRC*5.0*177") W !,"You must first install PRC*5*177 DELIVERY DATE ON PURCHASE ORDERS AND OTHER",!,"   ISSUES" S XPDQUIT=2
 I '$$PATCH^XPDUTL("PRC*5.0*187") W !,"You must first install PRC*5*187 PURCHASE ORDER PRINT/DISPLAY FIXES" S XPDQUIT=2
 I '$G(XPDQUIT) W !!,"Everything looks OK, Let's continue.",!
 Q
