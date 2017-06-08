ZZUTZOSV ;KRM/CJE,VEN/SMH - GT.M Kernel unit tests ;2017-01-09  3:56 PM
 ;;8.0;KERNEL;**10001**;Aug 28, 2013;Build 11
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Authored by Sam Habiel & Christopher Edwards 2014-2016.
 ;
 ; makes it easy to run tests simply by running this routine and
 ; insures that %ut will be run only where it is present
 I $T(EN^%ut)'="" D EN^%ut("ZZUTZOSV",3)
 Q
 ;
STARTUP ;
 D DUZ^XUP(.5)
 QUIT
 ;
COV ; [Coverage of Unit Tests] NB: This uses an unpublished copy of M-Unit to perform multiple namespace coverage.
 N NMSPS
 S (NMSPS("%ZOSV*"),NMSPS("%ZISH"),NMSPS("ZTMGRSET"))=""
 S (NMSPS("XLFNSLK"),NMSPS("XLFIPV"),NMSPS("XUSHSH"),NMSPS("XQ82"))=""
 S (NMSPS("ZSY"))=""
 D COV^%ut1(.NMSPS,"D ^ZZUTZOSV",1)
 QUIT
 ;
 ;
SETNM ; @TEST Set Environment Name
 D SETNM^%ZOSV("ZOSV UT for GT.M")
 QUIT
 ;
ZRO1 ; @TEST $ZROUTINES Parsing Single Object Multiple dirs
 N ZR S ZR="o(p r) /var/abc(/var/abc/r/) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"p/")
 QUIT
 ;
ZRO2 ; @TEST $ZROUTINES Parsing 2 Single Object Single dir
 N ZR S ZR="/var/abc(/var/abc/r/) o(p r) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/var/abc/r/")
 QUIT
 ;
ZRO3 ; @TEST $ZROUTINES Parsing Shared Object/Code dir
 N ZR S ZR="/abc/def /var/abc(/var/abc/r/) o(p r) $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/abc/def/")
 QUIT
 ;
ZRO4 ; @TEST $ZROUTINES Parsing Single Directory by itself
 N ZR S ZR="/home/osehra/r"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/r/")
 QUIT
 ;
ZRO5 ; @TEST $ZROUTINES Parsing Leading Space
 N ZR S ZR=" o(p r) /var/abc(/var/abc/r/) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"p/")
 QUIT
 ;
 ;
ZRO7 ; @TEST $ZROUTINES Shared Object Only
 N ZR S ZR="/home/osehra/lib/gtm/libgtmutil.so"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"")
 Q
 ;
ZRO8 ; @TEST $ZROUTINES No shared object
 N ZR S ZR="/home/osehra/r/V6.0-002_x86_64(/home/osehra/r) /home/osehra/lib/gtm"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/r/")
 Q
 ;
ZRO9 ; @TEST $ZROUTINES Shared Object First
 N ZR S ZR="/home/osehra/lib/gtm/libgtmutil.so /home/osehra/r/V6.0-002_x86_64(/home/osehra/r)"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/r/")
 Q
 ;
ZRO10 ; @TEST $ZROUTINES Shared Object First but multiple rtn dirs
 N ZR S ZR="/home/osehra/lib/gtm/libgtmutil.so /home/osehra/p/V6.0-002_x86_64(/home/osehra/p) /home/osehra/s/V6.0-002_x86_64(/home/osehra/s) /home/osehra/r/V6.0-002_x86_64(/home/osehra/r)"
 N DIRS D PARSEZRO^%ZOSV(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST^%ZOSV(.DIRS)
 D CHKEQ^%ut(FIRSTDIR,"/home/osehra/p/")
 Q
 ;
ZRO99 ; @TEST $$RTNDIR^%ZOSV Shouldn't be Empty
 N RTNDIR S RTNDIR=$$RTNDIR^%ZOSV
 D CHKTF^%ut(RTNDIR]"")
 QUIT
 ;
ACTJ ; @TEST Default path through ACTJ^ZOSV
 N ACTJ
 ; Run the algorithm
 S ACTJ=$$ACTJ^%ZOSV
 D CHKTF^%ut(ACTJ>0,"$$ACTJ^%ZOSV didn't return the correct value")
 Q
 ;
