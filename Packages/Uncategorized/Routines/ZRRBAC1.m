RORR1 ;VAX-11 DSM utilities ; Routine name selector
 ; Input = %ITEM = item name ("routine")
 K %UTILITY,%GD S %ITEM="routine"
 S U="^",%=2 U 0 W !,"List tape " D YN^DICN S:%Y="" %Y="N" S %Y=$E(%Y,1)
 I %Y="N" U 0 W !,"Loading routine names ..."
 F %J=0:1 U %IOD R %N Q:%N=""  S %UTI(%N)="" U %IOD X "ZL  ZR" I %Y="Y" U 0 W:'(%J#8) ! W ?%J#8*10 W %N
 S %QTY="3" D OPN^%IOS ; rewind tape
ASK ;prompt for name specifications and select names in %UTILITY
 U 0 W !,%ITEM R "(s) ? > ",%A G END:%A=""
 I %A="?" D HELP G ASK
 I %A="^" K %UTILITY,%UTI G END
 I %A="^L" D LIST G ASK
 I %A="^T" D TAPE G ASK
 S %X="" F %PIECE=1:1 S %X=$P(%A,",",%PIECE) Q:%X=""  D SELECT
 G ASK
 -
SELECT ;examine each item within commas
 ; Input = %X = one item
 S %MI=0 I $E(%X,1)="-" S %MI=1,%X=$E(%X,2,999)
 I %X="*" K %UTILITY Q:%MI  S %ST="",%FI="zzzzzzzz" D GET Q
 I '((%X["*")!(%X["-")) S %N=%X,%S=0 D GETONE Q
 I %X?.E1"*" S %ST=$E(%X,1,$L(%X)-1),%FI=%ST_"zzzzzzzzz" D @$S('%MI:"GET",1:"REMOVE") Q
 I %X?1E.E1"-"1E.E S %ST=$P(%X,"-",1),%FI=$P(%X,"-",2) D @$S('%MI:"GET",1:"REMOVE") Q
 D INVALID Q
 -
GET ;search tape and put names in %UTILITY
 ; input = %ST = start string
 ; 	  %FI = end string
 I %PIECE=1 W !,"searching ..."
GETPGM ; search tape
 I '((%ST="")!(%ST="%")) S %N=%ST,%S=1 D GETONE
 S %N="" F I=0:0 S %N=$O(%UTI(%N)) Q:%N=""!%N]%FI  I $E(%N,1,$L(%ST))=%ST S %UTILITY(%N)=""
 Q:%N=""  Q:%N]%FI
 -
GETONE ; get or remove a single name
 ; Input = %N = name
 ;	  %S = silent flag
 I %MI G REMONE
GONEPGM ; get one program name
 I '$D(%UTI(%N)) I '%S U 0 W ?40,"No such routine ",%N,!
 Q
 -
REMONE ;remove a single name from %UTILITY
 I %N["^" S %N=$E(%N,2,$L(%N))
 I '%S I '$D(%UTILITY(%N)) W:$X>40 ! W ?40,%N,"  not selected",!
 K %UTILITY(%N) Q
 -
REMOVE ;Remove entries from %UTILITY
 ; Input = %ST = start string
 ;	  %FI = end string
 I %ST["^" S %ST=$E(%ST,2,$L(%ST))
 I %FI["^" S %FI=$E(%FI,2,$L(%FI))
REM1 S %N=%ST
RGO Q:%N=""  Q:%N]%FI  K %UTILITY(%N) S %N=$ZS(%UTILITY(%N)) G RGO
 -
LIST U 0 I '$D(%UTILITY) W !!,"No ",%ITEM,"s selected",! Q
 W ! S %N=$ZS(%UTILITY("")) F %J=0:1 Q:%N=""  W:'(%J#8) ! W ?%J#8*10 W %N S %N=$ZS(%UTILITY(%N))
 Q
 -
TAPE W ! S %N=$ZS(%UTI("")) F %J=0:1 Q:%N=""  W:'(%J#8) ! W ?%J#8*10 W %N S %N=$ZS(%UTI(%N))
 Q
 -
END K %UTI,%X,%ST,%S,%FI,%MI,%J,%W,%F,%PIECE,%,%Z1,%Z2,%A,%N,%GD,%E
 U 0:NOCONVERT
 Q
 -
INVALID W !,?5,"Incorrect response - Enter '?' for more information" Q
 -
HELP W !!,?5,"Enter   a ",%ITEM," name"
 W !,?8,"or   NAM*       for all ",%ITEM,"s beginning with letters NAM"
 W !,?8,"or   NAM1-NAM2  to select ",%ITEM,"s beginning with letters NAM1"
 W !,?24,"and ending with NAM2"
 W !,?8,"or    *    to select all ",%ITEM,"s"
 W !,?8,"or    -    followed by any of the above to *DE-SELECT* ",%ITEM,"s"
 W !,?8,"or    a list of the above separated by commas"
 W !,?8,"or    ^L   to list selected ",%ITEM,"s"
 W !,?8,"or    ^T   to list all available ",%ITEM,"s in your directory"
 W !,?8,"or   <CR>  when done selecting"
 W !,?8,"or    ^    to terminate without selection",!!
 Q
