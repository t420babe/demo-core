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

void main() {
  vec3 color = vec3(1.0);
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  float rot_angle_rad = radians(mod(u_time * 25.0, 360.0));
  pos *= 1.8;
  pos.y -= 0.3;
  pos.x += 0.7;
  pos = rotate(pos, rot_angle_rad, 0.5);
  float wrap_time = abs(sin(u_time * 2.0));
  // float f = pos.y + wrap_time;
  // float f = sharp(elastic_in_out(pos.y), 1.0);
  float f = plot(pos, elastic_in_out(pos.y));
  if (mod(u_time, 0.5) < 0.25) {
    f = flip(f, radians(180.0));
  }
  color *= f * color - f * vec3(0.5235, 0.23451, 0.4348);

  gl_FragColor = vec4(color, 1.0);
}

