GMTSO001 ; ; 19-OCT-1995
 ;;2.7;Health Summary;;Oct 20, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"PRO",1382,0)
 ;;=GMTS COMP DESC LIST^List Health Summary Component Descriptions^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1382,1,0)
 ;;=^^2^2^2910301^
 ;;^UTILITY(U,$J,"PRO",1382,1,1,0)
 ;;=Lists all components which may be used to define Health Summary Types, along
 ;;^UTILITY(U,$J,"PRO",1382,1,2,0)
 ;;=with the abbreviation and a brief description of each.  
 ;;^UTILITY(U,$J,"PRO",1382,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1382,2,1,0)
 ;;=HS COMP DESC LIST
 ;;^UTILITY(U,$J,"PRO",1382,2,"B","HS COMP DESC LIST",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1382,3,0)
 ;;=^101.03PA^0^0
 ;;^UTILITY(U,$J,"PRO",1382,20)
 ;;=W ! S DIC="^GMT(142.1,",L=0,FLDS="[GMTS COMP DESC LIST]",BY=.01,FR="A",TO="zzzz" D EN1^DIP S DIR(0)="E" D ^DIR
 ;;^UTILITY(U,$J,"PRO",1382,99)
 ;;=56434,65464
 ;;^UTILITY(U,$J,"PRO",1383,0)
 ;;=GMTS HS BY PATIENT^Patient Health Summary^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1383,1,0)
 ;;=^^2^2^2910301^
 ;;^UTILITY(U,$J,"PRO",1383,1,1,0)
 ;;=Generates a Health Summary of a specified pre-defined Health Summary Type for
 ;;^UTILITY(U,$J,"PRO",1383,1,2,0)
 ;;=a specified patient.  
 ;;^UTILITY(U,$J,"PRO",1383,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1383,2,1,0)
 ;;=HS PRINT BY PATIENT
 ;;^UTILITY(U,$J,"PRO",1383,2,"B","HS PRINT BY PATIENT",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1383,3,0)
 ;;=^101.03PA^0^0
 ;;^UTILITY(U,$J,"PRO",1383,15)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1383,20)
 ;;=W ! S DIC("B")=$P($G(^GMT(142,+$G(^DISV(+$G(DUZ),"^GMT(142,")),0)),U),GMTSTYP=0 S:'$D(DFN) DFN=$S($D(ORVP):$P(ORVP,";"),1:"") D SELPT^GMTS:+DFN'>0,SELTYP^GMTS Q:GMTSTYP'>0  D HSOUT^GMTS
 ;;^UTILITY(U,$J,"PRO",1383,26)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1383,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1384,0)
 ;;=GMTS HS ADHOC^Health Summary Ad Hoc^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1384,1,0)
 ;;=^^5^5^2930825^^^
 ;;^UTILITY(U,$J,"PRO",1384,1,1,0)
 ;;=Generates an 'Ad Hoc' Health Summary for specified patients.  Instead of 
 ;;^UTILITY(U,$J,"PRO",1384,1,2,0)
 ;;=selecting a pre-defined Health Summary Type, the user defines his own ad hoc
 ;;^UTILITY(U,$J,"PRO",1384,1,3,0)
 ;;=Health Summary structure for temporary use while using this option.  The user
 ;;^UTILITY(U,$J,"PRO",1384,1,4,0)
 ;;=selects Health Summary components, time and occurrence limits when
 ;;^UTILITY(U,$J,"PRO",1384,1,5,0)
 ;;=applicable, and selection items when applicable.  
 ;;^UTILITY(U,$J,"PRO",1384,2,0)
 ;;=^101.02A^1^1
 ;;^UTILITY(U,$J,"PRO",1384,2,1,0)
 ;;=HS AD HOC
 ;;^UTILITY(U,$J,"PRO",1384,2,"B","HS AD HOC",1)
 ;;=
 ;;^UTILITY(U,$J,"PRO",1384,3,0)
 ;;=^101.03PA^88^1
 ;;^UTILITY(U,$J,"PRO",1384,3,1,0)
 ;;=ORWARD
 ;;^UTILITY(U,$J,"PRO",1384,20)
 ;;=W ! D MAIN^GMTSADOR
 ;;^UTILITY(U,$J,"PRO",1384,99)
 ;;=56434,65465
 ;;^UTILITY(U,$J,"PRO",1384,"MEN","OR OE/RR MENU CLINICIAN")
 ;;=1384^HS
 ;;^UTILITY(U,$J,"PRO",1384,"MEN","OR OE/RR MENU NURSE")
 ;;=1384
 ;;^UTILITY(U,$J,"PRO",1384,"MEN","OR OE/RR MENU WARD CLERK")
 ;;=1384
 ;;^UTILITY(U,$J,"PRO",1385,0)
 ;;=GMTS HS BY LOC^Hospital Location Health Summary^^A^^^^^^^^HEALTH SUMMARY
 ;;^UTILITY(U,$J,"PRO",1385,1,0)
 ;;=^^3^3^2910301^
 ;;^UTILITY(U,$J,"PRO",1385,1,1,0)
 ;;=Allows user to print health summaries interactively for all patients on a
 ;;^UTILITY(U,$J,"PRO",1385,1,2,0)
 ;;=specified ward or for all patients with appointments at a specified 
 ;;^UTILITY(U,$J,"PRO",1385,1,3,0)
 ;;=outpatient clinic on a selected day.  
 ;;^UTILITY(U,$J,"PRO",1385,2,0)
 ;;=^101.02A^2^1
 ;;^UTILITY(U,$J,"PRO",1385,2,2,0)
 ;;=HS PRINT BY LOCATION
 ;;^UTILITY(U,$J,"PRO",1385,2,"B","HS PRINT BY LOCATION",2)
 ;;=
