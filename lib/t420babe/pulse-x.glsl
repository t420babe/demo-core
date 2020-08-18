#ifndef PULSE_X
#define PULSE_X

#ifndef COMMON_PLOT
#include "../common/plot.glsl"
#endif

#ifndef COMMON_EASING_FUNCTIONS
#include "../common/easing-functions.glsl"
#endif

float create_line(vec2 pos, float full_ave) {
  float y = linear(pos.x);
  return plot(pos, y) * full_ave;
}

// RR IDEAS: change pos*=0.050 to 0.010 and stuff
// try to get a slim x burned into retina then switch to zoomed in fat x
vec3 pink_red_x(vec4 frag_coord, vec2 u_r, float u_t, float full_ave) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *=0.050;
  // pos *=0.010;
  vec3 color = vec3(0.1);
  float pct = create_line(pos, full_ave);

  vec2 pos_1 = vec2(-pos.x, pos.y);
  pct += create_line(pos_1, full_ave);
  pct = sharp(pct);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * full_ave * 0.25;

  return color;
}

#endif
