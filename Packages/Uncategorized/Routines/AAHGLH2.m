%AAHGLH2 ;402,DJB,3/24/92**Help Text - Main Screen
 ;;GEM III;;
 ;;David Bolduc - Togus, ME
 F I=1:1 S TEXT=$P($T(TXT+I),";;;",2) Q:TEXT="***"  W !,TEXT I $Y>GEMSIZE D PAGE Q:FLAGQ
EX ;
 Q
TXT ;Start of text
 ;;;
 ;;;  O T H E R   Submenu
 ;;;
 ;;;   S'n'       Skip over subscipt level 'n'.
 ;;;              Example:  Assume you started the listing with the USER file
 ;;;              ^DIC(3, and you were now at ^DIC(3,4,"FOF",3.05,0). If you
 ;;;              wanted to skip to the next user, you would enter S2. This means
 ;;;              subscript level 2 would skip to the next value. This would
 ;;;              result in ^DIC(3,5,0) being displayed. If instead, you wanted to
 ;;;              skip the "FOF" nodes, you would enter S3. This would result in
 ;;;              ^DIC(3,4,"PHONE") being displayed.
 ;;;
 ;;;    C         Enter Mumps code in the form of an IF statement. If True,
 ;;;              the node will be displayed. When you select 'C' you will see
 ;;;              a display of available variables. These variables may be used
 ;;;              in your code.
 ;;;
 ;;;              NOTE: To run this option, DUZ(0) must contain '@'.
 ;;;
 ;;;              Examples:
 ;;;
 ;;;                   I $P(GLVAL,U,2)=5
 ;;;
 ;;;              This will display only those nodes whose 2nd "Piece" equals 5.
 ;;;
 ;;;                   I 1 W !?40,"PIECE 5: ",$P(GLVAL,U,5)
 ;;;
 ;;;              This will display "Piece" 5 on one line and the entire node on
 ;;;              the next, so you can track the changes in value of "Piece" 5.
 ;;;
 ;;;              Some code searches may take a long time depending on the range
 ;;;              of nodes you started with. For example: If you started with
 ;;;              ^VA(200, a search would go through the entire NEW PERSON file.
 ;;;              For this reason, I allow you to abort a search by hitting any
 ;;;              key. The display of all nodes will resume in the normal fashion.
 ;;;              If you have Backed-Up a screen and then selected "C", the
 ;;;              first pass will check the entries for that screen only. When
 ;;;              you hit <RETURN> it will continue on with the rest of the
 ;;;              nodes.
 ;;;
 ;;;    R         A Fileman subscript has the following pattern:
 ;;;                 Root..Variable..Constant..Variable..Constant..etc
 ;;;              Entering "R" will display the Variable segments in reverse
 ;;;              video. This is beneficial when you are writing code that $ORDERs
 ;;;              down the subscript, making it very clear which segment is a
 ;;;              Constant. There is a speed penalty when using this option,
 ;;;              so you may use "R" to toggle it on and off as necessary.
 ;;;              If you enter "R" and no reverse video appears, it's because
 ;;;              the global being listed is not in ^DIC (the FILE of files) or
 ;;;              does not adhere to a normal Fileman format.
 ;;;
 ;;;    H         H is a Hot Key that is active when you have an alternate
 ;;;              session going and are viewing 2 globals. It allows you to jump
 ;;;              back and forth between the 2 globals to make comparisons.
 ;;;              It is initiated from Session 2. When you view the Session 1
 ;;;              global this way, you may only see those screens that were
 ;;;              initially displayed in Session 1.
 ;;;***
PAGE ;
 Q:$P($T(TXT+(I+1)),";;;",2)="***"
 R !!?2,"<RETURN> to continue, '^' to quit: ",GEMXX:GEMTIME S:'$T GEMXX="^" S:GEMXX["^" FLAGQ=1 I FLAGQ Q
 W @GEMIOF,!?1,"E N T E R",?38,"R  E  S  U  L  T",!?1,"---------",?14,"----------------------------------------------------------------"
 Q
