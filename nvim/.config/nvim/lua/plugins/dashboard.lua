local util = require("util")

local headers = {
  [[
 __________________________________________
/ “I do not fear computers. I fear lack of \
\  them.”— Isaac Asimov                    /
 ------------------------------------------
  \
   \
                     _____
                   .\'* *.\'
               ___/_*_(_
              / _______ \
             _\_)/___\(_/_
            / _((\- -/))_ \
            \ \())(-)(()/ /
             ' \(((()))/ \'
            / \' \)).))\ \' \
           / _ \ - | - /_  \
          (   ( .;\'\'\';. .\'  )
          _\\"__ /    )\ __\"/_
            \/  \   \' /  \/
             .\'  \'...\' \'  )
              / /  |   \  \
             / .   .    .  \
            /   .      .    \
           /   /   |    \    \
         .\'   /    b     \'.   \'.
     _.-\'    /     Bb      \'-.  \'-_
 _.-\'       |      BBb        \'-.  \'-.
(________mrf\____.dBBBb._________)____)
]],
  [[
 __________________________________________
/ “A computer once beat me at chess, but i \
| t was no match for me at kick boxing.”—  |
\ Emo Philips                              /
 ------------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||--WWW |
                ||     ||
]],
  [[
 __________________________________________
/ “Computer Science is no more about compu \
| ters than astronomy is about telescopes. |
\ ”— Edsger W. Dijkstra                    /
 ------------------------------------------
    \
     \
      \
  ___       _____     ___
 /   \     /    /|   /   \
|     |   /    / |  |     |
|     |  /____/  |  |     |
|     |  |    |  |  |     |
|     |  | {} | /   |     |
|     |  |____|/    |     |
|     |    |==|     |     |
|      \___________/      |
|                         |
|                         |
]],
  [[
 __________________________________________
/ “The computer was born to solve problems \
\  that did not exist before.”— Bill Gates /
 ------------------------------------------
   \         ,        ,
    \       /(        )`
     \      \ \___   / |
            /- _  `-/  '
           (/\/ \ \   /\
           / /   | `    \
           o o   ) /    |
           `-^--'`<     '
          (_.)  _  )   /
           `.___/`    /
             `-----' /
<----.     __ / __   \
<----|====O)))==) \) /====
<----'    `--' `.__,' \
             |        |
              \       /
        ______( (_  / \______
      ,'  ,-----'   |        \
      `--{__________)        \/
]],
  [[
 __________________________________________
/ “Software is like entropy: It is difficu \
| lt to grasp, weighs nothing, and obeys t |
| he Second Law of Thermodynamics; i.e., i |
\ t always increases.”— Norman Augustine   /
 ------------------------------------------
   \
    \        .
     .---.  //
    Y|o o|Y//
   /_(i=i)K/
   ~()~*~()~
    (_)-(_)

     Darth
     Vader
     koala
]],
  [[
 __________________________________________
/ “Software is a gas; it expands to fill i \
\ ts container.”— Nathan Myhrvold          /
 ------------------------------------------
   \         ,        ,
    \       /(        )`
     \      \ \___   / |
            /- _  `-/  '
           (/\/ \ \   /\
           / /   | `    \
           o o   ) /    |
           `-^--'`<     '
          (_.)  _  )   /
           `.___/`    /
             `-----' /
<----.     __ / __   \
<----|====O)))==) \) /====
<----'    `--' `.__,' \
             |        |
              \       /
        ______( (_  / \______
      ,'  ,-----'   |        \
      `--{__________)        \/
]],
  [[
 __________________________________________
/ “All parts should go together without fo \
| rcing.  You must remember that the parts |
|  you are reassembling were disassembled  |
| by you.  Therefore, if you can’t get the |
| m together again, there must be a reason |
| .  By all means, do not use a hammer.”—  |
\ IBM Manual, 1925                         /
 ------------------------------------------
   \
    \
      _____   _________
     /     \_/         |
    |                 ||
    |                 ||
   |    ###\  /###   | |
   |     o  \/  o    | |
  /|                 | |
 / |        <        |\ \
| /|                 | | |
| |     \_______/   |  | |
| |                 | / /
/||                 /|||
   ----------------|
        | |    | |
        ***    ***
       /___\  /___\
]],
  [[
 __________________________________________
/ “Standards are always out of date.  That \
| ’s what makes them standards.”— Alan Ben |
\ nett                                     /
 ------------------------------------------
           \
            \
        "-.. __      __.='>
         `.     """""   ,'
           "-..__   _.-"
   ~ ~~ ~ ~  ~   """  ~~  ~
]],
  [[
 __________________________________________
/ “Physics is the universe’s operating sys \
\ tem.”— Steven R Garman                   /
 ------------------------------------------
                                    \
                                     \
                                                         ____
                                               [(=]|[==/   @  \
                                                      |--------|
     *                                     *  .       ==========
.  / *    .                         *   .* . * /.     ==========
 / /  .                      *   .    *  \. * /      ||||||||||||
 =-=-=-=-=-=-----==-=--=-=--=-=-=-=---=--= -. %%%%%%[-- ||||||||||
  \  \ .                             *  (===========[  /=========]
.  \   *  *                          .    /  * \   |==============]
         *                        *      *         C @ @ @ @ @ @ |D
        *  *                          .           /              |
                                         .       C  @ @ @  @ @  @ |D
          *                          *          /                 |
                                               C  @  @  @  @  @  @ |D
                                              /                    |
                                             C  @   @   @   @  @  @ |D
                                            /                       |
                                           |@@@@@@@@@@@@@@@@@@@@@@@@@|
                                            -------------------------
Modified from howard1@vax.oxford.ac.uk
]],
  [[
 __________________________________________
/ “It’s hardware that makes a machine fast \
| .  It’s software that makes a fast machi |
\ ne slow.”— Craig Bruce                   /
 ------------------------------------------
     \
      \
          oO)-.                       .-(Oo
         /__  _\                     /_  __\
         \  \(  |     ()~()         |  )/  /
          \__|\ |    (-___-)        | /|__/
          '  '--'    ==`-'==        '--'  '
]],
  [[
 __________________________________________
/ “Imagination is more important than know \
| ledge.  For knowledge is limited, wherea |
| s imagination embraces the entire world, |
|  stimulating progress, giving birth to e |
\ volution.”— Albert Einstein              /
 ------------------------------------------
    \
     \
      \
       \
                                           .::.
                                           _::_
                                 ()      _/____\_
                               <~~~~>    \      /
                       <>_      \__/      \____/      <>_
           __/"""\   (\)  )    (____)     (____)    (\)  )   __/"""\
  WWWWWW  ]___ 0  }   \__/      |  |       |  |      \__/   ]___ 0  }  WWWWWW
   |  |       /   }  (____)     |  |       |__|     (____)      /   }   |  |
   |  |     /~    }   |  |      |__|      /    \     |  |     /~    }   |  |
   |__|     \____/    |__|     /____\    (______)    |__|     \____/    |__|
  /____\    /____\   /____\   (______)  (________)  /____\    /____\   /____\
 (______)  (______) (______) (________) /________\ (______)  (______) (______)

    __        __       __        __         __        __        __       __
   (  )      (  )     (  )      (  )       (  )      (  )      (  )     (  )
    ||        ||       ||        ||         ||        ||        ||       ||
   /__\      /__\     /__\      /__\       /__\      /__\      /__\     /__\
  (____)    (____)   (____)    (____)     (____)    (____)    (____)   (____)
]],
  [[
 __________________________________________
/ “The greatest enemy of knowledge is not  \
| ignorance, it is the illusion of knowled |
\ ge.”— Stephen Hawking                    /
 ------------------------------------------
    \
     \
                  \#[/[#:xxxxxx:#[/[\x
             [/\ &3N            W3& \/[x
          [[x@W                      W@x[[\
        /#&N                             N_#
      /#@                                  @#/x
    [/ NH_  ^@W               Nd_  ^@p      N /#
   [[d@#_ zz@[/x3           3x:d9zz \/#_N     d[[
  /[3^[JMMMJ/////&         ^#NMMMMM ////#W     H[[
 [/@p/NMMMML@#[:^/3       d/JMMMMMMEx[# x\      &/#
 /x &/LMMMMMMMMMM[_       x:MMMMMMMMMMMM /p      :/
[/d d/ELLLLLLLLLD/&        \#LLLLLLLLLLLL3/N      d/[
//N   xxxxxxxxxxxxN       Wxxxxxxxxxxxxxx_       W//
/[                                                //
//N   p333333333333333333333333333333333p        W//
[/d   _^/#\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\/H       @/[
 /:     \#                              [x       :/
 [/@    d/x                             \#:      &/#
  [[H    ^[x                            [      H[[
   [[d    _[x            &Hppp3d_      \#\N    @[[
    [/ N   d#\        &NzDDDDDDDDJp^ x[xN   N /#
      /#&   N [:     pDDDDDDDDDDDDJ&#:H    &#/
       :/#_W  W^##x 3DDDDDDDDDJN&:\^p   W_#/
          [[x&W  p& xx ^^^^ x:x @W   W&x/[
             [/# &HW   WWWWN    WH& \#/[
                 [/[#\xxxxxx\#[/[\x^@
]],
  [[
 __________________________________________
/ “The more you know, the more you realize \
\  you know nothing.”— Socrates            /
 ------------------------------------------
     \
      \

         .-;\':\':\'-.
        {\'.\'.\'.\'.\'.}
         )        \'`.
        \'-. ._ ,_.-=\'
          `). ( `);(
          (\'. .)(,\'.)
           ) ( ,\').(
          ( .\').\'(\').
          .) (\' ).(\'
           '  ) (  ).
            .\'( .)\'
              .).\'
jgs

]],
  [[
 __________________________________________
/ “Tell me and I forget.  Teach me and I r \
| emember.  Involve me and I learn.”— Benj |
\ amin Franklin                            /
 ------------------------------------------
         \
          \
                    ##        .
              ## ## ##       ==
           ## ## ## ##      ===
       /""""""""""""""""\___/ ===
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/
         \    \        __/
          \____\______/

]],
  [[
 __________________________________________
/ “Real knowledge is to know the extent of \
\  one’s ignorance.”— Confucius            /
 ------------------------------------------
     \     .-.
      \  .'   `.
       \ :g g   :
        \: o    `.
        :         ``.
       :             `.
      :  :         .   `.
      :   :          ` . `.
       `.. :            `. ``;
          `:;             `:'
             :              `.
              `.              `.     .
                `'`'`'`---..,___`;.-'
]],
  [[
 __________________________________________
/ “If people never did silly things, nothi \
| ng intelligent would ever get done.”— Lu |
\ dwig Wittgenstein                        /
 ------------------------------------------
  \
   \
    \

     iﾆﾆi
    /   /ヽ
   ｜農｜｜
   ｜協｜｜
   ｜牛｜｜＿
 ／｜乳｜｜／
 ￣￣￣￣￣
]],
  [[
 __________________________________________
/ “Getting information off the Internet is \
|  like taking a drink from a fire hydrant |
\ .”— Mitchell Kapor                       /
 ------------------------------------------
   \
    \
                      ,:二二二二:. .,
                   ／.／＿＿＿_  ＼.:＼
                  /. /／.: .: .:＼  : .:＼
                 /.: .: .:/｜:/\ .:＼}.: .:.
                .: |.:/一/ |:/ 一.:}: .: .:｜
                |.:|ノ |/_｜/ _  \/ﾍ: .: .:|
                |.: ｜= ＝    ＝＝= \/}: .:|
                |:: ﾘ''           '' /:/､.:|
               ノ:|:人    一一 ､    /:/ ﾉ.:|
                , ┴＜＼  {     ｝ ,{:/イ::八
               /_..   ＼` ー┬一r＜:八八／
               ／  T＼   `＜}ゞ=彡'⌒＼＼_>
              /___ |  >､    ｀''＼   ｜
             /ﾆ}::\/／  ＼       ｜  ｜
          　{ﾆﾉ:: /''＼ | `|r--ｯ＜|_／|
           /__   V    ｝|  》=《      |
           ＼ ＼/｀一ﾍノ|  { 6 }     ｛
             ￣        ｢   ゞ= '      }
                      ﾉ               〉
]],
  [[
 __________________________________________
/ “If you think your users are idiots, onl \
\ y idiots will use it.”— Linus Torvalds   /
 ------------------------------------------
                          \
                           \         __.----.___
           ||            ||  (\(__)/)-'||      ;--` ||
          _||____________||___`(oo)'___||______;____||_
          -||------------||----)  (----||-----------||-
          _||____________||___(o  o)___||______;____||_
          -||------------||----`--'----||-----------||-
           ||            ||        `|| ||| || ||     ||jgs
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
]],
  [[
 __________________________________________
/ “From a programmer’s point of view, the  \
| user is a peripheral that types when you |
\  issue a read request.”— P. Williams     /
 ------------------------------------------
  \
   \

    A__A
   ( OO )\_----__
   (____)\      )\/\
        ||      |
        ||`---w||
]],
  [[
 __________________________________________
/ “Where is the ‘any’ key?”— Homer Simpson \
| , in response to the message, “Press any |
\  key”                                    /
 ------------------------------------------
    \
     \                                                           ＿＿＿ノ^l
      \                                            ＿,,ノ``ｰ-'￣￣        ｌ
                                                 く                       /
                                                  `ヽ,   __､-'           /
                                                    __＞‐´               |
                                           ._,;‐''``              ,     /
                                         _;"                     /     /
                                       ／                       /     く
                                     ／                        /       |
                                   ／                        ／       ｌ
                                 ノ                        ／￣ヽ     /
                                /                        ／     ） _ノ
                            ,r'″ヽ、                   ／        ￣
                           /      ヽ                 ／
                        ＿ﾉ        `r            _､‐'
                      ／          _l,_       _､‐'
                 __,r'          ／r;;,ヽ   ／
               ,/              ｜.;●,;;|  ノ
              ノ ／  ／／       ヽ､!!!ﾞﾉ "
            ／ ／／／  ／／___,r''"￣
           / ／ / / /／ / /
      ___／／/／／／ ／／/
  ／￣＿_／／／/ / ／／／
 l ／´___／／／／／／ /
 しレ"／／/ /  ／／//／
      / ,/ / ／／／ /
      ﾚ'   ﾚ'／／ ／
           ／l｜l/
          ｜|ﾚ'lノ
           レ'
]],
  [[
 __________________________________________
/ “Computers are good at following instruc \
| tions, but not at reading your mind.”— D |
\ onald Knuth                              /
 ------------------------------------------
  \
   \   \_\_    _/_/
    \      \__/
           (oo)\_______
           (__)\       )\/\
               ||----- |
               ||     ||
]],
  [[
 __________________________________________
/ “There is only one problem with common s \
\ ense; it’s not very common.”— Milt Bryce /
 ------------------------------------------
  \            .    .     .
   \      .  . .     `  ,
    \    .; .  : .' :  :  : .
     \   i..`: i` i.i.,i  i .
      \   `,--.|i |i|ii|ii|i:
           UooU\.'@@@@@@`.||'
           \__/(@@@@@@@@@@)'
                (@@@@@@@@)
                `YY~~~~YY'
                 ||    ||
]],
  [[
 __________________________________________
/ “Your most unhappy customers are your gr \
\ eatest source of learning.”— Bill Gates  /
 ------------------------------------------
       \
        \

     ".           ,#
     \ `-._____,-'=/
  ____`._ ----- _,'_____PhS
         `-----'
]],
  [[
 __________________________________________
/ “Let us change our traditional attitude  \
| to the construction of programs: Instead |
|  of imagining that our main task is to i |
| nstruct a computer what to do, let us co |
| ncentrate rather on explaining to human  |
| beings what we want a computer to do.”—  |
\ Donald E. Knuth                          /
 ------------------------------------------
      \                            |     |
       \                        ,--|     |-.
                         __,----|  |     | |
                       ,;::     |  `_____' |
                       `._______|    i^i   |
                                `----| |---'| .
                           ,-------._| |== ||//
                           |       |_|P`.  /'/
                           `-------' 'Y Y/'/'
                                     .==\ /_\
   ^__^                             /   /'|  `i
   (oo)\_______                   /'   /  |   |
   (__)\       )\/\             /'    /   |   `i
       ||----w |           ___,;`----'.___L_,-'`\__
       ||     ||          i_____;----\.____i""\____\
]],
  [[
 __________________________________________
/ “The Internet?  We are not interested in \
\  it.”— Bill Gates, 1993                  /
 ------------------------------------------
  \
   \                       _
                          / )
                         / /
      //|                \ \
   .-`^ \   .-`````-.     \ \
 o` {|}  \_/         \    / /
 '--,  _ //   .---.   \  / /
   ^^^` )/  ,/     \   \/ /
        (  /)      /\/   /
        / / (     / (   /
    ___/ /) (  __/ __\ (
   (((__)((__)((__(((___)
]],
  [[
 __________________________________________
/ “The best way to get accurate informatio \
| n on Usenet is to post something wrong a |
| nd wait for corrections.”— Matthew Auste |
\ rn                                       /
 ------------------------------------------
      \                    / \  //\
       \    |\___/|      /   \//  \\
            /o  o  \__  /    //  | \ \
           /     /  \/_/    //   |  \  \
           @_^_@'/   \/_   //    |   \   \
           //_^_/     \/_ //     |    \    \
        ( //) |        \///      |     \     \
      ( / /) _|_ /   )  //       |      \     _\
    ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
  (( / / )) ,-{        _      `-.|.-~-.           .~         `.
 (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
 (( /// ))      `.   {            }                   /      \  \
  (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
             ///.----..>        \             _ -~             `.  ^-`  ^-_
               ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
                                                                  /.-~
]],
  [[
 __________________________________________
/ “The most likely way for the world to be \
|  destroyed, most experts agree, is by ac |
| cident.  That’s where we come in; we’re  |
| computer professionals.  We cause accide |
\ nts.”— Nathaniel Borenstein              /
 ------------------------------------------
  \
   \

:. :.孑|:/仔:./  ＼:.| V｜:. ﾄ:. :.
:. :/  |/  |:/     ヽ|   \/:!\/:.:
:. / ,ィf芋ミ     ィf芋｀:V  .\/.
:./ ,' :'::::ﾊ      ,':::::ﾊ ヽ /:.
:t  { {k)::::!     !k)::::!  },'.:
:ﾊ    弋 一ソ      弋 一 ｿ ,: ::
:.{      ￣    ,       ￣  ; :./
:.| ''                  '' |:./
:.ﾄ､      ` ､      ノ     ﾉ!:/ノ
ﾄ､!:＞ ､.     一  '   .,＜:|/::.
:: :: :: ::>z-一-z<:: :: :: :: :.
V|＼:/}ﾍ/  `ー又ー' \/}ノ{／|:／
  ,z'￣ ﾍ   /{ .ﾄ､  /￣  ヽ
／      /\./x 一 ﾐ./       ＼
]],
  [[
 __________________________________________
/ “Pessimists, we’re told, look at a glass \
|  containing 50% air and 50% water and se |
| e it as half empty.  Optimists, in contr |
| ast, see it as half full.  Engineers, of |
|  course, understand the glass is twice a |
\ s big as it needs to be.”— Bob Lewis     /
 ------------------------------------------
\                             .       .
 \                           / `.   .' "
  \                  .---.  <    > <    >  .---.
   \                 |    \  \ - ~ ~ - /  /    |
         _____          ..-~             ~-..-~
        |     |   \~~~\.'                    `./~~~/
       ---------   \__/                        \__/
      .'  o    \     /               /       \  "
     (_____,    `._.'               |         }  \/~~~/
      `----.          /       }     |        /    \__/
            `-.      |       /      |       /      `. ,~~|
                ~-.__|      /_ - ~ ^|      /- _      `..-‘ / \  /\
                     |     /        |     /     ~-.     `-/ _ \/__\
                     |_____|        |_____|         ~ - . _ _ _ _ _>
]],
  [[
 __________________________________________
/ “In a room full of top software designer \
| s, if two agree on the same thing, that’ |
\ s a majority.”— Bill Curtis              /
 ------------------------------------------
 \
  \
   \     O_      __)(
       ,'  `.   (_".`.
      :      :    /|`
      |      |   ((|_  ,-.
      ; -   /:  ,'  `:(( -\
     /    -'  `: ____ \\\-:
    _\__   ____|___  \____|_
   ;    | |        '-`      :
  :_____|:|__________________:
  ;     |:|                  :
 :      |:|                   :
 ;_______`'___________________:
:                              :
|______________________________|
 `---.--------------------.---'
     |____________________|
     |                    |
     |____________________|
     |                    |
   _\|_\|_\/(__\__)\__\//_|(_
]],
  [[
 __________________________________________
/ “It should be noted that no ethically-tr \
| ained software engineer would ever conse |
| nt to write a DestroyBaghdad procedure.  |
|  Basic professional ethics would instead |
|  require him to write a DestroyCity proc |
| edure, to which Baghdad could be given a |
\ s a parameter.”— Nathaniel S. Borenstein /
 ------------------------------------------
   \
    \

             _ - ￣ - _
           _-_＿＿＿＿_- _
         ￣ｌ  ●   ●  l￣
            ヽ､_ ⌒ _ノ
         _ -‐ニ ￣ ニ‐- _
  /⌒ ‐ﾆ‐ ￣   /    \ ￣ ‐ﾆ‐⌒ヽ
 ヽ､_ノ       └-ｕ‐┘      ヽ､_ノ
]],
  [[
 __________________________________________
/ “Mostly, when you see programmers, they  \
| aren’t doing anything.  One of the attra |
| ctive things about programmers is that y |
| ou cannot tell whether or not they are w |
| orking simply by looking at them.  Very  |
| often they’re sitting there seemingly dr |
| inking coffee and gossiping, or just sta |
| ring into space.  What the programmer is |
|  trying to do is get a handle on all the |
|  individual and unrelated ideas that are |
|  scampering around in his head.”— Charle |
\ s M. Strauss                             /
 ------------------------------------------
 \
  \
  __/"""\
 ]___ 0  }
     /   }
   /~    }
   \____/
   /____\
  (______)
]],
  [[
 __________________________________________
/ “If you think you are worth what you kno \
| w, you are very wrong.  Your knowledge t |
| oday does not have much value beyond a c |
| ouple of years.  Your value is what you  |
| can learn and how easily you can adapt t |
| o the changes this profession brings so  |
\ often.”— Jose M. Aguilar                 /
 ------------------------------------------
    \
     \
      \
                    ___
                _.-'   ```'--.._
              .'                `-._
             /                      `.
            /                         `.
           /                            `.
          :       (                       \
          |    (   \_                  )   `.
          |     \__/ '.               /  )  ;
          |   (___:    \            _/__/   ;
          :       | _  ;          .'   |__) :
           :      |` \ |         /     /   /
            \     |_  ;|        /`\   /   /
             \    ; ) :|       ;_  ; /   /
              \_  .-''-.       | ) :/   /
             .-         `      .--.'   /
            :         _.----._     `  <
            :       -'........'-       `.
             `.        `''''`           ;
               `'-.__                  ,'
                     ``--.   :'-------'
                         :   :
                        .'   '.
]],
  [[
 __________________________________________
/ “Programs must be written for people to  \
| read, and only incidentally for machines |
\  to execute.”— Abelson and Sussman       /
 ------------------------------------------
         \
          \
           ___
          (o o)
         (  V  )
        /--m-m-
]],
  [[
 __________________________________________
/ “Commenting your code is like cleaning y \
| our bathroom — you never want to do it,  |
| but it really does create a more pleasan |
| t experience for you and your guests.”—  |
\ Ryan Campbell                            /
 ------------------------------------------
  \
   \
    \     ,, ＿
        ／      ｀､
       /   (_ﾉL_） ヽ
      /   ´・ ・｀  l
    （l      し     l）
      l     ＿＿    l
      >  ､ _      ィ
    ／        ￣    ヽ
   /  |              iヽ
   |＼|              |/|
   |  ||/＼／＼／＼/ | |
]],
  [[
 __________________________________________
/ “We have to stop optimizing for programm \
| ers and start optimizing for users.”— Je |
\ ff Atwood                                /
 ------------------------------------------
       \
        \
         \
          \
          |\___/|
         =) oYo (=
          \  ^  /
           )=*=(
          /     \
          |     |
         /| | | |\
         \| | |_|/\
         //_// ___/
             \_)
]],
  [[
 __________________________________________
/ “Low-level programming is good for the p \
\ rogrammer’s soul.”— John Carmack         /
 ------------------------------------------
  \
   \   \
        \ /\
        ( )
      .( o ).
]],
  [[
 __________________________________________
/ “It’s OK to figure out murder mysteries, \
|  but you shouldn’t need to figure out co |
| de.  You should be able to read it.”— St |
\ eve McConnell                            /
 ------------------------------------------
     \
      \

         .-;\':\':\'-.
        {\'.\'.\'.\'.\'.}
         )        \'`.
        \'-. ._ ,_.-=\'
          `). ( `);(
          (\'. .)(,\'.)
           ) ( ,\').(
          ( .\').\'(\').
          .) (\' ).(\'
           '  ) (  ).
            .\'( .)\'
              .).\'
jgs

]],
  [[
 __________________________________________
/ “If we wish to count lines of code, we s \
| hould not regard them as ‘lines produced |
| ’ but as ‘lines spent.'”— Edsger Dijkstr |
\ a                                        /
 ------------------------------------------
     \
      \  (__)
         (\/)
  /-------\/
 / | 666 ||
*  ||----||
   ~~    ~~
]],
  [[
 __________________________________________
/ “Programming can be fun, so can cryptogr \
| aphy; however they should not be combine |
\ d.”— Kreitzberg and Shneiderman          /
 ------------------------------------------
  \
   \
       ___
     {~o_o~}
      ( Y )
     ()~*~()
     (_)-(_)
]],
  [[
 __________________________________________
/ “Before software should be reusable, it  \
\ should be usable.”— Ralph Johnson        /
 ------------------------------------------
        \         ____________________
         \       |                    |
          \      |     PSYCHIATRIC    |
           \     |        HELP        |
            \    |____________________|
             \   ||  ,-..'``.        ||
              \  || (,-..'`. )       ||
                 ||   )-c - `)\      ||
   ,.,._.-.,_,.,-||,.(`.--  ,`',.-,_,||.-.,.,-,._.
              ___||____,`,'--._______||
             |`._||______`'__________||
             |   ||     __           ||
             |   ||    |.-' ,|-      ||
   _,_,,..-,_|   ||    ._)) `|-      ||,.,_,_.-.,_
            . `._||__________________||   ____    .
     .              .           .     . <.____`>
   .SSt  .      .     .      .    .   _.()`'()`'  .
]],
  [[
 __________________________________________
/ “If you automate a mess, you get an auto \
\ mated mess.”— Rod Michael                /
 ------------------------------------------
     \
      \
                  ,
         ___     /^\   ,
        `\  \'...`   \_/^\
          ) ~     ',    /__,
         /       ,.    ,, /___,
        (  .-.   \'.\'. /// ___/
         ) .-.\'  .`.`///-.\'.
        / ( o )  .\"\". ====) \
       (   \'-`   \  |\'~~~`  u\,
        \ _~  .\"\"\"` |~|^u^ u^(\"\"
        //  ."     /~/^ u^ u^\
       // ."      /~  u^ u  ^u\      _
      // ."      /~/U^ U^ U^ ^(     / )
     /` ."       |~  U^ U^ ^ U^\   /) _)
   ./` ."        |~|^ U^ ^U ^ U(  / _  _)
  ;.`."          |~ ^U ^ U^ U ^/ /)_ =  _)
   \"\"            |~|^ ^U ^ ^ U(_/_    )- _)
                 |~ U ^ ^U ^U ^ )   =    _)
                 \~|^ U U^ U ^ =  ~ )  - _)
                  \ U ^U ^ ^U^_)     =  _)
                   \",^U^ ^U ^/ \)_~   -_)
                     \".u^u ^|   \_  = _)
                      ).u ^u|    \)  _)
                      \u ^u^(     \__)
                       )^u ^u\
                       \u ^u ^|
             ____       )^u ^u|
          ,-`    '-.    )u ^u^|
         /  .---. ' \  / ^ u^/
        |  ;  `  '  | /u^u ^/
        |  ;  '-` . `:u^u^u/
        \.\'^\'._   _.`u ^.-`
         \_.~=_```-.^.-\"
           \'\"------\"`

]],
  [[
 __________________________________________
/ “Looking at code you wrote more than two \
|  weeks ago is like looking at code you a |
| re seeing for the first time.”— Dan Hurv |
\ itz                                      /
 ------------------------------------------
        \
         \
          )__(
         '|oo|'________/
          |__|         |
             ||"""""""||
             ||       ||

]],
  [[
 __________________________________________
/ “It is easier to change the specificatio \
| n to fit the program than vice versa.”—  |
\ Alan Perlis                              /
 ------------------------------------------
          \     (
           \     )
            \   (
         /\  .-""""-.  /\
        //\\/  ,,,,  \//\\
        |/\| ,;;;;;;, |/\|
        //\\\;-""""-;///\\
       //  \/   ..   \/  \\
      (| ,-_| \ || / |_-, |)
        //`__(\(__)/)__`\\
       // /.-\`(oo)'/-.\ \\
      (\ |)   ')  ('   (| /)
       ` (|   (o  o)   |) `
         \)    `--'    (/

]],
  [[
 __________________________________________
/ “Less than 10% of the code has to do wit \
| h the ostensible purpose of the system;  |
| the rest deals with input-output, data v |
| alidation, data structure maintenance, a |
\ nd other housekeeping.”— Mary Shaw       /
 ------------------------------------------
       \
        \

     ".           ,#
     \ `-._____,-'=/
  ____`._ ----- _,'_____PhS
         `-----'
]],
  [[
 __________________________________________
/ “If you have a procedure with ten parame \
| ters, you probably missed some.”— Alan P |
\ erlis                                    /
 ------------------------------------------
       \
        \

                                     ...I..
                            :XX:X$ . .7N..            ..$$.. .:~..
                            X:XX.. 8XXI..         ....XX..7..7KKK8.. .
                              N. .XXX,          ..:ZD- ..M.$K:XN?XX.XN .
                              .. XX$.            *. .KN7XXX+ -XX,CN.,XX
                        IXX?..                  ...--+..IXX:X:X..-ZN?DX,.
                      .$XXXXX. .X               ..XX~-7=$7+IX5$...+IM+XXXX.
                    .  +....7D=               .7=IX,: 7+..   . ,.  =+XXID..
                    .-$-.. .    .             .MM-,,..... . ,=7OI.. .,:N7%
          ..17KN. ..XX:XZ.  ..., .            .:.. .     .-IN78IN7=-.,..CMO.                     ..-.
        ..XXXXMO..  ..8X:X= 8D0..               .8 .    .+I:N-X:XXDXXXX.ID..                  ..-XX:XX- .
        .X:DX:XX.     ...8KI78M,                .X......-IM.D.XDXXXXXXX?:. .                .:++7CXXXXXX?.
      . X7XXXXD8 .      .  ?8XXX.....            X+ : ...XX.X.DCO.  .+X-8X,.              . .=?2XXXXXXXXXX.
       .=XXX887+.       .=:+?,:I.XXXXZ.         .7NO.=8+ ...M?.. 8X.$$X 7=..              ..=?X:X7++$NXXXXX:
       =XX:D-...  .:..  .  ...  ...?XXX         .*. X(O)X  :X .X(O)X+X.,.                .*XXX=    . -IXXXD,
     ,-X:XI..     ,.     ...           .       .X..........XX-....=.?N?.O?               .+XXX..       .-XX:X.
    .:ZX8-      . .   ..+$:,..                .DX..D:$78. .XX?:XXXXD?XZ...               +DXX,    ..  .. =X:XX
    --$D   .    ......+XX. .I.                  X-.*XX ..XZXXXXX.XXXXXX 8.              -.XXO.    .:=-7=..:8XX,
  ..:7Z. .      ..  +X:XX.  X..                 :I.........XXX....XX:XX  .            ..7X7Z..  .-II$%>I?+,-X:X.
   :,7..       , ...8X:XX.  XX                  .X ...  . .. .8XX:,-ZXX.              .7IXXX .  .+ODC8:$II7:ZXX:
  .,=.      ..?.  ,8X$XX=   .XX..               ..+..  .-..%77.XXX.$XX .            . *IXXXX    :78DX8D08DN7-XXX.
  .:..       *-...-XXXXX.   .,XX..                8,...O..VVVVV XX:XX               . ZOX:XI  . =ID0X0XODOX:+$XX..
  .:        .? . ,IX:X:X,    .:X=.                .$ .N VV ....VVM+XX.              .=ZOXXX.  . IDO0X0X0D0X:0?XX?.
  ,         ...  :IXXXXXX- .....O.                 7- O...,I.Z.X.X:X,               .7$:$$..   .OCO0X$%DCOXXD$7X>.
  -  ...    ?..  =+X:X:XXDX:XX+ .. . .            ., .I. .VVVVV  XX$..              :.$XXX     +DCXXX$+%$D8ZXXDXO+
  , .*...   .%7...,,,%%0%XXXXXXXXXXO-D$7J0$: ..-:.. ...W,XXXXX,-IXX                .:7XXXX    .CD88DCW..$DX:X:XX?%
 .,.-%,-.   . ?7.  .. ..+%8XX:X:XX:X:X:NO$DX..,XXX.. . ..XXDXXI$XX .               .-O:XX     -CDOI8XX*.*DX:X:X7=%
.--.:$.+ .     .I%       .:7XXXXXXXXXX    . . ....      ..*.-XDXX..               .-:XXX .   .=78CD8XX+  +IXXX>..Z
 ?=:=?.+.        .XX..      ...?8:XXXX-.           .    .:-Z+XX- ....... .       .+,DXX.    .7.,$88DXX:  .:OD%..%O.
 ?+IO--+           -XX.  .        .-7O.    .              .$$.. .7.M.$XXX:...   .++DZM.   ..I$  .$8DX7.,..  .. IXX..
 +??D,$$              .X8.       .        .*      .   . ..  ...*XX X,X:X-: ON?...,XIO     .-O$.   .-. =O,. .  OXXX-.
.:?ID,Z7              .. ....:I-..        .      ...  .+..   :7 XXD. XX,:...+XXX-.,*..    .=$?..  . .:O8.$D7 .IXXX?
 ,+78:Z7 . ,*. ..*.           .....  .....D . ?+.     .:+.  -X+.XX7.8XZ.*.  ..+7XX,     ..*+:.  ... ,8:+.-D0..7XXX7.
.,=$8I88   ,7  :XD-.  ....             +.:,...--|.. ..      7% CXZ..XX,.*.  ....+XX+.   ..:.    .$O..DO,  8D+.-XXXX,
 :-$X0XX ..,*. -DX,... 7... .           .X...::::::-O...    .  .. .7XX...  .,XX. 78-+:..        .OZ.-87   CD$.7XXXX.
.--7O0XI.. :-O:ZM8...-*O.  -.           :% .::-,,::..:,::::--*+I88XXXD....X:X:XX.7XXXXX:        .8%7DO....-8O77DXXX,
 -=78XX.   .**%XX .   %7:..Z .          8. .:X7.::*,* :,,,::-:-*7$DXX+.,.XXX?I+.7X:X:X.-X:      .-%%8O .  .8ODIDXXX,
 -=7IX8.    .*87.   ..$O7-I$..    -.    .... .. ....:,:O:,::-: .7IDXX ..XX..  .:X:... XXXXX.    ..=7+.    .=0D7CXXX:
.-+7IN..          . :..O$7X,      =.  ..,.  ..   ...   O..7.::. ?.XXX,.  .      ..  .X:XZ08. . .          ..$D8%XXX:
.-7II.            .+%. :77:.    .:..  . XD  .-  :...  .:. .   ..... ..          .-  ,X7...,X%.:            . DO8XXX,
 ,I* ,       -?:..8XX. . .....   ...   :XX...X .$  , .?%: ,? ==7X7., .           D..? . .XXXXX:%...         ..%8DXX
 ..      ..  DOX .8XX..-..:==.:  . .   .X%  .X .% .%. XXO DX.D?$X?               XX.  . 7XI.XX.. :.   ....    ..-?,.
        ... .DXX..8XX .?8-Z$?..*.* .    X-  .X..7 7$..XXX.DX+XXXX,   .        . .XX.  .  .  .XX...     .*.  ..  ..
  ....  :,:. IXX-.8XX .-XDXX- .++$..  . X,  .X.%,.+% .XXX.$XIDDDD. .=.  .. ...,8XO..        -XXXX ..    *...., .....
   ,,$. -:*. -DXO+8X$ .,ZXD7,  .:...  .,X.  .?.X- +-..XXX 7XOXXXXO. ..  .NXXXXXXXXX         87%:XX..    -..I7$:.,-.
 . .DX,.-I% ..$XX8DXI   *OI-..  ..    .XX   ..7X8.?,  XXX.$DX:XXID     .XXXXXXX8.. ..       .+XXXXX+  ..,  $XX..:?..
 . .8X-.-%8...*DO$XX7   ......         XX   . XX .I.. XXD 7XX:XX?,     ,..              .8D$X:XXXXXX   ... $8X. ,I7.
    I8$.-OXX..,$D8XX... .  -,,....     XX.  ..X  .?:. ZXO -XX:X$,:...                 .... :XX:IXXXX   ... %8X  .$X.
..  -8D.-O8X...-$CX+ ..D,  -X7,-,.     XX   . 7. .I7 .7X$ :X$XX-.XXI .                .:: ..X:XXXXXX.. ,. .%XX  .CX:
..  .CD.+OCX  . .,. .-.XO. ?8I,IX.  . :X7.  ...   78..8X-.+X+XX, XXD.     .     .:    ..*N= -XXXXXXD  .:. .OXN  .8XI
 .   78*COyX,       .8*XX  =8....   ..$X..... .   XXI XX .XX.XX..?XX..7.  ?,    ..      ..?XXXXXXXX.  ,:. ,OX*  ,DX$
 .  .%D7CO7X$ . .... X7XX   ..        XX . ..   ..XX$ X8  XX.XX...XXX%8   %-              .. .=$XX..  ,:. :ZX   :DX%
.... +XO8O7XD ...+.  X8XX.          .:X.  .7-    ,XX$.D= .XX 8X   DXX$X:  XD.                         .-,.*OX.  =DX%
 .,. .XD8O$XX  ,,$:. OXXX-          .XX.  .D?.  .XXX:-8. +XX DX:   XX7X$  XX                          .=-IZXD   +DX8 .
 ::.  XXXXZX$  .,$D  7XDXI          OX... O8?   .XXX.%8  IXX ZXI   ZX7XD. DX.             ..   .      .=+Z$X=   7DX%
.-:.  IXXN7X. ..:IX. 7DNK$        ..XZ  .$XX- ..OXX8 %Z  7XX.-XX ..+XDXX+.7X-.           :+   .D      .-*$+X... %DX%
.*,,. .XXDIX, ..??X. IDXXI        .XX   .XX8,  :XXX  %% .=DX..XX.. .XX:X8 .XX.           .=.  .X      ..+??X  ..%DX?
.+*-  .OX7?%. .:%77$.7DXX         -X7.  XXX+...XXX:. ZO...DX$.OXX  .+X$XX,.XX,          ....  ,X       .-8$.  .-OXX+
 *I*,. .8+ZI  .=D+XX ,8XX.        XX. .8XX%...7XX7...%X   8XX .XXX  .X$XX$.XXX..              -X      . -X. ..?+DXX:.
 =O7%:. :-I  ..*O+XX  I8,.       .XI. .XX%.. -XXD   .:X:  .XX* ZXXZ..$X7XD.:XX7.              ?8        .-...I8$XXX..
 -X$O%:    .,..=7-XX. .,..      .*X   .OD.  .:+%..   *XD  .8X- .7XX..XX..II +CO               -.     ..   .,%XODXXX...
 :XOOX-.  ..?..:I:XX..                 .$,  .:.     ..,:  .I?,. +8?..$%.  . ..,.            . ,.    .?..   =XX:XXXX
 .XXXD=    ,O. .I.$M=                    .     .     ...  ......-....,..     ..             ..X=     X .   -DXX8XXX
 .XXX8*.  ,,$:. .?+XX                                               .                        =N?..   D     :OXD8XXX
  %XXXI.  ,,7$. +I78N.            ...                                                        ID?.   .I    ..%X8CXX+
  +ICOI   .,:Z- .-XXD.            .,..                                    ..                 7D*..  ..      $D$ZDD..
  ,IOO+.  ,::Z7..7$$D              ,.. .                                  .@.                -O$.:  7.     .78OZ8D..
  .888..  ,-:7O+.7778.            .,.  I .     ..      ....     ...:..  . OO..               .--*:. 7.. .   :%XZ8.
.,.:%I..  ,+:?O?.=I7$.             .   .      ....... . ::    , .*7%..  :.OO=.               ..-+..,?.. .   .I?OI.
    .     ,7:=$7,,II7.            ..  ..   .. .-    ..  +7.   :  77$.-..? %%+                 .7$. +=:,..   .,..
          .+::7Z7.:I+.            ..  :.    .. -* .. $  I$ .  -,.I$7 =  7.XXI                 .*...*,,.... .    .
        . .-*:I$?..*.              .  *.    .  -7.. .7. I$.,  :-.7$7.=  7-$$7                ..    .,- .  ..  ...
    . ...  :7:777. .                  -.    +- +7.   7..7$+ ..?.?77  =  7+777                 .. ..7?I....-   .. .
    = .....,7:-7I-.                   -.    II =I:   :?.?I7   ?.?II. = .I?7::                   ..+--?.. -*,  .=?
    ,,..,. ,**,I?I..              .   ,.   .II :*?.   ?.??I.. ?.:?I. - .I?II?                   . ,:*?-. ==I..=I?.
    .=...+ .*+,-??.*              .   .:.   +7:.-7.  .+,+??:..*:.+7. :. 7777+                   .,7+++7. -+,.-=7*.
    .=...*. :=:,++:.  .           .   .:. .. =+=.-*: .=*=**= .:-.**, ,..*****.                  .,:=*=*.,:*..***=.
    .....-. ,*-,===.              .   .:  .  ,== :-*. .,*,*+*. .-.** :  -****.                   ,:**:*.,:+..*+*:
    .. .... .:-:=== .             .   .:     .*: ,:*.  .*,--*,  -.-***  :****,                   .:---: ,:-..-**,
.   ..    .. ,--:-- .             .    ,     .-: .,-,.  -::--,..:,---:, .----:                   .:=:=. .::.,===.
       :-::. .::::- .             ..   .     .::  ,:-   .::--:, ,,,;:.  .---::                   .,:.: ..:,.::-:.
     ,..,,,.  ,::::                .   .     .,,  ,,:.  .:,:::,..,.:::. .:::::                   .,,,, ..,.,::::
        ,,,,  .,,,,                .   ..     .,  .,:,   ,,:,,,. ,.,,,.  .:,,,                    ..,.. ...,,:,,
    ,,...,,,   ,,,.                    .      .,. .,,,   .,,,,,. ,.,,,.. .,,,,                    .    .,,.,,,,.
     .,......  ...                     .      ...  ,,,   .,,,,,. ...,,,. .,,,,                          ...,.,,.
      ,......  ...                  .  ...     ..  .....  .................,.,.                           ...,.
      .......   .                        .     ... ....   ....... ....... .....                      ...........
      ... ....                          ..     ...  ...   ....... .............                        ........
       .......                          ...     ..  ...    ...... .............                       ........
        ......                          ...     ...  ...   ... ..  ............                         ......
        .....                           ....      .   .      ....  ............                        .... .
        .. ...                       .. . ..           ..       .   . .... .. ..                       ....
           . .                          . .       ..   ...   ...      ... ....                          .  .
           .                              .       ..          .       .  .   ..
             .                           .                    . .    ..    . .                             .
]],
  [[
 __________________________________________
/ “How rare it is that maintaining someone \
|  else’s code is akin to entering a beaut |
| ifully designed building, which you admi |
| re as you walk around and plan how to ad |
| d a wing or do some redecorating. More o |
| ften, maintaining someone else’s code is |
|  like being thrown headlong into a big p |
| ile of slimy, smelly garbage.”— Bill Ven |
\ ners                                     /
 ------------------------------------------
   \                     .___________.
    \                    |           |
     \    ___________.   |  |    /~\ |
         / __   __  /|   | _ _   |_| |
        / /:/  /:/ / |   !________|__!
       / /:/  /:/ /  |            |
      / /:/  /:/ /   |____________!
     / /:/  /:/ /    |
    / /:/  /:/ /     |
   /  ~~   ~~ /      |
   |~~~~~~~~~~|      |
   |    ::    |     /
   |    ==    |    /
   |    ::    |   /
   |    ::    |  /
   |    ::  @ | /
   !__________!/
]],
  [[
 __________________________________________
/ “Code generation, like drinking alcohol, \
\  is good in moderation.”— Alex Lowe      /
 ------------------------------------------
  \
(╯°□°）╯︵ ┻━┻
]],
  [[
 __________________________________________
/ “Simplicity, carried to the extreme, bec \
\ omes elegance.”— Jon Franklin            /
 ------------------------------------------
   \
    \
         _____
       .\'/L|__`.
      / =[_]O|` \
      |\"+_____\":|
    __:='|____`-:__
   ||[] ||====| []||
   ||[] | |=| | []||
   |:||_|=|U| |_||:|
   |:|||]_=_ =[_||:| LS
   | |||] [_][]C|| |
   | ||-\'\"\"\"\"\"`-|| |
   /|\\_\_|_|_/_//|\
  |___|   /|\   |___|
  `---\'  |___|  `---\'
         `---'
]],
  [[
 __________________________________________
/ “A program is never less than 90% comple \
| te, and never more than 95% complete.”—  |
\ Terry Baker                              /
 ------------------------------------------
  \
   \
      ,.,,､,..,､､.,､,､､.,_          ／i
    ;'`;、､:、..:、:,:,.::｀'::ﾞ":,'´ --i
    '､;:..: ,:.､.:',.:.::_.;..;:.‐'ﾞ

]],
  [[
 __________________________________________
/ “When you are stuck in a traffic jam wit \
| h a Porsche, all you do is burn more gas |
|  in idle.  Scalability is about building |
|  wider roads, not about building faster  |
\ cars.”— Steve Swartz                     /
 ------------------------------------------
   \         ,        ,
    \       /(        )`
     \      \ \___   / |
            /- _  `-/  '
           (/\/ \ \   /\
           / /   | `    \
           o o   ) /    |
           `-^--'`<     '
          (_.)  _  )   /
           `.___/`    /
             `-----' /
<----.     __ / __   \
<----|====O)))==) \) /====
<----'    `--' `.__,' \
             |        |
              \       /
        ______( (_  / \______
      ,'  ,-----'   |        \
      `--{__________)        \/
]],
  [[
 __________________________________________
/ “Everyone by now presumably knows about  \
| the danger of premature optimization.  I |
|  think we should be just as worried abou |
| t premature design — designing too early |
\  what a program should do.”— Paul Graham /
 ------------------------------------------
   \
    \

      (\(\/
  .-._)oo  '_
  \'---.     .\'\
       )    \.-\'\
      /__ ;     (
      |__ : /'._/
       \_  (
       .,)  )
       \'-.-\'

]],
  [[
 __________________________________________
/ “Programming without an overall architec \
| ture or design in mind is like exploring |
|  a cave with only a flashlight: You don’ |
| t know where you’ve been, you don’t know |
|  where you’re going, and you don’t know  |
\ quite where you are.”— Danny Thorpe      /
 ------------------------------------------
 \
  \          , ----.
   \        -  -     `
      ,__.,'           \
    .'                 *`
   /       o   o     / **\
  .                 / ****.
  |    mm           | ****|
   \                | ****|
    ` ._______      \ ****/
              \      /`---'
               \___(
               /~~~~\
              /      \
             /      | \
            |       |  \
  , ~~ .    |, ~~ . |  |\
 ( |||| )   ( |||| )(,,,)`
( |||||| )-( |||||| )    | ^
( |||||| ) ( |||||| )    |'/
( |||||| )-( |||||| )___,'-
 ( |||| )   ( |||| )
  ` ~~ '     ` ~~ '
]],
  [[
 __________________________________________
/ “The best way to predict the future is t \
| o implement it.”— David Heinemeier Hanss |
\ on                                       /
 ------------------------------------------
   \                     .___________.
    \                    |           |
     \    ___________.   |  |    /~\ |
         / __   __  /|   | _ _   |_| |
        / /:/  /:/ / |   !________|__!
       / /:/  /:/ /  |            |
      / /:/  /:/ /   |____________!
     / /:/  /:/ /    |
    / /:/  /:/ /     |
   /  ~~   ~~ /      |
   |~~~~~~~~~~|      |
   |    ::    |     /
   |    ==    |    /
   |    ::    |   /
   |    ::    |  /
   |    ::  @ | /
   !__________!/
]],
  [[
 __________________________________________
/ “We need above all to know about changes \
| ; no one wants or needs to be reminded 1 |
| 6 hours a day that his shoes are on.”— D |
\ avid Hubel                               /
 ------------------------------------------
        \    ,-^-.
         \   !oYo!
          \ /./=\.\______
               ##        )\/\
                ||-----w||
                ||      ||

               Cowth Vader
]],
  [[
 __________________________________________
/ “On two occasions I have been asked, ‘If \
|  you put into the machine wrong figures, |
|  will the right answers come out?’  I am |
|  not able rightly to apprehend the kind  |
| of confusion of ideas that could provoke |
\  such a question.”— Charles Babbage      /
 ------------------------------------------
  \
   \
    \

           ____
       ,: .: .: :.ヽ
     ,'       /\   ｉ
     {: .:ﾉﾚﾍ/  Viﾍ:}
    .{,､〈 Ｏ   Ｏ{.:.
    ノヽ\!"       }.:ﾊ
      Ｗﾊw=-､へ,ｬ<,V'
         /ﾍ }{./\
        ;: i:V:!;}
        |:｜: :｜}
        |:|:｡: ｡l}
        >-'-ﾟ-'`ﾟu
        ｰi-i～i-i~
         |.|  |.|
         |-|  |-|
         ヒｺ  ヒｺ
]],
  [[
 __________________________________________
/ “Make everything as simple as possible,  \
\ but not simpler.”— Albert Einstein       /
 ------------------------------------------
  \
   \
                     _____
                   .\'* *.\'
               ___/_*_(_
              / _______ \
             _\_)/___\(_/_
            / _((\- -/))_ \
            \ \())(-)(()/ /
             ' \(((()))/ \'
            / \' \)).))\ \' \
           / _ \ - | - /_  \
          (   ( .;\'\'\';. .\'  )
          _\\"__ /    )\ __\"/_
            \/  \   \' /  \/
             .\'  \'...\' \'  )
              / /  |   \  \
             / .   .    .  \
            /   .      .    \
           /   /   |    \    \
         .\'   /    b     \'.   \'.
     _.-\'    /     Bb      \'-.  \'-_
 _.-\'       |      BBb        \'-.  \'-.
(________mrf\____.dBBBb._________)____)
]],
  [[
 __________________________________________
/ “Today, most software exists, not to sol \
| ve a problem, but to interface with othe |
\ r software.”— IO Angell                  /
 ------------------------------------------
   \
    \

           _                _
          / /.           _-//
         / ///         _-   /
        //_-//=========     /
      _///        //_ ||   ./
    _|                 -__-||
   |  __              - \   \
  |  |#-       _-|_           |
  |            |#|||       _   |
 |  _==_                       ||
- ==|.=.=|_ =                  |
|  |-|-  ___                  |
|    --__   _                /
||     ===                  |
 |                     _. //
  ||_         __-   _-  _|
     \_______/  ___/  _|
                   --*
]],
  [[
 __________________________________________
/ “Good specifications will always improve \
|  programmer productivity far better than |
|  any programming tool or technique.”— Mi |
\ lt Bryce                                 /
 ------------------------------------------
            . .: -----  .
         ／: .: .: .:.: .:＼
        /    ..  . l.: .: .:ヽ
       : .: ,/|-/|:ハ.:|-.ｌ.:
       |: :ノ |/.|/  ヽ|.Vﾊ.:|
       |.::|  =＝     ＝= }.:|
       |.γ|| ''  ＿_   ''{::ﾊ
       ﾉノﾊﾘ   ｛   }     ﾉV
       ∨Vvヽ､._  --'_ .イV
            γ:/:{.又 }ﾍヽ
          ／:〉:V ﾊ.ﾘ〈: ＼
        ／ : Vヽ:V// /:V ::＼
    rイ: : ／|: :＼Vノ: :|ヽ: ヽ-､
   ｢  ヽ:／  |: o :  o:|   ＼:/ 」
    ー'    ./: : : : : ﾊ      ー'
          ./::o: : : :o ﾊ
          /ヽ: : :Λ: : :ﾉ:、
        〈:::￣￣:::￣:::::〉
          ＼:__:::::::__:／
            |  Τ￣Τ |
            |  |   |  |
            |''|   |''|
]],
  [[
 __________________________________________
/ “The difference between theory and pract \
| ice is that in theory, there is no diffe |
| rence between theory and practice.”— Ric |
\ hard Moore                               /
 ------------------------------------------
  \
   \
      /  \~~~/  \
     (    ..     )----,
      \__     __/      \
        )|  /)         |\
         | /\  /___\   / ^
          "-|__|   |__|
]],
  [[
 __________________________________________
/ “Don’t document the problem, fix it.”— A \
\ tli Björgvin Oddsson                     /
 ------------------------------------------
    \
     \
                                   .::!!!!!!!:.
  .!!!!!:.                        .:!!!!!!!!!!!!
  ~~~~!!!!!!.                 .:!!!!!!!!!UWWW$$$
      :$$NWX!!:           .:!!!!!!XUWW$$$$$$$$$P
      $$$$$##WX!:      .<!!!!UW$$$$"  $$$$$$$$#
      $$$$$  $$$UX   :!!UW$$$$$$$$$   4$$$$$*
      ^$$$B  $$$$\     $$$$$$$$$$$$   d$$R"
        "*$bd$$$$      '*$$$$$$$$$$$o+#"
             """"          """""""
]],
  [[
 __________________________________________
/ “As a rule, software systems do not work \
|  well until they have been used, and hav |
| e failed repeatedly, in real application |
\ s.”— Dave Parnas                         /
 ------------------------------------------
       \
        \
         \        .:  ￣￣￣￣:.丶､
               ／.: .: .: .: .: .: ＼
              /    ／|    /\.:| .: :.
             / .:|乂 |/{:/ _乂/\ .:.:|
           ノ.:\/ｨ庁ﾐ` \/ｨ庁ﾐx  \/:.:|
             |:}{弋.ﾉ    弋ノ } /.:.:|
             ﾚ:ﾘ''          '' ｜:ハ:＼
             {人       ,、    ,｜/ノ:厂
]],
  [[
 __________________________________________
/ “If the code and the comments do not mat \
| ch, possibly both are incorrect.”— Norm  |
\ Schryer                                  /
 ------------------------------------------
  \            .    .     .
   \      .  . .     `  ,
    \    .; .  : .' :  :  : .
     \   i..`: i` i.i.,i  i .
      \   `,--.|i |i|ii|ii|i:
           UooU\.'@@@@@@`.||'
           \__/(@@@@@@@@@@)'
                (@@@@@@@@)
                `YY~~~~YY'
                 ||    ||
]],
  [[
 __________________________________________
/ “I think it’s a new feature.  Don’t tell \
\  anyone it was an accident.”— Larry Wall /
 ------------------------------------------
     \
      \
                  ,
         ___     /^\   ,
        `\  \'...`   \_/^\
          ) ~     ',    /__,
         /       ,.    ,, /___,
        (  .-.   \'.\'. /// ___/
         ) .-.\'  .`.`///-.\'.
        / ( o )  .\"\". ====) \
       (   \'-`   \  |\'~~~`  u\,
        \ _~  .\"\"\"` |~|^u^ u^(\"\"
        //  ."     /~/^ u^ u^\
       // ."      /~  u^ u  ^u\      _
      // ."      /~/U^ U^ U^ ^(     / )
     /` ."       |~  U^ U^ ^ U^\   /) _)
   ./` ."        |~|^ U^ ^U ^ U(  / _  _)
  ;.`."          |~ ^U ^ U^ U ^/ /)_ =  _)
   \"\"            |~|^ ^U ^ ^ U(_/_    )- _)
                 |~ U ^ ^U ^U ^ )   =    _)
                 \~|^ U U^ U ^ =  ~ )  - _)
                  \ U ^U ^ ^U^_)     =  _)
                   \",^U^ ^U ^/ \)_~   -_)
                     \".u^u ^|   \_  = _)
                      ).u ^u|    \)  _)
                      \u ^u^(     \__)
                       )^u ^u\
                       \u ^u ^|
             ____       )^u ^u|
          ,-`    '-.    )u ^u^|
         /  .---. ' \  / ^ u^/
        |  ;  `  '  | /u^u ^/
        |  ;  '-` . `:u^u^u/
        \.\'^\'._   _.`u ^.-`
         \_.~=_```-.^.-\"
           \'\"------\"`

]],
  [[
 __________________________________________
/ “If you don’t handle [exceptions], we sh \
| ut your application down.  That dramatic |
| ally increases the reliability of the sy |
\ stem.”— Anders Hejlsberg                 /
 ------------------------------------------
   \
    \
              ___
      D>=G==='   '.
            |======|
            |======|
        )--/]IIIIII]
           |_______|
           C O O O D
          C O  O  O D
         C  O  O  O  D
         C__O__O__O__D
snd     [_____________]
]],
  [[
 __________________________________________
/ “When debugging, novices insert correcti \
| ve code; experts remove defective code.” |
\ — Richard Pattis                         /
 ------------------------------------------
  \
   \
      /  \~~~/  \
     (    ..     )----,
      \__     __/      \
        )|  /)         |\
         | /\  /___\   / ^
          "-|__|   |__|
]],
  [[
 __________________________________________
/ “In a software project team of 10, there \
|  are probably 3 people who produce enoug |
| h defects to make them net negative prod |
\ ucers.”— Gordon Schulmeyer               /
 ------------------------------------------
   \
    \

             _ - ￣ - _
           _-_＿＿＿＿_- _
         ￣ｌ  ●   ●  l￣
            ヽ､_ ⌒ _ノ
         _ -‐ニ ￣ ニ‐- _
  /⌒ ‐ﾆ‐ ￣   /    \ ￣ ‐ﾆ‐⌒ヽ
 ヽ､_ノ       └-ｕ‐┘      ヽ､_ノ
]],
  [[
 __________________________________________
/ “I think it is inevitable that people pr \
| ogram poorly.  Training will not substan |
| tially help matters.  We have to learn t |
\ o live with it.”— Alan Perlis            /
 ------------------------------------------
        \
         \
          )__(
         '|oo|'________/
          |__|         |
             ||"""""""||
             ||       ||

]],
  [[
 __________________________________________
/ “Program testing can be a very effective \
|  way to show the presence of bugs, but i |
| s hopelessly inadequate for showing thei |
\ r absence.”— Edsger Dijkstra             /
 ------------------------------------------
    \
     \
      \
                                                                                 -/-
                                                                              -/ --/
                                                                            /- -  /
                                                                         //      /
                                                                        /       /
                                                                      //       /
                                                                    //        /
                                                                  //          /
                                                                ///           /
                                                               //            /
                                                              //            /
                                                             //          . ./
                                                             //       .    /
                                                             //    .      /
                                                             //  .       /
                                                            // .         /
                                                          (=>            /
                                                         (==>            /
                                                          (=>            /
             -_                                           //.           /
             \\-_                                        //   .         /
              \ \_-_                                     //     .       /
               \_ \_--_                                 //        . . . /
                 \_ \_ -_                              //              /
                   \_ \_ (O)-___                      //               /
                     \ _\   __  --__                  /                /
                     _/    \  ----__--____          //                 /
                   _/  _/   \       -------       //                  /
                 _/ __/ \\   \\                  /                   /
               _/ _/      \\   \\              //                   /
              -__/          \\   \\\          //                   /
                              \\    \\\\\\\\\//   -                /
                                \\         _/         -            /
                                  \\                      -        \
                                    \\\                       -     \
                                        \\                       -   \
                                          \\\                         \--__
                                           | \\                            \__________
                                            |  \\\\                ___      _________-\\
                                            |    \\\\\                \--__/____
                                            |        \\\\________---\-    ______-----
                                             |                   /    \--  \_______
                                             |                   /       \-_________\
                                             \                   /                  \\
                                             \                 ./
                                             \            .     /
                                              \        .       /
                                              \    .           //
                                              \                /
                                              |__              /
                                              \==              /
                                               \\              \
                                                \\  .          \
                                                  \\    .  .   \
                                                   \           .\
                                                   \\            \
                                                     \           \
                                                      \\          \
                                                        \\         \
                                                          \         \--
                                                           \\          \
                                                             \\         \\\\
                                                               \\\\_________\\\
]],
  [[
 __________________________________________
/ “Manually managing blocks of memory in C \
|  is like juggling bars of soap in a pris |
| on shower: It’s all fun and games until  |
| you forget about one of them.”— anonymou |
\ s Usenet user                            /
 ------------------------------------------
  \            .    .     .
   \      .  . .     `  ,
    \    .; .  : .' :  :  : .
     \   i..`: i` i.i.,i  i .
      \   `,--.|i |i|ii|ii|i:
           UooU\.'@@@@@@`.||'
           \__/(@@@@@@@@@@)'
                (@@@@@@@@)
                `YY~~~~YY'
                 ||    ||
]],
  [[
 __________________________________________
/ “There’s no obfuscated Perl contest beca \
\ use it’s pointless.”— Jeff Polk          /
 ------------------------------------------
  \
   \       ___
      oo  // \\
     (_,\/ \_/ \
       \ \_/_\_/>
       /_/   \_\
]],
  [[
 __________________________________________
/ “Java is the most distressing thing to h \
\ it computing since MS-DOS.”— Alan Kay    /
 ------------------------------------------
   \
    \
     \                 ____
                 .: :<::. ::.>: :.
               ／:: ::. :. ::. ::`:、
               `::. ::.ィ:.i::.、::.ヽ
             /'      ./|..ﾄ.}V.. .. ﾊ
            '.. .. ./L/｜:| 一V::. ::１
            i::. ::/}/` V:| V Vﾄ::. ::i
            |::. :/Y芋ミV!Y 芋ミ|::. .|
            ,::. ハ {::}  V {::}}:r,:代
            /::. :}  つﾉ    つﾉ｜:レ:}ゝ  ヽ
              V::八    r一 ┐   ｨ!::.:ﾘ      }
       ｛r     ＼ﾊ:＞- .一-'.s<:ハ}ヽ}   __ノ ﾉ
        弋二一   ヽ:{＞}_ノ  / ゝ､
                ｡＜   〈ﾊ〉  {    `、
              ／     i       `､.    `、
            ／    フ^|   　   ',ﾞ、   `、
           く   ／   |         ', ﾞ、y ヽ
           tゝ_r     r          ',  ><一'
                    /  ゞ＿      '
                   /      一      `
]],
  [[
 __________________________________________
/ “There are only two things wrong with C+ \
| +:  The initial concept and the implemen |
\ tation.”— Bertrand Meyer                 /
 ------------------------------------------
  \
   \
        ____________
       /\  ________ \
      /  \ \______/\ \
     / /\ \ \  / /\ \ \
    / / /\ \ \/ / /\ \ \
   / / /__\ \ \/_/__\_\ \__________
  / /_/____\ \__________  ________ \
  \ \ \____/ / ________/\ \______/\ \
   \ \ \  / / /\ \  / /\ \ \  / /\ \ \
    \ \ \/ / /\ \ \/ / /\ \ \/ / /\ \ \
     \ \/ / /__\_\/ / /__\ \ \/_/__\_\ \
      \  /_/______\/_/____\ \___________\
      /  \ \______/\ \____/ / ________  /
     / /\ \ \  / /\ \ \  / / /\ \  / / /
    / / /\ \ \/ / /\ \ \/ / /\ \ \/ / /
   / / /__\ \ \/_/__\_\/ / /__\_\/ / /
  / /_/____\ \_________\/ /______\/ /
  \ \ \____/ / ________  __________/
   \ \ \  / / /\ \  / / /
    \ \ \/ / /\ \ \/ / /
     \ \/ / /__\_\/ / /
      \  / /______\/ /
       \/___________/
]],
  [[
 __________________________________________
/ “It was a joke, okay?  If we thought it  \
| would actually be used, we wouldn’t have |
|  written it!”— Mark Andreesen, speaking  |
\ of the HTML tag BLINK                    /
 ------------------------------------------
  \
   \
        ____________
       /\  ________ \
      /  \ \______/\ \
     / /\ \ \  / /\ \ \
    / / /\ \ \/ / /\ \ \
   / / /__\ \ \/_/__\_\ \__________
  / /_/____\ \__________  ________ \
  \ \ \____/ / ________/\ \______/\ \
   \ \ \  / / /\ \  / /\ \ \  / /\ \ \
    \ \ \/ / /\ \ \/ / /\ \ \/ / /\ \ \
     \ \/ / /__\_\/ / /__\ \ \/_/__\_\ \
      \  /_/______\/_/____\ \___________\
      /  \ \______/\ \____/ / ________  /
     / /\ \ \  / /\ \ \  / / /\ \  / / /
    / / /\ \ \/ / /\ \ \/ / /\ \ \/ / /
   / / /__\ \ \/_/__\_\/ / /__\_\/ / /
  / /_/____\ \_________\/ /______\/ /
  \ \ \____/ / ________  __________/
   \ \ \  / / /\ \  / / /
    \ \ \/ / /\ \ \/ / /
     \ \/ / /__\_\/ / /
      \  / /______\/ /
       \/___________/
]],
  [[
 __________________________________________
/ “Web Services are like teenage sex.  Eve \
| ryone is talking about doing it, and tho |
| se who are actually doing it are doing i |
\ t badly.”— Michelle Bustamante           /
 ------------------------------------------
  \                                  ,+*^^*+___+++_
   \                           ,*^^^^              )
    \                       _+*                     ^**+_
     \                    +^       _ _++*+_+++_,         )
              _+^^*+_    (     ,+*^ ^          \+_        )
             {       )  (    ,(    ,_+--+--,      ^)      ^\
            { (@)    } f   ,(  ,+-^ __*_*_  ^^\_   ^\       )
           {:;-/    (_+*-+^^^^^+*+*<_ _++_)_    )    )      /
          ( /  (    (        ,___    ^*+_+* )   <    <      \
           U _/     )    *--<  ) ^\-----++__)   )    )       )
            (      )  _(^)^^))  )  )\^^^^^))^*+/    /       /
          (      /  (_))_^)) )  )  ))^^^^^))^^^)__/     +^^
         (     ,/    (^))^))  )  ) ))^^^^^^^))^^)       _)
          *+__+*       (_))^)  ) ) ))^^^^^^))^^^^^)____*^
          \             \_)^)_)) ))^^^^^^^^^^))^^^^)
           (_             ^\__^^^^^^^^^^^^))^^^^^^^)
             ^\___            ^\__^^^^^^))^^^^^^^^)\\
                  ^^^^^\uuu/^^\uuu/^^^^\^\^\^\^\^\^\^\
                     ___) >____) >___   ^\_\_\_\_\_\_\)
                    ^^^//\\_^^//\\_^       ^(\_\_\_\)
                      ^^^ ^^ ^^^ ^
]],
  [[
 __________________________________________
/ “Perl: The only language that looks the  \
| same before and after RSA encryption.”—  |
\ Keith Bostic                             /
 ------------------------------------------
    \
     \
      \
                                                                                 -/-
                                                                              -/ --/
                                                                            /- -  /
                                                                         //      /
                                                                        /       /
                                                                      //       /
                                                                    //        /
                                                                  //          /
                                                                ///           /
                                                               //            /
                                                              //            /
                                                             //          . ./
                                                             //       .    /
                                                             //    .      /
                                                             //  .       /
                                                            // .         /
                                                          (=>            /
                                                         (==>            /
                                                          (=>            /
             -_                                           //.           /
             \\-_                                        //   .         /
              \ \_-_                                     //     .       /
               \_ \_--_                                 //        . . . /
                 \_ \_ -_                              //              /
                   \_ \_ (O)-___                      //               /
                     \ _\   __  --__                  /                /
                     _/    \  ----__--____          //                 /
                   _/  _/   \       -------       //                  /
                 _/ __/ \\   \\                  /                   /
               _/ _/      \\   \\              //                   /
              -__/          \\   \\\          //                   /
                              \\    \\\\\\\\\//   -                /
                                \\         _/         -            /
                                  \\                      -        \
                                    \\\                       -     \
                                        \\                       -   \
                                          \\\                         \--__
                                           | \\                            \__________
                                            |  \\\\                ___      _________-\\
                                            |    \\\\\                \--__/____
                                            |        \\\\________---\-    ______-----
                                             |                   /    \--  \_______
                                             |                   /       \-_________\
                                             \                   /                  \\
                                             \                 ./
                                             \            .     /
                                              \        .       /
                                              \    .           //
                                              \                /
                                              |__              /
                                              \==              /
                                               \\              \
                                                \\  .          \
                                                  \\    .  .   \
                                                   \           .\
                                                   \\            \
                                                     \           \
                                                      \\          \
                                                        \\         \
                                                          \         \--
                                                           \\          \
                                                             \\         \\\\
                                                               \\\\_________\\\
]],
  [[
 __________________________________________
/ “I didn’t work hard to make Ruby perfect \
|  for everyone, because you feel differen |
| tly from me.  No language can be perfect |
|  for everyone.  I tried to make Ruby per |
| fect for me, but maybe it’s not perfect  |
| for you.  The perfect language for Guido |
|  van Rossum is probably Python.”— Yukihi |
| ro Matsumoto, aka “Matz”, creator of Rub |
\ y                                        /
 ------------------------------------------
  \
   \   --木--
       ／｜＼
     ／  ｜  ＼
  --木-- ｜ --木--
  ／｜＼    ／｜＼
／  ｜　＼／  ｜  ＼
    ｜        ｜
]],
  [[
 __________________________________________
/ “XML is not a language in the sense of a \
|  programming language any more than sket |
| ches on a napkin are a language.”— Charl |
\ es Simonyi                               /
 ------------------------------------------
       \   \_______
 v__v   \  \   O   )
 (oo)      ||----w |
 (__)      ||     ||  \/\

]],
  [[
 __________________________________________
/ “BASIC is to computer programming as QWE \
\ RTY is to typing.”— Seymour Papert       /
 ------------------------------------------
       \
        \
         \
          \
          |\___/|
         =) oYo (=
          \  ^  /
           )=*=(
          /     \
          |     |
         /| | | |\
         \| | |_|/\
         //_// ___/
             \_)
]],
  [[
 __________________________________________
/ “It has been discovered that C++ provide \
| s a remarkable facility for concealing t |
| he trivial details of a program — such a |
\ s where its bugs are.”— David Keppel     /
 ------------------------------------------
  \
   \
       \#+ @      \# \#              M#@
 .    .X  X.%##@;# \#   +@#######X. @#%
   ,==.   ,######M+  -#####%M####M-    \#
  :H##M%:=##+ .M##M,;#####/+#######% ,M#
 .M########=  =@#@.=#####M=M#######=  X#
 :@@MMM##M.  -##M.,#######M#######. =  M
             @##..###:.    .H####. @@ X,
   \############: \###,/####;  /##= @#. M
           ,M## ;##,@#M;/M#M  @# X#% X#
.%=   \######M## \##.M#:   ./#M ,M \#M ,#$
\##/         $## \#+;#: \#### ;#/ M M- @# :
\#+ \#M@MM###M-;M \#:$#-##$H# .#X @ + $#. \#
      \######/.: \#%=# M#:MM./#.-#  @#: H#
+,.=   @###: /@ %#,@  \##@X \#,-#@.##% .@#
\#####+;/##/ @##  @#,+       /#M    . X,
   ;###M#@ M###H .#M-     ,##M  ;@@; \###
   .M#M##H ;####X ,@#######M/ -M###$  -H
    .M###%  X####H  .@@MM@;  ;@#M@
      H#M    /@####/      ,++.  / ==-,
               ,=/:, .+X@MMH@#H  \#####$=
]],
  [[
 __________________________________________
/ “UNIX is simple.  It just takes a genius \
|  to understand its simplicity.”— Dennis  |
\ Ritchie                                  /
 ------------------------------------------
    \
     \
      \
                    ___
                _.-'   ```'--.._
              .'                `-._
             /                      `.
            /                         `.
           /                            `.
          :       (                       \
          |    (   \_                  )   `.
          |     \__/ '.               /  )  ;
          |   (___:    \            _/__/   ;
          :       | _  ;          .'   |__) :
           :      |` \ |         /     /   /
            \     |_  ;|        /`\   /   /
             \    ; ) :|       ;_  ; /   /
              \_  .-''-.       | ) :/   /
             .-         `      .--.'   /
            :         _.----._     `  <
            :       -'........'-       `.
             `.        `''''`           ;
               `'-.__                  ,'
                     ``--.   :'-------'
                         :   :
                        .'   '.
]],
  [[
 __________________________________________
/ “Some people, when confronted with a pro \
| blem, think ‘I know, I’ll use regular ex |
| pressions.’  Now they have two problems. |
\ ”— Jamie Zawinski                        /
 ------------------------------------------
  \
   \
    \            ________
             .:          :｀丶
           /.:   ｛ :｜､  .: .:＼
          /   |.: /\.:|ﾉ＼.} .: :.
         .: .:/\乂  ＼ｨ=ミV.:}.: |
         |.:\/ ｨ=ﾐ    ﾋソ｝V:|.:｜
         |.:ﾊ{ ﾋソ '    ''｜:|ヽ｜
         |.: ﾊ''          ｜:ﾉノ:＼
        丿.:|人    ⌒ヽ    ｲ::\/ ￣
    /^^ﾍ  \/Vv:＞=rr::rr＜vV\/
  ｛   ﾉ    ノ   \/ヌ\／ ＼
    ＼  ＼,く  }   |:|   V ＼
      ＼     >ィ   |:|   ｝  ﾉ
        ＼／  ﾉ    |:|   }-く ＼
             /      V     \  ＼  ＼
]],
  [[
 __________________________________________
/ “I think computer viruses should count a \
| s life.  I think it says something about |
|  human nature that the only form of life |
|  we have created so far is purely destru |
| ctive.  We’ve created life in our own im |
\ age.”— Stephen Hawking                   /
 ------------------------------------------
                          \
                           \         __.----.___
           ||            ||  (\(__)/)-'||      ;--` ||
          _||____________||___`(oo)'___||______;____||_
          -||------------||----)  (----||-----------||-
          _||____________||___(o  o)___||______;____||_
          -||------------||----`--'----||-----------||-
           ||            ||        `|| ||| || ||     ||jgs
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
]],
  [[
 __________________________________________
/ “The only truly secure system is one tha \
| t is powered off, cast in a block of con |
| crete and sealed in a lead-lined room wi |
\ th armed guards.”— Gene Spafford         /
 ------------------------------------------
        \    ,-^-.
         \   !oYo!
          \ /./=\.\______
               ##        )\/\
                ||-----w||
                ||      ||

               Cowth Vader
]],
  [[
 __________________________________________
/ “Being able to break security doesn’t ma \
| ke you a hacker anymore than being able  |
| to hotwire cars makes you an automotive  |
\ engineer.”— Eric Raymond                 /
 ------------------------------------------
   \
    \
                      ,:二二二二:. .,
                   ／.／＿＿＿_  ＼.:＼
                  /. /／.: .: .:＼  : .:＼
                 /.: .: .:/｜:/\ .:＼}.: .:.
                .: |.:/一/ |:/ 一.:}: .: .:｜
                |.:|ノ |/_｜/ _  \/ﾍ: .: .:|
                |.: ｜= ＝    ＝＝= \/}: .:|
                |:: ﾘ''           '' /:/､.:|
               ノ:|:人    一一 ､    /:/ ﾉ.:|
                , ┴＜＼  {     ｝ ,{:/イ::八
               /_..   ＼` ー┬一r＜:八八／
               ／  T＼   `＜}ゞ=彡'⌒＼＼_>
              /___ |  >､    ｀''＼   ｜
             /ﾆ}::\/／  ＼       ｜  ｜
          　{ﾆﾉ:: /''＼ | `|r--ｯ＜|_／|
           /__   V    ｝|  》=《      |
           ＼ ＼/｀一ﾍノ|  { 6 }     ｛
             ￣        ｢   ゞ= '      }
                      ﾉ               〉
]],
  [[
 __________________________________________
/ “Companies spend millions of dollars on  \
| firewalls, encryption and secure access  |
| devices, and it’s money wasted, because  |
| none of these measures address the weake |
| st link in the security chain.”— Kevin M |
\ itnick                                   /
 ------------------------------------------
  \
     \
                  _ _
       | \__/|  .~    ~.
       /oo `./      .'
      {o__,   \    {
        / .  . )    \
        `-` '-' \    }
       .(   _(   )_.'
      '---.~_ _ _|

]],
  [[
 __________________________________________
/ “If you think technology can solve your  \
| security problems, then you don’t unders |
| tand the problems and you don’t understa |
\ nd the technology.”— Bruce Schneier      /
 ------------------------------------------
       \
        \
                   ,―ヾヽヽ/ｖへ／⌒ー
                , ⌒ヽ ヽ ヽ / ／ ノ  ⌒ヽ、
              / ／ヾ,ゞ -ゞゞゞ､_ ⌒  ノ ヽ
            ／  ／            `ヾ  ー   ミヽ
          ,/   /                   ヾ ＼  ヽﾐ
         /    /                      ゞ      ヽ
         i   /                       /      ＼
        /    -=ﾆヽ､,_  ,,,,;r;==-     ヾ  ヾミ ヽ
        | ;: `ゞﾂヽ〉^`ヾだ'=-､_        i    彡 ヽ
        i ,   /::::/     `'''"""        ﾉ  ゞ ヾ ヽ
        } ;  |    人､,;-,'^            /    くヾ  ）
        /    彡ノノノﾉﾉﾉ(((((        ／ﾍミ        /
       /     /ﾉﾉﾉﾉﾉ,.-―ミヽヾヾヾヾヾヾ     _ノ`ｰ'"
      ,i          -ー‐ `ゞ           ヽ   ヽ
      彡彡                        ミ       ヽ
''""￣彡      /   /   /   /            ミ   ﾂ＼
      ＜    /   /   /   /        ヾ   ヾ  ノﾉﾉ
        '―彡                         ｒー'"
            ヾノ人,,.r--､ノノノノノり'"
]],
  [[
 __________________________________________
/ “Hoaxes use weaknesses in human behavior \
|  to ensure they are replicated and distr |
| ibuted.  In other words, hoaxes prey on  |
| the Human Operating System.”— Stewart Ki |
\ rkpatrick                                /
 ------------------------------------------
  \
   \

     [-]
     (+)=C
     | |
     OOO
]],
  [[
 __________________________________________
/ “Passwords are like underwear: you don’t \
|  let people see it, you should change it |
|  very often, and you shouldn’t share it  |
\ with strangers.”— Chris Pirillo          /
 ------------------------------------------
  \
   \
      /  \~~~/  \
     (    ..     )----,
      \__     __/      \
        )|  /)         |\
         | /\  /___\   / ^
          "-|__|   |__|
]],
  [[
 __________________________________________
/ “I am not out to destroy Microsoft, that \
|  would be a completely unintended side e |
\ ffect.”— Linus Torvalds                  /
 ------------------------------------------
   \
    \
       ／ .: .: .: .: .: .: .:  .: .: . ＼
     ./   .: .: .: .: .: .: .:  .: .: .: .ヽ
     /          /  . ..l..  ヽ.: .: .: .: .:.
    ,    .. .: /  .| : ハ: .|  ＼.: .: .: .: .
    |.: .:.l.:/  ヽ|.:/  ､ .|.ノ ＼ .l:.: .: |
    |.: .:.|:/.ｨ≠ﾐ|:/    ＼| ィ≠ミ､|.:.: .:|
    |.: .: ノ /Y::::ヽ       Y::::ヽヽ＼ .: ｜
   /:.: /^|:|{.{:::::}       {:::::}.} |:|ヽ:､
 ノ:ノ: { |:| Ｕうーソ       うーソ  |:| }ヽ:＼
    | : ヽ|.|  '' ￣           ￣ ''U|:| /:|
     :: ::人|                        |人::ﾘ
     Vﾊ:: :: \                     /::  ﾊ/
      \|ヽ:: ::ヽ､     --      ,イ::／|／
          ＼| ヽ:≧=r-r---r-r=≦:ノ|／
             . :´:.ヽ二二.ノ: :｀: .
            ／: : :  ／ハ＼: : : : ＼
]],
  [[
 __________________________________________
/ “Yes, we have a dress code. You have to  \
| dress.”— Scott McNealy, co-founder of Su |
\ n Microsystems                           /
 ------------------------------------------
   \
    \

  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  | * * * * * * * * *  :::::::::::::::::::::::::|
  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  | * * * * * * * * *  :::::::::::::::::::::::::|
  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  | * * * * * * * * *  :::::::::::::::::::::::::|
  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  |:::::::::::::::::::::::::::::::::::::::::::::|
  |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|
  |:::::::::::::::::::::::::::::::::::::::::::::|
  |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|
  |:::::::::::::::::::::::::::::::::::::::::::::|
  |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|

]],
  [[
 __________________________________________
/ “In an information economy, the most val \
| uable company assets drive themselves ho |
| me every night.  If they are not treated |
|  well, they do not return the next morni |
\ ng.”— Peter Chang                        /
 ------------------------------------------
      \                    / \  //\
       \    |\___/|      /   \//  \\
            /o  o  \__  /    //  | \ \
           /     /  \/_/    //   |  \  \
           @_^_@'/   \/_   //    |   \   \
           //_^_/     \/_ //     |    \    \
        ( //) |        \///      |     \     \
      ( / /) _|_ /   )  //       |      \     _\
    ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
  (( / / )) ,-{        _      `-.|.-~-.           .~         `.
 (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
 (( /// ))      `.   {            }                   /      \  \
  (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
             ///.----..>        \             _ -~             `.  ^-`  ^-_
               ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
                                                                  /.-~
]],
  [[
 __________________________________________
/ “It’s better to wait for a productive pr \
| ogrammer to become available than it is  |
| to wait for the first available programm |
| er to become productive.”— Steve McConne |
\ ll                                       /
 ------------------------------------------
  \
   \
       \#+ @      \# \#              M#@
 .    .X  X.%##@;# \#   +@#######X. @#%
   ,==.   ,######M+  -#####%M####M-    \#
  :H##M%:=##+ .M##M,;#####/+#######% ,M#
 .M########=  =@#@.=#####M=M#######=  X#
 :@@MMM##M.  -##M.,#######M#######. =  M
             @##..###:.    .H####. @@ X,
   \############: \###,/####;  /##= @#. M
           ,M## ;##,@#M;/M#M  @# X#% X#
.%=   \######M## \##.M#:   ./#M ,M \#M ,#$
\##/         $## \#+;#: \#### ;#/ M M- @# :
\#+ \#M@MM###M-;M \#:$#-##$H# .#X @ + $#. \#
      \######/.: \#%=# M#:MM./#.-#  @#: H#
+,.=   @###: /@ %#,@  \##@X \#,-#@.##% .@#
\#####+;/##/ @##  @#,+       /#M    . X,
   ;###M#@ M###H .#M-     ,##M  ;@@; \###
   .M#M##H ;####X ,@#######M/ -M###$  -H
    .M###%  X####H  .@@MM@;  ;@#M@
      H#M    /@####/      ,++.  / ==-,
               ,=/:, .+X@MMH@#H  \#####$=
]],
  [[
 __________________________________________
/ “I’m not one of those who think Bill Gat \
| es is the devil.  I simply suspect that  |
| if Microsoft ever met up with the devil, |
|  it wouldn’t need an interpreter.”— Nich |
\ olas Petreley                            /
 ------------------------------------------
   \      {
    \  }   }   {
      {   {  }  }
       }   }{  {
      {  }{  }  }
     ( }{ }{  { )
    .-{   }   }-.
   ( ( } { } { } )
   |`-.._____..-'|
   |             ;--.
   |   (__)     (__  \
   |   (oo)      | )  )
   |    \/       |/  /
   |             /  /
   |            (  /
   \             y'
    `-.._____..-'
]],
  [[
 __________________________________________
/ “Two years from now, spam will be solved \
\ .”— Bill Gates, 2004                     /
 ------------------------------------------
  \
   \
    \
             ＿＿＿＿
       ＜ :: :: :: :: `丶､
       ／   _, ｨ:ﾊ ､＿: ::＼
     ∠:: :/ |/|/ \/  \/:: |
rヘn  /:\/ c=＝.::.＝=っ\/ |  rvへ
ヽ／＼i:｜   ┌──┐   i::|／＼ノ
  ＼::|(||   |:::::|    ||)|::／
    ＼|人|.、|:::::| .ｨ|ﾉ:八／
      ＼\/\/>|:::::|<\/\/／
        ＼ :::>TﾇT<::: ／
          Y : ＼W／ : Y
]],
  [[
 __________________________________________
/ “The problem of viruses is temporary and \
|  will be solved in two years.”— John McA |
\ fee, 1988                                /
 ------------------------------------------
  \
   \
        ____________
       /\  ________ \
      /  \ \______/\ \
     / /\ \ \  / /\ \ \
    / / /\ \ \/ / /\ \ \
   / / /__\ \ \/_/__\_\ \__________
  / /_/____\ \__________  ________ \
  \ \ \____/ / ________/\ \______/\ \
   \ \ \  / / /\ \  / /\ \ \  / /\ \ \
    \ \ \/ / /\ \ \/ / /\ \ \/ / /\ \ \
     \ \/ / /__\_\/ / /__\ \ \/_/__\_\ \
      \  /_/______\/_/____\ \___________\
      /  \ \______/\ \____/ / ________  /
     / /\ \ \  / /\ \ \  / / /\ \  / / /
    / / /\ \ \/ / /\ \ \/ / /\ \ \/ / /
   / / /__\ \ \/_/__\_\/ / /__\_\/ / /
  / /_/____\ \_________\/ /______\/ /
  \ \ \____/ / ________  __________/
   \ \ \  / / /\ \  / / /
    \ \ \/ / /\ \ \/ / /
     \ \/ / /__\_\/ / /
      \  / /______\/ /
       \/___________/
]],
  [[
 __________________________________________
/ “Computer viruses are an urban legend.”— \
\  Peter Norton, 1988                      /
 ------------------------------------------
          \
           \
            \          __---__
                    _-       /--______
               __--( /     \ )XXXXXXXXXXX\v.
             .-XXX(   o   o  )XXXXXXXXXXXXXXX-
            /XXX(       U     )        XXXXXXX\
          /XXXXX(              )--_  XXXXXXXXXXX\
         /XXXXX/ (      O     )   XXXXXX   \XXXXX\
         XXXXX/   /            XXXXXX   \__ \XXXXX
         XXXXXX__/          XXXXXX         \__---->
 ---___  XXX__/          XXXXXX      \__         /
   \-  --__/   ___/\  XXXXXX            /  ___--/=
    \-\    ___/    XXXXXX              '--- XXXXXX
       \-\/XXX\ XXXXXX                      /XXXXX
         \XXXXXXXXX   \                    /XXXXX/
          \XXXXXX      >                 _/XXXXX/
            \XXXXX--__/              __-- XXXX/
             -XXXXXXXX---------------  XXXXXX-
                \XXXXXXXXXXXXXXXXXXXXXXXXXX/
                  ""VXXXXXXXXXXXXXXXXXXV""
]],
  [[
 __________________________________________
/ “In 2031, lawyers will be commonly a par \
| t of most development teams.”— Grady Boo |
\ ch                                       /
 ------------------------------------------
   \
    \

  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  | * * * * * * * * *  :::::::::::::::::::::::::|
  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  | * * * * * * * * *  :::::::::::::::::::::::::|
  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  | * * * * * * * * *  :::::::::::::::::::::::::|
  |* * * * * * * * * * OOOOOOOOOOOOOOOOOOOOOOOOO|
  |:::::::::::::::::::::::::::::::::::::::::::::|
  |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|
  |:::::::::::::::::::::::::::::::::::::::::::::|
  |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|
  |:::::::::::::::::::::::::::::::::::::::::::::|
  |OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO|

]],
  [[
 __________________________________________
/ “I don’t know what the language of the y \
| ear 2000 will look like, but I know it w |
\ ill be called Fortran.”— CA Hoare, 1982  /
 ------------------------------------------
     \               _
      \            ´   ＼   __
       \        ／ ／⌒\ | ／   ＼
   f|{r、       | /     '|/ ／⌒＼＼
   ||J |        \/＞--＜\/ /--    |
(＼|`` し]ﾄ----／          ⌒` ＼| /
 ＼      ﾉ\   /                ＼|/\   --、___
  ゛    /  ＼/      /     |         \/_       ﾉ
   \、/\_／/ｲ    ,/'|    /\ 、        Ⅵ   __／
    [\/   \/_|   /\|/|   |-]  、     く-く
    |      \/|  |/___ﾉ\  /\___ \     /   ＼
    {/      <|小| _ﾒﾘ  \/  _ﾒﾘ` \   ｜|   |
     \        ｜| \/ｿ      \/ｿ  ﾉ / /\|＼_/
      \       ｜|              /_ｲ\/
       \      ｜|     /ヽ      / /ﾉ
        \     ｜/\   └-     ,/ /'
         \    ｜ |／>> r -=≦{{/ /ﾆ=_
          \   人 | ／ｨ|     /ﾚ/__   ﾉﾆ-、
           ＼   \|/  Xﾉ    / /   入//⌒Yﾊ
             \  /し ｜`---' //  /  \ﾆﾆﾆﾉ|
              ＼/  / \  --ｱ ｜  |   | _]|
               ｜ /   \/\/  ｜  |   |___|
               r勺    ｜_｜ ｜  |   |  ||
               |`7    ｜ ｜ ｜  |   |   |
]],
  [[
 __________________________________________
/ “In the future, computers may weigh no m \
| ore than 1.5 tonnes.”— Popular mechanics |
\ , 1949                                   /
 ------------------------------------------
\
 \
   /\   /\   Todd Vargo
  //\\_//\\     ____
  \_     _/    /   /
   / * * \    /^^^]
   \_\O/_/    [   ]
    /   \_    [   /
    \     \_  /  /
     [ [ /  \/ _/
    _[ [ \  /_/
]],
  [[
 __________________________________________
/ “I see little commercial potential for t \
| he Internet for at least ten years.”— Bi |
\ ll Gates, 1994                           /
 ------------------------------------------
  \
(╯°□°）╯︵ ┻━┻
]],
  [[
 __________________________________________
/ “Before man reaches the moon, mail will  \
| be delivered within hours from New York  |
| to California, to Britain, to India or A |
| ustralia.”— Arthur Summerfield, 1959, Un |
\ ited States Pos                          /
 ------------------------------------------
       \
        \
         \  _))
           > o\     _~
           `;'\\__-' \_
              | )  _ \ \
             / / ``   w w
            w w
]],
  [[
.____           __               .___
|    |    _____/  |_  ______   __| _/____
|    |  _/ __ \   __\/  ___/  / __ |/  _ \
|    |__\  ___/|  |  \___ \  / /_/ (  <_> )
|_______ \___  >__| /____  > \____ |\____/
        \/   \/          \/       \/
                                               .___.__
  __________   _____   ____     ____  ____   __| _/|__| ____    ____
 /  ___/  _ \ /     \_/ __ \  _/ ___\/  _ \ / __ | |  |/    \  / ___\
 \___ (  <_> )  Y Y  \  ___/  \  \__(  <_> ) /_/ | |  |   |  \/ /_/  >
/____  >____/|__|_|  /\___  >  \___  >____/\____ | |__|___|  /\___  / /\
     \/            \/     \/       \/           \/         \//_____/  )/
       .__           .__  .__                     _________
  _____|  |__ _____  |  | |  |   __  _  __ ____   \_____   \
 /  ___/  |  \\__  \ |  | |  |   \ \/ \/ // __ \     /   __/
 \___ \|   Y  \/ __ \|  |_|  |__  \     /\  ___/    |   |
/____  >___|  (____  /____/____/   \/\_/  \___  >   |___|
     \/     \/     \/                         \/    <___>
]],
  [[
 _          _             _
| |        | |           | |
| |     ___| |_ ___    __| | ___
| |    / _ \ __/ __|  / _` |/ _ \
| |___|  __/ |_\__ \ | (_| | (_) |
\_____/\___|\__|___/  \__,_|\___/


                                          _ _
                                         | (_)
 ___  ___  _ __ ___   ___    ___ ___   __| |_ _ __   __ _
/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \ / _` | | '_ \ / _` |
\__ \ (_) | | | | | |  __/ | (_| (_) | (_| | | | | | (_| |_
|___/\___/|_| |_| |_|\___|  \___\___/ \__,_|_|_| |_|\__, ( )
                                                     __/ |/
                                                    |___/
     _           _ _                  ___
    | |         | | |                |__ \
 ___| |__   __ _| | | __      _____     ) |
/ __| '_ \ / _` | | | \ \ /\ / / _ \   / /
\__ \ | | | (_| | | |  \ V  V /  __/  |_|
|___/_| |_|\__,_|_|_|   \_/\_/ \___|  (_)
]],
  [[
=================     ===============     ===============   ========  ========
\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //
||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||
|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||
||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||
|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||
||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||
|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||
||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||
||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||
||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||
||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||
||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||
||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||
||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||
||.=='    _-'                                                     `' |  /==.||
=='    _-'                        N E O V I M                         \/   `==
\   _-'                                                                `-_   /
 `''                                                                      ``'
]],
  [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
  [[
`       --._    `-._   `-.   `.     :   /  .'   .-'   _.-'    _.--'
`--.__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __.--'
   __    `--.__    `--._  `-._ `-. `. :/ .' .-' _.-'  _.--'    __.--'    __
    `--..__   `--.__   `--._ `-._`-.`_=_'.-'_.-' _.--'   __.--'   __..--'
  --..__   `--..__  `--.__  `--._`-q(-_-)p-'_.--'  __.--'  __..--'   __..--
        ``--..__  `--..__ `--.__ `-'_) (_`-' __.--' __..--'  __..--''
  ...___        ``--..__ `--..__`--/__/  --'__..--' __..--''        ___...
        ```---...___    ``--..__`_(<_   _/)_'__..--''    ___...---'''
   ```-----....._____```---...___(____|_/__)___...---'''_____.....-----'''
]],
  [[
          .                                                      .",
        .n                   .                 .                  n.",
  .   .dP                  dP                   9b                 9b.    .",
 4    qXb         .       dX                     Xb       .        dXp     t",
dX.    9Xb      .dXb    __                         __    dXb.     dXP     .Xb",
9XXb._       _.dXXXXb dXXXXbo.                 .odXXXXb dXXXXb._       _.dXXP",
 9XXXXXXXXXXXXXXXXXXXVXXXXXXXXOo.           .oOXXXXXXXXVXXXXXXXXXXXXXXXXXXXP",
  `9XXXXXXXXXXXXXXXXXXXXX'~   ~`OOO8b   d8OOO'~   ~`XXXXXXXXXXXXXXXXXXXXXP'",
    `9XXXXXXXXXXXP' `9XX'   DIE    `98v8P'  HUMAN   `XXP' `9XXXXXXXXXXXP'",
        ~~~~~~~       9X.          .db|db.          .XP       ~~~~~~~",
                        )b.  .dbo.dP'`v'`9b.odb.  .dX(",
                      ,dXXXXXXXXXXXb     dXXXXXXXXXXXb.",
                     dXXXXXXXXXXXP'   .   `9XXXXXXXXXXXb",
                    dXXXXXXXXXXXXb   d|b   dXXXXXXXXXXXXb",
                    9XXb'   `XXXXXb.dX|Xb.dXXXXX'   `dXXP",
                     `'      9XXXXXX(   )XXXXXXP      `'",
                              XXXX X.`v'.X XXXX",
                              XP^X'`b   d'`X^XX",
                              X. 9  `   '  P )X",
                              `b  `       '  d'",
                               `             '"
]],
}

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local length = util.t.len(headers)
    math.randomseed(os.time(os.date("!*t")))
    local index = math.random(length)
    local logo = headers[index]

    local marginTopPercent = 0.2
    local headerPadding = vim.fn.max({
      2,
      vim.fn.floor(vim.fn.winheight(0) * marginTopPercent),
    })
    local layout = {
      { type = "padding", val = headerPadding },
      {
        type = "text",
        val = vim.split(logo, "\n"),
        opts = { position = "center" },
      },
      { type = "text", val = "", opts = { position = "center" } },
    }
    require("alpha").setup({ layout = layout, opts = { noautocmd = true } })
    vim.keymap.set("n", "q", ":q<cr>", { buffer = 0 })

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        layout[3].val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