ACTJ0 ; @TEST Force ^XUTL("XUSYS","CNT") to 0 to force algorithm to run
 ; Force algorithm to run
 S ^XUTL("XUSYS","CNT")=0
 ; Run the algorithm
 N ACTJ S ACTJ=$$ACTJ^%ZOSV
 D CHKTF^%ut(ACTJ,"Active Jobs must not be zero")
 ;
 ; Run again, but this time we get the cached result
 N ACTJ2 S ACTJ2=$$ACTJ^%ZOSV
 D CHKEQ^%ut(ACTJ2,ACTJ,"$$ACTJ^%ZOSV is out of sync with jobs on file")
 ;
 ; Force algorithm to run
 S ^XUTL("XUSYS","CNT")=0
 ; Run the algorithm
 N ACTJ3 S ACTJ3=$$ACTJ^%ZOSV
 D CHKEQ^%ut(ACTJ2,ACTJ3,"$$ACTJ^%ZOSV is out of sync with jobs on file")
 ; 
 Q
 ;
AVJ ; @TEST Available Jobs
 D CHKTF^%ut($$AVJ^%ZOSV>0)
 QUIT
 ;
DEVOK ; @TEST Dev Okay
 N X,X1,Y
 S X="ORB NOTIFICATION RESOURCE",X1="RES" D DEVOK^%ZOSV
 D CHKTF^%ut(Y=0)
 S X="NULL" D DEVOK^%ZOSV
 D CHKTF^%ut(Y=0)
 QUIT
 ;
