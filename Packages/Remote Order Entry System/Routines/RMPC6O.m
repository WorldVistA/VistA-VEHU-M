RMPC6O ;DDC/KAW-RMPF*1.1*6 - STOCK HEARING AID BATTERIES [ 06/24/93  1:45 PM ]
 ;;1.1;RMPF;**6**;June 24, 1993
 W !!,"STOCK HEARING AID BATTERIES"
 F IX=1:1:53 S ST=$T(MODEL+IX),MD=$P(ST,";",3) D
 .S MP=$O(^RMPF(791811,"B",MD,0))
 .I 'MP W !!,MD," does not exist in file 791811.  Batteries not added." Q
 .F IZ=4:1 S NB=$P(ST,";",IZ) Q:NB=""  D
 ..S BT=$P($T(BAT+NB),";",3)
 ..S BP=$O(^RMPF(791811.3,"B",BT,0)) I 'BP W !!,BT," battery not added." Q
 ..D SET2^RMPC6 W "."
 W !!,"Addition of components and batteries complete."
END K W,V,ST,POP,MP,MD,IX,IY,IZ,B,BP,BT,BX,NB,CA,CP,CD,CS,CX,DFL,DKP,DMRG,%H,%I Q
MODEL ;;Stock Hearing Aids
 ;;A-37-I;1;7
 ;;A52S;1;7
 ;;C-10;1;7
 ;;PA76D;2;6
 ;;AVANTI DIRECTIONAL;3;7
 ;;PRIMA A23203;2;6
 ;;T86;1;3;7
 ;;EUROSTAR VFC;2;6
 ;;107-2PPAGCI;4
 ;;F228L;1;7
 ;;F228R;1;7
 ;;F229L;1;7
 ;;F229R;1;7
 ;;G117;2
 ;;M244;1
 ;;MCO31;1
 ;;MCO33V;3;7
 ;;S315;1;3
 ;;S415;1;3
 ;;E17HC;1
 ;;E25P;1;3
 ;;E28P;1;3
 ;;E38P;1;3
 ;;E40;2
 ;;E42P;2
 ;;E43;2
 ;;HP8146;4;5
 ;;M47D;2;6
 ;;P47;2;6
 ;;S1594;4
 ;;SFPPC2;1;6;7
 ;;PE805CD;1;7
 ;;DED;2;6
 ;;MCPP675;1;7
 ;;MINI PRIMO PP-I-GC;2;6
 ;;SELECTRA PP-4;1;7
 ;;266H;2;6
 ;;268S;2;6
 ;;284PPASP;1;7
 ;;340BC;1;7
 ;;340C;1;7
 ;;340CLO;1;7
 ;;350BC;1;7
 ;;363C;1;7
 ;;402BC;1;7
 ;;402C;1;7
 ;;ACT II CR;2
 ;;UE4-H;1;7
 ;;ALPPII;1;7
 ;;AN LEFT;1;7
 ;;AN RIGHT;1;7
 ;;F8T;1;7
 ;;S22;4;5
BAT ;;Batteries
 ;;ZA675
 ;;ZA13
 ;;S76
 ;;ALKAA
 ;;MAA
 ;;M13
 ;;M675
