#ifndef T420BABE_PURPLE_CIRCLE
#define T420BABE_PURPLE_CIRCLE

#ifndef COMMON
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_TRIANGLE
#include "./lib/pxl/triangle-sdf.glsl"
#endif

#ifndef PXL_CIRLCE
#include "./lib/pxl/circle-sdf.glsl"
#endif

vec3 purple_circle(vec2 pos, float u_lowpass, float u_highpass, float u_bandpass, float u_notch) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2, 0.243, 0.0234);

  float pct = sharp(circle_1(pos * 1.1, u_notch));
  color = vec3(pct * color + pct + color.gbr);

  return color;
}

// void main() {
//   vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
//   vec3 color = vec3(0.2, 0.243, 0.0234);
//
//   // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
//   float pct = sharp(circle_1(pos * 1.1, u_notch));
//   float pct2 = sharp(triangle_sdf(pos * 1.1* u_notch));
//   color = vec3(pct * color + pct + color.gbr);
//   // color = vec3(pct + color * pct2 + color.gbr);
//   // int num_vesicas = 4.0;
//   // for (int i = 0; i < num_vesicas; i++) {
//   //   pct = sharp(vesica_sdf(pos * 1.1, u_notch));
//   //   color = vec3(pct * color + pct * color);
//   // }
//
//   gl_FragColor = vec4(color, 1.0);
// }
//
//   // autocmd BufWritePost * execute '!git add % && git commit -m %'
//
#endif
