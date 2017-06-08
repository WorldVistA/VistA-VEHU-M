VEJDWPD0 ;wpb/swo routine modified for dental GUI;8.2.98
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ; slc/CLA - Functions which return PCE data ;12/15/97 [ 04/02/97  3:54 PM ]
 ;ORQQPX;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 Q
IMMLIST(ORY,ORPT) ;return pt's immunization list:
 ;id^name^date/time^reaction^inverse d/t
 I $L($T(IMMUN^VEJDWPD1))<1 S ORY(1)="^Immunizations not available." Q
 K ^TMP("PXI",$J)
 D IMMUN^VEJDWPD1(ORPT)
 N ORI,IMM,IVDT,IEN,X
 S ORI=0,IMM="",IVDT="",IEN=0
 F  S IMM=$O(^TMP("PXI",$J,IMM)) Q:IMM=""  D
 .F  S IVDT=$O(^TMP("PXI",$J,IMM,IVDT)) Q:IVDT=""  D
 ..F  S IEN=$O(^TMP("PXI",$J,IMM,IVDT,IEN)) Q:IEN<1  D
 ...S ORI=ORI+1,X=$G(^TMP("PXI",$J,IMM,IVDT,IEN,0)) Q:'$L(X)
 ...S ORY(ORI)=IEN_U_IMM_U_$P(X,U,3)
 ...I $P(X,U,7)=1 S ORY(ORI)=ORY(ORI)_U_$P(X,U,6)_U_IVDT
 ...E  S ORY(ORI)=ORY(ORI)_U_U_IVDT
 S:+$G(ORY(1))<1 ORY(1)="^No immunizations found.^2900101^^9999999"
 K ^TMP("PXI",$J)
 Q
DETAIL(ORY,IMM) ; return detailed information for an immunization
 S ORY(1)="Detailed information on immunizations is not available."
 Q
REMIND(ORY,ORPT) ;return pt's currently due PCE clinical reminders
 ; in the format file 811.9 ien^reminder print name^date due^last occur.
 N ORSRV,TMPLST,ERR,ORI,ORJ,ORIEN,ORTXT,ORX,ORLASTDT,ORDUEDT,ORLOC
 S ORJ=0
 ;
 ;get patient's location flag (INPATIENT ONLY - outpt locations cannot be
 ;reliably determined, and many simultaneous outpt locations can occur):
 I +$G(ORPT)>0 D
 .N DFN S DFN=ORPT,VA200="" D OERR^VADPT
 .I +$G(VAIN(4))>0 S ORLOC=+$G(^DIC(42,+$G(VAIN(4)),44))
 .K VA200,VAIN
 ;
 S ORSRV=$G(^VA(200,DUZ,5)) I +ORSRV>0 S ORSRV=$P(ORSRV,U)
 ;D GETLST^XPAR(.TMPLST,"USR^LOC.`"_$G(ORLOC)_"^SRV.`"_+$G(ORSRV)_"^DIV^SYS^PKG","ORQQPX SEARCH ITEMS","Q",.ERR)
 I ERR>0 S ORY(1)=U_"Error: "_$P(ERR,U,2) Q
 S ORI=0 F  S ORI=$O(TMPLST(ORI)) Q:'ORI  D
 .S ORIEN=$P(TMPLST(ORI),U,2)
 .K ^TMP("PXRHM",$J)
 .D MAIN^PXRM(ORPT,ORIEN,0)
 .S ORTXT="",ORTXT=$O(^TMP("PXRHM",$J,ORIEN,ORTXT)) Q:ORTXT=""  D
 ..S ORX=^TMP("PXRHM",$J,ORIEN,ORTXT)
 ..S ORDUEDT=$P(ORX,U,2),ORLASTDT=$P(ORX,U,3)
 ..S ORLASTDT=$S(+$G(ORLASTDT)>0:ORLASTDT,1:"")  ;null if not a date
 ..S ORJ=ORJ+1
 ..S ORY(ORJ)=ORIEN_U_ORTXT_U_ORDUEDT_U_ORLASTDT
 .K ^TMP("PXRHM",$J)
 Q
REMDET(ORY,ORPT,ORIEN) ;return detail for a pt's clinical reminder
 ; ORY - return array
 ; ORPT - patient DFN
 ; ORIEN - clinical reminder (811.9 ien)
 K ^TMP("PXRHM",$J)
 D MAIN^PXRM(ORPT,ORIEN,5)     ; 5 returns all reminder info
 N CR,I,J,ORTXT S I=1
 S ORTXT="",ORTXT=$O(^TMP("PXRHM",$J,ORIEN,ORTXT)) Q:ORTXT=""  D
 .S J=0 F  S J=$O(^TMP("PXRHM",$J,ORIEN,ORTXT,"TXT",J)) Q:J=""  D
 ..S ORY(I)=^TMP("PXRHM",$J,ORIEN,ORTXT,"TXT",J),I=I+1
 K ^TMP("PXRHM",$J)
 Q
