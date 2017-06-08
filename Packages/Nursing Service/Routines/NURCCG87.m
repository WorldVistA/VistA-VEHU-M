NURCCG87 ;HISC/RM-DATA ROUTINE FOR DATA TRANSFER UTILITY ;12/12/91
 ;;3.0;Nursing Clinical;;Jan 24, 1996
 ;;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO I  S @X=Y
Q Q
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,2,0)
 ;;=4368^alteration in preload/afterload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,3,0)
 ;;=4370^fluid volume deficit/excess^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,4,0)
 ;;=4371^activity intolerance^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,5,0)
 ;;=134^imbalance between oxygen supply and demand^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,1,6,0)
 ;;=1050^myocardial ischemia^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4361,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4362,0)
 ;;=verbalizes pain level, [specify #] on a scale of 1-10 q[]hrs^3^NURSC^9^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4362,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4362,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4363,0)
 ;;=Decreased Cardiac Output, Electrical/Mechanical^2^NURSC^2^1^1^^T^0
 ;;^UTILITY("^GMRD(124.2,",$J,4363,1,0)
 ;;=^124.21PI^4^3
 ;;^UTILITY("^GMRD(124.2,",$J,4363,1,2,0)
 ;;=4381^Etiology/Related and/or Risk Factors^2^NURSC^203
 ;;^UTILITY("^GMRD(124.2,",$J,4363,1,3,0)
 ;;=4427^Goals/Expected Outcomes^2^NURSC^202
 ;;^UTILITY("^GMRD(124.2,",$J,4363,1,4,0)
 ;;=4500^Nursing Intervention/Orders^2^NURSC^208
 ;;^UTILITY("^GMRD(124.2,",$J,4363,7)
 ;;=D EN3^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4363,9)
 ;;=D EN2^NURCCPU3
 ;;^UTILITY("^GMRD(124.2,",$J,4363,10)
 ;;=D EN3^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4366,0)
 ;;=disturbance in impulse formation/conduction^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4368,0)
 ;;=alteration in preload/afterload^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4370,0)
 ;;=fluid volume deficit/excess^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4371,0)
 ;;=activity intolerance^3^NURSC^^1^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4373,0)
 ;;=Goals/Expected Outcomes^2^NURSC^5^199^1^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,0)
 ;;=^124.21PI^7^7
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,1,0)
 ;;=4376^maintain stable hemodynamics^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,2,0)
 ;;=3205^maintain clear bilateral non-labored respirations^3^NURSC^5
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,3,0)
 ;;=1458^myocardial oxygen demand is minimized^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,4,0)
 ;;=4392^maintain fluid/electrolytes WNL for patient^2^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,5,0)
 ;;=4397^maintain ABG's/pulse oximeter WNL for pt;oxygen sat [spec]%^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,6,0)
 ;;=4400^[Extra Goal]^3^NURSC^118
 ;;^UTILITY("^GMRD(124.2,",$J,4373,1,7,0)
 ;;=4562^absence of S/S of fluid overload^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4373,7)
 ;;=D EN4^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4374,0)
 ;;=[Extra Goal]^3^NURSC^9^49^^^T
 ;;^UTILITY("^GMRD(124.2,",$J,4374,9)
 ;;=D EN5^NURCCPU0
 ;;^UTILITY("^GMRD(124.2,",$J,4374,10)
 ;;=D EN2^NURCCPU1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,0)
 ;;=maintain stable hemodynamics^2^NURSC^9^1^1^^T^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,0)
 ;;=^124.21PI^9^8
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,1,0)
 ;;=4380^Cardiac Index (CI) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,2,0)
 ;;=4382^Cardiac Output (CO) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,3,0)
 ;;=4383^SVR (systemic vascular resistance) [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,4,0)
 ;;=4384^PAWP pulmonary artery wedge pressure [specify range]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,6,0)
 ;;=4386^BP [specify systolic/diastolic HIGH] to [specify LOW]^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,7,0)
 ;;=4387^pulse [specify range] ^3^NURSC^1
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,8,0)
 ;;=4388^respirations [specify range]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4376,1,9,0)
 ;;=4436^temperature per[route] q[ frequency ]^3^NURSC^4
 ;;^UTILITY("^GMRD(124.2,",$J,4376,7)
 ;;=D EN4^NURCCPU1
