ORWPAR1 ;SLC/JLC - UTILITIES FOR JSON PARAMETERS ;Jan 29, 2024@13:55
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**608**;Dec 17, 1997;Build 15
 ;
 ; Reference to ^DD supported in ICR #10155
 ;
 Q
SIGI(RESULTS) ; Return Values for SIGI
 N SC,I,A
 S SC=$P(^DD(2,.024,0),"^",3)
 F I=1:1 Q:$P(SC,";",I)=""  S A=$P(SC,";",I),RESULTS("SelfIdentifiedGender",I,"Gender")=$P(A,":",2)
 Q
