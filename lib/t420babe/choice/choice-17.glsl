// Like I Don't Exist by Nicky Night Time
#ifndef T420BABE_CHOICE_17
#define T420BABE_CHOICE_17

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_RGB_HSV
#include "./lib/common/rgb-hsv.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3


float t2s(float hour, float min, float sec) {
  float s = sec;
  s += min * 60.0;
  s += hour * 60.0 * 60.0;

  return s;
}

float choice_17_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}


vec3 choice_17(vec2 pos, float time, peakamp audio) {
  // 365.0
  float start = t2s(0.0, 4.0, 20.0);
  time += start;

  float offset = 0.0;
  time += offset;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  float d = 5.0;

  for(int i = 0; i <= 5; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = choice_17_map(pos, time);
    float dim = 1.0;
    float f = clamp( ( rz - choice_17_map(pos + 0.5, wrap_time(time, 10.0)) ) * dim, 0.5, 5.0 );
    float r_mul = 1.0;
    float g_mul = 1.0;
    float b_mul = 1.0;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.lowpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.notch) * b_mul) * f;
    color *= l;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);
  }

    // color *= abs(sin(time));
      // color = rgb2hsv(color);
      // color.r *= 0.5;
      // color.b *= 1.5;
      // color.g *= 0.5;
    //
    // RR TODO: adjust l.r, don't multiply by lowpass maybe
    if (time - offset < t2s(0.0, 1.0, 35.0)) {
      // 0:00 - 1:35
      // NO CHANGE
    } else if (time - offset >= t2s(0.0, 1.0, 35.0) && time - offset < t2s(0.0, 2.0, 52.0)) {
      // X - 1:35 - 2:52, White pink purple
      color = color.gbr;
      color.r *= 0.7;
      color.r *= abs(sin(u_time));
      color.b *= 1.5;
      color.g *= 0.5;
    } else if (time - offset >= t2s(0.0, 2.0, 52.0) && time - offset < t2s(0.0, 3.0, 23.0)) {
      // 2:52 - 3:23, White pink purple
      color = sin(color) / 2.0;
      // color = color.bgr;
    } else if (time - offset >= t2s(0.0, 3.0, 23.0) && time - offset < t2s(0.0, 4.0, 24.0) + 0.3) {
      // X 3:23 - 3:51: 
      // Perfect motion drop
      color = sin(color) / 2.0;
      color = color.bgr;

      // 3:56
    } else if (time - offset >= t2s(0.0, 4.0, 25.0) + 0.3 && time - offset < t2s(0.0, 6.0, 26.0)) {
      // 4:24 - 6:26,  6:27 (660)
      // NO CHANGE
    } else if (time - offset >= t2s(0.0, 6.0, 26.0) && time - offset < 441.0) {
      // 6:26 - 7:21, White, lime green/yellow, lime green
      color = 2.0 - color;
      color.b *= 0.5;
      color.g *= 1.7;
    } else if (time - offset >= 441.0 && time - offset < 524.0) {
      // 7:21 - 8:24
    } else {
      // 8:24 - 9:24 (end) Blue, peach, red highlights/flashes
    }
      // color = color.gbr;
      // color = sin(color) / 2.0;
      // color.r *= 0.7;
      // color.b *= 1.5;
      // color.g *= 0.5;

      // color = sin(color) / 2.0;
      // color = color.bgr;

      // // White, cyan/purple, cyan - kinda flash heavy
      // color = color.gbr;
      // color.r *= 0.7;
      // color.r *= abs(sin(u_time));
      // color.b *= 1.5;
      // color.g *= 0.5;


      // color = color.gbr;
      // color.r *= 0.5;
      // color.b *= 1.5;
      // color.g *= 0.5;
    // white, start
      // color = color.gbr;
      // color.r *= 0.7;
      // color.r *= abs(sin(u_time));
      // color.b *= 1.5;
      // color.g *= 0.5;

      // White small pink ball, green flashes
      // color = color.gbr;
      // color = color.grb;
      // color = 0.8 - color;
      // color = rgb2hsv(color);
      // color.r *= 0.6;
      // color.b *= 1.8;
      // color.g *= 0.85;
      //
    // 3:23, 3:53, 4:24


    // 7:21


    // color = color.grb;
    // add slight color change (still white and black) around 1:50ish


  return color;
}
#endif

// 553 -> 3:54, roughlty maybe like 20s less in song
