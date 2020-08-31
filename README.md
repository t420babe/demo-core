Favorites:
 - lib/t420babe/babydoyougetme.glsl babydoyougetme_1(vec2 pos, float u_time)
  scrolling black to purple with trippy tee-pee

 - lib/t420babe/rainbow-scales.glsl rainbow_0(vec2 pos, vec2 u_resolution, vec2 u_mouse)
  black and white on one side, red and cyan on the other. all rotating
  transparent scales on top


  i need to make a tool that commits my file to git every time i save a shader



File name format:
`*.aa.glsl` - Ableton audio expects peakamp of `u_lowpass`, `u_highpass`, `u_notch`, `u_bandpass`

Auto commit on save:
`autocmd BufWritePost * execute '!git add % && git commit -m %'`
