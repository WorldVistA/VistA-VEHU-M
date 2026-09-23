GMVWTCK ;SLC/DANG - VITALS WEIGHT CHECK FROM PREVIOUS READINGS FOR A PATIENT ; Mar 14, 2025@08:30:32
 ;;5.0;GEN. MED. REC. - VITALS;**40**;Oct 31, 2002;Build 51
 ;
 ; Reference to EN^ORB3 in ICR #1362
 ; Reference to ALERT^FHGMVQAL in ICR #7137
 ; Reference to COMMA^%DTC in ICR #10000
 ; Reference to FMDIFF^XLFDT in ICR #10103
 ; Reference to ^PXD(811.9 in ICR #3148
 ; Reference to ^PXRM in ICR #2182
 ; Reference to ABS^XLFMTH in ICR #10105
 ;
GMVCHKWT(RETURN,DFN,GMVWT,GMVWTDT) ; Returned Patient's Latest Weight with Date/Time Taken and Weight gain/loss threshold
 ; RETURN:  Return variable.  Results are returned on the format
 ;          Patient's Congestive Heart Failure Flag (0 or 1)^Latest Weight reading^Date/Time taken^Weight change in pound~Percent Weight change^Weight thresholds
 ;          If there is no data or no weight threshold is met then an empty string ("") is returned.
 ; Input variables:
 ;  DFN: patient identifier from Patient File [#2]
 ;  GMVWT: Weight measure
 ;  GMVWTDT: date/time taken in FileMan format
 ;RETURN= 1^207^3191216.144716^43 lbs~20.77%^9.75%~20.18 lbs~90
 N GMVWTLAD,GMVWTLAT,GMVPTCHF,GMVWTALW,GMVCHFAL,GMVWHIT,GMVJ,GMVWTTHR,GMVDDIF
 N GMVWG,GMVWPERC,GMVWDIF,GMVTHRO,X,X3,GMVPCLB,GMVA,GMVPXRM,GMVPXRMA,I
 S (RETURN,GMVWG,GMVWPERC,GMVPCLB)="",GMVPTCHF=0
 ;Set up array to hold WT allowed Thresholds
 ;Assuming 1 mth is 30 days, 1 year is 365 days
 S GMVWTALW(30)=5_"%",GMVWTALW(90)=7.5_"%",GMVWTALW(180)=10_"%",GMVWTALW(365)=20_"%",GMVWTALW(1)=2_" lbs",GMVWTALW(7)=5_" lbs"
 S GMVCHFAL="2 lbs~7" ;WT Threshold for Congestive Heart Failure patient
 S GMVPXRM=$O(^PXD(811.9,"B","VA-CHF DIAGNOSIS","")) I GMVPXRM D FIDATA^PXRM(DFN,GMVPXRM,.GMVPXRMA)
 I $G(GMVPXRMA(1))>0 S GMVPTCHF=1
 D CLOSEST^GMVGETD(.GMVWTLAT,DFN,"","WT",1)
 I GMVWTLAT<0  Q  ;S RETURN="-2^Patient had no Weight on file" Q
 I '$P(GMVWTLAT,"^",2) Q  ;weight entered is 0
 S GMVWHIT=0
 S GMVWTLAD=$P(GMVWTLAT,"^"),GMVWTLAT=$P(GMVWTLAT,"^",2)
 S GMVDDIF=+$$FMDIFF^XLFDT(GMVWTLAD,GMVWTDT,1)
 S GMVDDIF=$TR(GMVDDIF,"-")
 I GMVDDIF>365 Q
 S GMVWDIF=GMVWT-GMVWTLAT,GMVWDIF=$TR(GMVWDIF,"-"),GMVWPERC=(GMVWDIF/GMVWTLAT)*100
 S X=GMVWPERC,X3=4 D COMMA^%DTC S GMVWPERC=X
 ;CHF Patient: Not  more than 2 lbs in 7days
 I GMVPTCHF,(GMVDDIF'>7),($$ABS^XLFMTH(GMVWT-GMVWTLAT))>2 S RETURN=GMVPTCHF_U_GMVWTLAT_U_GMVWTLAD_U_GMVWDIF_" lbs"_"~"_GMVWPERC_"%"_U_$$WTPERCLB(GMVCHFAL,GMVWTLAT,GMVWDIF)_"~"_$P(GMVCHFAL,"~",2) S GMVWHIT=1 Q
 F I=1,7 K GMVWTALW(I)
 S GMVJ=$O(GMVWTALW(GMVDDIF-1))
 I GMVJ="" S GMVJ=365
 S GMVWTTHR=GMVWTALW(GMVJ)
 S GMVTHRO=GMVWTALW(GMVJ)_"~"_GMVJ
 D CHKTHR(GMVWTTHR,.GMVWHIT,GMVWDIF,GMVWPERC)
 S GMVA=$$WTPERCLB(GMVTHRO,GMVWTLAT,GMVWDIF)
 I GMVWHIT S RETURN=GMVPTCHF_U_GMVWTLAT_U_GMVWTLAD_U_GMVWDIF_" lbs"_"~"_GMVWPERC_"%"_U_GMVA_"~"_$S(GMVDDIF'>365:GMVJ,1:GMVDDIF)
 Q
WTPERCLB(GMVTHRO,GMVLAT,GMVDIF) ;
 N GMVPRLB
 I GMVTHRO["%" S GMVPRLB=(GMVLAT*+GMVTHRO)/100 Q GMVPRLB_" lbs~"_$P(GMVTHRO,"~")
 I GMVTHRO["lb" S GMVPRLB=$J((+GMVDIF/GMVLAT)*100,0,2) Q $P(GMVTHRO,"~")_"~"_GMVPRLB_"%"
 Q
WTCALC(GMVMEA,GMVLAT,GMVTHR,GMVH,GMVDIFF,GMVWTPC)  ;Check against the WT gain/loss thresholds
 ;GMVTHR: Weight Thresholds for 1 month or 90 days, 180 days, or 1 year range
 ;GMVMEA: Current Weight Reading
 ;GMVLAT: latest WT on file
 ;GMVH  : FLAG 0=not exceeds the threshold,
 ;            1=exceeds the weight threshold
 ;
 N GMVWTCP,GMVCPVL
 S GMVWTCP=$S(GMVTHR["%":"%",1:"LBS")
 S GMVCPVL=$P(GMVTHR,U) S (GMVH,GMVDIFF,GMVWTPC)=""
 S GMVDIFF=GMVMEA-GMVLAT,GMVDIFF=$TR(GMVDIFF,"-")
 I GMVWTCP="%" S GMVWTPC=(GMVDIFF-GMVLAT)*100
 S GMVH=$S(GMVWTCP="%":GMVWTPC'<GMVCPVL,1:GMVDIFF'<GMVCPVL)
 Q
 ;
CHKTHR(GMVWTTH,GVHIT,GMVWDIF,GMVWTPC) ;
 N GMVWTCP,GMVCPVL
 S GMVWTCP=$S(GMVWTTH["%":"%",1:"LBS")
 S GMVCPVL=+GMVWTTH ;$P(GMVWTTH,U)
 S GVHIT=$S(GMVWTCP="%":GMVWTPC'<GMVCPVL,1:GMVWDIF>GMVCPVL)
 Q
 ;
WTNOTF(RETURN,DFN) ;Send notification
 ;Input Variable: Patient ID from Patient File #2
 ;Output Variable" null
 N GMVTEXT,GMVLOC,GMVLATI
 N GMVARR,XQA
 S GMVTEXT="Patient's Weight Change Exceeded threshold."
 ;Send Alert to providers
 ;97 is ORD IEN for WT ALERT in 100.9
 D EN^ORB3(97,DFN,"",,GMVTEXT)
 ;Send Alert to Dieticians
 S GMVLATI=$O(^GMR(120.5,"C",DFN,""),-1)
 S GMVLOC=$P(^GMR(120.5,GMVLATI,0),U,5)
 D ALERT^FHGMVQAL(DFN,GMVLOC)
 S RETURN=""
 Q
