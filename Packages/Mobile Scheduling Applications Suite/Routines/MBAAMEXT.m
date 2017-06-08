MBAAMEXT ;RGI/CBR - EXTERNAL API ; 10 MAR 2014
 ;;1.0;Scheduling Calendar View;****;10 MAR 2014;Build 11
CNSSTAT(IFN) ; Get consult status
 Q $P($G(^GMR(123,IFN,0)),U,12)
 ;
GETMOVDT(IFN) ; Get patient movement
 Q +$G(^DGPM(IFN,0))
 ;
HASMOV(DFN) ; Has movement?
 Q $D(^DGPM("C",DFN))
 ;
LSTSADM(RETURN,DFN,SD,CAN) ; Get scheduled admissions
 N LST,FLDS
 D LSTSADM^MBAAMDA5(.LST,5,.SD,.CAN)
 S FLDS(13)="CANCEL DT",FLDS(2)="DATE"
 D BLDLST^MBAAMAPI(.RETURN,.LST,.FLDS)
 Q 1
 ;
