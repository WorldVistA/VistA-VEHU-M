IBY757PO ;YMG/EDE - IB*2.0*757 POST INSTALL;APR 23 2024
 ;;2.0;Integrated Billing;**757**;21-MAR-94;Build 4
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; entry point
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine for IB*2.0*757")
 D NEWCANC
 D BMES^XPDUTL(" >>  End of the Post-Initialization routine for IB*2.0*757")
 Q
 ;
NEWCANC ; add new cancellation reasons to file 350.3
 N FDA,IBCNNM,IBDATA,IBREAS,IENS,Z
 D MES^XPDUTL("     -> Adding new Cancellation Reasons to file 350.3...")
 F Z=1:1 S IBDATA=$T(REASDAT+Z),IBCNNM=$P(IBDATA,";",3) Q:IBCNNM="END"  D
 .S IBREAS=+$$FIND1^DIC(350.3,,"X",IBCNNM,"B"),IENS=$S(IBREAS>0:IBREAS_",",1:"+1,")
 .S FDA(350.3,IENS,.01)=IBCNNM           ; name
 .S FDA(350.3,IENS,.02)=$P(IBDATA,";",4) ; abbreviation
 .S FDA(350.3,IENS,.03)=$P(IBDATA,";",5) ; limit
 .S FDA(350.3,IENS,.04)=$P(IBDATA,";",6) ; can cancel UC
 .S FDA(350.3,IENS,.05)=$P(IBDATA,";",7) ; UC visit processing
 .S FDA(350.3,IENS,.07)=$P(IBDATA,";",8) ; MH visit processing
 .S FDA(350.3,IENS,.08)=$P(IBDATA,";",9) ; Can cancel MH Visit
 .I IBREAS D FILE^DIE("","FDA")
 .I 'IBREAS D UPDATE^DIE("","FDA")
 .K FDA
 D MES^XPDUTL("        Done.")
 Q
 ;
REASDAT ; New cancellation reasons (350.3)
 ;;FITTING/ADJUSTMENT;F/A;3
 ;;PATIENT NOT SEEN;PNS;3;1;1;1;1
 ;;TEST ACCOUNT;TEST;3;1;1;1;1
 ;;INELIGIBLE;INEL;3;1;1;1;1
 ;;ACTIVE DUTY;AD;3;;;1;1
 ;;CAMP LEJEUNE;CL;3;;;2;1
 ;;VACCINE;VAC;3
 ;;OBSERVATION STAY;OS;3;1;2;2;1
 ;;TELEPHONE ENCOUNTER;TE;3;;;2;1
 ;;END
 Q
