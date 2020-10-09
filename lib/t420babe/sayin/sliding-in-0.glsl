#ifndef T420BABE_SLIDING_IN_0
#define T420BABE_SLIDING_IN_0

#ifndef PXL_RECT
#include "./lib/pxl/rect-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

// d5b0306, 20:28
void sayin_sayin_sliding_in_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 5.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  float mod_time = mod(u_time, 10.0);
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  pct = star_sliding(pos, 5, audio.bandpass * 2.0);
  color /= sharp(pct);
}
#endif

