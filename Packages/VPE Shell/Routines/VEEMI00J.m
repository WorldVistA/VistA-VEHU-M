VEEMI00J ; ; 04-JAN-2004
 ;;12;VPE SHELL;;JAN 04, 2004
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",188,0)
 ;;=VEEM PGM EDIT^^^^2960511.221^^^19200.113^0^0^1
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,0)
 ;;=^.4031I^1^1
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,0)
 ;;=1^^1,1
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,1)
 ;;=Page 1
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,0)
 ;;=^.4032IP^716^2
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,715,0)
 ;;=VEEM PGM EDIT HD^1^1,1^d
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,716,0)
 ;;=VEEM PGM EDIT EDT^2^2,1^e
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,"AC",1,715)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,"AC",2,716)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,"B",715,715)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,1,40,"B",716,716)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,"B",1,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,40,"C","PAGE 1",1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,0,0,"N")
 ;;=18,716^1,716^1,716^18,716^1,716
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,715)
 ;;=0^0^19200.113^^d^^^^0
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716)
 ;;=1^0^19200.113^^e^^^^1
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,1,"D")
 ;;=2^14^30^.01
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,1,"N")
 ;;=0^5^2^0^2
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,2,"D")
 ;;=2^57^2^2
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,2,"N")
 ;;=0^4^5^1^5
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,3,"D")
 ;;=5^14^20^3
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,3,"N")
 ;;=5^7^6^4^6
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,4,"D")
 ;;=4^57^9^4
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,4,"N")
 ;;=2^6^3^5^3
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,5,"D")
 ;;=4^14^30^5
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,5,"N")
 ;;=1^3^4^2^4
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,6,"D")
 ;;=5^57^20^20
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,6,"N")
 ;;=4^8^7^3^7
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,7,"D")
 ;;=7^14^25^21
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,7,"N")
 ;;=3^9^8^6^8
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,8,"D")
 ;;=7^53^25^22
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,8,"N")
 ;;=3^10^9^7^9
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,9,"D")
 ;;=8^14^25^23
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,9,"N")
 ;;=7^11^10^8^10
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,10,"D")
 ;;=8^53^25^24
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,10,"N")
 ;;=8^12^11^9^11
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,11,"D")
 ;;=9^14^25^25
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,11,"N")
 ;;=9^13^12^10^12
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,12,"D")
 ;;=9^53^25^26
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,12,"N")
 ;;=10^14^13^11^13
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,13,"D")
 ;;=10^14^25^27
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,13,"N")
 ;;=11^15^14^12^14
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,14,"D")
 ;;=10^53^25^28
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,14,"N")
 ;;=12^16^15^13^15
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,15,"D")
 ;;=11^14^25^29
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,15,"N")
 ;;=13^17^16^14^16
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,16,"D")
 ;;=11^53^25^30
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,16,"N")
 ;;=14^19^17^15^17
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,17,"D")
 ;;=12^14^25^31
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,17,"N")
 ;;=15^18^19^16^19
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,18,"D")
 ;;=13^14^25^33
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,18,"N")
 ;;=17^0^0^19^0
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,19,"D")
 ;;=12^53^25^32
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,716,19,"N")
 ;;=16^18^18^17^18
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY",1,"FIRST")
 ;;=1,716
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","ACTIVE",1,1,716,2)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","DESCRIPTION",1,1,716,5)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","IDENTIFIER",1,1,716,3)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","NAME",1,1,716,1)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 1",1,1,716,7)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 10",1,1,716,16)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 11",1,1,716,17)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 12",1,1,716,19)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 13",1,1,716,18)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 2",1,1,716,8)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 3",1,1,716,9)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 4",1,1,716,10)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",188,"AY","CAP","PARAM 5",1,1,716,11)
 ;;=
