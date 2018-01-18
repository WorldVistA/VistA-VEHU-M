A1CHISM1 ;ALB/ - INPATIENT WORKLOAD SUMMARY, TOTALS ; 3/1/89 1500
 ;;V 1.3
TOT1 F I=30:10:110 W ?I,"------"
 W !,?1,"SUBTOTAL",?30,^UTILITY("A1CH","T",K,"C",1),?40,^(2),?50,^(3),?60,^(4),?70,^(5),?80,^(6),?90,^(7)
 W ?100,^UTILITY("A1CH","T",K,"R")
 W:^UTILITY("A1CH","T",K,"R")>0 ?110,"("_$J(^UTILITY("A1CH","T",K,"R")/^UTILITY("A1CH","T",K,"R")*100,2,2)_")"
 Q:^UTILITY("A1CH","T",K,"R")=0
 W !,?1,"SUBTOTAL %",?30,$J(^UTILITY("A1CH","T",K,"C",1)/^UTILITY("A1CH","T",K,"R")*100,2,2),?40,$J(^UTILITY("A1CH","T",K,"C",2)/^UTILITY("A1CH","T",K,"R")*100,2,2)
 W ?50,$J(^UTILITY("A1CH","T",K,"C",3)/^UTILITY("A1CH","T",K,"R")*100,2,2),?60,$J(^UTILITY("A1CH","T",K,"C",4)/^UTILITY("A1CH","T",K,"R")*100,2,2)
 W ?70,$J(^UTILITY("A1CH","T",K,"C",5)/^UTILITY("A1CH","T",K,"R")*100,2,2),?80,$J(^UTILITY("A1CH","T",K,"C",6)/^UTILITY("A1CH","T",K,"R")*100,2,2)
 W ?90,$J(^UTILITY("A1CH","T",K,"C",7)/^UTILITY("A1CH","T",K,"R")*100,2,2)
 W ?100,$J(^UTILITY("A1CH","T",K,"R")/^UTILITY("A1CH","T",K,"R")*100,2,2)
 Q
 ;
TOT W ! F I=30:10:100 W ?I,"======"
 W !,?1,"TOTAL",?30,^UTILITY("A1CH","T","C",1),?40,^(2),?50,^(3),?60,^(4),?70,^(5),?80,^(6),?90,^(7)
 W ?100,^UTILITY("A1CH","T","C")
 W !,?1,"TOTAL %",?30,$J(^UTILITY("A1CH","T","C",1)/^UTILITY("A1CH","T","C")*100,2,2),?40,$J(^UTILITY("A1CH","T","C",2)/^UTILITY("A1CH","T","C")*100,2,2)
 W ?50,$J(^UTILITY("A1CH","T","C",3)/^UTILITY("A1CH","T","C")*100,2,2),?60,$J(^UTILITY("A1CH","T","C",4)/^UTILITY("A1CH","T","C")*100,2,2)
 W ?70,$J(^UTILITY("A1CH","T","C",5)/^UTILITY("A1CH","T","C")*100,2,2),?80,$J(^UTILITY("A1CH","T","C",6)/^UTILITY("A1CH","T","C")*100,2,2)
 W ?90,$J(^UTILITY("A1CH","T","C",7)/^UTILITY("A1CH","T","C")*100,2,2)
 W ?100,$J(^UTILITY("A1CH","T","C")/^UTILITY("A1CH","T","C")*100,2,2),!
 Q
 ;
