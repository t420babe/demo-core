// https://www.youtube.com/watch?v=9wbZEPrFd10
#ifndef T4B_ABF_107
#define T4B_ABF_107

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float abf_107_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = tan(p3 * 2.0 + time);
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = log(q.x + (q.z + (q.y) ) ) * 1.0;
  return x0 *  x1 / x2 * 1.0;
}

vec3 fake_fluid(vec3 p3, float time, peakamp audio) {
	vec2 uv = p3.xy;
	for (float i = 1.; i < 15.; i++) {
		vec2 uv2 = p3.xy;
		uv2.x += sin(time*.25)*1.25/ i* sin(i *  uv2.y + time * 0.55);
		uv2.y +=  cos(time*.2)*2./i* cos(i * uv2.x + time * 0.35 ); 
		uv = uv2;
	}

	float r = abs(sin(uv.x))+.5;
	float g =abs(sin(uv.x+2.+time*.2))-.2;
	float b = abs(sin(uv.x+4.));   
  vec3 col = vec3(r,g,b);  
  return col;
}

void abf_107(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  float time_raw = time;
  vec3 p3_raw = p3;
  time *= 0.1;
  time += 10.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.1;
  audio.highpass  *= 1.1;
  audio.bandpass  *= 1.1;
  audio.notch     *= 1.1;

  // p3 *= 55.0 * cos(p3.x) * sin(p3.x);
  // p3 *= time * exp(p3.y * exp(p3.x)) * 0.3;
  // p3 *= 500.0 * log(p3.y * p3.y);
  // p3.z += time * 0.001;
  // p3 *= 13.0;
  // p3 *= 43.0;
  // p3 == time;
  // p3 *= wrap_time(time * 0.05, 30.0) * cos(p3.y) * atan(p3.x);
  // p3 *= wrap_time(time * 0.05, 30.0) * cos(p3.y) * atan(p3.y * p3.x);
  p3 *= wrap_time(time * 0.05, 30.0) * cos(p3.y) * atan(p3.x * time * 0.05);
  p3.xz *= -rotate2d(p3.y);
  p3.yx *= rotate2d(time * 0.8);

  p3 *= 5.0;

  float y1 = 1.0 * (sin(p3.x ));
  // float m1 = plot(vec2(p3.x, p3.y), y1, wrap_time(time, 10.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy *= m1;

  float rz = abf_107_map(p3, time);
  float y = 1.5 * audio.notch * (sin(p3.y * time) + sin(p3.z * time));
  float m = plot(vec2(p3.x, p3.y * audio.lowpass), y * 5.0  * audio.lowpass, 5.50) * 1.0;
  // float m = plot(vec2(p3.x, p3.y * audio.notch * 5.0), y * 10.0  * audio.notch, 10.50) * 1.0;

  float f =  ( rz - abf_107_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * asin(0.1 * f * p3.y) + cos(0.1 * f * p3.y);

  color *= l * m;
  color *= l * l;

  color.r *= audio.notch;
  color.g *= audio.highpass;
  color.b *= audio.lowpass;

  color /= fake_fluid(p3_raw * 0.05, time_raw, audio);
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(color.rgb, 1.0);
}

#endif
