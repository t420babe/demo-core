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

// #ifndef COMMON_SIGNAL
// #include "lib/common/signal.glsl"
// #endif
//
// #ifndef T4B_ABS_02
// #include "lib/t420babe/abs/abs-02.glsl"
// #endif


void main(void) {
  vec2 p2 = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = u_audio;
  float time = t;
  vec3 color = abs(vec3(sin(time), cos(time), sin(time * PI)));
  gl_FragCoord = vec4(color, 1.0);
  // abs_02(vec3(p2, p3.z), time, audio);
}
