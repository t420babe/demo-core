/* Brother Louie - Imanbek */
/* target qmetro: 20 ms */

#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef T420BABE_WOOD_BROTHER_LOUIE_8
#include "./lib/t420babe/wood-bb/wood-brother-louie-8.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  wbl8_wood(pos, u_time, audio, color);

  gl_FragColor = vec4(color, 1.0);
}
