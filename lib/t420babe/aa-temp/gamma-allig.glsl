#ifndef T420BABE_GAMMA_ALLIG
#define T420BABE_GAMMA_ALLIG

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef LRN_GAMMA_CORRECT
#include "./lib/lrn/gamma-correct.glsl"
#endif

#ifndef T420BABE_ALLIGATOR
#include "./lib/t420babe/ridge/alligator.glsl"
#endif

void gamma_allig(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 1.3;
  vec3 allig  = vec3(1.0);
  alligator(pos, u_time, audio, allig);

  float gamma = gamma_correct(2.3, pos.x) + gamma_correct(0.1, pos.x) * sin(u_time);
  float pct = plot(pos, gamma) * 5.0;
  color *= pct;
  color += allig;

  if (pos.y < gamma) {
    color = 1.0 - color;
  }

  if (pos.y > gamma) {
    color += allig;
    color = 0.1 + audio.notch - color;
  }
}

#endif
