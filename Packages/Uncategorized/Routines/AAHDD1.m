%AAHDD1 ;402,DJB,11/2/91,EDD**Electronic Data Dictionary cont.
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
HD ;
 W:'FLAGNFF @GEMIOF
 W !?65,"David Bolduc",!?65,"Togus, ME"
 W !!!!?35,"E D D",!?34,"~~~~~~~",!?35,"~~~~~",!?36,"~~~",!?37,"~",!?25,"Electronic Data Dictionary",!?34,"GEM III",!
 W !?22,"*",?25,"Everything you ever wanted",?53,"*",!?22,"*",?25,"to know about a file but",?53,"*",!?22,"*",?25,"were afraid to ask.",?53,"*"
 W !!
 Q
HD1 ;Heading for Top of Main Menu
 W:'FLAGNFF @GEMIOF W !?M1,"A.) FILE NAME:------------- ",ZNAM
 W !?48,"F.) FILE ACCESS:"
 W !?M1,"B.) FILE NUMBER:----------- ",ZNUM
 W ?53,"DD______ ",$S($D(^DIC(ZNUM,0,"DD")):^("DD"),1:"")
 W !?53,"Read____ ",$S($D(^DIC(ZNUM,0,"RD")):^("RD"),1:"")
 W !?M1,"C.) NUM OF FLDS:----------- ",^UTILITY($J,"TOT")
 W ?53,"Write___ ",$S($D(^DIC(ZNUM,0,"WR")):^("WR"),1:"")
 W !?53,"Delete__ ",$S($D(^DIC(ZNUM,0,"DEL")):^("DEL"),1:"")
 W !?M1,"D.) DATA GLOBAL:----------- ",ZGL
 W ?53,"Laygo___ ",$S($D(^DIC(ZNUM,0,"LAYGO")):^("LAYGO"),1:"")
 W !!?M1,"E.) TOTAL GLOBAL ENTRIES:-- "
 S ZZGL=ZGL_"0)",ZZGL=@ZZGL W $S($P(ZZGL,U,4)]"":$P(ZZGL,U,4),1:"Blank")
 I PRINTING="YES" W ?48,"G.) PRINTING STATUS:-- ",$S(FLAGP:"On",1:"Off")
 W !,$E(GEMLINE1,1,GEMIOM)
 Q
