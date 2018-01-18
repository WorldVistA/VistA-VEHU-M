AOVTIUHS ;ELZ/VAPA tiu utility routine  12/9/97;SEP 27, 2000@10:51
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;MODIFIED BY RMS/HINES 5-31-01 TO MAKE RXCLASS INTO AN HS COMPONENT
 ;
RXCLASS(DFN,AOVCLASS,TARGET) ; Search the outpatient med for specify Drug
 Q
HSCLASS ;
 S AOVCLASS="CN101",TARGET="AJEY"
 ;  Class for tiu drug class object
 ; DFN = patient IEN
 ; AOVCLASS = drug class specify by the calling object
 ; TARGET = Return temp global for TIU to display
 ; This call is similar to the OMED above, just need to filter out the 
 ; drug class if any.
 N LINE,DA,RX,DAT,AJEYLINE,AJEY
 K @TARGET
 S LINE=0,INTERNAL=""
 D ^PSOHCSUM
 S RX="" F  S RX=$O(^TMP("PSOO",$J,RX)) Q:RX=""  D
 . S RX(0)=$G(^TMP("PSOO",$J,RX,0)),RX(1)=$G(^TMP("PSOO",$J,RX,1,0))
 . Q:$E($P(RX(0),U,5))'="A"&($E($P(RX(0),U,5))'="S")
 . Q:$E($P(^PSDRUG(+$P(RX(0),U,3),0),U,2))="X"
 . ;I RX(1)'="" S DA=RX(1) D SIG^GMTSPSO(.DA) S RX(1)=DA
 . S INTERNAL=$P($P(RX(0),U,3),";")
 . I $P($G(^PSDRUG(INTERNAL,0)),"^",2)=AOVCLASS D
 . . S LINE=LINE+1,@TARGET@(LINE,0)=$E($P($P(RX(0),U,3),";",2),1,80)
 . . S LINE=LINE+1,@TARGET@(LINE,0)="   "_$TR($E(RX(1),1,77),"*")
 . . ;W "."
 I LINE=0 S LINE=1,@TARGET@(1,0)="No Narcotic Rx's found.  (Class "_AOVCLASS_")"
 ;S @TARGET@(0)="^^"_LINE_"^"_LINE_"^"_DT_"^^"
 W ! S AJEYLINE=0 F  S AJEYLINE=$O(@TARGET@(AJEYLINE)) Q:'+AJEYLINE  D  ;
 . D CKP^GMTSUP Q:$D(GTMSQIT)
 . W @TARGET@(AJEYLINE,0),!
 ;Q "~@"_$NA(@TARGET)
 Q
 ;
