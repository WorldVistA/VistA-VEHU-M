PXKVST ;ISL/ARS - SET UP VISIT FIELDS BEFORE CALLING OFF TO VSIT ;08/20/2023
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**56,111,130,164,168,211,238**;Aug 12, 1996;Build 3
VSIT ;ENTRY POINT 
 ;COMMON SECTION
 N PXKAFTR,PXKAFT8,PXKAFT15,PXKAFT21,PXKAF811,PXKAF812,PXVSTIEN
 N VSIT,VSITPKG
 S PXKAFTR=$S($G(^TMP("PXK",$J,"VST",1,0,"AFTER"))]"":^TMP("PXK",$J,"VST",1,0,"AFTER"),1:"")
 Q:PXKAFTR=""
 S PXKAFT21=$S($G(^TMP("PXK",$J,"VST",1,21,"AFTER"))]"":^TMP("PXK",$J,"VST",1,21,"AFTER"),1:"")
 S PXKAFT15=$S($G(^TMP("PXK",$J,"VST",1,150,"AFTER"))]"":^TMP("PXK",$J,"VST",1,150,"AFTER"),1:"")
 S PXKAFT8=$S($G(^TMP("PXK",$J,"VST",1,800,"AFTER"))]"":^TMP("PXK",$J,"VST",1,800,"AFTER"),1:"")
 S PXKAF811=$S($G(^TMP("PXK",$J,"VST",1,811,"AFTER"))]"":^TMP("PXK",$J,"VST",1,811,"AFTER"),1:"")
 S PXKAF812=$S($G(^TMP("PXK",$J,"VST",1,812,"AFTER"))]"":^TMP("PXK",$J,"VST",1,812,"AFTER"),1:"")
 S VSIT("IEN")=$S(^TMP("PXK",$J,"VST",1,"IEN")]"":^TMP("PXK",$J,"VST",1,"IEN"),1:"")
 I VSIT("IEN")="" S PXKAFTR=$TR(PXKAFTR,"@"),PXKAFT8=$TR(PXKAFT8,"@")
 S VSIT("VDT")=$S($P(PXKAFTR,"^",1)]"":$P(PXKAFTR,"^",1),1:"NOW")
 S VSIT("TYP")=$P(PXKAFTR,"^",3)
 S VSIT("INS")=$P(PXKAFTR,"^",6)
 S VSIT("OUT")=$P(PXKAFT21,"^")
 S VSIT("PAT")=$P(PXKAFTR,"^",5)
 S VSIT("SVC")=$P(PXKAFTR,"^",7)
 S VSIT("DSS")=$P(PXKAFTR,"^",8)
 S VSIT("LNK")=$P(PXKAFTR,"^",12)
 S VSIT("WIA")=$P(PXKAFTR,"^",16)
 S VSIT("LOS")=$P(PXKAFTR,"^",17)
 S VSIT("COD")=$P(PXKAFTR,"^",18)
 S:$P(PXKAFTR,"^",21)]"" VSIT("ELG")=$P(PXKAFTR,"^",21)
 S VSIT("LOC")=$P(PXKAFTR,"^",22)
 S VSIT("USR")=$P(PXKAFTR,"^",23)
 S VSIT("ACT")=$P(PXKAFTR,"^",26) ;PX*1.0*164
 S:$P(PXKAFT8,"^",1)]"" VSIT("SC")=$P(PXKAFT8,"^",1)
 S:$P(PXKAFT8,"^",2)]"" VSIT("AO")=$P(PXKAFT8,"^",2)
 S:$P(PXKAFT8,"^",3)]"" VSIT("IR")=$P(PXKAFT8,"^",3)
 S:$P(PXKAFT8,"^",4)]"" VSIT("EC")=$P(PXKAFT8,"^",4)
 S:$P(PXKAFT8,"^",5)]"" VSIT("MST")=$P(PXKAFT8,"^",5) ;added 6/17/98 for MST enhancement
 ;PX*1*111 - added for HNC enhancement
 S:$P(PXKAFT8,"^",6)]"" VSIT("HNC")=$P(PXKAFT8,"^",6)
 S:$P(PXKAFT8,"^",7)]"" VSIT("CV")=$P(PXKAFT8,"^",7)
 S:$P(PXKAFT8,"^",8)]"" VSIT("SHAD")=$P(PXKAFT8,"^",8)
 S:$P(PXKAFT15,"^",1)]"" VSIT("SVP")=$P(PXKAFT15,"^",1)
 S:$P(PXKAFT15,"^",2)]"" VSIT("IO")=$P(PXKAFT15,"^",2)
 S:$P(PXKAFT15,"^",3)]"" VSIT("PRI")=$P(PXKAFT15,"^",3)
 S:$P(PXKAF812,"^",2)]"" VSIT("PKG")=$P(PXKAF812,"^",2)
 S:$P(PXKAF812,"^",3)]"" VSIT("SOR")=$P(PXKAF812,"^",3)
 S:PXKAF811]"" VSIT("COM")=PXKAF811
 S VSITPKG=$G(VSIT("PKG"))
 I $G(VSIT("PRI"))="",VSIT("SVC")="E"!($P($G(^SC(+VSIT("LOC"),0)),"^",7)=VSIT("DSS")) S VSIT("PRI")="P"
 ;If ^TMP("PXK",$J,"VISITCREATE")="F" then in CALL^PXAIVST, FINDVISIT^PXUTLVST could not find an existing visit so
 ;force the creation of a new one.
 I $G(^TMP("PXK",$J,"VISITCREATE"))="F" S VSIT(0)=$S(VSIT("SVC")="E":"F",1:"EF")
 I '$D(VSIT(0)) S VSIT(0)=$S(VSIT("SVC")="E":"D0NM",1:"D0NEM")
 ;
 ;CALL FOR VSIT
 D ^VSIT
 I '$D(VSIT("IEN"))#2 Q
 S PXVSTIEN=$P(VSIT("IEN"),"^",1)
 S ^TMP("PXK",$J,"VST",1,"IEN")=PXVSTIEN
 I PXVSTIEN<1 Q
 D VIEN(PXVSTIEN)
 I $P(VSIT("IEN"),"^",3)'=1 D
 .S ^TMP("PXK",$J,"VST",1,0,"BEFORE")=^AUPNVSIT(PXVSTIEN,0)
 .S ^TMP("PXK",$J,"VST",1,21,"BEFORE")=$G(^AUPNVSIT(PXVSTIEN,21))
 .S ^TMP("PXK",$J,"VST",1,150,"BEFORE")=$G(^AUPNVSIT(PXVSTIEN,150))
 .S ^TMP("PXK",$J,"VST",1,800,"BEFORE")=$G(^AUPNVSIT(PXVSTIEN,800))
 .S ^TMP("PXK",$J,"VST",1,811,"BEFORE")=$G(^AUPNVSIT(PXVSTIEN,811))
 .S ^TMP("PXK",$J,"VST",1,812,"BEFORE")=$G(^AUPNVSIT(PXVSTIEN,812))
 .S $P(^TMP("PXK",$J,"VST",1,0,"AFTER"),"^",3)=$P(^AUPNVSIT(PXVSTIEN,0),"^",3)
 .S $P(^TMP("PXK",$J,"VST",1,0,"AFTER"),"^",7)=$P(^AUPNVSIT(PXVSTIEN,0),"^",7)
 I $P(VSIT("IEN"),"^",3)=1 D
 .S ^TMP("PXK",$J,"VST",1,0,"AFTER")=^AUPNVSIT(PXVSTIEN,0)
 .S ^TMP("PXK",$J,"VST",1,21,"AFTER")=$G(^AUPNVSIT(PXVSTIEN,21))
 .S ^TMP("PXK",$J,"VST",1,150,"AFTER")=$G(^AUPNVSIT(PXVSTIEN,150))
 .S ^TMP("PXK",$J,"VST",1,800,"AFTER")=$G(^AUPNVSIT(PXVSTIEN,800))
 .S ^TMP("PXK",$J,"VST",1,811,"AFTER")=$G(^AUPNVSIT(PXVSTIEN,811))
 .S ^TMP("PXK",$J,"VST",1,812,"AFTER")=$G(^AUPNVSIT(PXVSTIEN,812))
 .S ^TMP("PXK",$J,"VST",1,0,"BEFORE")=""
 .S ^TMP("PXK",$J,"VST",1,21,"BEFORE")=""
 .S ^TMP("PXK",$J,"VST",1,150,"BEFORE")=""
 .S ^TMP("PXK",$J,"VST",1,800,"BEFORE")=""
 .S ^TMP("PXK",$J,"VST",1,811,"BEFORE")=""
 .S ^TMP("PXK",$J,"VST",1,812,"BEFORE")=""
 .I $D(PXELAP)#2 D
 ..S ^TMP("PXKCO",$J,PXVSTIEN,"VST",PXVSTIEN,"ELAP","BEFORE")=""
 ..S ^TMP("PXKCO",$J,PXVSTIEN,"VST",PXVSTIEN,"ELAP","AFTER")=PXELAP
 K VSIT
 Q
 ;
VIEN(VIEN) ;Put the Visit IEN in the AFTERs for all of the V-Files
 N PXCAINX1,PXCAINX2
 S PXCAINX1=""
 F  S PXCAINX1=$O(^TMP("PXK",$J,PXCAINX1)) Q:PXCAINX1']""  D:"^VST^SOR^"'[PXCAINX1
 . S PXCAINX2=""
 . F  S PXCAINX2=$O(^TMP("PXK",$J,PXCAINX1,PXCAINX2)) Q:PXCAINX2']""  D
 .. I $D(^TMP("PXK",$J,PXCAINX1,PXCAINX2,0,"AFTER"))=1 S $P(^TMP("PXK",$J,PXCAINX1,PXCAINX2,0,"AFTER"),"^",3)=VIEN
 Q
 ;
