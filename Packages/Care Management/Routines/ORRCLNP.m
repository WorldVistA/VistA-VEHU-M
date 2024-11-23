ORRCLNP ; SLC/JER - Person functions for CM ;Oct 27, 2023@12:14:13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**535**;Dec 17, 1997;Build 20
 ;Reference to ^XUSEC("PROVIDER" in ICR #10076
 ;Reference to $$GET1^DIQ in ICR #2056
 ;Reference to $$ISA^USRLM in ICR #1544
 ;Reference to $$NETNAME^XMXUTIL in ICR #2734
 ;Reference to $$PROD^XUPROD in ICR #4440
 ;Reference to $$NAME^XUSER in ICR #2343
 ;
EMAIL(USER) ; e-mail address
 Q $$NETNAME^XMXUTIL(USER)
NAME(USER) ; Person Name
 Q $$NAME^XUSER(USER)
SSNL4(USER) ; SSN Last4
 N ORRCY
 S ORRCY=$$GET1^DIQ(200,USER,9)
 Q $S(+ORRCY:$E(ORRCY,6,10),1:ORRCY)
SEX(USER) ; Person SEX
 Q $$GET1^DIQ(200,USER,4,"I")
PROVIDER(USER) ; Boolean fn: is user a provider
 Q $S(+$D(^XUSEC("PROVIDER",USER)):1,+$$ISA^USRLM(USER,"PROVIDER"):1,1:0)
 ;
SYS(PROD) ;RPC to determine if current system is PROD or TEST
 ; **Requires XU*8.0*284
 ;
 ; Input: NONE
 ; Output: returned in PROD
 ;      1 if production system
 ;      0 if not production system
 ;
 S PROD=+$$PROD^XUPROD
 Q
