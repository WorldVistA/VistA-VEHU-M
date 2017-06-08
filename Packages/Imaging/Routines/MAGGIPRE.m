MAGGIPRE ;WOIFO/SRR - Clean out data and setup device ; [ 06/20/2001 08:56 ]
 ;;3.0;IMAGING;;1-Mar-2002
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
EN ; environmental check.
 N MAGVRSN,MAGMSG
 ; XPDENV - =0 (loading process)  =1 (install process)
 I XPDENV=0,$G(DUZ(0))'="@" W !,"Remember to set your DUZ(0)=@ before installing."
 I XPDENV D  Q:$G(XPDABORT)
 . I $G(DUZ(0))'="@" D
 . . S MAGMSG(1)="Your DUZ(0) is not set to an '@'!"
 . . S MAGMSG(2)="Transport global is not deleted."
 . . S MAGMSG(2)="Please setup your Fileman Access code to '@' before installing."
 . . D MES^XPDUTL(.MAGMSG) S XPDABORT=2
 . . Q
 S MAGVRSN=$$VERSION^XPDUTL("IMAGING")
 I '+MAGVRSN S XPDQUIT("IMAGING PREINSTALL 3.0")=1 D MSG Q
 I +MAGVRSN=3 S XPDQUIT("IMAGING PREINSTALL 3.0")=1 D MSG Q
 Q
MSG ;
 S MAGMSG(1)="The install process did not detect a previous version of Imaging."
 S MAGMSG(2)="The transport global for 'Imaging Preinstall 3.0' will be removed."
 D MES^XPDUTL(.MAGMSG)
 Q
 
