Setup VIM

```
:set number
:set nu
:set syntax on
:set filetype=yaml
:set tabstop=2

```

https://www.dbi-services.com/blog/vim-tips-tricks-for-the-kubernetes-cka-exam/


# Setup
https://www.youtube.com/watch?v=h-epcklOC_g

keybindings.json

  // Ensure that tab button works in vim.
  {
    "key": "tab",
    "command": "tab",
    "when": "editorTextFocus && !editorTabMovesFocus"
  },
  {
    "key": "shift+tab",
    "command": "outdent",
    "when": "editorTextFocus && !editorTabMovesFocus"
  }

settings.json

  // VS Code automatically highlights selected words.
  // "vim.hlsearch": false,
  "vim.timeout": 200,
  "vim.useSystemClipboard": true,
  "vim.insertModeKeyBindings": [
    {
      "before": ["k", "j"],
      "after": ["<Esc>", "l"]
    }
  ],

# COMMANDS

Shift + A                       Activate insert mode in the end of line
Shift + ZZ                      Save and exit

25G                             go to 25-th line
25%                             go to 25% of the file

w (1w)                          next word
b (1b)                          previous word

/search-string                  search forward in file
?search-string                  search backward in file
n                               next search result
Shift + N                       prev search result
:set hlsearch                   highlight search results

o                               insert line and go to edit mode
Shift + 6 or 0                  go to the begining of a line

yy                              copy a line
p (4p)                          paste the line

Shift + V                       enter a visual mode
d                               delete lines
Shift + j                       join two lines

u                               undo changes
Ctrl + R                        redo changes

:w filename                     write buffer to file
:h                              help
Ctrl + f                        next page
Ctrl + b                        prev page


vim +/motion filename.txt       open a file and make a search
vim +295 filename.txt           open a file and go to the 295-th line

/usr/share/vim/vim90/doc        a folder with VIM help files
grep -wn search-word *.txt      search for a word and print line numbers

gv                              repeat selection
shift + >                       tab the text

Shift + H M L                   go to Top, Middle, Low