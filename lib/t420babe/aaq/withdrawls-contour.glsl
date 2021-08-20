#ifndef T420BABE_WITHDRAWLS_CONTOUR
#define T420BABE_WITHDRAWLS_CONTOUR

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

/* skew constants for 3d simplex functions */
const float F3 =  0.3333333;
const float G3 =  0.1666667;

/* discontinuous pseudorandom uniformly distributed in [-0.5, +0.5]^3 */
vec3 random3(vec3 c) {
	float j = 4096.0 * sin(dot(c,vec3(17.0, 59.4, 15.0)));
	vec3 r;
	r.z = fract(512.0*j);
	j *= .125;
	r.x = fract(512.0*j);
	j *= .125;
	r.y = fract(512.0*j);
	return r - 0.5;
}

/* 3d simplex noise */
float simplex3(vec3 p) {
	/* 1. find current tetrahedron T and it's four vertices */
	/* s, s+i1, s+i2, s+1.0 - absolute skewed (integer) coordinates of T vertices */
	/* x, x1, x2, x3 - unskewed coordinates of p relative to each of T vertices*/
	
	/* calculate s and x */
	vec3 s = floor(p + dot(p, vec3(F3)));
	vec3 x = p - s + dot(s, vec3(G3));
	
	/* calculate i1 and i2 */
	vec3 e = step(vec3(0.0), x - x.yzx);
	vec3 i1 = e * (1.0 - e.zxy);
	vec3 i2 = 1.0 - e.zxy * (1.0 - e);
		
	/* x1, x2, x3 */
	vec3 x1 = x - i1 + G3;
	vec3 x2 = x - i2 + 2.0 * G3;
	vec3 x3 = x - 1.0 + 3.0 * G3;
	
	/* 2. find four surflets and store them in d */
	vec4 w, d;
	
	/* calculate surflet weights */
	w.x = dot(x, x);
	w.y = dot(x1, x1);
	w.z = dot(x2, x2);
	w.w = dot(x3, x3);
	
	/* w fades from 0.6 at the center of the surflet to 0.0 at the margin */
	w = max(0.6 - w, 0.0);
	
	/* calculate surflet components */
	d.x = dot(random3(s), x);
	d.y = dot(random3(s + i1), x1);
	d.z = dot(random3(s + i2), x2);
	d.w = dot(random3(s + 1.0), x3);
	
	/* multiply d by w^4 */
	w *= w;
	w *= w;
	d *= w;
	
	/* 3. return the sum of the four surflets */
	return dot(d, vec4(52.0));
}

float map(float nMin, float nMax, float n) {
	return (n - nMin) / (nMax - nMin);
}
float gain(float x, float p) {
	return x < 0.5 ? 
		0.5 * pow(2.0 * x, p) : 
		1.0 - 0.5 * pow(2.0 * (1.0 - x), p);
}

float contour_lines(vec2 _pos) {
  float thickness = 2.0;
  float scale = 1.5;
  float t = 0.0;

  float n = simplex3( vec3(sin(_pos * scale), sin(u_time * 0.12))) / 35.0;
  n = smoothstep(1.5, 0.0, abs(fract(n + 0.5) - 0.5) / fwidth(n) ); 

  return n;
}

float circle_0(vec2 st, float u_full_ave) {
    return length(st );
}

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

// 7cc3f12, 20:58 concentric black white purple u_notch
void purple_concentric(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.2, 0.243, 0.0234);

  // float pct = sharp(vesica_sdf(pos * 1.1, u_notch));
  float pct = sharp(circle_1(pos * 1.1, audio.notch));
  color = vec3(pct * color + pct + color.gbr);
  float pct2 = sharp(circle_1(pos * 1.1, audio.notch + 0.1));
  color *= pct2;
}


void withdrawls_0(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  vec3 c_brick = vec3(abs(sin(u_time + 0.1) + 0.1) + 0.5, abs(cos(u_time - 0.5) + 0.1) + 0.3, abs(tan(u_time + 0.8) + 0.1) + 0.4);
  color = c_brick;
  vec3 circle_color = vec3(1.0);
  purple_concentric(pos, u_time, audio, circle_color);
  color.r /= circle_color.r;
  color.g += circle_color.g;
  color.b *= circle_color.b;
  // color.b = 1.0 - color.g;
  color -= contour_lines(pos);
  // color = vec3(sharp(circle_0(pos, audio.bandpass)));

  // color = color.rbg;
}
#endif
