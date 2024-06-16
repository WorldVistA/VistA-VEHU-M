WV30PST ;SLC/WAS-WV*1*30 POST INSTALLATION ROUTINE; Dec 18,2023@13:41
 ;;1.0;WOMEN'S HEALTH;**30**;Sep 30, 1998;Build 5
 ;
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to CHG^XPAR,GETLST^XPAR in ICR #2263
 ; Reference to ^DIC(9.4 in ICR #10048
 ;
POST ; Main entry point for Post-init items.
 ;
 D BMES^XPDUTL("Post-installation begin...")
 ;
 N PAR S PAR="WV COVER SHEET WEBSITES"
 N WVRETURN D GETLST^XPAR(.WVRETURN,"ALL",PAR,"Q")
 ;
 N INST,WIDX,CURVAL,VAL,PKG,ENT,ERROR,MSG
 S WIDX=0
 F WIDX=1:1:WVRETURN D
 .S INST=$P(WVRETURN(WIDX),U,1)
 .I INST="U. S. MEC for Contraceptive Use" S VAL="https://www.cdc.gov/reproductivehealth/contraception/mmwr/mec/summary.html"
 .I INST="U. S. SPR for Contraceptive Use" S VAL="https://www.cdc.gov/reproductivehealth/contraception/mmwr/spr/summary.html"
 .S CURVAL=$P(WVRETURN(WIDX),U,2)
 .I CURVAL'=VAL D
 ..;
 ..; Update the value using XPAR
 ..;
 ..S PKG=$O(^DIC(9.4,"B","WOMEN'S HEALTH",0))
 ..S ENT=PKG_";DIC(9.4,"
 ..D CHG^XPAR(ENT,PAR,INST,VAL,.ERROR)
 ..I +ERROR S MSG=$P(ERROR,U,2) D BMES^XPDUTL(MSG) Q
 ..;
 ..D BMES^XPDUTL("Successfully updated weblink value for "_INST)
 ..D BMES^XPDUTL("  to "_VAL)
 ..;
 ;
 D BMES^XPDUTL("Post-installation complete...")
 ;
 Q
