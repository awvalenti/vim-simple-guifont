scriptversion 4

if exists("simple_guifont#loaded")
  finish
endif
let simple_guifont#loaded = v:true

function! simple_guifont#Set(preferred_fonts, fallback_font, size)
  let &guifont = s:MakeGuifontString(a:preferred_fonts, a:fallback_font, a:size)
endfunction

function! s:MakeGuifontString(preferred_fonts, fallback_font, size)
  if has('gui_win32') || has('gui_win64') || has('gui_macvim')
    return a:preferred_fonts
          \->add(a:fallback_font)
          \->map({ _, family -> family == '*' ? '*' : family .. ':h' .. a:size })
          \->join(',')
  elseif has('gui_gtk')
    const l:chosen_font = s:GtkGetSystemFonts()
          \->s:GtkFindBestFont(a:preferred_fonts, a:fallback_font)
    return l:chosen_font == '*' ? '*' : l:chosen_font .. ' ' .. a:size
  endif
endfunction

function! s:GtkGetSystemFonts()
  return 'fc-list -f "%{family}\n" | sed -E -e "s/,/\n/g" | sort -u'
        \->system()
        \->split("\n")
endfunction

function! s:GtkFindBestFont(system_fonts, preferred_fonts, fallback_font)
  for system_font in a:system_fonts
    for preferred_font in a:preferred_fonts
      if preferred_font ==? system_font
        return preferred_font
      endif
    endfor
  endfor
  return a:fallback_font
endfunction

