#ifndef T420BABE_SAYIN_SAYIN
#define T420BABE_SAYIN_SAYIN

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL_PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// 671e2bc, 20:25 red yellow black weird shape 
void sayin_sayin_retro_vibez_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 20.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_line_retro_0(scale_pos, 1, sin(u_time));
  color *= sharp(pct);
}

// 57b7aae, 20:11 red and yellow
void sayin_sayin_red_line_zoom(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_line_zoom(scale_pos, 10, sin(u_time));
  color += sharp(pct);
}

// 57b7aae, 20:11 red and yellow
void sayin_sayin_red_kal_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(10.0 * audio.notch, 0.224, 0.34117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_kal(scale_pos, 20, sin(u_time));
  color += sharp(pct);
}

// 57b7aae, 20:11 red and yellow
void sayin_sayin_red_kal(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(10.0 * audio.notch, 0.224, 0.34117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_line_zoom(scale_pos, 20, sin(u_time));
  color += sharp(pct);
}

// 651292d, 20:08
void sayin_sayin_cyan_schnoodle(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_schnoodle(scale_pos, 10, sin(u_time));
	color = gradient_and_sharp_line(
      pos,
      pct,
      DEMO_EASE(audio.notch),
      vec3(0.234, 0.12309, 0.89724 * audio.notch),
      vec3(0.234 * audio.notch, 0.987, 0324)
      );

  color += sharp(pct);
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = sharp(circle_1(pos * 1.1, 10.0 * audio.notch));
  float pct2 = sharp(triangle_sdf(pos + 0.5));
  float pct3 = sharp(triangle_sdf(pos));
  float pct4 = sharp(triangle_sdf(vec2(pos.x + 0.5, pos.y)));
  color = vec3(pct2 * color - pct * color.gbr + 0.3 + pct3 * color + pct4 * color);
  // color = vec3(pct2 * color - pct * color.gbr + 0.3 + pct3 * color);
}


// 88c657b, 20:07
// Goodbye Fly - Joris Voorn
void sayin_sayin_blue_wiggly_clock_og_3(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  vec3 color_0 = vec3(0.234, 3.5 * audio.notch, audio.notch);
  vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  color = color_0;
  // vec3 color_0 = vec3(2.5 * audio.notch, 0.234, 1.5 * audio.notch);
  // vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  // color = color_0;
  // color.b *= audio.notch;
  // color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 4.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 4.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 4.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  color += tri_main;
  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
}

// 88c657b, 20:07
// Goodbye Fly - Joris Voorn
void sayin_sayin_blue_wiggly_clock_og_3f(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  vec3 color_0 = vec3(0.234, 3.5 * audio.notch, audio.notch);
  vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  color = color_0;
  // vec3 color_0 = vec3(2.5 * audio.notch, 0.234, 1.5 * audio.notch);
  // vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  // color = color_0;
  // color.b *= audio.notch;
  // color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
  color += tri_main;
  color *= color_1;
}

// 88c657b, 20:07
// Goodbye Fly - Joris Voorn
void sayin_sayin_blue_wiggly_clock_og_3e(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  vec3 color_0 = vec3(0.234, 3.5 * audio.notch, audio.notch);
  vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  color = color_0;
  // vec3 color_0 = vec3(2.5 * audio.notch, 0.234, 1.5 * audio.notch);
  // vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  // color = color_0;
  // color.b *= audio.notch;
  // color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  // color /= circ_right;
  // color /= circ_center;
  // color /= circ_left;
  color += tri_main;
  color *= color_1;
}

// 88c657b, 20:07
// Goodbye Fly - Joris Voorn
void sayin_sayin_blue_wiggly_clock_og_3d(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  vec3 color_0 = vec3(0.234, 3.5 * audio.notch, audio.notch);
  vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  color = color_0;
  // vec3 color_0 = vec3(2.5 * audio.notch, 0.234, 1.5 * audio.notch);
  // vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  // color = color_0;
  // color.b *= audio.notch;
  // color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
  color += tri_main;
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_3c(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  vec3 color_0 = vec3(0.234, 2.5 * audio.notch, 1.5 * audio.notch);
  vec3 color_1 = vec3(0.887, 1.5 * audio.highpass, 0.0);
  color = color_0;
  // color.b *= audio.notch;
  // color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
  color += tri_main;
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_3b(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  vec3 color_0 = vec3(0.234, 0.12309, 5.0 * audio.notch);
  vec3 color_1 = vec3(0.887, 5.0 * audio.highpass, 0.0);
  color = color_1;
  // color.b *= audio.notch;
  // color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
  color += tri_main;
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_3a(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) * audio.bandpass);

  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
  color += tri_main;
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_6(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_left = sharp(circle_1(vec2(pos.x + 0.05, pos.y) * 4.0, audio.notch / 2.0));
  float circ_right = sharp(circle_1((vec2(pos.x - 1.05, pos.y)) * 4.0, audio.notch / 2.0));
  float circ_center = sharp(circle_1((vec2(pos.x - 0.49, pos.y - 0.95)) * 4.0, audio.notch / 2.0));
  float tri_main = sharp(triangle_sdf(pos) / 10.0);

  color /= circ_right;
  color /= circ_center;
  color /= circ_left;
  color += tri_main;
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_5(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  color = vec3(0.0, audio.notch * 2.0, 0.84117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float circ_l = sharp(circle_1(pos * 4.0, audio.notch));
  float circ_r = sharp(circle_1((vec2(pos.x - 1.0, pos.y)) * 4.0, audio.notch));
  float circ_c = sharp(circle_1((vec2(pos.x - 0.5, pos.y - 0.5)) * 4.0, audio.notch));
  float pct2 = sharp(triangle_sdf(pos) * audio.bandpass);
  color *= circ_l;
  color *= circ_r;
  color *= circ_c;
  color += pct2 + color.gbr;
  // color = vec3(pct * color + pct2 + color.gbr);
  // color = vec3(pct * color + pct3 * color + pct4 * color + pct2);
  // color = vec3(pct * color + pct3 * color + pct4 * color);
  // color += pct2;
}

// // 88c657b, 20:07
// void sayin_sayin_blue_wiggly_clock_og_4(vec2 pos, float u_time, peakamp audio, out vec3 color) {
//   pos.x += 0.5;
//   pos.y += 0.5;
//   // pos /= 2.0;
//   color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
//   // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
//   float pct = sharp(circle_1(pos * 4.0, audio.bandpass));
//   float pct3 = sharp(circle_1((vec2(pos.x - 1.0, pos.y)) * 4.0, audio.bandpass));
//   float pct4 = sharp(circle_1((vec2(pos.x - 0.5, pos.y - 0.5)) * 4.0, audio.bandpass));
//   float pct2 = sharp(triangle_sdf(pos) / 15.0);
//   // color = vec3(pct * color + pct2 + color.gbr);
//   // color = vec3(pct * color + pct3 * color + pct2 + color.gbr);
//   color = vec3(pct * color + pct3 * color + pct4 * color + pct2 + color.gbr);
// }

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_4(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;

  // color = vec3(1.0, -abs(audio.notch), 0.14117647058);
  color = vec3(1.0, (audio.notch) + 0.00, 0.14117647058);
  float circle_multiplier = (audio.bandpass);
  // float circle_multiplier = (audio.bandpass) * 0.45;
  // float circle_multiplier = clamp(abs(audio.bandpass), 0.005, 2.0);
  float pct = sharp(circle_1(pos * 4.0, circle_multiplier));
  float pct3 = sharp(circle_1((vec2(pos.x - 1.0, pos.y)) * 4.0, circle_multiplier));
  float pct4 = sharp(circle_1((vec2(pos.x - 0.5, pos.y - 0.5)) * 4.0, circle_multiplier));
  float pct2 = sharp(triangle_sdf(pos) / 15.0);

  color = vec3(pct * color + pct3 * color + pct4 * color + pct2 + color.gbr);
}

/// DONT GO PAST HERE

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_8(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  // pos /= 2.0;
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float circle_multiplier = audio.bandpass;
  color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float pct = sharp(circle_1(pos * 4.0, circle_multiplier));
  float pct3 = sharp(circle_1((vec2(pos.x - 1.0, pos.y)) * 4.0, circle_multiplier));
  float pct4 = sharp(circle_1((vec2(pos.x - 0.5, pos.y - 0.5)) * 4.0, circle_multiplier));
  float pct2 = sharp(triangle_sdf(pos) / 15.0);

  color = vec3(pct * color + pct3 * color + pct4 * color + pct2 + color.gbr);
}


// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  // pos.y += 0.5;
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float pct = sharp(circle_1(pos * 4.0, audio.bandpass));
  float pct3 = sharp(circle_1((vec2(pos.x - 1.0, pos.y)) * 4.0, audio.bandpass));
  float pct4 = sharp(circle_1((vec2(pos.x - 0.5, pos.y - 0.2)) * 4.0, audio.bandpass));
  float pct2 = sharp(triangle_sdf(pos) / 10.0);
  // color = vec3(pct * color + pct2 + color.gbr);
  // color = vec3(pct * color + pct3 * color + pct2 + color.gbr);
  color = vec3(pct * color + pct3 * color + pct4 * color);
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  // color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float pct = sharp(circle_1(pos * 4.0, audio.bandpass));
  float pct2 = sharp(triangle_sdf(pos) / 10.0);
  color = vec3(pct * color + pct2 + color.gbr);
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  // color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  color = vec3(1.5 * audio.highpass, audio.notch * 0.5, 0.04117647058);
  float pct = sharp(circle_1(pos * 4.0, audio.bandpass));
  float pct2 = sharp(triangle_sdf(pos) / 10.0);
  color = vec3(pct * color + pct2 + color.gbr);
}

// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = sharp(circle_1(pos * 4.0, audio.bandpass));
  float pct2 = sharp(triangle_sdf(pos) / 10.0);
  color = vec3(pct * color + pct2 + color.gbr);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_clock_og_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_5(scale_pos, 10, audio.bandpass);
  vec3 color_0 = vec3(0.234, 0.12309, 5.0 * audio.notch);
  vec3 color_1 = vec3(0.887, 5.0 * audio.highpass, 0.0);
	color = gradient_and_sharp_line(pos, pct, (DEMO_EASE(audio.notch)), color_0, color_1);
	// color = gradient_and_sharp_line(pos, pct, log(DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color -= sharp(pct);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_clock_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_5(scale_pos, 10, sin(u_time));
	color = gradient_and_sharp_line(pos, pct, (DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
	// color = gradient_and_sharp_line(pos, pct, log(DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_clock_arrow_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  pct = sayin_sayin_star_4(scale_pos, 10, 5.0 * audio.bandpass);
  vec3 color_0 = vec3(0.234, 0.12309, 5.0 * audio.notch);
  vec3 color_1 = vec3(0.887, 5.0 * audio.highpass, 0.0);
	color = gradient_and_sharp_line(pos, pct, (DEMO_EASE(audio.notch)), color_0, color_1);
  color /= sharp(pct);
  // color -= 0.1;
  // color += audio.bandpass;
}

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_clock_arrow(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_4(scale_pos, 10, sin(u_time));
	color = gradient_and_sharp_line(pos, pct, (DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
	// color = gradient_and_sharp_line(pos, pct, log(DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_cyan_black_clock(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // color = vec3(1.0, audio.notch * 4.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_3(scale_pos, 10, sin(u_time));
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color *= sharp(pct);
  // color *= pct;
}


// cc7109f, 20:05 blue thing
void sayin_sayin_blue_clock(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_3(scale_pos, 10, sin(u_time));
	color = gradient_and_sharp_line(pos, pct, (DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
	// color = gradient_and_sharp_line(pos, pct, log(DEMO_EASE(audio.notch)), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}


// cc7109f, 20:05 blue thing
void sayin_sayin_dancing_blue_clock_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.0;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_2(scale_pos, 10, 0.5 * audio.bandpass);
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_dancing_blue_clock(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_2(scale_pos, 10, sin(u_time));
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}


// cc7109f, 20:05 blue thing
void sayin_sayin_blue_single_fracture_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.0;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, 6.0 * audio.bandpass);
  // vec3 color_0 = vec3(0.234, 0.12309, 0.89724 * audio.notch);
  // vec3 color_1 = vec3(0.234 * audio.notch, 0.987, 0.0);
  vec3 color_0 = vec3(0.234, 0.12309, 5.0 * audio.notch);
  vec3 color_1 = vec3(0.887, 5.0 * audio.highpass, 0.0);
  // color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), color_0, color_1);
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), color_1, color_0);
  color += sharp(pct);
}

// cc7109f, 20:05 blue thing
// favorite color combo
void sayin_sayin_blue_single_fracture_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos *= 5.0;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, 6.0 * audio.bandpass);
  // vec3 color_0 = vec3(0.234, 0.12309, 0.89724 * audio.notch);
  // vec3 color_1 = vec3(0.234 * audio.notch, 0.987, 0.0);
  vec3 color_0 = vec3(0.234, 0.12309, 5.0 * audio.notch);
  vec3 color_1 = vec3(0.887, 5.0 * audio.highpass, 0.0);
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), color_0, color_1);
  // color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), color_1, color_0);
  color += sharp(pct);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_single_fracture_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, 6.0 * audio.bandpass);
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_single_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, sin(u_time));
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}


