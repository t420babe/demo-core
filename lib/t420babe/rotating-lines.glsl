#ifndef T420BABE_ROTATING_LINES
#define T420BABE_ROTATING_LINES

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif


vec3 rotating_lines(vec2 pos, float u_time, peakamp audio, vec3 color) {
  int idx_shader = 0;

  float rot_angle_rad = radians(mod(u_time * 25.0, 360.0));
  pos *= 1.8;
  pos.y -= 0.3;
  pos.x += 0.7;
  pos = rotate(pos, rot_angle_rad, 0.5);

  float wrap_time = abs(sin(u_time * 2.0));
  float f = 1.0;

  if (idx_shader == 0) {
    f = plot(pos, elastic_in_out(pos.y));
  } else if (idx_shader == 1) {
    f = pos.y + wrap_time;
  } else if (idx_shader == 2) {
    f = sharp(elastic_in_out(pos.y), 1.0);
  } else {
    f = plot(pos, elastic_in_out(pos.y));
  }

  // if (mod(u_time, 0.5) < 0.25) {
  // if (audio.highpass > 0.1) {
  if (audio.bandpass > 0.1) {
  // if (audio.lowpass < 0.1) {
    f = flip(f, radians(180.0));
  }

  color *= f * color - f * vec3(0.5235, 0.23451, 0.4348);

  return color;

}

void rotating_lines_pink(vec2 pos, float u_time, peakamp audio, out vec3 color) {


  float rot_angle_rad = radians(mod(u_time * 25.0, 360.0));
  pos *= 1.8;
  pos.y -= 0.3;
  pos.x += 0.7;
  pos = rotate(pos, rot_angle_rad, 0.5);
  float wrap_time = abs(sin(u_time * 2.0));
  // // float f = pos.y + wrap_time;
  // // float f = sharp(elastic_in_out(pos.y), 1.0);
  float f = plot(pos, elastic_in_out(pos.y));
  f = flip(f, radians(180.0));
  // color = f * color + f * vec3(0.23423, 0.25324, 0.89345);
  color = f * color + f * vec3(0.5235, 0.23451, 0.4348);

  // return color;

}

void rotating_lines_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {


  float rot_angle_rad = radians(mod(u_time * 25.0, 360.0));
  pos *= 1.8;
  pos.y -= 0.3;
  pos.x += 0.7;
  pos = rotate(pos, rot_angle_rad, 0.5);
  float wrap_time = abs(sin(u_time * 2.0));
  float f = pos.y + wrap_time;
  // float f = sharp(elastic_in_out(pos.y), 1.0);
  // float f = plot(pos, elastic_in_out(pos.y));
  f = flip(f, radians(180.0));
  // color = f * color + f * vec3(0.23423, 0.25324, 0.89345);
  color = f * color + f * vec3(0.5235, 0.23451, 0.4348);

  // return color;

}

void bouncing_line(vec2 pos, float u_time, peakamp audio, out vec3 color) {


  float rot_angle_rad = radians(mod(u_time * 25.0, 360.0));
  pos *= 1.8;
  pos.y -= 0.3;
  pos.x += 0.7;
  pos = rotate(pos, rot_angle_rad, 0.5);
  float wrap_time = abs(sin(u_time * 2.0));
  float f = pos.y + wrap_time;
  // float f = sharp(elastic_in_out(pos.y), 1.0);
  // float f = plot(pos, elastic_in_out(pos.y));
  f = flip(f, radians(180.0));
  // color = f * color + f * vec3(0.23423, 0.25324, 0.89345);
  color = f * color + f * vec3(0.5235, 0.23451, 0.4348);

  // return color;

}
#endif
