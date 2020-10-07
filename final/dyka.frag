// Techno Prank - Dubdogz
#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

#ifndef PXL_RAYS
#include "./lib/pxl/rays-sdf.glsl"
#endif

#ifndef T420BABE_BABYDOYOUGETME
#include "./lib/t420babe/babydoyougetme.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec3 my_mix() {
  vec3 c1 = vec3(0.760704, 0.94902, 0.0);
  vec3 c0 = vec3(0.94902 ,0.0, 0.760704);
  float f = abs(u_bandpass);
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = my_mix();
  color = babydoyougetme_1(pos, u_time, audio);

  vec3 purp_circle =  vec3(0.0);
  vec2 rayz_position = pos * 9.0 * audio.notch;

  float rayz = rays_audio(rayz_position, 60, audio);
  color *= rayz;
  purple_circle_oh_yes_he_is_mio(pos, u_time, audio, purp_circle);
  color += purp_circle;

  gl_FragColor = vec4(color, 1.0);
}
