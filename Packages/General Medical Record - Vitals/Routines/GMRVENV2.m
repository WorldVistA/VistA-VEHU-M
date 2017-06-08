GMRVENV2 ;CIOFO/NCA - Environment Check Routine For Patch 2
 ;;4.0;Vitals/Measurements;**2**;Apr 25, 1997
 I +$$VERSION^XPDUTL("OR")=2.5 Q
 I +$$PATCH^XPDUTL("OR*3.0*14") Q
 D MES^XPDUTL("You Do Not Have Patch OR*3*14 installed.  You can still install this patch")
 D MES^XPDUTL("BUT you can not convert the two Vital protocols with the")
 D MES^XPDUTL("option Convert Protocols, [ORCM PROTOCOLS].")
 Q
