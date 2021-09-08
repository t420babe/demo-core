#ifndef T4B_BO_02
#define T4B_BO_02

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_BLOB
#include "lib/common/blob.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif
mat2 bo_02_rotate2d(float a){
  float c=cos(a), s=sin(a);
  return mat2(c,-s,s,c);
}

float bo_02_blob(vec3 p3, float time){
  p3 = p3.yxz;
  p3.xz *= rotate2d(time * 0.4);
  p3.xy *= rotate2d(time * 0.3);
  vec3 q = p3 * 2.0 + time;
  float x0 = length( sin(p3) + vec3( sin(time * 0.7) ) );
  float x1 = ( length(p3) + p3.x  * p3.y);
  float x2 = ( q.x + ( length(q) ) ) * 0.5 - 10.0;
  return x0 * x1 + x2;
}


void bo_02(vec3 p3, float time, peakamp audio) {
  time += 1000.0;
  vec3 color = vec3(1.0);
  // p3.y *= 0.30;
  p3.xz *= rotate2d(time * 0.5);
  p3.xy *= rotate2d(time * p3.x * 0.01);
  p3 *= 200.0;
  // float y = (tan(p3.x) * cos(p3.x * time * 3.0));
  float y = sin(time);

  float m = plot(vec2(p3), y, 0.25) * 1.0;

  // p3.x -= 0.5;
  float rz = bo_02_blob(p3, time);
  float f = ( rz * bo_02_blob(p3, y) ) * 1.0;
  vec3 l = vec3(0.0) + vec3(audio.lowpass, audio.bandpass, audio.notch) * rz * fract(f);
  // color = vec3(1.0 / m);
  color *= l;
  // color /= (smoothstep(0.5, 0.5, rz) );


  color.r *= audio.notch;
  color.g *= audio.lowpass;
  color.b *= audio.highpass;


  color = rgb2hsv(color);
  // color /= 10.0;
  // color *= 2.0;
  // color = color.bgr; gl_FragColor = vec4(color.gbr, 1.0);
  // color = color.bgr; gl_FragColor = vec4(color.bgr, 1.0);
  // color = color.bgr; gl_FragColor = vec4(color.rbg, 1.0);
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor -= texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
