TIUCOPR1 ;SLC/TDP - Copy/Paste Report ;Jun 11, 2021@09:21:53
 ;;1.0;TEXT INTEGRATION UTILITIES;**290,338**;Jun 20, 1997;Build 9
 ;
 ;   DBIA 2056   $$GET1^DIQ
 ;   DBIA 2056   GETS^DIQ
 ;   DBIA 2028   ^AUPNVSIT(
 ;   DBIA 10035  ^DPT(
 ;   DBIA 3162   ^GMR(123
 ;   DBIA 3260   ^LRT(67
 ;   DBIA 5771   ^OR(100
 ;   DBIA 10040  ^SC(
 ;   DBIA 10060  ^VA(200,
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10061  DEM^VADPT, KVA^VADPT
 ;
 Q
DETAILQ ;Detail Report (QUEUED)
 ;CLIN, DIV, DUZ, EDT, PROV, QUEUE, RUNDT, SDT, AND SRC EXIST FROM TIUCOPR QUEUE
 D DETAIL1(.CLIN,.DIV,DUZ,EDT,.PROV,RUNDT,SDT,SRC,QUEUE)
 Q
 ;
DETAIL(CLIN,DIV,DUZ,EDT,PROV,RUNDT,SDT,SRC) ;Detail Report (NO QUEUE)
 D DETAIL1(.CLIN,.DIV,DUZ,EDT,.PROV,RUNDT,SDT,SRC,QUEUE)
 Q
 ;
DETAIL1(CLIN,DIV,DUZ,EDT,PROV,RUNDT,SDT,SRC,QUEUE) ;Detail Report
 N APCT,CLNLOC,CLNNM,CPYDATA0,CPYDFN,CPYDT,CPYDUZ,CPYGBL,CPYIEN,CPYNAME,CPYOUT
 N CPYPKG,CPYPTNAME,CPYPTSRC,CPYSRC,CPYUSER,DFN,DTPST,ENDT,IEN,LNCNT,LOC
 N LOCTYP,LPDT,MIACPY,MIAPST,NOGO,NOTPAT,PARNT,PDIV,PDIVNM,PDIVS,PNVST,PNVST0
 N PNVSTLOC,PRVIEN,PRVNM,PSTDFN,PSTDT,PSTIEN,PSTNAME,PSTNT,PSTNT0,PSTPTNAME
 N PSTUSER,RSLT,STDT,STRTDT,TIU0,TIU12,TIU13,TIUC0,TIUC12,TIUC13,TIUOUT,VA
 N VADM
 I $G(RUNDT)="" S RUNDT=$$NOW^XLFDT
 W !,"PASTE DATE/TIME^PN PATIENT^PASTE NOTE (PN)^PN DATE/TIME^PN AUTHOR^COPY SOURCE (CS)^CS AUTHOR"
 S ENDT=EDT+.999999
 S (LPDT,STDT)=SDT-.000001
 S STRTDT=9999999-LPDT
 F  S LPDT=$O(^TIUP(8928,"B",LPDT)) Q:((LPDT="")!(LPDT>ENDT))  D
 . S IEN=""
 . F  S IEN=$O(^TIUP(8928,"B",LPDT,IEN)) Q:IEN=""  D
 .. S (PSTPTNAME,PSTNAME,PARNT)=""
 .. S (MIACPY,MIAPST,NOGO)=0
 .. S PSTNT0=$G(^TIUP(8928,IEN,0))
 .. I PSTNT0="" Q
 .. S PARNT=$P(PSTNT0,U,11)
 .. I PARNT'="",PARNT'=IEN Q
 .. S DTPST=$P(PSTNT0,U,1)
 .. S PRVIEN=+$P(PSTNT0,U,2)
 .. I +PROV>0,'$D(PROV(PRVIEN)) Q
 .. S PRVNM=""
 .. I +PRVIEN>0 S PRVNM=$P($G(^VA(200,PRVIEN,0)),U,1)
 .. ;I PRVNM="" S PRVNM="UNKNOWN PASTER NAME"
 .. S PDIV=+$P(PSTNT0,U,3)
 .. I +DIV>0,'$D(DIV(PDIV)) Q
 .. S PDIVS=PDIV_","
 .. K RSLT
 .. D GETS^DIQ(4,PDIVS,".01;99","","RSLT")
 .. S PDIVNM=$G(RSLT(4,PDIVS,.01))
 .. S PDIVNM=PDIVNM_" ("_$G(RSLT(4,PDIVS,99))_")"
 .. S CPYIEN=$P(PSTNT0,U,6)
 .. S CPYPKG=$P(PSTNT0,U,7)
 .. I CPYIEN>0,CPYPKG="" S CPYPKG=8925
 .. S CPYSRC=$S(CPYPKG=8925:"T",CPYPKG=100:"O",CPYPKG=123:"C",1:"")
 .. I CPYSRC'="",SRC'[CPYSRC Q
 .. S APCT=$P(PSTNT0,U,8)
 .. I APCT="" S APCT="??"
 .. S CPYNAME=""
 .. S CPYOUT=""
 .. S CPYUSER=""
 .. S CPYPTNAME=""
 .. S CPYDUZ=""
 .. S CPYUSER=""
 .. S CPYDFN=""
 .. S PSTNT=+$P(PSTNT0,U,4)
 .. I '$D(^TIU(8925,PSTNT,0)) Q
 .. S TIU0=$G(^TIU(8925,PSTNT,0))
 .. S TIU12=$G(^TIU(8925,PSTNT,12))
 .. S TIU13=$G(^TIU(8925,PSTNT,13))
 .. S NOTPAT=0
 .. I MIAPST'=1 D  Q:NOTPAT
 ... S PSTIEN=$P(TIU12,U,2) ;AUTHOR/DICTATOR
 ... I +PSTIEN=0 S PSTIEN=$P(TIU13,U,2) ;ENTERED BY
 ... I +PSTIEN>0 S PSTUSER=$P($G(^VA(200,PSTIEN,0)),U,1)
 ... ;I PSTUSER="" S PSTUSER="UNKNOWN AUTHOR"
 ... S PSTDFN=+$P(TIU0,U,2)
 ... I +PSTDFN>0 D
 .... S DFN=+PSTDFN
 .... D DEM^VADPT
 .... S PSTPTNAME=$E($G(VADM(1)),1,20)_" ("_$G(VA("BID"))_")"
 .... D KVA^VADPT ;Cleans up VADPT variables including VA("BID") and VA("PID")
 ... ;I PSTPTNAME="" S PSTPTNAME="UNKNOWN PATIENT NAME"
 ... S PSTDT=$P(TIU13,U,1)
 ... S PSTNAME=$P(TIU0,U,1)
 ... S PSTNAME=$P($G(^TIU(8925.1,PSTNAME,0)),U,1)
 ... ;I PSTNAME="" S PSTNAME="UNKNOWN TITLE"
 .. S CLNLOC=+$P(TIU12,U,5)
 .. I +CLIN>0,'$D(CLIN(CLNLOC)) Q
 .. S LOC=$G(^SC(CLNLOC,0))
 .. S LOCTYP=$P(LOC,U,3)
 .. I CLNLOC>0 S CLNNM=$P(LOC,U,1)
 .. ;I CLNLOC=0 S CLNNM="UNKNOWN LOCATION"
 .. S PNVST=$S(LOCTYP="W":"Adm: ",1:"Visit: ")_$$FMTE^XLFDT($P(TIU0,U,7),7)
 .. I CPYIEN="",CPYPKG="" D  Q:SRC'[CPYSRC
 ... S CPYOUT=$P(PSTNT0,U,10)
 ... S CPYNAME=$P(CPYOUT,";",2)
 ... S CPYPTNAME=$P(CPYOUT,";",3)
 ... I (CPYNAME["Outside of")!(CPYNAME["Percent Match fell below threshold") D
 .... ;S CPYDT="UNKNOWN"
 .... ;S CPYUSER="UNKNOWN"
 .... S CPYSRC=$S(CPYNAME["Outside of":"X",1:"E")
 ... I $P(CPYNAME," - ",1)="ORDER DETAILS" D
 .... S CPYIEN=$P($P(CPYNAME," - ",2),";",1)
 .... S CPYPKG="100",CPYSRC="O"
 ... I $P(CPYNAME," - ",1)'="ORDER DETAILS" D
 .... I $P(CPYOUT,";",4)'="" S CPYUSER=$P(CPYOUT,";",3)
 ... ;I CPYUSER="" S CPYUSER="UNKNOWN"
 ... ;I +$G(CPYDT)=0 S CPYDT="UNKNOWN"
 ... ;I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. I CPYPKG="8925" D  Q:MIACPY=1
 ... I '$D(^TIU(8925,CPYIEN)) S MIACPY=1 Q
 ... S TIUC0=$G(^TIU(8925,CPYIEN,0))
 ... S TIUC12=$G(^TIU(8925,CPYIEN,12))
 ... S TIUC13=$G(^TIU(8925,CPYIEN,13))
 ... S CPYDUZ=$P(TIUC12,U,2) ;AUTHOR/DICTATOR
 ... I +CPYDUZ=0 S CPYDUZ=$P(TIUC13,U,2) ;ENTERED BY
 ... I +CPYDUZ>0 S CPYUSER=$P($G(^VA(200,CPYDUZ,0)),U,1)
 ... ;I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 ... S CPYDATA0=$G(TIUC0)
 ... S CPYDT=$P(TIUC13,U,1)
 ... S CPYNAME=$P(CPYDATA0,U,1)
 ... S CPYNAME=$P($G(^TIU(8925.1,CPYNAME,0)),U,1)
 ... ;I CPYNAME="" S CPYNAME="UNKNOWN TITLE"
 ... S CPYDFN=$P(CPYDATA0,U,2)
 ... I +CPYDFN>0 S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 ... ;I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. I CPYPKG="100" D
 ... S CPYDATA0=$G(^OR(100,CPYIEN,0))
 ... S CPYDT=$P(CPYDATA0,U,7)
 ... S CPYDUZ=$P(CPYDATA0,U,6) ;WHO ENTERED
 ... I +CPYDUZ>0 S CPYUSER=$P($G(^VA(200,CPYDUZ,0)),U,1)
 ... ;I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 ... S CPYNAME="ORDER #"_$P(CPYDATA0,U,1)
 ... ;I +$P(CPYNAME,"#",2)=0 S CPYNAME="UNKNOWN ORDER NUMBER"
 ... S CPYDFN=$P(CPYDATA0,U,2) ;ORDERABLE ITEMS (PATIENT/REFERRAL)
 ... I +CPYDFN>0 D
 .... S CPYGBL=$P(CPYDFN,";",2)
 .... S CPYDFN=+CPYDFN
 ... I CPYGBL="DPT(" S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 ... I CPYGBL="LRT(67," S CPYPTNAME=$$GET1^DIQ(67,CPYDFN_",",.01)
 ... ;I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. I CPYPKG="123" D
 ... S CPYDATA0=$G(^GMR(123,CPYIEN,0))
 ... S CPYDT=$P(CPYDATA0,U,1)
 ... S CPYDUZ=$P(CPYDATA0,U,14) ;SENDING PROVIDER
 ... I +CPYDUZ>0 S CPYUSER=$P($G(^VA(200,CPYDUZ,0)),U,1)
 ... I +CPYDUZ<1,$P($G(^GMR(123,CPYIEN,12)),U,6)'="" S CPYUSER=$P($G(^GMR(123,CPYIEN,12)),U,6),CPYDUZ="IFC"
 ... ;I CPYUSER="" S CPYUSER="UNKNOWN AUTHOR"
 ... S CPYNAME="CONSULT #"_CPYIEN
 ... ;I +$P(CPYNAME,"#",2)=0 S CPYNAME="UNKNOWN CONSULT NUMBER"
 ... S CPYDFN=$P(CPYDATA0,U,2) ;PATIENT NAME (IEN)
 ... I +CPYDFN>0 S CPYPTNAME=$P($G(^DPT(CPYDFN,0)),U,1)
 ... ;I CPYPTNAME="" S CPYPTNAME="UNKNOWN PATIENT NAME"
 .. S TIUOUT=$$FMTE^XLFDT(DTPST,7)_U_PSTPTNAME_U_PSTNAME_U_$$FMTE^XLFDT(PSTDT,7)_U_PSTUSER_U_CPYNAME_U_CPYUSER
 .. I $L(TIUOUT)>255 D
 ... S $P(TIUOUT,U,3)=$E(PSTNAME,1,40)
 ... I $L(TIUOUT)'>255 Q
 ... S $P(TIUOUT,U,6)=$E(CPYNAME,1,40)
 .. W !,TIUOUT
 .. ;W !,PDIVNM_U_PNVST_U_CLNNM_U_$$FMTE^XLFDT(DTPST,7)_U_PSTPTNAME_U_PSTNAME
 .. ;W U_$$FMTE^XLFDT(PSTDT,7)_U_PSTUSER_U_CPYPTNAME_U_CPYNAME
 .. ;W U_$$FMTE^XLFDT(CPYDT,7)_U_CPYUSER_U_APCT_"%"
 .. Q
 . Q
 I QUEUE D MSG(.CLIN,.DIV,DUZ,EDT,.PROV,RUNDT,SDT,SRC)
 Q
MSG(CLIN,DIV,DUZ,EDT,PROV,RUNDT,SDT,SRC) ;Send mail message to user who ran report
 ;IO,IOST are device related arrays/variables
 N LNCNT,TIUDT,TXT,XMDUZ,XMSUB,XMTEXT,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,XMZ
 S XMY(DUZ)=""
 S XMTEXT="TXT("
 S TIUDT=$$FMTE^XLFDT(RUNDT,1)
 S XMSUB=TIUDT_" COPY/PASTE TRACKING REPORT COMPLETED"
 S LNCNT=0
 S LNCNT=LNCNT+1,TXT(LNCNT)="The COPY/PASTE TRACKING REPORT run at "_TIUDT_" has completed."
 S LNCNT=LNCNT+1,TXT(LNCNT)=""
 S LNCNT=LNCNT+1,TXT(LNCNT)="Report Parameters:"
 S LNCNT=LNCNT+1,TXT(LNCNT)=""
 S LNCNT=LNCNT+1,TXT(LNCNT)="   Start Date: "_$$FMTE^XLFDT(SDT,5)
 S LNCNT=LNCNT+1,TXT(LNCNT)="    Stop Date: "_$$FMTE^XLFDT(EDT,5)
 S LNCNT=LNCNT+1,TXT(LNCNT)="  Division(s): "
 I DIV=0 S TXT(LNCNT)=$G(TXT(LNCNT))_"ALL"
 I DIV>0 D
 . N DIVCNT,DIVNM,DIVIEN
 . S DIVNM=""
 . F  S DIVNM=$O(DIV("B",DIVNM)) Q:DIVNM=""  D
 .. S DIVIEN=0
 .. F  S DIVIEN=$O(DIV("B",DIVNM,DIVIEN)) Q:DIVIEN=""  D
 ... S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_DIVNM_" ("_$G(DIV("B",DIVNM,DIVIEN))_")"
 ... S LNCNT=LNCNT+1
 ... Q
 .. Q
 . S LNCNT=LNCNT-1
 . Q
 S LNCNT=LNCNT+1,TXT(LNCNT)="  Location(s): "
 I CLIN=0 S TXT(LNCNT)=$G(TXT(LNCNT))_"ALL"
 I CLIN>0 D
 . N CLINCNT,CLINNM,CLINIEN
 . S CLINNM=""
 . F  S CLINNM=$O(CLIN("B",CLINNM)) Q:CLINNM=""  D
 .. S CLINIEN=0
 .. F  S CLINIEN=$O(CLIN("B",CLINNM,CLINIEN)) Q:CLINIEN=""  D
 ... S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_CLINNM
 ... S LNCNT=LNCNT+1
 ... Q
 .. Q
 . S LNCNT=LNCNT-1
 . Q
 S LNCNT=LNCNT+1,TXT(LNCNT)="  Provider(s): "
 I PROV=0 S TXT(LNCNT)=$G(TXT(LNCNT))_"ALL"
 I PROV>0 D
 . N PROVCNT,PROVNM,PROVIEN
 . S PROVNM=""
 . F  S PROVNM=$O(PROV("B",PROVNM)) Q:PROVNM=""  D
 .. S PROVIEN=0
 .. F  S PROVIEN=$O(PROV("B",PROVNM,PROVIEN)) Q:PROVIEN=""  D
 ... S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_PROVNM
 ... S LNCNT=LNCNT+1
 ... Q
 .. Q
 . S LNCNT=LNCNT-1
 . Q
 S LNCNT=LNCNT+1,TXT(LNCNT)="    Source(s): "
 I SRC["T",SRC["C",SRC["O",SRC["X",SRC["E" S TXT(LNCNT)=$G(TXT(LNCNT))_"ALL"
 E  D
 . I SRC["T" S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_"T: TIU DOCUMENTS",LNCNT=LNCNT+1
 . I SRC["C" S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_"C: REQUEST/CONSULTATIONS",LNCNT=LNCNT+1
 . I SRC["O" S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_"O: ORDERS",LNCNT=LNCNT+1
 . I SRC["X" S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_"X: OUTSIDE OF CPRS",LNCNT=LNCNT+1
 . I SRC["E" S TXT(LNCNT)=$S($L($G(TXT(LNCNT)))>0:$G(TXT(LNCNT)),1:"               ")_"E: EVERYTHING ELSE"
 . Q
 S LNCNT=LNCNT+1,TXT(LNCNT)="       Device: "_$G(IOST)
 S TXT(LNCNT)=$G(TXT(LNCNT))_$S($G(IO("DOC"))'="":" ("_$G(IO("DOC")),$G(IO("HFSIO"))'="":" ("_$G(IO("HFSIO")),1:"")
 D ^XMD
 Q
