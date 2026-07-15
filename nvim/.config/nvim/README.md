# Neovim Config

`<Esc>`: clear search 'highlight'

`<leader>w`: save file

`<leader>?`: show buffer keymaps (which-key)

`i`: smart insert (auto-indent on empty line)

## Navigation

`<C-j>`: scroll down 50 lines

`<C-k>`: scroll up 50 lines

`n`: next search result (centered)

`N`: previous search result (centered)

`<leader>t`: toggle fold

`<leader>T`: toggle function folds

`]]`: next word reference (snacks.words)

`[[`: previous word reference (snacks.words)

## Editing

`J` : join lines (cursor stays in place)

`J` (visual): move selection down

`K` (visual): move selection up

`<C-_>`: toggle comment (line or selection, \_ in terminal is same as /)

`<leader>a`: select all text in buffer without moving cursor

`<leader>y`: yank buffer without moving cursor

`<leader>y` (visual): yank selection without moving cursor

`<M-d>`: delete to void register

`<M-c>`: change to void register

`<M-x>`: x to void register

`<M-s>`: s to void register

`<A-p>` (visual): paste without losing clipboard

## Snacks Picker

`<leader>f`: find files

`<leader>/`: grep search

`<leader>,`: file explorer sidebar

`<leader>sh`: help pages

`<leader>ss`: LSP symbols (buffer)

`<leader>sS`: LSP workspace symbols

`<leader>su`: undo history

`<leader>st`: find TODO/FIX/FIXME comments

## Snacks Explorer

`<CR>`: open file / enter directory

`.`: go to parent cwd

`,`: go to parent dir

`t`: toggle directory

`h`: toggle hidden files

`i`: toggle ignored files

`H`: toggle hidden and ignored files

`z`: close all directories

`r`: refresh explorer

## LSP

`gd`: goto definition

`gD`: goto declaration

`gr`: find references

`gI`: goto implementation

`gy`: goto type definition

`gl`: show line diagnostics

`<leader>rn`: rename symbol

`<leader>ca`: code action

`<leader>h`: toggle inlay hints

## Refactoring

`<leader>rr`: select refactor

`<leader>re`: extract function

`<leader>rE`: extract function to file

`<leader>rv`: extract variable

`<leader>ri`: inline variable

`<leader>rI`: inline function

## Bufferline

`<leader>1-9`: go to buffer N

`<S-h>`: previous buffer

`<S-l>`: next buffer

`<leader>bd`: delete buffer

`<leader>bo`: close other buffers

`<leader>br`: close buffers to the right

`<leader>bl`: close buffers to the left

## Terminal (Toggleterm)

`<C-t>`: toggle terminal

`<C-n>` (terminal): exit terminal mode

## Git (Gitsigns)

`]c`: next git hunk

`[c`: previous git hunk

`<leader>gb`: blame line

## Trouble (Diagnostics)

`<leader>xa`: toggle all diagnostics

`<leader>xb`: toggle buffer diagnostics

`<leader>xl`: toggle LSP definitions/references

## DAP (Debugger)

`<leader>db`: toggle breakpoint

`<leader>dB`: conditional breakpoint

`<leader>dc`: continue

`<leader>dC`: run to cursor

`<leader>di`: step into

`<leader>do`: step out

`<leader>dO`: step over

`<leader>dl`: run last

`<leader>dp`: pause

`<leader>dt`: terminate

`<leader>dr`: toggle REPL

`<leader>du`: toggle DAP UI

`<leader>de`: evaluate expression

## Oil (File Browser)

`<leader>o`: open Oil

`<CR>`: select file

`<C-s>`: open vertical split

`<C-h>`: open horizontal split

`<C-t>`: open in tab

`<C-p>`: preview

`<C-c>`: close

`<C-l>`: refresh

`,`: parent directory

`.`: open cwd

`;`: change directory

`<leader>os`: change sort

`<leader>ox`: open external

`<leader>ot`: toggle hidden files

## Surround

`ss{char}`: surround entire line

`s{char}` (visual): surround selection

`sd{char}`: delete surround

`sc{old}{new}`: change surround

## Flash

`f` / `F`: enhanced f/F with jump labels

`<C-Space>`: treesitter incremental selection

`<BS>` (in treesitter select): shrink selection

## Treesitter Text Objects

`if`/`af`: inner/around function

`ia`/`aa`: inner/around argument

`ib`/`ab`: inner/around block

`ii`/`ai`: inner/around conditional

`il`/`al`: inner/around loop

`is`/`as`: inner/around struct (or class)

`ir`/`ar`: inner/around return

## Treesitter Navigation

`]f` / `[f`: next/previous function

`]a` / `[a`: next/previous argument

`]i` / `[i`: next/previous conditional

`]l` / `[l`: next/previous loop

## Formatting (Conform)

`=`: format buffer (also formats on save)

## Completion (Blink)

`<C-y>`: accept completion

`<C-Space>`: open menu / open docs

`<C-n>` / `<C-p>`: next/previous item

`<C-e>`: hide menu

`<C-h>` (insert): signature help

## Markdown

`<leader>mp`: toggle markdown preview

## Leader Namespaces

`b` buffer, `d` debug, `g` git, `l` LeetCode, `m` markdown, `o` oil, `r` refactor, `s` search/snacks, `t` folds, `x` diagnostics
