#ifndef T4B_ABK_00
#define T4B_ABK_00

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

void abk_00(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(0.5, 0.0, 1.0);
  color = flash_mul(color, time, 5.0 + abs(audio.highpass));
  pos = rotate2d(time * 5.0 * 10.0) * pos;
  float poly = sharp(polygon(pos, 5, 5.0 * audio.bandpass));
  color *= poly;

  gl_FragColor = vec4(color, 1.0);
}
#endif
