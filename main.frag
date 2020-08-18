#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;


void main() {
  vec3 color = vec3(0.2);

  gl_FragColor = vec4(color, 1.0);
}

