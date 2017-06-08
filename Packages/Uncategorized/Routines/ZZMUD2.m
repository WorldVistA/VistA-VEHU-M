ZZMUD2 ;;1/12/94 / 17:00:24
 K PSG F  R !,"ENTER DFN: ",X Q:'X  D
 .S PSG(X,0)="" F  R !,"ENTER ORDER NO.: ",Y Q:'Y  S PSG(X,Y)=""
 Q:'$D(PSG)
 S S1="" F  S S1=$O(^PS(53.5,S1)) Q:S1=""  D
 .S S2="" F  S S2=$O(^PS(53.5,S1,S2)) Q:S2=""  D
 ..S S3="" F  S S3=$O(^PS(53.5,S1,S2,S3)) Q:S3=""  D
 ...S S4="" F  S S4=$O(^PS(53.5,S1,S2,S3,S4)) Q:S4=""  D
 ....S S5="" F  S S5=$O(^PS(53.5,S1,S2,S3,S4,S5)) Q:S5=""  D
 .....D:$D(PSG(+$P(S5,U,2))) FNDORD
 Q
FNDORD ;
 S S6="" F  S S6=$O(^PS(53.5,S1,S2,S3,S4,S5,S6)) Q:S6=""  D
 .S S7="" F  S S7=$O(^PS(53.5,S1,S2,S3,S4,S5,S6,S7)) Q:S7=""  D
 ..;K:$D(PSG(+$P(S5,U,2),+$P(S7,U,2)) ^PS(53.5,S1,S2,S3,S4,S5,S6,S7)
 ..W:$D(PSG(+$P(S5,U,2),+$P(S7,U,2))) "DFN: ",$P(S5,U,2),!,"ON: ",$P(S7,U,2),!
 Q
