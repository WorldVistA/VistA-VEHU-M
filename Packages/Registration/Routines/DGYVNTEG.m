DGYVNTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2950920.154933
 ;;0.0;;**64**;
 ;;7.3;2950920.154933
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
DGACT ;;408896
DGPT501 ;;5783311
DGPT535 ;;5147063
DGPT601 ;;7784192
DGPT701 ;;5801551
DGPTAEE ;;5059185
DGPTF41 ;;5046293
DGPTSCAN ;;6410838
DGPTTS1 ;;16380627
DGTSSET ;;4183804
DGYVI001 ;;3837031
DGYVI002 ;;7991318
DGYVI003 ;;3142622
DGYVI004 ;;8101429
DGYVI005 ;;5679781
DGYVI006 ;;4788822
DGYVI007 ;;5006319
DGYVI008 ;;4804736
DGYVI009 ;;3018538
DGYVI00A ;;8857821
DGYVI00B ;;9131375
DGYVI00C ;;2954605
DGYVI00D ;;5820486
DGYVI00E ;;9220069
DGYVI00F ;;8778007
DGYVI00G ;;9418816
DGYVI00H ;;7252770
DGYVI00I ;;7913894
DGYVI00J ;;7535648
DGYVI00K ;;6320571
DGYVI00L ;;6248588
DGYVI00M ;;9508763
DGYVI00N ;;8411520
DGYVI00O ;;9271854
DGYVI00P ;;5168768
DGYVI00Q ;;6427931
DGYVI00R ;;6172547
DGYVI00S ;;4225921
DGYVI00T ;;7841508
DGYVI00U ;;7253836
DGYVI00V ;;8165221
DGYVI00W ;;1547037
DGYVI00X ;;15003366
DGYVI00Y ;;18023286
DGYVI00Z ;;13972426
DGYVI010 ;;4183736
DGYVI011 ;;1842470
DGYVINI1 ;;4919041
DGYVINI2 ;;5232652
DGYVINI3 ;;16807806
DGYVINI4 ;;3357824
DGYVINI5 ;;1038551
DGYVINIS ;;2215190
DGYVINIT ;;10264655
DGYVPOST ;;11248935
DGYVPRE ;;1984963
DGYVPST1 ;;6806519
