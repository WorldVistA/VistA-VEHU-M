IBDEI1UD ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32432,1,4,0)
 ;;=4^D12.0
 ;;^UTILITY(U,$J,358.3,32432,2)
 ;;=^5001963
 ;;^UTILITY(U,$J,358.3,32433,0)
 ;;=D12.6^^182^1987^11
 ;;^UTILITY(U,$J,358.3,32433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32433,1,3,0)
 ;;=3^Benign Neop of Colon,Unspec
 ;;^UTILITY(U,$J,358.3,32433,1,4,0)
 ;;=4^D12.6
 ;;^UTILITY(U,$J,358.3,32433,2)
 ;;=^5001969
 ;;^UTILITY(U,$J,358.3,32434,0)
 ;;=D12.1^^182^1987^8
 ;;^UTILITY(U,$J,358.3,32434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32434,1,3,0)
 ;;=3^Benign Neop of Appendix
 ;;^UTILITY(U,$J,358.3,32434,1,4,0)
 ;;=4^D12.1
 ;;^UTILITY(U,$J,358.3,32434,2)
 ;;=^5001964
 ;;^UTILITY(U,$J,358.3,32435,0)
 ;;=K63.5^^182^1987^67
 ;;^UTILITY(U,$J,358.3,32435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32435,1,3,0)
 ;;=3^Polyp of Colon
 ;;^UTILITY(U,$J,358.3,32435,1,4,0)
 ;;=4^K63.5
 ;;^UTILITY(U,$J,358.3,32435,2)
 ;;=^5008765
 ;;^UTILITY(U,$J,358.3,32436,0)
 ;;=D12.3^^182^1987^14
 ;;^UTILITY(U,$J,358.3,32436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32436,1,3,0)
 ;;=3^Benign Neop of Transverse Colon
 ;;^UTILITY(U,$J,358.3,32436,1,4,0)
 ;;=4^D12.3
 ;;^UTILITY(U,$J,358.3,32436,2)
 ;;=^5001966
 ;;^UTILITY(U,$J,358.3,32437,0)
 ;;=D12.2^^182^1987^9
 ;;^UTILITY(U,$J,358.3,32437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32437,1,3,0)
 ;;=3^Benign Neop of Ascending Colon
 ;;^UTILITY(U,$J,358.3,32437,1,4,0)
 ;;=4^D12.2
 ;;^UTILITY(U,$J,358.3,32437,2)
 ;;=^5001965
 ;;^UTILITY(U,$J,358.3,32438,0)
 ;;=D12.5^^182^1987^13
 ;;^UTILITY(U,$J,358.3,32438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32438,1,3,0)
 ;;=3^Benign Neop of Sigmoid Colon
 ;;^UTILITY(U,$J,358.3,32438,1,4,0)
 ;;=4^D12.5
 ;;^UTILITY(U,$J,358.3,32438,2)
 ;;=^5001968
 ;;^UTILITY(U,$J,358.3,32439,0)
 ;;=D12.4^^182^1987^12
 ;;^UTILITY(U,$J,358.3,32439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32439,1,3,0)
 ;;=3^Benign Neop of Descending Colon
 ;;^UTILITY(U,$J,358.3,32439,1,4,0)
 ;;=4^D12.4
 ;;^UTILITY(U,$J,358.3,32439,2)
 ;;=^5001967
 ;;^UTILITY(U,$J,358.3,32440,0)
 ;;=D73.2^^182^1987^16
 ;;^UTILITY(U,$J,358.3,32440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32440,1,3,0)
 ;;=3^Congestive Splenomegaly,Chronic
 ;;^UTILITY(U,$J,358.3,32440,1,4,0)
 ;;=4^D73.2
 ;;^UTILITY(U,$J,358.3,32440,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,32441,0)
 ;;=I85.00^^182^1987^43
 ;;^UTILITY(U,$J,358.3,32441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32441,1,3,0)
 ;;=3^Esophageal Varices w/o Bleeding
 ;;^UTILITY(U,$J,358.3,32441,1,4,0)
 ;;=4^I85.00
 ;;^UTILITY(U,$J,358.3,32441,2)
 ;;=^5008023
 ;;^UTILITY(U,$J,358.3,32442,0)
 ;;=K20.9^^182^1987^44
 ;;^UTILITY(U,$J,358.3,32442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32442,1,3,0)
 ;;=3^Esophagitis,Unspec
 ;;^UTILITY(U,$J,358.3,32442,1,4,0)
 ;;=4^K20.9
 ;;^UTILITY(U,$J,358.3,32442,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,32443,0)
 ;;=K21.9^^182^1987^50
 ;;^UTILITY(U,$J,358.3,32443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32443,1,3,0)
 ;;=3^Gastroesophageal Reflux Disease w/o Esophagitis
 ;;^UTILITY(U,$J,358.3,32443,1,4,0)
 ;;=4^K21.9
 ;;^UTILITY(U,$J,358.3,32443,2)
 ;;=^5008505
 ;;^UTILITY(U,$J,358.3,32444,0)
 ;;=K25.7^^182^1987^45
 ;;^UTILITY(U,$J,358.3,32444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32444,1,3,0)
 ;;=3^Gastric Ulcer w/o Hemorrhage/Perforation,Chronic
 ;;^UTILITY(U,$J,358.3,32444,1,4,0)
 ;;=4^K25.7
 ;;^UTILITY(U,$J,358.3,32444,2)
 ;;=^5008521
 ;;^UTILITY(U,$J,358.3,32445,0)
 ;;=K26.9^^182^1987^41
 ;;^UTILITY(U,$J,358.3,32445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32445,1,3,0)
 ;;=3^Duadenal Ulcer w/o Hemorrhage/Perforation,Unspec
 ;;^UTILITY(U,$J,358.3,32445,1,4,0)
 ;;=4^K26.9
 ;;
 ;;$END ROU IBDEI1UD
