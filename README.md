Favorites:
 - `lib/t420babe/babydoyougetme.glsl` `babydoyougetme_1(vec2 pos, float u_time)`
  scrolling black to purple with trippy tee-pee

 - `lib/t420babe/rainbow-scales.glsl` `rainbow_0(vec2 pos, vec2 u_resolution, vec2 u_mouse)`
  black and white on one side, red and cyan on the other. all rotating
  transparent scales on top

- `lib/t420babe/doppler.glsl` `void choppy_doppler_square_fractal(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/doppler.glsl` `void choppy_doppler_square_fractal_zoom_out(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/doppler.glsl` `void doppler_morph(vec2 pos, float u_time, peakamp audio, out vec3 color)`
Mess with the positions under RRTI for really cool effects

- `lib/t420babe/doppler.glsl` `void doppler_trippy_melting_diamond(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/doppler.glsl` `void doppler_pink_blue_sand(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/doppler.glsl` `void doppler_green_rooster(vec2 pos, float u_time, peakamp audio, out vec3 color)`, sofias theme

- `lib/t420babe/audio-circle.aa.glsl` `void doppler_purple(vec2 pos, float u_time, peakamp audio, out vec3 color)`

File name format:
`*.aa.glsl` - Ableton audio expects peakamp of `u_lowpass`, `u_highpass`, `u_notch`, `u_bandpass`

Auto commit on save:
`autocmd BufWritePost * execute '!git add % && git commit -m %'`


Set:
- ridge.glsl - Brain Juice by DARK $
- `doppler_audio` - Moonlight by Gaulin 20 qmetro


Songs:
- us by Steve James - 40 qmetro
- kowabunga! by SuperParka


Remaining:
- `rotating_lines` functions can be consolidated with `shader_idx` and `color_idx`
- make the doppler shader easier to use. split into multiple functions then also make the idx option in the main doppler function


