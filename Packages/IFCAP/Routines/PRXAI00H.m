PRXAI00H ; ; 31-OCT-1994
 ;;4.0;IFCAP;**27**;9/23/93
 Q:'DIFQ(440)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^DD(440,39,"DT")
 ;;=2940707
 ;;^DD(440,40,0)
 ;;=PAYMENT HOLD INDICATOR^S^N:NO;Y:YES;C:CORRESPONDENCE;^3;10^Q
 ;;^DD(440,40,21,0)
 ;;=^^2^2^2940627^
 ;;^DD(440,40,21,1,0)
 ;;=Is payment for this vendor placed on hold?  Do we pay this vendor or
 ;;^DD(440,40,21,2,0)
 ;;=don't we.
 ;;^DD(440,40,"DT")
 ;;=2940204
 ;;^DD(440,41,0)
 ;;=1099 VENDOR INDICATOR^RS^N:NO;Y:YES;^3;11^Q
 ;;^DD(440,41,21,0)
 ;;=^^1^1^2940627^
 ;;^DD(440,41,21,1,0)
 ;;=Is a 1099 form filled out for this vendor?
 ;;^DD(440,41,"DT")
 ;;=2940707
 ;;^DD(440,42,0)
 ;;=PENDING FLAG^S^P:PENDING APPROVAL;C:CONFIRMATION OF APPROVAL;^3;12^Q
 ;;^DD(440,42,21,0)
 ;;=^^4^4^2940627^
 ;;^DD(440,42,21,1,0)
 ;;=Internal IFCAP flag used to state what is being done with this vendor
 ;;^DD(440,42,21,2,0)
 ;;=and FMS.  When a vendor request is sent to FMS other requests should
 ;;^DD(440,42,21,3,0)
 ;;=wait until there is a FMS VENDOR UPDATE.  Actually no other requests
 ;;^DD(440,42,21,4,0)
 ;;=can be created until the update comes back.
 ;;^DD(440,42,"DT")
 ;;=2940204
 ;;^DD(440,43,0)
 ;;=CENTRAL REMIT^S^Y:YES;N:NO;^3;13^Q
 ;;^DD(440,43,21,0)
 ;;=^^1^1^2940804^^
 ;;^DD(440,43,21,1,0)
 ;;=Should all payments for this vendor be sent to one place?
 ;;^DD(440,43,"DT")
 ;;=2940711
 ;;^DD(440,44,0)
 ;;=VENDOR TYPE^RS^A:AGENT CASHIER;C:COMMERCIAL;E:EMPLOYEE;F:FEDERAL GOVERNMENT;G:GSA;I:INDIVIDUALS-OTHER;O:OTHER COUNTRIES;R:COMMERCIAL-RECURRING PMTS;U:UTILITY COMPANIES;V:VETERANS;^3;14^Q
 ;;^DD(440,44,21,0)
 ;;=^^1^1^2940627^
 ;;^DD(440,44,21,1,0)
 ;;=This is a list of different kinds of vendors.
 ;;^DD(440,44,"DT")
 ;;=2940707
 ;;^DD(440,45,0)
 ;;=MTI ACTION^S^A:ADD;F:ADD IFCAP ONLY;C:CHANGE;D:DELETE;^3;15^Q
 ;;^DD(440,45,21,0)
 ;;=^^2^2^2940627^
 ;;^DD(440,45,21,1,0)
 ;;=This is a set of conditions telling IFCAP what to do with the FMS VENDOR
 ;;^DD(440,45,21,2,0)
 ;;=UPDATE.  This field is never changed by IFCAP users.
 ;;^DD(440,45,"DT")
 ;;=2940217
 ;;^DD(440,46,0)
 ;;=FAX #^F^^10;6^K:$L(X)>18!($L(X)<7) X
 ;;^DD(440,46,3)
 ;;=Answer must be 7-18 characters in length.
 ;;^DD(440,46,21,0)
 ;;=^^1^1^2940627^^
 ;;^DD(440,46,21,1,0)
 ;;=This is the vendor's FAX phone number.
 ;;^DD(440,46,"DT")
 ;;=2940707
 ;;^DD(440.01,0)
 ;;=TYPE OF OWNERSHIP (FY88) SUB-FIELD^NL^.01^1
 ;;^DD(440.01,0,"NM","TYPE OF OWNERSHIP (FY88)")
 ;;=
 ;;^DD(440.01,0,"UP")
 ;;=440
 ;;^DD(440.01,.01,0)
 ;;=TYPE OF OWNERSHIP (FY88)^M*P420.6'OX^PRCD(420.6,^0;1^S DIC("S")="I ""MWVY""[$P(^PRCD(420.6,Y,0),U,1),$P(^(0),U,3)=0" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X I $D(X) S DINUM=X
 ;;^DD(440.01,.01,2)
 ;;=S Y(0)=Y Q:Y=""  S Y=$S($D(^PRCD(420.6,Y,0)):^(0),1:""),Y=$P(Y,U,1)_"   "_$P(Y,U,2)
 ;;^DD(440.01,.01,2.1)
 ;;=Q:Y=""  S Y=$S($D(^PRCD(420.6,Y,0)):^(0),1:""),Y=$P(Y,U,1)_"   "_$P(Y,U,2)
 ;;^DD(440.01,.01,12)
 ;;=CAN ONLY BE AN M,W,Y OR V
 ;;^DD(440.01,.01,12.1)
 ;;=S DIC("S")="I ""MWVY""[$P(^PRCD(420.6,Y,0),U,1),$P(^(0),U,3)=0"
 ;;^DD(440.01,.01,21,0)
 ;;=^^1^1^2910516^
 ;;^DD(440.01,.01,21,1,0)
 ;;=This is the type of ownership.
 ;;^DD(440.01,.01,"DT")
 ;;=2880921
 ;;^DD(440.02,0)
 ;;=SYNONYM SUB-FIELD^NL^.01^1
