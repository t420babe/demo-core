#ifndef ALBERS_IV_1
#define ALBERS_IV_1

#ifndef COMMON_SHAPES
#include "lib/common/shapes.glsl"
#endif

vec3 albers_iv_1(vec2 pos) {
  vec3 color = vec3(0.2);

  vec3 teal = vec3(0.188235, 0.545098, 0.68275);
  vec3 beige = vec3(0.584314, 0.447059, 0.305882);
  vec3 navy = vec3(0.023529, 0.117647, 0.356863);
  vec3 yellow = vec3(0.780392, 0.72549, 0.396078);
  vec3 orange = vec3(0.627451, 0.419608, 0.223529);

  color = mix(orange, yellow, step(-0.4, pos.y));     // Lower orange and middle lower yellow
  color = mix(color, navy, step(0.0, pos.y));         // Middle lower yellow and middle upper navy
  color = mix(color, teal, step(0.4, pos.y));         // Middle upper navy and upper teal

  float rect_upper = rectangle(pos, vec2(0.0, 0.5), vec2(0.2));
  color = mix(color, beige, rect_upper);

  float rect_lower = rectangle(pos, vec2(0.0, -0.5), vec2(0.2));
  color = mix(color, beige, rect_lower);

  return color;
}

// void main() {
//   vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
//
//   vec3 color = vec3(0.2);
//   color = albers_iv_1(pos);
//
//   gl_FragColor = vec4(color, 1.0);
// }

#endif
