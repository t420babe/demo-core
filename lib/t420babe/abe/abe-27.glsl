// Lonely by Rezz, The Riggs
#ifndef ABE_27
#define ABE_27

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

#ifndef COMMON_TIME_CONVERT
#include "./lib/common/time-convert.glsl"
#endif

// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3


float abe_27_map(vec3 pos, float time, peakamp audio){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 1.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = tan(length(pos) + 1.0);
  // float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5 * audio.notch * 2.0;
  return x0 *  x1 + x2 * 5.0;
}

void abe_27(vec3 p3, float time, peakamp audio) {
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
    float rz = abe_27_map(pos, time, audio);
    float dim = 1.0;
    // float f = clamp( ( rz - abe_27_map(pos * audio.notch * 3.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    float f;
    if (time < t2s(0.0, 1.0, 32.0)) {
      f = clamp( ( rz - abe_27_map(pos + 0.5, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    } else if (time > t2s(0.0, 1.0, 32.0) && time <= t2s(0.0, 1.0, 57.0)) {
      f = clamp( ( rz - abe_27_map(abs(sin(pos)) * audio.lowpass * 4.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    } else if (time > t2s(0.0, 1.0, 57.0) && time <= t2s(0.0, 2.0, 47.0)) {
      f = clamp( ( rz - abe_27_map(pos + 0.5, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    } else if (time > t2s(0.0, 2.0, 47.0) && time <= t2s(0.0, 3.0, 12.0)) {
      f = clamp( ( rz - abe_27_map(abs(sin(pos)) * audio.lowpass * 4.0, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    } else {
      f = clamp( ( rz - abe_27_map(pos + 0.5, wrap_time(time, 10.0), audio) ) * dim, 0.5, 5.0 );
    }

    float r_mul = 1.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    r_mul *= clamp(audio.bandpass, 0.5, 10.0);
    g_mul *= clamp(audio.bandpass, 0.5, 10.0);
    b_mul *= clamp(audio.notch, 0.5, 10.0);
    // vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.bandpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    vec3 l = vec3(0.35, 0.1, 0.3) + vec3(r_mul, g_mul, b_mul) * sin(f) * 2.0;
    color *= l * 1.5;
    // color += ( 1.0 - smoothstep(0.0, 0.1, rz * pos.x * pos.y) ) * 0.6 * l * abs(audio.notch);
    color += ( 1.0 - smoothstep(0.0, 0.1, rz * pos.x * pos.y) ) * 0.6 * l;
  }

  if (time < t2s(0.0, 1.0, 33.0)) {
  } else if (time > t2s(0.0, 1.0, 33.0) && time <= t2s(0.0, 1.0, 57.0)) {
    color.r += 2.0;
    color.b += 5.0;
    color.g += 25.0;
    color.r *= audio.lowpass * 2.0;
    color.g *= audio.highpass * 1.0;
    color.b *= audio.bandpass;

    color = rgb2hsv(color);
  } else if (time > t2s(0.0, 1.0, 57.0) && time <= t2s(0.0, 2.0, 47.0)) {
  } else if (time > t2s(0.0, 2.0, 57.0) && time <= t2s(0.0, 3.0, 12.0)) {
    color.r += 2.0;
    color.b += 5.0;
    color.g += 25.0;
    color.r *= audio.lowpass * 2.0;
    color.g *= audio.highpass * 1.0;
    color.b *= audio.bandpass;

    color = rgb2hsv(color);
  } else {
  }

  gl_FragColor = vec4(color, 1.0);
}
#endif

