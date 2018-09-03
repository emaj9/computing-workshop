todo:
  - list of common functions (Eric's prelude.hs walkthrough doc)
  - make slides
  - write up basic hs file to get started

0. Pattern matching and lists

  * Slides on pattern matching, the syntax of it.
    "Recall from last week that everything has a type signature in haskell,
    including functions. (Recall function types.) Datatypes remember how they
    were made."

    Eric: "Look at a type signature. Pattern matching to me is, teaching the
    function what to do when it gets certain inputs. Handling all the
    cases. Dummy exercises. Type signature: rough idea of the
    function. Implementation: the details. Important to catch all cases to avoid
    the function blowing up."

    Stoplight example: what to do when driving.

    intersection :: Light -> Action
    intersection Red = Stop
    intersection Yellow = SlowDown
    intersection Green = Go

    extension:
    intersection RightArrow = TurnRight if you need to, else Wait.

    catchall extension: (e.g. blinking light and don't understand)
    intersection _ = Stop -- just to be safe

    Syntactic constructions to cover: where, case-of, if-then-else

  * Slides on lists:
    - made of nil and cons / [1,2,3] is syntactic sugar
    - recursion:
      * length :: [a] -> Int
      * pattern matching on nil and cons
      * walkthrough of evaluation of `length [2,0,1,8]`
      * useful list functions: `cycle`, `head`, `tail`, => point to URL of doc

1. Coding together

  * Get everyone set up with our basic haskell file that sets up `interactionOf`.
  * Walkthrough one example: cycling through colors on keypress.
  * People are invited to share after.

2. Individual challenges

   Changing images:
     * color:
       - key press -> set to a fixed color
       - key press -> cycling through a list of colors
       - arrows -> slight hue adjustments (e.g. 5 degrees on color wheel)

     * shape:
       - cycling through a list of shapes (triangle, square, house, etc.)
       - increasing number of sides on a regular polygon

     * moving:
       - shape follows cursor => drag and drop
       - arrow keys

3. Last time with breadboards: the half-adder

  * XOR IC and connection to binary addition: crashcourse ALU
  * required materials:
    - AND gate IC and XOR gate IC
    - voltage regulator
    - resistors
    - 2 LEDs
    - battery
