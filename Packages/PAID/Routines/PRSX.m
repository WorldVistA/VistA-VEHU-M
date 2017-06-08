PRSX ; HISC/REL/FPT-MATCH 450 to 200 DRIVER ;1/26/93  11:37
 ;;3.1;PAID;;Feb 25, 1994
OP K G F I=1:1:11 S G(I)=$P($T(PGMS+I),";",3,99)
 W !
 F I=1:1:11 W !?6,$P(G(I),";",1),?10,$P(G(I),";",2)
O1 K A R !!,"Select OPTION: ",A:DTIME G:'$T!("^"[A) KILL I A'?1.2N W $C(7)_"  Enter a number from 1 to 11" G O1
 I '$D(G(A)) W $C(7)_"  ??" G O1
 S X=$P(G(A),";",3) K A,I,G D @X K X G OP
KILL K A,I,G,X,Y
 Q
PGMS ;;
 ;;1;List Duplicate SSNs in File 450;EN3^PRSX5
 ;;2;List Duplicate SSNs in File 200;EN4^PRSX5
 ;;3;SSN Match;^PRSX1
 ;;4;Last Name Match;^PRSX3
 ;;5;List Unmatched Entries;NOMATCH^PRSX2
 ;;6;Select File 450 Entry & Match It;PE^PRSX3
 ;;7;Add Entries to File 200;^PRSX4
 ;;8;List All File 450 Entries;^PRSX2
 ;;9;Clean Up Matching Cross-references;CU^PRSX3
 ;;10;Delete a Match;DM^PRSX3
 ;;11;DINUM File 450 to File 200;^PRSDNM
