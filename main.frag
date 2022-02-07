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

#ifndef COMMON_S4Y
#include "lib/common/s4y.glsl"
#endif

#ifndef COMMON_SIGNAL
#include "lib/common/signal.glsl"
#endif

#ifndef T4B_ABT_00
#include "lib/t420babe/abt/abt-00.glsl"
#endif

// #ifndef T4B_ABF_141
// #include "lib/t420babe/abf/abf-141.glsl"
// #endif
//
// #ifndef T4B_ABH_87
// #include "lib/t420babe/abh/abh-87.glsl"
// #endif

// #ifndef T4B_ABS_46
// #include "lib/t420babe/abs/abs-46.glsl"
// #endif

// #ifndef T4B_ABQ_46
// #include "lib/t420babe/abq/abq-46.glsl"
// #endif


void main(void) {
  vec2 p2 = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = u_audio;
  float time = t;
  // abh_87(vec3(p2, p3.z), time, audio);
  abt_00(vec3(p2, p3.z), time, audio);
  // abm_05(vec3(p2, p3.z), time, audio);
}
