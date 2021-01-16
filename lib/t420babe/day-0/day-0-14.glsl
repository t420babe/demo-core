// #effect #fav4 #shadershoot
#ifndef T420BABE_DAY_0_14
#define T420BABE_DAY_0_14

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

// Cellular noise ("Worley noise") in 3D in GLSL.
// Copyright (c) Stefan Gustavson 2011-04-19. All rights reserved.
// This code is released under the conditions of the MIT license.
// See LICENSE file for details.

// Permutation polynomial: (34x^2 + x) mod 289
vec4 permute(vec4 x) {
  return mod((34.0 * x + 1.0) * x, 289.0);
}
vec3 permute(vec3 x) {
  return mod((34.0 * x + 1.0) * x, 289.0);
}

// Cellular noise, returning F1 and F2 in a vec2.
// Speeded up by using 2x2x2 search window instead of 3x3x3,
// at the expense of some pattern artifacts.
// F2 is often wrong and has sharp discontinuities.
// If you need a good F2, use the slower 3x3x3 version.
vec2 cellular2x2x2(vec3 P) {
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
vec2 cellular2x2(vec2 P) {

  float K = 0.142857142857;      // 1/7
  float K2 = 0.0;    // K/2
  float jitter = 0.01;

  vec2 Pi = mod((P), 289.0);
  vec2 Pf = fract(exp2(P));

  vec4 Pfx = Pf.x - vec4(-0.5, -1.5, -0.5, -1.5);
  vec4 Pfy = Pf.y - vec4(-0.5, -0.5, -1.5, -1.5);

  vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
  p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));

  // vec4 ox = mod(p, abs(2.0 * audio.notch)) * abs(tan(u_time) + 0.0) + K2;
  vec4 ox = mod(p, abs(1.0 * audio.lowpass)) * abs(audio.notch);
  // vec4 oy = mod(floor(p * K), 1.0) * K  + K2;
  vec4 oy = mod(floor(p * K), 1.0) * K  + K2;

  vec4 dx = Pfx + jitter * ox;
  vec4 dy = Pfy + jitter * oy;

  // d11, d12, d21 and d22, squared
  vec4 d = dx * dx + dy * dy;

  // Sort out the two smallest distances
  #if 0
    // Cheat and pick only F1
    d.yx = max(d.wy, d.zw);
    d.x = min(d.x, d.y);

    return d.xx;                // F1 duplicated, F2 not computed

  #else
    // Do it right and find both F1 and F2
    d.xy = (d.x < d.y) ? d.xy : d.yx; // Swap if smaller
    d.xz = (d.x < d.z) ? d.xz : d.zx;
    d.xw = (d.x < d.w) ? d.xw : d.wx;

    d.y = min(d.y, d.z);
    d.y = min(d.y, d.w);

    return tan(d.xy);
  #endif

}

float random (in float x) {
    return fract(sin(x)*1e4);
}

float random (in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float randomSerie(float x, float freq, float t) {
    return step(.8,random( floor(x*freq)-floor(t) ));
}

vec3 ikeda(vec2 pos, float time) {
    float cols = 1.5;
    // float freq = random(floor(time)) + abs(atan(time) * 0.1);
    // float freq = random(floor(time));
    float freq = 1.0;
    float t = 60. + time * (1.0 - freq) * 30.;

    if (fract(cols * 0.5) < 0.5){
        t *= -1.0;
    }
    t = 60.0;

    // freq += random(floor(pos.y));

    float offset = 0.025;
    return vec3(randomSerie(sin(pos.x), freq * 100.0, t + offset),
                 randomSerie(tan(pos.x), freq * 100.0, t),
                 randomSerie(cos(pos.x), freq * 100.0, t - offset));

}

float spiral_pxl(vec2 st, float t) {
    float r = dot(st.yx, st.yx) * 0.5;
    float a = atan(st.y,st.x)  * 0.5;
    return abs(((sin(r * t)   / r)));
}

vec3 shapes(vec2 pos, float u_time, peakamp audio) {
    float x = pos.x;
    float y = pos.y;

    float a0 = step(x*x + y*y, 1.0); 
    
    float y1 = 0.4*log(0.63*x+0.64)+1.8;
    float a1 = step(y, y1);

    float y2 = 0.3*log(10.0*x-2.0)+0.8;
    float a2 = step(y2, y) + step(x,0.2);

    float y3 = -0.1 * pow(x+-0.5, 2.0)+1.8;
    float a3 = step(y, y3);

    float a = max(a0, a1*a2*a3*step(0.0,y));

    vec3 col_back = vec3(0.0);
    vec3 col_fill = vec3(0.2353, 0.34580, 0.9872340);

    vec3 rgb = mix(col_back, col_fill, a) + 0.4 * vec3(a1, a2, a3);
    return rgb;
}

vec3 day_0_14(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass = abs(audio.lowpass);
  audio.highpass = abs(audio.highpass);
  audio.bandpass = abs(audio.bandpass);
  audio.notch = abs(audio.notch);

  audio.lowpass *= 1.0;
  audio.highpass *= 1.0;
  audio.bandpass *= 1.0;
  audio.notch *= 1.0;

  vec2 ux = pos;
  vec2 st = pos;
  st.y += 1.0;
  st *= 20.0;
	vec2 F = cellular2x2x2(vec3(st * 1.0, u_time));
  float n = smoothstep(0.0, abs(sin(u_time * 0.05)) + 1.0, F.y) / ( clamp(audio.bandpass * 0.045, 0.01, 1.0));
  // float n = smoothstep(0.0, abs(sin(u_time * 0.05)) + 1.0, F.y) / ( (audio.bandpass * 0.015));
  // n = step(n, sin(pos.x));
  color = vec3(n);
  pos = (pos.yx);
  pos *= 50.0;
  pos.x *= 1.5 * sin(pos.y);
  // pos.y += abs(audio.notch) * 5.0;
  pos.x *= 5.5 * sin(pos.y);
  color -= abs(sin(u_time * 0.1) + 2.0) + 5.0 * spiral_pxl(abs(sin(pos.yy) * cos(pos.xy)) * 4.5 * abs(1.0 * audio.bandpass), 0.1 * wrap_time(u_time, 10.0) + 10.0);
  // color -= spiral_pxl(3.0 * pos.yx * abs(audio.bandpass), 1.0 * wrap_time(u_time, 10.0) + 10.0);
  color.b *= 2.5 * (audio.lowpass);
  color.b += 5.4;
  color.r /= 2.5 * 1.5 * (audio.highpass);
  // color = color.gbr;
  // color.g /= 0.4;
  color.g *=  2.5 * abs(audio.notch);
  // color /= (0.1 - n * 0.5);
  color += (0.1 - n * 0.8);
  // color -= 1.5;
  ux.y += 1.5;
  color /= 1.0 * shapes(ux * 20.0, u_time, audio);

  if (abs(audio.notch) > 0.7) {
    color = color.gbr;
    color = color.gbr;
  } else if (audio.notch > 0.6) {
    color = color.gbr;
  }
  return color;
}
#endif