// fe0bdc7, 19:59 yellow and red freaky star
void sayin_sayin_red_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct=0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = sayin_sayin_star_0(scale_pos, 10, sin(u_time));
  color += sharp(pct);
}

// fe0bdc7, 19:59 yellow and red freaky star
void sayin_sayin_single_red_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct=0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, sin(u_time));
  color += sharp(pct);
}

// d207143 idk something left over from yesterday that i dont want to deal with now
void sayin_sayin_break(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos += 0.18;
  float pct = rays_sdf(pos, 3);
  color = pct * color.gbr + vec3(0.0, 0.4, 0.9) * pct;
  color.b = audio.highpass * 5.0;

}

void sayin_sayin_red(vec2 pos, float u_time, peakamp audio, out vec3 color) {
	pos.x += 2.5;
	pos.y += 2.5;
	float pct = sin_in_out(rect_sdf(pos * audio.notch, vec2(0.5, 0.5)));
	color = pct * color.gbr + vec3(0.1, 0.4, 0.9) * pct;
	
  color.r = 1.0;
}

void sayin_sayin_deep_blue(vec2 pos, float u_time, peakamp audio, out vec3 color) {
	pos.x += 2.5;
	pos.y += 2.5;
	float pct = sin_in_out(rect_sdf(pos * audio.notch, vec2(0.5, 0.5)));
	color = pct * color.gbr + vec3(0.1, 0.4, 0.9) * pct;
}

void sayin_sayin(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 2.5;
  pos.y += 2.5;
  float pct = rect_sdf(pos * audio.notch * 1.7, vec2(0.5, 0.5));
  color = pct * color + vec3(0.1, 0.4, 0.9) * pct;
}

#endif
