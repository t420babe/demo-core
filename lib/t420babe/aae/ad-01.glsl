#ifndef T4B_AD_01
#define T4B_AD_01

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// Choose between 3 `shader_id`s and 2 `color_id`s
void ad_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos += 0.18;
  float pct = rays_sdf(pos, 3);
  color = pct * color.gbr + vec3(0.0, 0.4, 0.9) * pct;
  color.b = audio.highpass * 5.0;

  gl_FragColor = vec4(color, 1.0);
}
#endif

