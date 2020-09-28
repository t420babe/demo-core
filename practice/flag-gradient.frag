#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;


float rectangle(in vec2 pos, in vec2 size) {
  pos = pos * 2.0 - 1.0;
  return max(abs(pos.x / size.x), abs(pos.y / size.y));
  // size = 0.25 - size * 0.25;
  // vec2 position = smoothstep(size, size + size * vec2(0.002), pos * (1.0 - pos));
  // return position.x * position.y;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;

  vec3 color = vec3(0.2);
  vec3 teal = vec3(0.160784, 0.494118, 0.639216);
  vec3 navy = vec3(0.007843, 0.101961, 0.349020);
  vec3 yellow = vec3(0.768627, 0.745098, 0.415686);
  vec3 orange = vec3(0.674510, 0.458824,  0.254902);
  vec3 beige = vec3(0.572549, 0.435294, 0.294118);

  color = mix(orange, yellow, step(-0.4, pos.y));
  color = mix(color, navy, step(0.0, pos.y));
  color = mix(color, teal, step(0.4, pos.y));

  float rect = rectangle(pos, vec2(1.0, 0.1));
  color = mix(color, beige, rect);

  gl_FragColor = vec4(color, 1.0);
}

