VALMO004 ; ; 13-AUG-1993
 ;;1;List Manager;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",672,10,0)
 ;;=^101.01PA^6^6
 ;;^UTILITY(U,$J,"PRO",672,10,1,0)
 ;;=665^^1
 ;;^UTILITY(U,$J,"PRO",672,10,1,"^")
 ;;=VALM DEMOGRAPHICS
 ;;^UTILITY(U,$J,"PRO",672,10,2,0)
 ;;=670^^2
 ;;^UTILITY(U,$J,"PRO",672,10,2,"^")
 ;;=VALM LIST REGION EDIT
 ;;^UTILITY(U,$J,"PRO",672,10,3,0)
 ;;=669^^3
 ;;^UTILITY(U,$J,"PRO",672,10,3,"^")
 ;;=VALM PROTOCOL INFORMATION
 ;;^UTILITY(U,$J,"PRO",672,10,4,0)
 ;;=667^^5
 ;;^UTILITY(U,$J,"PRO",672,10,4,"^")
 ;;=VALM MUMPS CODE EDIT
 ;;^UTILITY(U,$J,"PRO",672,10,5,0)
 ;;=668^^4
 ;;^UTILITY(U,$J,"PRO",672,10,5,"^")
 ;;=VALM OTHER FIELDS
 ;;^UTILITY(U,$J,"PRO",672,10,6,0)
 ;;=666^^6
 ;;^UTILITY(U,$J,"PRO",672,10,6,"^")
 ;;=VALM CAPTION EDIT
 ;;^UTILITY(U,$J,"PRO",672,15)
 ;;=K VALMALL S VALMBCK="R" D BLD^VALMWB
 ;;^UTILITY(U,$J,"PRO",672,20)
 ;;=S VALMALL=""
 ;;^UTILITY(U,$J,"PRO",672,99)
 ;;=55598,37540
 ;;^UTILITY(U,$J,"PRO",673,0)
 ;;=VALM PROTOCOL EDIT^Protocol Edit^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",673,15)
 ;;=S VALMBCK="R"
 ;;^UTILITY(U,$J,"PRO",673,20)
 ;;=D FULL^VALM1,4^VALMW
 ;;^UTILITY(U,$J,"PRO",673,99)
 ;;=55598,37539
 ;;^UTILITY(U,$J,"PRO",674,0)
 ;;=VALM RUN LIST^Run List^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",674,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",674,20)
 ;;=D RUN^VALMW2(VALMIFN)
 ;;^UTILITY(U,$J,"PRO",674,99)
 ;;=55598,37544
 ;;^UTILITY(U,$J,"PRO",675,0)
 ;;=VALM INPUT TEMPLATE EDIT^Input Template^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",675,20)
 ;;=D FULL^VALM1,^DIB S VALMBCK="R"
 ;;^UTILITY(U,$J,"PRO",675,99)
 ;;=55598,37503
 ;;^UTILITY(U,$J,"PRO",678,0)
 ;;=VALM LIST ENTRY^List Template Entry/Edit^^M^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",678,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",678,10,0)
 ;;=^101.01PA^11^11
 ;;^UTILITY(U,$J,"PRO",678,10,1,0)
 ;;=665^DE^1
 ;;^UTILITY(U,$J,"PRO",678,10,1,"^")
 ;;=VALM DEMOGRAPHICS
 ;;^UTILITY(U,$J,"PRO",678,10,2,0)
 ;;=669^PI^2
 ;;^UTILITY(U,$J,"PRO",678,10,2,"^")
 ;;=VALM PROTOCOL INFORMATION
 ;;^UTILITY(U,$J,"PRO",678,10,3,0)
 ;;=670^LR^3
 ;;^UTILITY(U,$J,"PRO",678,10,3,"^")
 ;;=VALM LIST REGION EDIT
 ;;^UTILITY(U,$J,"PRO",678,10,4,0)
 ;;=668^OF^4
 ;;^UTILITY(U,$J,"PRO",678,10,4,"^")
 ;;=VALM OTHER FIELDS
 ;;^UTILITY(U,$J,"PRO",678,10,5,0)
 ;;=667^MC^5
 ;;^UTILITY(U,$J,"PRO",678,10,5,"^")
 ;;=VALM MUMPS CODE EDIT
 ;;^UTILITY(U,$J,"PRO",678,10,6,0)
 ;;=666^CE^6
 ;;^UTILITY(U,$J,"PRO",678,10,6,"^")
 ;;=VALM CAPTION EDIT
 ;;^UTILITY(U,$J,"PRO",678,10,7,0)
 ;;=671^CL^7
 ;;^UTILITY(U,$J,"PRO",678,10,7,"^")
 ;;=VALM CHANGE LIST
 ;;^UTILITY(U,$J,"PRO",678,10,8,0)
 ;;=672^EA^8
 ;;^UTILITY(U,$J,"PRO",678,10,8,"^")
 ;;=VALM EDIT ALL
 ;;^UTILITY(U,$J,"PRO",678,10,9,0)
 ;;=673^PE^9
 ;;^UTILITY(U,$J,"PRO",678,10,9,"^")
 ;;=VALM PROTOCOL EDIT
 ;;^UTILITY(U,$J,"PRO",678,10,10,0)
 ;;=674^RN^10
 ;;^UTILITY(U,$J,"PRO",678,10,10,"^")
 ;;=VALM RUN LIST
 ;;^UTILITY(U,$J,"PRO",678,10,11,0)
 ;;=675^IT^12
 ;;^UTILITY(U,$J,"PRO",678,10,11,"^")
 ;;=VALM INPUT TEMPLATE EDIT
 ;;^UTILITY(U,$J,"PRO",678,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",678,28)
 ;;=Select Tool:
 ;;^UTILITY(U,$J,"PRO",678,99)
 ;;=55598,37544
 ;;^UTILITY(U,$J,"PRO",707,0)
 ;;=VALM DEMO MENU^List Package Protocols^^M^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",707,1,0)
 ;;=^^2^2^2920402^
 ;;^UTILITY(U,$J,"PRO",707,1,1,0)
 ;;=Allows user to list a package's options and take some actions against
 ;;^UTILITY(U,$J,"PRO",707,1,2,0)
 ;;=those options.
 ;;^UTILITY(U,$J,"PRO",707,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",707,10,0)
 ;;=^101.01PA^4^4
 ;;^UTILITY(U,$J,"PRO",707,10,1,0)
 ;;=708^PE^10
 ;;^UTILITY(U,$J,"PRO",707,10,1,"^")
 ;;=VALM DEMO PROTOCOL EDIT
 ;;^UTILITY(U,$J,"PRO",707,10,2,0)
 ;;=645^EP^21
 ;;^UTILITY(U,$J,"PRO",707,10,2,"^")
 ;;=VALM EXPAND
 ;;^UTILITY(U,$J,"PRO",707,10,3,0)
 ;;=709^DE^11
 ;;^UTILITY(U,$J,"PRO",707,10,3,"^")
 ;;=VALM DEMO DESC
 ;;^UTILITY(U,$J,"PRO",707,10,4,0)
 ;;=710^CP^12
 ;;^UTILITY(U,$J,"PRO",707,10,4,"^")
 ;;=VALM DEMO CHANGE PACKAGE
 ;;^UTILITY(U,$J,"PRO",707,20)
 ;;=
 ;;^UTILITY(U,$J,"PRO",707,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",707,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",707,99)
 ;;=55600,51712
 ;;^UTILITY(U,$J,"PRO",708,0)
 ;;=VALM DEMO PROTOCOL EDIT^Protocol Edit^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",708,20)
 ;;=D EDIT^VALMD
 ;;^UTILITY(U,$J,"PRO",708,99)
 ;;=55598,37442
 ;;^UTILITY(U,$J,"PRO",709,0)
 ;;=VALM DEMO DESC^Show Description^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",709,20)
 ;;=D DESC^VALMD
 ;;^UTILITY(U,$J,"PRO",709,99)
 ;;=55598,37422
 ;;^UTILITY(U,$J,"PRO",710,0)
 ;;=VALM DEMO CHANGE PACKAGE^Change Package^^A^^^^^^^^LIST MANAGER
 ;;^UTILITY(U,$J,"PRO",710,1,0)
 ;;=^^1^1^2920402^
 ;;^UTILITY(U,$J,"PRO",710,1,1,0)
 ;;=Allows users to change package.
