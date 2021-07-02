# vim-simple-guifont
The simple and portable way to `set guifont` on GVim.

## Without it 😢
```vimscript
if has('gui_win32') || has('gui_win64') || has('gui_macvim') " Windows, Mac
  " Complicated syntax; repetition of size (many places to change if needed)
  set guifont=Cascadia\ Code\ PL:h14,JetBrains\ Mono:h14,Hack:h14,Consolas:h14

elseif has('gui_gtk') " Linux
  " Different syntax; no support for alternatives; makes a mess if font is not found
  set guifont=Consolas\ 14
endif
```

## With it 😍
```vimscript
silent! call simple_guifont#Set(
  ['Cascadia Code PL', 'JetBrains Mono', 'Hack'], " List your preferred fonts
  'Consolas',                                     " Choose a fallback (can be '*' to ask user)
  14                                              " Set size and it's done!
)
```

## Usage
Add the following to you `vimrc`
(example using [vim-plug](https://github.com/junegunn/vim-plug)):
```vimscript
call plug#begin()
" ...
Plug 'awvalenti/vim-simple-guifont'
" ...
call plug#end()

" 'silent!' is optional. It avoids an error before the plugin is installed.
" You can omit it to show any error that occurs.
silent! call simple_guifont#Set(['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
```

## Internals
`vim-simple-guifont` first detects your OS, then uses the
appropriate strategy. For Windows and Mac, it just builds a string like
the one from #without-it. For Linux with GTK, it calls some shell
programs to get a list of all installed fonts and then finds
the best match. If it cannot find a match, it chooses the fallback font.
To learn more, just browse the [source code](blob/main/autolad/simple_guifont.vim).

## Development
Contributions are welcome! Especially:
- Testing on Mac
- Advice on good practices for Vim plugins

