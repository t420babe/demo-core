#ifdef GL_ES
precision mediump float;
#endif

#ifndef ALBERS_IV_1
#include "lib/albers/iv-1.glsl"
#endif
// #define SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))
#define SHARP(f) smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f))

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

float rect(in vec2 pos, in vec2 size) {
  size = 0.25 - size * 0.25;
  vec2 uv = smoothstep(size, size + size * vec2(0.002), pos * (1.0 - pos));
  return uv.x * uv.y;
}

float my_rect(in vec2 pos, in vec2 size) {
  // vec2 sides = smoothstep(size, 2.0 * size, pos * (1.0 - pos));
  // sides = SHARP(sides);
  // return sides.x * sides.y;
  //
  // vec2 rect_sides = vec2(0.0, 0.0);
  // // rect_sides.x = step(size.x, pos.x * ((0.8 - u_resolution.x) / u_resolution.x - pos.x));
  // // rect_sides.y = step(size.y, pos.y * ((0.8 - u_resolution.x) / u_resolution.x - pos.y));
  // rect_sides.x = step(size.x, pos.x * (1.0 - pos.x));
  // rect_sides.y = step(size.y, pos.y * (1.0 - pos.y));
  // // float blx = step(0.1, pos.x * (1.0 - pos.x));       // bottom-left
  // // float bly = step(0.1, pos.y);       // bottom-left
  // return rect_sides.x * rect_sides.y;
  // return 1.0;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // vec2 pos = gl_FragCoord.xy / u_resolution.xy;
  // pos.y = 1.0 - pos.y;

  vec3 color = vec3(0.2);

  vec3 teal = vec3(0.188235, 0.545098, 0.68275);
  vec3 biege = vec3(0.584314, 0.447059, 0.305882);
  vec3 navy = vec3(0.023529, 0.117647, 0.356863);
  vec3 yellow = vec3(0.780392, 0.72549, 0.396078);
  vec3 orange = vec3(0.627451, 0.419608, 0.223529);

  color = mix(orange, yellow, step(-0.4, pos.y));     // Lower orange and middle lower yellow
  color = mix(color, navy, step(0.0, pos.y));         // Middle lower yellow and middle upper navy
  color = mix(color, teal, step(0.4, pos.y));         // Middle upper navy and upper teal

  // color = mix(color, biege, my_rect(vec2(pos - vec2(0.0, -0.4)) * vec2(1.0, 1.75), vec2(0.50, 0.50)));

  // vec2 bl = step(vec2(0.0), pos);       // bottom-left
  // float blx = step(0.1, pos.x);       // bottom-left
  // float bly = step(0.1, pos.y);       // bottom-left
  // vec3 biege_rect = vec3(my_rect(pos, vec2(0.1, 0.1)));
  // vec2 tr = step(vec2(-0.1),0.4-pos);   // top-right
  // color = vec3(bl.x * bl.y * tr.x * tr.y);
  // color = mix(color, biege, vec3(bl.x * bl.y));
  // color = mix(color, biege, vec3(blx * bly));

  gl_FragColor = vec4(color, 1.0);
}

