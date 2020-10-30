Favorites:
 - `lib/t420babe/babydoyougetme.glsl` `babydoyougetme_1(vec2 pos, float u_time)` scrolling black to purple with trippy tee-pee
 - `lib/t420babe/rainbow-scales.glsl` `rainbow_0(vec2 pos, vec2 u_resolution, vec2 u_mouse)` black and white on one side, red and cyan on the other. all rotating transparent scales on top
- `lib/t420babe/doppler.glsl` `void choppy_doppler_square_fractal(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/doppler.glsl` `void choppy_doppler_square_fractal_zoom_out(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/doppler.glsl` `void doppler_morph(vec2 pos, float u_time, peakamp audio, out vec3 color)` Mess with the positions under RRTI for really cool effects
- `lib/t420babe/doppler.glsl` `void doppler_trippy_melting_diamond(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/doppler.glsl` `void doppler_pink_blue_sand(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/doppler.glsl` `void doppler_green_rooster(vec2 pos, float u_time, peakamp audio, out vec3 color)`, sofias theme
- `lib/t420babe/audio-circle.aa.glsl` `void doppler_purple(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_blue_clock_arrow(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_red_kal(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_kal(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/sayin-sayin.glsl` `void sayin_sayin_sliding_in_cyan_square(vec2 pos, float u_time, peakamp audio, out vec3 color)`
- `lib/t420babe/wood-bb/caterpillar.glsl`
- `lib/t420babe/wood-bb/wood-brother-louie-5.glsl`
- `lib/t420babe/wood-bb/wood-brother-louie-7.glsl`
- `lib/t420babe/wood-bb/wood-brother-louie-8.glsl`
- `lib/t420babe/ridge/alligator.glsl`
- `lib/t420babe/ridge/ridge-3.glsl` ALL THE RIDGES
- `lib/t420babe/ridge/ridge-5.glsl` ALL THE RIDGES
- `lib/t420babe/ridge/ridge-6.glsl` ALL THE RIDGES itme
- `lib/t420babe/ridge/ridge-9.glsl` ALL THE RIDGES
- `lib/t420babe/ridge/ridge-10.glsl` ALL THE RIDGES
- `lib/t420babe/ridge/ridge-19.glsl` play with the four colors - Bassically by Tei Shi
- `lib/t420babe/ridge/ridge-22.glsl` 
- `lib/t420babe/ridge/ridge-24.glsl`  play with the colors - I Feel So Bad The Kunds

File name format:
`*.aa.glsl` - Ableton audio expects peakamp of `u_lowpass`, `u_highpass`, `u_notch`, `u_bandpass`

Auto commit on save:
`autocmd BufWritePost * execute '!git add % && git commit -m %'`


Set:
- ridge.glsl - Brain Juice by DARK $
- `doppler_audio` - Moonlight by Gaulin 20 qmetro
- `hypnotized_by_the_light` - Hypnotized - Loods Remix by Purple Disco Machine, Sophie and the Giants
- `wbl5c_wood` - In Memoriam (Mixed) - Ben Bohmer
- ridge/ridge-8.glsl - Party All the Time 
- ridge/ridge-20.glsl - I Feel So Band - The Kungs
- ridge/ridge-22.glsl - Paris - The Kungs


Songs:
- us by Steve James - 40 qmetro
- kowabunga! by SuperParka
- Paris - The Kungs


Remaining:
- `rotating_lines` functions can be consolidated with `shader_idx` and `color_idx`
- make the doppler shader easier to use. split into multiple functions then also make the idx option in the main doppler function



Maybe go back to these commits:
88c657b35426b87f109d2ffa32c0fd51465f930e









Script:
Directory 0, d0: directory with all the commits
Directory 1, d1: directory where each commit will be saved as a new file

- for each commit
  - save changed files with appended id
    ex: if d0/main.frag and d0/lib/t420babe/couch-1.glsl were changed in commit0,
        they would be copied and saved in their identical dirs:

          d1/main-0.frag d1/lib/t420babe/couch-1-0.glsl

        Or maybe can specify a dir so (but not right now):

          d1/main-0.frag d1/lib/t420babe/couch/couch-1-0.glsl


goal: minimal imports to minimize load time 
sandbox
lib
  - effects   // things that makes good texture/pattern effectss
  - shapes
  - utils
    - math.glsl
    - easing.glsl
sets
  - set1
    - Makefile
    - n0...n1.frag
singles
  - Makefile
  - x.frag



# Textures
- ridge set
- ridge-21


# To Finalize
ridge-2.glsl -> City in Florida by Deadmau5
ridge-3.glsl -> Mi Mujer
couch-136c.glsl -> Aftershock by admo
couch162 -> Flug & Fall - Edit by Ben Bohmer

# This one needs a song
- ridge-12 -> maybe Cthulhu Sleeps by deadmau5
- ridge-15
- ridge-18 -> must be with the right song to see full vis
- ridge-19 -> maybe into the surf
- ridge-22 -> silly fun song
- ridge-24 -> play with those colors bb


- [ ] finished shaders MUST have all logic in their .frag file. no calling to external glsl lib files


Rule: everything in lib can reference each other except for the t420babe folder. all functions should be pulled into at least the descent designs. dont waste your time on non-bangerz
