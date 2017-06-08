XTECROU ;FO-OAK/JLI - routine processing for eclipse ;06/11/2008
 ;;7.3;TOOLKIT;**101**;Apr 25, 1995;Build 10
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
DIR(XTECGLOB,XTECLINE,XTECFROM,XTECTO) ; This routine will provide a list of routines
 ; ARRAY = is the return array where the list will be passed
 ; XTECFROM(Optional) = is a starting point
 ; XTECTO (Optional) = is an ending point
 N CNT,ROU,FST,FLG
 ; remove * if user entered name*
 S:XTECFROM["*" XTECFROM=$P(XTECFROM,"*") S:XTECTO["*" XTECTO=$P(XTECTO,"*")
 S @XTECGLOB@(0)="0^NO ROUTINES FOUND IN SEARCH "_$S(XTECTO="":"FOR",1:"BETWEEN")_" "_XTECFROM_$S(XTECTO'="":"AND "_XTECTO,1:"")
 S XTECLINE=$G(XTECLINE,1000)
 S FLG=$$SETNAMES^XTECGLO(.XTECFROM,.XTECTO) I FLG<0 S @XTECGLOB@(0)=FLG Q
 S ROU=XTECFROM,FLG=0,CNT=0,FST=""
 ;F  S ROU=$O(^$ROUTINE(ROU)) Q:ROU=""  D  Q:FLG
 F  S ROU=$O(^DIC(9.8,"B",ROU)) Q:ROU=""  D  Q:FLG
 . I ROU]XTECTO S FLG=1 Q
 . I CNT=XTECLINE S FLG=1 Q
 . I FST="" S FST=ROU
 . S CNT=CNT+1,@XTECGLOB@(CNT)=ROU
 . Q
 I CNT S @XTECGLOB@(0)=CNT_"^"_FST_"^"_@XTECGLOB@(CNT)
 Q
 ;
INFO(XTECGLOB,ROU,OPTS) ; Return the routine information
 N SIZ1,SIZ2,TMP,X,XTECGLO1,TMP,Y
 S X=$$SETNAMES^XTECGLO(ROU,"") I X<0 S @XTECGLOB@(0)=X Q
 I '$$ROU(ROU) S @XTECGLOB@(0)="-1^Routine Not found" Q
 S @XTECGLOB@(0)="1^"_ROU
 S XTECGLO1=$NA(^TMP("XTECLIPSE1",$J)) K @XTECGLO1
 S X=ROU,TMP="",SIZ1=$S
 D LOAD(XTECGLO1,X)
 M TMP=@XTECGLO1
 K @XTECGLO1
 S SIZ2=$S,@XTECGLOB@(1)=(SIZ1-SIZ2)
 S X=ROU X ^%ZOSF("RSUM") S @XTECGLOB@(2)=Y
 D XINDEX(ROU,XTECGLO1)
 M @XTECGLOB=@XTECGLO1
 K @XTECGLO1
 Q
 ;
LOAD(XTECGLOB,ROU) ; load the routine
 ; ARRAY = is the return array where the routine will be passed
 ;   in the structure:
 ; ROU = is the routine that is requested
 N CNT,LN,TMP,I,DIF,X,XCNP
 S I=$$SETNAMES^XTECGLO(ROU,"") I I<0 S @XTECGLOB@(0)="Invalid Routine Name" Q
 I '$$ROU(ROU) S @XTECGLOB@(0)="-1^Routine Not found" Q
 S DIF="TMP(",XCNP=0,X=ROU
 X ^%ZOSF("LOAD")
 I '$D(TMP(1,0)) S @XTECGLOB@(0)="-1^Error Processing load request" Q
 S I=0
 F  S I=$O(TMP(I)) Q:I<1  D
 . Q:TMP(I,0)=""  N J F J=1:1:$L(TMP(I,0)) I $E(TMP(I,0),J)=" " S TMP(I,0)=$E(TMP(I,0),1,J-1)_$C(9)_$E(TMP(I,0),J+1,$L(TMP(I,0))) Q
 . S @XTECGLOB@(I)=TMP(I,0)
 S @XTECGLOB@(0)="1^"_ROU
 Q
 ;
ROU(X) ;encapsule the call to ^%ZOSF("TEST")
 X ^%ZOSF("TEST")
 Q $T
 ;
SAVE(XTECGLOB,ARRAY,ROU,OPTS) ; Save a routine from the array to the name ROU
 ; ARRAY = The array of routine to save
 ; ROU = the Namespace to save it to
 ; OPTS = updateroutinefile^unittestname^updatefirstline
 ;       update routine file if 1
 ;       unittestname is routine name
 ;       updatefirstline if 1 (or null for original client code)
 N TMP,I,DIE,DIF,X,XCN,UNITROU
 K ^TMP($J)
 I ROU="" S @XTECGLOB@(0)="-1^No routine name"
 S I=$$SETNAMES^XTECGLO(ROU,"") I I<0 S @XTECGLOB@(0)=I Q
 I '$D(ARRAY(1)) S @XTECGLOB@(0)="-1^No routine to process" Q
 S I=0
 F  S I=$O(ARRAY(I)) Q:I<1  D
 . I ARRAY(I)="" Q
 . I ARRAY(I)[$C(9) S ARRAY(I)=$P(ARRAY(I),$C(9))_" "_$P(ARRAY(I),$C(9),2,99)
 . F  Q:$E(ARRAY(I),$L(ARRAY(I)))'=" "  S ARRAY(I)=$E(ARRAY(I),1,$L(ARRAY(I))-1)
 . I I=1,($P($G(OPTS),U,3)="")!(+$P($G(OPTS),U,3)) S ARRAY(I)=$$FIRSTLIN(ARRAY(I),ROU)
 . S ^TMP($J,I,0)=ARRAY(I)
 . Q
 S (DIF,DIE)="^TMP($J,",XCN=0,X=ROU N ROUNAME S ROUNAME=ROU
 X ^%ZOSF("SAVE")
 K ARRAY
 ;
 I $D(^%Z("FILE")),+$G(OPTS),^%ZOSF("OS")'["GT.M" D
 . N XX,XX1,%X,%POP
 . S XX="S %NX=1 X ^%Z(""F11"") I %A>0 X ^%ZOSF(""UCI"") S ^DIC(9.8,%A,23,%C,0)=%DT_""^""_$I_""^""_Y_""^""_$S($D(DUZ)#2:DUZ,1:"""")"
 . X "S %X=ROUNAME ZL @ROUNAME X ^%Z(""F2""),^%Z(""F3""),XX"
 . Q
 ;
 S UNITROU=$P($G(OPTS),U,2) I UNITROU["does not exist" S UNITROU=""
 D CHKROU(XTECGLOB,ROUNAME,UNITROU)
 K ^TMP($J)
 Q
 ;
CHKROU(XTECGLOB,XTECNAME,XTECUNIT) ;
 N XTECRSLT,I,J
 S XTECRSLT=$NA(^TMP("ROUTMP",$J))
 D XINDEX(XTECNAME,XTECRSLT)
 M @XTECGLOB=@XTECRSLT
 S @XTECGLOB@(0)="1^"_XTECNAME
 K @XTECRSLT
 D CHEKTAGS^XTMRPAR1(XTECNAME,XTECRSLT)
 D ADDLINE(XTECGLOB,XTECRSLT,"Variables which are neither NEWed or arguments")
 I $G(XTECUNIT)'="" D
 . D UNITTEST(XTECUNIT,XTECRSLT)
 . D ADDLINE(XTECGLOB,XTECRSLT,"Results of Unit Tests")
 . Q
 Q
 ;
ADDLINE(XTECGLOB,XTECRSLT,HEADER) ;
 N I,J
 S J=$$LASTNODE(XTECGLOB)
 S J=J+1,@XTECGLOB@(J)="",J=J+1,@XTECGLOB@(J)="",J=J+1,@XTECGLOB@(J)=HEADER,J=J+1,@XTECGLOB@(J)=""
 S I="" F  S I=$O(@XTECRSLT@(I)) Q:I=""  S J=J+1,@XTECGLOB@(J)=@XTECRSLT@(I)
 K @XTECRSLT
 Q
 ;
LASTNODE(GLOB) ; Extrinsic Function - returns value of current last node in global reference GLOB
 N I,J
 S I="",J="" F  S I=$O(@GLOB@(I)) Q:I=""  S J=I
 Q J
 ;
FIRSTLIN(INPUT,ROU) ;
 ; update date/time on first line and if name on first line does not start with %,
 ; make sure name is on first line
 N CURTIME S CURTIME=$$NOW^XLFDT(),CURTIME=$E(CURTIME,4,5)_"/"_$E(CURTIME,6,7)_"/"_$E(CURTIME,2,3)_"  "_$E(CURTIME,9,10)_":"_$E(CURTIME,11,12)
 I INPUT[$C(9) D  Q INPUT ; handle any coming with tabs as linestart
 . I $P(INPUT,$C(9))'=ROU,$E(INPUT)'="%" S INPUT=ROU_$C(9)_$P(INPUT,$C(9),2,250)
 . S:$L(INPUT," ;")=1 INPUT=INPUT_" ;" S $P(INPUT," ;",2,3)=CURTIME
 . Q
 ; handle those with space as linestart - should be most of them
 I $P(INPUT," ")'=ROU,$E(INPUT)'="%" S INPUT=ROU_" "_$P(INPUT," ",2,250)
 S:$L(INPUT," ;")=2 INPUT=INPUT_" ;" S $P(INPUT," ;",3,4)=CURTIME
 Q INPUT
 ;
UNITTEST(XTECUNIT,XTECRSLT) ;
 N XTECDOC,XTECDEV,XTECIO,I,XTECDEVN,XTMUIO
 S XTECDOC="XTEC"_$J_"A.DAT"
 D SETDOC(XTECDOC)
 S XTECIO=IO
 S XTMUIO=IO,XTECDEV="",XTECDEVN="" F  S XTECDEVN=$O(^TMP("XUDEVICE",$J,XTECDEVN)) Q:XTECDEVN=""  I $G(^(XTECDEVN,"IO"))=IO S XTECDEV=^(0) Q
 I XTECDEV="" S XTECDEV="XTMUNIT DEVICE" D SAVDEV^%ZISUTL(XTECDEV)
 M ^TMP("UNITTEST1",$J,"DEV1")=^TMP("XUDEVICE",$J)
 D EN^XTMUNIT(XTECUNIT)
 K ^TMP("UNITTEST1",$J)
 M ^TMP("UNITTEST1",$J,"IO")=IO
 M ^TMP("UNITTEST1",$J,"DEV2")=^TMP("XUDEVICE",$J)
 I IO'=XTECIO D USE^%ZISUTL(XTECDEV)
 D GETDOC(XTECDOC,XTECRSLT)
 F I=0:0 S I=$O(@XTECRSLT@(I)) Q:I'>0  I $E(^(I),1,4)="|TOP" K ^(I) Q
 Q
 ;
XINDEX(XTECNAME,XTECGLOB) ;
 N XTECDOC,IOP,INNDDA,INP,NRO,NDA,X,I,INDDA,J
 S XTECDOC="XTEC"_$J_".DAT"
 K ^UTILITY($J) S ^UTILITY($J,XTECNAME)=""
 S INDDA=-1
 F I=1:1:9 S INP(I)=0
 S INP(10)=9.4,INP(11)="",INP(12)="",INP("MAX")=20000,INP("CMAX")=15000
 S NRO=1
 D SETDOC(XTECDOC) ; setup a spool file using XTECDOC
 D ALIVE^XINDEX
 D GETDOC(XTECDOC,XTECGLOB)
 ; trim it down to just the error info
 F I=0:0 S I=$O(@XTECGLOB@(I)) Q:I'>0  Q:$E(^(I),1,4)="Comp"  K ^(I)
 I I>0 F  S I=$O(@XTECGLOB@(I)) Q:I'>0  I $E(^(I),1,7)="--- END" K ^(I) Q
 I I>0 F  S I=$O(@XTECGLOB@(I)) Q:I'>0  K ^(I)
 Q
 ;
SETDOC(XTECDOC) ;
 N IOP,%ZIS
 S IOP="HFS",%ZIS("HFSNAME")=$$CHKNM^%ZISF(XTECDOC),%ZIS("HFSMODE")="W" D ^%ZIS ;_$"SPOOL;P-OTH80;"_XTECDOC D ^%ZIS
 U IO S $Y=0
 Q
 ;
GETDOC(XTECDOC,XTECGLOB) ;
 N X,XNAME
 U IO D ^%ZISC
 S X=$$FTG^%ZISH("",XTECDOC,$NA(@XTECGLOB@(1)),3)
 S XNAME(XTECDOC)=""
 S X=$$DEL^%ZISH("",$NA(XNAME))
 Q
