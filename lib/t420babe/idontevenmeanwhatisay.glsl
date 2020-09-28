#ifndef T420BABE_IDONTEVENMEANWHATISAY
#define T420BABE_IDONTEVENMEANWHATISAY
#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL_PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

const vec3 COLOR_A = vec3(0.149, 0.141, 0.912);
const vec3 COLOR_B = vec3(1.000, 0.833, 0.224);

vec3 current2(vec2 pos, float full_ave) {
  float f = exp_in(pos.x);
  float pct = plot(pos, f);
  vec3 color = pct * vec3(full_ave, 1.0, full_ave) + pct;
  return color;
}

vec3 current(vec2 pos) {
  float fx0 = ONE_MINUS_ABS_POW(pos.x, 0.5);
  float fx1 = ONE_MINUS_ABS_POW(pos.x, 0.5);
  // float f = aastep(pos.y, 0.5);
  float f = ONE_MINUS_POW_COS(pos.y, 0.5);
  f -= ONE_MINUS_ABS_POW(pos.x, full_ave);
  // pos.y = ONE_MINUS_POW_ABS_SIN(pos.y, u_time);

  float pct = plot(pos, f);
  // vec3 color = vec3(stroke(f, 0.5, 1.0), 0.5, 0.2);
  // vec3 color = vec3(raysSDF(pos, 4), 0.5, 0.2);
  vec3 color_a = vec3(0.234, 0.5345, 0.0984);
  vec3 color_b = vec3(0.534, 0.1345, 0.8984);
  return gradient_and_line(pos, fx0, fx1, color_b, COLOR_B);

  // return color;
}

// void main() {
//   vec2 pos = gl_FragCoord.xy / u_resolution.xy;
//   // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
//   vec3 color = vec3(0.2);
//
//   if (full_ave > 6.0) {
//     color = current2(pos) * full_ave;
//   } else {
//     color = current(pos);
//   }
//
//   gl_FragColor = vec4(color, 1.0);
// }

#endif
