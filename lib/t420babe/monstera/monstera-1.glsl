#ifndef T420BABE_MONSTERA_1
#define T420BABE_MONSTERA_1

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

#ifndef BOS_LAVA_LAMP
#include "./lib/bos/lava-lamp.glsl"
#endif

/* BEGIN T420BABE_AUDIO_CIRCLE */
#ifndef T420BABE_AUDIO_CIRCLE

/* BEGIN PXL_CIRCLE*/
#ifndef PXL_CIRCLE
float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}
#endif
/* END PXL_CIRCLE*/

void monstera_audio_circle(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float pct = sharp(circle_1(pos * 0.95, abs(audio.bandpass) * 1.0));
  color = vec3(1.0, pct * abs(sin(u_time)), 1.0);
}
#endif
/* BEGIN T420BABE_AUDIO_CIRCLE */

float monstera_hexagon(vec2 pos, float size, float u_time, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 5.0;
  hexagon = (max(abs(pos.y), pos.x * 0.9 + pos.y * (tan(u_time))));
  return hexagon;
}

void monstera_1(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float lava = lava_lamp(pos, u_time);
  color = vec3(0.4, 0.243, 0.7234);
  color -= vec3(lava); 

  vec3 orange_circle = vec3(1.0);
  monstera_audio_circle(pos, u_time, audio, orange_circle);
  color += orange_circle * audio.notch * 2.0;
  color.b /= (sharp(monstera_hexagon(pos, 10.0, u_time, audio)));
  color.b *= audio.notch;
}
#endif
