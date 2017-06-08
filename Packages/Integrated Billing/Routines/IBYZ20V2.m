IBYZ20V2 ;ALB/CPM - LOCATE/BILL PRESCRIPTIONS (BULLETIN) ; 21-MAR-97
 ;;FOR USE ONLY IN THE VHA CHICAGO HEALTHCARE SYSTEM
 ;
BULL ; Send bulletin confirming job completion.
 S XMSUB="Job Completion - Bill Prescriptions"
 S XMDUZ="INTEGRATED BILLING",XMTEXT="IBT(",XMY(DUZ)=""
 K IBT S IBS="to be "
 ;
 S IBT(1)="The job to bill unbilled prescriptions has just completed."
 S IBT(2)="The job was run for prescriptions filled from "_$$DAT1^IBOUTL(IBBDT)_" through "_$$DAT1^IBOUTL(IBEDT)_"."
 S IBT(3)=" "
 S Y=IBBEXDT D D^DIQ S IBT(4)="                     Job Start Time: "_Y
 S Y=IBEEXDT D D^DIQ S IBT(5)="                       Job End Time: "_Y
 S IBT(6)=" "
 ;
 S IBT(7)="                                                   Job Mode: "_$S(IBMODE="S":"SCAN ONLY",1:"BILL")
 S IBT(8)=" "
 S IBT(9)="                         # of prescriptions/refills checked: "_IBCTA
 S IBT(10)="                 # of prescriptions ignored for SC<50% vets: "_IBCTAS
 S IBT(11)=" "
 S IBT(12)=$S(IBMODE="S":"",1:$J("",6))_"                              # original fills "_$S(IBMODE="S":IBS,1:"")_"billed: "_IBCTBO
 S IBT(13)=$S(IBMODE="S":"",1:$J("",6))_"                                     # refills "_$S(IBMODE="S":IBS,1:"")_"billed: "_IBCTBR
 S IBT(14)=$S(IBMODE="S":"",1:$J("",6))_"# original fills "_$S(IBMODE="S":IBS,1:"")_"set up for billing (rx not released): "_IBCTSO
 S IBT(15)=$S(IBMODE="S":"",1:$J("",6))_"       # refills "_$S(IBMODE="S":IBS,1:"")_"set up for billing (rx not released): "_IBCTSR
 S IBT(16)=" "
 S IBT(17)=$S(IBMODE="S":"",1:$J("",6))_"                                 Total dollars "_$S(IBMODE="S":IBS,1:"")_"billed: $"_$J(IBCTD,0,2)
 ;
 I IBMODE'="S" D
 .S IBT(18)=" "
 .S IBT(19)="  # of prescriptions not billed due to an error encountered: "_IBCTBER
 ;
 D ^XMD
 K IBT,IBS,XMSUB,XMTEXT,XMDUZ,XMY,Y
 Q
