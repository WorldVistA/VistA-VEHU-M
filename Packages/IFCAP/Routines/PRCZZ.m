PRCZZ ;look at 424 to 424.1 relationship
 ;;
 N I,J
 S I=0
 F  S I=$O(^PRC(424.1,I)) Q:'I  S J=$G(^(I,0)) I +J,$P(J,"^",4)>2950101 D  W "."
 . I $P($P(J,"^"),"-",1,3)'=$P($G(^PRC(424,+$P(J,"^",2),0)),"^") D 
 .. W !,I,?10,$P(J,"^",1,2)
 ..S ^TMP($J,"FEE",I)=""
