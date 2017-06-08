PRCPO002 ; ; 28-FEB-1995
 ;;5.0;GENERIC INVENTORY PACKAGE;;FEB 28, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",82,10,1,0)
 ;;=91^DE^4^^^Descriptive
 ;;^UTILITY(U,$J,"PRO",82,10,1,"^")
 ;;=PRCP EDIT ITEM DESCRIPTION
 ;;^UTILITY(U,$J,"PRO",82,10,2,0)
 ;;=92^CD^14^^^Costing Data
 ;;^UTILITY(U,$J,"PRO",82,10,2,"^")
 ;;=PRCP EDIT COSTING DATA
 ;;^UTILITY(U,$J,"PRO",82,10,3,0)
 ;;=93^IU^6^^^Issue Units
 ;;^UTILITY(U,$J,"PRO",82,10,3,"^")
 ;;=PRCP EDIT ISSUE UNITS
 ;;^UTILITY(U,$J,"PRO",82,10,4,0)
 ;;=94^LE^8^^^Levels
 ;;^UTILITY(U,$J,"PRO",82,10,4,"^")
 ;;=PRCP EDIT LEVELS
 ;;^UTILITY(U,$J,"PRO",82,10,5,0)
 ;;=95^QU^12^^^Quantities
 ;;^UTILITY(U,$J,"PRO",82,10,5,"^")
 ;;=PRCP EDIT QUANTITIES
 ;;^UTILITY(U,$J,"PRO",82,10,6,0)
 ;;=96^DI^16^^^Due-Ins
 ;;^UTILITY(U,$J,"PRO",82,10,6,"^")
 ;;=PRCP EDIT DUEINS
 ;;^UTILITY(U,$J,"PRO",82,10,7,0)
 ;;=97^SP^22^^^Special Parameters
 ;;^UTILITY(U,$J,"PRO",82,10,7,"^")
 ;;=PRCP EDIT SPECIAL PARAMETERS
 ;;^UTILITY(U,$J,"PRO",82,10,8,0)
 ;;=98^PS^26^^^Procurement Sources
 ;;^UTILITY(U,$J,"PRO",82,10,8,"^")
 ;;=PRCP EDIT SOURCES
 ;;^UTILITY(U,$J,"PRO",82,10,9,0)
 ;;=99^DA^24^^^Drug Accountability
 ;;^UTILITY(U,$J,"PRO",82,10,9,"^")
 ;;=PRCP EDIT DRUG ACCT
 ;;^UTILITY(U,$J,"PRO",82,10,10,0)
 ;;=100^AF^2^^^All Fields
 ;;^UTILITY(U,$J,"PRO",82,10,10,"^")
 ;;=PRCP EDIT ALL FIELDS
 ;;^UTILITY(U,$J,"PRO",82,10,11,0)
 ;;=101^RI^28^^^Remove Item From Inv
 ;;^UTILITY(U,$J,"PRO",82,10,11,"^")
 ;;=PRCP EDIT REMOVE ITEM FROM INVPT
 ;;^UTILITY(U,$J,"PRO",82,10,12,0)
 ;;=102^SI^18^^^Secondary Items
 ;;^UTILITY(U,$J,"PRO",82,10,12,"^")
 ;;=PRCP EDIT SECONDARY ITEMS
 ;;^UTILITY(U,$J,"PRO",82,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",82,24)
 ;;=I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),"^"),24)) ^(24)
 ;;^UTILITY(U,$J,"PRO",82,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",82,99)
 ;;=56302,44727
 ;;^UTILITY(U,$J,"PRO",83,0)
 ;;=PRCP DIST ORDER CHECK^Check Order/Items^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",83,1,0)
 ;;=^^3^3^2931020^
 ;;^UTILITY(U,$J,"PRO",83,1,1,0)
 ;;=This protocol will check the items on a distribution order for errors
 ;;^UTILITY(U,$J,"PRO",83,1,2,0)
 ;;=in the inventory point.  Errors include, issue and receipt units,
 ;;^UTILITY(U,$J,"PRO",83,1,3,0)
 ;;=available quantity on-hand, etc.
 ;;^UTILITY(U,$J,"PRO",83,4)
 ;;=^^^CO
 ;;^UTILITY(U,$J,"PRO",83,20)
 ;;=D CHECKORD^PRCPOPER
 ;;^UTILITY(U,$J,"PRO",83,24)
 ;;=
 ;;^UTILITY(U,$J,"PRO",83,99)
 ;;=56064,53664
 ;;^UTILITY(U,$J,"PRO",84,0)
 ;;=PRCP DIST ORDER RELEASE^Release Order^^A^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",84,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",84,1,1,0)
 ;;=This protocol allows the user to release a distribution order for filling
 ;;^UTILITY(U,$J,"PRO",84,1,2,0)
 ;;=by the primary inventory point.
 ;;^UTILITY(U,$J,"PRO",84,4)
 ;;=^^^RO
 ;;^UTILITY(U,$J,"PRO",84,20)
 ;;=D RELEASEL^PRCPOPR
 ;;^UTILITY(U,$J,"PRO",84,24)
 ;;=I $$CHECK^PRCPOPL("RELEASE")
 ;;^UTILITY(U,$J,"PRO",84,99)
 ;;=56064,53677
 ;;^UTILITY(U,$J,"PRO",85,0)
 ;;=PRCP DIST ORDER PROCESSING^Distribution Order Processing^^M^^^^^^^^GENERIC INVENTORY PACKAGE
 ;;^UTILITY(U,$J,"PRO",85,1,0)
 ;;=^^2^2^2931020^
 ;;^UTILITY(U,$J,"PRO",85,1,1,0)
 ;;=This protocol menu provides the options to generate and post orders from
 ;;^UTILITY(U,$J,"PRO",85,1,2,0)
 ;;=a primary inventory point to a secondary inventory point.
 ;;^UTILITY(U,$J,"PRO",85,4)
 ;;=26^^^DP
 ;;^UTILITY(U,$J,"PRO",85,10,0)
 ;;=^101.01PA^8^8
 ;;^UTILITY(U,$J,"PRO",85,10,1,0)
 ;;=86^DO^23^^^Delete Order
 ;;^UTILITY(U,$J,"PRO",85,10,1,"^")
 ;;=PRCP DIST ORDER DELETE
 ;;^UTILITY(U,$J,"PRO",85,10,2,0)
 ;;=87^EI^11^^^Edit Items On Order
 ;;^UTILITY(U,$J,"PRO",85,10,2,"^")
 ;;=PRCP DIST ORDER ITEM EDIT
 ;;^UTILITY(U,$J,"PRO",85,10,3,0)
 ;;=88^DI^21^^^Delete Item On Order
 ;;^UTILITY(U,$J,"PRO",85,10,3,"^")
 ;;=PRCP DIST ORDER ITEM DELETE
 ;;^UTILITY(U,$J,"PRO",85,10,4,0)
 ;;=83^CO^15^^^Check Order/Items
 ;;^UTILITY(U,$J,"PRO",85,10,4,"^")
 ;;=PRCP DIST ORDER CHECK
 ;;^UTILITY(U,$J,"PRO",85,10,5,0)
 ;;=84^RO^31^^^Release Order
 ;;^UTILITY(U,$J,"PRO",85,10,5,"^")
 ;;=PRCP DIST ORDER RELEASE
 ;;^UTILITY(U,$J,"PRO",85,10,6,0)
 ;;=89^PT^33^^^Picking Ticket Print
