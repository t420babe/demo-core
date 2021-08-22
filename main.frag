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

#ifndef T4B_BF
#include "lib/t420babe/bf/bf.glsl"
#endif

void main(void) {
  float time = t;
  peakamp audio = u_audio;
  float mul = 0.1;
  audio.notch *= mul;
  audio.highpass *= mul;
  audio.bandpass *= mul;
  audio.lowpass *= mul;
  // time = wrap_time(time, 30.0);
  // bf_16(p3, time, u_audio);
  // bf_17(p3, time, u_audio);
  // bf_18(p3, time, u_audio);
  // bf_32(p3, time, u_audio);
  // bf_31(p3, time, audio);
  // bf_28(p3, time, u_audio);
  // bf_11(p3, time, u_audio);  // // too bright for future ref
  // bf_26(p3, time, u_audio);
  // bf_12(p3, time, u_audio);
  //
  // // HALF
  //
  // bf_41(p3, time, u_audio);
  // bf_10(p3, time, u_audio);
  // bf_25(p3, time, u_audio);
  // bf_33(p3, time, u_audio);
  // bf_34(p3, time, u_audio);
  // bf_06(p3, time, u_audio);
  bf_04(p3, time, u_audio); // prob END here
  // bf_23(p3, time, u_audio); // for a BRIGHT finish maybe
}
