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

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

//
// float rect(in vec2 pos, in vec2 origin, in vec2 side_len) {
//   // Center  to lower left
//   vec2 on_block = vec2(origin - size);    // (0.0, 0.6) -> (-0.2, 0.4)
//   vec2 cut_block = vec2(
// }


float my_rect(in vec2 pos, in vec2 size) {
  vec2 on_block = step(size, pos);
  // vec2 cut_block = step(vec2(0.2), pos * (1.0 - pos));
  vec2 cut_block = step(vec2(0.9, 0.4), (1.0 - pos));
  return on_block.x * on_block.y * cut_block.x * cut_block.y;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // vec2 pos = gl_FragCoord.xy / u_resolution.xy;
  // pos.y = 1.0 - pos.y;

  vec3 color = vec3(0.2);

  vec3 teal = vec3(0.188235, 0.545098, 0.68275);
  vec3 beige = vec3(0.584314, 0.447059, 0.305882);
  vec3 navy = vec3(0.023529, 0.117647, 0.356863);
  vec3 yellow = vec3(0.780392, 0.72549, 0.396078);
  vec3 orange = vec3(0.627451, 0.419608, 0.223529);

  color = mix(orange * u_bandpass, yellow * u_notch, step(-0.4, pos.y));     // Lower orange and middle lower yellow
  color = mix(color, navy * u_highpass, step(0.0, pos.y));         // Middle lower yellow and middle upper navy
  color = mix(color, teal * u_lowpass, step(0.4, pos.y));         // Middle upper navy and upper teal


  // vec2 size = vec2(-0.1, 0.4);   // lower left corner
  // float r = my_rect(pos, size);
  // color = mix(color, beige, r);

  // color = mix(color, beige, step(0.5, pos.x) * (1.0 - step(0.5, pos.y)));
  // color = mix(color, beige, my_rect(pos, vec2(0.1, 0.15)));

  // vec2 bl = step(vec2(-0.3), pos);       // bottom-left
  // float blx = step(0.1, pos.x);       // bottom-left
  // float bly = step(0.1, pos.y);       // bottom-left
  // vec3 beige_rect = vec3(my_rect(pos, vec2(0.1, 0.1)));
  // vec2 tr = step(vec2(0.2), 0.0 - pos );   // top-right
  // color = vec3(bl.x * bl.y * tr.x * tr.y);
  // color = vec3(bl.x * bl.y);
  // color = mix(color, beige, vec3(bl.x * bl.y));
  // color = mix(color, beige, vec3(blx * bly));

  gl_FragColor = vec4(color, 1.0);
}

