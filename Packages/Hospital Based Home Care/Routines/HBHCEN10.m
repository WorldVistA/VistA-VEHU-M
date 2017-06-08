HBHCEN10 ; LR VAMC(IRMS)/MJT-Enviroment Check for Patch HBH*1*10 ;9804
 ;;1.0;HOSPITAL BASED HOME CARE;**10**;NOV 01, 1993
 I +$$PATCH^XPDUTL("SD*5.3*131")=0 D BMES^XPDUTL("Please install SD*5.3*131. Installation Halted.") S XPDABORT=2
 I +$$PATCH^XPDUTL("HBH*1.0*9")=0 D BMES^XPDUTL("Please install HBH*1.0*9. Installation Halted.") S XPDABORT=2
 Q
