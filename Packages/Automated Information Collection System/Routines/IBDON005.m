IBDON005 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",806,10,2,"^")
 ;;=IBDF VIEW TOOL KIT BLOCK
 ;;^UTILITY(U,$J,"PRO",806,10,3,0)
 ;;=824^EX^3^^^Exit
 ;;^UTILITY(U,$J,"PRO",806,10,3,"^")
 ;;=IBDF EF QUIT
 ;;^UTILITY(U,$J,"PRO",806,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",806,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",806,99)
 ;;=56473,40767
 ;;^UTILITY(U,$J,"PRO",807,0)
 ;;=IBDF VIEW TOOL KIT BLOCK^View Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",807,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",807,2,1,0)
 ;;=VB
 ;;^UTILITY(U,$J,"PRO",807,2,"B","VB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",807,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",807,20)
 ;;=D VIEWBLK^IBDF8
 ;;^UTILITY(U,$J,"PRO",807,28)
 ;;=View Block:
 ;;^UTILITY(U,$J,"PRO",807,99)
 ;;=56301,49967
 ;;^UTILITY(U,$J,"PRO",808,0)
 ;;=IBDF EDIT SELECTION^Edit List Item^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",808,1,0)
 ;;=^^1^1^2950414^^^^
 ;;^UTILITY(U,$J,"PRO",808,1,1,0)
 ;;=Allows editing of an existing selection
 ;;^UTILITY(U,$J,"PRO",808,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",808,2,1,0)
 ;;=EI
 ;;^UTILITY(U,$J,"PRO",808,2,"B","EI",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",808,20)
 ;;=D EDIT^IBDF4A
 ;;^UTILITY(U,$J,"PRO",808,28)
 ;;=Edit List Item: 
 ;;^UTILITY(U,$J,"PRO",808,99)
 ;;=56351,48951
 ;;^UTILITY(U,$J,"PRO",809,0)
 ;;=IBDF DELETE SELECTION^Delete From List^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",809,1,0)
 ;;=^^1^1^2950414^^
 ;;^UTILITY(U,$J,"PRO",809,1,1,0)
 ;;=Allows the user to choose existing selections for deletion.
 ;;^UTILITY(U,$J,"PRO",809,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",809,2,1,0)
 ;;=DL
 ;;^UTILITY(U,$J,"PRO",809,2,"B","DL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",809,20)
 ;;=D DELETE^IBDF4A
 ;;^UTILITY(U,$J,"PRO",809,99)
 ;;=56351,48774
 ;;^UTILITY(U,$J,"PRO",810,0)
 ;;=IBDF MOVE BLOCK^Move Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",810,1,0)
 ;;=^^1^1^2930119^^^^
 ;;^UTILITY(U,$J,"PRO",810,1,1,0)
 ;;=Moves a block to any position on the form.
 ;;^UTILITY(U,$J,"PRO",810,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",810,2,1,0)
 ;;=MB
 ;;^UTILITY(U,$J,"PRO",810,2,2,0)
 ;;=MV
 ;;^UTILITY(U,$J,"PRO",810,2,"B","MB",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",810,2,"B","MV",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",810,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",810,20)
 ;;=D MOVE^IBDF5
 ;;^UTILITY(U,$J,"PRO",810,28)
 ;;=Move Block: 
 ;;^UTILITY(U,$J,"PRO",810,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",811,0)
 ;;=IBDF RESIZE BLOCK (WHILE EDITING FORM)^Block Size^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",811,1,0)
 ;;=^^1^1^2930510^
 ;;^UTILITY(U,$J,"PRO",811,1,1,0)
 ;;=Allows the user to change the height and width of the block.
 ;;^UTILITY(U,$J,"PRO",811,2,0)
 ;;=^101.02A^2^2
 ;;^UTILITY(U,$J,"PRO",811,2,1,0)
 ;;=RS
 ;;^UTILITY(U,$J,"PRO",811,2,2,0)
 ;;=BS
 ;;^UTILITY(U,$J,"PRO",811,2,"B","BS",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",811,2,"B","RS",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",811,10,0)
 ;;=^101.01PA^0^0
 ;;^UTILITY(U,$J,"PRO",811,20)
 ;;=D RESIZE^IBDF5
 ;;^UTILITY(U,$J,"PRO",811,28)
 ;;=Resize Block: 
 ;;^UTILITY(U,$J,"PRO",811,99)
 ;;=56301,49966
 ;;^UTILITY(U,$J,"PRO",812,0)
 ;;=IBDF DISPLAY FORM BLOCK FOR EDIT^Edit Block^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",812,1,0)
 ;;=^^1^1^2930727^^^
 ;;^UTILITY(U,$J,"PRO",812,1,1,0)
 ;;=Allows the user to select a block from the form for editing.
 ;;^UTILITY(U,$J,"PRO",812,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",812,2,1,0)
 ;;=ED
 ;;^UTILITY(U,$J,"PRO",812,2,"B","ED",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",812,15)
 ;;=I $G(IBFASTXT) S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",812,20)
 ;;=D EDITBLK^IBDF5B
 ;;^UTILITY(U,$J,"PRO",812,28)
 ;;=Edit Block: 
 ;;^UTILITY(U,$J,"PRO",812,99)
 ;;=56301,49961
 ;;^UTILITY(U,$J,"PRO",813,0)
 ;;=IBDF EDIT FORM BLOCK MENU^Edit Form Block Menu^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",813,1,0)
 ;;=^^1^1^2930120^^^^
 ;;^UTILITY(U,$J,"PRO",813,1,1,0)
 ;;=A menu of actions the user can use to define what is inside a form block.
 ;;^UTILITY(U,$J,"PRO",813,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",813,10,0)
 ;;=^101.01PA^9^10
 ;;^UTILITY(U,$J,"PRO",813,10,1,0)
 ;;=814^LT^3^^^List
 ;;^UTILITY(U,$J,"PRO",813,10,1,"^")
 ;;=IBDF SELECTION LIST
 ;;^UTILITY(U,$J,"PRO",813,10,2,0)
 ;;=820^BS^2
 ;;^UTILITY(U,$J,"PRO",813,10,2,"^")
 ;;=IBDF RESIZE BLOCK (WHILE EDITING BLOCK)
 ;;^UTILITY(U,$J,"PRO",813,10,3,0)
 ;;=821^EH^1^^^Header/Descr/Outline
 ;;^UTILITY(U,$J,"PRO",813,10,3,"^")
 ;;=IBDF EDIT NAME,HEADER,OUTLINE
 ;;^UTILITY(U,$J,"PRO",813,10,4,0)
 ;;=822^DF^4^^^Data Field
 ;;^UTILITY(U,$J,"PRO",813,10,4,"^")
 ;;=IBDF DATA FIELD
