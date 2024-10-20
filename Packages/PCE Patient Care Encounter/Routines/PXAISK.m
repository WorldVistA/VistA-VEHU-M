PXAISK ;ISL/PKR - Set the SKIN TEST nodes. ;May 29, 2019@14:38:01
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**45,124,210,211,217**;Aug 12, 1996;Build 134
 ;
SKIN ;Main entry point.
 ;
 K PXAERR
 S PXAERR(8)=PXAK
 S PXAERR(7)="SKIN TEST"
 ;
 N IND,PXAA
 S IND=""
 F  S IND=$O(@PXADATA@("SKIN TEST",PXAK,IND)) Q:IND=""  D
 . S PXAA(IND)=@PXADATA@("SKIN TEST",PXAK,IND)
 ;
 ;Validate the data.
 N STOP
 D VAL^PXAISKV
 I $G(STOP) Q
 ;
SETVARA ;Set the after visit variables.
 N AFTER0,AFTER12,AFTER13,AFTER80,AFTER811,AFTER812 ; modified by PX*1*210
 S $P(AFTER0,U,1)=$G(PXAA("TEST"))
 I $G(PXAA("DELETE")) S $P(AFTER0,U,1)="@"
 S $P(AFTER0,U,2)=$G(PATIENT)
 S $P(AFTER0,U,3)=$G(PXAVISIT)
 S $P(AFTER0,U,4)=$G(PXAA("RESULT"))
 S $P(AFTER0,U,5)=$G(PXAA("READING"))
 S $P(AFTER0,U,6)=$G(PXAA("D/T READ"))
 S $P(AFTER0,U,7)=$G(PXAA("READER")) ; PX*1*210
 ;Do not store diagnosis as of patch PX*1*211.
 ;S $P(AFTER80,U,1)=$G(PXAA("DIAGNOSIS")) ; modified by PX*1*210
 ;S $P(AFTER80,U,2)=$G(PXAA("DIAGNOSIS 2")) ; modified by PX*1*210
 ;S $P(AFTER80,U,3)=$G(PXAA("DIAGNOSIS 3")) ; modified by PX*1*210
 ;S $P(AFTER80,U,4)=$G(PXAA("DIAGNOSIS 4")) ; modified by PX*1*210
 ;S $P(AFTER80,U,5)=$G(PXAA("DIAGNOSIS 5")) ; modified by PX*1*210
 ;S $P(AFTER80,U,6)=$G(PXAA("DIAGNOSIS 6")) ; modified by PX*1*210
 ;S $P(AFTER80,U,7)=$G(PXAA("DIAGNOSIS 7")) ; modified by PX*1*210
 ;S $P(AFTER80,U,8)=$G(PXAA("DIAGNOSIS 8")) ; modified by PX*1*210
 S $P(AFTER12,U,1)=$G(PXAA("EVENT D/T"))
 S $P(AFTER12,U,2)=$G(PXAA("ORD PROVIDER")) ; PX*1*210
 S $P(AFTER12,U,4)=$G(PXAA("ENC PROVIDER"))
 S $P(AFTER12,U,8)=$G(PXAA("PLACEMENT"))
 S $P(AFTER12,U,12)=$G(PXAA("ANATOMIC LOC")) ; PX*1*210
 S $P(AFTER13,U,1)=$G(PXAA("READING COMMENT")) ; PX*1*210
 S $P(AFTER811,U,1)=$G(PXAA("COMMENT"))
 ;
 ;--PACKAGE AND SOURCE
 S $P(AFTER812,"^",2)=$S($G(PXAA("PKG"))'="":PXAA("PKG"),1:$G(PXAPKG))
 S $P(AFTER812,"^",3)=$S($G(PXAA("SOURCE"))'="":PXAA("SOURCE"),1:$G(PXASOURC))
 ;
 S ^TMP("PXK",$J,"SK",PXAK,0,"AFTER")=AFTER0
 S ^TMP("PXK",$J,"SK",PXAK,12,"AFTER")=AFTER12
 S ^TMP("PXK",$J,"SK",PXAK,13,"AFTER")=AFTER13 ; PX*1*210
 ;S ^TMP("PXK",$J,"SK",PXAK,80,"AFTER")=AFTER80 ; PX*1*210
 S ^TMP("PXK",$J,"SK",PXAK,811,"AFTER")=AFTER811
 S ^TMP("PXK",$J,"SK",PXAK,812,"AFTER")=AFTER812
 ;
SETVARB ;Set the before variables.
 N BEFOR0,BEFOR12,BEFOR13,BEFOR80,BEFOR811,BEFOR812 ; modified by PX*1*210
 N IENB
 ;
 S IENB=$$GETIEN(PXAVISIT,PXAA("TEST"))
 ;
 I $G(IENB) D
 . ; if placement skin test pointer is the current entry, no need to store it
 . I IENB=$G(PXAA("PLACEMENT")) S $P(^TMP("PXK",$J,"SK",PXAK,12,"AFTER"),U,8)=""
 . ;
 . S BEFOR0=$G(^AUPNVSK(IENB,0))
 . S BEFOR12=$G(^AUPNVSK(IENB,12))
 . S BEFOR13=$G(^AUPNVSK(IENB,13)) ; PX*1*210
 . S BEFOR80=$G(^AUPNVSK(IENB,80)) ; PX*1*210
 . S BEFOR811=$G(^AUPNVSK(IENB,811))
 . S BEFOR812=$G(^AUPNVSK(IENB,812))
 E  S (BEFOR0,BEFOR11,BEFOR12,BEFOR13,BEFOR80,BEFOR811,BEFOR812)="" ; modified by PX*1*210
 ;
 S ^TMP("PXK",$J,"SK",PXAK,0,"BEFORE")=BEFOR0
 S ^TMP("PXK",$J,"SK",PXAK,12,"BEFORE")=BEFOR12
 S ^TMP("PXK",$J,"SK",PXAK,13,"BEFORE")=BEFOR13 ; PX*1*210
 S ^TMP("PXK",$J,"SK",PXAK,80,"BEFORE")=BEFOR80 ; PX*1*210
 S ^TMP("PXK",$J,"SK",PXAK,811,"BEFORE")=BEFOR811
 S ^TMP("PXK",$J,"SK",PXAK,812,"BEFORE")=BEFOR812
 S ^TMP("PXK",$J,"SK",PXAK,"IEN")=IENB
 ;
 ;Package and Data Source cannot be edited.
 S BEFOR812=^TMP("PXK",$J,"SK",PXAK,812,"BEFORE")
 I BEFOR812'="" D
 . I AFTER812=BEFOR812 Q
 . I $P(BEFOR812,U,2)'="" S $P(AFTER812,U,2)=$P(BEFOR812,U,2)
 . I $P(BEFOR812,U,3)'="" S $P(AFTER812,U,3)=$P(BEFOR812,U,3)
 . S ^TMP("PXK",$J,"SK",PXAK,812,"AFTER")=AFTER812
 Q
 ;
GETIEN(PXAVISIT,PXASK) ;
 ;
 N PXAIEN,PXASKNM,PXBCNT,PXBKY,PXBSKY,PXBSAM
 ;
 S PXAIEN=""
 ;
 D SK^PXBGSK(PXAVISIT)
 I PXBCNT>0 D
 . S PXASKNM=$P($G(^AUTTSK(PXASK,0)),U,1)
 . S PXAIEN=$O(PXBKY(PXASKNM,PXAIEN))
 ;
 Q PXAIEN
