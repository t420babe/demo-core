// Still Night by Pretty Lights
#ifndef T4B_FRACTIONS_111
#define T4B_FRACTIONS_111

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_111_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = sin(q.x + (q.z + (q.y) ) ) * 5.5;
  return x0 * x1 + x2 * 5.0;
}

vec3 fractions_111_fake_fluid(vec3 p3, float time, peakamp audio) {
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

void fractions_111(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  float time_raw = time;
  vec3 p3_raw = p3;
  vec3 color = vec3(1.0);

  // p3 *= 55.0 * cos(p3.x) * sin(p3.x);
  // p3 *= time * log(p3.y * log(p3.x)) * 0.3;
  p3 *= time * tan(p3.y * log(p3.x)) * cos(p3.y)* 0.5;
  // p3 *= 500.0 * log(p3.y * p3.y);
  p3 *= 15.0 * cos(p3.x) * sin(p3.x);
  p3.xz *= rotate2d(time * 1.40);
  p3.yx *= -rotate2d(time * 0.8);

  float y1 = 1.0 * (sin(p3.x ));
  // float m1 = plot(vec2(p3.x, p3.y), y1, wrap_time(time, 10.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy /= m1;

  float rz = fractions_111_map(p3, time);

  float y = 1.0 * (cos(p3.y) + cos(p3.z * time));

  float m = plot(vec2(p3.x, p3.y * audio.notch), y * 10.0  * audio.notch, 10.50) * 1.0;
  // float m = plot(vec2(p3.x, p3.y * audio.notch * 5.0), y * 10.0  * audio.notch, 10.50) * 1.0;

  float f =  ( rz / fractions_111_map(p3, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(1.0) * log(0.1 * f * p3.y);

  color *= fract(l) * m;
  color *= (l);

  color.r *= 6.0 * audio.notch;
  color.b *= 6.0 * audio.bandpass;
  color.g *= 6.0 * audio.lowpass;
  color *= fractions_111_fake_fluid(p3_raw * 0.5, time_raw, audio);
  // color.b += 15.0 * audio.lowpass;
  //
  // color.r += 10.0;
  // color.g *= 10.0;
  // color.b += 0.5;

  // color = 1.0 - color;
  // color = 1.0 / color;
  // gl_FragColor = vec4(color.bgr, 1.0);
  gl_FragColor = vec4(color.bgr, 1.0);
}

#endif
