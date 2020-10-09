#ifndef T420BABE_SAYIN_DBH
#define T420BABE_SAYIN_DBH

#ifndef PXL_RECT
#include "./lib/pxl/rect-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
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

#endif
