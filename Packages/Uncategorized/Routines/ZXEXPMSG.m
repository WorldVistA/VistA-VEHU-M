ZXEXPMSG ;BIZ/WPB - Utitlity to export a PackMan to KIDS File
 ;;1.0;BIZ PATCHING;;jUN 27, 2106;Build 17
 ;This routine has two callable APIs:
 ; 1. EXPDATA - This API exports the contents of a PM KIDS build into a designated KIDS file
 ; 2. MSGNUM - This API allows the user to enter a range of message numbers to export. This API calls the EXPDATA line tag
 ;             to actually export the KIDS file. Since this API actually has to read each message between the start and end
 ;             IENs, a check is made for the message to have a line that has "Packman Mail Message:". This indicates that this
 ;             is a PM message containg a KIDS build. 
 ;    
 Q
EXPDATA ; 
 N PROG S PROG=$S($G(FLAG)=1:"FLAG1^ZXEXPMSG",$G(FLAG)=0:"FLAG0^ZXEXPMSG",1:"EXIT")
 D @PROG
 Q
FLAG1 ; multiple message export
 S ERR=0
 S START=$$KDIR(5)  Q:$G(START)=""!($G(START)=0)!($G(START)["^")
 S END=$$KDIR(6)  Q:$G(END)=""!($G(END)=0)!($G(END)["^")
 S XDIR=$$KDIR(4) Q:$G(XDIR)=""!($G(XDIR)=0)!($G(XDIR)["^")
 S XDIRTXT=$$KDIR(7)  Q:$G(XDIRTXT)=""!($G(XDIRTXT)=0)!($G(XDIRTXT)["^")
 I $G(START)'>0 S ERR=1
 I $G(END)'>0 S ERR=2
 I $G(XDIR)="" S ERR=3
 I $G(START)>$G(END) S ERR=4 W !,"ERR- ",ERR
 I $G(XDIRTXT)="" S ERR=8
 D:$G(ERR)>0 EDIR(ERR)
 D:$G(ERR)=0 MSGNUM(START,END,XDIR,$G(FLAG))
 G EXIT
 Q
FLAG0 ; Single message export
 S XMNUM=0,ERR=0
 S XMNUM=$$KDIR(1) Q:$G(XMNUM)=""!($G(XMNUM)=0)!($G(XMNUM)["^")
 S XUBDNAME=$$KDIR(2) Q:$G(XUBDNAME)=""!($G(XUBDNAME)=0)!($G(XUBDNAME)["^")
 S XUCOM=$$KDIR(3) Q:$G(XUCOM)=""!($G(XUCOM)=0)!($G(XUCOM)["^")
 S XDIR=$$KDIR(4) Q:$G(XDIR)=""!($G(XDIR)=0)!($G(XDIR)["^")
 S XDIRTXT=$$KDIR(7) Q:$G(XDIRTXT)=""!($G(XDIRTXT)=0)!($G(XDIRTXT)["^")
 S:$G(XMNUM)'>0 ERR=6 S:$G(XUBDNAME)="" ERR=5 S:$G(XDIR)="" ERR=3 S:$G(XUCOM)="" ERR=7 S:$G(XDIRTXT)="" ERR=8
 D:$G(ERR)>0 EDIR(ERR)
 ;I $G(XMNUM)'>0!($G(XUBDNAME)="")!($G(XUCOM)="")!($G(XDIR)="") D ERROR1
 D:$G(ERR)=0 EXPDATA1(XMNUM,XUBDNAME,XUCOM,XDIR,$G(FLAG))
 G EXIT
EXPDATA1(XMNUM,XUBDNAME,XUCOM,XDIR,FLAG) ; allows
 ; XMNUM =  MESSAGE #
 ; XUBDNAME = HOST FILE name
 ; XUCOM = comment for the build\
 ; XDIR = destination directory to store the KIDS file. Optional, if not present, defaults to the default HFS directory
 ; FLAG = a flag that indicates if this API was called directly or from MSGNUM. If FLAG="" write the notice that the KIDS
 ;        exported or failed and controls the actions if this API is entered from the Option.
 ;
 ; Called from the ZX EXPORT ONE PATCH Option.
 ;
 ;W !,"EXPDATA1"
 N XOBWY,Y,XUF,XU,XUE,XREF
 S:$G(XDIR)="" XDIR=$$DEFDIR^%ZISH  ; defaults to store the KIDS file in the default HFS directory
 S MSG=XMNUM ;W !!,"MSG= ",MSG," XUBDNAME= ",XUBDNAME," XDIRTXT- ",XDIRTXT
 D EXPINST(XMNUM,XDIRTXT)  ;,$TR(XUBDNAME,"KID","TXT")) 
 Q:$$KIDSCHK(MSG)=1
 S R1=0 D CONFIRM
 Q:$G(R1)=1
 K ^TMP($J_"A"),^TMP($J)
 M ^TMP($J_"A")=^XMB(3.9,XMNUM)
 D TRANDATA
 S ^TMP($J,2,1,0)="KIDS Distribution saved on"_$P(^TMP($J_"A",2,1,0),"on",2)
 S ^TMP($J,2,2,0)=$G(XUCOM)
 S ^TMP($J,2,3,0)="**KIDS**:"_$P(^TMP($J_"A",2,XUF,0),"$KID ",2)_"^"
 S ^TMP($J,2,4,0)=""
 S ^TMP($J,2,XUE,0)="**END**"
 S ^TMP($J,2,XUE+1,0)="**END**"
 S XREF="^TMP("_$J_",2,1,0)" W !,"XREF = ",XREF
 S Y=0
 I $G(XREF)'="" D
 . S Y=$$GTF^%ZISH(XREF,3,XDIR,XUBDNAME)  ;Export ^TMP global to a KIDS file
 . W:$G(Y)=1 !!,"KIDS Build ",$G(XUBDNAME)," exported to ",$G(XDIR)
 . W:$G(Y)'=1 !!,"Export Failed"
 . ;D EXPINST(XMNUM,XDIRTXT,$TR(XUBDNAME,"KID","TXT"))
 Q Y
SETDATA ;
 N I,IT
 K ^TMP($J,4)
 F I=1:1:164 S IT=$T(DATA+I)  S ^TMP($J,4,I,0)=$P(IT,";;",2,99)
 Q
TRANDATA ;
 S XU=0
 F  S XU=$O(^TMP($J_"A",2,XU)) Q:XU'>0  Q:$G(^TMP($J_"A",2,XU,0))="**INSTALL NAME**"
 S XUE=5,XUF=XU-1,XU=XUF
 F  S XU=$O(^TMP($J_"A",2,XU)) Q:XU'>0  Q:$G(^TMP($J_"A",2,XU,0))["$END KID"  S ^TMP($J,2,XUE,0)=$G(^TMP($J_"A",2,XU,0)),XUE=XUE+1
 Q
CONFIRM ;
 N X1Q
 S X1=0,R1=0
 F  S X1=$O(^XMB(3.9,MSG,2,X1)) Q:$G(X1)'>0  S:'$D(^XMB(3.9,MSG,6,1,0)) R1=1
 Q:R1=1
 S X1=0,R1=0 F  S X1=$O(^XMB(3.9,MSG,2,X1)) Q:$G(X1)'>0  D
 . Q:R1=3
 . S R1=1
 . S:$G(^XMB(3.9,MSG,2,X1,0))["$K" R1=3
 Q:$G(R1)=1
 S X1=0,R1=0
 F  S X1=$O(^XMB(3.9,MSG,2,X1)) Q:$G(X1)'>0  D
 . S:$G(^XMB(3.9,MSG,2,X1,0))="No routines included" R1=1
 . Q:$G(R1)=1
 . ;S:$G(^XMB(3.9,MSG,2,X1,0))["Informational"&($G(R1)'=3) R1=1
 . S:$G(^XMB(3.9,MSG,2,X1,0))["Packman Mail Message:" R1=3
 K X1
 Q
MSGNUM(START,END,XDIR,FLAG) ; Gets a list of XMB numbers for kids builds from the Message file (#3.9).
 ; To Do: Jun 28, 2016 add code to store a list of all patches encountered and an indicator to show the patch was converted or not converted.
 ; maybe use the list containing the results to create a VistA mail message to the user or to give an on demand report. 
 ; START - Starting Message File number
 ; END - ending message number, if null sets END to current date
 ; XDIR - destination directory for the KIDS files
 ;
 ; Called from the ZX EXPORT A GROUP OF PATCHES Option
 ;
 ;W !,"IN MSGNUM"
 N MSG
 I $G(START)'>0 W !,"START is required!" Q
 I $G(END)="" S END=DT
 I START>END W !,"Start date parameter can't be greater than the search ending date!" Q
 S MSG=START-1 ; START is the input parameter for the search start. in order to include that message in the search
 F  S MSG=$O(^XMB(3.9,MSG)) Q:MSG'>0!(MSG>END)  D
 . ;Q:$P(^XMB(3.9,MSG,0),"^",7)'="K" ; original check, but during testing we found that this was not always set in the PM Patch message
 . Q:$$KIDSCHK(MSG)=1
 . D EXPINST(MSG,XDIRTXT)  ;,$TR(XUBDNAME,"KID","TXT"))
 . S R1=0 D CONFIRM
 . Q:$G(R1)=1
 . S REC=0 F  S REC=$O(^XMB(3.9,MSG,2,REC)) Q:$G(REC)'>0  D
 . . N NM,NM1,NODE,RESP
 . . S NODE=$G(^XMB(3.9,MSG,2,REC,0)) ;w !,NODE
 . . I $G(NODE)["Designation:" D
 . . .S NM=$P(NODE,"Designation:",2),NM1=$TR(NM,"*","_"),NM1=$TR(NM1,".","-"),NM1=$G(MSG)_NM1_".KID",NM1=$TR(NM1," ","")
 . . . ;W !,"PATCH = "_NM1,"  ",MSG
 . . . S RESP=$$EXPDATA1(MSG,NM1,"AUTO PM EXPORT TO KIDS",XDIR,FLAG)
 . . . W !,"PATCH = "_NM1,"  ",MSG,"  ",$S(RESP=1:"Exported successfully",1:"Failed to export")," to: ",XDIR
 K R1,REC
 Q
KIDSCHK(X1) ; Check to see if the message as Packman Mail Message: in the body. if not then this is not a KIDS patch to be installed
 Q:$G(X1)'>0 1
 S STOP=1
 N X2
 S X2=0 F  S X2=$O(^XMB(3.9,X1,2,X2)) Q:$G(X2)'>0  D
 . S:$G(^XMB(3.9,X1,2,X2,0))="Packman Mail Message:" STOP=0
 Q STOP
KDIR(FLG) ; kills DIR variables before and after calling D ^DIR to display prompts
 K DIR(0),DIR("A"),DIR("B"),DIRUT,X,Y,X1,DIRUT,DUOUT,DTOUT,DIROUT
 S X1=0
 S LAST=$P(^XMB(3.9,0),"^",3)
 S DIR(0)=$S("156"[$G(FLG):"N^0:"_$G(LAST),$G(FLG)=7:"F",1:"F")
 Q:FLG'>0
 S DIR("A")=$S($G(FLG)>0:$P($T(MSG+FLG),";",3),1:"")
 S DIR("?")=$S($G(FLG)>0:$P($T(MSG+FLG),";",4),1:"")
 D ^DIR ;W !,"Y= ",Y," X= ",X
 K LAST
 S:$G(Y)'="" X1=Y
 Q Y
EDIR(ERR) ; display error messages
 K DIR(0),DIR("A"),DIR("B"),DIRUT,X,Y
 S DIR(0)="Y",DIR("A")=$S(ERR>0:$P($T(ERRMSG+ERR),";",3),1:""),DIR("A",1)="Do you want to try again",DIR("?")="Enter Yes to enter data again, No to quit"
 D ^DIR
 I $G(DIRUT)=1!($G(DUOUT)=1)!($G(DTOUT)=1)!($G(DIROUT)=1) W !,"SHOULD QUIT" G EXIT
 G:Y=1 EXPDATA
 Q
EXIT ; Exit
 W !,"EXIT"
 K X,Y,DIR(0),DIR("A"),DIR("?"),DIRUT,XMNUM,XUBDNAME,XUCOM,XDIR,START,END,FLAG,STOP,DIR("B")
 Q
MSG ; help text msg
 ;1;Enter the PackMan mail message IEN;This is the IEN for the message in the Message file.
 ;2;Enter KIDS filename;This is the name for the KIDS build.
 ;3;Enter the comment for the KIDS file;This is the comment that is in the KIDS build
 ;4;Enter the fully qualified Path for where you want to store the KIDS file.;This is the directory or folder to store the KIDS file
 ;5;Enter the starting message number IEN;This is the starting IEN for the first PM message to be exported
 ;6;Enter the ending message number IEN;This is the ending IEN for the last PM message to be exported
 ;7;Enter the fully qualified Path for where you want to store the Patch Description;This is the directory or folder to store the text file with the Patch Description
 Q
ERRMSG ; error messages
 ;1;Starting number must be numeric and greater than zero.
 ;2;Ending number must numeric and greater than zero.
 ;3;Ending number must be greater than the starting number.
 ;4;Directory/Path is required in order to write out the KIDs file.
 ;5;File Name is required in order to save the KIDs file.
 ;6;Message number must be greater than zero and not null.
 ;7;Comments must not be null.
 ;8;Directory/Path is required in order to write out the Patch Description.
 Q
EXPINST(XMZ,PATH) ; PRINT THE INSTALL INSTRUCTIONS
 ;XMZ = IEN for the message in the XMB(3.9 file
 ;PATH = The path for the directory to write the file to
 ;FILENAME = The filename for the text file.
 ;
 Q:'$D(^XMB(3.9,XMZ))
 K ^TMP($J,"MSG")
 S XX=1,CNT=1 F  S XX=$O(^XMB(3.9,XMZ,2,XX)) Q:XX'>0  Q:$G(^XMB(3.9,XMZ,2,XX,0))["Packman Mail Message:"  D
 . S:$G(^XMB(3.9,XMZ,2,XX,0))["Designation:" NODE=$G(^XMB(3.9,XMZ,2,XX,0)),NM=$P(NODE,"Designation:",2),NM1=$TR(NM,"*","_"),NM1=$TR(NM1,".","-"),NM1=$G(MSG)_NM1_".TXT",NM1=$TR(NM1," ",""),FILENAME=NM1
 . S ^TMP($J,"MSG",CNT,0)=$G(^XMB(3.9,XMZ,2,XX,0)),CNT=CNT+1
 K XX,CNT
 S XREF="^TMP(MSG,"_$J_",1)"
 S Y=$$GTF^%ZISH($NA(^TMP($J,"MSG",1,0)),3,PATH,FILENAME)
 W:$G(Y)=1 "SUCCESS"_PATH_FILENAME
 W:$G(Y)=0 "FAILED"
 Q
