IBDON007 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",820,1,1,0)
 ;;=This allows the user to change the height and width of the block while he
 ;;^UTILITY(U,$J,"PRO",820,1,2,0)
 ;;=is editing the block.
 ;;^UTILITY(U,$J,"PRO",820,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",820,2,1,0)
 ;;=RS
 ;;^UTILITY(U,$J,"PRO",820,2,2,0)
 ;;=BS
 ;;^UTILITY(U,$J,"PRO",820,2,"B","BS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",820,2,"B","RS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",820,20)
 ;;=D RESIZE^IBDF9
 ;;^UTILITY(U,$J,"PRO",820,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",821,0)
 ;;=IBDF EDIT NAME,HEADER,OUTLINE^Header/Descr/Outline^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",821,1,0)
 ;;=^^1^1^2930201^
 ;;^UTILITY(U,$J,"PRO",821,1,1,0)
 ;;=Allows editing of the block header and outline type.
 ;;^UTILITY(U,$J,"PRO",821,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",821,2,1,0)
 ;;=EH
 ;;^UTILITY(U,$J,"PRO",821,2,"B","EH",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",821,20)
 ;;=D EDITBLK^IBDF9
 ;;^UTILITY(U,$J,"PRO",821,99)
 ;;=56301,49963
 ;;^UTILITY(U,$J,"PRO",822,0)
 ;;=IBDF DATA FIELD^Data Field^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",822,1,0)
 ;;=^^2^2^2930322^
 ;;^UTILITY(U,$J,"PRO",822,1,1,0)
 ;;=Allows the user to create a new data field or edit or delete an already
 ;;^UTILITY(U,$J,"PRO",822,1,2,0)
 ;;=existing one.
 ;;^UTILITY(U,$J,"PRO",822,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",822,2,2,0)
 ;;=DF
 ;;^UTILITY(U,$J,"PRO",822,2,"B","DF",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",822,20)
 ;;=D FIELD^IBDF9B
 ;;^UTILITY(U,$J,"PRO",822,99)
 ;;=56301,49960
 ;;^UTILITY(U,$J,"PRO",823,0)
 ;;=IBDF STRAIGHT LINE^Straight Line^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",823,1,0)
 ;;=^^2^2^2930324^^
 ;;^UTILITY(U,$J,"PRO",823,1,1,0)
 ;;=Allows a straight line, either horizontal or vertical, to be created,
 ;;^UTILITY(U,$J,"PRO",823,1,2,0)
 ;;=deleted or edited.
 ;;^UTILITY(U,$J,"PRO",823,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",823,2,2,0)
 ;;=LN
 ;;^UTILITY(U,$J,"PRO",823,2,"B","LN",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",823,20)
 ;;=D LINE^IBDF9D
 ;;^UTILITY(U,$J,"PRO",823,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",824,0)
 ;;=IBDF EF QUIT^EXIT^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",824,.1)
 ;;=EXIT
 ;;^UTILITY(U,$J,"PRO",824,1,0)
 ;;=^^2^2^2950809^^^^
 ;;^UTILITY(U,$J,"PRO",824,1,1,0)
 ;;=Allows the user to exit the system without quitting through the hierarchy of
 ;;^UTILITY(U,$J,"PRO",824,1,2,0)
 ;;=screens, or the user can exit to the previous screen.
 ;;^UTILITY(U,$J,"PRO",824,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",824,2,2,0)
 ;;=EXIT
 ;;^UTILITY(U,$J,"PRO",824,2,"B","EXIT",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",824,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",824,20)
 ;;=D FASTEXIT^IBDFU3
 ;;^UTILITY(U,$J,"PRO",824,99)
 ;;=56468,47910
 ;;^UTILITY(U,$J,"PRO",824,101.0431,0)
 ;;=^^3^3^2950809^^
 ;;^UTILITY(U,$J,"PRO",824,101.0431,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",824,101.0431,2,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",824,101.0431,3,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",825,0)
 ;;=IBDF EDIT HEADER BLOCK^Form Header^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",825,1,0)
 ;;=^^1^1^2930211^
 ;;^UTILITY(U,$J,"PRO",825,1,1,0)
 ;;=Allows the form header to be edited
 ;;^UTILITY(U,$J,"PRO",825,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",825,2,1,0)
 ;;=FH
 ;;^UTILITY(U,$J,"PRO",825,2,"B","FH",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",825,20)
 ;;=D EDITHDR^IBDF9C
 ;;^UTILITY(U,$J,"PRO",825,99)
 ;;=56301,49963
 ;;^UTILITY(U,$J,"PRO",826,0)
 ;;=IBDF PRINT SAMPLE FORM^Print Sample Form^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",826,1,0)
 ;;=^^1^1^2950130^^^^
 ;;^UTILITY(U,$J,"PRO",826,1,1,0)
 ;;=Allows a sample form, without patient information, to be printed.
 ;;^UTILITY(U,$J,"PRO",826,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",826,2,1,0)
 ;;=PF
 ;;^UTILITY(U,$J,"PRO",826,2,"B","PF",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",826,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",826,20)
 ;;=D PRINT^IBDF5B
 ;;^UTILITY(U,$J,"PRO",826,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",827,0)
 ;;=IBDF DELETE FORM^Delete Unused Form^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",827,1,0)
 ;;=^^6^6^2930224^
 ;;^UTILITY(U,$J,"PRO",827,1,1,0)
 ;;= 
 ;;^UTILITY(U,$J,"PRO",827,1,2,0)
 ;;=Allows the user to delete a form. Deletion is not allowed if the form is
 ;;^UTILITY(U,$J,"PRO",827,1,3,0)
 ;;=in use by any clinic. In that case the form must first be deleted from the
 ;;^UTILITY(U,$J,"PRO",827,1,4,0)
 ;;=clinic setup, and then actually deleted using this action. This two step
 ;;^UTILITY(U,$J,"PRO",827,1,5,0)
 ;;=process is used to be on the safe side, since a form may be in use by more
