ORY17401 ; Install Package Level Parameters ; May 22, 2003@23:35:05
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**174**;Dec 17, 1997
LOAD ; load data into ^TMP (expects ROOT to be defined)
 S I=1 F  S REF=$T(DATA+I) Q:REF=""  S VAL=$T(DATA+I+1) D
 . S I=I+2,REF=$P(REF,";",3,999),VAL=$P(VAL,";",3,999)
 . S @(ROOT_REF)=VAL
 Q
DATA ; parameter data
 ;;4334,"KEY")
 ;;ORR TEST WP PARAMETERS^1
 ;;4334,"VAL")
 ;;Test Word-Processing
 ;;4334,"VAL",1,0)
 ;;<?xml version="1.0" encoding="UTF-8"?>
 ;;4334,"VAL",2,0)
 ;;<configTree
 ;;4334,"VAL",3,0)
 ;;xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 ;;4334,"VAL",4,0)
 ;;xsi:noNamespaceSchemaLocation="C:\reeng\main\modules\config\src\gov\va\med\hds\config\xml\configTree.xsd">
 ;;4334,"VAL",5,0)
 ;;<pluginParameterCategory>
 ;;4334,"VAL",6,0)
 ;;<id>1</id>
 ;;4334,"VAL",7,0)
 ;;<name>Dashboard</name>
 ;;4334,"VAL",8,0)
 ;;<preferencePage>gov.va.med.hds.dash.DBPrefPage</preferencePage>
 ;;4334,"VAL",9,0)
 ;;<parameters>
 ;;4334,"VAL",10,0)
 ;;<parameter>
 ;;4334,"VAL",11,0)
 ;;<name>Look and Feel</name>
 ;;4334,"VAL",12,0)
 ;;<key>Look and Feel^5000;DIC(4,^201^1</key>
 ;;4334,"VAL",13,0)
 ;;<value>Motif</value>
 ;;4334,"VAL",14,0)
 ;;</parameter>
 ;;4334,"VAL",15,0)
 ;;<parameter>
 ;;4334,"VAL",16,0)
 ;;<name>Selection Mode</name>
 ;;4334,"VAL",17,0)
 ;;<key>Selection Mode^0^4749^1</key>
 ;;4334,"VAL",18,0)
 ;;<value>Table-Navigator-Viewer</value>
 ;;4334,"VAL",19,0)
 ;;</parameter>
 ;;4334,"VAL",20,0)
 ;;<parameter>
 ;;4334,"VAL",21,0)
 ;;<name>Window Mode</name>
 ;;4334,"VAL",22,0)
 ;;<key>Window Mode^0^4750^1</key>
 ;;4334,"VAL",23,0)
 ;;<value>Single Document Interface</value>
 ;;4334,"VAL",24,0)
 ;;</parameter>
 ;;4334,"VAL",25,0)
 ;;</parameters>
 ;;4334,"VAL",26,0)
 ;;<children>
 ;;4334,"VAL",27,0)
 ;;<parameterCategory>
 ;;4334,"VAL",28,0)
 ;;<id>2</id>
 ;;4334,"VAL",29,0)
 ;;<name>Patient Selection</name>
 ;;4334,"VAL",30,0)
 ;;<preferencePage>gov.va.med.hds.dash.PtSelPrefPage</preferencePage>
 ;;4334,"VAL",31,0)
 ;;<parameters>
 ;;4334,"VAL",32,0)
 ;;<parameter>
 ;;4334,"VAL",33,0)
 ;;<name>Patient Selection Mode</name>
 ;;4334,"VAL",34,0)
 ;;<key>Patient Selection Mode^0^4751^1</key>
 ;;4334,"VAL",35,0)
 ;;<value>single click</value>
 ;;4334,"VAL",36,0)
 ;;</parameter>
 ;;4334,"VAL",37,0)
 ;;<parameter>
 ;;4334,"VAL",38,0)
 ;;<name>Default Patient List</name>
 ;;4334,"VAL",39,0)
 ;;<key>Default Patient List^375;DIC(9.4,^4752^1</key>
 ;;4334,"VAL",40,0)
 ;;<value>Patient List A</value>
 ;;4334,"VAL",41,0)
 ;;</parameter>
 ;;4334,"VAL",42,0)
 ;;</parameters>
 ;;4334,"VAL",43,0)
 ;;<children>
 ;;4334,"VAL",44,0)
 ;;</children>
 ;;4334,"VAL",45,0)
 ;;</parameterCategory>
 ;;4334,"VAL",46,0)
 ;;<parameterCategory>
 ;;4334,"VAL",47,0)
 ;;<id>3</id>
 ;;4334,"VAL",48,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",49,0)
 ;;<preferencePage>gov.va.med.hds.dash.LabPrefPage</preferencePage>
 ;;4334,"VAL",50,0)
 ;;<parameters>
 ;;4334,"VAL",51,0)
 ;;<parameter>
 ;;4334,"VAL",52,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",53,0)
 ;;<key>Lab Collection Times^5000;DIC(4,^21^28800</key>
 ;;4334,"VAL",54,0)
 ;;<value>0810</value>
 ;;4334,"VAL",55,0)
 ;;</parameter>
 ;;4334,"VAL",56,0)
 ;;<parameter>
 ;;4334,"VAL",57,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",58,0)
 ;;<key>Lab Collection Times^5000;DIC(4,^21^36000</key>
 ;;4334,"VAL",59,0)
 ;;<value>1030</value>
 ;;4334,"VAL",60,0)
 ;;</parameter>
 ;;4334,"VAL",61,0)
 ;;<parameter>
 ;;4334,"VAL",62,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",63,0)
 ;;<key>Lab Collection Times^5000;DIC(4,^21^39600</key>
 ;;4334,"VAL",64,0)
 ;;<value>1130</value>
 ;;4334,"VAL",65,0)
 ;;</parameter>
 ;;4334,"VAL",66,0)
 ;;<parameter>
 ;;4334,"VAL",67,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",68,0)
 ;;<key>Lab Collection Times^5000;DIC(4,^21^66600</key>
 ;;4334,"VAL",69,0)
 ;;<value>1900</value>
 ;;4334,"VAL",70,0)
 ;;</parameter>
 ;;4334,"VAL",71,0)
 ;;<parameter>
 ;;4334,"VAL",72,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",73,0)
 ;;<key>Lab Collection Times^5000;DIC(4,^21^73800</key>
 ;;4334,"VAL",74,0)
 ;;<value>2100</value>
 ;;4334,"VAL",75,0)
 ;;</parameter>
 ;;4334,"VAL",76,0)
 ;;<parameter>
 ;;4334,"VAL",77,0)
 ;;<name>Lab Collection Times</name>
 ;;4334,"VAL",78,0)
 ;;<key>Lab Collection Times^5000;DIC(4,^21^75000</key>
 ;;4334,"VAL",79,0)
 ;;<value>2350</value>
 ;;4334,"VAL",80,0)
 ;;</parameter>
 ;;4334,"VAL",81,0)
 ;;</parameters>
 ;;4334,"VAL",82,0)
 ;;<children>
 ;;4334,"VAL",83,0)
 ;;</children>
 ;;4334,"VAL",84,0)
 ;;</parameterCategory>
 ;;4334,"VAL",85,0)
 ;;</children>
 ;;4334,"VAL",86,0)
 ;;</pluginParameterCategory>
 ;;4334,"VAL",87,0)
 ;;</configTree>
 ;;4604,"KEY")
 ;;ORR TEST SCALAR PARAMETER^1
 ;;4604,"VAL")
 ;;99
 ;;4710,"KEY")
 ;;ORR PRISM DEFAULT PERSPECTIVE^1
 ;;4710,"VAL")
 ;;clinicianDashboard
 ;;4712,"KEY")
 ;;ORRC NURSE DEFAULT DATE MIN^1
 ;;4712,"VAL")
 ;;T-30
 ;;4713,"KEY")
 ;;ORRC NURSE DEFAULT DATE MAX^1
 ;;4713,"VAL")
 ;;T
 ;;4716,"KEY")
 ;;ORRC NURSE EVENT DATE MAX^1
 ;;4716,"VAL")
 ;;T+180
 ;;4717,"KEY")
 ;;ORRC NURSE EVENT DATE MIN^1
 ;;4717,"VAL")
 ;;T-180
 ;;4837,"KEY")
 ;;ORRC NURSE RESULT DATE MAX^1
 ;;4837,"VAL")
 ;;T
 ;;4838,"KEY")
 ;;ORRC NURSE RESULT DATE MIN^1
 ;;4838,"VAL")
 ;;T-30
 ;;4841,"KEY")
 ;;ORRC NURSE UNVERIFIED DATE MAX^1
 ;;4841,"VAL")
 ;;T
 ;;4842,"KEY")
 ;;ORRC NURSE UNVERIFIED DATE MIN^1
 ;;4842,"VAL")
 ;;T-1
 ;;4843,"KEY")
 ;;ORRC NURSE TEXT ORDER DATE MAX^1
 ;;4843,"VAL")
 ;;T
 ;;4844,"KEY")
 ;;ORRC NURSE TEXT ORDER DATE MIN^1
 ;;4844,"VAL")
 ;;T-365
 ;;4847,"KEY")
 ;;ORRC NURSE VITALS DATE MAX^1
 ;;4847,"VAL")
 ;;T
 ;;4848,"KEY")
 ;;ORRC NURSE VITALS DATE MIN^1
 ;;4848,"VAL")
 ;;T-60
