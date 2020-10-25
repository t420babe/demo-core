// Porto - Worakls
#ifndef T420BABE_RORSCHACH
#define T420BABE_RORSCHACH

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

float shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  // Porto, change `m`
  // 2:59 -> * to /
  // 3:44 -> / to * 
  // 4:30 -> * to / 
  m *= noise( pos + u_time * 0.1) * 0.1;
  // m /= noise( pos + u_time * 0.1) * 1.0;

  f += sin(theta * 50.0) * noise(pos + u_time * 1.0) * 0.1;
  f /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  f /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  f1 *= tan(theta * 20.0) * 0.1 * pow(m, 2.0);

  // return 1.0 - smoothstep(f, f + 0.007, r);
  return 1.0 - smoothstep(f, f + 0.507, r) / fwidth(f1);
}

float shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return shape(pos, radius, u_time, audio) - shape(pos, radius - width, u_time, audio);
}

void rorschach(vec2 pos, float u_time, peakamp audio, inout vec3 color){
	// color = vec3(1.0, 0.4, 0.23);
  pos *= 10.0;

  color.g *= audio.lowpass * 2.0;
  color *= shape_border(pos, 3.0, 0.50, u_time, audio);
  color.r *= audio.highpass * 1.0;
}

#endif
