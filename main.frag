#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif

#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

// uniform float u_lowpass;
// uniform float u_highpass;
// uniform float u_bandpass;
// uniform float u_notch;
// uniform float u_at;
uniform vec2 u_resolution;
// uniform float u_time;

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

// #ifndef T4B_FRACTIONS_33
// #include "lib/t420babe/fractions/fractions-33.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_35
// #include "lib/t420babe/fractions/fractions-35.glsl"
// #endif
// //
// #ifndef T4B_FRACTIONS_78
// #include "lib/t420babe/fractions/fractions-78.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_84
// #include "lib/t420babe/fractions/fractions-84.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_85
// #include "lib/t420babe/fractions/fractions-85.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_87
// #include "lib/t420babe/fractions/fractions-87.glsl"
// #endif
//
// // No audio
// #ifndef T4B_FRACTIONS_89
// #include "lib/t420babe/fractions/fractions-89.glsl"
// #endif
//
// // No audio
// #ifndef T4B_FRACTIONS_90
// #include "lib/t420babe/fractions/fractions-90.glsl"
// #endif
//
// // No audio - FAV
// #ifndef T4B_FRACTIONS_95
// #include "lib/t420babe/fractions/fractions-95.glsl"
// #endif
//
// // No audio - FAV
// #ifndef T4B_FRACTIONS_96
// #include "lib/t420babe/fractions/fractions-96.glsl"
// #endif
//
// // No audio - FAV
// #ifndef T4B_FRACTIONS_97
// #include "lib/t420babe/fractions/fractions-97.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_77
// #include "lib/t420babe/fractions/fractions-77.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_75
// #include "lib/t420babe/fractions/fractions-75.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_73
// #include "lib/t420babe/fractions/fractions-73.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_72
// #include "lib/t420babe/fractions/fractions-72.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_70
// #include "lib/t420babe/fractions/fractions-70.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_67
// #include "lib/t420babe/fractions/fractions-67.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_66
// #include "lib/t420babe/fractions/fractions-66.glsl"
// #endif
//
// #ifndef T4B_FRACTIONS_65
// #include "lib/t420babe/fractions/fractions-65.glsl"
// #endif

#ifndef T4B_FRACTIONS_98
#include "lib/t420babe/fractions/fractions-98.glsl"
#endif

// #ifndef T4B_FRACTIONS_64
// #include "lib/t420babe/fractions/fractions-64.glsl"
// #endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  audio = u_audio;
  float time = t;
  vec3 color = vec3(1.0);
  // color.r *= audio.lowpass;
  // color.g *= audio.highpass;
  // color.b *= audio.notch;
  // fractions_33(p3, time, audio);
  // fractions_35(p3, time, audio);
  // fractions_78(p3, time, audio);
  // fractions_84(p3, time, audio);
  // fractions_85(p3, time, audio);
  // fractions_87(p3, time, audio);
  // fractions_89(p3, time, audio);
  // fractions_90(p3, time, audio);
  // fractions_95(p3, time, audio);
  // fractions_96(p3, time, audio);
  // fractions_97(p3, time, audio);
  // fractions_77(p3, time, audio);
  // fractions_75(p3, time, audio);
  // fractions_73(p3, time, audio);
  // fractions_72(p3, time, audio);
  // fractions_70(p3, time, audio);
  // fractions_67(p3, time, audio);
  // fractions_66(p3, time, audio);
  // fractions_65(p3, time, audio);
  fractions_98(p3, time, audio);
}

