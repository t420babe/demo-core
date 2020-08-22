#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#ifndef COMMON_COMMON
#include "lib/common/common.glsl"
#endif


float my_rect(in vec2 pos, in vec2 size) {
  vec2 sides = smoothstep(size, 2.0 * size, pos * (1.0 - pos));
  // sides = SHARP(sides);
  sides = sharp(sides);
  return sides.x * sides.y;

  vec2 rect_sides = vec2(0.0, 0.0);
  // rect_sides.x = step(size.x, pos.x * ((0.8 - u_resolution.x) / u_resolution.x - pos.x));
  // rect_sides.y = step(size.y, pos.y * ((0.8 - u_resolution.x) / u_resolution.x - pos.y));
  rect_sides.x = step(size.x, pos.x * (1.0 - pos.x));
  rect_sides.y = step(size.y, pos.y * (1.0 - pos.y));
  // float blx = step(0.1, pos.x * (1.0 - pos.x));       // bottom-left
  // float bly = step(0.1, pos.y);       // bottom-left
  return rect_sides.x * rect_sides.y;
  // return 1.0;
}
// // vec3 albers_iv_1() {
// // }
void main() {
  vec3 color = vec3(1.0);
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // color *= f * color - f * vec3(0.5235, 0.23451, 0.4348);

  gl_FragColor = vec4(color, 1.0);
}

