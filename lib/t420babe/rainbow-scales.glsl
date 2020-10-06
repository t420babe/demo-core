#ifndef T420BABE_RAINBOW_SCALES
#define T420BABE_RAINBOW_SCALES

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

vec2 rainbow_position(vec2 pos, vec2 u_resolution, float u_time) {

    pos = (pos - 0.5) * 1.0011;
    pos *= 1.0;

    if (u_resolution.y > u_resolution.x) {
      pos.y *= u_resolution.y / u_resolution.x;
      pos.y -= (u_resolution.y * 0.5 - u_resolution.x * 0.5) / u_resolution.x;
    } else {
      pos.x *= u_resolution.x / u_resolution.y;
      pos.x -= (u_resolution.x * 0.5 - u_resolution.y * 0.5) / u_resolution.y;
    }
    pos = (pos - 0.5) * 1.1 + 2.0;
    pos = rotate(pos, u_time / 2.0, 0.5);

    return pos;
}

vec3 rainbow_scales_hbg_is_mio(in vec2 pos, float u_time, peakamp audio) {

  vec2 tmp_pos = pos;
  float speed = 0.6;
  float zoom = 1.0;
  tmp_pos *= zoom;
  // tmp_pos.x += 0.1;
  // tmp_pos.y -= 0.3;
  tmp_pos.x -= 0.8;
  tmp_pos.y += 0.3;

  // float mod_time = mod(u_time, 400.0);
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

// vec3 rainbow_scales_hbg_is_mio(in vec2 pos, float u_time, peakamp audio) {
//
//   vec2 tmp_pos = pos;
//   float speed = 0.6;
//   // float zoom = 1000.0;
//   float zoom = 1.0;
//   tmp_pos *= zoom;
//   // tmp_pos.x += 0.1;
//   // tmp_pos.y -= 0.3;
//   tmp_pos.x -= 100.0;
//   tmp_pos.y += 0.3;
//
//   float mod_time = mod(u_time, 400.0);
//   vec2 movement = vec2(mod_time * 4.0, 500.0);
//   // vec2 movement = vec2(1.0);
//
//   for (int i = 1; i < 2; i++) {
//     tmp_pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.y / speed) + movement.x/ 20.0;
//     tmp_pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.x / speed) + movement.y / 10.0;
//   }
//
//   // float g = (tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
//   // float b = (tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
//   // float r = ((tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y)) * 0.5 + 0.5;
//
//   float g = (tmp_pos.x + tmp_pos.y + 1.0) * 1.5 * audio.bandpass;
//   float b = (tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
//   float r = ((tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y)) * 0.5 + 0.5;
//
//   return vec3(r, g, b);
// }

vec3 rainbow_scales(in vec2 pos, float u_time) {

  vec2 tmp_pos = pos;;
  float speed = 0.5;
  float zoom = 4.0;
  tmp_pos *= zoom;

  float mod_time = mod(u_time, 400.0);
  vec2 movement = vec2(mod_time * 4.0, 500.0);

  for (int i = 1; i < 5; i++) {
    tmp_pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.y + u_time / speed) + movement.x/ 20.0;
    tmp_pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * tmp_pos.x + u_time / speed) + movement.y / 10.0;
  }

  float g = cos(tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  float b = sin(tmp_pos.x + tmp_pos.y + 1.0) * 0.5 + 0.5;
  float r = (tan(tmp_pos.x + tmp_pos.y) + tan(tmp_pos.x + tmp_pos.y)) * 0.5 + 0.5;

  return vec3(r, g, b);
}

vec3 rainbow_scales_1(vec2 pos, float u_time) {

  float speed = 0.5;
  float zoom = 4.0;
  pos *= zoom;

  float mod_time = mod(u_time, 400.0);
  vec2 movement = vec2(mod_time * 4.0, 500.0);

  for (int i = 1; i < 5; i++) {
    pos.x += 0.003 / float(i) * tan(float(i) * 3.0 * pos.y + u_time / speed) + movement.x/ 20.0;
    pos.y += 0.003 / float(i) * tan(float(i) * 3.0 * pos.x + u_time / speed) + movement.y / 10.0;
  }

  float g = cos(pos.x + pos.y + 1.0) * 0.5 + 0.5;
  float b = sin(pos.x + pos.y + 1.0) * 0.5 + 0.5;
  float r = (tan(pos.x + pos.y) + tan(pos.x + pos.y)) * 0.5 + 0.5;
  pos.y -= 0.5;

  vec3 color =  vec3(r, g, b);
  color = vec3(color.x * pos.y, color.x, color.x);
  return color;
}


vec3 rainbow_0(vec2 pos, vec2 u_resolution, float u_time, vec2 u_mouse) {
  pos = rainbow_position(pos, u_resolution, u_time);
  pos.y -= 0.5;
  vec3 color = rainbow_scales(pos, u_time);
  return vec3(color.x * pos.y, color.x, color.x);
}

vec3 rainbow_1(vec2 pos, vec2 u_resolution, float u_time, vec2 u_mouse) {
  pos = rainbow_position(pos, u_resolution, u_time);
  pos.y -= 0.5;
  vec3 color = rainbow_scales_1(pos, u_time * 0.1);
  color =  vec3(color.x * pos.y, color.x, color.x);
  return vec3(color.x * pos.y, color.x, color.x);
}

vec3 rainbow_1a(vec2 pos, vec2 u_resolution, float u_time, vec2 u_mouse) {
  pos = rainbow_position(pos, u_resolution, u_time);
  pos.y -= 0.5;
  pos *= 0.09;
  pos.x = -pos.y;
  vec3 color = rainbow_scales_1(pos, u_time * 2.0);
  color =  vec3(color.x * pos.y, color.x, color.x);
  return vec3(color.x * pos.y, color.x, color.x);
}

// Clearer separation
vec3 rainbow_2(vec2 pos, vec2 u_resolution, float u_time, vec2 u_mouse) {
  pos = rainbow_position(pos, u_resolution, u_time);
  pos.y -= 0.5;
  vec3 color = rainbow_scales_1(pos, u_time);
  return vec3(color.x * pos.y, color.x, color.x);
}

// idk if i really want to keep this, not too much different
vec3 rainbow_3(vec2 pos, vec2 u_resolution, float u_time, vec2 u_mouse) {
  pos = rainbow_position(pos, u_resolution, u_time);
  pos.y -= 0.5;
  vec3 color = rainbow_scales(pos, u_time);
  color =  vec3(color.x * pos.y, color.x, color.x);
  return vec3(color.x * pos.y, color.x, color.x);
}
#endif
