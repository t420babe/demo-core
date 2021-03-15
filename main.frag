// Tarengiri (Abgt438) by Sultan + Sheperd
#ifdef GL_ES
precision highp float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;
uniform float u_at;

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_TRANS
#include "./lib/common/trans.glsl"
#endif

#ifndef T420BABE_CHOICE_02
#include "./lib/t420babe/choice/choice-02.glsl"
#endif

#ifndef T420BABE_ADDICTED_00
#include "./lib/t420babe/addicted/addicted-00.glsl"
#endif

#ifndef T420BABE_ADDICTED_23
#include "./lib/t420babe/addicted/addicted-23.glsl"
#endif

#ifndef T420BABE_ADDICTED_29
#include "./lib/t420babe/addicted/addicted-29.glsl"
#endif

#ifndef COMMON_RGB_HSV
#include "./lib/common/rgb-hsv.glsl"
#endif

void main(void) {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  vec3 color = vec3(1.0);
  vec3 color_0 = vec3(1.0);
  vec3 color_1 = vec3(1.0);

  float t;
  t = wrap_time(u_at * 1.0, 1.0);

  color_0 = addicted_23(pos, u_at, audio, u_resolution);
  color_1 = addicted_29(pos, u_at, audio, u_resolution);
  color = mix(color_0, color_1, 0.5);
  color = rgb2hsv(1.0 - color_1);
  // color = color_1;

  // float g = abs(sin(u_time * 0.5));
  // color = vec3(0.0, g, 0.0);


  gl_FragColor = vec4(color, 1.0);
}

