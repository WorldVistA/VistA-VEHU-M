ZZRRBTST        ; RAY BLANK'S DEBUG TESTING ROUTINE
        ; NOTE - CALL BY SPECIFIC ENTRY POINT
        Q
ACCEPT  ; ACCEPT CONSULT
        ;
        S DFN=100022,STRT="",ORREN=0,FID="GMRC",ORL=11
        S OIL(1)=5057,ORIFN=""
        S RETURN=$$ACCEPT^ORWDXC(.LST,DFN,FID,STRT,ORL,.OIL,ORIFN,ORREN)
        ZW
        Q
        ;
LISTALL ;
        ;
        S FROM="100846",DIR=1,U="^",RETURN=""
        D LISTALL^ORWPT(.RETURN,FROM,DIR)
        Q
        ;
        ;
NEWDLG  ;
        ;
        S DUZ=1,U="^",ORTYPE="C",ORLOC=""
        D NEWDLG^ORWDCN32(.Y,ORTYPE,ORLOC)
        ;
        Q
        ;
USID    ;
        ;
        S ORI=1
        S OIL(ORI)=87
        S USID=$$USID^ORWDXC(OIL(ORI))
        Q
        ;
SETSORT ;
        ;
        S DUZ=1,U="^",SORT="D",DIR="R"
        D SETSORT^ORWORB(.ORERR,SORT,DIR)
        ;
        Q
        ;
CV      ; COMBAT VETERAN
        ;
        S DUZ=1,DFN=100850,U="^",DT=3131602
        D CV^ORMARKER(.RVAL,DFN)
        ZW RVAL
        Q
        ;
AUTORDV ;
        ;
        D AUTORDV^ORWCIRN(.ORY)
        ZW ORY
        Q
        ;
SVCLOOK ;
        S ORSTRT=1,ORWHY=1,ORSYN=1,U="^",DUZ=1
        D SVCSYN^ORQQCN2(.LST,ORSTRT,ORWHY,ORSYN,"")
        Q
        ;
GETSVC  ;
        ;
        S SVC="A",LOC=32,INP=0,U="^"
        D GETSVC^ORWPCE(.NEWSVC,SVC,LOC,INP)
        ZW NEWSVC
        Q
        ;
PROVDX  ;
        S ORIEN="5057;99CON"
        D PROVDX^ORQQCN2(.ORY,ORIEN)
        ZW ORY
        Q
        ;
NEAR    ;
        ;
        S DFN=5,STATUS="I",COMM="TEST NEAR LIST",U="^"
        K RES
        D EDITNEAR^ZSDRPCLV(.RES,DFN,STATUS,COMM)
        ZW RES
        Q
        ;
PSB     ;
        S U="^",DUZ=20171
        D RPC^PSBO(.RES,"PM",8,0,0,"","",1,"","","","","","","","","",500,"")   ;
        ;
        Q
        ;
PSB1    ;
        S I=""
        F  S I=$O(^PSB(53.69,I)) Q:I=""  D
        . S P=$P($G(^PSB(53.69,I,.1)),"^",2) Q:P=""
        . S PNAME=$P($G(^DPT(P,0)),"^",1)
        . W !,I_" "_P_" "_PNAME
        Q
        ;
RPTRPC  ;
        ;
        S DUZ=1,DUZ(0)="@",DUZ(2)=500,DT=3131111,U="^",DIV=""
        D RPT^ORWRP(.RES,8,"23:MED ADMIN LOG (BCMA)~;;0;101","",50000,"",0,0)
        ZW RES
        Q
        ;
LABRPT  ;
        ;
        S DUZ=1,DUZ(0)="@",DUZ(2)=500,DT=3131111,U="^",DIV=""
        D RPT^ORWRP(.RES,8,"OR_CH:CHEM & HEMATOLOGY~CH;ORDV02;3;101","",50000,"",0,0)
        ZW RES
        Q
        ;
BLDAVRPT        ;
        ;
        S DUZ=1,DUZ(0)="@",DUZ(2)=500,DT=3131111,U="^",DIV=""
        D RPT^ORWRP(.RES,433,"OR_BA:BLOOD AVAILABILITY~;;45;","",50000,"",0,0)
        ZW RES
        Q
        ;
LABPT   ;
        ;
        S DFN=""
        F  S DFN=$O(^DPT(DFN)) Q:DFN=""  D
        .S PNAME=$P($G(^DPT(DFN,0)),"^",1)
        .Q:DFN'?1.N
        .S LRDFN=$P($G(^DPT(DFN,"LR")),"^",1)
        .Q:'LRDFN
        .Q:'$D(^LR(LRDFN,"BB"))
        .W !,DFN_" "_PNAME_" "_LRDFN
        Q
        ;
CSLTNP  ;
        ;
        S DUZ=1,U="^",DT=$$HTFM^XLFDT(+$H),ORSERV=""
        S ORSERV="",ORSTATUS="",ORPROV=11712,ORSDT=2930523,OREDT=""    ;11712   ORPROV=983  OREDT=2981207.150037
        D CSLTNP^ZORRPCLV(.ORY,ORSDT,OREDT,ORSERV,ORSTATUS,ORPROV)
        ZW ORY
        Q
        ;
PRVSTAT ; LOOKUP BY PROVIDER FOR SPECIFIC STATUSES
        ;
        S CCSTAT="5,6,8",ORPROV=""
        F  S ORPROV=$O(^GMR(123,"G",ORPROV)) Q:ORPROV=""  D
        . S CONIEN=""
        . F  S CONIEN=$O(^GMR(123,"G",ORPROV,CONIEN)) Q:CONIEN=""  D
        . . F X=1:1 S CSTAT=$P(CCSTAT,",",X) Q:CSTAT=""  D 
        . . . S DOR=$P(^GMR(123,CONIEN,0),"^",7) 
        . . . I $D(^GMR(123,"D",CSTAT,CONIEN)) S ^TMP("ORPROV",$J,ORPROV,CONIEN,DOR,CSTAT)=""
        Q
        ;
SRVSTAT ; LOOKUP BY STATUS FOR SPECIFIC STATUSES
        ;
        S CCSTAT="5,6,8",SERV=""
        F  S SERV=$O(^GMR(123,"D",SERV)) Q:SERV=""  D
        . S CONIEN=""
        . F  S CONIEN=$O(^GMR(123,"D",SERV,CONIEN)) Q:CONIEN=""  D
        . . F X=1:1 S CSTAT=$P(CCSTAT,",",X) Q:CSTAT=""  D
        . . . S DOR=$P(^GMR(123,CONIEN,0),"^",7) 
        . . . I $D(^GMR(123,"D",CSTAT,CONIEN)) S ^TMP("ORSERV",$J,SERV,CONIEN,DOR,CSTAT)=""
        Q
        ;
IMOLOC  ;
        ;
        S DUZ=1,U="^",DT=3140606
        S DFN= 100710,LOC=32
        K LST
        D IMOLOC^ORIMO(.LST,LOC,DFN)
        ZW LST
        Q
CLOZ    ;
        ;
        S DUZ=1057,DUZ(2)=500,U="^",DFN=91,ORX=2281,ORTYPE="N"
        K LST
        D ALLWORD^ORALWORD(.LST,DFN,ORX,ORTYPE,DUZ)
        ZW LST
        Q
        ;
DISPAY  ; NAMESPACE ORDER CHECKS
        ;
        S DUZ=1,DUZ(2)=500,DFN=91,FID="PSI"
        K LST
        D DISPLAY^ORWDXC(.LST,DFN,FID)
        ZW LST
        Q
        
        
        
