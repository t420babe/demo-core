// #chill 
#ifndef T4B_ABH_43
#define T4B_ABH_43

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

float abh_43_map(vec3 p3, float time){
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.1);
  vec3 q = p3 * 2.0;
  // float x0 = length( p3 + vec3( sin(time * 0.7) ) );
  float x0 = length( p3 + vec3( sin(time * 0.7) ) );
  float x1 = (length(p3) + 1.0);
  float x2 = sin(q.x + (q.x * sin(q.y) ) ) * 1.5;
  return x0 *  x1 + x2 * 5.0;
}

void abh_43(vec3 p3, float time, peakamp audio) {
  // time += 100.0;
  vec3 color = vec3(1.0);
  p3 *= 2.5;
  // p3 *= time * 1.05;
  // float y = mod(tan(2.0 * p3.x) * (cos(time), tan(time)), 0.75);

  // float y = (atan(1.0 * p3.x) + cos(p3.x * time * PI * 0.5));
  // float m = plot(vec2(p3.x, p3.y), y, abs(sin(time * 0.1) * 0.5) + 0.01) * 50.0;
  float y = sin(tan(p3.x) + cos(p3.x * time * 3.0));
  float m = plot(vec2(p3), y, 0.25) * 1.0;
  float rz = abh_43_map(2.0 * (p3.yxz), time);
  // color = (m) * color + m * vec3(audio.lowpass * 3.0, rz * audio.bandpass * 2.0, 3.0 * audio.notch);
  // color = (m) * color + m * vec3(rz);
  color = (m) * color * m * vec3(1.0);
  vec3 l = vec3(m);
  color += (smoothstep(rz * 2.0, 0.5, rz) );

  color.r *= audio.notch;
  color.g *= audio.lowpass;
  color.b *= audio.highpass;

  color.r *= 2.0;
  color.g *= 2.0;
  color.b *= 2.0;

  gl_FragColor = vec4(color.grb, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(rz* p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
