// #chill 
#ifndef T4B_ABH_37
#define T4B_ABH_37

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_BLOB
#include "lib/common/blob.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif
mat2 abh_37_rotate2d(float a){
  float c=cos(a), s=sin(a);
  return mat2(c,-s,s,c);
}

float abh_37_blob(vec3 p3, float time){
    p3.xz *= rotate2d(time * 0.4);
    p3.xy*= rotate2d(time * 0.3);
    vec3 q = p3 * 2.0 + time;
    float x0 = length( p3 + vec3( sin(time * 0.7) ) );
    float x1 = tan( length(p3) + 1.0 );
    float x2 = ( q.x + tan( q.z + length(q) ) ) * 0.5 - 1.0;
    return x0 * x1 + x2;
}


void abh_37(vec3 p3, float time, peakamp audio) {
  // audio.lowpass = 0.05;
  // audio.highpass = 0.05;
  // audio.bandpass = 0.05;
  // audio.notch = 0.05;
  // time += 50.0;
  vec3 color = vec3(1.0);
  p3.y *= 0.65;
  p3.xz *= rotate2d(time * 0.4);
  p3.xy *= rotate2d(time * 0.1);
  p3 *= 10.0;
  float y = (tan(p3.x) * cos(p3.x * time * 3.0));
  float m = plot(vec2(p3), y, 0.25) * 1.0;

  // p3.x -= 0.5;
  float rz = abh_37_blob(1.0 * p3, time);
  float f = ( rz / abh_37_blob(p3, y) ) * 10.0;
  vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.lowpass), abs(audio.bandpass), abs(audio.notch)) * f;
  // color = vec3(1.0 / m);
  color *= l;
  // color += (smoothstep(0.5, 0.5, rz) );


  color.r /= audio.notch;
  color.g /= audio.lowpass;
  color.b /= audio.highpass;

  // color.r /= 5.0;
  // color.g /= 5.0;
  // color.b /= 5.0;

  // color = rgb2hsv(1.0 - color.brg);
  // color = rgb2hsv(color.bgr);
  color = rgb2hsv(color.rbg);
  // color /= 10.0;
  color *= 2.0;
  // gl_FragColor = vec4( color.grb, 1.0);
  // gl_FragColor = vec4( 1.0 - rgb2hsv(color.rbg), 1.0);
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
