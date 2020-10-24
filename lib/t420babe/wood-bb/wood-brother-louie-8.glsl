// 8d6adf64, 00:11
#ifndef T420BABE_WOOD_BROTHER_LOUIE_8
#define T420BABE_WOOD_BROTHER_LOUIE_8

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif


mat2 wbl8_rotate2d(float theta) {
  return mat2(tan(theta), sin(theta), cos(theta), -sin(theta));
}

float wbl8_lines(in vec2 pos, float b){
  float scale = 10.0;
  pos *= scale;
  return smoothstep(0.0, 0.5 + b * 0.5, (((pos.y * 3.1415) * b * 2.0)) * 5.5);
}

// Ya know by Mat.Joe
void wbl8_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  vec2 pos2 = pos.yx * vec2(10.0 * fract(u_time), 10.0);

  float pattern = pos2.x;
  float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;

  // Add noise
  pos2 = wbl8_rotate2d( noise(pos2) ) * pos2;

  // Draw lines
  pattern = wbl8_lines(pos2, pos.y * pos.y);

  color = vec3(pattern);

  float size = 15.5;
  color *= SHARP(wbl1_hexagon(pos * audio_ave * 4.0, size, audio));

  if (audio.lowpass < 0.65) {
    color = vec3(0.8, color.g - 0.4, color.b - 0.1290384);
  }
  color.r *= audio.notch;
}

#endif
