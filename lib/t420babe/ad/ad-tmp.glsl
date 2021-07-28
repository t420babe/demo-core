#ifndef T4B_AC_02
#define T4B_AC_02

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL_PXL
#include "./lib/pxl/00-pxl.glsl"
#endif
/// DONT GO PAST HERE


// 88c657b, 20:07
void sayin_sayin_blue_wiggly_clock(vec2 pos, float u_time, peakamp audio, out vec3 color) {
}

// cc7109f, 20:05 blue thing
void sayin_sayin_dancing_blue_clock_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
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





#endif
