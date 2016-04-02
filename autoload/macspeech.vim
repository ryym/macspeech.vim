let s:save_cpo = &cpo
set cpo&vim

let s:speech_pid          = 0
let s:kill_signal_SIGTERM = 15

" Speak the text.
function! macspeech#say(text)
  let process_obj  = s:_say(a:text)
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

function! s:_say(text)
  let escaped_text = shellescape(a:text)
  if exists('g:macspeech_voice')
    let voice = string(g:macspeech_voice)
    return vimproc#popen2('say --voice ' . voice . ' ' . escaped_text)
  else
    return vimproc#popen2('say ' . escaped_text)
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
