#ifndef T420BABE_BLUE_WIGGLY_CLOCK_OG_3
#define T420BABE_BLUE_WIGGLY_CLOCK_OG_3

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

#ifndef PXL_CIRCLE
#include "./lib/pxl/circle-sdf.glsl"
#endif

#ifndef PXL_TRIANGLE
#include "./lib/pxl/triangle-sdf.glsl"
#endif

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
void sayin_sayin_blue_wiggly_clock_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  pos.x += 0.5;
  pos.y += 0.5;
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = sharp(circle_1(pos * 4.0, audio.bandpass));
  float pct2 = sharp(triangle_sdf(pos) / 10.0);
  color = vec3(pct * color + pct2 + color.gbr);
}
#endif
