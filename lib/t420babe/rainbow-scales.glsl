#ifndef T420BABE_RAINBOW_SCALES
#define T420BABE_RAINBOW_SCALES

#ifndef COMMON_MATRIX
#include "../../lib/common/matrix.glsl"
#endif

vec2 rainbow_position(vec2 pos, vec2 u_r, float u_t) {

    pos = (pos - 0.5) * 1.0011;
    pos *= 1.0;

    if (u_r.y > u_r.x) {
      pos.y *= u_r.y / u_r.x;
      pos.y -= (u_r.y * 0.5 - u_r.x * 0.5) / u_r.x;
    } else {
      pos.x *= u_r.x / u_r.y;
      pos.x -= (u_r.x * 0.5 - u_r.y * 0.5) / u_r.y;
    }
    pos = (pos - 0.5) * 1.1 + 2.0;
    pos = rotate(pos, u_t / 2.0, 0.5);

    return pos;
}

vec3 rainbow_scales(in vec2 pos, float u_t) {

  vec2 tmp_pos = pos;;
  float speed = 0.5;
  float zoom = 4.0;
  tmp_pos *= zoom;

  float mod_time = mod(u_t, 400.0);
  vec2 movement = vec2(mod_time * 4.0, 500.0);

  for (int i = 1; i < 5; i++) {
    tmp_pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.y + u_t / speed) + movement.x/ 20.0;
    tmp_pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.x + u_t / speed) + movement.y / 10.0;
  }

  float g = cos(tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  float b = sin(tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  float r = (tan(tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y)) * 0.5 + 0.5;

  return vec3(r, g, b);
}

vec3 rainbow_scales_1(vec2 pos, float u_t) {

  float speed = 0.5;
  float zoom = 4.0;
  pos *= zoom;

  float mod_time = mod(u_t, 400.0);
  vec2 movement = vec2(mod_time * 4.0, 500.0);

  for (int i = 1; i < 5; i++) {
    pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * pos.y + u_t / speed) + movement.x/ 20.0;
    pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * pos.x + u_t / speed) + movement.y / 10.0;
  }

  float g = cos(pos.x + pos.y + 1.0) * 0.5 + 0.5;
  float b = sin(pos.x + pos.y + 1.0) * 0.5 + 0.5;
  float r = (tan(pos.x + pos.y) + tan(pos.x + pos.y)) * 0.5 + 0.5;
  pos.y -= 0.5;

  vec3 color =  vec3(r, g, b);
  color = vec3(color.x * pos.y, color.x, color.x);
  return color;
}


vec3 rainbow_0(vec2 pos, vec2 u_r, float u_t, vec2 u_m) {
  pos = rainbow_position(pos, u_r, u_t);
  pos.y -= 0.5;
  vec3 color = rainbow_scales(pos, u_t);
  return vec3(color.x * pos.y, color.x, color.x);
}

vec3 rainbow_1(vec2 pos, vec2 u_r, float u_t, vec2 u_m) {
  pos = rainbow_position(pos, u_r, u_t);
  pos.y -= 0.5;
  vec3 color = rainbow_scales_1(pos, u_t);
  color =  vec3(color.x * pos.y, color.x, color.x);
  return vec3(color.x * pos.y, color.x, color.x);
}

// Clearer separation
vec3 rainbow_2(vec2 pos, vec2 u_r, float u_t, vec2 u_m) {
  pos = rainbow_position(pos, u_r, u_t);
  pos.y -= 0.5;
  vec3 color = rainbow_scales_1(pos, u_t);
  return vec3(color.x * pos.y, color.x, color.x);
}

// idk if i really want to keep this, not too much different
vec3 rainbow_3(vec2 pos, vec2 u_r, float u_t, vec2 u_m) {
  pos = rainbow_position(pos, u_r, u_t);
  pos.y -= 0.5;
  vec3 color = rainbow_scales(pos, u_t);
  color =  vec3(color.x * pos.y, color.x, color.x);
  return vec3(color.x * pos.y, color.x, color.x);
}
#endif
