ZXPLIST;BIZ/WPB - LIST OF KIDS BUILD READY FOR INSTALL
 ;;8.0;KERNEL;**;AUG 15, 2013;Build 17
 ; Utility to pull a list of KIDS files from a specific directory and then call the 
 ; KIDS utility (modified) to load the KIDS build into VistA
 ;
 Q
EN  ; get the list
 N PATH,PATH1,CNT,INFLAG
 ;R !,"ENTER THE PATH: ",PATH:DTIME
 ;R !,"ENTER BACKUP PATH: ",PATH1:DTIME
 D KDIR
 S DIR("A")="Enter KIDS File Path ",DIR(0)="F" D ^DIR
 S PATH=$G(Y)
 G:$G(PATH)=""!($G(PATH)["^") EXIT
 D KDIR
 S DIR("A")="Enter Path for backup Path ",DIR(0)="F" D ^DIR
 S PATH1=$G(Y)
 G:$G(PATH1)=""!($G(PATH1)["^") EXIT
 D KDIR
 S CNT=1,INFLAG=0
 ;S:$G(PATH)="" PATH="D:\VistA\2016\JUN\KIDS\"
 ;S:$G(PATH1)="" PATH1="D:\VISTA\INSTALLED\JUN\",CNT=1,INFLAG=0 ;D:\VistA\Patches\September
 ;S PATH="C:\Vista\NDF\",PATH1="C:\Vista\INSTALLED\",CNT=80,INFLAG=0
 Q:$G(PATH)=""
 Q:$G(PATH)["^"
 Q:$G(PATH1)=""
 Q:$G(PATH1)["^"
 K FILESPEC,KIDSFILES
 S FILESPEC("*.KI*")=""
 S FILESPEC("*.ki*")=""
 S Y=$$LIST^%ZISH(PATH,"FILESPEC","KIDSFILES") ; get a list of all the files that have an extension of KI* and ki* store the list in the KIDSFILES array
 ;W !,Y
 ;loop thru the KIDSFILES array for the filename
 I Y=1 S XX="" F  S XX=$O(KIDSFILES(XX)) Q:XX=""  Q:$G(NEXT)="0"!($G(NEXT)["^")  D
 . Q:$G(NEXT)["^"!($G(NEXT)="0")
 . W !,XX
 . S KIDFILE=PATH_XX
 . S KFILE=XX
 . ;W !,"IMPORTING FILE "_$G(KIDFILE)
 . ;K TEXT S TEXT="IMPORTING FILE "_$G(KIDFILE)
 . ;S DIC(0)="
 . D EN1^ZXPDIL ; loads the KIDS file into the transport global
 . ;W !,"INFLAG= ",INFLAG
 . W:$G(INFLAG)=1 $G(KIDFILE)_" has been imported."
 . I INFLAG=1 S Y=$$MV^%ZISH(PATH,KFILE,PATH1,KFILE),CNT=CNT+1 ;moves the KIDS file to a backup directory specified by the user if the file was successfully imported
 . W:Y=1 KFILE," FILE MOVED" W:Y=0 "FILE NOT MOVED"
 . ;R !,"NEXT ",NEXT:DTIME Q:NEXT="^"  ;Change to use dir call
 . D KDIR
 . S DIR("A")="Load Next KIDS Build ",DIR(0)="Y",DIR("B")="Y" D ^DIR S NEXT=$G(Y) ;prompts the user to load the next file. Before loading the next file the user can open a new
 . ;session window and use the KIDS Options under the Install Menu to do a compare checksums, backup, comparison and then install the KIDS patch
 .;W !,$G(PATCHNUM)
 .;I $G(PATCHNUM)'="" D EN^ZXPDIB
 .;R !,"NEXT ",NEXT:DTIME Q:NEXT="^"
 .G:$G(NEXT)="^"!($G(NEXT)["^")!($G(NEXT)="0") EXIT
 K PATH,PATH1
 Q
EXIT
 K X,Y,DIR(0),DIR("A"),DIR("?"),DIRUT,XMNUM,XUBDNAME,XUCOM,XDIR,START,END,FLAG,STOP,DIR("B")
 Q
KDIR
 K X,Y,DIR(0),DIR("A"),DIR("?"),DIRUT,DIR("B")
 Q
