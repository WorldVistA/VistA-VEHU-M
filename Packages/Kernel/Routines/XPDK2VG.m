XPDK2VG ; OSE/SMH - Export Global Type Builds ; 6/9/17 4:11pm
 ;
GLOEXP(XPDFAIL,SN,ROOT,BLDIEN) ; Main Entry point
 ; .XPDFAIL (bool) did we fail? Return only.
 ; SN = Short Name
 ; ROOT   = Export Root directory
 ; BLDIEN = Build IEN
 ; 
 ; Global data is still in ^TMP("XPDK2VC-OUT",$J,glo)
 ; Globals are in a 1 2 format, like %GO format
 ;
 ; Build has already been exported.
 ; NB: Only build has info on whether to delete the global first
 ;
 ; Load each global into a zwrite like format for later export
 ; 
 N GLODIR S GLODIR=ROOT_"Globals"_$$D^XPDOS()
 N % S %=$$MKDIR^XPDOS(GLODIR)
 I % S XPDFAIL=1 QUIT
 D EN^DDIOL("Exporting these globals to "_GLODIR)
 D EN^DDIOL("")
 ;
 n i
 for i=0:0 set i=$o(@SN@("BLD",BLDIEN,"GLO",i)) quit:'i  do
 . n eachGlobal s eachGlobal=$P(@SN@("BLD",BLDIEN,"GLO",i,0),U)
 . do convertToZwrite(eachGlobal),export(eachGlobal,GLODIR)
 quit
 ;
convertToZwrite(g) ; Convert each global into a zwrite format
 ; ZEXCEPT: XPDFAIL,SN,ROOT,BLDIEN
 ;
 ;
 ; cnvert va(200) to va(200,
 N oroot S oroot=$S($e(g,$l(g))=")":$e(g,1,$l(g)-1)_",",1:g_"(")
 n traverseNode s traverseNode=$name(^TMP("XPDK2VC-OUT",$j,g))
 n traverseNodem1 s traverseNodem1=$e(traverseNode,1,$l(traverseNode)-1)
 n currentNode s currentNode=traverseNode
 ; ^TMP("XPDK2VC-OUT",7585,"VA(200,998)",3)=".1)"
 ; ^TMP("XPDK2VC-OUT",7585,"VA(200,998)",4)="60000,1^`tu?JVVs4fz_8#_zL{qy"
 new state set state="global" ; or data
 new subs,value
 new cnt set cnt=0
 new skipFirst set skipFirst=1
 new q set q="""" ; Single double quote
 for  set currentNode=$query(@currentNode) quit:($name(@currentNode,3)'=traverseNode)  quit:currentNode=""  do
 . if skipFirst set skipFirst=0 quit  ; skip zero node
 . if state="global" set subs=@currentNode,state="value" quit
 . if state="value"  do
 .. set value=@currentNode
 .. if value[q s value=$$CONVQQ^DILIBF(value)
 .. set value= q_value_q
 .. set cnt=cnt+1
 .. set @SN@("BLD",BLDIEN,"GLO","ZWRITE",g,cnt)="^"_oroot_subs_"="_value
 .. set state="global"
 quit
 ;
export(g,dir) ; Export Each Global
 N POP
 D EN^DDIOL(g,,"?5")
 D OPEN^%ZISH("GLOBAL",dir,g_".zwr","W")
 I POP S XPDFAIL=1 QUIT
 U IO
 n i f i=0:0 s i=$o(@SN@("BLD",BLDIEN,"GLO","ZWRITE",g,i)) q:'i  w ^(i),!
 D CLOSE^%ZISH("GLOBAL")
 quit
