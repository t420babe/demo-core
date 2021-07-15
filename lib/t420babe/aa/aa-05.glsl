#ifndef T4B_AA_05
#define T4B_AA_05

#ifndef COMMON_TRANSFORM
#include "./lib/common/transform.glsl"
#endif

vec3 aa_05_1(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;

  vec2 tmp_pos = pos;
  float speed = 0.6;
  float zoom = 1.0;
  tmp_pos *= zoom;
  // tmp_pos.x += 0.1;
  // tmp_pos.y -= 0.3;
  tmp_pos.x -= 0.8;
  tmp_pos.y += 0.3;

  // float mod_time = mod(time, 400.0);
  // vec2 movement = vec2(mod_time * 4.0, 500.0);
  vec2 movement = vec2(1.0);

  for (int i = 1; i < 2; i++) {
    tmp_pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.y / speed) + movement.x/ 20.0;
    tmp_pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.x / speed) + movement.y / 10.0;
  }

  // float g = (tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  // float b = (tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  // float r = ((tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y)) * 0.5 + 0.5;

  float g = (tmp_pos.x + tmp_pos.y + 1.0) * 1.5 * audio.bandpass;
  float b = (tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  float r = ((tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y)) * 0.5 + 0.5;

  return vec3(r, g, b);
}

void aa_05(vec3 p3, float time, peakamp audio) {
  vec3 color = aa_05_1(p3, time, audio);
  gl_FragColor = vec4(color, 1.0);
}
#endif
