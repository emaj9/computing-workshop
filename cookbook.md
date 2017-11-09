COOKBOOK
========

VIM
-----

### Insert text at the same column over several lines

We want to go from

    Lorem Ipsum is simply dummy text of the printing and typesetting industry.
    Lorem Ipsum has been the industry's standard dummy text ever since the
    1500s, when an unknown printer took a galley of type and scrambled it to
    make a type specimen book. It has survived not only five centuries, but
    also the leap into electronic typesetting, remaining essentially unchanged.
    It was popularised in the 1960s with the release of Letraset sheets
    containing Lorem Ipsum passages, and more recently with desktop publishing
    software like Aldus PageMaker including versions of Lorem Ipsum.

to

    hello Lorem Ipsum is simply dummy text of the printing and typesetting industry.
    hello Lorem Ipsum has been the industry's standard dummy text ever since the
    hello 1500s, when an unknown printer took a galley of type and scrambled it to
    hello make a type specimen book. It has survived not only five centuries, but
    hello also the leap into electronic typesetting, remaining essentially unchanged.
    hello It was popularised in the 1960s with the release of Letraset sheets
    hello containing Lorem Ipsum passages, and more recently with desktop publishing
    hello software like Aldus PageMaker including versions of Lorem Ipsum.

And insert the text `"hello "` on the front of every line.

  * Go to normal mode.
  * Position the cursor at the beginning of the first line.
  * Enter visual block mode by pressing `Ctrl+V`.
  * Move the cursor to the last line.
    This selects part of one column of text.
  * Press Shift+I to enter insert mode, and input the text you want.
  * Pressing escape to return to normal mode will prepend the text to the other
    lines.
