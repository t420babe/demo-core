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

#ifndef T4B_ABB_00
#include "lib/t420babe/abb/abb-00.glsl"
#endif


void main(void) {
  peakamp audio = u_audio;
  float audio_mul = 1.0;
  audio.notch *= audio_mul;
  audio.bandpass *= audio_mul;
  audio.highpass *= audio_mul;
  audio.lowpass *= audio_mul;
  // 82
  float time = t * 1.0 + 00.0;
  abb_00(p3, t, u_audio);
}
