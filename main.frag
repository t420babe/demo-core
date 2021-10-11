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

#ifndef COMMON_SIGNAL
#include "lib/common/signal.glsl"
#endif

#ifndef T4B_ABA_44
#include "lib/t420babe/aba/aba-44.glsl"
#endif


void main(void) {
  peakamp audio = u_audio;
  float time = t;
  aba_44(p3, time, audio);
  // plot_signal(p3.xy, audio);
}
