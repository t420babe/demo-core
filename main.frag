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

#ifndef T4B_ABP_06
#include "lib/t420babe/abp/abp-06.glsl"
#endif

#ifndef T4B_BF_06
#include "lib/t420babe/abg/bf-06.glsl"
#endif

#ifndef T4B_FRACTIONS_06
#include "lib/t420babe/abf/fractions-06.glsl"
#endif

void main(void) {
  // abp_06(p3, t, u_audio);
  // bf_06(p3, t, u_audio);
  fractions_06(p3, t, u_audio);
}
