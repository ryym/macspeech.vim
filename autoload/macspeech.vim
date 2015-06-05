let s:save_cpo = &cpo
set cpo&vim

let s:speech_pid          = 0
let s:kill_signal_SIGTERM = 15

" Speak the text.
function! macspeech#say(text)
  let text         = s:escape_text(a:text)
  let process_obj  = vimproc#popen2('say "'.text.'"')
  let s:speech_pid = process_obj.pid
endfunction

" Speak the selected text.
function! macspeech#say_selected_text() range
  let temp = @@
  silent normal! gvy
  let selected_text = @@
  let @@ = temp

  call macspeech#say(selected_text)
endfunction

" Stop the speech.
function! macspeech#stop()
  if s:speech_pid
    call vimproc#kill(s:speech_pid, s:kill_signal_SIGTERM)
    let s:speech_pid = 0
  endif
endfunction

" Escape the text.
function! s:escape_text(text)
  let text = a:text
  for char in ['\', "'", '"']
    let text = escape(text, char)
  endfor
  return text
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
