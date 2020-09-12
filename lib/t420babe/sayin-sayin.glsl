#ifndef T420BABE_SAYIN_SAYIN
#define T420BABE_SAYIN_SAYIN

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL_PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// 72dd371, 21:33 whoa digital black hole
void sayin_sayin_digital_black_hole(vec2 pos, float u_time, peakamp audio, out vec3 color) {
 color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
 pos /= 1.1;
 float pct = 0.0;
 vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
 float mod_time = mod(u_time, 10.0);
 pct = star(pos * 1.0, 5, tan(u_time));
 // color = gradient_and_sharp_line(pos, pct, DEMO_EASE(u_notch),
 vec3 color_a = vec3(0.234 * audio.notch, 0.987, 0324);
 color /= pct;
 float rect = rectangle(pos, vec2(0.0, 0.0), vec2(0.5));
 color = mix(color, color_a, rect);
}

// 5db8c15, 20:32 yeeessss cyan rectangle
// RR NOTE: change the tan around to different trig functions in pct, youll be happy you did
void sayin_sayin_sliding_in_cyan_square(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(pos * 1.0, 5, tan(u_time));
  vec3 color_a = vec3(0.234 * audio.notch, 0.987, 1.0);
  color /= sharp(pct);
  vec2 rect_center = vec2(0.0, 0.0);
  vec2 rect_sides = vec2(0.5, 0.5);
  float rect = rectangle(pos, rect_center, rect_sides);
  color = mix(color, color_a, rect);
  pct = star_sliding(pos, 5, tan(u_time));
  color /= sharp(pct);
}

// 5db8c15, 20:32 yeeessss cyan rectangle
void sayin_sayin_sliding_in_cyan_square_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(pos * 1.0, 5, tan(u_time));
  vec3 color_a = vec3(0.234 * audio.notch, 0.987, 1.0);
  color /= sharp(pct);
  vec2 rect_center = vec2(0.0, 0.0);
  float rect = rectangle(pos, rect_center, vec2(0.2));
  color = mix(color, color_a, rect);
  // pct = star_sliding(pos, 5, tan(u_time));
  // color /= sharp(pct);
}

// d5b0306, 20:28
void sayin_sayin_sliding_in(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 5.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  float mod_time = mod(u_time, 10.0);
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  pct = star_sliding(pos, 5, tan(u_time));
  color /= sharp(pct);
}

// 671e2bc, 20:25 red yellow black weird shape 
void sayin_sayin_sliding(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 5.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  float mod_time = mod(u_time, 10.0);
  pct = star_line_retro_0(pos, 1, tan(u_time));
  color /= sharp(pct);
}

// 671e2bc, 20:25 red yellow black weird shape 
void sayin_sayin_retro_vibez_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 7.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_line_zoom(scale_pos, 1, sin(u_time));
  color *= sharp(pct);
}

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
void sayin_sayin_blue_wiggly_clock_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  float pct2 = sharp(triangle_sdf(pos * 1.1 *  audio.notch));
  color = vec3(pct * color + pct2 + color.gbr);
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
void sayin_sayin_blue_clock_arrow(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
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
void sayin_sayin_blue_single_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
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
