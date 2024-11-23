ONCOXA3 ; GENERATED FROM 'ONCOXA3' PRINT TEMPLATE (#1259) ; 11/22/24 ; (FILE 165.5, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 X ^DD("DD")
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 S I(0)="^ONCO(165.5,",J(0)=165.5
 D N:$X>2 Q:'DN  W ?2 W "Diagnostic confirmation: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,6) W:Y]"" $E($$SET^DIQ(165.5,26,Y),1,46)
 D N:$X>2 Q:'DN  W ?2 W "Tumor size: "
 S X=$G(^ONCO(165.5,D0,0)) W ?16 S Y=$P(X,U,8) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Extension: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,10) S Y(0)=Y S ONCOX="E",ONCFLD=30 D OT^ONCODEL W $J(Y,2)
 D N:$X>2 Q:'DN  W ?2 W "Regional lymph nodes positive: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,12) S Y(0)=Y D RNP^ONCOOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Regional lymph nodes examined: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,13) S Y(0)=Y D RNE^ONCOOT W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Lymph nodes: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,11) S Y(0)=Y S ONCOX="L" D OT^ONCODEL W $J(Y,2)
 D N:$X>2 Q:'DN  W ?2 W "SEER Summary Stage 2000: "
 S X=$G(^ONCO(165.5,D0,2)) S Y=$P(X,U,17) W:Y]"" $E($$SET^DIQ(165.5,35,Y),1,35)
 D N:$X>2 Q:'DN  W ?2 W "Sites of metastases: "
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,14) W:Y]"" $E($$SET^DIQ(165.5,34,Y),1,19)
 D N:$X>43 Q:'DN  W ?43 S Y=$P(X,U,15) W:Y]"" $E($$SET^DIQ(165.5,34.1,Y),1,19)
 D N:$X>63 Q:'DN  W ?63 S Y=$P(X,U,16) W:Y]"" $E($$SET^DIQ(165.5,34.2,Y),1,15)
 D N:$X>2 Q:'DN  W ?2 W "Clinical TNM:     "
 D N:$X>20 Q:'DN  W ?20 S STGIND="C",X=$$TNMOUT^ONCOTNO(D0) W $E(X,1,12) K Y(165.5,37)
 D N:$X>39 Q:'DN  W ?39 W "Pathologic TNM:  "
 D N:$X>59 Q:'DN  W ?59 S STGIND="P",X=$$TNMOUT^ONCOTNO(D0) W $E(X,1,12) K Y(165.5,89.1)
 D N:$X>2 Q:'DN  W ?2 W "AJCC Stage (Clin):  "
 S X=$G(^ONCO(165.5,D0,2)) D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,20) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 D N:$X>39 Q:'DN  W ?39 W "AJCC Stage (Path):  "
 S X=$G(^ONCO(165.5,D0,2.1)) D N:$X>59 Q:'DN  W ?59 S Y=$P(X,U,4) S Y(0)=Y S X="" D OT^ONCOTNS W $E(Y,1,30)
 D N:$X>29 Q:'DN  W ?29 W " " K DIP K:DN Y
 D N:$X>2 Q:'DN  W ?2 W "FIRST COURSE OF TREATMENT SUMMARY:"
 D N:$X>2 Q:'DN  W ?2 W "Dx/Staging/Palliative Proc: "
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,27) S Y(0)=Y D NCDSOT^ONCODSR W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "Date First Surgical Procedure: "
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,38) S Y(0)=Y S X=Y D DATEOT^ONCOES W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "RX Summ--Surg Primsite 03-2022: "
 S X=$G(^ONCO(165.5,D0,3.1)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,29) S Y(0)=Y S FIELD=58.6 D SPSOT^ONCOSUR W $E(Y,1,30)
 D N:$X>2 Q:'DN  W ?2 W "RX Summ--Surg Prim Site 2023: "
 S X=$G(^ONCO(165.5,D0,3.2)) D N:$X>33 Q:'DN  W ?33,$E($P(X,U,9),1,4)
 D N:$X>2 Q:'DN  W ?2 W "Surgical Margins: "
 S X=$G(^ONCO(165.5,D0,3)) D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,28) W:Y]"" $E($$SET^DIQ(165.5,59,Y),1,26)
 D N:$X>2 Q:'DN  W ?2 W "Reason for no surgery: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,26) W:Y]"" $E($$SET^DIQ(165.5,58,Y),1,43)
 D N:$X>2 Q:'DN  W ?2 W "Radiation: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,6) W:Y]"" $E($$SET^DIQ(165.5,51.2,Y),1,32)
 D N:$X>2 Q:'DN  W ?2 W "Radiation Sequence: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,7) W:Y]"" $E($$SET^DIQ(165.5,51.3,Y),1,45)
 D N:$X>2 Q:'DN  W ?2 W "Reason for no radiation: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,35) W:Y]"" $E($$SET^DIQ(165.5,75,Y),1,39)
 D N:$X>2 Q:'DN  W ?2 W "Chemotherapy: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,13) W:Y]"" $E($$SET^DIQ(165.5,53.2,Y),1,39)
 D N:$X>2 Q:'DN  W ?2 W "Hormone Therapy: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,16) W:Y]"" $E($$SET^DIQ(165.5,54.2,Y),1,39)
 D N:$X>2 Q:'DN  W ?2 W "Immunotherapy: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,19) W:Y]"" $E($$SET^DIQ(165.5,55.2,Y),1,39)
 D N:$X>2 Q:'DN  W ?2 W "Other treatment: "
 D N:$X>33 Q:'DN  W ?33 S Y=$P(X,U,25) W:Y]"" $E($$SET^DIQ(165.5,57.2,Y),1,36)
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
