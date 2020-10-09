#ifndef T420BABE_CLOCK
#define T420BABE_CLOCK


#ifndef PXL_TRIANGLE
#include "./lib/pxl/triangle-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif


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


#endif
