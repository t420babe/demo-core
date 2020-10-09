#ifndef T420BABE_AUDIO_CIRCLE
#define T420BABE_AUDIO_CIRCLE

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_CIRCLE
#include "./lib/pxl/circle-sdf.glsl"
#endif


// 7cc3f12, 20:58 concentric black white purple u_notch
void purple_concentric(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  color = vec3(pct * color + pct + color.gbr);
  float pct2 = sharp(circle_1(pos * 1.1, audio.notch + 0.1));
  color *= pct2;
}

// 5df41ce, 20:55 green concentric pulsating circles
void green_concentric(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  color = vec3(pct * color + pct + color.bgr);
  float pct2 = sharp(circle_1(pos * 1.1, audio.notch + 0.1));
  color -= pct2;
  // color = vec3(pct + color * pct2 + color.gbr);
}


// be8e320, main.frag
void purple_concetric(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 2.0, audio.notch));
  color = vec3(pct * color + pct + color.gbr);
}


// vec3 color = purple_circle(pos, u_time, audio);
void purple_circle(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.2, 0.243, 0.0234);

  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  color = vec3(pct * color + pct + color.gbr);
}

void purple_circle_oh_yes_he_is_mio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.2, 0.243, 0.0234);

  float pct = sharp(circle_1(pos * 1.1, audio.bandpass / 1.5));
  color = vec3(pct * color + pct + color.gbr);
}

// vec3 color = orange_circle_bright_purple_bg(pos, u_time, audio);
void orange_circle_bright_purple_bg(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.0, 0.0, 0.0);

  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  color = vec3(1.0, 0.5, pct);
}
#endif