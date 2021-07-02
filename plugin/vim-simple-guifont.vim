if !has('gui_running')
  finish
endif

function! s:GtkGetSystemFonts()
  return 'fc-list -f "%{family}\n" | sed -E -e "s/,/\n/g" | sort -u'
        \->system()
        \->split("\n")
endfunction

function! s:GtkFindBestFont(system_fonts, desired_fonts, fallback_font)
  for system_font in a:system_fonts
    for desired_font in a:desired_fonts
      if desired_font ==? system_font
        return desired_font
      endif
    endfor
  endfor
  return a:fallback_font
endfunction

function! s:MakeGuifontString(desired_fonts, fallback_font, size)
  if has('gui_win32') || has('gui_win64') || has('gui_macvim')
    return a:desired_fonts
          \->add(a:fallback_font)
          \->map({ family -> family .. ':h' .. a:size })
          \->join(',')
  elseif has('gui_gtk')
    return s:GtkGetSystemFonts()
          \->s:GtkFindBestFont(a:desired_fonts, a:fallback_font)
          \.. ' '
          \.. a:size
  endif
endfunction

let &guifont = s:MakeGuifontString(['dejavu sans mon', 'oto mono', 'monospac'], 'mono', 14)

