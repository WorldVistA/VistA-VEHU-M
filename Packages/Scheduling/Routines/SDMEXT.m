SDMEXT ;RGI/CBR - EXTERNAL API; 10/18/2012
 ;;5.3;scheduling;**260003**;08/13/93;Build 8
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
 D LSTSADM^SDMDALE(.LST,5,.SD,.CAN)
 S FLDS(13)="CANCEL DT",FLDS(2)="DATE"
 D BLDLST^SDMAPI(.RETURN,.LST,.FLDS)
 Q 1
 ;
