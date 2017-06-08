SOWK46B ;B'HAM ISC/BJW - Routine to edit entries in Social Work Direct Services File (#655.202)   [ 05/08/97  3:32 PM ]
 ;;3.0; Social Work ;**46**;27 Apr 93
 K SOW S SOW="2960101" F  S SOW=$O(^SOWK(650,"O",SOW)) Q:'SOW  W !,SOW,"" S SOW(1)=0 F  S SOW(1)=$O(^SOWK(650,"O",SOW,SOW(1))) Q:'SOW(1)  W !,?5,SOW(1) D
 . I $D(^SOWK(650,SOW(1),5,0)) S SOW("I")=0 F  S SOW("I")=$O(^SOWK(650,SOW(1),5,SOW("I"))) Q:'SOW("I")  S SOW("DS")=$P(^SOWK(650,SOW(1),5,SOW("I"),0),U) D
 .. I SOW("DS")=53!(SOW("DS")=54) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///11" D ^DIE
 .. I SOW("DS")=50!(SOW("DS")=51)!(SOW("DS")=52) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///10" D ^DIE
 .. I SOW("DS")=55!(SOW("DS")=56)!(SOW("DS")=57) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///26" D ^DIE
 .. I SOW("DS")=58!(SOW("DS")=39) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///23" D ^DIE
 .. I SOW("DS")=35 S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///12" D ^DIE
 .. I SOW("DS")=46!(SOW("DS")=47)!(SOW("DS")=48) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///25" D ^DIE
 .. I SOW("DS")=22!(SOW("DS")=23)!(SOW("DS")=24) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///19" D ^DIE
 .. I SOW("DS")=36!(SOW("DS")=37)!(SOW("DS")=38) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///22" D ^DIE
 .. I SOW("DS")=43!(SOW("DS")=44)!(SOW("DS")=45) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///8" D ^DIE
 .. I SOW("DS")=60!(SOW("DS")=61) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///15" D ^DIE
 .. I SOW("DS")=28!(SOW("DS")=29)!(SOW("DS")=30) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///21" D ^DIE
 .. I SOW("DS")=25!(SOW("DS")=26)!(SOW("DS")=27) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///20" D ^DIE
 .. I SOW("DS")=19!(SOW("DS")=20)!(SOW("DS")=21) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///3" D ^DIE
 .. I SOW("DS")=40 S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///24" D ^DIE
 .. I SOW("DS")=62!(SOW("DS")=63) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///16" D ^DIE
 .. I SOW("DS")=49!(SOW("DS")=64) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///9" D ^DIE
 .. I SOW("DS")=31!(SOW("DS")=32)!(SOW("DS")=33)!(SOW("DS")=34) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///4" D ^DIE
 .. I SOW("DS")=41!(SOW("DS")=42) S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///6" D ^DIE
 .. I SOW("DS")=59 S DA(1)=SOW(1),DIE="^SOWK(650,"_DA(1)_",5,",DA=SOW("I"),DR=".01///14" D ^DIE
 Q
