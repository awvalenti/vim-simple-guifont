# vim-simple-guifont
The simple and portable way to `set guifont` on GVim.

## Without it 🙁
```vim
if has('gui_win32') || has('gui_win64') || has('gui_macvim')
  " Complicated syntax; repetition of size (many places to change if needed)
  set guifont=Cascadia\ Code\ PL:h14,JetBrains\ Mono:h14,Hack:h14,Consolas:h14

elseif has('gui_gtk')
  " Different syntax; no support for alternatives; messes up if not found
  set guifont=Consolas\ 14
endif
```

## With it 😍
```vim
silent! call simple_guifont#Set(
  \['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
```

## Usage
Add the following to you `vimrc`
(using [vim-plug](https://github.com/junegunn/vim-plug) in this example):
```vim
call plug#begin()
" ...
Plug 'awvalenti/vim-simple-guifont'
" ...
call plug#end()

" function! simple_guifont#Set(preferred_fonts, fallback_font, size)
silent! call simple_guifont#Set(
  \['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
```
- `silent!` is optional. You can add it to avoid an error before the plugin
is installed. You can omit it to see all errors in case they occur.
- `preferred_fonts` is a list of font families, from most to least preferred.
- `fallback_font` is separated because it is handled differently on Linux.
  It will be chosen if none of the prefereed ones are found. You can
  use a '*' fallback to prompt user for a font.
- `size` is usually 10, 12, 14, 16.


## Saying thank you
If you find this plugin useful, please leave this repository a star
[up there](#top) ⭐!

## Internals
Operating system is detected and the appropriate measures are taken.
For Windows and Mac, a string is created and set as `guifont`.
For Linux with GTK, much more is done: shell programs are called to get
a list of all installed fonts, then the best match is searched.
If one is not found, the fallback font is chosen.
To learn more, just browse the [source code](autoload/simple_guifont.vim).

## Development
Contributions are welcome! Especially testing on Mac, but also any other
improvements.
