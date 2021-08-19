#ifndef T420BABE_GEO_GLOSS_0
#define T420BABE_GEO_GLOSS_0

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif


float shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 0.5;
  f += sin(theta * 50.0) * noise(pos + u_time * 1.0) * 0.1;
  f1 += (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);

  return 1.0 - smoothstep(f, f + 0.007, r);
}

float shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return shape(pos, radius, u_time, audio) - shape(pos, radius - width, u_time, audio);
}

void gloss_0(vec2 pos, float u_time, peakamp audio, out vec3 color) {
	color = vec3(1.0);
  color.b += audio.lowpass * 2.0;
  color *= shape_border(pos, 1.0, 0.10, u_time, audio);
  color.g *= audio.lowpass * 2.0;
}

#endif
