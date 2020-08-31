#ifndef T420BABE_DOPPLER
#define T420BABE_DOPPLER

#ifndef COMMON_COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void doppler(vec2 pos, float u_time, out vec3 color) {

  int color_idx = 1;

  // pos *= 50.0;
  // pos += 0.45;

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);

  if (color_idx == 0) {
    color = vec3(pct * color + color * pct2);
  } else if (color_idx == 1) {
    color = vec3(pct2 * color + color * vec3(0.5));
  } else if (color_idx == 2) {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  } else {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  }
}


// Moonlight by Gaulin 20 qmetro
void doppler_audio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  int color_idx = 0;

  pos *= 50.0 * audio.bandpass;
  pos += 0.45;

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);

  if (color_idx == 0) {
    color = vec3(pct * color + color * pct2 * audio.bandpass * 50.0);
  } else if (color_idx == 1) {
    color = vec3(pct2 * color + color * vec3(audio.bandpass * 50.0));
  } else if (color_idx == 2) {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(audio.bandpass * 10.0));
  } else {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  }
}


#endif
