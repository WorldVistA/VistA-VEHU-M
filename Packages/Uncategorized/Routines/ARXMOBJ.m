ARXMOBJ ;SHR/JT;miscellaneous objects for TIU [7/31/02 8:20am]
 ;
 ;no top level entry
 Q
 ;
GAF(DFN) ;gaf display
 ;
 S REC=$$RET^YSGAF(DFN)
 I REC]"",REC=-1 S RC="Last GAF Score: None" Q RC
 I REC]"" S Y=$P(REC,U,2) X ^DD("DD") S RC="Last GAF Score: "_$P(REC,U)_" on "_Y_" by "_$P(^VA(200,$P(REC,U,3),0),U)
 Q RC
 ;
BSA(DFN) ;body surface area
 ;
 S AOAWT=$$WEIGHT^TIULO(DFN),AOAHT=$$HEIGHT^TIULO(DFN)
 S AOAWT=+$P(AOAWT,"[",2),AOAHT=+$P(AOAHT,"[",2)
 I AOAWT<1!(AOAHT<1) Q "Body Surface Area: Missing Height or Weight"
 S AOABSA=(AOAWT*AOAHT)/3600,%X=AOABSA
 D SQRT^XTFN
 S AOABSA="Body Surface Area: "_$J(%Y,5,2)
 Q AOABSA
