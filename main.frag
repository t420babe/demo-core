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

#ifndef T4B_BF_06
#include "lib/t420babe/bf/bf-06.glsl"
#endif

void main(void) {
  vec2 p2 = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  audio = u_audio;
  float time = t;
  bf_06(p3, time, audio);
}
