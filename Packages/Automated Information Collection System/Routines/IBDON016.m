IBDON016 ; ; 03-APR-1996
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;; 3-APR-96
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1319,20)
 ;;=D REMOVE^IBDFC
 ;;^UTILITY(U,$J,"PRO",1319,99)
 ;;=56308,34056
 ;;^UTILITY(U,$J,"PRO",1322,0)
 ;;=IBDFC MENU FOR CONVERTED FORMS^MENU FOR CONVERTED FORMS^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1322,1,0)
 ;;=^^1^1^2950302^
 ;;^UTILITY(U,$J,"PRO",1322,1,1,0)
 ;;=Menu for working with the list of converted forms.
 ;;^UTILITY(U,$J,"PRO",1322,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1322,2,2,0)
 ;;=LIST
 ;;^UTILITY(U,$J,"PRO",1322,2,"B","LIST",2)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1322,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1322,10,0)
 ;;=^101.01PA^7^7
 ;;^UTILITY(U,$J,"PRO",1322,10,1,0)
 ;;=802^EF^2
 ;;^UTILITY(U,$J,"PRO",1322,10,1,"^")
 ;;=IBDF EDIT FORM
 ;;^UTILITY(U,$J,"PRO",1322,10,2,0)
 ;;=831^NM^1
 ;;^UTILITY(U,$J,"PRO",1322,10,2,"^")
 ;;=IBDF EDIT FORM NAME/DESCR/SIZE
 ;;^UTILITY(U,$J,"PRO",1322,10,3,0)
 ;;=1331^VW^3
 ;;^UTILITY(U,$J,"PRO",1322,10,3,"^")
 ;;=IBDFC VIEW SCANNING WARNINGS
 ;;^UTILITY(U,$J,"PRO",1322,10,4,0)
 ;;=1333^SI^4
 ;;^UTILITY(U,$J,"PRO",1322,10,4,"^")
 ;;=IBDF PRINT FORM DEFINITION
 ;;^UTILITY(U,$J,"PRO",1322,10,5,0)
 ;;=1332^RC^5
 ;;^UTILITY(U,$J,"PRO",1322,10,5,"^")
 ;;=IBDFC REPLACE IN CLINICS
 ;;^UTILITY(U,$J,"PRO",1322,10,6,0)
 ;;=1336^DF^6
 ;;^UTILITY(U,$J,"PRO",1322,10,6,"^")
 ;;=IBDFC DELETE CONVERTED FORM
 ;;^UTILITY(U,$J,"PRO",1322,10,7,0)
 ;;=1337^PL^8
 ;;^UTILITY(U,$J,"PRO",1322,10,7,"^")
 ;;=IBDFC PURGE CONVERSION LOG
 ;;^UTILITY(U,$J,"PRO",1322,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1322,99)
 ;;=56315,38241
 ;;^UTILITY(U,$J,"PRO",1323,0)
 ;;=IBDFC LIST CONVERTED FORMS^View Conversion Log^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1323,1,0)
 ;;=^^1^1^2950306^^
 ;;^UTILITY(U,$J,"PRO",1323,1,1,0)
 ;;=Used to go to the screen that lists all of the converted forms.
 ;;^UTILITY(U,$J,"PRO",1323,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1323,2,1,0)
 ;;=VL
 ;;^UTILITY(U,$J,"PRO",1323,2,"B","VL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1323,15)
 ;;=I $G(IBFASTXT) S VALMBCK="Q"
 ;;^UTILITY(U,$J,"PRO",1323,20)
 ;;=D LIST^IBDFC1
 ;;^UTILITY(U,$J,"PRO",1323,99)
 ;;=56315,34334
 ;;^UTILITY(U,$J,"PRO",1324,0)
 ;;=IBDF EF HELP SPEC INST^Special Instruc Help^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1324,20)
 ;;=D EN^IBDFHLP
 ;;^UTILITY(U,$J,"PRO",1324,99)
 ;;=56308,50064
 ;;^UTILITY(U,$J,"PRO",1325,0)
 ;;=IBDF EF HELP MENU^Help Menu^^M^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1325,4)
 ;;=26^4
 ;;^UTILITY(U,$J,"PRO",1325,10,0)
 ;;=^101.01PA^^
 ;;^UTILITY(U,$J,"PRO",1325,26)
 ;;=D SHOW^VALM
 ;;^UTILITY(U,$J,"PRO",1325,28)
 ;;=Select Action: 
 ;;^UTILITY(U,$J,"PRO",1325,99)
 ;;=56308,51083
 ;;^UTILITY(U,$J,"PRO",1327,0)
 ;;=IBDFC CONVERT LISTED FORMS^Convert List^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1327,1,0)
 ;;=^^3^3^2951208^^
 ;;^UTILITY(U,$J,"PRO",1327,1,1,0)
 ;;=Converts all the forms on the list. The original forms are left unchanged.
 ;;^UTILITY(U,$J,"PRO",1327,1,2,0)
 ;;=The forms are copied, the copied form is renamed with a CNV. prefix, and
 ;;^UTILITY(U,$J,"PRO",1327,1,3,0)
 ;;=it is the copy that is converted.
 ;;^UTILITY(U,$J,"PRO",1327,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1327,2,1,0)
 ;;=CL
 ;;^UTILITY(U,$J,"PRO",1327,2,"B","CL",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1327,20)
 ;;=D CNVTLIST^IBDFC
 ;;^UTILITY(U,$J,"PRO",1327,99)
 ;;=56309,30915
 ;;^UTILITY(U,$J,"PRO",1331,0)
 ;;=IBDFC VIEW SCANNING WARNINGS^View Warnings^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1331,1,0)
 ;;=^^2^2^2950306^^^
 ;;^UTILITY(U,$J,"PRO",1331,1,1,0)
 ;;=Allows the potential problems discovered durring the conversion process to
 ;;^UTILITY(U,$J,"PRO",1331,1,2,0)
 ;;=be viewed.
 ;;^UTILITY(U,$J,"PRO",1331,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1331,2,1,0)
 ;;=VW
 ;;^UTILITY(U,$J,"PRO",1331,2,"B","VW",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1331,20)
 ;;=D WARNINGS^IBDFC1
 ;;^UTILITY(U,$J,"PRO",1331,99)
 ;;=56309,40232
 ;;^UTILITY(U,$J,"PRO",1332,0)
 ;;=IBDFC REPLACE IN CLINICS^Replace In Clinics^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
 ;;^UTILITY(U,$J,"PRO",1332,1,0)
 ;;=^^2^2^2950306^^^
 ;;^UTILITY(U,$J,"PRO",1332,1,1,0)
 ;;=Used to substitute the converted forms for the original forms in the
 ;;^UTILITY(U,$J,"PRO",1332,1,2,0)
 ;;=clinics.
 ;;^UTILITY(U,$J,"PRO",1332,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1332,2,1,0)
 ;;=RC
 ;;^UTILITY(U,$J,"PRO",1332,2,"B","RC",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1332,20)
 ;;=D REPLACE^IBDFC3
 ;;^UTILITY(U,$J,"PRO",1332,99)
 ;;=56309,40377
 ;;^UTILITY(U,$J,"PRO",1333,0)
 ;;=IBDF PRINT FORM DEFINITION^Scanning Info^^A^^^^^^^^AUTOMATED INFO COLLECTION SYS
