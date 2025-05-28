# Editor Actions

| Keys | Action |
| --- | --- |
| `⌥click` | add or remove caret |
| `↑`, `^P` | up |
| `⇧↑` | up with selection |
| `⌥↑`, `⌥K` | extend selection |
| `^↑`, `^K` | move statement up |
| `^⇧↑`, `^⇧K` | previous method |
| `⌥⌘↑` | previous occurrence |
| `↓`, `^N` | down |
| `⇧↓` | down with selection |
| `⌥↓`, `⌥J` | shrink selection |
| `^↓`, `^J` | move statement down |
| `^⇧↓`, `^⇧J` | next method |
| `⌥⌘↓` | next occurrence |
| `←` | left |
| `⇧←` | left with selection |
| `⌥←`, `⌥H` | move caret to previous word |
| `⤒`, `⌘←` | move caret to line start |
| `⇧⌘←` | move caret to line start with selection |
| `⌘⤒` | move caret to text start |
| `^←`, `^H` | move element left |
| `→` | right |
| `⇧→` | right with selection |
| `⌥→`, `⌥L` | move caret to next word |
| `⤓`, `⌘→` | move caret to line end |
| `⇧⤓`, `⇧⌘→` | move caret to line end with selection |
| `⌘⤓` | move caret to text end |
| `^→`, `^L` | move element right |
| `⇟` | page down |
| `⌘⇟` | move caret to page bottom |
| `⇞` | page up |
| `⌘⇞` | move caret to page top |
| `⌘↓` | jump to source |
| `⌘[`, `⌘↑` | back |
| `⌘]` | forward |
| `⌥M` | move caret to matching brace |
| `⌘M` | toggle sticky selection |
| `⌥␣` | basic code completion |
| `^␣` | type-matching |
| `⌥/` | cyclic expand word |
| `⌥⇧/` | cyclic expand word (backwards) |
| `⌥⇧\` | call inline completion |
| `⌘/` | comment with line comment |
| `⇧⌘/` | comment with block comment |
| `⌥⌘L` | reformat code |
| `↩` | enter |
| `⌘↩` | split line |
| `⇧↩` | start new line |
| `^↩` | start new line before current |
| `⇧⌘↩` | complete current statement |
| `⇥` | tab |
| `⇧⇥` | unindent line or selection |
| `⎋` | escape |
| `⎋` | focus editor |
| `⌫` | delete |
| `⌥⌫` | delete to word end |
| `⌦` | backspace |
| `⌥⌦` | delete to word start |
| `⌘D` | duplicate line or selection |
| `⌘N` | new |
| `⌘J` | insert live template |
| `⌘O` | search everywhere |
| `⌘P` | find action |
| `⌘L` | goto row |
| `⌘<backquote>` | activate next window |
| `⇧⌘<backquote>` | activate previous window |
| `⌥⌘↩`, `⌥Q` | show quick actions popup |
| `⌥↩`, `⌘G ⌘A` | show quick fixes |
| `⌥↩`, `⌘G ⌘A` | show context actions |
| `⌘G ⌘F` | show context menu |

# Main Menu

## File

| Keys | Action |
| --- | --- |
| `⌘,` | settings |
| `⌘Q` | exit |

## Edit

| Keys | Action |
| --- | --- |
| `⌘Z` | undo |
| `⇧⌘Z` | redo |

### Cut/Copy/Paste Actions

| Keys | Action |
| --- | --- |
| `⌘X` | cut |
| `⌘C` | copy |
| `⌘V` | paste |
| `⌥V ⌥V` | paste from history |
| `⌥V V` | paste as plain text |

### Find

| Keys | Action |
| --- | --- |
| `⌘F ⌘F` | find |
| `⌘F F` | find in files |
| `⌘F ⌘S` | search in selection only |
| `⌘F ⌘R` | replace |
| `⌘F R` | replace in files |
| `⌘F ⌘G` | find next / move to next occurrence |
| `⌘F ⌘T` | find previous / move to previous occurrence |
| `⌘F A` | select all occurrence |
| `⌘F S` | add selection to next occurrence |
| `⌘F D` | unselect occurrence |
| `⌘F ⌘D` | next occurrence of the word at caret |
| `⌘F ⌘E` | previous occurrence of the word at caret |

## View

| Keys | Action |
| --- | --- |
| `⌘E` | recent files |
| `⇧⌘E` | recent locations |
| `⌘S ⌘S` | quick documentation |
| `⌘S ⌘A` | external documentation |
| `⌘S ⌘D` | parameter info |
| `⌘S ⌘F` | type info |
| `⌘S ⌘C` | context info |
| `⌘S ⌘E` | error description |

## Navigate

| Keys | Action |
| --- | --- |
| `⌘G ⌘G` | next highlighted error |
| `⌘G ⌘T` | previous highlighted error |
| `⌘G ⌘B` | go to declaration or usages |
| `⌘G B` | go to implementation |
| `⌘G ⌘V` | go to test |
| `⌘G ⌘R` | type hierarchy |
| `⌘G ⌘S` | method hierarchy |
| `⌘G ⌘D` | call hierarchy |
| `⌘G ⌘E` | find usages |
| `⌘G E` | find usages in file |
| `⌘G ⇧E` | find usages settings |

## Refactor

| Keys | Action |
| --- | --- |
| `⌘T T` | refactor this |
| `⌘T ⌘T` | rename |
| `⌘T ⌘R` | change signature, modify object |
| `⌘T ⌘V` | introduce variable |
| `⌘T ⌘C` | introduce constant |
| `⌘T ⌘F` | introduce field |
| `⌘T ⌘P` | introduce parameter |
| `⌘T ⌘M` | extract routine, extract method |
| `⌘T ⌘N` | inline |
| `⌘T ⌘O` | override methods |
| `⌘T ⌘I` | implement methods |
| `⌘T ⌘G` | generate |
| `⌘T ⌘U` | toggle case |
| `⌘T ⌘A` | surround with |
| `⌘T A` | unwrap/remove |
| `⌘T ⌘S` | move |
| `⌘T ⌘D` | copy |

## Run&Debug

| Keys | Action |
| --- | --- |
| `⌘R ⌘R` | run |
| `⌘R ⌘D` | debug |
| `⌘R R` | run... |
| `⌘R D` | debug... |
| `⌘R ⌘S` | stop |
| `⌘R ⌘L`, `⌘R →` | step over |
| `⌘R L` | force step over |
| `⌘R ⌘J`, `⌘R ↓` | step into |
| `⌘R J` | force step into |
| `⌘R ⌘K`, `⌘R ↑` | step out |
| `⌘R ⌘.` | run to cursor |
| `⌘R .` | force run to cursor |
| `⌘R ⌘P`, `⌘R ⤓` | pause program |
| `⌘R ⌘O`, `⌘R ⤒` | resume program |
| `⌘R ⌘B` | toggle line breakpoint |
| `⌘R B` | view breakpoints |

## Window

| Keys | Action |
| --- | --- |
| `⇧⎋` | hide active tool window |
| `^⌥←` | stretch to left |
| `^⌥→` | stretch to right |
| `^⌥TOP` | stretch to top |
| `^⌥BOTTOM` | stretch to bottom |
| `⇧⌘]`, `^⌘→` | select next tab |
| `⇧⌘[`, `^⌘←` | select previous tab |
| `⌘W` | close tab |
| `⌥W ⌥A` | reopent closed tab |
| `⌥W ⌥R` | split right |
| `⌥W ⌥E` | split down |
| `⌥W ⌥D` | change splitter orientation |
| `⌥W ⌥F` | maximize editor/normalize splits |
| `⌥W ⌥Q` | unsplit |
| `⌥W Q` | unsplit all |
| `⌥W ⌥W` | goto next splitter |
| `⌥W W` | goto previous splitter |
| `⌥W <N>` | select tab #N |
| `⌥W ⌥X` | move to opposite group |
| `⌥W ⌥C` | open in opposite group |

# Tools

| Keys | Action |
| --- | --- |
| `^V` | vsc operations popup |
| `⌘1` | project |
| `⌘2` | terminal |
| `⌘3` | find |
| `⌘4` | run |
| `⌘5` | debug |
| `⌘6` | problems |
| `⌘7` | structure |
| `⌘8` | services |
| `⌘9` | version control |
| `⌘0` | commit |