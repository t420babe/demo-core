#ifndef GOON_0
#define GOON_0

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
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

void goon_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.0);
  // color = alligator

  vec3 purp_color = vec3(0.0);
  // vec2 rayz_position = pos * 9.0 * audio.notch;
  //
  // float rayz = rays_audio(rayz_position, 60, audio);
  // color *= rayz;

  // orange_circle_bright_purple_bg(pos, u_time, audio, color);
  // purple_circle_fire(pos, u_time, audio, purp_color);
  float my_hex = hexagon_web(pos);
  color += my_hex;
  // color.b *= audio.lowpass * 0.5;
  // color.b *= audio.lowpass * abs(sin(u_time));
  color.r -= audio.bandpass * abs(cos(u_time));
  // color.g *= audio.highpass * 0.5;
  color.g *= audio.highpass * abs(tan(u_time));
  // color.g *= audio.lowpass * abs(sin(u_time));
  // color += my_hex;
  green_concentric_0(pos, u_time, audio, purp_color);
  color *= purp_color;
  color.r += audio.bandpass;
}
#endif
