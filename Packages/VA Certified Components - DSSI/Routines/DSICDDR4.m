DSICDDR4 ; DSS/BLJ - ADDITIONAL FILEMAN CLONED CALLS ;11/15/2002 11:58
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#   SUPPORTED
 ; -----   --------------------------
 ;  2055   EXTERNAL^DILFD
 ;  2051   FIND1^DIC
 ;  2050   MSG^DIALOG
 ;
INIT(T) ;  initalize input variables
 N Z S Z="" Q:'$G(T)
 I T<3 D
 .S FILE=$G(FILE),VALUE=$G(VALUE)
 .S:FILE="" Z="FILE, " S:VALUE="" Z=Z_"VALUE, "
 .Q
 I T=1 S FIELD=$G(FIELD) S:FIELD="" Z=Z_"FIELD, "
 I T=3 S WIDTH=$G(WIDTH),LEFT=$G(LEFT),FLG=$TR($G(FLG,"A"),"W")
 I Z]"" S Z="-1^No input value(s) received for: "_Z
 Q Z
 ;
XLATE1(RETURN,FILE,FIELD,VALUE) ; RPC: DSIC DDVG XLATE IDX2DATA
 N X,Y,Z,DIERR,ERR
 S X=$$INIT(1)
 I X]"" S RETURN(1)=X Q
 S X=$$EXTERNAL^DILFD(FILE,FIELD,"",VALUE,"ERR")
 S RETURN(1)=$S('$D(ERR):1,1:-1)_U_X
 Q
 ;
XLATE2(RETURN,FILE,IENS,VALUE) ; RPC: DSIC DDVG XLATE DATA2IDX
 N X,Y,Z,DIERR,ERR
 S X=$$INIT(2)
 I X]"" S RETURN(1)=X Q
 S X=$$FIND1^DIC(FILE,IENS,"MO",VALUE,,,"ERR")
 S RETURN(1)=$S('$D(ERR):1,1:-1)_U_X
 Q
 ;
MSG(FLG,OUT,WIDTH,LEFT,INPUT,TYPE) ;  process fileman dialog msgs
 ;  assumes you are familiar with MSG^DIALOG
 ;  no quality check on data passed
 ;  Exceptions: you must pass OUT by reference as the results will
 ;    be returned in OUT - the format of OUT returned depends on the
 ;    value of TYPE
 ;  TYPE - optional
 ;    TYPE = A [default] -  return data in array format
 ;         = S - return data as a single string, max length 500
 ;               in this case OUT = string to be returned
 ;
 N X,Y,Z,DIERR,ERR,OUTARR
 S X=$$INIT(3)
 S TYPE=$S($G(TYPE)="":"A","AaSs"'[$E(TYPE):"A","Aa"[$E(TYPE):"A",1:"S")
 D MSG^DIALOG(FLG,.OUTARR,WIDTH,LEFT,$G(INPUT))
 I TYPE="A" M OUT=OUTARR Q
 S OUT="",Y=0
 F  S Y=$O(OUTARR(Y)) Q:'Y  D  Q:$L(Z)>499
 .S OUT=OUT_$E(OUTARR(Y),1,499-$L(Z))_" "
 .Q
 Q
