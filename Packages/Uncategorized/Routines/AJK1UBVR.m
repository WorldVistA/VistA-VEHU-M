AJK1UBVR ;580/MRL - Collections, Version; 04-Jun-99
 ;;2.0T8;AJK1UB;Sep 15, 1999
 ;
 ;This routine determines what version of collections is currently
 ;running.  The following is returned:
 ;
 ;   -1  =  never installed
 ;    #  =  current version number [^diz(580950.1,1,"VER")]
 ;
 ;called from ^AJK1UBX (post-init) to see if certain parts of the
 ;post-initialization are necessary.  For example, default values
 ;are only stuffed into files on initial installation.
 ;
VER() ; --- obtain version number
 ;
 I '$D(^DIZ(580950.1,1,0)) Q -1
 S X=+$G(^DIZ(580950.1,1,"VER"))
 S:'X X=2.0
 Q X
