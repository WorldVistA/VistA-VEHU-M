HBHCENV ;Hines CIOFO/NCA - Enviroment Check for Patch HBH*1*9 ;3/20/98
 ;;1.0;HOSPITAL BASED HOME CARE;**9**;NOV 01, 1993
EN1 ;Enviroment check routine
 I +$$PATCH^XPDUTL("HBH*1.0*06")=0 D BMES^XPDUTL("Please install HBH*1.0*06. Installation Halted.") S XPDABORT=2
 I +$$PATCH^XPDUTL("HBH*1.0*08")=0 D BMES^XPDUTL("Please install HBH*1.0*08.  Installation Halted.") S XPDABORT=2
 Q
