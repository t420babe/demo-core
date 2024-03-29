// Like I Don't Exist by Nicky Night Time
#ifndef ABE_10
#define ABE_10

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_TIME_CONVERT
#include "./lib/common/time-convert.glsl"
#endif

// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3


float abe_10_map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void abe_10(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  // 365.0
  // float start = t2s(0.0, 4.0, 20.0);
  float start = t2s(0.0, 0.0, 0.0);
  time += start;

  float offset = 0.0;
  time += offset;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  float d = 5.0;

  for(int i = 0; i <= 2; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = abe_10_map(pos, time);
    float dim = 1.0;
    float f = clamp( ( rz - abe_10_map(pos + 0.5, wrap_time(time, 10.0)) ) * dim, 0.5, 5.0 );
    float r_mul = 0.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.bandpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.bandpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.notch) * b_mul) * sin(f);
    color *= l;
    color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);
    // if (time - offset < t2s(0.0, 1.0, 35.0)) {
    // // no color change
    // }


    //
    // RR TODO: adjust l.r, don't multiply by lowpass maybe
    if (time - offset < t2s(0.0, 1.0, 35.0)) {
      // 0:00 - 1:35
      // White, blue, green
      color = color.gbr;
      color.r *= 0.5;
      color.b *= 1.5;
      color.g *= 0.5;
    } else if (time - offset >= t2s(0.0, 1.0, 35.0) && time - offset < t2s(0.0, 2.0, 52.0)) {
      // X - 1:35 - 2:52, White pink lime green
      color = color.bgr;
      color.r *= 0.5;
      color.b *= 1.5;
      color.g *= 0.5;
    } else if (time - offset >= t2s(0.0, 2.0, 52.0) && time - offset < t2s(0.0, 3.0, 23.0)) {
      // NEED TO COME BACK TO THIS ONE....
      // 2:52 - 3:23, White pink purple
      color = color.gbr;
      color = color.grb;
      color.r *= 0.6;
      color.b *= 1.8;
      color.g *= 0.85;

    } else if (time - offset >= t2s(0.0, 3.0, 23.0) && time - offset < t2s(0.0, 4.0, 24.0) + 0.3) {
      // X 3:23 - 3:51: Blue, red, soft yellow
      color.r *= 0.8;
      color.b *= 1.0;
      color.g *= 1.2;
      color = color.gbr;
      color = color.grb;
      color = 1.0 - color;

      // color = color.grb;
      color.r *= 1.0;
      color.b *= 0.2;
      color.g *= 1.5;

      // 3:56
    } else if (time - offset >= t2s(0.0, 4.0, 25.0) + 0.3 && time - offset < t2s(0.0, 6.0, 26.0)) {
      // 4:24 - 6:26,  6:27 (660)
      color = color.bgr;
      color.r *= 0.5;
      color.b *= 1.5;
      color.g *= 0.5;
    } else if (time - offset >= t2s(0.0, 6.0, 26.0) && time - offset < 441.0) {
      // 6:26 - 7:21, Red, soft yellow
      color = 2.0 - color;
      color.b *= 0.5;
      color.g *= 1.7;
    } else if (time - offset >= 441.0 && time - offset < 524.0) {
      // 7:21 - 8:24
      color = color.gbr;
      color.r *= 0.7;
      color.b *= 1.5;
      color.g *= 0.5;
    } else {
      // 8:24 - 9:24 (end) Blue, peach, red highlights/flashes
      color.r *= 1.0;
      color.b *= 0.5;
      color.g *= 1.2;
      color = color.gbr;
      color = color.grb;
      color = 1.0 - color;

    }

    // 6:26 no color changes


    // white, start 
      // color = color.gbr;
      // color.r *= 0.7;
      // color.b *= 1.5;
      // color.g *= 0.5;

      // // White small pink ball, green flashes
      // color = color.gbr;
      // color = color.grb;
      // color.r *= 0.6;
      // color.b *= 1.8;
      // color.g *= 0.85;
      //
    // 3:23, 3:53, 4:24


    // 7:21


    // color = color.grb;
    // add slight color change (still white and black) around 1:50ish


  }
gl_FragColor = vec4(color, 1.0);
}
// 553 -> 3:54, roughlty maybe like 20s less in song
#endif
