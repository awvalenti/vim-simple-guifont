# vim-simple-guifont
The simple and portable way to `set guifont` on GVim.

## 🙁 Before
```vim
if has('gui_win32') || has('gui_win64') || has('gui_macvim')
  " Complicated syntax and repetition of size
  set guifont=Cascadia\ Code\ PL\:h14,JetBrains\ Mono\:h14,Hack\:h14,Consolas\:h14

elseif has('gui_gtk') " Linux
  " Another syntax and cannot specify more than one
  set guifont=Consolas\ 14
endif
```

## 😍 After
```vim
silent! call simple_guifont#Set(
  \['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
```

## Installation
If using [vim-plug](https://github.com/junegunn/vim-plug), add the following to your `vimrc` or `gvimrc`:
```vim
call plug#begin()
" ...
Plug 'awvalenti/vim-simple-guifont'
" ...
call plug#end()
```

For other plugin managers, please check their documentation,
or take a look at
[Vim 8's native plugin system](https://duckduckgo.com/?t=ffab&q=vim+native+plugin+management&ia=web).

## Usage
Just call this function:
```vim
simple_guifont#Set(preferred_fonts, fallback_font, size)
```

### Samples
- Typical usage, on `vimrc`
  ```vim
  " This check avoids loading plugin when Vim is running on terminal
  if has('gui_running')
    silent! call simple_guifont#Set(
      \['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
  endif
  ```

- Typical usage, on `gvimrc`
  ```vim
  " No need to check, we're on GVim
  silent! call simple_guifont#Set(
    \['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
  ```

- Debugging: `silent!` avoids throwing errors. It is useful when the plugin
  is not yet installed, avoiding prematurely ending your `vimrc`/`gvimrc`.
  If you ommit `silent!`, any errors will be explicit.
  ```vim
  call simple_guifont#Set(
    \['Cascadia Code PL', 'JetBrains Mono', 'Hack'], 'Consolas', 14)
  ```

- Single font
  ```vim
  silent! call simple_guifont#Set([], 'Fira Code Medium', 16)
  ```

- Try one; if not available, ask user to pick another one (by using `'*'`)
  ```vim
  silent! call simple_guifont#Set(['Monospace'], '*', 12)
  ```

## Appreciation
If you find this plugin useful, please [leave me a star up there ⭐](#top)!

## Internals
Operating system is detected and the appropriate measures are taken.

For Windows, it suffices to create a single string and set `guifont`.

Mac follows the same syntax, but it is uncertain whether it supports
a list of fonts like Windows does.

For Linux with GTK, much more is done: shell programs are called to get
a list of all installed fonts, then a search for the best match is done.
If no match is found, fallback font is chosen, without searching for
availability.

To learn more, just browse the [source code](autoload/simple_guifont.vim).

## TODO
Contributions are welcome! Main next steps are:
- Support for Mac (may or may not work, hasn't been tested yet)
- Support other platforms
- Support for Windows font options, like `Andale_Mono:h7:cANSI:qANTIALIASED`

