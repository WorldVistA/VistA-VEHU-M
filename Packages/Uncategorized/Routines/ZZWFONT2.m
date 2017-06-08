ZZWFONT2        ;ISCSF/RWF - UPDATE THE DEVICE FILE WITH SERVER:PORT ;04/21/97  12:49
 ;;
 D HOME^%ZIS
 W !,"FIRST see that you have a HFS device setup in the VA Device file that has"
 W !,"ASK PARAMETERS: YES, ASK HOST FILE: YES, OPEN PARAMETERS: ""RS""."
 W !!,"Open the ""VASYS.DEF"" to provide device data to change the $I"
 W !,"to be the LAT server:port"
 D ^%ZIS Q:POP
 W !,"Looking for the right section of the file."
 S $ZT="EXIT^ZZWFONT2"
 F  U IO R X:0 Q:X="[Devices]"
 U IO(0) W !,X,!,"Found it."
 F IX=0:1:1024 U IO R LINE:0 Q:$E(LINE)="["  U IO(0) W !,LINE D LINE
EXIT D ^%ZISC
 Q
 ;
LINE ;PARSE LINE
 S NUM=+$P(LINE,"=Device_",2),DOLIO=$P(LINE,"~",2),ALIAS=$P(LINE,"~",9)
 ;U IO(0) W !,?5,NUM,"  ",DOLIO,"  ",ALIAS
 Q:NUM'>0
 S DA=0 F  S DA=$O(^%ZIS(1,"C",NUM,DA)) Q:DA'>0  D DIE
 Q
DIE ;
 K ZFD,ZIEN,ZMSG
 U IO(0) W !,"Device: ",$p(^%ZIS(1,DA,0),U)," to ",DOLIO," with alias ",ALIAS
 S ZFD="",ZFD(3.5,DA_",",1)=DOLIO,ZFD(3.501,"?+1,"_DA_",",.01)=ALIAS
 D UPDATE^DIE("","ZFD","ZIEN","ZMSG")
 I $D(ZMSG)>2 S ZZ="ZMSG" F  S ZZ=$Q(@ZZ) Q:ZZ=""  W !,ZZ," = ",@ZZ
 Q
