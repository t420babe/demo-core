#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef PXL_TRIANGLE
#include "./lib/pxl/triangle-sdf.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

#ifndef T420BABE_SHARP_HEART
#include "./lib/t420babe/doppler-heart.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// vec3 my_mix(peakamp audio) {
//   vec3 c1 = vec3(0.760704, 0.94902, 0.0);
//   vec3 c0 = vec3(0.94902 ,0.0, 0.760704);
//   float f = abs(audio.bandpass);
//   vec3 color = (1.0 - f) * c0 + f * c1;
//   return color;
// }

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.5);
  // color = alligator

  vec3 purp_color = vec3(0.0);
  // vec2 rayz_position = pos * 9.0 * audio.notch;
  //
  // float rayz = rays_audio(rayz_position, 60, audio);
  // color *= rayz;

  orange_circle_bright_purple_bg(pos, u_time, audio, purp_color);
  // purple_circle_fire(pos, u_time, audio, purp_color);
  // float my_hex = sharp(hexagon_web(pos));
  // float my_hex = sharp(hexagon_wood(pos, sin(u_time)));
  float my_hex = (wbl1_hexagon(pos, sin(u_time), audio));
  // float my_tri = triangle_1(pos);
  color /= my_hex;
  // color *= my_tri;
  color.r /= audio.lowpass * abs(sin(u_time));
  // color.r -= audio.bandpass * abs(cos(u_time));
  // color.g *= audio.highpass * abs(tan(u_time));
  // color.g *= audio.lowpass * abs(sin(u_time));
  // color += my_hex;
  // green_concentric(pos, u_time, audio, purp_color);
  // doppler_sharp_heart_0(pos, u_time, audio, color);
  color *= purp_color;
  gl_FragColor = vec4(color, 1.0);
}
