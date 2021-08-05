#ifndef T420BABE_WOOD_BROTHER_LOUIE
#define T420BABE_WOOD_BROTHER_LOUIE
// 2226a23, 23:42 hex rect wood bb
#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL_HEXAGON
#include "lib/pxl/hex-sdf.glsl"
#endif

float wbl_random (in vec2 pos) {
  return fract(sin(dot(pos.xy,
          vec2(12.9898,78.233)))
      * 43758.5453123);
}

// Value noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/lsf3WH
float wbl_noise(vec2 pos, float u_time) {
  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f*f*(3.0-2.0*f);
  return mix( mix( wbl_random( i + vec2(0.0,0.0) ),
        wbl_random( i + vec2(1.0,0.0) ), u.x),
      mix( wbl_random( i + vec2(0.0,1.0) ),
        wbl_random( i + vec2(1.0,1.0) ), u.x), u.y);
}

mat2 wbl_rotate2d(float angle){
  return mat2(cos(angle),-sin(angle),
      sin(angle),cos(angle));
}

float wbl_lines(in vec2 pos, float b){
  float scale = 10.0;
  pos *= scale;
  return smoothstep(0.0,
      .5+b*.5,
      abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

// vec3 wbl_wood(vec4 frag_coord, vec2 u_r, float u_t, float full_ave, float full_max) {
void wbl_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  vec2 pos2 = pos.yx*vec2(10. * tan(u_time),10. * fract(u_time));

  float pattern = pos2.x;

  float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;
  // Add noise
  pos2 = wbl_rotate2d( noise(pos2, u_time) ) * pos2;

  // Draw lines
  pattern = wbl_lines(pos2,0.1);

  color = vec3(pattern);
  // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);

  float size = 5.5;
  color += SHARP(wbl_hexagon(pos * audio_ave * 4.0, size, audio));
  // color += SHARP(wbl_hexagon(pos * full_ave * 0.5, size, audio, full_max));
  // color += SHARP(wbl_hexagon(pos * rotate2d(full_ave * 0.1), full_ave, audio));

  // if (full_max > 50.0  && full_max < 70.0) {
  // if (full_max > 10.0) {
  if (audio.lowpass < 0.65) {
    // color = vec3(0.8, color.g + exp_out(full_max) - 0.7, color.b + 0.4);
    color = vec3(0.8, color.g + exp_out(audio.lowpass * 40.0) - 0.7, color.b + 0.4);
  }
}


// void wbl_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {
// // void wbl_wood(vec2 pos, float u_time, peakamp audio, out vec3 color) {
//   pos = square_position(pos);
//   // float full_ave = audio.notch * 200.0;
//   // float full_max = audio.bandpass * 200.0;
//
//   vec2 pos2 = pos.yx*vec2(10. * tan(u_time),10. * fract(u_time));
//
//   float pattern = pos2.x;
//
//   float audio_ave = (audio.notch + audio.highpass + audio.lowpass + audio.bandpass) / 4.0;
//   // Add noise
//   pos2 = wbl_rotate2d( noise(pos2, u_time) ) * pos2;
//
//   // Draw lines
//   pattern = wbl_lines(pos2,0.1);
//
//   color = vec3(pattern);
//   // return  vec3(color.x + sin(u_time) * 1.1, 0.9, color.x - 0.1);
//
//   float size = 5.5;
//   color += SHARP(wbl_hexagon(pos * audio_ave * 2.0, size, audio, full_max));
//   // color += SHARP(wbl_hexagon(pos * full_ave * 0.5, size, audio, full_max));
//   // color += SHARP(wbl_hexagon(pos * rotate2d(full_ave * 0.1), full_ave, audio));
//
//   // if (full_max > 50.0  && full_max < 70.0) {
//   // if (full_max > 10.0) {
//   if (audio.lowpass < 1.6) {
//     // color = vec3(0.8, color.g + exp_out(full_max) - 0.7, color.b + 0.4);
//     color = vec3(0.8, color.g + exp_out(audio.lowpass * 20.0) - 0.7, color.b + 0.4);
//   }
// }
//
#endif
