OOPSPC41 ;HIRMFO/YH-EMPLOYEE DATA, CA2 FORM ;6/14/98
 ;;1.0;ASISTS;**1,4,6,8**;Jun 01, 1998
 ;EMPLOYEE DATA
 ;EMPLOYEE'S DATA
 S OOPSDATA=$P($G(^OOPS(2260,IEN,0)),"^",2)
 W !,"PU0.8,25.5;LB"_OOPSDATA_"@;" ;NAME
 S OOPSDATA=$G(^OOPS(2260,IEN,"2162A"))
 S OOPSP=$P(OOPSDATA,"^") I OOPSP'["-" S OOPSP=$E(OOPSP,1,3)_"-"_$E(OOPSP,4,5)_"-"_$E(OOPSP,6,13)
 W !,"PU15.9,25.5;LB"_OOPSP_"@;" ;SSN
 S OOPSP=$P(OOPSDATA,"^",2) I OOPSP'="" D WDATE^OOPSPUT1(OOPSP,"3.1,24.8","3.9,24.8","4.8,24.8") ;DATE OF BIRTH
 S OOPSP=$P(OOPSDATA,"^",3) W !,"PU6.5,24.7;LB"_$S(OOPSP=1:"Male",OOPSP=2:"Female",1:" ")_"@;" ;SEX
 N PHN
 S PHN=$TR($P(OOPSDATA,"^",8),"/-*#","")
 W !,"PU8.7,24.7;LB"_$E(PHN,1,3)_"-"_$E(PHN,4,6)_"-",$E(PHN,7,10)_"@;"
 W !,"PU16.6,24.7;LB"_$S($P(OOPSDATA,"^",12)'="":+$P(OOPSDATA,"^",12),1:"")_"@;PU18.7,24.7;LB"_$P(OOPSDATA,"^",13)_"@;" ;GRADE AND STEP
 W !,"PU0.8,23.5;LB"_$P(OOPSDATA,"^",4)_"@;PU0.8,22.7;LB"_$P(OOPSDATA,"^",5)_", "_$S($D(^DIC(5,+$P(OOPSDATA,"^",6),0)):$P(^DIC(5,+$P(OOPSDATA,"^",6),0),"^"),1:"")_"@"
 W !,"PU12.8,22.7;LB"_$P(OOPSDATA,"^",7)_"@;" ;ADDRESS
 S OOPSP=+$P($G(^OOPS(2260,IEN,"CA2A")),"^",8) ;DEPENDENTS
 I OOPSP>0,OOPSP<6 W !,$S(OOPSP=1:"PU16.2,23.8;LBX@;",OOPSP=2:"PU16.2,23.4;LBX@;",OOPSP=3:"PU16.2,23;LBX@;",OOPSP=4:"PU16.2,23.8;LBX@;PU16.2,23.4;LBX@;",OOPSP=5:"PU16.2,23.8;LBX@;PU16.2,23;LBX@;",1:"")
 I OOPSP>5,OOPSP<8 W !,$S(OOPSP=6:"PU16.2,23.4;LBX@;PU16.2,23;LBX@;",1:"PU16.2,23.8;LBX@;PU16.2,23.4;LBX@;PU16.2,23;LBX@;")
 W !,"PU0.8,20.9;LB"_$P($G(^OOPS(2260,IEN,"CA2A")),"^",9)_"@;"
 ; Patch 8
 S OCC=$$GET1^DIQ(2260,IEN,15,"E")
 S OCC=$S(OCC<2200:"G"_OCC,(OCC>2499&(OCC<9001)):"W"_OCC,(OCC=9999):"Z"_OCC,1:"")
 W "PU16.2,21.1;LB"_OCC_"@;" K OCC        ; OCCUPATION CODE
 S OOPSDATA=$G(^OOPS(2260,IEN,"CA2B"))
 W !,"PU0.8,19.7;LB"_$P(OOPSDATA,"^")_"    "_$P(OOPSDATA,"^",2)_"@;" ;LOCATION ILLNESS OCCURRED
 W !,"PU0.8,18.8;LB"_$P(OOPSDATA,"^",3)_", "_$P($G(^DIC(5,+$P(OOPSDATA,"^",4),0)),"^")_" "_$P(OOPSDATA,"^",5)_"@;"
 S OOPSP=$P(OOPSDATA,"^",6) I OOPSP'="" D WDATE^OOPSPUT1(OOPSP,"16.5,18.8","17.4,18.8","18.1,18.8") ;DATE AWARE OF ILLNESS
 S OOPSP=$P(OOPSDATA,"^",7) I OOPSP'="" D WDATE^OOPSPUT1(OOPSP,"4.9,17.5","5.8,17.5","6.5,17.5") ;DATE REALIZED ILLNESS CAUSED BY EMPLOYMENT
 ;EXPLAIN THE RELATIONSHIP TO YOUR EMPLOYMENT
 S OOPSNODE="CA2C",OOPSDIWL=1,OOPSDIWR="",OOPSDIWF="C100",OOPSBS=6
 S OOPSSEL="W !,$S(II=1:""PU0.8,16.9;LB"",II=2:""PU0.8,16.5;LB"",II=3:""PU0.8,16.1;LB"",II=4:""PU0.8,15.7;LB"",II=5:""PU0.8,15.3;LB"",II=6:""PU0.8,14.9;LB"",1:"""")_$G(^UTILITY($J,""W"",1,II,0))_""@;"""
 S OOPSAT="W !,""PU7.9,17.6;LBSee Attached@;"""
 S OOPSLBL="13. Explain the relationship to your employment, and why you came to this realization."
 I $D(^OOPS(2260,IEN,OOPSNODE,0)) D
 .D WP^OOPSPCA(OOPSDIWL,OOPSDIWR,OOPSDIWF,OOPSBS,OOPSNODE,OOPSSEL,OOPSAT,OOPSLBL)
 ;NATURE OF DISEASE OR ILLNESS
 S OOPSNODE="CA2D",OOPSDIWL=1,OOPSDIWR="",OOPSDIWF="C85",OOPSBS=3
 S OOPSSEL="W !,$S(II=1:""PU1,13.7;LB"",II=2:""PU1,13.3;LB"",II=3:""PU1,12.9;LB"",1:"""")_$G(^UTILITY($J,""W"",1,II,0))_""@;"""
 S OOPSAT="W !,""PU1,13.6;LBSee Attached@;"""
 S OOPSLBL="14. Nature of disease or illness."
 I $D(^OOPS(2260,IEN,OOPSNODE,0)) D
 .D WP^OOPSPCA(OOPSDIWL,OOPSDIWR,OOPSDIWF,OOPSBS,OOPSNODE,OOPSSEL,OOPSAT,OOPSLBL)
 ; Patch 8 - add NOI code, type and source code
 S OOPSNOI=$$GET1^DIQ(2260,IEN,"62:1")
 S OOPSTYP=$$GET1^DIQ(2260,IEN,"226:1")
 S OOPSSOR=$$GET1^DIQ(2260,IEN,"227:1")
 W "PU16.2,13.9;LB"_OOPSNOI_"@;"
 W !,"PU16.2,13.0;LB"_OOPSTYP_"@;"_"PU18.0,13.0;LB"_OOPSSOR_"@;"
 K OOPSNOI,OOPSTYP,OOPSSOR
 ;REASON FOR THE DELAY
 S OOPSNODE="CA2E",OOPSDIWL=1,OOPSDIWR="",OOPSDIWF="C100",OOPSBS=3
 S OOPSSEL="W !,$S(II=1:""PU1,12;LB"",II=2:""PU1,11.6;LB"",II=3:""PU1,11.2;LB"",1:"""")_$G(^UTILITY($J,""W"",1,II,0))_""@;"""
 S OOPSAT="W !,""PU1,12;LBSee Attached@;"""
 S OOPSLBL="15. If this notice and claim was not filed with the employing agency within"
 I $D(^OOPS(2260,IEN,OOPSNODE,0)) D
 .D WP^OOPSPCA(OOPSDIWL,OOPSDIWR,OOPSDIWF,OOPSBS,OOPSNODE,OOPSSEL,OOPSAT,OOPSLBL)
 S OOPSNODE="CA2F",OOPSDIWL=1,OOPSDIWR="",OOPSDIWF="C100",OOPSBS=3
 S OOPSSEL="W !,$S(II=1:""PU1,10.3;LB"",II=2:""PU1,9.9;LB"",II=3:""PU1,9.5;LB"",1:"""")_$G(^UTILITY($J,""W"",1,II,0))_""@;"""
 S OOPSAT="W !,""PU1,10.3LBSee Attached@;"""
 S OOPSLBL="16. If the statement requested in item 1 of the attached instructions is not"
 I $D(^OOPS(2260,IEN,OOPSNODE,0)) D
 .D WP^OOPSPCA(OOPSDIWL,OOPSDIWR,OOPSDIWF,OOPSBS,OOPSNODE,OOPSSEL,OOPSAT,OOPSLBL)
 ;ITEM 2 OF ATTACHED INSTRUCTIONS ARE NOT SUBMITTED
 S OOPSNODE="CA2G",OOPSDIWL=1,OOPSDIWR="",OOPSDIWF="C100",OOPSBS=3
 S OOPSSEL="W !,$S(II=1:""PU1,8.6;LB"",II=2:""PU1,8.2;LB"",II=3:""PU1,7.8;LB"",1:"""")_$G(^UTILITY($J,""W"",1,II,0))_""@;"""
 S OOPSAT="W !,""PU1,8.6LBSee Attached@;"""
 S OOPSLBL="17. If the medical reports requested in item 2 of attached instructions"
 I $D(^OOPS(2260,IEN,OOPSNODE,0)) D
 .D WP^OOPSPCA(OOPSDIWL,OOPSDIWR,OOPSDIWF,OOPSBS,OOPSNODE,OOPSSEL,OOPSAT,OOPSLBL)
 ; Patch 8, e-sign encrypted, make sure data valid when printing
 N X,X1,X2,STR,VER
 S STR=$G(^OOPS(2260,IEN,"CA")),VER=$P(STR,"^",9),X=$P(STR,"^",7)
 I $G(VER)=1&($G(X)'="") D
 . S X1=$$GET1^DIQ(2260,IEN,221,"I"),X2=$$CA2SUM^OOPSUTL6()
 . D DE^XUSHSHP
 . W !,"PU9.5,4.5;LB/ES/ "_X_"@;"
 S OOPSDATA=$G(^OOPS(2260,IEN,"CA2ES"))
 I $P(OOPSDATA,"^",2)'="",+$P(OOPSDATA,"^",3)>0 W !,"PU17.3,4.5;LB"_$$FMTE^XLFDT($P(OOPSDATA,"^",3),1)_"@;" ;DATE SIGNED
 K I,J,OOPSQ Q
