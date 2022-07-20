COOKBOOK
========

VIM
-----

### Insert text at the same column over several lines

We want to go from

    Lorem Ipsum is simply dummy text of the printing and typesetting industry.
    Lorem Ipsum has been the industry's standard dummy text ever since the
    1500s, when an unknown printer took a galley of type and scrambled it to

to

    hello Lorem Ipsum is simply dummy text of the printing and typesetting industry.
    hello Lorem Ipsum has been the industry's standard dummy text ever since the
    hello 1500s, when an unknown printer took a galley of type and scrambled it to

And insert the text `"hello "` on the front of every line.

  * Go to normal mode.
  * Position the cursor at the beginning of the first line.
  * Enter visual block mode by pressing `Ctrl+V`.
  * Move the cursor to the last line.
    This selects part of one column of text.
  * Press Shift+I to enter insert mode, and input the text you want.
  * Pressing escape to return to normal mode will prepend the text to the other
    lines.

### Commands

In normal mode:

  * undo: `u`
  * redo: `Ctrl+R`
  * half-page up: `Ctrl+U`
  * half-page down: `Ctrl+D`

#### Deleting and changing text

In normal mode, `d` (in combination with a motion) deletes text.
For example, `w` moves us to the front of the next word, so `dw` deletes the
text text up to the front of the next word.
There are some exceptions: `dd` deletes the entire line under the cursor, and
prefixing `dd` command with a number deletes that number of lines.

The same applies to `c` (change), but after deleting the text, you're placed in
insert mode so you can replace (some of) the text.

#### Find and replace

  * In normal mode, type `/` to enter a search query.
  * Press enter to execute the search.
  * Press `n` to go to the next result, and `N` to go to the previous one.

And replace:

  * Press `:` to go to command mode.
  * Enter the range of your search.
    To search through just the line you're on, leave the range blank. (Input
    nothing.)
    To search through the entire file, input `%`. (Percent generally refers to
    the entire file.)
  * Input a `/` and type the text to search for.
  * Input a `/` and type the text to replace with.
  * Optionally, input a `/` and input any options.
    Options are single letters. For example `g` makes the search _global_, so
    it will replace every occurrence on a line. Without this flag, the search
    will only replace the first match on every line in the range.
    The `c` flag makes Vim confirm each match.

Example: `:%s/hello/goodbye/gc`
