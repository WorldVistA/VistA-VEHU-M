VTSTTCP(debug) ; ;[ 08/11/94  4:40 PM ]
 ;
 ;
 C 56 K ^VTST($ZN)
 S $ZT="CLNTERR^"_$ZN,mode="CLIENT"
 ;s debug=0
 ;
 ;
 ;
 f loops=1:1:3 d test
 ;
stat c 56 u 0 q:$d(^VTST($ZN))<10
 w !,*7,$ZN," Error(s)/Warning(s) "
 s i="" f  s i=$o(^VTST($ZN,i)) q:i=""  w !?5,^(i)
 q
 ;
 ;
test ;
 u 0 w !,"Test loop #",loops
 x "j SERVER^"_$ZN_"("_debug_")" s server=$zb h 2
 ;
 o 56
 u 56::"TCP"
 ;w /SOCKET("0.0.0.0",20850)
 w /SOCKET("128.200.1.96",20850)
 s a=$za,b=$zb,c=$zc,d=$d,k=$key
 d:debug errlog("$za="_a_",  $zb="_b_",  $zc="_c_",  $d="_d_",  $key="_k,30)
 d:k="" errlog("hostname is null ($KEY after /SOCKET)",40)
 d:debug errlog("hostname is '"_k_"'",50)
 ;
 s msgs=20 d send("Messages="_msgs)
 f i=1:1:msgs d
 .s msg=$$makemsg(i)
 .d send(msg)
 .s resp=$$recv()
 .q:resp=("Server: "_msg)
 .d errlog("response mismatch, expected 'server: "_msg_"', but got '"_resp_"'",60)
 .zt ": "_$zn_"/"_mode
 ;
 ;
 l +^VTSTX:10 e  d
 .d errlog("Server has not terminated, $j="_server,20)
 .zt " Server Stuck "
 l -^VTSTX
 c 56
 q
 ;
 ;
CLNTERR d errlog("detected error: "_$ze,70) g stat
 ;
makemsg(n) 
 s str=""
 f m=1:1:$r(50+n)+5 s str=str_$c(32+$r(94))
 q str
 ;
 ;
send(str)          ;
 d:debug errlog("sending="_$l(str)_"='"_str_"'",45)
 s len=$l(str),str=$c(len\256,len#256)_str
 ;
 ;
 s m=$r(3)+1 u 56
 ;
 f  q:$l(str)=0  s x=$l(str)\m,mm=x\2+$r(x+5)+1 w $e(str,1,mm),! d
 .s $e(str,1,mm)=""
 q
 ;
 ;
recv() u 56 r *x:3 d:x<0
 .d errlog("recv() timed out on 1st length byte",80)
 .zt ": "_$zn_"/"_mode
 ;
 d:debug errlog("received: 1st length byte="_x,85)
 ;
 u 56 r *y:3 d:y<0
 .d errlog("recv() timed out on 2nd length byte",90)
 .zt ": "_$zn_"/"_mode
 d:debug errlog("received: 2nd length byte="_y,95)
 ;
 u 56 s len=x*256+y d:len=0
 .d errlog("recv() got a length of 0 for message",100)
 .zt ": "_$zn_"/"_mode
 ;
 r str#len:3 d:str=""
 .d errlog("recv() timed out on message text",110)
 .zt ": "_$zn_"/"_mode
 ;
 d:debug errlog("received: msg piece="_$l(str)_"='"_str_"'",115)
 ;
 f  q:$l(str)=len  d
 .r x#len-$l(str):3 d:x=""  s str=str_x
 ..d errlog("recv() timed out on partial message text",120)
 ..zt ": "_$zn_"/"_mode
 .d:debug errlog("received: msg piece="_$l(x)_"='"_x_"'",125)
 ;
 i mode="Client" u 0 w "." u 56
 d:debug errlog("received: "_$l(str)_"='"_str_"'",127)
 q str
 ;
 ;
SERVER(debug)      ;
 c 56 s $ZT="SRVERR^"_$ZN,mode="Server"
 l +^VTSTX
 o 56
 u 56::"TCP"
 w /SOCKET("",20850)
 s a=$za,b=$zb,c=$zc,d=$d,k=$key
 d:$zc
 .d:debug errlog("$za="_a_",  $zb="_b_",  $zc="_c_",  $d="_d_",  $key="_k,130)
 .zt "OpenErr"
 d:k="" errlog("hostname is null ($KEY after /SOCKET)",140)
 d:debug errlog("hostname is '"_k_"'",150)
 s x=$$recv()
 i x'?1"Messages="1.n zt "BadRequest"
 s msgs=$p(x,"Messages=",2)
 ;
 f i=1:1:msgs s j=$$recv() d send("Server: "_j)
 c 56
 q
 ;
 ;
SRVERR d errlog("detected error: "_$ze,160)
 c 56
 q
 ;
 ;
errlog(msg,id)     ;
 l +^VTST($ZN)
 s num=$o(^VTST($ZN,""),-1)+1
 s ^VTST($ZN,num)=mode_": "_msg_" (id="_id_")"
 l -^VTST($ZN)
 q
