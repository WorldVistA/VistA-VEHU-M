IBDEI233 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.6)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.6,9,1,1,0)
 ;;=Used for inputting the visit type that applies to the visit.
 ;;^UTILITY(U,$J,358.6,9,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,9,3)
 ;;=VISIT TYPE OF VISIT
 ;;^UTILITY(U,$J,358.6,9,9)
 ;;=D INPUTCPT^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,9,10)
 ;;=Enter an active Visit Type code.
 ;;^UTILITY(U,$J,358.6,9,11)
 ;;=D TESTVST^IBDFN7
 ;;^UTILITY(U,$J,358.6,9,12)
 ;;=ENCOUNTER^5
 ;;^UTILITY(U,$J,358.6,9,14)
 ;;=S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,9,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,9,17)
 ;;=D SLCTVST^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,9,18)
 ;;=S IBDF("OTHER")="357.69^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Visit Type (EM) Code")
 ;;^UTILITY(U,$J,358.6,9,19)
 ;;=D VST^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,10,0)
 ;;=DG SELECT ICD-9 DIAGNOSIS CODES^ICD9^IBDFN4^SCHEDULING^^3^2^^1^^^1^11^^^^1^1^^^^1
 ;;^UTILITY(U,$J,358.6,10,1,0)
 ;;=^^2^2^2970304^^^^
 ;;^UTILITY(U,$J,358.6,10,1,1,0)
 ;;=Allows the user to select ICD-9 diagnosis codes from the ICD Diagnosis
 ;;^UTILITY(U,$J,358.6,10,1,2,0)
 ;;=file. Allows only active codes to be selected.
 ;;^UTILITY(U,$J,358.6,10,2)
 ;;=CODE^7^DIAGNOSIS^30^DESCRIPTION^200^^^^^^^^^^^1^1
 ;;^UTILITY(U,$J,358.6,10,3)
 ;;=SELECT ICD9 ICD-9 CODES DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,10,9)
 ;;=D INPUTICD^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,10,11)
 ;;=D TESTICD^IBDFN7
 ;;^UTILITY(U,$J,358.6,10,13,0)
 ;;=^358.613V^2^2
 ;;^UTILITY(U,$J,358.6,10,13,1,0)
 ;;=1;IBD(358.98,
 ;;^UTILITY(U,$J,358.6,10,13,2,0)
 ;;=2;IBD(358.98,
 ;;^UTILITY(U,$J,358.6,10,15,0)
 ;;=^357.615I^2^2
 ;;^UTILITY(U,$J,358.6,10,15,1,0)
 ;;=DIAGNOSIS^30^2^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,10,15,2,0)
 ;;=DESCRIPTION^200^3^^DIAGNOSIS
 ;;^UTILITY(U,$J,358.6,10,16)
 ;;=o^4^Diagnosis^^r^1^ICD-9 Code^^1
 ;;^UTILITY(U,$J,358.6,10,17)
 ;;=D SLCTDX^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,10,19)
 ;;=D DX^IBDFN14(X)
 ;;^UTILITY(U,$J,358.6,11,0)
 ;;=INPUT DIAGNOSIS CODE (ICD9)^^^PATIENT CARE ENCOUNTER^^1^^^1^^^1^^^^SMP^^^1
 ;;^UTILITY(U,$J,358.6,11,1,0)
 ;;=^^1^1^2970304^^^^
 ;;^UTILITY(U,$J,358.6,11,1,1,0)
 ;;=Used for inputting ICD9 diagnosis codes.
 ;;^UTILITY(U,$J,358.6,11,2)
 ;;=^^^^^^^^^^^^^^^^^1
 ;;^UTILITY(U,$J,358.6,11,3)
 ;;=INPUT ICD9 ICD-9 DIAGNOSIS CODES
 ;;^UTILITY(U,$J,358.6,11,9)
 ;;=D INPUTICD^IBDFN8(.X)
 ;;^UTILITY(U,$J,358.6,11,10)
 ;;=Enter an active ICD9 diagnosis code.
 ;;^UTILITY(U,$J,358.6,11,11)
 ;;=D TESTICD^IBDFN7
 ;;^UTILITY(U,$J,358.6,11,12)
 ;;=DIAGNOSIS/PROBLEM^1^13^14^2
 ;;^UTILITY(U,$J,358.6,11,13,0)
 ;;=^358.613V^10^10
 ;;^UTILITY(U,$J,358.6,11,13,1,0)
 ;;=1;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,11,13,2,0)
 ;;=2;IBD(358.98,^^1^^^^^2
 ;;^UTILITY(U,$J,358.6,11,13,3,0)
 ;;=3;IBD(358.98,^^1^^^^^9
 ;;^UTILITY(U,$J,358.6,11,13,4,0)
 ;;=1;IBE(358.99,^^0
 ;;^UTILITY(U,$J,358.6,11,13,5,0)
 ;;=4;IBD(358.98,^^1^^^^^10
 ;;^UTILITY(U,$J,358.6,11,13,6,0)
 ;;=5;IBD(358.98,^^1^^^^^11
 ;;^UTILITY(U,$J,358.6,11,13,7,0)
 ;;=6;IBD(358.98,^^1^^^^^12
 ;;^UTILITY(U,$J,358.6,11,13,8,0)
 ;;=7;IBD(358.98,^^1^^^^^5
 ;;^UTILITY(U,$J,358.6,11,13,9,0)
 ;;=8;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,11,13,10,0)
 ;;=9;IBD(358.98,^^1^^^^^6
 ;;^UTILITY(U,$J,358.6,11,14)
 ;;=S Y=$$DSPLYICD^IBDFN9(Y)
 ;;^UTILITY(U,$J,358.6,11,15,0)
 ;;=^357.615I^0^0
 ;;^UTILITY(U,$J,358.6,11,17)
 ;;=D SLCTDX^IBDFN12(.X)
 ;;^UTILITY(U,$J,358.6,11,18)
 ;;=S IBDF("OTHER")="80^I '$P(^(0),U,9)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"ICD-9 Diagnosis Code")
 ;;^UTILITY(U,$J,358.6,11,19)
 ;;=D DX^IBDFN14(X)
 ;;
 ;;$END ROU IBDEI233
