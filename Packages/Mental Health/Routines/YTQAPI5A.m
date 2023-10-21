YTQAPI5A ;DXC/ART - Save MH Administration Record API ;10/23/2017
 ;;5.01;MENTAL HEALTH;**132,221**;Dec 30, 1994;Build 11
 ;
 QUIT
 ;
SAVEADM(YSDATA,YS) ; Create a new or update an existing administration
 ; RPC: YTQ SAVE ADMIN, replaces call to YTQ SAVE which is too open ended
 ;Input: YS("IEN")= the internal number of the record to edit.
 ;                  Leave blank if creating a new record. If creating a new record you must
 ;                  send .01^NEW in YS(1).
 ;         YS(1)=FIELD #^Value^[3rd piece]
 ;         YS(x)=FIELD #^Value^[3rd piece]
 ;              [3rd piece] = 1 to bypass validation
 ;              Data values must be external format - or `IEN
 ;Output: YSDATA(1)=[DATA] or [ERROR]
 ;
 SET YS("FILEN")=601.84 ; force to MH ADMINISTRATION
 N I S I=0
 F  S I=$O(YS(I)) Q:'I  I $P(YS(I),U)="15" S YS(I)="15^`"_$$SRC^YTQAPI1($P(YS(I),U,2))
 DO EDAD^YTQAPI1(.YSDATA,.YS) ; then call previous entry point
 QUIT
