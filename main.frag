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
// #ifndef T4B_FRACTIONS_34
// #include "lib/t420babe/fractions/fractions-34.glsl"
// #endif

#ifndef T4B_FRACTIONS_35
#include "lib/t420babe/fractions/fractions-35.glsl"
#endif

#ifndef T4B_FRACTIONS_77
#include "lib/t420babe/fractions/fractions-77.glsl"
#endif

// #ifndef T4B_FRACTIONS_94
// #include "lib/t420babe/fractions/fractions-94.glsl"
// #endif



float plot(vec2 uv) {
  return smoothstep(0.02, 0.0, abs(uv.y - uv.x));
}

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  audio = u_audio;
  float time = t;
  vec3 color = vec3(1.0);
  // color.r *= audio.lowpass;
  // color.g *= audio.highpass;
  // color.b *= audio.notch;
  // fractions_34(p3, time, audio);
  // fractions_33(p3, time, audio);
  // fractions_35(p3, time, audio);
  fractions_77(p3, time, audio);
  // fractions_94(p3, time, audio);

  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
//
  // gl_FragColor = vec4(color, 1.0);;

}

