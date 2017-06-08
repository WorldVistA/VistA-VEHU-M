DGONI006 ; ; 13-AUG-1993
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",609,1,2,0)
 ;;=utility.
 ;;^UTILITY(U,$J,"PRO",609,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",609,10,0)
 ;;=^101.01PA^5^26
 ;;^UTILITY(U,$J,"PRO",609,10,22,0)
 ;;=610^AT^10^^^
 ;;^UTILITY(U,$J,"PRO",609,10,22,"^")
 ;;=DGPT ADD A/P TEMPLATE
 ;;^UTILITY(U,$J,"PRO",609,10,23,0)
 ;;=611^DT^12
 ;;^UTILITY(U,$J,"PRO",609,10,23,"^")
 ;;=DGPT DEL A/P TEMPLATE
 ;;^UTILITY(U,$J,"PRO",609,10,24,0)
 ;;=612^ET^11
 ;;^UTILITY(U,$J,"PRO",609,10,24,"^")
 ;;=DGPT EDIT A/P TEMPLATE
 ;;^UTILITY(U,$J,"PRO",609,10,25,0)
 ;;=623^RR^13
 ;;^UTILITY(U,$J,"PRO",609,10,25,"^")
 ;;=DGPT A/P ARCHIVE
 ;;^UTILITY(U,$J,"PRO",609,10,26,0)
 ;;=624^PR^14
 ;;^UTILITY(U,$J,"PRO",609,10,26,"^")
 ;;=DGPT A/P PURGE
 ;;^UTILITY(U,$J,"PRO",609,24)
 ;;=
 ;;^UTILITY(U,$J,"PRO",609,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",609,28)
 ;;=Select Action:
 ;;^UTILITY(U,$J,"PRO",609,99)
 ;;=55572,50861
 ;;^UTILITY(U,$J,"PRO",610,0)
 ;;=DGPT ADD A/P TEMPLATE^Add Template^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",610,.1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",610,1,0)
 ;;=^^1^1^2920922^^
 ;;^UTILITY(U,$J,"PRO",610,1,1,0)
 ;;=This protocol will be used to add a A/P template.
 ;;^UTILITY(U,$J,"PRO",610,4)
 ;;=^^^AT
 ;;^UTILITY(U,$J,"PRO",610,15)
 ;;=D TMPEXIT^DGPTLMU2
 ;;^UTILITY(U,$J,"PRO",610,20)
 ;;=D TMPADD^DGPTLMU2
 ;;^UTILITY(U,$J,"PRO",610,99)
 ;;=55418,28331
 ;;^UTILITY(U,$J,"PRO",611,0)
 ;;=DGPT DEL A/P TEMPLATE^Delete Template^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",611,1,0)
 ;;=^^1^1^2920922^^
 ;;^UTILITY(U,$J,"PRO",611,1,1,0)
 ;;=This protocol is used to delete an entry from PTF A/P History File (#45.62)
 ;;^UTILITY(U,$J,"PRO",611,4)
 ;;=^^^DT
 ;;^UTILITY(U,$J,"PRO",611,15)
 ;;=D TMPEXIT^DGPTLMU2
 ;;^UTILITY(U,$J,"PRO",611,20)
 ;;=D TMPDEL^DGPTLMU2
 ;;^UTILITY(U,$J,"PRO",611,99)
 ;;=55417,51033
 ;;^UTILITY(U,$J,"PRO",612,0)
 ;;=DGPT EDIT A/P TEMPLATE^Edit Template^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",612,1,0)
 ;;=^^1^1^2920922^
 ;;^UTILITY(U,$J,"PRO",612,1,1,0)
 ;;=This function will allow the user to edit a PTF A/P Template.
 ;;^UTILITY(U,$J,"PRO",612,4)
 ;;=^^^ET
 ;;^UTILITY(U,$J,"PRO",612,15)
 ;;=D TMPEXIT^DGPTLMU2
 ;;^UTILITY(U,$J,"PRO",612,20)
 ;;=D TMPED^DGPTLMU2
 ;;^UTILITY(U,$J,"PRO",612,99)
 ;;=55417,52170
 ;;^UTILITY(U,$J,"PRO",613,0)
 ;;=DGPT DETAILED INQUIRY^PTF Detailed Inquiry^^A^^^^^^^^REGISTRATION
 ;;^UTILITY(U,$J,"PRO",613,1,0)
 ;;=^^2^2^2920924^
 ;;^UTILITY(U,$J,"PRO",613,1,1,0)
 ;;=This protocol will be used to display a detailed inquiry of the
 ;;^UTILITY(U,$J,"PRO",613,1,2,0)
 ;;=PTF record selected.
 ;;^UTILITY(U,$J,"PRO",613,20)
 ;;=D DIEN^DGPTLMU4
 ;;^UTILITY(U,$J,"PRO",613,99)
 ;;=55419,54531
 ;;^UTILITY(U,$J,"PRO",623,0)
 ;;=DGPT A/P ARCHIVE^Archive Records^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",623,1,0)
 ;;=^^1^1^2921014^
 ;;^UTILITY(U,$J,"PRO",623,1,1,0)
 ;;=This protocol will be used to Archive PTF records.
 ;;^UTILITY(U,$J,"PRO",623,4)
 ;;=^^^RR
 ;;^UTILITY(U,$J,"PRO",623,15)
 ;;=D ARCEX^DGPTAPA
 ;;^UTILITY(U,$J,"PRO",623,20)
 ;;=D ARC^DGPTAPA
 ;;^UTILITY(U,$J,"PRO",623,99)
 ;;=55439,42122
 ;;^UTILITY(U,$J,"PRO",624,0)
 ;;=DGPT A/P PURGE^Purge Records^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",624,1,0)
 ;;=^^1^1^2921014^
 ;;^UTILITY(U,$J,"PRO",624,1,1,0)
 ;;=This protocol will be used to Purge PTF records.
 ;;^UTILITY(U,$J,"PRO",624,4)
 ;;=^^^PR
 ;;^UTILITY(U,$J,"PRO",624,15)
 ;;=D PUREX^DGPTAPP
 ;;^UTILITY(U,$J,"PRO",624,20)
 ;;=D PUR^DGPTAPP
 ;;^UTILITY(U,$J,"PRO",624,99)
 ;;=55439,42312
 ;;^UTILITY(U,$J,"PRO",625,0)
 ;;=DGJ GROUP 2 EDIT^IRT Group 2 Edit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",625,1,0)
 ;;=^^2^2^2930106^^^
 ;;^UTILITY(U,$J,"PRO",625,1,1,0)
 ;;=This protocol is an action that allows the editing of the data in group 2 of
 ;;^UTILITY(U,$J,"PRO",625,1,2,0)
 ;;=the Incomplete Records screen when editing an IRT report.
 ;;^UTILITY(U,$J,"PRO",625,4)
 ;;=^^^G2
 ;;^UTILITY(U,$J,"PRO",625,20)
 ;;=S DGJTNUM=2 D EDIT^DGJTVW1
 ;;^UTILITY(U,$J,"PRO",625,99)
 ;;=55440,52133
 ;;^UTILITY(U,$J,"PRO",626,0)
 ;;=DGJ GROUP 3 EDIT^IRT Group 3 Edit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",626,1,0)
 ;;=^^2^2^2930106^^^^
 ;;^UTILITY(U,$J,"PRO",626,1,1,0)
 ;;=This protocol is an action that allows the editing of the data in group 3 of
 ;;^UTILITY(U,$J,"PRO",626,1,2,0)
 ;;=the Incomplete Records screen when editing an IRT report.
 ;;^UTILITY(U,$J,"PRO",626,4)
 ;;=^^^G3
 ;;^UTILITY(U,$J,"PRO",626,20)
 ;;=S (X,DGJTNUM)=3 D EDIT^DGJTVW1
 ;;^UTILITY(U,$J,"PRO",626,99)
 ;;=55440,52596
 ;;^UTILITY(U,$J,"PRO",627,0)
 ;;=DGJ GROUP 4 EDIT^IRT Group 4 Edit^^A^^^^^^^^
 ;;^UTILITY(U,$J,"PRO",627,1,0)
 ;;=^^2^2^2921201^^^^
 ;;^UTILITY(U,$J,"PRO",627,1,1,0)
 ;;=This protocol is an action that allows the editing of the data in group 4 of
