MAGGTLNK ; Imaging RPC's to synchronize with other applications. [ 18-AUG-2000 14:47:56 ]
 ;;2.5T11;MAG;;18-Aug-2000
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a Class II medical device.  As such, it may not be changed    |
 ;; | in any way.  Modifications to this software may result in an  |
 ;; | adulterated medical device under 21CFR820, the use of which   |
 ;; | is considered to be a violation of US Federal Statutes.       |
 ;; +---------------------------------------------------------------+
 ;;
 Q
SETLINK(MAGRY,APPLINK) ;RPC Call to Set the node for synchronization with CPRS
 ;  THIS IS OLD Call , kept for backward compatibility
 K ^TMP("MAGGTLNK",$J)
 ;S ^TMP("MAGGTLNK",$J)=APPLINK
 S APPLINK=$TR(APPLINK,"'","""")
 S ^TMP("MAGGTLNK",$J,1)=APPLINK
 S MAGJOB("CPRSLINK")=APPLINK
 S @APPLINK@("MAG")=$G(MAGJOB("MAGLINK"))
 S @MAGJOB("MAGLINK")@("CPRSLINK")=APPLINK
 S MAGRY="1^"
 ;M ^TMP("MAGGTLNK",$J,"MAGJOB")=MAGJOB
 Q
GETLINK(MAGRY) ; RPC Call to Get CPRS current patient from linked CPRS job.
 ;  THIS IS OLD Call , kept for backward compatibility
 ;
 I '$D(@MAGJOB("CPRSLINK")) S MAGRY="0^CPRS Patient is undefined" Q
 S MAGRY=@MAGJOB("CPRSLINK")
 Q
INITLINK(MAGRY,HANDLE) ; RPC Call to Initialize the Global Node to be
 ; used for linking with another Application
 ; HANDLE = MainFormHandle   i.e. 255.255.255.255-89485
 ;  THIS IS OLD Call , kept for backward compatibility
 N IP
 K ^TMP("MAGLINK",$J)
 S IP=$G(IO("IP"),"255.255.255.255")
 S ^TMP("MAGLINK",$J,IP,HANDLE)=""
 S IP=""""_IP_""""
 S HANDLE=""""_HANDLE_""""
 S MAGRY="^TMP(""MAGLINK"","_$J_","_IP_","_HANDLE_")"
 S MAGJOB("MAGLINK")=MAGRY
 ; MAGJOB is array to hold partition variables, 
 ; to be used by other calls from delphi.
 Q
KILLLINK ; Kill the MAGLINK Node. Other applications that are trying
 ; to synchronize with Imaging Patient will know Imaging is closed by
 ; testing for the MAGLINK Node.
 K ^TMP("MAGLINK",$J)
 Q
