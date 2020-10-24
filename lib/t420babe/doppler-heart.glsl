#ifndef T420BABE_SHARP_HEART
#define T420BABE_SHARP_HEART

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_HEART
#include "./lib/pxl/heart-sdf.glsl"
#endif

#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef COMMON_TRANSFORM
#include "./lib/common/transform.glsl"
#endif

#ifndef CLOUDS_BOS
#include "./lib/bos/clouds-bos.glsl"
#endif

#ifndef CLOUDS
#include "./lib/bos/clouds.glsl"
#endif

#ifndef PXL_SPIRAL
#include "./lib/pxl/spiral-sdf.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef PXL_TRIANGLE
#include "./lib/pxl/triangle-sdf.glsl"
#endif

// 9643dad, 20:38 heart
void doppler_sharp_heart_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.5;
  pos.y += 0.50;
  color = vec3(0.0, 0.1234, 0.34);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  float pct = heart_sdf(pos) * audio.notch;
  pct = sharp(pct);
  float pct2 = (hexagon_sdf(pos) / 1.0);
  color = vec3(pct * color + color.gbr * pct2);
  // color.r -= 0.4;
}

// 9643dad, 20:38 heart
void doppler_sharp_heart(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  pos.x += 0.5;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  vec2 rot_pos = rotate(pos * 2.5, 0.0, 0.0);
  float pct = heart_sdf(pos) * audio.notch;
  pct = sharp(pct);
  float pct2 = (hexagon_sdf(pos) / 1.0);
  color = vec3(pct * color + color.gbr * pct2);
  color.r -= 0.4;
}

void say_nothing_next_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  clouds(pos, u_time, audio, color);
  // float vesica_wrap = wrap_time(u_time, 100.0);
  float tri_wrap = 0.1;
  float tri = sharp(triangle_web_0(pos, audio, u_time * 0.1));
  color *= tri;

  // color.r /= audio.bandpass;
  color.g *= audio.lowpass * 1.0;
  color.b -= audio.highpass * 1.0;
  // color += heart_color;
  color /= audio.bandpass;
  color -= 0.5;
}

void say_nothing_next(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  clouds(pos, u_time, audio, color);
  // float vesica_wrap = wrap_time(u_time, 100.0);
  float tri_wrap = 1.5;
  float tri = (triangle_web_0(pos, audio, u_time * 0.1));
  color *= (tri);

  // color.r /= audio.bandpass;
  // color.b *= audio.lowpass * 1.0;
  color.b *= audio.highpass * 0.5;
  color.r /= abs(sin(u_time));
  // color += heart_color;
  color /= audio.bandpass * 1.0;
}

void say_nothing(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  clouds_bos(pos, u_time, audio, color);
  // float spiral_multiplier = wrap_time(u_time, 20.0);
  float spiral_multiplier = (u_time - 15.0)* 0.2;
  float spiral = spiral_pxl(pos, spiral_multiplier);
  color /= spiral;
  vec3 heart_color = vec3(1.0);

  doppler_sharp_heart(pos, u_time, audio, heart_color);
  color.r /= audio.bandpass;
  color.g *= audio.lowpass;
  color.b -= audio.highpass;
  color += heart_color;
  color -= 0.2;
}

void im_a_real_cunt_in_spring(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  clouds_bos(pos, u_time, audio, color);
  vec3 heart_color = vec3(1.0);
  doppler_sharp_heart(pos, u_time, audio, heart_color); 
  color += 0.2;
  color -= heart_color;
}
#endif
