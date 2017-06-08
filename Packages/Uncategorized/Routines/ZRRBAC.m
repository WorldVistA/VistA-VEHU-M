RORR ;VAX-11 DSM Utilities ; Routine Restore
 U 0 W !!,"Routine Restore",!
GET S %QTY=1 K %DEF,%IOD,%MOD,%DTY,%ZIOD
 D ^%IOS I '$D(%IOD) G END
RESTORE ; restore from file %IOD, %ZIOD
 U 0 W !!,"Restoring routines from  ",%ZIOD,!
 U %IOD R %DATIM,%HEAD
 S %CT=0
 U 0 I %DATIM'="" W !,"Saved on ",%DATIM,!
 I %HEAD'="" W !,"Header: ",%HEAD,!
ASK U 0 R !,"Restore all (A) or selected (S) ? <A> ",%X I %X="^" G DONE
 I %X="?" W !,?5,"Enter 'A' OR 'S'",! G ASK
 S %ALL=0 I %X=""!(%X="A") S %ALL=1 W ! G A1
 I %X="S" D:$E(%DTY,1,2)="MS" ^RORR1
 I $E(%DTY,1,1)'="MS",%X="S" D ^%RSEL
 G:'$D(%UTILITY) DONE W !,"Change any selected routine names " S U="^",%=2 D YN^RODICN S:%Y="" %Y="N" S %Y=$E(%Y,1) W ! G A1
 D IV G ASK
 Q
A1 U 0 U %IOD
GO R %NAM I %NAM="" G DONE
 U 0 I %ALL W:'(%CT#8) ! W ?(%CT#8*10),%NAM G SAV
RES I $D(%UTILITY(%NAM)) G:%Y="Y" CHK G SAV
 E  S %X="-" U %IOD X "ZL  ZR" U 0 W !,%NAM,"  skipped" G A1
CHK W !,"Restore as ? <",%NAM R "> ",%X G DONE:%X="^",HELP:%X="?"
 I %X="" G SAV
 I '(%X?1"%"1AN.AN!(%X?1A.AN)) D IV G RES
 I $L(%X)>8 D IV G RES
 S %NAM=%X 
SAV K %UTILITY(%NAM) X "U %IOD ZL  ZS @%NAM ZR" I '%ALL U 0 W:%Y="Y" "  restored" I %Y="N" W !,%NAM,"  restored"
 S %CT=%CT+1 G A1
DONE C %IOD U 0 I $D(%UTILITY),%X'="^" S %NAM="" F I=0:0 S %NAM=$O(%UTILITY(%NAM)) Q:%NAM=""  W !,%NAM,"  not found",!
 G GET
END K %DATIM,%CT,%HEAD,%IOD,%DTY,%ALL,%X,%NAM Q
IV W !,?5,"Incorrect response - Enter '?' for more information" Q
HELP W !!,?5,"Enter   <CR>  to restore the routine with the same name"
 W !,?8,"or    -    to skip restoring this routine"
 W !,?8,"or    ^    to abort",!,?8,"or    a new name for restoring this routine",!! G RES
ERR ZCLEAR
 G:$ZE["ENDOFILE" DONE B  U 0 W !,$P($ZE,",",3),!
 S %ZA=$P($ZE,",",5),%ZB=$P($ZE,",",7)
 I %ZA'="" W %ZA,! I %ZB'="" W %ZB,!
 K %ZA,%ZB S $ZE="" G DONE
