CVERCVT ;Routine for making VistA changes based on OS
        ;
        ; 11/21/10 - based on VRO conversion utility
        ;
        ; share proper syntax
        .W !,"CVERCVT routine syntax: D START^CVERCVT(""x"") where x ="
        .W !
        .W !,"A for Auto sense the operating system"
        .W !,"L for Linux"
        .W !,"W for Windows"
        .W !,"V for VMS"
        .W !
        ;       
START(VER)      ; pass the OS version to convert to or A for auto
        N VERS
        S VERS=$G(VER)
        I (VERS="")!("LWVAlwva"'[VERS) D  Q
        .W !,"CVERCVT routine syntax: D START^CVERCVT(""x"") where x ="
        .W !
        .W !,"A for Auto sense the operating system"
        .W !,"L for Linux"
        .W !,"W for Windows"
        .W !,"V for VMS"
        .W !
        W !,"CAUTION!! The CVERCVT routine is intended only for" 
        W !,"Intersystems Cache' test or development environments,"
        W !,"NOT FOR PRODUCTION VISTA CONFIGURATIONS!"
        W !
        ;R !,"With this in mind, press any key to continue or ""^"" to abort: ",X:90
        ;Q:X="^"
        ;
        I "Aa"[VERS D DEFENV  Q:VERS=""
        D SETUP  Q:VERS=""
        D SPLRES
        D NULRES
        D TNTRES
        D CONSRES
        D HFSRES
        D PMESRES
        D PARMRES
        ;D ZTMSET - don't need to run ztmgrset or change working taskman
        ;S X=$ZU(5,CNSP)
        ;U $P
        ;W !,"Returned to namespace: ",$ZU(5)
        W !,"Conversion complete!"
        Q
SETUP ;Set potentially required variables
        N X,RC,CFG,CNSP,DNSP
        S:'$D(U) U="^"
        S:+$G(DTIME)'>0 DTIME=300
        S:'$D(DUZ) DUZ=.5
        S:$G(DUZ(0))'="@" DUZ(0)="@"
        S:+$G(DT)'>0 DT=$$DT^XLFDT()
        I VERS="L" S VNAME="Linux"
        I VERS="W" S VNAME="Windows"
        I VERS="V" S VNAME="VMS"
        W !,"The OS selected is "_VNAME_". If this is correct"
        R !,"press any key to continue or ""^"" to abort: ",X:90
        I X="^" S VERS="" Q
        W !,"Cache OS version = "_VNAME
        S CNSP=$ZU(5)
        W !,"Current namespace = "_CNSP
        ;I $ZU(90,10,CNSP) S RC=$ZU(90,4,CNSP)
        U $P
        ;W !,"Default namespace set to: ",$G(RC)
        S DNSP=$ZU(5)
        ;S DNSP=$ZU(90,4)
        I DNSP="" D  Q
        .U $P
        .W !,"ERROR!  Unable to determine default namespace!"
        ;S X=$ZU(5,DNSP)
        ;I $G(X)="" D  Q
        ;.U $P
        ;.W !,"ERROR!  Unable to move to namespace ",DNSP,"!"
        ;.S X=$ZU(5,CNSP)
        ;W !,"Current namespace = "_CNSP
        ;W !,"Default namespace = "_DNSP
        ;W !,"Moved to default namespace: ",$ZU(5)
        W !,"Setup done..."
        Q
        ;
DEFENV  ;Define the current environment
        ;
        N VNAME,X
        S VERS=""
        I $F($ZV,"Linux")'=0 s VERS="L",VNAME="Linux"
        I $F($ZV,"Windows")'=0 s VERS="W",VNAME="Windows"
        I $F($ZV,"VMS")'=0 s VERS="V",VNAME="VMS"
        I VERS="" W !,"WARNING! Unable to determine the current OS...Aborting!" Q
        W !,"The OS has been determined to be "_VNAME_". If this is correct"
        R !,"press any key to continue or ""^"" to abort: ",X:90
        I X="^" S VERS=""
        Q
SPLRES  ;spooler directory reset
        N SPL
        I VERS="L" s SPL="/SPOOLER" S X=$ZF(-2,"mkdir /SPOOLER")
        I VERS="W" s SPL="C:\SPOOLER" S X=$ZF(-2,"md c:\SPOOLER")
        I VERS="V" s SPL="USER$:[SPOOLER]" S X=$ZF(-2,"create/dir USER$:[SPOOLER]")
        W !,"Resetting Kernel Default Directory for HFS to "_SPL_" "
        S ^XTV(8989.3,1,"DEV")=SPL
        ;S X=$ZF(-2,"md /SPOOLER")
        W "...done."
        Q
NULRES  ; null device reset
        N ODEV,NDEV,AXXI
        N DIE,DA,DR
        I VERS="L" s NDEV="/dev/nul"
        I VERS="W" s NDEV="//./nul"
        I VERS="V" s NDEV="NLA0:"
        W !,"Resetting VistA NULL device(s) $I to "_NDEV_" "
        S AXXI=0
        F ODEV="/dev/nul","//./nul","NLA0:" I ODEV'=NDEV D
        .F  S AXXI=$O(^%ZIS(1,"C",ODEV,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_ODEV 
        ..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
        ..S DIE="^%ZIS(1,"
        ..S DA=AXXI
        ..;S DR="1///^S X=""/dev/null"""
        ..S DR="1///^S X=NDEV"
        ..D ^DIE K DIE,DA,DR
        K ODEV,NDEV,AXXI
        W "...done."
        Q
TNTRES  ; telnet device reset
        N TDEV,OTDEV,AXXI
        N DIE,DA,DR
        I VERS="L" s TDEV="/dev/pts"
        I VERS="W" s TDEV="|TNT|"
        I VERS="V" s TDEV="TNA"
        W !,"Resetting TNA VIRTUAL device $I to "_TDEV_" "
        S AXXI=0
        F OTDEV="/dev/pts","|TNT|","TNA" I OTDEV'=TDEV D
        .F  S AXXI=$O(^%ZIS(1,"C",OTDEV,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_OTDEV 
        ..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
        ..S DIE="^%ZIS(1,"
        ..S DA=+AXXI
        ..S DR="1///^S X=TDEV"
        ..D ^DIE K DIE,DA,DR
        K TDEV,OTDEV,AXXI
        W "...done."
        Q
CONSRES ; console device reset
        N OCDEV,CDEV,AXXI
        N DIE,DA,DR
        I VERS="L" s CDEV="/dev/tty"
        I VERS="W" s CDEV="|TRM|"
        I VERS="V" s CDEV="OPA"
        W !,"Resetting VistA CONSOLE device $I to "_CDEV_" "
        S AXXI=0
        F OCDEV="/dev/tty","|TRM|","OPA" I OCDEV'=CDEV  D
        .F  S AXXI=$O(^%ZIS(1,"C",OCDEV,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_OCDEV
        ..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
        ..S DIE="^%ZIS(1,"
        ..S DA=+AXXI
        ..S DR="1///^S X=CDEV"
        ..D ^DIE K DIE,DA,DR
        K OCDEV,CDEV,AXXI
        W "...done."
        Q
HFSRES  ; HSF device reset
        N HFS,OHFS,AXXI
        N DIE,DA,DR
        I VERS="L" s HFS="/HFS" S X=$ZF(-2,"mkdir /HFS")
        I VERS="W" s HFS="c:\HFS" S X=$ZF(-2,"md c:\HFS")
        I VERS="V" s HFS="USER$:[HFS]" S X=$ZF(-2,"create/dir USER$:[HFS]")
        W !!,"Resetting HFS device(s) $I values to "_HFS_"..."
        S AXXI=0
        F OHFS="C:\TEMP\TMP.DAT","USER$:[HFS]","/HFS",$ZU(5)_"_HFS$:[HFS]" I OHFS'=HFS D
        .F  S AXXI=$O(^%ZIS(1,"C",OHFS,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_OHFS
        ..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
        ..S DIE="^%ZIS(1,"
        ..S DA=+AXXI
        ..S DR="1///^S X=HFS"
        ..D ^DIE K DIE,DA,DR
        K HFS,OHFS,AXXI
        W "...done."
        Q
PMESRES ; P-MESSAGE device reset
        N PMES,OPMES,AXXI
        N DIE,DA,DR
        I VERS="L" s PMES="/HFS/XMHFS.TMP"
        I VERS="W" s PMES="c:\HFS\XMHFS.TMP"
        I VERS="V" s PMES="USER$:[HFS]XMHFS.TMP"
        W !!,"Resetting HFS device(s) $I values to "_PMES_"..."
        S AXXI=0
        F OPMES="C:\TEMP\XMHFS.TMP","/HFS/XMHFS.TMP","c:\HFS\XMHFS.TMP","USER$:[HFS]XMHFS.TMP" I OPMES'=PMES D
        .F  S AXXI=$O(^%ZIS(1,"C",OPMES,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_OPMES
        ..W !?2,$P($G(^%ZIS(1,AXXI,0)),"^")
        ..S DIE="^%ZIS(1,"
        ..S DA=+AXXI
        ..S DR="1///^S X=PMES"
        ..D ^DIE K DIE,DA,DR
        K PMES,OPMES,AXXI
        W "...done."
        Q 
PARMRES ; PARAMETERS file reset
        N AXX1,AXXG,AXXGREF,AXXDATA,AXXFIX
        I VERS="L" s HFS="/HFS/"
        I VERS="W" s HFS="c:\HFS\"
        I VERS="V" s HFS="USER$:[HFS]"
        W !,"Resetting PARAMETERS file entries -- any VMS device $I values"
        W !,"will be reset to HFS directory..."
        F AXX1=$ZU(5)_"_HFS$:[TMP]",$ZU(5)_"_HFS$:[HFS]","/HFS","C:\HFS","C:\TEMP" I AXX1'=HFS D
        .S AXXG="^XTV(8989.5)",AXXGREF="^XTV(8989.5"
        .F  S AXXG=$Q(@AXXG) Q:AXXG'[AXXGREF  D
        ..S AXXDATA=@AXXG
        ..I AXXDATA="" K AXXDATA Q
        ..S AXXFIX=0
        ..S AXXDATA=$$UP^XLFSTR(AXXDATA)
        ..I AXXDATA=AXX1 S AXXFIX=1
        ..I 'AXXFIX&(AXXDATA["_HFS$:") S AXXFIX=1
        ..I AXXFIX=1 S @AXXG=HFS
        ..K AXXDATA,AXXFIX
        .K AXX1,AXX2,AXXG,AXXGREF
        W "...done."
        Q
ZTMSET  ;
        ;ZTMGRSET ;SF/RWF,PUG/TOAD - SET UP THE MGR ACCOUNT FOR THE SYSTEM ;02/13/2008
        ;;8.0;KERNEL;**34,36,69,94,121,127,136,191,275,355,446**;JUL 10, 1995;Build 35
        ;
        N %D,%S,I,OSMAX,U,X,X1,X2,Y,Z1,Z2,ZTOS,ZTMODE,SCR,ZNSP
        S ZTMODE=0
A       ;
        ;;W !!,"ZTMGRSET Version ",$P($T(+2),";",3)," Patch level ",$P($T(+2),";",5)
        ;;W !,"HELLO! I exist to assist you in correctly initializing the current account."
        I $D(^%ZOSF("UCI")) X ^%ZOSF("UCI")  ;D  G A:"YNyn"'[$E(X) Q:"Nn"[$E(X)
        ;X ^%ZOSF("UCI") returns "Y=CPM,ROU"    
        ;;. I ZTMODE=2 S X="Y" Q
        ;;. W $C(7),!!,"This is namespace or uci ",Y,".",!
        ;;. R "Should I continue? N//",X:120
        ;;. Q
        ;;S ZTOS=$$OS() I ZTOS'>0 W !,"OS type not selected. Exiting ZTMGRSET." Q
        S ZTOS=3,U="^",SCR="I 1" ;3=all versions of cache when ZTMGRSET is run
        ;;I ZTMODE D  I (PCNM<1)!(PCNM>999) W !,"Need a Patch number to load." Q
        ;;. I ZTMODE<2 R !!,"Patch number to load: ",PCNM:120 Q:(PCNM<1)!(PCNM>999)
        ;;. S SCR="I $P($T(+2^@X),"";"",5)?.E1P1"_$C(34)_PCNM_$C(34)_"1P.E"
        ;
        K ^%ZOSF("MASTER"),^("SIGNOFF") ;Remove old nodes.
        ;
DOIT ;
        D MES("I will now rename a group of routines specific to your operating system.",1)
        D @ZTOS,ALL,GLOBALS:'ZTMODE D MES("ALL DONE",1)
        Q
        ;========================================
RELOAD ;Reload any patched routines
 N %D,%S,I,OSMAX,U,X,X1,X2,Y,Z1,Z2,ZTOS,ZTMODE,SCR
 S ZTMODE=1 G A
 Q
 ;
PATCH(PCNM) ;Post install Reload any patched routines
 N %D,%S,I,OSMAX,U,X,X1,X2,Y,Z1,Z2,ZTOS,ZTMODE,SCR
 I (1>PCNM)!(PCNM>999) D MES("PATCH NUMBER OUT OF RANGE",1) Q
 D MES("Rename the routines in Patch "_PCNM,1)
 S ZTMODE=2 G A
 Q
 ;
MES(T,B) ;Write message.
 S B=$G(B)
 I $L($T(BMES^XPDUTL)) D BMES^XPDUTL(T):B,MES^XPDUTL(T):'B Q
 W:B ! W !,T
 Q
 ;
OS() ;Select the OS
        N Y,X1,X,OSMAX
        S U="^",SCR="I 1" F I=1:1:20 S X=$T(@I) Q:X=""  S OSMAX=I
B       ;
        S Y=0,ZTOS=0 I $D(^%ZOSF("OS")) D
        . S X1=$P(^%ZOSF("OS"),U),ZTOS=$$OSNUM W !,"I think you are using ",X1
        I ZTMODE=2,ZTOS>0 Q ZTOS
        W !,"Which MUMPS system should I install?",!
        F I=1:1:OSMAX W !,I," = ",$P($T(@I),";",3)
        W !,"System: " W:ZTOS ZTOS,"//"
        R X:300 S:X="" X=ZTOS
        I X<1!(X>OSMAX) W !,"NOT A VALID CHOICE" Q:X[U 0 G B
        Q X
        ;
OSNUM() ;Return the OS number
        N I,X1,X2,Y S Y=0,X1=$P($G(^%ZOSF("OS")),"^")
        F I=1:1 S X2=$T(@I) Q:X2=""  I X2[X1 S Y=I Q
        Q Y
        ;
ALL W !!,"Now to load routines common to all systems."
        D TM,ETRAP,DEV,OTHER,FM
        I ZTOS=7!(ZTOS=8) D
        . S ^%ZE="D ^ZE"
        E  D  ;With ZLoad, ZSave, ZInsert
        . W !,"Installing ^%Z editor"
        . D ^ZTEDIT
        I 'ZTMODE W !,"Setting ^%ZIS('C')" K ^%ZIS("C") S ^%ZIS("C")="G ^%ZISC"
        Q
        ;
TM ;Taskman
        S %S="ZTLOAD^ZTLOAD1^ZTLOAD2^ZTLOAD3^ZTLOAD4^ZTLOAD5^ZTLOAD6^ZTLOAD7"
        S %D="%ZTLOAD^%ZTLOAD1^%ZTLOAD2^%ZTLOAD3^%ZTLOAD4^%ZTLOAD5^%ZTLOAD6^%ZTLOAD7"
        D MOVE
        S %S="ZTM^ZTM0^ZTM1^ZTM2^ZTM3^ZTM4^ZTM5^ZTM6"
        S %D="%ZTM^%ZTM0^%ZTM1^%ZTM2^%ZTM3^%ZTM4^%ZTM5^%ZTM6"
        D MOVE
        S %S="ZTMS^ZTMS0^ZTMS1^ZTMS2^ZTMS3^ZTMS4^ZTMS5^ZTMS7^ZTMSH"
        S %D="%ZTMS^%ZTMS0^%ZTMS1^%ZTMS2^%ZTMS3^%ZTMS4^%ZTMS5^%ZTMS7^%ZTMSH"
        D MOVE
        Q
FM ;Rename the FileMan routines
        I ZTMODE>0 Q  ;Only ask on full install
        R !,"Want to rename the FileMan routines: No//",X:600 Q:"Yy"'[$E(X_"N")
        S %S="DIDT^DIDTC^DIRCR",%D="%DT^%DTC^%RCR"
        D MOVE
        Q
 ;
ETRAP ;Error Trap
 S %S="ZTER^ZTER1",%D="%ZTER^%ZTER1"
 D MOVE
 Q
OTHER S %S="ZTPP^ZTP1^ZTPTCH^ZTRDEL^ZTMOVE"
 S %D="%ZTPP^%ZTP1^%ZTPTCH^%ZTRDEL^%ZTMOVE"
 D MOVE
 Q
DEV S %S="ZIS^ZIS1^ZIS2^ZIS3^ZIS5^ZIS6^ZIS7^ZISC^ZISP^ZISS^ZISS1^ZISS2^ZISTCP^ZISUTL"
        S %D="%ZIS^%ZIS1^%ZIS2^%ZIS3^%ZIS5^%ZIS6^%ZIS7^%ZISC^%ZISP^%ZISS^%ZISS1^%ZISS2^%ZISTCP^%ZISUTL"
        D MOVE
        Q
RUM ;Build the routines for Capacity Management (CM)
        S %S=""
        I ZTOS=3 S %S="ZOSVKRO^ZOSVKSOE^ZOSVKSOS^ZOSVKSD" ;OpenM
        I ZTOS=7!(ZTOS=8) S %S="ZOSVKRG^ZOSVKSGE^ZOSVKSGS^ZOSVKSD" ;GT.M
        S %D="%ZOSVKR^%ZOSVKSE^%ZOSVKSS^%ZOSVKSD"
        D MOVE
        Q
ZOSF(X) ;
        ;X SCR I $T W ! D @(U_X) W !
        W !,"ZOSF-1"
        X SCR I $T W ! D MGR,PROD,VOLSET,VOL W !
        W !,"ZOSF-2"
        Q
3 ;;Cache (VMS, NT, Linux), OpenM-NT
        S %S="ZOSVONT^^ZIS4ONT^ZISFONT^ZISHONT^XUCIONT"
        D DES,MOVE
        S %S="ZISTCPS^ZTMDCL",%D="%ZISTCPS^%ZTMDCL"
        D MOVE,RUM,ZOSF("ZOSFONT")
        Q
MOVE ; rename % routines
        N %,X,Y,M
        F %=1:1:$L(%D,"^") D  D MES(M)
        . S M="",X=$P(%S,U,%) ; from
        . S Y=$P(%D,U,%) ; to
        . Q:X=""
        . S M="Routine: "_$J(X,8)
        . Q:Y=""  I $T(^@X)=""  S M=M_"  Missing" Q
        . X SCR Q:'$T
        . S M=M_" Loaded, "
        . D COPY(X,Y)
        . S M=M_"Saved as "_$J(Y,8)
        Q
        ;
COPY(FROM,TO) ;
 I ZTOS'=7,ZTOS'=8 X "ZL @FROM ZS @TO" Q
 ;For GT.M below
 N PATH,COPY,CMD S PATH=$$R
 S FROM=PATH_FROM_".m"
 S TO=PATH_$TR(TO,"%","_")_".m"
 S COPY=$S(ZTOS=7:"COPY",1:"cp")
 S CMD=COPY_" "_FROM_" "_TO
 X "ZSYSTEM CMD"
 Q
 ;
R() ; routine directory for GT.M
 N ZRO X "S ZRO=$ZRO"
 I ZTOS=7 D  Q $S(ZRO["(":$P($P(ZRO,"(",2),")"),1:ZRO)
 . S ZRO=$P(ZRO,",")
 . I ZRO["/SRC=" S ZRO=$P(ZRO,"=",2) Q  ;Source dir
 . S ZRO=$S(ZRO["/":$P(ZRO,"/"),1:ZRO) Q  ;Source and Obj in same dir
 I ZTOS=8 Q $P($S(ZRO["(":$P($P(ZRO,"(",2),")"),1:ZRO)," ")_"/" ;Use first source dir.
 E  Q ""
 ;
DES S %D="%ZOSV^%ZTBKC1^%ZIS4^%ZISF^%ZISH^%XUCI" Q
        ;
GLOBALS ;Set node zero of file #3.05 & #3.07
        W !!,"Now, I will check your % globals."
        W ".........."
        F %="^%ZIS","^%ZISL","^%ZTER","^%ZUA" S:'$D(@%) @%=""
        S:$D(^%ZTSK(0))[0 ^%ZTSK(-1)=100,^%ZTSCH=""
        S Z1=$G(^%ZTSK(-1),-1),Z2=$G(^%ZTSK(0))
        I Z1'=$P(Z2,"^",3) S:Z1'>0 ^%ZTSK(-1)=+Z2 S ^%ZTSK(0)="TASKS^14.4^"_^%ZTSK(-1)
        S:$D(^%ZUA(3.05,0))[0 ^%ZUA(3.05,0)="FAILED ACCESS ATTEMPTS LOG^3.05^^"
        S:$D(^%ZUA(3.07,0))[0 ^%ZUA(3.07,0)="PROGRAMMER MODE LOG^3.07^^"
        Q
NAME ;Setup the static names for this system
MGR     S X=$ZU(90,4) X ^("UCICHECK") G MGR:0[Y S ^%ZOSF("MGR")=X  Q 
PROD  S X=$ZU(90,4) X ^("UCICHECK") G PROD:0[Y S ^%ZOSF("PROD")=X  Q
VOL ; set the default volume set to default namespace
        ;W !,"NAME OF VOLUME SET: "_^%ZOSF("VOL")_"//" R X:$S($G(DTIME):DTIME,1:9999) I X]"" S:X?3U ^%ZOSF("VOL")=X I X'?3U W "MUST BE 3 Upper case." G VOL
        ;
        N DIE,DA,DR,OVOL,AXXI,NVOL
        S NVOL=$ZU(90,4)
        ;W !,"VOLS="_^%ZOSF("VOL")_" "_$ZU(90,4)
        S AXXI=0
        F OVOL=$G(^%ZOSF("VOL")),$ZU(90,4) D
        .F  S AXXI=$O(^%ZIS(14.5,"B",OVOL,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_OVOL
        ..W !?2,$P($G(^%ZIS(14.5,AXXI,0)),"^")
        ..S DIE="^%ZIS(14.5,"
        ..S DA=+AXXI
        ..S DR=".01///^S X=NVOL"
        ..D ^DIE 
        S ^%ZOSF("VOL")=NVOL
        K DIE,DA,DR,NVOL,OVOL
        Q
VOLSET  ; reset the tasman volume set
        ;
        N DIE,DA,DR,OVSET,AXXI,NVSET,NSP,CFG
        S NSP=$ZU(90,4)
        S CFG=$P($ZU(86),"*",2)
        W !,"Config name = "_CFG
        S NVSET=$ZU(90,4)_":"_CFG
        ;W !,"VOLS="_^%ZOSF("VOL")_" "_$ZU(90,4)
        S OVSET=""
        F  S OVSET=$O(^%ZIS(14.7,"B",OVSET)) Q:(OVSET="")!(OVSET=NVSET)  D
        .S AXXI=0
        .F  S AXXI=$O(^%ZIS(14.7,"B",OVSET,AXXI)) Q:'AXXI  D
        ..W !,AXXI_"="_OVSET
        ..W !?2,$P($G(^%ZIS(14.7,AXXI,0)),"^")
        ..S DIE="^%ZIS(14.7,"
        ..S DA=+AXXI
        ..S DR=".01///^S X=NVSET"
        ..D ^DIE 
        K DIE,DA,DR,OVSET,AXXI,NVSET,NSP
        Q
 
