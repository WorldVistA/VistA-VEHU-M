GMTSO002 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1385,3,0)
 ;;=^101.03PA^0^0
 ;;^UTILITY(U,$J,"PRO",1385,20)
 ;;=D MAIN^GMTSPD
 ;;^UTILITY(U,$J,"PRO",1385,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1386,0)
 ;;=GMTS USER^Health Summary User Menu^^M^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1386,1,0)
 ;;=^^8^8^2910301^
 ;;^UTILITY(U,$J,"PRO",1386,1,1,0)
 ;;=This menu allows the user to print Health Summaries by Patient or Hospital 
 ;;^UTILITY(U,$J,"PRO",1386,1,2,0)
 ;;=Location with a pre-defined Health Summary Type, or print Health Summaries 
 ;;^UTILITY(U,$J,"PRO",1386,1,3,0)
 ;;=for patients, based on ad hoc Health Summary definitions.  The user may also
 ;;^UTILITY(U,$J,"PRO",1386,1,4,0)
 ;;=use the Information Menu to list and inquire about Health Summary Types and
 ;;^UTILITY(U,$J,"PRO",1386,1,5,0)
 ;;=Health Summary Components.  
 ;;^UTILITY(U,$J,"PRO",1386,1,6,0)
 ;;=   
 ;;^UTILITY(U,$J,"PRO",1386,1,7,0)
 ;;=This menu does not contain the options which allow the user to create or 
 ;;^UTILITY(U,$J,"PRO",1386,1,8,0)
 ;;=delete his/her own Health Summary Types.  
 ;;^UTILITY(U,$J,"PRO",1386,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1386,2,2,0)
 ;;=HS USER MENU
 ;;^UTILITY(U,$J,"PRO",1386,2,"B","HS USER MENU",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1386,3,0)
 ;;=^101.03PA^56434,65466^1
 ;;^UTILITY(U,$J,"PRO",1386,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1386,4)
 ;;=^^Y
 ;;^UTILITY(U,$J,"PRO",1386,10,0)
 ;;=^101.01PA^4^4
 ;;^UTILITY(U,$J,"PRO",1386,10,1,0)
 ;;=1384^2^2
 ;;^UTILITY(U,$J,"PRO",1386,10,1,"^")
 ;;=GMTS HS ADHOC
 ;;^UTILITY(U,$J,"PRO",1386,10,2,0)
 ;;=1385^3^3
 ;;^UTILITY(U,$J,"PRO",1386,10,2,"^")
 ;;=GMTS HS BY LOC
 ;;^UTILITY(U,$J,"PRO",1386,10,3,0)
 ;;=1383^1^1
 ;;^UTILITY(U,$J,"PRO",1386,10,3,"^")
 ;;=GMTS HS BY PATIENT
 ;;^UTILITY(U,$J,"PRO",1386,10,4,0)
 ;;=1387^4^4
 ;;^UTILITY(U,$J,"PRO",1386,10,4,"^")
 ;;=GMTS INFO ONLY MENU
 ;;^UTILITY(U,$J,"PRO",1386,26)
 ;;=S ORUIEN=XQORNOD D OE^ORUHDR K ORUIEN
 ;;^UTILITY(U,$J,"PRO",1386,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1387,0)
 ;;=GMTS INFO ONLY MENU^Health Summary Information Menu^^M^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1387,1,0)
 ;;=^^2^2^2910301^
 ;;^UTILITY(U,$J,"PRO",1387,1,1,0)
 ;;=This menu contains options which provide information only about Health
 ;;^UTILITY(U,$J,"PRO",1387,1,2,0)
 ;;=Summary Types and Health Summary Components.  
 ;;^UTILITY(U,$J,"PRO",1387,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1387,2,2,0)
 ;;=HS INFO MENU
 ;;^UTILITY(U,$J,"PRO",1387,2,"B","HS INFO MENU",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1387,3,0)
 ;;=^101.03PA^88^1
 ;;^UTILITY(U,$J,"PRO",1387,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1387,4)
 ;;=^^Y
 ;;^UTILITY(U,$J,"PRO",1387,10,0)
 ;;=^101.01PA^5^5
 ;;^UTILITY(U,$J,"PRO",1387,10,1,0)
 ;;=1382^5^5
 ;;^UTILITY(U,$J,"PRO",1387,10,1,"^")
 ;;=GMTS COMP DESC LIST
 ;;^UTILITY(U,$J,"PRO",1387,10,2,0)
 ;;=1388^3^3
 ;;^UTILITY(U,$J,"PRO",1387,10,2,"^")
 ;;=GMTS COMP INQ
 ;;^UTILITY(U,$J,"PRO",1387,10,3,0)
 ;;=1429^4^4
 ;;^UTILITY(U,$J,"PRO",1387,10,3,"^")
 ;;=GMTS COMP LIST
 ;;^UTILITY(U,$J,"PRO",1387,10,4,0)
 ;;=1389^1^1
 ;;^UTILITY(U,$J,"PRO",1387,10,4,"^")
 ;;=GMTS TYPE INQUIRE
 ;;^UTILITY(U,$J,"PRO",1387,10,5,0)
 ;;=1430^2^2
 ;;^UTILITY(U,$J,"PRO",1387,10,5,"^")
 ;;=GMTS TYPE LIST
 ;;^UTILITY(U,$J,"PRO",1387,26)
 ;;=S ORUIEN=XQORNOD D OE^ORUHDR K ORUIEN
 ;;^UTILITY(U,$J,"PRO",1387,99)
 ;;=56434,65466
 ;;^UTILITY(U,$J,"PRO",1388,0)
 ;;=GMTS COMP INQ^Inquire about a Health Summary Component^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1388,1,0)
 ;;=^^2^2^2910301^
 ;;^UTILITY(U,$J,"PRO",1388,1,1,0)
 ;;=This allows the user to display the characteristics of a Health Summary 
