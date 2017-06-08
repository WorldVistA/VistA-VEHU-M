ALS6TIU ;LL/ELZ  TIU ROUTINE
 ;;1.0
ASI(YSASPIEN,TARGET) ; -- object to look up addiction severity index history
 ; national option for this lookup is YSAS ASI PRINT
 ; input YSASPIEN as the patient DFN
 N ALSMSG,LINE,YSASC
 S LINE=0
 D TLD^YSASSEL
 I '$D(^TMP($J,"YSASI")) D  D TOP Q "~@"_$NA(@TARGET)
 . S LINE=1,@TARGET@(1,0)="No Addiction Severity Index History"
 S YSASC=0
 F  S YSASC=$O(^TMP($J,"YSASI",YSASC)) Q:YSASC'>0  D
 . S YSASG=^TMP($J,"YSASI",YSASC)
 . S ALSMSG=$J(YSASC,3)_" "
 . S ALSMSG=$$SPACE^AOVTIU(ALSMSG_$$FMTE^XLFDT($P(YSASG,U,2),"5ZD"),18)
 . S ALSMSG=$$SPACE^AOVTIU(ALSMSG_$P(YSASG,U,3),28)
 . S ALSMSG=$$SPACE^AOVTIU(ALSMSG_$P(YSASG,U,4),55)
 . S ALSMSG=ALSMSG_$S($P(YSASG,U,5)=1:"Signed",1:"## Not Signed ##")
 . D SET(ALSMSG)
 Q "~@"_$NA(@TARGET)
TOP ; -- called to set the top part of a multi lined object
 S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 Q
SET(TEXT) ;-- used to set the temp global
 W "."
 S LINE=LINE+1
 S @TARGET@(LINE,0)=TEXT
 Q
CITYST(DFN) ; -- single valued object to return just the pt's city, state
 N VAPA,VAERR
 D ADD^VADPT
 S:VAPA(5) VAPA(5)=$P($G(^DIC(5,+VAPA(5),0)),U,2)
 Q VAPA(4)_", "_VAPA(5)
MARRIED(DFN) ; -- single valued object to return marital status
 N VADM,VAERR,VA
 D DEM^VADPT
 Q $P(VADM(10),U,2)
