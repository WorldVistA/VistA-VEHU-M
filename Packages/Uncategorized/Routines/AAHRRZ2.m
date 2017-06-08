%AAHRRZ2 ;402,DJB,6/21/92**Set Screen Variables
 ;;GEM III;;
 ;;David Bolduc - Augusta ME
 D ECHO,EXIST
 I $G(FLAGEDIT)="EDIT" D ZSAVE,XY,SCRNVAR
 Q
ECHO ;Set up Echo On and Echo Off
 I $D(^%ZOSF("EON")),$D(^%ZOSF("EOFF")) S GEMSYS("EON")=^%ZOSF("EON"),GEMSYS("EOFF")=^%ZOSF("EOFF") D  Q
 . Q:GEMSYS'=9  Q:'$ZDEV("ECHOA")
 . S GEMSYS("EON")="U $I:ECHOA=1",GEMSYS("EOFF")="U $I:ECHOA=0"
 . Q
 I GEMSYS=8 S GEMSYS("EON")="U $I:(:::::1)",GEMSYS("EOFF")="U $I:(::::1)" Q  ;MSM
 I GEMSYS=9,$ZDEV("ECHOA") S GEMSYS("EON")="U $I:ECHOA=1",GEMSYS("EOFF")="U $I:ECHOA=0" ;DTM
 I GEMSYS=16 S GEMSYS("EON")="U $I:ECHO",GEMSYS("EOFF")="U $I:NOECHO" Q  ;VAX DSM
 Q:GEMSYS'=101  ;M/UX Mumps for Unix
 S GEMSYS("EON")="U $I:("""":$S($D(^XUTL(""ZIS"",""TYPE-AHEAD"",$I)):^($I),1:"""")_$S($D(^XUTL(""ZIS"",""TRMON"",$I)):^($I),1:""""):$C(13,27)) S ^XUTL(""ZIS"",""EON"",$I)="""""
 S GEMSYS("EOFF")="U $I:("""":$S($D(^XUTL(""ZIS"",""TYPE-AHEAD"",$I)):^($I),1:"""")_""S""_$S($D(^XUTL(""ZIS"",""TRMON"",$I)):^($I),1:""""):$C(13,27)) S ^XUTL(""ZIS"",""EON"",$I)=""S"""
 Q
EXIST ;Set up GEMSYS("EXIST") to test existence of a routine.
 I $D(^DD("OS",GEMSYS,18)) S GEMSYS("EXIST")=^(18) Q:GEMSYS("EXIST")]""
 I GEMSYS=8 S GEMSYS("EXIST")="I $D(^ (X))" Q
 I GEMSYS=9 S GEMSYS("EXIST")="I $ZRSTATUS(X)]""""" Q
 I GEMSYS=16 S GEMSYS("EXIST")="I $D(^ (X))!$D(^!(X))" Q
 I GEMSYS=101 S GEMSYS("EXIST")="I $D(^ROUTINE(X))"
 Q
ZSAVE ;Set up GEMSYS("ZS") to zsave a routine.
 Q:$G(FLAGEDIT)'="EDIT"
 I $D(^DD("OS",GEMSYS,"ZS")) S GEMSYS("ZS")=^("ZS") Q:GEMSYS("ZS")]""
 I $D(^DD("OS")),'$D(^DD("OS",GEMSYS,"ZS")) S FLAGQ=1 W *7,!!?5,"Your Mumps system has no way to ZSAVE a routine. I'm aborting.",!! Q
 ;
 I GEMSYS=8!(GEMSYS=16) S GEMSYS("ZS")="N %Y ZR  X ""F %Y=0:0 S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y'>0  ZI ^(%Y)"" ZS @X" Q
 I GEMSYS=9 S GEMSYS("ZS")="N %X,%Y S %X="""" X ""F %Y=0:0 S %Y=$O(^UTILITY($J,0,%Y)) Q:$Y'>0  S %X=%X_$C(10)_^(%Y)"" ZS @X:$E(%X,2,999999)" Q
 I GEMSYS=101 S GEMSYS("ZS")="N %Y ZR  ZS @X X ""F %Y=0:0 S %Y=$O(^UTILITY($J,0,%Y)) Q:%Y'>0  ZI ^(%Y)"" ZS @X"
 Q
XY ;Resetting $X & $Y
 I $D(^%ZOSF("XY")) S GEMSYS("XY")=^%ZOSF("XY") Q:GEMSYS("XY")]""
 I GEMSYS=8 S GEMSYS("XY")="U $I:(::::::DY*256+DX)" Q
 I GEMSYS=9 S GEMSYS("XY")="W /C(DX,DY)" Q
 I GEMSYS=16 S GEMSYS("XY")="U $I:(NOCURSOR,X=DX,Y=DY,CURSOR)" Q
 I GEMSYS=101 S GEMSYS("XY")="S $X=DX,$Y=DY"
 Q
SCRNVAR ;Screen Variables
 ;Reverse Video (See INIT^%AAHRRZ)
 ;S GEMSYS("RON")="$C(27)_""[7m""",GEMSYS("ROFF")="$C(27)_""[0m"""
 ;Graphics
 S GEMSYS("GON")="$C(27)_""(0""",GEMSYS("GOFF")="$C(27)_""(B"""
 ;Screen erase
 S GEMSYS("BLANK")="$C(27)_""[J""" ;Blank from cursor to end-of-screen
 S GEMSYS("BLANK1")="$C(27)_""[1J""" ;Blank from top-of-screen to cursor
 S GEMSYS("BLANK2")="$C(27)_""[K""" ;Blank from cursor to end-of-line
 ;Position curser
 S GEMSYS("CRSR")="$C(27)_""[""_(DY+1)_"";""_(DX+1)_""H"""
 ;Schroll region
 S GEMSYS("SCHROLLON")="$C(27)_""[22;24r"""
 S GEMSYS("SCHROLLOFF")="$C(27)_""[1;24r"""
 ;Character insert
 S GEMSYS("CION")="$C(27)_""[4h""",GEMSYS("CIOFF")="$C(27)_""[4l"""
 ;Index
 S GEMSYS("INDEX")="$C(27)_""D""",GEMSYS("REVINDEX")="$C(27)_""E"""
 ;Right margin
 S (GEMSYS("RM0"),GEMSYS("RM80"))=""
 I GEMSYS=8 S GEMSYS("RM0")="U $I:(0)",GEMSYS("RM80")="U $I:(80)" ;Micronetics
 Q
