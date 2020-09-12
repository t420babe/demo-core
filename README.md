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

- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_blue_clock_arrow(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_red_kal(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_kal(vec2 pos, float u_time, peakamp audio, out vec3 color)`

- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_sliding_in_cyan_square(vec2 pos, float u_time, peakamp audio, out vec3 color)`

File name format:
`*.aa.glsl` - Ableton audio expects peakamp of `u_lowpass`, `u_highpass`, `u_notch`, `u_bandpass`

Auto commit on save:
`autocmd BufWritePost * execute '!git add % && git commit -m %'`


Set:
- ridge.glsl - Brain Juice by DARK $
- `doppler_audio` - Moonlight by Gaulin 20 qmetro
- `hypnotized_by_the_light` - Hypnotized - Loods Remix by Purple Disco Machine, Sophie and the Giants


Songs:
- us by Steve James - 40 qmetro
- kowabunga! by SuperParka


Remaining:
- `rotating_lines` functions can be consolidated with `shader_idx` and `color_idx`
- make the doppler shader easier to use. split into multiple functions then also make the idx option in the main doppler function



Maybe go back to these commits:
88c657b35426b87f109d2ffa32c0fd51465f930e

All functions in `lib/pxl` that have `sdf` appended to the function definition have this license:
```
/*
 Copyright (c) 2017 Patricio Gonzalez Vivo ( http://www.pixelspiritdeck.com )
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 Redistributions of source code must retain the above copyright notice,
 this list of conditions and the following disclaimer.
 
 Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
```

- just have everything in one single include file that you point to in the cli command.
      one main include per dir, all the way up to the top level lib
