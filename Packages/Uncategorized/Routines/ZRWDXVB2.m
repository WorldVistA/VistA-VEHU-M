ZRWDXVB2 ;slc/dcm - Order dialog utilities for Blood Bank Cont.;3/2/04  09:31 [6/7/08 9:57am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17 1997
 ;
ERROR ;Process error
 D LN
 S VBERROR=$P(ORX("ERROR"),"^",2)
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"******************************************************************",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                           WARNING!                             *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                An Error occurred attempting to                 *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                retrieve Blood Bank order data.                 *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*          This order cannot be completed at this time.          *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*         Revert to local downtime procedures to continue        *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*           order or retry this option at a later time.          *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*           Contact the Blood Bank System Administrator          *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"******************************************************************",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                         Error Message                          *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*",.CCNT)
 I $L(VBERROR)<68 D
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(70-$L(VBERROR)/2,CCNT,VBERROR,.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(67,CCNT,"*",.CCNT) D LN
 I $L(VBERROR)>68 D
 . I $L(VBERROR)>136 S VBERROR=$E(VBERROR,1,136)_"..."
 . N L1 S L1=$E(VBERROR,1,$L(VBERROR)/2)
 . I $E(L1,$L(L1))'=" " D
 . . S LINE1=$E(L1,1,($L(L1)-($L($P(L1," ",$L(L1," ")))))),LINE2=$E(VBERROR,$L(LINE1)+1,$L(VBERROR))
 . E  S LINE1=$E(L1),LINE2=$E(VBERROR,$L(LINE1)+1,$L(VBERROR))
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(70-$L(LINE1)/2,CCNT,LINE1,.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(67,CCNT,"*",.CCNT) D LN
 . S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*",.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(70-$L(LINE2)/2,CCNT,LINE2,.CCNT)
 . S ^TMP("ORVBEC",$J,GCNT,0)=^TMP("ORVBEC",$J,GCNT,0)_$$S^ORU4(67,CCNT,"*",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"*                                                                *",.CCNT) D LN
 S ^TMP("ORVBEC",$J,GCNT,0)=$$S^ORU4(2,CCNT,"******************************************************************",.CCNT) D LN
 D LINE^ORU4("^TMP(""ORVBEC"",$J)",GIOM),LN
 Q
LN ;Increment counts
 S GCNT=GCNT+1,CCNT=1
 Q
