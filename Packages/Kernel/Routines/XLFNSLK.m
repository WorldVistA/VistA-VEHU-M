XLFNSLK ;ISF/RWF,ISD/HGW - Calling a DNS server for name lookup ;08/05/2020
 ;;8.0;KERNEL;**142,151,425,638,659,717,19999**;Jul 10, 1995;Build 10
 ;Per VA Directive 6402, this routine should not be modified.
 ; *19999 changes to support GT.M
 ;
 Q
TEST ;Test entry
 N XNAME
 R !,"Enter an IP address to lookup: www.domain.ext//",XNAME:DTIME S:XNAME="" XNAME="www.domain.ext" Q:XNAME["^"
 W !!,"Looking up IPv4 address: ",XNAME
 W !,?5,XNAME,". > ",$$ADDRESS(XNAME,"A")
 W !!,"Looking up IPv6 address: ",XNAME
 W !,?5,XNAME,". > ",$$ADDRESS(XNAME,"AAAA")
 W !
 Q
 ;
HOST(IP) ;Get a host name from an IP address
 ;ZEXCEPT: AddrToHostName,INetInfo,TextAddrToBinary ;Kernel exemption for Cache Objects
 N X,Y
 I ($$VERSION^%ZOSV(1)["Cache")!($$VERSION^%ZOSV(1)["IRIS") D  Q Y
 . S X=$SYSTEM.INetInfo.TextAddrToBinary(IP)
 . S Y=$SYSTEM.INetInfo.AddrToHostName(X)
 ;Enter code for non-Cache systems here:
 I +$SY=47 N RESULT D  Q RESULT
 . S RESULT=$$RETURN^%ZOSV("dig -x "_IP_" +noall +answer +short") ; reverse DNS. MUST HAVE A REVERSE DNS RECORD
 . S $E(RESULT,$L(RESULT))="" ; Strip Last Character
 Q ""
 ;
ADDRESS(N,T) ;Get a IP address from a name
 ;ZEXCEPT: HostNameToAddr,INetInfo ;Kernel exemption for Cache Objects
 N X,XLF,Y,I S XLF="",Y=0
 I $$VERSION^XLFIPV S T=$G(T,"AAAA")
 E  S T=$G(T,"A") ; change default to "A" if VistA has IPv6 disabled
 I ($$VERSION^%ZOSV(1)["Cache")!($$VERSION^%ZOSV(1)["IRIS")&((T="A")!(T="AAAA")) D  Q Y
 . I T="AAAA" D
 . . S X=$SYSTEM.INetInfo.HostNameToAddr(N,2,0) ;Get IPv6 address
 . . S Y=$$FORCEIP6^XLFIPV(X) ;Format IPv6 address
 . I ($P(Y,":")="0000")!(T="A") S Y=$SYSTEM.INetInfo.HostNameToAddr(N,1,0) ;Get IPv4 address
 ;Non-cache systems and lookups other than "A" or "AAAA"
 I +$SY=47 D  Q Y
 . I (T="AAAA") S Y=$$FORCEIP6^XLFIPV($$RETURN^%ZOSV("dig "_T_" "_N_" +noall +answer +short")) QUIT  ; return the last ip address in the list
 . I (T="A") S Y=$$FORCEIP4^XLFIPV($$RETURN^%ZOSV("dig "_T_" "_N_" +noall +answer +short")) QUIT  ; return the last ip address in the list
 D NS(.XLF,N,T)
 S Y="" F I=1:1:XLF("ANCOUNT") S:$D(XLF("AN"_I_"DATA")) Y=Y_XLF("AN"_I_"DATA")_","
 Q $E(Y,1,$L(Y)-1)
 ;
MAIL(RET,N) ;Get the MX address for a domain
 ;RET is the return array
 N XLF,Y,I,T S XLF="",T="MX"
 D NS(.XLF,N,T)
 S RET=0,I=0 F  S I=$O(XLF("P",I)) Q:I'>0  D
 . S N=XLF("P",I),RET(I)=N_"^"_$G(XLF("B",N)),RET=RET+1
 Q
 ;
NS(XL,NAME,QTYPE,XLFLOG) ;NAME LOOKUP
 ;XL is the return array, NAME is the name to lookup,
 ;QTYPE is type of lookup, XLFLOG is a debug array returned.
 N RI,DNS,CNT,POP N:'$D(XLFLOG) XLFLOG S XL("ANCOUNT")=0,CNT=1
 D SAVEDEV
NS2 ;
 S DNS=$$GETDNS(CNT) I DNS="" G EXIT
 D LOG("Call server: "_DNS)
 D CALL^%ZISTCP(DNS,53) I POP S CNT=CNT+1 G NS2
 D LOG("Got connection, Send message")
 D BUILD(NAME,$G(QTYPE,"AAAA")),LOG("Wait for reply")  ; Uses "AAAA" type for IPv6 if QTYPE is not defined
 ;Close part of READ
 D READ,DECODE
 D RESDEV,LOG("Returned question: "_$G(XL("QD1NAME")))
 Q
EXIT D RESDEV
 Q
 ;
BUILD(Y,T) ;BUILD A QUERY
 ; ID,PARAM,#of?, #ofA, #of Auth, #of add,
 N X,%,MSG,I
 S X=" M"_$C(1,0)_$C(0,1)_$C(0,0)_$C(0,0)_$C(0,0) ;Header
 I $E(Y,$L(Y))'="." S:$E(Y,$L(Y))'="." Y=Y_"."
 F I=1:1:$L(Y,".") S %=$P(Y,".",I) S:$L(%) X=X_$C($L(%))_% ;FQDN Address
 S X=X_$C(0) ;End of FQDN address
 ;Type A=1, NS=2, CNAME=5, MX=15, AAAA=28
 S MSG=X_$C(0,$$TYPECODE(T))_$C(0,1) ;type and class
 D LOG("msg: "_MSG)
 U IO S %=$L(MSG) W $C(%\256,%#256)_MSG,!
 Q
READ ;
 ;ZEXCEPT: I,RI,XL ;Global variables within this routine
 N L1,L2,X,$ET S $ET="G RDERR" K RI S RI=0
 U IO R L1#2:20 I '$T D LOG("Time-out") G RDERR
 S RI=$A(L1,1)*256+$A(L1,2) ;get msg length
 F I=1:1:6 R L2#2:20 Q:'$T  S XL($P("ID^CODE^QDCOUNT^ANCOUNT^NSCOUNT^ARCOUNT","^",I))=$S(I>2:$$WBN(L2),I=2:$$BIN16(L2),1:L2)
 I '$T D LOG("Time-out") G RDERR
 D LOG("Return msg length: "_RI)
 F I=13:1:RI U IO R *X:20 Q:'$T  S RI(I)=X ;or use X#1 and $A(X)
RDERR ;End of read
 D CLOSE^%ZISTCP
 Q
DECODE ;
 ;ZEXCEPT: XL ;Global variable within this routine
 N I,IX,X,Y,Z,NN,NN2 Q:RI'>7
 I $G(XL("ID"))'=" M" S XL("ERR")="Bad Response" D LOG(XL("ERR")) Q
 ;Decode the header
 S Z=XL("CODE"),XL("QR")=$E(Z,1),XL("Opcode")=$E(Z,2,5),XL("AA")=$E(Z,6),XL("TC")=$E(Z,7),XL("RD")=$E(Z,8),XL("RA")=$E(Z,9),XL("RCODE")=$E(Z,13,16)
 ;The Question section
 S IX=13
 F NN2=1:1:XL("QDCOUNT") D QD("QD"_NN2)
 F NN="AN","NS","AR" I $G(XL(NN_"COUNT")) F NN2=1:1:XL(NN_"COUNT") D RR(NN_NN2)
 Q
 ;
QD(NSP) ;Decode the Question section
 ;ZEXCEPT: IX,RI,XL ;Global variables within this routine
 N Y
 S Y="",IX=IX+$$NAME(IX,.Y,1),XL(NSP_"NAME")=Y
 S XL(NSP_"TYPE")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 S XL(NSP_"CLASS")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 Q
RR(NSP) ;
 ;ZEXCEPT: IX,RI,X,XL ;Global variables within this routine
 N Y,NA
 S Y="",IX=IX+$$NAME(IX,.Y,1),XL(NSP_"NAME")=Y,NA=Y
 S XL(NSP_"TYPE")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 S XL(NSP_"CLASS")=$$BN(RI(IX),RI(IX+1)),IX=IX+2
 S Y=RI(IX)*256+RI(IX+1),Y=Y*256+RI(IX+2),Y=Y*256+RI(IX+3)
 S XL(NSP_"TTL")=Y,IX=IX+4
 S (X,XL(NSP_"LENGTH"))=$$BN(RI(IX),RI(IX+1)),IX=IX+2 Q:X=0
 I XL(NSP_"TYPE")=1 D                                                                       ; IPv4 address
 . S XL(NSP_"DATA")=RI(IX)_"."_RI(IX+1)_"."_RI(IX+2)_"."_RI(IX+3),XL("B",NA)=XL(NSP_"DATA")
 I XL(NSP_"TYPE")=28 D                                                                      ; IPv6 address
 . S XL(NSP_"DATA")=$$H1(RI(IX))_$$H1(RI(IX+1))_":"_$$H1(RI(IX+2))_$$H1(RI(IX+3))_":"
 . S XL(NSP_"DATA")=XL(NSP_"DATA")_$$H1(RI(IX+4))_$$H1(RI(IX+5))_":"_$$H1(RI(IX+6))_$$H1(RI(IX+7))_":"
 . S XL(NSP_"DATA")=XL(NSP_"DATA")_$$H1(RI(IX+8))_$$H1(RI(IX+9))_":"_$$H1(RI(IX+10))_$$H1(RI(IX+11))_":"
 . S XL(NSP_"DATA")=XL(NSP_"DATA")_$$H1(RI(IX+12))_$$H1(RI(IX+13))_":"_$$H1(RI(IX+14))_$$H1(RI(IX+15))
 . S XL("B",NA)=XL(NSP_"DATA")
 I XL(NSP_"TYPE")=15 D MX(IX)                                                               ; MX entry
 S IX=IX+XL(NSP_"LENGTH")
 Q
NAME(I,NM,F) ;Decode a NAME section
 ;ZEXCEPT: RI ;Global variable within this routine
 N P,T,Y,X S NM=$G(NM) S:F T=0
 F  S X=RI(I) S:(X=0)&F T=T+1 Q:X=0  D  Q:X=0  ;Use X as flag to escape recursion.
 . I (X\64)=3 S X=$$NAME((X#64)*256+RI(I+1)+1,.NM,0),X=0 S:F T=T+2 Q
 . S NM=NM_$$PART(I+1,X),I=I+X+1 S:F T=T+X+1
 Q $G(T)
 ;
MX(IX) ;Hide IX changes
 ;ZEXCEPT: NSP,RI,XL ;Global variables within this routine
 N Y S Y=$$BN(RI(IX),RI(IX+1))
 F  Q:'$D(XL("P",Y))  S Y=Y+1
 S XL(NSP_"PREF")=Y,IX=IX+2
 S Y="",IX=IX+$$NAME(IX,.Y,1),XL(NSP_"NAME")=Y,XL("P",XL(NSP_"PREF"))=Y
 Q
 ;
BN(Z1,Z2) ;Convert two binary char 16 bit number into ASCII number
 Q Z1*256+Z2
 ;
WBN(Z1) ;Convert two byte string to a ASCII number
 Q $A(Z1,1)*256+$A(Z1,2)
 ;
H2(Z2) ;Convert 2 byte string to HEX
 N B S B=$A(Z2,1)*256+$A(Z2,2)
 Q $$H(B)
 ;
H1(Z1) ;Convert decimal number <= 256 to two digit HEX number
 N Y S Y=$$CNV^XLFUTL(Z1,16)
 Q $$RJ^XLFSTR(Y,2,"0")
 ;
H(Z1) Q $$BASE^XLFUTL(Z1,10,16)
 ;
BIN16(S) ;Convert two byte string to 16 bit binary
 N K,Y S S=$A(S,1)*256+$A(S,2),Y=""
 F K=0:1:15 S Y=(S\(2**K)#2)_Y
 Q Y
 ;
PART(S,L) ;
 ;ZEXCEPT: RI ;Global variable within this routine
 N R,A S R="" F A=S:1:S+L-1 S R=R_$C(RI(A))
 Q R_"."
 ;
TYPECODE(T) ;
 ;1=A:IPv4 address,2=NS:nameserver,5=CNAME,15=MX:mail exchange,28=AAAA:IPv6 address
 I +T Q $S(T=1:"A",T=2:"NS",T=5:"CNAME",T=15:"MX",T=28:"AAAA",1:"ZZ")
 Q $S(T="A":1,T="NS":2,T="CNAME":5,T="MX":15,T="AAAA":28,1:1)
 ;
CLASS(T) ;
 Q $S(T=1:"IN",1:"ZZ")
 ;
GETDNS(I) ;Get the address of our DNS
 N L S L=$G(^XTV(8989.3,1,"DNS"))
 Q $P(L,",",I)
 ;
SW(T,H,V) ;
 W ?T,$J(H,8),V
 Q
SAVEDEV ;Save calling device
 D:'$D(IO(0)) HOME^%ZIS D SAVDEV^%ZISUTL("XLFNSLK")
 Q
RESDEV ;Restore calling device
 D USE^%ZISUTL("XLFNSLK"),RMDEV^%ZISUTL("XLFNSLK")
 K IO("CLOSE")
 Q
LOG(M,XLFLOG) ;Log Debug messages
 ;ZEXCEPT: XLFLOG ;Global variable within this routine
 S XLFLOG=$G(XLFLOG)+1,XLFLOG(XLFLOG)=M
 Q
 ;
