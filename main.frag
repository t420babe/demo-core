#ifdef GL_ES
precision mediump float;
#endif

#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif


uniform float full_min;
uniform float full_ave;
uniform float full_max;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef UNIFORMS
#define UNIFORMS
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#endif

/* BEGIN */
// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com
#ifndef COMMON_COMMON
#include "./common/common.glsl"
#endif

#ifndef PXL
#include "./pxl/00-pxl.glsl"
#endif

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  // doppler_step_pink_yellow(pos, u_time, audio, color);
  // wood_bb_hexagon_0(pos, u_time, audio, color);
  // wood_bb_red_tan_noise(pos, u_time, audio, color);
  // wood_bb_red_noise(pos, u_time, audio, color);
  wbl_wood(pos, u_time, audio, color);
  gl_FragColor = vec4(color, 1.0);
}
