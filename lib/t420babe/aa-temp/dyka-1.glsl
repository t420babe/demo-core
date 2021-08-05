#ifndef T420BABE_DYKA_1
#define T420BABE_DYKA_1

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


vec3 my_mix(peakamp audio) {
  vec3 c1 = vec3(0.760704, 0.94902, 0.0);
  vec3 c0 = vec3(0.94902 ,0.0, 0.760704);
  float f = abs(audio.bandpass);
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}

void dyka_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = my_mix(audio);
  color = babydoyougetme_1(pos, u_time, audio);

  vec3 purp_circle =  vec3(0.0);
  vec2 rayz_position = pos * 1.0 * audio.notch;

  float rayz = rays_audio(rayz_position, 20, audio);
  color *= rayz;
  purple_circle_oh_yes_he_is_mio(pos, u_time, audio, purp_circle);
  color *= purp_circle;
}
#endif
