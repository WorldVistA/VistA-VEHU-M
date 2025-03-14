PXRMCSUBOBJ ;SLC/PKR - Routines for CSUB Objects. ;05/19/2020
 ;;2.0;CLINICAL REMINDERS;**46**;Feb 04, 2005;Build 236
 ;
 ;===============
CSUBDATE(FUNCTION,DATEFORMAT,TEXT,FIEVAL) ;CSUB Date Object.
 N CELLFORMAT,DATE,EXTDATE,JUSTIFY,LIST,PADC,ROUTINE,WIDTH
 S ROUTINE=$P(FUNCTION,"(",1)
 S LIST=$P(FUNCTION,"(",2)
 S LIST=$P(LIST,")",1)
 S CELLFORMAT=$P(DATEFORMAT,":",2,3)
 S DATEFORMAT=$P(DATEFORMAT,":",1)
 S DATE=$S(ROUTINE="MRD":$$MRD(LIST,.FIEVAL),ROUTINE="MIN_DATE":$$MINDATE(LIST,.FIEVAL),1:0)
 S EXTDATE=$S(DATE=0:$G(TEXT),1:$$FMTE^XLFDT(DATE,DATEFORMAT))
 I CELLFORMAT'="" D
 . S PADC=$P(CELLFORMAT,":",2),CELLFORMAT=$P(CELLFORMAT,":",1)
 . S JUSTIFY=$E(CELLFORMAT,1),WIDTH=$P(CELLFORMAT,JUSTIFY,2)_"T"
 . S EXTDATE=$S(JUSTIFY="L":$$LJ^XLFSTR(EXTDATE,WIDTH,PADC),JUSTIFY="R":$$RJ^XLFSTR(EXTDATE,WIDTH,PADC),JUSTIFY="C":$$CJ^XLFSTR(EXTDATE,WIDTH,PADC),1:EXTDATE)
 Q EXTDATE
 ;
 ;===============
