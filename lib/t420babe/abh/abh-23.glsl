// #chill 
#ifndef T4B_BG_23
#define T4B_BG_23

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_BLOB
#include "lib/common/blob.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif
mat2 bg_23_rotate2d(float a){
  float c=cos(a), s=sin(a);
  return mat2(c,-s,s,c);
}

float bg_23_blob(vec3 p3, float time){
  p3 = p3.yxz;
  p3.xz *= rotate2d(time * 0.4);
  p3.xy *= rotate2d(time * 0.3);
  vec3 q = p3 * 2.0 + time;
  float x0 = length( asin(p3) + vec3( sin(time * 0.7) ) );
  float x1 = ( length(p3) + p3.x  * p3.y);
  float x2 = ( q.x + ( length(q) ) ) * 0.5 - 10.0;
  return x0 * x1 + x2;
}


void bg_23(vec3 p3, float time, peakamp audio) {
  // audio.lowpass = 0.05;
  // audio.highpass = 0.05;
  // audio.bandpass = 0.05;
  // audio.notch = 0.05;
  // time += 50.0;
  vec3 color = vec3(1.0);
  // p3.y *= 0.75;
  p3.xz *= rotate2d(time * 1.25);
  p3.xy *= rotate2d(time * 0.55);
  // p3 *= 200.0;
  p3 *= 1.5;
  float y = (sin(p3.x) * fract(p3.y * time * PI));
  float m = plot(vec2(p3), y, 0.15) * audio.notch * 2.0;

  // p3.x -= 0.5;
  float rz = bg_23_blob(p3, time);
  float f = ( rz * bg_23_blob(p3, y) ) * 1.0;
  vec3 l = vec3(1.0) + vec3(abs(audio.lowpass), abs(audio.bandpass), abs(audio.notch)) * rz;
  color = vec3(2.0 / m);
  color *= l;
  // color += (smoothstep(0.5, 0.5, rz) );


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
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor -= texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
