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

// 5df41ce, 20:55 green concentric pulsating circles
void green_concentric_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // color = vec3(0.9, 0.643, 0.0234);
  color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 2.0, audio.notch));
  color = vec3(pct * color + pct + color.bgr);
  float pct2 = sharp(circle_1(pos * 1.0, audio.notch + 0.1));
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
void purple_circle_fire(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.2, 0.243, 0.0234);

  float grow = u_time *0.0005;
  float pct = sharp(circle_1(pos * 1.1, audio.notch * grow));
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
void orange_circle_bright_purple_bg_2(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // color = vec3(1.3, 0.8, 1.1);
  // color = vec3(0.4, 0.243, 0.7234);

  float pct = sharp(circle_1(pos * 0.95, abs(audio.bandpass) * 1.0));
  // float pct = sharp(circle_1(pos * 0.95, abs(audio.lowpass) * 0.5));
  // color = vec3(1.0, 1.0, pct * abs(sin(u_time)));
  color = vec3(1.0, pct * abs(sin(u_time)), 1.0);
}

// vec3 color = orange_circle_bright_purple_bg(pos, u_time, audio);
void orange_circle_bright_purple_bg(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.0, 0.0, 0.0);

  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  color = vec3(1.0, 0.5, pct);
}

void orange_circle_bright_purple_bg_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.0, 0.0, 0.0);

  float pct = (circle_1(pos * 3.0, audio.notch));
  color = vec3(1.0, pct, 0.9);
}
#endif
