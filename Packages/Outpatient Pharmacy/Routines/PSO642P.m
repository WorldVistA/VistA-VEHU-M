PSO642P ;BIR/JLC - VCC BUILD VCC PROXY USER ; July 13, 2021@21:00
 ;;7.0;OUTPATIENT PHARMACY;**642**;DEC 1997;Build 9
 ;
 Q
POST ;;
 N PSOA
 S PSOA=$$CREATE^XUSAP("PSOVCC,APPLICATION PROXY","","PSO VCC REFILL")
 I PSOA>0 D BMES^XPDUTL("Proxy user created successfully.") Q
 I PSOA="0^Name in Use" D BMES^XPDUTL("Proxy user name already in use.")
 Q
