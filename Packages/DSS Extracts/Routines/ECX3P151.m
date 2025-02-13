ECX3P151 ;ALB/DE - ECX*3.0*151 Post-Init Rtn
 ;;3.0;DSS EXTRACTS;**151**;Dec 22,1997;Build 2
 ;
 ;Post-init routine adding new entries to:
 ;LOINC Code(#727.29) file
 ;
 Q
 ;
POST ;Entry point
 ;Add new LOINC Codes
 D ADDLNC
 Q
 ;
ADDLNC ;Add LOINC Codes
 N ECXLINE,ECXSTR,ECXCNT
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" Adding entries to DSS LOINC (#727.29) File...")
 D MES^XPDUTL(" ")
 S ECXCNT=0
 N DIC,DIE,DA,DLAYGO,DR,X,Y,ECXDN,ECXDTN,ECXLN,ECXDRU
 S DIC="^ECX(727.29,",DIC(0)="L",DLAYGO=727.29
 F ECXLINE=1:1 S ECXSTR=$P($T(ALOINC+ECXLINE),";;",2) Q:ECXSTR="EXIT"  D
 . S X=$P(ECXSTR,"^",1)
 . D ^DIC I Y<0 D  Q
 .. D BMES^XPDUTL("*****")
 .. D MES^XPDUTL("Unsuccessful entry of LOINC Code - "_X_".")
 .. D MES^XPDUTL("******")
 . S ECXCNT=ECXCNT+1
 . S ECXDN=$P(ECXSTR,"^",2)
 . S ECXDTN=$P(ECXSTR,"^",3)
 . S ECXDRU=$P(ECXSTR,"^",4)
 . S ECXLN=$P(ECXSTR,"^",5)
 . S DA=+Y,DR=".02///"_ECXDN_";.03///"_ECXDTN_";.04///"_ECXDRU_";.05///"_ECXLN
 . S DIE=DIC D ^DIE
 . D BMES^XPDUTL(">>>...Code "_$P(ECXSTR,"^")_" added to the file.")
 K DA,DIC,DIE,DLAYGO,X,Y
 S DIK="^ECX(727.29,",DIK(1)=".02^AC" D ENALL^DIK
 K DIK
 Q
 ;
ALOINC ;LOINC CODE^LAR TEST #^DSS TEST NAME^REPORTING UNITS^LOINC NAME 
 ;;39008-8^0034^Hepatitis C Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HCV Ab Fld Ql IB
 ;;51657-5^0034^Hepatitis C Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HCV Ab Fld Ql
 ;;72376-7^0034^Hepatitis C Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HCV Ab SerPlBld Ql EIA.rapid
 ;;22356-0^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ab Ser-aCnc
 ;;22357-8^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1+2 Ab Ser-aCnc
 ;;35438-1^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ab Sal EIA-aCnc
 ;;41143-9^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ab Sal-aCnc
 ;;43599-0^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ab Ser IF-aCnc
 ;;48345-3^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV 1+O+2 Ab SerPl Ql
 ;;48346-1^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV 1+O+2 Ab SerPl-aCnc
 ;;49483-1^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ser EIA-Imp
 ;;5220-9^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ab Ser EIA-aCnc
 ;;5223-3^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1+2 Ab Ser EIA-aCnc
 ;;57975-5^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV 1+O+2 Ab Fld Ql
 ;;68961-2^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1 Ab SerPlBld Ql EIA.rapid
 ;;69668-2^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV 1 & 2 Ab SerPl EIA.rapid
 ;;73905-2^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1+2 IgG SerPl Ql EIA.rapid
 ;;73906-0^0035^HIV Screening Antibody^NEG-POS OR NONREACTIVE-REACTIVE^HIV1+2 IgG Bld Ql EIA.rapid
 ;;47359-5^0038^HIV Viral Load^COPIES/ML^HIV1 RNA SerPl Donr Ql Amp Prb
 ;;62469-2^0038^HIV Viral Load^COPIES/ML^HIV1 RNA SerPl PCR-aCnc
 ;;70241-5^0038^HIV Viral Load^COPIES/ML^HIV1 RNA # Plas PCR DL=20
 ;;51913-2^0041^Hepatitis A AB^NEG-POS^HAV IgG+IgM Ser Ql
 ;;22315-6^0042^Hepatitis A IgM AB^NEG-POS^HAV IgM Ser-aCnc
 ;;5182-1^0042^Hepatitis A IgM AB^NEG-POS^HAV IgM Ser RIA-aCnc
 ;;5179-7^0043^Hepatitis A IgG AB^NEG-POS^HAV IgG Ser EIA-aCnc
 ;;5180-5^0043^Hepatitis A IgG AB^NEG-POS^HAV IgG Ser RIA-aCnc
 ;;39005-4^0046^Hepatitis B Core AB^NEG-POS OR NONREACTIVE-REACTIVE^HBV core Ab Fld Ql
 ;;31845-1^0047^Hepatitis B e AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV e Ag Ser-aCnc
 ;;39007-0^0047^Hepatitis B e AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV e Ag XXX Ql
 ;;5191-2^0047^Hepatitis B e AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV e Ag Ser EIA-aCnc
 ;;58452-4^0081^Hepatitis B Surface AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV surface Ag Ser-aCnc
 ;;63557-3^0081^Hepatitis B Surface AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV surface Ag SerPl EIA-aCnc
 ;;65633-0^0081^Hepatitis B Surface AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV surface Ag SerPl Ql Cfm
 ;;70154-0^0081^Hepatitis B Surface AG^NEG-POS OR NONREACTIVE-REACTIVE^HBV surface Ag SerPl Cfm-%
 ;;39006-2^0084^Hepatitis B e AB^NEG-POS OR NONREACTIVE-REACTIVE^HBV e Ab Fld Ql
 ;;48575-5^0088^Hepatitis C Genotype^TEXT^HCV Gentyp XXX PCR
 ;;EXIT
 Q
