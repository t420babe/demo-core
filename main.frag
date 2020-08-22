#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#ifndef ALBERS_IV_1
#include "lib/albers/iv-1.glsl"
#endif


float rectangle(in vec2 pos, in vec2 size) {
  size = 0.25 - size * 0.25;
  vec2 position = smoothstep(size, size + size * vec2(0.002), pos * (1.0 - pos));
  return position.x * position.y;
}

void main() {
  vec3 color = vec3(0.2);
  vec3 teal = vec3(0.160784, 0.494118, 0.639216);
  vec3 navy = vec3(0.007843, 0.101961, 0.349020);
  vec3 yellow = vec3(0.768627, 0.745098, 0.415686);
  vec3 orange = vec3(0.674510, 0.458824,  0.254902);
  vec3 beige = vec3(0.572549, 0.435294, 0.294118);

  color = mix(teal, navy, step(0.3, pos.y));




  gl_FragColor = vec4(color, 1.0);
}

