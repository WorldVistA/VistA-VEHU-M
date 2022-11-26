ONC2PS15 ;HINES OIFO/RTK - Post-Install Routine for Patch ONC*2.2*15 ;06/27/22
 ;;2.2;ONCOLOGY;**15**;Jul 31, 2013;Build 5
 ;
 N RC
 ;DC production server Patch ##
 ;S RC=$$UPDCSURL^ONCSAPIU("http://10.41.100.27:83/cgi_bin/oncsrv.exe")
 ;DC PRODUCTION SERVER V21
 ;S RC=$$UPDCSURL^ONCSAPIU("http://10.41.100.27:86/cgi_bin/oncsrv.exe")
 ;test server uRL V21
 ;S RC=$$UPDCSURL^ONCSAPIU("http://10.41.100.27:81/cgi_bin/oncsrv.exe")
 Q