DEVOPN ; @TEST Show open devices
 N Y D DEVOPN^%ZOSV
 D CHKTF^%ut(Y'="")
 QUIT
 ;
GETPEER ; @TEST Get Peer
 N PEER S PEER=$$GETPEER^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
PRGMODE ; @TEST Prog Mode
 N % S %=$$PROGMODE^%ZOSV()
 D PRGMODE^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
JOBPAR ; @TEST Job Parameter -- Dummy; doesn't do anything useful.
 N X,Y S X=$J D JOBPAR^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
LOGRSRC ; @TEST Turn on Resource Logging
 ; KMPR package not ported to GT.M. Noop.
 D LOGRSRC^%ZOSV("TEST",1,"OPEN")
 QUIT
 ;
ORDER ; @TEST Order
 N X,Y
 S X="^TMP($J,"
 K ^TMP($J)
 S Y="%ut*"
 D ORDER^%ZOSV
 D CHKTF^%ut(^TMP($J,"%ut","CHK")) ; Must be a number
 QUIT
 ;
DOLRO ; @TEST Ensure symbol table is saved correctly
 N TEST,X
 ; Will check for this variable and value in the open root
 S TEST="TEST1"
 ; DOLRO reads the variable X to figure put where to save the symbol table to
 S X="^TMP(""ZZUTZOSV"","
 ; Save the symbol table
 D DOLRO^%ZOSV
 D CHKEQ^%ut(^TMP("ZZUTZOSV","TEST"),"TEST1","DOLRO^%ZSOV Didn't save the correct variable value")
 ; Debug
 ; ZWR ^TMP("ZZUTZOSV",*)
 ; Kill test variable
 K ^TMP("ZZUTZOSV")
 Q
 ;
TMTRAN ; @TEST Make sure that Taskman is running
 I '$$TM^%ZTLOAD() D FAIL^%ut("Can't run this test. Taskman isn't running.") QUIT
 ;
 N ZTSK D Q^XUTMTZ
 D CHKTF^%ut(ZTSK)
 N TOTALWAIT S TOTALWAIT=0
 F  Q:'$D(^%ZTSK(ZTSK))  H .05 S TOTALWAIT=TOTALWAIT+.05 Q:TOTALWAIT>3
 D CHKTF^%ut(TOTALWAIT<2,"Taskman didn't process task")
 QUIT
 ;
GETENV ; @TEST Test GETENV
 N Y D GETENV^%ZOSV
 D CHKEQ^%ut($L(Y,"^"),4)
 QUIT
 ;
OS ; @TEST OS
 D CHKEQ^%ut($$OS^%ZOSV(),"UNIX")
 QUIT
 ;
VERSION ; @TEST VERSION
 N V0 S V0=$$VERSION^%ZOSV(0)
 N OS S OS=$$VERSION^%ZOSV(1)
 D CHKTF^%ut(V0,"Must be positive")
 D CHKTF^%ut($L(V0,"-")=2,"Must be in xx.xxxx")
 D CHKTF^%ut(OS["nux"!(OS["nix")!(OS["BSD")!(OS["Darwin")!(OS["CYGWIN"))
 QUIT
 ;
SID ; @TEST System ID
 N SID S SID=$$SID^%ZOSV
 D CHKTF^%ut(SID[$ZGBLDIR)
 QUIT
 ;
UCI ; @TEST Get UCI/Vol
 N Y D UCI^%ZOSV
 D CHKTF^%ut(Y=^%ZOSF("PROD"))
 QUIT
UCICHECK ; @TEST Noop
 N % S %=$$UCICHECK^%ZOSV(88)
 D CHKEQ^%ut(88,%)
 QUIT
PARSIZ ; @TEST PARSIZE NOOP
 N X
 D PARSIZ^%ZOSV
 D SUCCEED^%ut
 QUIT
NOLOG ; @TEST NOLOG NOOP
 N Y
 D NOLOG^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
SHARELIC ; @TEST SHARELIC NOOP
 D SHARELIC^%ZOSV()
 D SUCCEED^%ut
 QUIT
 ;
PRIORITY ; @TEST PRIORITY NOOP
 D PRIORITY^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
PRIINQ ; @TEST PRIINQ() NOOP
 N % S %=$$PRIINQ^%ZOSV()
 D SUCCEED^%ut
 QUIT
 ;
BAUD ; @TEST BAUD NOOP
 N X D BAUD^%ZOSV
 D SUCCEED^%ut
 S X="UNKNOWN"
 QUIT
 ;
SETTRM ; @TEST Set Terminators
 N % S %=$$SETTRM^%ZOSV($C(10,13))
 D CHKEQ^%ut(%,1)
 X ^%ZOSF("TRMON") ; Reset terminators
 QUIT
 ;
LGR ; @TEST Last Global Reference
 S ^TMP($J)=""
 I ^TMP($J)
 N R S R=$$LGR^%ZOSV()
 D CHKEQ^%ut(R,$NA(^TMP($J)))
 K ^TMP($J)
 QUIT
 ;
EC ; @TEST $$EC
 N A,%
 N $ET S $ET="S A=$$EC^%ZOSV,$EC="""" G EC1"
 S %=1/0
EC1 ;
 D CHKTF^%ut(A["divide")
 QUIT
 ;
ZTMGRSET ; @TEST ZTMGRSET Renames Routines on GT.M
 ;ZEXCEPT: shell
 N %ZR,%Y,%YY
 N RTNFS S RTNFS="_ZTLOAD1.o"
 D SILENT^%RSEL("%ZTLOAD1","OBJ")
 N FILE S FILE=%ZR("%ZTLOAD1")_RTNFS
 S %Y=$$RETURN^%ZOSV("stat -c %X "_FILE)
 N ZTOS S ZTOS=$$OSNUM^ZTMGRSET()
 N SCR S SCR="I 0"
 N ZTMODE S ZTMODE=2
 N IOP S IOP="NULL" D ^%ZIS U IO
 D DOIT^ZTMGRSET
 D ^%ZISC
 D SILENT^%RSEL("%ZTLOAD1","OBJ")
 N FILE S FILE=%ZR("%ZTLOAD1")_RTNFS
 S %YY=$$RETURN^%ZOSV("stat -c %X "_FILE)
 D CHKTF^%ut(%YY'<%Y)
 ;
 ; Now that we know that it works, just run some of the other EPs to inc coverage
 N IOP S IOP="NULL" D ^%ZIS U IO
 D PATCH^ZTMGRSET(599) ; %ZIS
 ;
 N DTIME S DTIME=.00001
 D NAME^ZTMGRSET
 D GLOBALS^ZTMGRSET
 D RUM^ZTMGRSET
 D ^%ZISC
 QUIT
 ;
ZHOROLOG ; @TEST $ZHOROLOG Functions
 Q:$$VERSION^%ZOSV<6.3
 N %ZH0,%ZH1,%ZH2
 D T0^%ZOSV
 D CHKTF^%ut(%ZH0)
 D CHKTF^%ut($L(%ZH0,",")=4)
 D T1^%ZOSV
 D CHKTF^%ut(%ZH1)
 D CHKTF^%ut($L(%ZH1,",")=4)
 D ZHDIF^%ZOSV
 D CHKTF^%ut(%ZH2<.001,"%ZH2 is "_%ZH2)
 QUIT
 ;
TEMP ; @TEST getting temp directory
 N TMP S TMP=$$TEMP^%ZOSV()
 N FN S FN=TMP_"/test.txt"
 O FN:newvesrion
 U FN
 W "TEST",!
 C FN:delete
 D SUCCEED^%ut
 QUIT
 ;
PASS ; @TEST PASTHRU and NOPASS
 D PASSALL^%ZOSV
 D NOPASS^%ZOSV
 D SUCCEED^%ut
 QUIT
 ;
NSLOOKUP ; @TEST Test DNS Utilities
 ; REVERSE DNS
 N % S %=$$HOST^XLFNSLK("208.67.220.220")
 D CHKTF^%ut(%["opendns")
 N % S %=$$HOST^XLFNSLK("2607:F8B0:400D:0C01:0000:0000:0000:0066")
 D CHKTF^%ut(%["1e100")
 N % S %=$$HOST^XLFNSLK("")
 D SUCCEED^%ut
 N % S %=$$HOST^XLFNSLK("93.184.216.34") ; example.com doesn't have reverse dns
 D CHKTF^%ut(%="")
 ;
 ; FORWARD DNS
 ; dig may fail with localhost lookup
 N IPV6 S IPV6=$$VERSION^XLFIPV
 I IPV6 D CHKTF^%ut($$ADDRESS^XLFNSLK("localhost")["0000:0000:0000:0000:0000:0000:0000:000") I 1
 E  D CHKTF^%ut(($$ADDRESS^XLFNSLK("localhost")["127.0.0.1")!($$ADDRESS^XLFNSLK("localhost")["0.0.0.0"))
 D CHKTF^%ut(($$ADDRESS^XLFNSLK("localhost","A")["127.0.0.1")!($$ADDRESS^XLFNSLK("localhost","A")["0.0.0.0"))
 D CHKTF^%ut($$ADDRESS^XLFNSLK("localhost","AAAA")["0000:0000:0000:0000:0000:0000:0000:000")
 QUIT
 ;
IPV6 ; @TEST Test GT.M support for IPV6
 I $ZV["CYGWIN" QUIT  ; We run Cygwin on IPv4 only as Cygwin doesn't support between the two as well as Linux
 D CHKEQ^%ut($$VERSION^XLFIPV(),1)
 QUIT
 ;
SSVNJOB ; @TEST Replacement for ^$JOB in XQ82
 ; ZEXCEPT: SSVNJOB,SSVNJOB1,ERR,IN
 L +SSVNJOB
 J SSVNJOB1:(IN="/dev/null":OUT="/dev/null":ERR="/dev/null")
 N CHILDPID S CHILDPID=$ZJOB
 L -SSVNJOB
 H .01 ; This must be big enough to let your computer start the job
 I $ZV["CYGWIN" H 1 ; Wish I knew why...
 L +SSVNJOB
 L
 D CHKTF^%ut($D(^TMP(CHILDPID)))
 S ^XUTL("XQ",$J)="" ; So that ^XQ82 won't kill our temp globals 
 D ^XQ82
 D CHKTF^%ut('$D(^TMP(CHILDPID)))
 QUIT
 ;
SSVNJOB1 ; [Private] Helper for SSVNJOB
 ; ZEXCEPT: SSVNJOB
 L +SSVNJOB
 K ^TMP($J)
 S ^TMP($J,"SAM")=1
 S ^TMP($J,"CHRISTOPHER")=2
 L -SSVNJOB
 QUIT
 ;
OPENH ; @TEST Read a Text File in w/ Handle
 ; OPEN^%ZISH([handle][,path,]filename,mode[,max][,subtype]) 
 N POP
 K ^TMP($J)
 D OPEN^%ZISH("FILE1","/usr/include/","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 D USE^%ZISUTL("FILE1")
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CLOSE^%ZISH("FILE1")
 W !
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 QUIT
 ;
OPENNOH ; @TEST Read a Text File w/o a Handle
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include/","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CLOSE^%ZISH()
 W !
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 QUIT
 ;
OPENBLOR ; @TEST Read a File as a binary device (FIXED WIDTH)
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include/","stdio.h","RB")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CLOSE^%ZISH()
 W !
 D CHKEQ^%ut($ZL(^TMP($J,5)),512,"Blocks are 512 bytes each")
 D CHKEQ^%ut($ZL(^TMP($J,5)),$ZL(^TMP($J,6)),"Blocks should all be the same size")
 QUIT
 ;
OPENBLOW ; @TEST Write a File as a binary device (Use Capri zip file in 316.18)
 N POP
 K ^TMP($J)
 N SUB S SUB=$O(^DVB(396.18,1,3,0))
 N FNNODE S FNNODE=^DVB(396.18,1,3,SUB,0)
 N L S L=$P(FNNODE," ",2)
 N FN S FN=$P(FNNODE," ",3)
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"WB",61)
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  S SUB=$O(^DVB(396.18,1,3,SUB)) Q:'SUB  W ^(SUB,0)
 D CLOSE^%ZISH()
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"RB",61)
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 N X R X:0
 D CLOSE^%ZISH()
 W !
 D CHKTF^%ut($L(X)=61,"record size isn't correct")
 QUIT
 ;
OPENBLOV ; @TEST Write and Read a variable record file
 N POP
 K ^TMP($J)
 N SUB S SUB=$O(^DVB(396.18,174,3,0))
 N FNNODE S FNNODE=^DVB(396.18,174,3,SUB,0)
 N L S L=$P(FNNODE," ",2)
 N FN S FN=$P(FNNODE," ",3)
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"W",61)
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  S SUB=$O(^DVB(396.18,174,3,SUB)) Q:'SUB  W ^(SUB,0),!
 D CLOSE^%ZISH()
 D OPEN^%ZISH(,$$DEFDIR^%ZISH(),FN,"R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 N X R X:0
 D CLOSE^%ZISH()
 W !
 D CHKTF^%ut($L(X)=61,"record size isn't correct")
 QUIT
 
OPENDF ; @TEST Open File from Default HFS Directory
 ; Uses the file from the last test.
 N POP
 N SUB S SUB=$O(^DVB(396.18,1,3,0))
 N FNNODE S FNNODE=^DVB(396.18,1,3,SUB,0)
 N L S L=$P(FNNODE," ",2)
 N FN S FN=$P(FNNODE," ",3)
 D OPEN^%ZISH(,,FN,"RB",61)
 D CHKTF^%ut(POP'=1)
 D CLOSE^%ZISH()
 QUIT
 ;
OPENSUB ; @TEST Open file with a Specific Subtype
 ; ZEXCEPT: IOM,IOSL
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include/","stdio.h","R",,"P-HFS/80/99999")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 D CHKTF^%ut(IOM=80)
 D CHKTF^%ut(IOSL=65500)
 D CLOSE^%ZISH()
 QUIT
 ;
OPENDLM ; @TEST Forget delimiter in Path
 N POP
 K ^TMP($J)
 D OPEN^%ZISH(,"/usr/include","stdio.h","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 F  R ^TMP($J,$I(^TMP($J))):0 Q:$$STATUS^%ZISH()
 D CHKTF^%ut(^TMP($J)>25)
 D CHKTF^%ut($D(^TMP($J,^TMP($J)-1)))
 D CLOSE^%ZISH()
 QUIT
 ;
OPENAPP ; @TEST Open with appending
 N POP
 D OPEN^%ZISH(,,"test-for-sam.txt","W")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "TEST 1",!
 D CLOSE^%ZISH
 D OPEN^%ZISH(,,"test-for-sam.txt","WA")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "TEST 2",!
 D CLOSE^%ZISH
 D CHKTF^%ut($$RETURN^%ZOSV("wc -l "_$$DEFDIR^%ZISH()_"test-for-sam.txt | xargs | cut -d' ' -f1")=2)
 QUIT
 ;
PWD ; @TEST Get Current Working Directory
 D CHKTF^%ut($$PWD^%ZISH()=$ZD)
 QUIT
 ;
DEFDIR ; @TEST Default Directory
 N DEFDIR S DEFDIR=$$DEFDIR^%ZISH
 D CHKTF^%ut(DEFDIR["/tmp/"!(DEFDIR["/shm/"),"1")
 S DEFDIR=$$DEFDIR^%ZISH(".")
 D CHKTF^%ut(DEFDIR=$ZD,"2")
 S DEFDIR=$$DEFDIR^%ZISH("/usr/lib")
 D CHKTF^%ut($E(DEFDIR,$L(DEFDIR))="/","3")
 N OLDD S OLDD=$ZD
 S $ZD="/usr/"
 S DEFDIR=$$DEFDIR^%ZISH("./lib")
 D CHKTF^%ut(DEFDIR="/usr/lib/","4")
 S $ZD=OLDD
 D
 . N $ET,$ES S $ET="S $EC="""" D SUCCEED^%ut,UNWIND^%ZTER"
 . S DEFDIR=$$DEFDIR^%ZISH("/LKJASDLJ/ASLKDAIOUWRE/ASLK")
 QUIT
 ;
LIST ; @TEST LIST^%ZISH
 N PATH S PATH="/usr/include"
 N %ARR S %ARR("std*")=""
 N %RET
 N % S %=$$LIST^%ZISH(PATH,$NA(%ARR),$NA(%RET))
 N CNT,I
 S CNT=0,I=""
 F  S I=$O(%RET(I)) Q:I=""  S CNT=CNT+1
 D CHKTF^%ut(CNT'<3,1)
 D CHKTF^%ut(%,2)
 ;
 N PATH S PATH="/dsdfsadf/klasjdfasdf"
 N %ARR S %ARR("*")=""
 N %RET
 N % S %=$$LIST^%ZISH(PATH,$NA(%ARR),$NA(%RET))
 D CHKTF^%ut('%,3)
 ;
 I $ZPARSE("$vista_home/r/")="" QUIT
 N %ARR S %ARR("*")=""
 N %RET
 N % S %=$$LIST^%ZISH("$vista_home/r/",$NA(%ARR),$NA(%RET))
 N CNT,I
 S CNT=0,I=""
 F  S I=$O(%RET(I)) Q:I=""  S CNT=CNT+1
 D CHKTF^%ut(CNT>20000,4)
 D CHKTF^%ut(%,5)
 QUIT
 ;
MV ; @TEST MV^%ZISH
 N POP
 D OPEN^%ZISH(,,"test_for_sam2.txt","W")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 U IO
 W "LINE1",!
 W "LINE2",!
 D CLOSE^%ZISH
 N % S %=$$MV^%ZISH(,"test_for_sam2.txt",,"test_for_sam3.txt")
 D OPEN^%ZISH(,,"test_for_sam3.txt","R")
 I POP D FAIL^%ut("Couldn't open file") QUIT
 E  D SUCCEED^%ut
 D CLOSE^%ZISH
 D OPEN^%ZISH(,,"test_for_sam2.txt","R")
 D CHKTF^%ut(POP)
 QUIT
 ;
FTGGTF ; @TEST $$FTG^%ZISH & $$GTF^%ZISH
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/usr/include","stdlib.h",$NA(^TMP($J,1,0)),2,"VVV")
 N LASTLINE S LASTLINE=$O(^TMP($J," "),-1)
 D CHKTF^%ut(LASTLINE>50,1)
 K ^TMP($J)
 N I F I=1:1:20 S $P(^TMP($J,I,0),"=",300)="="
 N % S %=$$GTF^%ZISH($NA(^TMP($J,1,0)),2,"/tmp/","test_long_records.glo")
 D CHKTF^%ut(%,2)
 D CHKTF^%ut($$RETURN^%ZOSV("stat /tmp/test_long_records.glo",1)=0,3)
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/tmp/","test_long_records.glo",$NA(^TMP($J,1,0)),2,"VVV")
 N LASTLINE S LASTLINE=$O(^TMP($J," "),-1)
 D CHKTF^%ut(LASTLINE=20,4)
 N VVV S VVV=0
 N I F I=0:0 S I=$O(^TMP($J,I)) Q:'I  I $D(^(I,"VVV")) S VVV=1
 D CHKTF^%ut(VVV=0,5)
 ;
 ; Test maximum length
 N MAX S MAX=$$MAXREC^%ZISH($NA(^TMP($J,1,0)))
 N A,B,C
 S $P(A,"=",MAX+20)="="
 S $P(B,"=",MAX+20)="="
 S $P(C,"=",MAX+20)="="
 D OPEN^%ZISH(,"/tmp/","test_overflow_records.glo","W")
 U IO W A,!,B,!,C,!
 D CLOSE^%ZISH()
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/tmp/","test_overflow_records.glo",$NA(^TMP($J,1,0)),2,"VVV")
 N VVV S VVV=0
 N I F I=0:0 S I=$O(^TMP($J,I)) Q:'I  I $D(^(I,"VVV")) S VVV=1
 D CHKTF^%ut(VVV=1,6)
 QUIT
 ;
GATF ; @TEST
 N % S %=$$GATF^%ZISH($NA(^VA(200,1,0)),2,"/tmp/","test_append_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$GATF^%ZISH($NA(^DIC(5,1,0)),2,"/tmp/","test_append_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$GATF^%ZISH($NA(^DIC(4,1,0)),2,"/tmp/","test_append_records.glo")
 D CHKTF^%ut(%=1)
 N VA200,DIC5,DIC4
 S (VA200,DIC5,DIC4)=0
 K ^TMP($J)
 N % S %=$$FTG^%ZISH("/tmp/","test_append_records.glo",$NA(^TMP($J,1,0)),2)
 N I,Z F I=0:0 S I=$O(^TMP($J,I)) Q:'I  S Z=^(I,0) D
 . I Z["TASKMAN" S VA200=1 ; Taskman User
 . I Z["DOCTOR" S VA200=1  ; ditto, WV
 . I Z["CANADA" S DIC5=1   ; State File
 . I Z["VISN" S DIC4=1     ; Institution File
 . I Z["GALLUP" S DIC4=1   ; Ditto, for RPMS
 D CHKTF^%ut(VA200=1)
 D CHKTF^%ut(DIC5=1)
 D CHKTF^%ut(DIC4=1)
 QUIT
 ;
DEL1 ; @TEST
 ; Diabetes.pnl.zip
 ; test_append_records.glo
 ; test_for_sam3.txt
 ; test_long_records.glo
 ; test_overflow_records.glo
 ; test.sam
 N % S %=$$DEL1^%ZISH("/tmp/Diabetes.pnl.zip")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_append_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_for_sam3.txt")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_long_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$DEL1^%ZISH("/tmp/test_overflow_records.glo")
 D CHKTF^%ut(%=1)
 N % S %=$$RETURN^%ZOSV("stat /tmp/test_overflow_records.glo",1)
 D CHKTF^%ut(%'=0)
 QUIT
 ;
DEL ; @TEST Delete files we created in the tests
 I $$VERSION^%ZOSV(0)<6.1 QUIT  ; $ZCLOSE
 ;
 N DELARRAY
 S DELARRAY("test-for-sam.txt")=""
 ;
 N SUB S SUB=$O(^DVB(396.18,1,3,0))
 N FNNODE S FNNODE=^DVB(396.18,1,3,SUB,0)
 N FN S FN=$P(FNNODE," ",3)
 S DELARRAY(FN)=""
 ;
 N DIR S DIR=$$DEFDIR^%ZISH()
 ;
 N FULLPATH
 S FULLPATH=DIR_"test-for-sam.txt"
 N STATCMD S STATCMD="stat -t "
 I $$VERSION^%ZOSV(1)["Darwin" S STATCMD="stat -q "
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%=0,1)
 S FULLPATH=DIR_FN
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%=0,2)
 N % S %=$$DEL^%ZISH(DIR,$NA(DELARRAY))
 D CHKTF^%ut(%=1,2.5)
 S FULLPATH=DIR_"test-for-sam.txt"
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%'=0,3)
 S FULLPATH=DIR_FN
 N % S %=$$RETURN^%ZOSV(STATCMD_FULLPATH,1)
 D CHKTF^%ut(%'=0,4)
 QUIT
 ;
DELERR ; @TEST Delete Error
 D
 . N $ET,$ES
 . D DELERR^%ZISH
 D SUCCEED^%ut
 QUIT
 ;
BROKER ; @TEST Test the new GT.M MTL Broker
 ; Old version died after first connection.
 ; NB: It DOES NOT WANT anything that's not IPv4.
 ; Hard to do on any modern computer that is hardwired to give you IPv6
 ; addressed for localhost.
 N PORT S PORT=58738
 ; ZEXCEPT: ZISTCP,XWBTCPM1
 J ZISTCP^XWBTCPM1(58738)
 N BROKERJOB S BROKERJOB=$ZJOB
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$TEST^XWBTCPMT("127.0.0.1",PORT)
 D CHKEQ^%ut(+%,1)
 N % S %=$$RETURN^%ZOSV("$gtm_dist/mupip stop "_BROKERJOB)
 H .05 ; It doesn't die right away...
 D CHKTF^%ut('$ZGETJPI(BROKERJOB,"ISPROCALIVE"))
 W ! ; reset $X
 QUIT
 ;
XUSHSH ; @TEST Top of XUSHSH
 N X S X="TEST"
 D ^XUSHSH
 D CHKTF^%ut(X="TEST")
 QUIT
 ;
SHA ; @TEST SHA-1 and SHA-256 in Hex and Base64
 D CHKEQ^%ut($$SHAHASH^XUSHSH(160,"test"),"A94A8FE5CCB19BA61C4C0873D391E987982FBBD3")
 D CHKEQ^%ut($$SHAHASH^XUSHSH(160,"test","H"),"A94A8FE5CCB19BA61C4C0873D391E987982FBBD3")
 D CHKEQ^%ut($$SHAHASH^XUSHSH(160,"test","B"),"qUqP5cyxm6YcTAhz05Hph5gvu9M=")
 D CHKEQ^%ut($$SHAHASH^XUSHSH(256,"test"),"9F86D081884C7D659A2FEAA0C55AD015A3BF4F1B2B0B822CD15D6C15B0F00A08")
 QUIT
 ;
BASE64 ; @TEST Base 64 Encode and Decode
 D CHKEQ^%ut($$B64ENCD^XUSHSH("test"),"dGVzdA==")
 D CHKEQ^%ut($$B64DECD^XUSHSH("dGVzdA=="),"test")
 QUIT
 ;
RSAENC ; @TEST Test RSA Encryption
 N SECRET S SECRET="Alice and Bob had Sex!"
 ;
 ; Create RSA certificate and private key w/ no password
 N %CMD
 S %CMD="openssl req -x509 -nodes -days 365 -sha256 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -newkey rsa:2048 -keyout /tmp/mycert.key -out /tmp/mycert.pem"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,"/tmp/mycert.pem")
 D CHKTF^%ut($ZL(CIPHERTEXT)>$ZL(SECRET))
 N DECRYPTION S DECRYPTION=$$RSADECR^XUSHSH(CIPHERTEXT,"/tmp/mycert.key")
 D CHKEQ^%ut(SECRET,DECRYPTION)
 ;
 ; Create RSA certificate and private key with a password
 ; Apparently, no way to do all of this in a single line in openssl; have to do
 ; it the traditional way: key, CSR, Cert.
 ; VEN/SMH - For some reason, the darwin command doesn't create the
 ; certificate when running from inside GT.M; it does okay in Bash.
 ; So, for now, let's just disable this check on Darwin; I don't have time
 ; for this shit.
 I $$VERSION^%ZOSV(1)["Darwin" QUIT
 I $$VERSION^%ZOSV(1)["CYGWIN" QUIT
 ;
 N %CMD
 S %CMD="openssl genrsa -aes128 -passout pass:monkey1234 -out /tmp/mycert.key 2048"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -new -key /tmp/mycert.key -passin pass:monkey1234 -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -out /tmp/mycert.csr"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 ;I $$VERSION^%ZOSV["arwin" S %CMD="openssl req -x509 -days 365 -sha256 -in /tmp/mycert.csr -subj '/C=US/ST=Washington/L=Seattle/CN=www.smh101.com' -key /tmp/mycert.key -passin pass:monkey1234 -out /tmp/mycert.pem"
 N % S %=$$RETURN^%ZOSV(%CMD,1)
 D CHKTF^%ut(%=0)
 N CIPHERTEXT S CIPHERTEXT=$$RSAENCR^XUSHSH(SECRET,"/tmp/mycert.pem")
 D CHKTF^%ut($ZL(CIPHERTEXT)>$ZL(SECRET))
 N DECRYPTION S DECRYPTION=$$RSADECR^XUSHSH(CIPHERTEXT,"/tmp/mycert.key","monkey1234")
 D CHKEQ^%ut(SECRET,DECRYPTION)
 QUIT
 ;
AESENC ; @TEST Test AES Encryption
 N SECRET S SECRET="Alice and Bob had Sex!"
 N X S X=$$AESENCR^XUSHSH(SECRET,"ABCDABCDABCDABCD","DCBADCBADCBADCBA")
 N Y S Y=$$AESDECR^XUSHSH(X,"ABCDABCDABCDABCD","DCBADCBADCBADCBA")
 D CHKEQ^%ut(SECRET,Y)
 QUIT
 ;
ZSY ; @TEST Run System Status
 ; ZEXCEPT: in,out,err
 N IOP S IOP="NULL" D ^%ZIS U IO
 D ^ZSY
 N %utAnswer s %utAnswer=2
 D QUERY^ZSY
 N nProcs s nProcs=$$UNIXLSOF^ZSY()
 D HALTALL^ZSY ; Kill all other processes
 N nProcsAfter S nProcsAfter=$$UNIXLSOF^ZSY()
 D CHKTF^%ut(nProcs>nProcsAfter)
 D CHKTF^%ut(nProcsAfter=1)
 D ^ZTMB ; bring it back up.
 D IMAGE^ZSY
 D LW^ZSY
 D ERR^ZSY
 D UERR^ZSY
 D SUCCEED^%ut
 D ^%ZISC
 QUIT
 ;
XTROU ;;
 ;;ZZUTZOSV2
