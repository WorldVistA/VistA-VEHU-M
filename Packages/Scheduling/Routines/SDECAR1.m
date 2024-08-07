SDECAR1 ;ALB/SAT,WTC,CT,LAB - VISTA SCHEDULING RPCS ;MAR 23, 2022@10:55
 ;;5.3;Scheduling;**627,642,658,686,694,745,813**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
 ; Get SDEC APPOINTMENT REQUEST for all entries in the user's Institution
 ; where the Current Status is not C(losed).
ARGET(RET,ARIEN1,MAXREC,SDBEG,SDEND,DFN,LASTSUB,SDTOP,SVCL,DESDT,PRL,SVCR,SCVISIT,CLINIC,ORIGDT) ;Appt Req GET  ;alb/sat 658 add SVCL-SCVISIT
ARGET1 ;
 ;29  SVCCONN  - SERVICE CONNECTED? field .301 of the PATIENT file
 ;37  ARSVCCON - SERVICE CONNECTED PRIORITY field 15 of the SDEC APPT REQUEST file
 ;
 N CLOSED,FNUM,NAME,DOB,SSN4,GENDER,ARORIGDT,ARINST,ARINSTNM,ARTYPE,ARTEAM,ARPOS
 N ELIGIEN,ELIGNAME,FRULES,GLOREF,HRN,INSTIEN,INSTNAME,PRIGRP,SVCCONN,SVCCONNP,TYPEIEN,TYPENAME
 N PCOUNTRY,SDSUB,SDTMP,SSN,ARSSIEN,ARSSNAME,ARCLIEN,ARCLNAME
 N ARUSER,ARPRIO,ARREQBY,ARPROV,ARPROVNM,ARDAPTDT,ARCOMM,AREESTAT,ARUSRNM
 N ARCLIENL,AREDT,ARIEN,PTINFOLSTA,ARDISPD,ARDISPU,ARDISPUN,ARSVCCON
 N ARMAI,ARMAN,ARMAR,ARSTAT,ARSTOP,ARSTOPN,COUNT,DES,SDK,STR,SDRTMP
 N PCITY,GAF,PSTATE,PZIP4,PADDRES1,PADDRES2,PADDRES3,PPC,PTPHONE,ARENPRI,ARASD,ARPC,ARDATA
 N SDCL,SDI,SDJ,SDMTRC,SDPARENT,SDPS,SDSENS,SDDEMO,X,Y,%DT,APPTPTRS
 N VAOSGUID ; wtc patch 686 3/23/18 added for VAOS requests
 ;
 ; wtc/mbs patch 694 7/24/18 added to check if user has access to VAOS requests
 ;
 N VAOSUSR ;
 D OWNSKEY^XUSRB(.VAOSUSR,"SDECZ REQUEST") ;
 ;
 S RET="^TMP(""SDEC"","_$J_")"
 K @RET
 S FNUM=$$FNUM^SDECAR,COUNT=0
 S MAXREC=+$G(MAXREC,50)
 D HDR
 S GLOREF=$NA(^SDEC(409.85,"C",DUZ(2)))
 S FRULES=1
 S ARIEN=0
 ;F  S WLIEN=$O(@GLOREF@(WLIEN)) Q:'WLIEN  D ONEPAT I MAXREC,COUNT'<MAXREC Q
 S SDBEG=$G(SDBEG)
 I SDBEG'="" S %DT="" S X=$P(SDBEG,"@",1) D ^%DT S SDBEG=Y I Y=-1 S SDBEG=3100101
 I SDBEG="" S SDBEG=3100101
 S SDEND=$G(SDEND)
 I SDEND'="" S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND=$$FMADD^XLFDT($E($$NOW^XLFDT,1,12),-90)
 I SDEND="" S SDEND=$$FMADD^XLFDT($E($$NOW^XLFDT,1,12),-90)
 S DFN=$G(DFN)
 I DFN'="",'$D(^DPT(DFN,0)) S DFN=""
 S LASTSUB=$S(DFN="":$G(LASTSUB),1:"")
 S SDTOP=+$G(SDTOP)
 ;validate SVCL
 S SVCL=$G(SVCL)
 I SVCL'="" D
 .F SDI=$L(SVCL,"|"):-1:1 S SVC=$P(SVCL,"|",SDI) D
 ..I (SVC="")!('$D(^DIC(40.7,+SVC,0))) S SVCL=$$PD^SDECUTL(SVCL,SDI,"|")
 ;validate DESDT
 S DESDT=$G(DESDT)
 ;validate PRL
 S PRL=$G(PRL)
 I PRL'="" D
 .N PR
 .F SDI=$L(PRL,"|"):-1:1 S PR=$P(PRL,"|",SDI) D
 ..I "012345678"'[PR S PR=$E(PR,7)
 ..I "012345678"'[PR S PRL=$$PD^SDECUTL(PRL,SDI,"|")
 ;validate SVCR
 S SVCR=$G(SVCR) S:SVCR'="" SVCR=$$UP^XLFSTR(SVCR)
 I SVCR'="" S SVCR=$S(SVCR="Y":1,SVCR="N":0,SVCR="YES":1,SVCR="NO":0,1:"")
 ;validate SCVISIT
 S SCVISIT=$G(SCVISIT) S:SCVISIT'="" SCVISIT=$$UP^XLFSTR(SCVISIT)
 I SCVISIT'="" S SCVISIT=$S(SCVISIT="Y":"Y",SCVISIT="N":"N",SCVISIT="YES":"Y",SCVISIT="NO":"N",1:"")
 ;validate CLINIC
 S CLINIC=$G(CLINIC)
 ;validate ORIGDT
 S ORIGDT=$G(ORIGDT)
 ;single IEN
 S ARIEN1=$G(ARIEN1)
 I +ARIEN1 I '$D(^SDEC(409.85,+ARIEN1,0))  S ARIEN1=""
 I +ARIEN1 D
 .S ARIEN=+ARIEN1
 .S FRULES=0  ;no rules - just return the single record
 .D ONEPAT
 I +ARIEN1 S @RET@(COUNT)=@RET@(COUNT)_$C(31) Q
 ;by patient
 I +DFN D
 .I 'SDTOP S ARIEN=0 F  S ARIEN=$O(^SDEC(409.85,"B",+DFN,ARIEN)) Q:ARIEN'>0  D ONEPAT  ;I MAXREC,COUNT'<MAXREC Q
 .I +SDTOP S ARIEN=999999999 F  S ARIEN=$O(^SDEC(409.85,"B",+DFN,ARIEN),-1) Q:ARIEN'>0  D ONEPAT
 ;clinic
 I CLINIC'="" D  G ARX
 .S SDI=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1),1:1)
 .F SDI=SDI:1:$L(CLINIC,"|") S SDCL=$P(CLINIC,"|",SDI) D  I MAXREC,COUNT'<MAXREC Q
 ..Q:SDCL=""
 ..I DESDT'="" D  Q  ;GCC  DESDT desired dates by pipe
 ...S SDT=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:1)
 ...F SDT=SDT:1:$L(DESDT,"|") S DES=$P(DESDT,"|",SDT) D  I MAXREC,COUNT'<MAXREC Q
 ....Q:DES=""
 ....S ARIEN=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ....F  S ARIEN=$O(^SDEC(409.85,"GCC",SDCL,DES,ARIEN)) Q:ARIEN=""  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDCL_"|"_SDT_"|"_ARIEN Q
 .....D ONEPAT
 ..;
 ..S SDT=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,ORIGDT'="":ORIGDT-1,1:SDBEG-1)  ;GC
 ..F  S SDT=$O(^SDEC(409.85,"GC",SDCL,SDT)) Q:SDT=""  Q:((ORIGDT'="")&(SDT>ORIGDT))  Q:(ORIGDT="")&(SDT>SDEND)  D  I MAXREC,COUNT'<MAXREC Q
 ...S ARIEN=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ...F  S ARIEN=$O(^SDEC(409.85,"GC",SDCL,SDT,ARIEN)) Q:ARIEN=""  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDI_"|"_SDT_"|"_ARIEN Q
 ....D ONEPAT
 ;by service
 I SVCL'="" D  G ARX
 .N PR1,SDT,SVC
 .S SDI=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1),1:1)
 .F SDI=SDI:1:$L(SVCL,"|") S SVC=$P(SVCL,"|",SDI) D  I MAXREC,COUNT'<MAXREC Q
 ..Q:SVC=""
 ..;I DESDTR'="" D  ;desired date range range <begin> ~ <end> not implemented
 ..I DESDT'="" D  Q  ;GSC  DESDT desired dates by pipe
 ...S SDT=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:1)
 ...F SDT=SDT:1:$L(DESDT,"|") S DES=$P(DESDT,"|",SDT) D  I MAXREC,COUNT'<MAXREC Q
 ....Q:DES=""
 ....S ARIEN=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ....F  S ARIEN=$O(^SDEC(409.85,"GSC",SVC,DES,ARIEN)) Q:ARIEN=""  D  I MAXREC,COUNT'<MAXREC S SDSUB=SVC_"|"_SDT_"|"_ARIEN Q
 .....D ONEPAT
 ..I PRL'="" D  Q   ;GSP
 ...S SDK=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:1)
 ...F SDK=SDK:1:$L(PRL,"|") S PR1=$P(PRL,"|",SDK) D  I MAXREC,COUNT'<MAXREC Q
 ....S SDT=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3)-1,1:SDBEG-1)
 ....F  S SDT=$O(^SDEC(409.85,"GSP",SVC,PR1,SDT)) Q:SDT=""  Q:SDT>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 .....S ARIEN=$S($P(LASTSUB,"|",4)'="":$P(LASTSUB,"|",4),1:0)
 .....F  S ARIEN=$O(^SDEC(409.85,"GSP",SVC,PR1,SDT,ARIEN)) Q:ARIEN=""  D ONEPAT  I MAXREC,COUNT'<MAXREC S SDSUB=SVC_"|"_SDK_"|"_SDT_"|"_ARIEN Q
 ..I SVCR'="" D  Q  ;GSB - WL service connected
 ...S SDT=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:SDBEG-1)
 ...F  S SDT=$O(^SDEC(409.85,"GSB",SVC,$E(SVCR),SDT)) Q:SDT=""  Q:SDT>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 ....S ARIEN=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ....F  S ARIEN=$O(^SDEC(409.85,"GSB",SVC,$E(SVCR),SDT,ARIEN)) Q:ARIEN=""  D ONEPAT  I MAXREC,COUNT'<MAXREC S SDSUB=SVC_"|"_SDT_"|"_ARIEN Q
 ..I SCVISIT'="" D  Q  ;GSA - Patient Service Connected
 ...S SDT=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:SDBEG-1)
 ...F  S SDT=$O(^SDEC(409.85,"GSA",SVC,$E(SCVISIT),SDT)) Q:SDT=""  Q:SDT>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 ....S ARIEN=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ....F  S ARIEN=$O(^SDEC(409.85,"GSA",SVC,$E(SCVISIT),SDT,ARIEN)) Q:ARIEN=""  D ONEPAT  I MAXREC,COUNT'<MAXREC S SDSUB=SVC_"|"_SDT_"|"_ARIEN Q
 ..S SDT=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2)-1,1:SDBEG-1)  ;GS
 ..F  S SDT=$O(^SDEC(409.85,"GS",SVC,SDT)) Q:SDT=""  Q:SDT>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 ...S ARIEN=$S($P(LASTSUB,"|",3)'="":$P(LASTSUB,"|",3),1:0)
 ...F  S ARIEN=$O(^SDEC(409.85,"GS",SVC,SDT,ARIEN)) Q:ARIEN=""  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDI_"|"_SDT_"|"_ARIEN Q
 ....D ONEPAT
 ;
 ;all by date range
 I 'DFN D
 .I 'SDTOP D
 ..S SDJ=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)-1,1:SDBEG-1)
 ..F  S SDJ=$O(^SDEC(409.85,"E","O",SDJ)) Q:SDJ'>0  Q:SDJ>SDEND  D  I MAXREC,COUNT'<MAXREC Q
 ...S ARIEN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:0)
 ...F  S ARIEN=$O(^SDEC(409.85,"E","O",SDJ,ARIEN)) Q:ARIEN'>0  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDJ_"|"_ARIEN Q
 ....S SDSUB=""
 ....D ONEPAT
 .I +SDTOP D
 ..S SDJ=$S($P(LASTSUB,"|",1)'="":$P(LASTSUB,"|",1)+1,1:SDEND+1)
 ..F  S SDJ=$O(^SDEC(409.85,"E","O",SDJ),-1) Q:SDJ'>0  Q:SDJ<SDBEG  D  I MAXREC,COUNT'<MAXREC Q
 ...S ARIEN=$S($P(LASTSUB,"|",2)'="":$P(LASTSUB,"|",2),1:999999999)
 ...F  S ARIEN=$O(^SDEC(409.85,"E","O",SDJ,ARIEN),-1) Q:ARIEN'>0  D  I MAXREC,COUNT'<MAXREC S SDSUB=SDJ_"|"_ARIEN Q
 ....S SDSUB=""
 ....D ONEPAT
ARX S SDTMP=@RET@(COUNT) S SDTMP=$P(SDTMP,$C(30),1)
 S:$G(SDSUB)'="" $P(SDTMP,U,56)=SDSUB
 S @RET@(COUNT)=SDTMP_$C(30,31)
 Q
HDR ;Send back the header
 ;                     1         2
 S SDRTMP="T00030DFN^T00030NAME"
 ;                       3         4         5         6            7         8
 S SDRTMP=SDRTMP_"^T00030HRN^T00030DOB^T00030SSN^T00030GENDER^I00010IEN^D00030ORIGDT"
 ;                       9             10             11          12            13
 S SDRTMP=SDRTMP_"^T00030INSTIEN^T00030INSTNAME^T00030TYPE^T00030CLINIEN^T00030CLINNAME"
 ;                       14            15             16         17          18            19
 S SDRTMP=SDRTMP_"^T00030USERIEN^T00030USERNAME^T00030PRIO^T00030REQBY^T00030PROVIEN^T00030PROVNAME"
 ;                       20           21         22
 S SDRTMP=SDRTMP_"^T00030DAPTDT^T00250COMM^T00030ENROLLMENT_PRIORITY"
 ;                       23                             24                           25
 S SDRTMP=SDRTMP_"^T00010MULTIPLE APPOINTMENT RTC^T00010MULT APPT RTC INTERVAL^T00010MULT APPT NUMBER"
 ;                       26           27            28             29            30
 S SDRTMP=SDRTMP_"^T00030PRIGRP^T00030ELIGIEN^T00030ELIGNAME^T00030SVCCONN^T00030SVCCONNP"
 ;                       31            32             33             34            35            36
 S SDRTMP=SDRTMP_"^T00030TYPEIEN^T00030TYPENAME^T00100PCONTACT^T00030ARDISPD^T00030ARDISPU^T00030ARDISPUN"
 ;                       37             38             39             40             41
 S SDRTMP=SDRTMP_"^T00030WLSVCCON^T00030PADDRES1^T00030PADDRES2^T00030PADDRES3^T00030PCITY"
 ;                       42           43             44          45        46         47
 S SDRTMP=SDRTMP_"^T00030PSTATE^T00030PCOUNTRY^T00030PZIP4^T00050GAF^T00030DATE^T00030MTRCDATES"
 ;                       48              49         50         51         52         53
 S SDRTMP=SDRTMP_"^T00100SENSITIVE^T00030NU49^T00030NU50^T00030NU51^T00030NU52^T00030NU53"
 ;                       54         55         56            57            58             59
 S SDRTMP=SDRTMP_"^T00030NU54^T00030NU55^T00030LASTSUB^T00030STOPIEN^T00030STOPNAME^T00250APPT_SCHED_DATE"
 S SDRTMP=SDRTMP_"^T00030MRTCCOUNT^T00030PTPHONE^T00030APPTYPE^T00030EESTAT^T00030PRHBLOC^T00030APPTPTRS"
 S SDRTMP=SDRTMP_"^T00250CHILDREN^T00030SDPARENT"
 ;
 ;  Removed unnamed column header.  694 wtc 7/16/2019
 ;
 ;S SDRTMP=SDRTMP_"^T00030HRN^T00030BADADD^T00030OPHONE^T00030NOK^T00030^T00030KNAME^T00030KREL^T00030KPHONE"
 S SDRTMP=SDRTMP_"^T00030HRN^T00030BADADD^T00030OPHONE^T00030NOK^T00030KNAME^T00030KREL^T00030KPHONE"
 ;
 ;  Removed unnamed column header.  694 wtc 7/16/2019
 ;
 ;S SDRTMP=SDRTMP_"^T00030KSTREET^T00030KSTREET2^T00030KSTREET3^T00030KCITY^T00030KSTATE^T00030KZIP^T00030"
 S SDRTMP=SDRTMP_"^T00030KSTREET^T00030KSTREET2^T00030KSTREET3^T00030KCITY^T00030KSTATE^T00030KZIP"
 S SDRTMP=SDRTMP_"^T00030NOK2^T00030K2NAME^T00030K2REL^T00030K2PHONE"
 S SDRTMP=SDRTMP_"^T00030K2STREET^T00030K2STREET2^T00030K2STREET3^T00030K2CITY^T00030K2STATE^T00030K2ZIP"
 S SDRTMP=SDRTMP_"^T00030PCOUNTY^T00030PETH^T00030PRACE^T00030PMARITAL^T00030PRELIGION^T00030PTACTIVE"
 S SDRTMP=SDRTMP_"^T00030PTADDRESS1^T00030PTADDRESS2^T00030PTADDRESS3^T00030PTCITY^T00030PTSTATE^T00030PTZIP^T00030PTZIP+4"
 S SDRTMP=SDRTMP_"^T00030PTCOUNTRY^T00030PTCOUNTY^T00030PTMPPHONE^T00030PTSTART^T00030PTEND^T00030PCELL^T00030PPAGER^T00030PEMAIL"
 S SDRTMP=SDRTMP_"^T00030PF_FFF^T00030PF_VCD^T00030PFNATIONAL^T00030PFLOCAL^T00030SUBGRP^T00030CAT8G^T01000SIMILAR"
 S SDRTMP=SDRTMP_"^T00032VAOS_GUID^T00030CPHONE^T00030CLET" ;  wtc patch 686 3/23/18 added for VAOS requests   ;CT added call phone & letter
 S SDRTMP=SDRTMP_"^T00030CEMAIL^T00030CTEXT^T00030CSEC" ; 813  contact email,text,sec msg
 S @RET@(COUNT)=SDRTMP_$C(30)
 Q
 ;
ONEPAT ; Process one patient
 N APPTYPE,ARMRTC,CHILDREN,SDI,PRHBLOC
 K ARASD,ARDATA,ARSDOA,ARDAM,ARCLERK,ARCLERKN,SDAPPT
 S FRULES=$G(FRULES)
 D GETS^DIQ(FNUM,ARIEN,"**","IE","ARDATA","ARMSG")
 Q:'$D(ARDATA)
 S ARSTAT=ARDATA(FNUM,ARIEN_",",23,"I")
 I FRULES I '+$G(CLOSED) Q:ARSTAT="C"  ; Ignore CLOSED records; CLOSED setup and used from SDEC54 only
 S ARORIGDT=ARDATA(FNUM,ARIEN_",",1,"I")
 I FRULES I ($P(ARORIGDT,".",1)<SDBEG)!($P(ARORIGDT,".",1)>SDEND) Q
 S DFN=ARDATA(FNUM,ARIEN_",",.01,"I")
 Q:DFN=""
 S SDPS=ARDATA(FNUM,ARIEN_",",.02,"E")
 S SDCL=ARDATA(FNUM,ARIEN_",",8,"I")
 Q:(SDCL'="")&($$GET1^DIQ(44,SDCL_",",50.01,"I")=1)  ;check OOS? in file 44
 S PRHBLOC=$S($$GET1^DIQ(44,SDCL_",",2500,"I")="Y":1,1:0)
 ;collect demographics
 D PDEMO^SDECU3(.SDDEMO,DFN)  ;alb/sat 658 PDEMO moved to SDECU3
 S NAME=SDDEMO("NAME")
 S DOB=SDDEMO("DOB")
 S GENDER=SDDEMO("GENDER")
 S HRN=SDDEMO("HRN")
 S SSN=SDDEMO("SSN")
 S INSTIEN=SDDEMO("INSTIEN")
 S INSTNAME=SDDEMO("INSTNAME")
 S PRIGRP=SDDEMO("PRIGRP")
 S ELIGIEN=SDDEMO("ELIGIEN")
 S ELIGNAME=SDDEMO("ELIGNAME")
 S SVCCONN=SDDEMO("SVCCONN")
 S SVCCONNP=SDDEMO("SVCCONNP")
 S TYPEIEN=SDDEMO("TYPEIEN")
 S TYPENAME=SDDEMO("TYPENAME")
 S PADDRES1=SDDEMO("PADDRES1")
 S PADDRES2=SDDEMO("PADDRES2")
 S PADDRES3=SDDEMO("PADDRES3")
 S PCITY=SDDEMO("PCITY")
 S PSTATE=SDDEMO("PSTATE")
 S PCOUNTRY=SDDEMO("PCOUNTRY")
 S PZIP4=SDDEMO("PZIP+4")
 ;
 S GAF=$$GAF^SDECU2(DFN)
 ;
 S PTPHONE=SDDEMO("HPHONE")    ;ARDATA(FNUM,ARIEN_",",.05,"I")  ;msc/sat
 S ARINST=ARDATA(FNUM,ARIEN_",",2,"I")
 S ARINSTNM=ARDATA(FNUM,ARIEN_",",2,"E")
 S ARTYPE=ARDATA(FNUM,ARIEN_",",4,"I")
 ;
 ; wtc/mbs patch 694 7/24/18 added to check if user has access to VAOS requests
 ;
 I ARTYPE="VETERAN",'$G(VAOSUSR(0)) Q  ;
 ;
 S VAOSGUID=ARDATA(FNUM,ARIEN_",",5,"I") ;  wtc patch 686 3/23/18 added for VAOS requests
 S ARCLIENL=ARDATA(FNUM,ARIEN_",",8,"I")
 S ARSTOP=ARDATA(FNUM,ARIEN_",",8.5,"I")
 S ARSTOPN=ARDATA(FNUM,ARIEN_",",8.5,"E")
 ;S ARCLIEN=$P($G(^SDWL(409.32,+ARCLIENL,0)),U,1)
 S ARCLIEN=ARCLIENL
 S ARCLNAME=ARDATA(FNUM,ARIEN_",",8,"E")
 S APPTYPE=ARDATA(FNUM,ARIEN_",",8.7,"I")
 S ARUSER=ARDATA(FNUM,ARIEN_",",9,"I")
 S ARUSRNM=ARDATA(FNUM,ARIEN_",",9,"E")
 S AREDT=$G(ARDATA(FNUM,ARIEN_",",9.5,"E"))   ;53
 S ARPRIO=ARDATA(FNUM,ARIEN_",",10,"I")
 S ARENPRI=ARDATA(FNUM,ARIEN_",",10.5,"E")   ;msc/sat
 S ARREQBY=ARDATA(FNUM,ARIEN_",",11,"I")
 S ARPROV=ARDATA(FNUM,ARIEN_",",12,"I")
 S ARPROVNM=ARDATA(FNUM,ARIEN_",",12,"E")
 ;S ARSDOA=ARDATA(FNUM,ARIEN_",",13,"E")      ;scheduled date of appt
 S ARSDOA=ARDATA(FNUM,ARIEN_",",13,"I")      ;scheduled date of appt
 ;  Change date/time conversion so midnight is handled properly.  wtc/pwc 694 1/7/2020
 ;
 S ARSDOA=$$FMTONET^SDECDATE(ARSDOA,"N") ;
 S ARDAM=ARDATA(FNUM,ARIEN_",",13.1,"E")     ;date appt. made
 S ARCLERK=ARDATA(FNUM,ARIEN_",",13.7,"I")   ;appt clerk ien
 S ARCLERKN=ARDATA(FNUM,ARIEN_",",13.7,"E")   ;appt clerk name
 S ARASD=""
 S:ARSDOA'="" $P(ARASD,"~~",1)=ARSDOA
 S:ARCLERK'="" $P(ARASD,"~~",12)=ARCLERK
 S:ARCLERKN'="" $P(ARASD,"~~",13)=ARCLERKN
 S:ARDAM'="" $P(ARASD,"~~",17)=ARDAM
 S ARSVCCON=ARDATA(FNUM,ARIEN_",",15,"E")
 S ARDAPTDT=ARDATA(FNUM,ARIEN_",",22,"I")
 S ARCOMM=ARDATA(FNUM,ARIEN_",",25,"I")
 ;S AREESTAT=ARDATA(FNUM,ARIEN_",",27,"I")
 S ARMAR=$$GET1^DIQ(409.85,ARIEN_",",41)
 S ARMAI=$$GET1^DIQ(409.85,ARIEN_",",42)
 S ARMAN=$$GET1^DIQ(409.85,ARIEN_",",43)
 S ARPC=$$WLPC^SDECAR1A(.ARDATA,ARIEN)
 S ARDISPD=ARDATA(FNUM,ARIEN_",",19,"E")
 S ARDISPU=ARDATA(FNUM,ARIEN_",",20,"I")
 S ARDISPUN=ARDATA(FNUM,ARIEN_",",20,"E")
 S APPTPTRS=$$GETAPPTS^SDECAR1A(ARIEN)
 S CHILDREN=$$CHILDREN^SDECAR1A(ARIEN)
 S ARMRTC=$$MRTC^SDECAR(ARIEN)
 S SDPARENT=ARDATA(FNUM,ARIEN_",",43.8,"I")
 S SDSENS=$$PTSEC^SDECUTL(DFN)
 S (SDI,SDMTRC)="" F  S SDI=$O(ARDATA(409.857,SDI)) Q:SDI=""  S SDMTRC=$S(SDMTRC'="":SDMTRC_"|",1:"")_ARDATA(409.857,SDI,.01,"E")
 S COUNT=COUNT+1
 ;     1     2    3    4    5    6    7       8          9        10         11
 S STR=DFN_U_""_U_""_U_""_U_""_U_""_U_ARIEN_U_ARORIGDT_U_ARINST_U_ARINSTNM_U_ARTYPE
 ;           12        13         14       15        16       17        18
 S STR=STR_U_ARCLIEN_U_ARCLNAME_U_ARUSER_U_ARUSRNM_U_ARPRIO_U_ARREQBY_U_ARPROV
 ;           19         20         21       22        23      24      25
 S STR=STR_U_ARPROVNM_U_ARDAPTDT_U_ARCOMM_U_ARENPRI_U_ARMAR_U_ARMAI_U_ARMAN
 ;           26       27        28;29        30         31        32         33
 S STR=STR_U_PRIGRP_U_ELIGIEN_U_ELIGNAME_U_SVCCONN_U_SVCCONNP_U_TYPEIEN_U_TYPENAME_U_ARPC
 ;           34        35        36         37         38   39   40   41   42
 S STR=STR_U_ARDISPD_U_ARDISPU_U_ARDISPUN_U_ARSVCCON_U_""_U_""_U_""_U_""_U_""
 ;           43   44   45    46      47       48                       57   (save 56 for SDSUB)
 S STR=STR_U_""_U_""_U_GAF_U_AREDT_U_SDMTRC_U_SDSENS_U_U_U_U_U_U_U_U_U_ARSTOP_U_ARSTOPN_U_ARASD
 S STR=STR_U_ARMRTC_U_PTPHONE_U_APPTYPE_U_SDPS_U_PRHBLOC_U_APPTPTRS_U_CHILDREN_U_SDPARENT
 D ARDEMO^SDECAR1A(.STR,DFN)  ;alb/sat 658 - get demographics
 S $P(STR,"^",119)=VAOSGUID ;  wtc patch 686 3/23/18 added for VAOS requests.  Revised to store in piece 119.
 S SDAPPT=$$CALLET^SDECAR1A(DFN,ARIEN)   ;CT *745 # OF CALLS MADE AND DATE LAST LETTER SENT
 S $P(STR,"^",120)=$P(SDAPPT,"^",1),$P(STR,"^",121)=$P(SDAPPT,"^",2)   ;SDCALL ^ SDCLET  *745
 S $P(STR,"^",122)=$P(SDAPPT,"^",3) ;813
 S $P(STR,"^",123)=$P(SDAPPT,"^",4) ;813
 S $P(STR,"^",124)=$P(SDAPPT,"^",5) ;813
 S @RET@(COUNT)=STR_$C(30)
 Q
 ;
ARGUID(RET,GUID)    ;
 ;
 ;  Return SDEC Appointment Request data for a VAOS Request GUID.
 ;
 ;  wtc SD*5.3*686  4/19/2018
 ;
 N FNUM,ARIEN,SDTMP,COUNT ;
 S RET="^TMP(""SDEC"","_$J_")" ;
 K @RET ;
 S FNUM=$$FNUM^SDECAR,COUNT=0 ;
 S ARIEN=$O(^SDEC(409.85,"GUID",GUID,0)) ;
 D HDR ;
 I ARIEN>0 D  ;
 . ;
 . ; wtc/mbs patch 694 7/24/18 added to check if user has access to VAOS requests
 . ;
 . N VAOSUSR ;
 . D OWNSKEY^XUSRB(.VAOSUSR,"SDECZ REQUEST") ;
 . ;
 . D ONEPAT ;
 G ARX ;
 ;
