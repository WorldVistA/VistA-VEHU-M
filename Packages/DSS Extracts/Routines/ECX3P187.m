ECX3P187 ;ALB/CMD - DSS FY2024 Post-init ;Feb 03, 2023@17:24:42
 ;;3.0;DSS EXTRACTS;**187**;Dec 22,1997;Build 163
 ;
 ; Reference to MES^XPDUTL in ICR #10141
 ;
POST ;Post-install items
 D TEST
 Q
 ;
TEST ;turn-on fld #73 in file #728 for Field Test Site;
 ;allows use of option ECX FISCAL YEAR EXTRACT by test sites;
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Providing special menu option access for DSS FY Conversion test sites.")
 D TESTON^ECXTREX(XPDNM,"FY2024")
 D MES^XPDUTL(" ")
 ;if this is the national released version, then fld #73 will be turned-off
 ;the first time any user attempts to use ECX FISCAL YEAR EXTRACT option
 Q