CSUBINTE(CSUB,CELLFORMAT,FILENUM,FIELDNUM,FINUM,OCC,SEP,PIECE,TEXT,FIEVAL) ;
 ;CSUB INTE Object.
 N EXTERNAL,INTERNAL,JUSTIFY,MSG,PADC,WIDTH
 S CELLFORMAT=$G(CELLFORMAT),OCC=$G(OCC),SEP=$G(SEP)
 S PIECE=$G(PIECE,1),TEXT=$G(TEXT)
 S INTERNAL=$S(OCC="":$G(FIEVAL(FINUM,CSUB)),1:$G(FIEVAL(FINUM,OCC,CSUB)))
 I SEP'="" S INTERNAL=$P(INTERNAL,SEP,PIECE)
 S EXTERNAL=$S(INTERNAL'="":$$EXTERNAL^DILFD(FILENUM,FIELDNUM,,INTERNAL,"MSG"),1:TEXT)
 I CELLFORMAT'="" D
 . S PADC=$P(CELLFORMAT,":",2),CELLFORMAT=$P(CELLFORMAT,":",1)
 . S JUSTIFY=$E(CELLFORMAT,1),WIDTH=$P(CELLFORMAT,JUSTIFY,2)_"T"
 . S EXTERNAL=$S(JUSTIFY="L":$$LJ^XLFSTR(EXTERNAL,WIDTH,PADC),JUSTIFY="R":$$RJ^XLFSTR(EXTERNAL,WIDTH,PADC),JUSTIFY="C":$$CJ^XLFSTR(EXTERNAL,WIDTH,PADC),1:EXTERNAL)
 Q EXTERNAL
 ;
 ;===============
CSUBNUM(CSUB,FORMAT,FINUM,OCC,SEP,PIECE,TEXT,FIEVAL) ;CSUB Num Object.
 N CELLFORMAT,FMT,FNUM,FTYPE,JUSTIFY,NDEC,NUM,PADC,WIDTH
 S OCC=$G(OCC),SEP=$G(SEP),PIECE=$G(PIECE,1),TEXT=$G(TEXT)
 S NUM=$S(OCC="":$G(FIEVAL(FINUM,CSUB)),1:$G(FIEVAL(FINUM,OCC,CSUB)))
 I SEP'="" S NUM=$P(NUM,SEP,PIECE)
 S FTYPE=$P(FORMAT,":",1)
 I NUM'="" D
 . S FMT=$P(FORMAT,":",2),NDEC=$P(FORMAT,":",3)
 . S FNUM=$S(FTYPE="N":$FN(NUM,FMT,NDEC),FTYPE="D":$$FMTE^XLFDT(NUM,FMT),1:NUM)
 I NUM="" S FNUM=TEXT
 S CELLFORMAT=$S(FTYPE="D":$P(FORMAT,":",3,4),FTYPE="N":$P(FORMAT,":",4,5),1:"")
 I CELLFORMAT'="" D
 . S PADC=$P(CELLFORMAT,":",2),CELLFORMAT=$P(CELLFORMAT,":",1)
 . S JUSTIFY=$E(CELLFORMAT,1),WIDTH=$P(CELLFORMAT,JUSTIFY,2)_"T"
 . S FNUM=$S(JUSTIFY="L":$$LJ^XLFSTR(FNUM,WIDTH,PADC),JUSTIFY="R":$$RJ^XLFSTR(FNUM,WIDTH,PADC),JUSTIFY="C":$$CJ^XLFSTR(FNUM,WIDTH,PADC),1:FNUM)
 Q FNUM
 ;
 ;===============
CSUBOBJ(CSUBLINE,FIEVAL) ;Top-level entry point for CSUB objects, determine
 ;the object type and branch to it.
 N DONE,FINUM,LEN,OBJECT,OBJEND,OBJSEND,OBJSTART,OBJTEXT,OCC,OUTTEXT
 S DONE=0,OBJEND=1,OBJSTART=1
 S LEN=$L(CSUBLINE)
 F  Q:DONE  D
 . S OBJSTART=$F(CSUBLINE,"$$CSUB",OBJEND)-6
 . I OBJSTART=-6 S DONE=1 Q
 . S OBJEND=$F(CSUBLINE,"(",OBJSTART)-2
 . S OBJECT=$E(CSUBLINE,OBJSTART,OBJEND)
 . I OBJECT="$$CSUBDATE" D  Q
 .. N DATEFORMAT,FUNCTION,FUNEND,FUNSTART,RP,TEMP,TEXT
 .. S FUNSTART=$F(CSUBLINE,"MRD",OBJEND)-3
 .. I FUNSTART=-3 S FUNSTART=$F(CSUBLINE,"MIN_DATE",OBJEND)-8
 .. S FUNEND=$F(CSUBLINE,")",OBJEND)-1
 .. S FUNCTION=$E(CSUBLINE,FUNSTART,FUNEND)
 .. S RP=$F(CSUBLINE,")",FUNEND+2)
 .. S TEMP=$E(CSUBLINE,FUNEND+2,RP-2)
 .. S DATEFORMAT=$P(TEMP,",",1)
 .. S TEXT=$P(TEMP,",",2)
 .. S OBJTEXT=$$CSUBDATE(FUNCTION,DATEFORMAT,TEXT,.FIEVAL)
 .. S OUTTEXT=$E(CSUBLINE,1,OBJSTART-1)_OBJTEXT_$E(CSUBLINE,RP,LEN)
 .. S CSUBLINE=OUTTEXT
 . I OBJECT="$$CSUBINTE" D  Q
 .. N CELLFORMAT,CSUB,FIELDNUM,FILENUM,FNUM,PIECE,RP,SEP,TEMP,TEXT
 .. S RP=$F(CSUBLINE,")",OBJEND+2)
 .. S TEMP=$E(CSUBLINE,OBJEND+2,RP-2)
 .. S CSUB=$P(TEMP,",",1),CELLFORMAT=$P(TEMP,",",2),FILENUM=$P(TEMP,",",3)
 .. S FIELDNUM=$P(TEMP,",",4),FINUM=$P(TEMP,",",5),OCC=$P(TEMP,",",6)
 .. S SEP=$P(TEMP,",",7),PIECE=$P(TEMP,",",8),TEXT=$P(TEMP,",",9)
 .. S OBJTEXT=$$CSUBINTE(CSUB,CELLFORMAT,FILENUM,FIELDNUM,FINUM,OCC,SEP,PIECE,TEXT,.FIEVAL)
 .. S OUTTEXT=$E(CSUBLINE,1,OBJSTART-1)_OBJTEXT_$E(CSUBLINE,RP,LEN)
 .. S CSUBLINE=OUTTEXT
 . I OBJECT="$$CSUBNUM" D  Q
 .. N CSUB,FORMAT,PIECE,RP,SEP,TEMP,TEXT
 .. S RP=$F(CSUBLINE,")",OBJEND+2)
 .. S TEMP=$E(CSUBLINE,OBJEND+2,RP-2)
 .. S CSUB=$P(TEMP,",",1)
 .. I TEMP["N:," D
 ... S FORMAT=$P(TEMP,",",2,3)
 ... S FINUM=$P(TEMP,",",4),OCC=$P(TEMP,",",5),SEP=$P(TEMP,",",6)
 ... S PIECE=$P(TEMP,",",7),TEXT=$P(TEMP,",",8)
 .. E  D
 ... S FORMAT=$P(TEMP,",",2)
 ... S FINUM=$P(TEMP,",",3),OCC=$P(TEMP,",",4),SEP=$P(TEMP,",",5)
 ... S PIECE=$P(TEMP,",",6),TEXT=$P(TEMP,",",7)
 .. S OBJTEXT=$$CSUBNUM(CSUB,FORMAT,FINUM,OCC,SEP,PIECE,TEXT,.FIEVAL)
 .. S OUTTEXT=$E(CSUBLINE,1,OBJSTART-1)_OBJTEXT_$E(CSUBLINE,RP,LEN)
 .. S CSUBLINE=OUTTEXT
 . I OBJECT="$$CSUBTEXT" D  Q
 .. N CELLFORMAT,CSUB,PIECE,RP,SEP,TEMP,TEXT
 .. S RP=$F(CSUBLINE,")",OBJEND+2)
 .. S TEMP=$E(CSUBLINE,OBJEND+2,RP-2)
 .. S CSUB=$P(TEMP,",",1),CELLFORMAT=$P(TEMP,",",2),FINUM=$P(TEMP,",",3)
 .. S OCC=$P(TEMP,",",4),SEP=$P(TEMP,",",5)
 .. S PIECE=$P(TEMP,",",6),TEXT=$P(TEMP,",",7)
 .. S OBJTEXT=$$CSUBTEXT(CSUB,CELLFORMAT,FINUM,OCC,SEP,PIECE,TEXT,.FIEVAL)
 .. S OUTTEXT=$E(CSUBLINE,1,OBJSTART-1)_OBJTEXT_$E(CSUBLINE,RP,LEN)
 .. S CSUBLINE=OUTTEXT
 Q OUTTEXT
 ;
 ;===============
CSUBTEXT(CSUB,CELLFORMAT,FINUM,OCC,SEP,PIECE,TEXT,FIEVAL) ;CSUB Text Object.
 N FITEXT,JUSTIFY,PADC,WIDTH
 S CELLFORMAT=$G(CELLFORMAT),OCC=$G(OCC)
 S SEP=$G(SEP),PIECE=$G(PIECE,1),TEXT=$G(TEXT)
 S FITEXT=$S(OCC="":$G(FIEVAL(FINUM,CSUB)),1:$G(FIEVAL(FINUM,OCC,CSUB)))
 I SEP'="" S FITEXT=$P(FITEXT,SEP,PIECE)
 I FITEXT="" S FITEXT=TEXT
 I CELLFORMAT'="" D
 . S PADC=$P(CELLFORMAT,":",2),CELLFORMAT=$P(CELLFORMAT,":",1)
 . S JUSTIFY=$E(CELLFORMAT,1),WIDTH=$P(CELLFORMAT,JUSTIFY,2)_"T"
 . S FITEXT=$S(JUSTIFY="L":$$LJ^XLFSTR(FITEXT,WIDTH,PADC),JUSTIFY="R":$$RJ^XLFSTR(FITEXT,WIDTH,PADC),JUSTIFY="C":$$CJ^XLFSTR(FITEXT,WIDTH,PADC),1:FITEXT)
 Q FITEXT
 ;
 ;===============
MINDATE(LIST,FIEVAL) ;Oldest date.
 N FINUM,IND,MIND,NUMFI,TESTD
 S MIND=9991231
 S NUMFI=$L(LIST,",")
 F IND=1:1:NUMFI D
 . S FINUM=$P(LIST,",",IND)
 . S TESTD=$G(FIEVAL(FINUM,"DATE"))
 . I (TESTD>0),(TESTD<MIND) S MIND=TESTD
 I MIND=9991231 S MIND=0
 Q MIND
 ;
 ;===============
MRD(LIST,FIEVAL) ;Most recent date.
 N FINUM,IND,MRD,NUMFI
 S MRD=0
 S NUMFI=$L(LIST,",")
 F IND=1:1:NUMFI D
 . S FINUM=$P(LIST,",",IND)
 . I $G(FIEVAL(FINUM,"DATE"))>MRD S MRD=FIEVAL(FINUM,"DATE")
 Q MRD
 ;
