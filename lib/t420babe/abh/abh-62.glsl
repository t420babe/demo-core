// #chill 
#ifndef T4B_ABH_62
#define T4B_ABH_62

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_BLOB
#include "lib/common/blob.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

float abh_62_blob(vec3 p3, float time){
  p3 = p3.yxz * 0.8;
  p3.xz *= rotate2d(time * 0.4);
  p3.xy *= rotate2d(time * 0.3);
  vec3 q = p3 * 2.0;
  float x0 = length( acos(1.5 * p3) );
  float x1 = ( length(p3) + p3.x  * p3.y);
  float x2 = ( q.x + ( length(q) ) ) * 0.5 - 10.0;
  return x0 * x1 + x2;
}


void abh_62(vec3 p3, float time, peakamp audio) {
  // audio.lowpass = 0.05;
  // audio.highpass = 0.05;
  // audio.bandpass = 0.05;
  // audio.notch = 0.05;
  // time += 50.0;
  vec3 color = vec3(1.0);
  // p3.y *= 0.75;
  vec3 p3_tmp = p3;
  p3_tmp.xz *= rotate2d(time * 1.25);
  p3_tmp.xy *= rotate2d(time * 0.55);
  // p3 *= 200.0;
  // p3 *= 1.5;
  float y = (tan(p3.x) * cos(p3.x * time * 3.0)) * p3_tmp.x;
  float m = plot(vec2(p3), y, 0.25) * 1.0;

  // p3.x -= 0.5;
  float rz = abh_62_blob(p3, time);
  float rz_2 = abh_62_blob(p3 + vec3(0.5), time);
  float f = ( sin(p3.y* y) ) * 1.0;
  vec3 l = vec3(0.0) + vec3(abs(audio.lowpass), abs(audio.bandpass), abs(audio.notch)) * rz;
  vec3 l_2 = vec3(0.0) + vec3(abs(audio.lowpass), abs(audio.bandpass), abs(audio.notch)) * rz_2;
  color *= l;
  color /= l_2;
  color *= sin(fract(f));

  color.r *= audio.notch;
  color.g *= audio.lowpass;
  color.b *= audio.highpass;

  // color.r /= 5.0;
  // color.g /= 5.0;
  // color.b /= 5.0;

  // color = rgb2hsv(1.0 - color.brg);
  // color = rgb2hsv(color.bgr);
  color = rgb2hsv(color);
  // color = color.bgr;
  // color /= 10.0;
  // color *= 2.0;
  // gl_FragColor = vec4( 1.0 - color.grb, 1.0);
  // gl_FragColor = vec4( rgb2hsv(color.rbg), 1.0);
  gl_FragColor = vec4(color.brg, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  gl_FragColor -= texture2D(u_fb, vec2(vec2(p3.y, -p3.x)/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor -= texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
