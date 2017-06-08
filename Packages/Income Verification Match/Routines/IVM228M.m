IVM228M ;ALB/RTK IVM*2*28 MT Xref Cleanup to Mailman Msg ; 08/30/00
 ;;2.0;INCOME VERIFICATION MATCH;**28**; 21-OCT-94
 ;
 ; This routine will be run as part of the MT Xref Cleanup in
 ; patch IVM*2*28.
 ;
 ; A mail message will be sent to the user when the cleanup process
 ; is complete.
 ;
 ;
MAIL ; Send a mailman msg to user with results
 N DIFROM,%
 N DATA,DATA1,FILE,FLD,IENX,NODE,TEXT,I,X,XMDUZ,XMSUB,XMTEXT,XMY,Y,STA
 K ^TMP("IVM228",$J)
 S XMSUB="Means Test Cross Reference Cleanup"
 S XMDUZ="IVM Cleanup Package",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="^TMP(""IVM228"",$J,"
 D NOW^%DTC S Y=% D DD^%DT
 S ^TMP("IVM228",$J,1)="Means Test Cross Reference Cleanup"
 S ^TMP("IVM228",$J,2)="  "
 S TEXT="Recs Scanned"
 S TEXT=$$BLDSTR("# of IVM MT Fixed",TEXT,20,18)
 S ^TMP("IVM228",$J,3)=TEXT
 S ^TMP("IVM228",$J,4)=$$REPEAT^XLFSTR("=",$L(TEXT))
 S NODE=4
 S DATA=^XTMP("DG-MTFIX",1)
 S TEXT=^XTMP("DG-MTRECS",1)
 S TEXT=$$BLDSTR(DATA,TEXT,20,$L(DATA))
 S NODE=NODE+1
 S ^TMP("IVM228",$J,NODE)=TEXT
 F I=1:1:2 S NODE=NODE+1,^TMP("IVM228",$J,NODE)=" "
 ;
 ; add error reports to the mail message
 I $O(^XTMP("DG-MTERR",0))'="" D
 .S NODE=NODE+1
 .S ^TMP("IVM228",$J,NODE)="Some records were not edited due to filing errors:"
 .S NODE=NODE+1
 .S ^TMP("IVM228",$J,NODE)=" "
 .S TEXT="File #"
 .S TEXT=$$BLDSTR("Record #",TEXT,12,8)
 .S TEXT=$$BLDSTR("Node",TEXT,22,9)
 .S TEXT=$$BLDSTR("Error Message",TEXT,32,13)
 .S NODE=NODE+1
 .S ^TMP("IVM228",$J,NODE)=TEXT
 .S FILE=""
 .F  S FILE=$O(^XTMP("DG-MTERR",FILE)) Q:FILE=""  D
 ..S TEXT=FILE
 ..S IENX=""
 ..F  S IENX=$O(^XTMP("DG-MTERR",FILE,IENX)) Q:IENX=""  D
 ...S FLD=""
 ...F  S FLD=$O(^XTMP("DG-MTERR",FILE,IENX,FLD)) Q:FLD=""  D
 ....S DATA=^XTMP("DG-MTERR",FILE,IENX,FLD)
 ....S TEXT=$$BLDSTR(IENX,TEXT,12,$L(IENX))
 ....S TEXT=$$BLDSTR(FLD,TEXT,22,$L(FLD))
 ....S TEXT=$$BLDSTR(DATA,TEXT,32,$L(DATA))
 ....S NODE=NODE+1
 ....S ^TMP("IVM228",$J,NODE)=TEXT
 ;
MAIL1 D ^XMD
 K ^TMP("IVM228",$J)
 Q
 ;
BLDSTR(NSTR,STR,COL,NSL) ; build a string
 ; Input:
 ;   NSTR = a string to be added to STR
 ;   STR  = an existing string to which NSTR will be added
 ;   COL  = column location at which NSTR will be added to STR
 ;   NSL  = length of new string
 ; Output:
 ;   returns STR with NSTR appended at the specified COL
 ;
 Q $E(STR_$J("",COL-1),1,COL-1)_$E(NSTR_$J("",NSL),1,NSL)_$E(STR,COL+NSL,999)
