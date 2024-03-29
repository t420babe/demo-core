#ifndef PULSE_X_
#define PULSE_X_

#ifndef COMMON_LINES
#include "./lib/common/lines.glsl"     // create_line
#endif


// RR IDEAS: change pos*=0.050 to 0.010 and stuff
// try to get a slim x burned into retina then switch to zoomed in fat x
vec3 pulse_x(in vec2 pos, float u_time, float u_lp, float u_hp, float u_bp, float u_n) {
  pos *=0.050 * u_n;
  // pos *=0.010;
  // pos *=0.510;
  vec3 color = vec3(0.1);
  float pct = create_line(pos, u_n);
  // float pct = create_line(pos, 0.015);

  vec2 pos_1 = vec2(-pos.x, pos.y);
  pct += create_line(pos_1, u_n);
  pct = sharp(pct);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * u_n * 0.25;

  return color;
}

vec3 pink_red_x_max(in vec2 pos, float u_time, float u_lp, float u_hp, float u_bp, float u_n) {
  pos *=0.050 * u_n;
  // pos *=0.010;
  // pos *=0.510;
  vec3 color = vec3(0.1);
  float pct = create_line(pos, u_n);
  // float pct = create_line(pos, 0.015);

  vec2 pos_1 = vec2(-pos.x, pos.y);
  pct += create_line(pos_1, u_n);
  pct = sharp(pct);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * u_n * 0.25;

  return color;
}

#endif
