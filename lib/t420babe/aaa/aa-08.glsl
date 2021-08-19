// #time
#ifndef T4B_AA_08
#define T4B_AA_08

#ifndef COMMON_TRANSFORM
#include "./lib/common/transform.glsl"
#endif

// Rainbow scales
vec3 aa_08_1(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec2 tmp_pos = pos;;
  float speed = 0.5;
  float zoom = 4.0;
  tmp_pos *= zoom;

  float mod_time = mod(time, 400.0);
  vec2 movement = vec2(mod_time * 4.0, 500.0);

  for (int i = 1; i < 5; i++) {
    tmp_pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.y + time / speed) + movement.x/ 20.0;
    tmp_pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.x + time / speed) + movement.y / 10.0;
  }

  vec3 color;
  color.r = tan(tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y);
  color.g = cos(tmp_pos.x + tmp_pos.y + 1.0);
  color.b = sin(tmp_pos.x + tmp_pos.y + 1.0);
  color.r = tan(tmp_pos.x);
  color.g = cos(tmp_pos.x);
  color.b = tan(tmp_pos.y);

  return color;
}

void aa_08(vec3 p3, float time, peakamp audio) {
  p3 *= time * 0.05;

  // p3 *= 5.5;
  vec3 color = aa_08_1(p3, time, audio);
  // gl_FragColor = vec4(color.rbg, 1.0);
  gl_FragColor = vec4(color.bgr, 1.0);
  gl_FragColor +=texture2D(u_fb,vec2(abs(tan(p3.yx/(PI*0.60)+PI))+0.10)+vec2(0.001,0.001))-0.005;
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.5, p3.y + 0.5));
  gl_FragColor -= texture2D(u_fb, vec2(p3.xy/2.0 + 0.5));
}
#endif
