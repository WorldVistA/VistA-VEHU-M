ORAMP600 ;SLC/SLP - Post Installation Tasks ;Jul 31, 2023@09:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**600**;Dec 17, 1997;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel (supported)
 ; #2263 - EN^XPAR Kernel (supported)
 ;
 Q
EN ;
 ; Installing commands in the command file...
 D MES^XPDUTL("OR*3.0*600 Post install starting....")
 ;
 D MES^XPDUTL("Updating parameters...")
 ; Update ORAM GUI VERSION with new build number for AntiCoagulate.exe.
 D EN^XPAR("SYS","ORAM GUI VERSION",,"1.0.600.2")
 D MES^XPDUTL("Parameters updated.")
 ;
 D MES^XPDUTL("OR*3.0*600 Post install complete")
 ;
 Q
