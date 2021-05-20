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

// #ifndef T4B_FRACTIONS_06
// #include "lib/t420babe/fractions/fractions-06.glsl"
// #endif

#ifndef T4B_B2B_00
#include "lib/t420babe/b2b/b2b-00.glsl"
#endif

// #ifndef T4B_B2B_16
// #include "lib/t420babe/b2b/b2b-16.glsl"
// #endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  audio = u_audio;
  float time = t;
  // time += 1000.0;
  b2b_00(p3, time, audio);
  // b2b_16(p3, time, audio);
  // fractions_06(p3, time, audio);
  // fractions_78(p3, time, audio);

  // gl_FragColor = vec4(color, 1.0);
}
