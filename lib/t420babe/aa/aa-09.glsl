#ifndef T4B_AA_09
#define T4B_AA_09

#ifndef COMMON_TRANSFORM
#include "./lib/common/transform.glsl"
#endif

// Rainbow scales
vec3 aa_09_1(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  float speed = 0.5;
  float zoom = 4.0;
  pos *= zoom;

  float mod_time = mod(time, 400.0);
  vec2 movement = vec2(mod_time * 4.0, 500.0);

  for (int i = 1; i < 5; i++) {
    pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * pos.y + time / speed) + movement.x/ 20.0;
    pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * pos.x + time / speed) + movement.y / 10.0;
  }

  float g = cos(pos.x + pos.y + 1.0) * 0.5 + 0.5;
  float b = sin(pos.x + pos.y + 1.0) * 0.5 + 0.5;
  float r = (tan(pos.x + pos.y) + tan(pos.x + pos.y)) * 0.5 + 0.5;
  pos.y -= 0.5;

  vec3 color =  vec3(r, g, b);
  color = vec3(color.x * pos.y, color.x, color.x);
  return color;
}

void aa_09(vec3 p3, float time, peakamp audio) {
  vec3 color = aa_09_1(p3, time, audio);
  gl_FragColor = vec4(1.0 / color, 1.0);
  gl_FragColor +=texture2D(u_fb,vec2(abs(tan(p3.yx/(PI*0.60)+PI))+0.10)+vec2(0.001,0.001))-0.005;
}
#endif
