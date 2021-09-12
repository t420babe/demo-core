// The Way Back by Solumun
#ifndef T4B_ABH_68
#define T4B_ABH_68

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_BLOB
#include "lib/common/blob.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif
mat2 abh_68_blob_m(float a){
  float c=cos(a), s=sin(a);
  return mat2(c,-s,s,c);
}

float abh_68_blob(vec3 p3, float time){
    p3.xz *= abh_68_blob_m(time * 0.4);
    p3.xy*= abh_68_blob_m(time * 0.3);
    vec3 q = p3 * 2.0 + time;
    float x0 = length( p3 + vec3( sin(time * 0.7) ) );
    float x1 = log( length(p3) + 1.0 );
    float x2 = cos( q.x + tan( q.z + sin(q.y) ) ) * 0.5 - 0.0;
    return x0 * x1 + x2;
}


void abh_68(vec3 p3, float time, peakamp audio) {
  float audio_mul = 1.0;
  audio.lowpass = audio_mul;
  audio.highpass = audio_mul;
  audio.bandpass = audio_mul;
  audio.notch = audio_mul;

  time *= 1.1;
  vec3 color = vec3(1.0);
  p3 *= 1.5;
  float y = (tan(p3.x) * cos(p3.x * time * 3.0));
  // float m = plot(vec2(p3), y, 0.25) * 1.0;

  // p3.x -= 0.5;
  float rz = abh_68_blob(1.0 * p3, time);
  float f = ( rz / abh_68_blob(p3, y) ) * 10.0;
  // color = (m) * color * m * vec3(1.0);
  vec3 l = vec3(0.35, 0.1, 0.3) + vec3(abs(audio.lowpass), abs(audio.bandpass), abs(audio.notch)) * f;
  color = l;
  // color += (smoothstep(0.5, 0.5, rz) );

  color.r *= audio.notch;
  color.g *= audio.lowpass;
  color.b *= audio.highpass;
  // color.b /= audio.bandpass;

  color.r *= 1.2;
  color.g *= 1.8;
  color.b *= 1.8;

  // color.r /= 2.5;
  // color.g /= 2.5;
  // color.b /= 2.5;


  gl_FragColor = vec4( 1.0 - color.grb, 1.0);
  // gl_FragColor = vec4( 1.0 / color.rbg, 1.0);
  // gl_FragColor = vec4( 1.0 / color.brg, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
