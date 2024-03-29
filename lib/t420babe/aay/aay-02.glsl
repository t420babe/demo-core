// #effect #fav4 #shadershoot
#ifndef T420BABE_DAY_0_02
#define T420BABE_DAY_0_02

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "./lib/common/permute.glsl"
#endif

vec2 day_02_cellular2x2x2(vec3 P) {
	float K = 0.142857142857; // 1/7
	float Ko = 0.428571428571; // 1/2-K/2
	float K2 = 0.020408163265306; // 1/(7*7)
	float Kz = 0.166666666667; // 1/6
	float Kzo = 0.416666666667; // 1/2-1/6*2
	float jitter = 0.8; // smaller jitter gives less errors in F2
	vec3 Pi = mod(floor(P), 289.0);
 	vec3 Pf = fract(P);
	vec4 Pfx = Pf.x + vec4(0.0, -1.0, 0.0, -1.0);
	vec4 Pfy = Pf.y + vec4(0.0, 0.0, -1.0, -1.0);
	vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
	p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));
	vec4 p1 = permute(p + Pi.z); // z+0
	vec4 p2 = permute(p + Pi.z + vec4(1.0)); // z+1
	vec4 ox1 = fract(p1*K) - Ko;
	vec4 oy1 = mod(floor(p1*K), 7.0)*K - Ko;
	vec4 oz1 = floor(p1*K2)*Kz - Kzo; // p1 < 289 guaranteed
	vec4 ox2 = fract(p2*K) - Ko;
	vec4 oy2 = mod(floor(p2*K), 7.0)*K - Ko;
	vec4 oz2 = floor(p2*K2)*Kz - Kzo;
	vec4 dx1 = Pfx + jitter*ox1;
	vec4 dy1 = Pfy + jitter*oy1;
	vec4 dz1 = Pf.z + jitter*oz1;
	vec4 dx2 = Pfx + jitter*ox2;
	vec4 dy2 = Pfy + jitter*oy2;
	vec4 dz2 = Pf.z - 1.0 + jitter*oz2;
	vec4 d1 = dx1 * dx1 + dy1 * dy1 + dz1 * dz1; // z+0
	vec4 d2 = dx2 * dx2 + dy2 * dy2 + dz2 * dz2; // z+1

	// Sort out the two smallest distances (F1, F2)
#if 1
	// Cheat and sort out only F1
	d1 = min(d1, d2);
	d1.xy = min(d1.xy, d1.wz);
	d1.x = min(d1.x, d1.y);
	return sqrt(d1.xx);
#else
	// Do it right and sort out both F1 and F2
	vec4 d = min(d1,d2); // F1 is now in d
	d2 = max(d1,d2); // Make sure we keep all candidates for F2
	d.xy = (d.x < d.y) ? d.xy : d.yx; // Swap smallest to d.x
	d.xz = (d.x < d.z) ? d.xz : d.zx;
	d.xw = (d.x < d.w) ? d.xw : d.wx; // F1 is now in d.x
	d.yzw = min(d.yzw, d2.yzw); // F2 now not in d2.yzw
	d.y = min(d.y, d.z); // nor in d.z
	d.y = min(d.y, d.w); // nor in d.w
	d.y = min(d.y, d2.x); // F2 is now in d.y
	return sqrt(d.yz); // F1 and F2
#endif
}

float day_02_spiral(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}


vec3 day_02(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  vec2 st = pos;
  st.y += 1.0;
  st *= 20.0;
	vec2 F = day_02_cellular2x2x2(vec3(st * 1.0, u_time));
	float n = smoothstep(0.0, abs(sin(u_time * 0.05)) + 1.0, F.y) / ( abs(audio.notch * 0.015));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  pos *= 10.5;
  pos.y += 1.5;
  pos.x += 1.5;
  color -= abs(sin(u_time * 0.1) + 2.0) + 5.0 * day_02_spiral(abs(sin(pos.yy) * cos(pos.xy)) * 4.5 * abs(1.0 * audio.bandpass), 0.1 * wrap_time(u_time, 10.0) + 10.0);
  // color -= day_02_spiral(3.0 * pos.yx * abs(audio.bandpass), 1.0 * wrap_time(u_time, 10.0) + 10.0);
  color.b *= 4.5 * abs(audio.lowpass);
  color.b += 5.4;
  color.r /= 1.5 * abs(audio.highpass);
  // color = color.gbr;
  // color.g /= 0.4;
  color.g *=  1.5 * abs(audio.notch);
  color /= (0.5 - n * 0.8);
  // color = vec3(0.1, 0.5, 1.1) * color;
  // color -= 1.5;
  return color;
}
#endif
