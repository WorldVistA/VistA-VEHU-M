A1A1FMT1 ;ALB/CAW,PKE - Format data for extract ;4/6/95 [ 05/29/96  12:44 PM ]
 ;;1.2;Prescription Practices Extract;;FEB 1,1996
SETSTR(A1DATA,A1TPE) ;sets the string into a TMP global
 ;
 ;  Input:    A1DATA - The string to input
 ;            A1TPE - Would include a 'P' for provider
 ; Output:    The counter number of how many lines are in the TMP global
 ;
 N A1DATA1
 S A1CNTR=$G(A1CNTR)+1,A1MSG1=A1MSG
 S A1MSG=1+(A1CNTR\57)
 I A1MSG1'=A1MSG D  G SETSTRQ
 .I A1DATA'["$" D  Q
 ..S A1DATA1=$E(A1DATA,1,255),A1PDATA=$E(A1DATA,256,999)
 ..S:A1TPE'="P" ^TMP("A1RXEXT",$J,A1MSG1,A1CNTR)=A1DATA1
 ..S:A1TPE="P" ^TMP("A1RXPROV",$J,A1MSG1,A1CNTR)=A1DATA1
 ..S A1MSG=A1MSG1
 ..S A1DATA=""
 .S A1DATA1=$P(A1DATA,"$")_"$"
 .S:A1TPE'="P" ^TMP("A1RXEXT",$J,A1MSG1,A1CNTR)=A1DATA1
 .S:A1TPE="P" ^TMP("A1RXPROV",$J,A1MSG1,A1CNTR)=A1DATA1
 .S A1PDATA=$P(A1DATA,"$",2,99),A1DATA=""
 S A1DATA1=$E(A1DATA,1,255),A1PDATA=$E(A1DATA,256,999)
 S:A1TPE'="P" ^TMP("A1RXEXT",$J,A1MSG,A1CNTR)=A1DATA1,A1DATA=""
 S:A1TPE="P" ^TMP("A1RXPROV",$J,A1MSG,A1CNTR)=A1DATA1,A1DATA=""
SETSTRQ Q
 ;
 ;
LENGTH(A1DATA,A1PDATA) ;calculate the length of string
 ;
 ;  Input:  A1DATA - The data being appended to the string
 ;         A1PDATA - The existing string
 ; Output:   1/0 indicator as to whether the data+prior data is >255
 ;
 N X,Y,Z
 S Z=0
 S X=$L(A1DATA),Y=$L(A1PDATA) I (X+Y)>255 S Z=1
 Q Z
FRMT(A1DATA,A1LEN,A1TYPE,A1PDATA,A1TPE) ;format data
 ;
 ;  Input:    A1DATA - The data to format
 ;             A1LEN - The length of the field
 ;            A1TYPE - The type of data (T=TEXT, N=NUMERIC)
 ;           A1PDATA - The prior data the data is concatenated to
 ;             A1TPE - (Optional) would include a 'P' for provider
 ; Output:   Data sent in concatenated to any prior data
 ;
 N X,HOWMANY
 S (X,HOWMANY)=""
 I $L(A1DATA)>A1LEN S X=$E(A1DATA,1,A1LEN) G FRMTQ
 I A1TYPE="N" S X=$J(A1DATA,A1LEN)
 I A1TYPE="T" D
 .S X=$L(A1DATA)
 .S $P(HOWMANY," ",((A1LEN-X)+1))=""
 .S X=A1DATA_HOWMANY
FRMTQ I $$LENGTH(X,A1PDATA) D SETSTR(A1PDATA,$G(A1TPE))
 Q A1PDATA_X
 ;
DATE(X) ; return in mmddyyyy format
 N Y
 S Y=""
 I $P(X,".",1)?7N S Y=$E(X,4,5)_$E(X,6,7)_$E((1700+$E(X,1,3)),3,4)
 Q Y
 ;
LAST(A1DATA,A1TPE) ;Set last record in the TMP global
 ;   Input:   A1DATA - data to set
 ;            A1TYP  - RX or Provider
 N Z
 Q:$G(A1MSG)=""  Q:$G(A1CNTR)=""
 I A1TPE'="P" DO
 .I '$D(^TMP("A1RXEXT",$J,A1MSG,A1CNTR)) DO  Q
 . .S ^TMP("A1RXEXT",$J,A1MSG,A1CNTR+1)=A1DATA
 . .;
 .S Z=^TMP("A1RXEXT",$J,A1MSG,A1CNTR)_A1DATA
 .S ^TMP("A1RXEXT",$J,A1MSG,A1CNTR)=$E(Z,1,255)
 .I $L(Z)>255 S ^TMP("A1RXEXT",$J,A1MSG,A1CNTR+1)=$E(Z,256,999)
 ;
 I A1TPE="P" DO
 .I '$D(^TMP("A1RXPROV",$J,A1MSG,A1CNTR)) DO  Q
 . .S ^TMP("A1RXPROV",$J,A1MSG,A1CNTR+1)=A1DATA
 . .;
 .S Z=^TMP("A1RXPROV",$J,A1MSG,A1CNTR)_A1DATA
 .S ^TMP("A1RXPROV",$J,A1MSG,A1CNTR)=$E(Z,1,255)
 .I $L(Z)>255 S ^TMP("A1RXPROV",$J,A1MSG,A1CNTR+1)=$E(Z,256,999)
 Q
