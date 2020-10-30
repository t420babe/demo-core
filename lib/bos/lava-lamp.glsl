#ifndef BOS_LAVA_LAMP
#define BOS_LAVA_LAMP

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

float lava_lamp(vec2 pos, float u_time) {
  // vec3 color = vec3(0.0);
  vec2 pos_tmp = vec2(pos*3.);

  float DF = 0.0;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(pos_tmp+vel)*.25+.25;

  // Add a random position
  a = snoise(pos_tmp*vec2(cos(u_time*0.15),sin(u_time*0.1))*0.1)*3.1415;
  vel = vec2(cos(a),sin(a));
  DF += snoise(pos_tmp+vel)*.25+.25;

  return smoothstep(.7,.75,fract(DF));
}

void bos_lava_lamp(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  // vec3 color = vec3(0.0);
  vec2 pos_tmp = vec2(pos*3.);

  float DF = 0.0;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(pos_tmp+vel)*.25+.25;

  // Add a random position
  a = snoise(pos_tmp*vec2(cos(u_time*0.15),sin(u_time*0.1))*0.1)*3.1415;
  vel = vec2(cos(a),sin(a));
  DF += snoise(pos_tmp+vel)*.25+.25;

  color = vec3( smoothstep(.7,.75,fract(DF)) );

  color = 1.0 - color;
}
#endif
