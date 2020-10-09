#ifndef T420BABE_SAYIN_BANGERZ
#define T420BABE_SAYIN_BANGERZ

#ifndef PXL_RECT
#include "./lib/pxl/rect-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

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
