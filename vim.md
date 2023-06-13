Setup VIM

```
:set number
:set nu
:set syntax on
:set filetype=yaml
:set tabstop=2
:set scrolloff=5
:set list   # show end of line
:set ignorecase   # ignore case in search
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

Shift + {}                      go to the next paragraph

Shift + A                       start edit at the end of the string
Shift + I                       start edit from the beginning of the string

Ctrl + v -> Shift + I           Multiline add

dd                              delete line                               
d^                              delete to the begining of the line
d$                              delete to the end of the line
d}                              dekete the paragraph

dG                              delete to the end of the file

x     delete hte symbol under the cursor

dw
db
dW
dB

yy
y^
y$
yG

Y     copy the line

p     paste in the line
P     paste below

r     replace the text
cw    delete the end of the word and enter the INSERT mode

*     seach for all words


s/the/THE           find and replace the first instance in this file

%s/the/THE/g        find and replace ALL instance in ALL lines

%s/the/THE/gc       find and replace ALL instance in ALL lines with confirtmation

%s/the/THE/gci      find and replace ALL instance in ALL lines with confirtmation and CASE insensitive

:shell              go to shell. then "exit"
:! ls -ls           read a command inside vim
:read ! ls -la      insert a content of the comand into the vim

vsp                 vertical split
ctrl + wr           switch view
ctrl + ww           switch coursor

sp                  split
:new                new file
:edit               edit file
:exit               exit file

:tabnew             create new tab
gt                  switch between tabs

:ls                 show buffers
:buffers            show buffers

:hide               hide changes (showen with + in the buffer list)