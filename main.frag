#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

uniform vec2 u_resolution;

uniform float t;
uniform peakamp u_audio;
varying vec3 p3;
uniform sampler2D u_fb;
uniform sampler2D u_freq_fast;
uniform sampler2D u_freq_med;
uniform sampler2D u_freq_slow;

#ifndef COMMON_S4Y
#include "lib/common/s4y.glsl"
#endif

// // Fidem Community - Zero Nine BEGIN
// #ifndef T4B_B2B_49
// #include "lib/t420babe/b2b/b2b-49.glsl"
// #endif

// x // // 5:38, Kemt I'll Be Around
// #ifndef T4B_B2B_48
// #include "lib/t420babe/b2b/b2b-48.glsl"
// #endif

// x // // 7:38 Holo - In My Dreams
// #ifndef T4B_B2B_07
// #include "lib/t420babe/b2b/b2b-07.glsl"
// #endif

// #ifndef T4B_B2B_50
// #include "lib/t420babe/b2b/b2b-50.glsl"
// #endif
//
// #ifndef T4B_B2B_05
// #include "lib/t420babe/b2b/b2b-05.glsl"
// #endif
//
// // // 4:00 Honeydust - or start clozee set
// #ifndef T4B_B2B_02
// #include "lib/t420babe/b2b/b2b-02.glsl"
// #endif

// transition from mathy to trippy
// #ifndef T4B_FRACTIONS_90
// #include "lib/t420babe/fractions/fractions-90.glsl"
// #endif

// // // kp hypdes tippy
// #ifndef T4B_FRACTIONS_78
// #include "lib/t420babe/fractions/fractions-78.glsl"
// #endif

// // // kp hypdes tippy
// #ifndef T4B_FRACTIONS_94
// #include "lib/t420babe/fractions/fractions-94.glsl"
// #endif

// #ifndef T4B_FRACTIONS_24
// #include "lib/t420babe/fractions/fractions-24.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_36
// #include "lib/t420babe/fractions/fractions-36.glsl"
// #endif

// #ifndef T4B_FRACTIONS_37
// #include "lib/t420babe/fractions/fractions-37.glsl"
// #endif
//
// // fraction-38
// #ifndef T4B_FRACTIONS_38
// #include "lib/t420babe/fractions/fractions-38.glsl"
// #endif

#ifndef T4B_FRACTIONS_85
#include "lib/t420babe/fractions/fractions-85.glsl"
#endif
// #ifndef T4B_FRACTIONS_11
// #include "lib/t420babe/fractions/fractions-11.glsl"
// #endif
// fractoins-67.glsl

// #ifndef T4B_FRACTIONS_126
// #include "lib/t420babe/fractions/fractions-126.glsl"
// #endif

// #ifndef T420BABE_CHOICE_20
// #include "lib/t420babe/choice/choice-20.glsl"
// #endif

// #ifndef T4B_ARRIVAL_09
// #include "lib/t420babe/arrival/arrival-09.glsl"
// #endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  audio = u_audio;
  float time = t;
  // time += t2s(0, 3, 0);
  // time += 388.0;
  // time *= 4.0;
  // fractions_11(p3, time, audio);
  // choice_20(p3, time, audio);
  // b2b_02(p3, time, audio);
  fractions_85(p3, time, audio);
  // arrival_09(p3, time, audio);
  // fractions_48(p3, time, audio);
  // fractions_38(p3, time, audio);

  // vec3 color = vec3(audio.notch, audio.bandpass, audio.highpass) * 2.0;
  // gl_FragColor = vec4(color, 1.0);
}
