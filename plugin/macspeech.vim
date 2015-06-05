" Vim plugin for speaking texts in Mac.
" Version: 0.0.1
" Author : ryym
" License: NYSL

if ! (has('mac') || has('macunix') || has('gui_macvim'))
  finish
endif

if exists('g:loaded_macspeech')
  finish
endif

let g:loaded_macspeech = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 MacSpeech         call macspeech#say(<q-args>)
command! -range   MacSpeechSelected call macspeech#say_selected_text()
command!          MacSpeechStop     call macspeech#stop()

let &cpo = s:save_cpo
unlet s:save_cpo
