#ifndef T420BABE_NYE_2021_26
#define T420BABE_NYE_2021_26

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_HILLS_VORTEX
#include "./lib/common/hills-vortex.glsl"
#endif

float nye_2021_26_vc_nyc(vec2 pos, float time, peakamp audio) {
  pos = abs(tan(fract(pos.yx) * abs(cos(pos.xy))));
  // pos  = pos.xx;
  pos.x += 5.0 * abs(tan(time * 0.5));
  pos.y -= 1.0 * abs(tan(time * 0.5));
  vec2 uv_int = hills_spherical_vortex(pos, time);
  float z = (5.0 * uv_int.x + 5.0 * uv_int.y);

  float time_wrap = wrap_time(time, 20.0);
  float d = abs(sin(z * 1.0));

  d = fract(d);
  d = atan(d);
  // return fract(d);
  return (d);
}

float nye_2021_26_shape(vec2 pos, float radius, float time, peakamp audio) {
  float r = length(pos / audio.highpass);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + abs(audio.notch);
  // float m = abs( mod( theta + time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float m = ( sin( theta + time * 2.0) - 1.14 );
  float f = radius;
  float f1 = radius;

  m += noise( pos + time * 0.1) * 0.5;
  f += noise(pos + time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = nye_2021_26_vc_nyc(pos, time, audio);

  return 1.0 - smoothstep(f1, f + 5.107, r) / fwidth(f1);
  // return 1.0 - sharp(smoothstep(f1, f + 1.007, r) );
}

float nye_2021_26_shape_border(vec2 pos, float radius, float width, float time, peakamp audio) {
  return nye_2021_26_shape(pos, radius - abs(audio.bandpass), time, audio) - nye_2021_26_shape(pos, radius - width + abs(audio.notch), time, audio);
}


vec3 nye_2021_26(vec2 pos, float time, peakamp audio) {
  // pos *= 2.0;
  vec2 st = pos;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.5;
  audio.highpass  *= 2.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 2.0;

  // nye_2021_26_shape_color_border(pos, 1.0, 0.10, time, audio, color);

  // Color 0
  // color.b += audio.lowpass * 2.0;
  // color *= nye_2021_26_shape_border(pos, 1.0, 0.50, time, audio);
  // color.b *= abs(audio.lowpass * 2.0);
  // color.g -= abs(audio.lowpass * 2.0);

  // color = color.bgr;
  //
  // Color 0
  // color.g += audio.lowpass * 2.0;
  color /= nye_2021_26_shape_border(pos * 2.8, 1.0, 3.10, time, audio);
  // color.b /= audio.lowpass * 1.0;
  color.b *= abs(audio.highpass) * 1.5;
  color.g /= abs(audio.notch) * 1.5;
  color.r += clamp(abs(audio.lowpass) * 1.5 - 0.29234, 0.2, 100.0);
  color = color.grb;
  color = color.rgb;

  color = 1.0 - color;

  return color;
}
#endif
