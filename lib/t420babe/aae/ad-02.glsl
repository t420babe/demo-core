#ifndef T4B_AD_02
#define T4B_AD_02

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// Choose between 3 `shader_id`s and 2 `color_id`s
void ac_02(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos *= 5.0;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(time, 10.0);
  pct = sayin_sayin_star_2(scale_pos, 10, 0.5 * audio.bandpass);
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0224));
  color += sharp(pct);

  gl_FragColor = vec4(color, 1.0);
}
#endif

