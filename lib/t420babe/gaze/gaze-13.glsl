// #effect #shadershoot
#ifndef T420BABE_GAZE_13
#define T420BABE_GAZE_13

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

float circle(vec2 _pos, float _radius){
  vec2 pos = vec2(0.5) - _pos;
  // _radius *= tan(u_time * 0.1) * -0.10;
  _radius *= 1.0 / cos(pos.x * pos.y) * sin(u_time);

  // _radius *= tan(u_time * 1.0) * -0.10;
  // _radius *= 3.00;
  // return smoothstep(_radius-(_radius*0.01),_radius+(_radius*0.01),dot(pos,pos)*3.14);
  // return 1.0 - smoothstep(_radius - (_radius * 1.1), (_radius * 0.1), dot(pos, pos) * 0.14);
  // return 1.0 - smoothstep(_radius - (_radius * (abs(sin(u_time * 0.3))) - 0.5), _radius + (_radius*0.01), dot(pos, pos) * 3.14);
  return 1.0 - smoothstep(_radius - (_radius   - 1.5), _radius * (_radius * 0.01), dot(acos(pos), acos(pos)) * 0.01);
}

vec3 damier(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  color *= 7.0;
  // vec3 color = vec3(abs(audio.notch) * 1.5, 1.0, 1.0);
  // vec3 color = vec3(1.0, abs(audio.notch) * 1.5, 1.0);

  float zoom = 6.0 * (audio.bandpass);
  pos *= zoom;
  pos.y += 0.5;
  pos.x += 0.5;
  color /= vec3(circle(pos + vec2(0.,0.1), 1.000)+
                    circle(pos+vec2(0.00,-0.1), 1.000)+
                    circle(pos+vec2(-0.1,0.), -1.000)+
                    circle(pos+vec2(0.1,0), 0.007));

  return color;
}


/* AUDIO_CIRCLE BEGIN */
#ifndef T420BABE_AUDIO_CIRCLE

/* PXL_CIRCLE BEGIN */
#ifndef PXL_CIRCLE
float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}
#endif
/* PXL_CIRCLE END */

void purple_circle_oh_yes_he_is_mio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  color = vec3(0.2, 0.243, 0.0234);

  float pct = sharp(circle_1(pos * 1.1, audio.bandpass / 1.5));
  color = vec3(pct * color + pct + color.gbr);
}
#endif
/* AUDIO_CIRCLE END */

/* CLOUDS BEGIN */
#ifndef CLOUDS
float clouds_random (in vec2 _pos) {
    return fract(sin(dot(_pos.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float clouds_noise (in vec2 _pos) {
    vec2 i = floor(_pos);
    vec2 f = fract(_pos);

    // Four corners in 2D of a tile
    float a = clouds_random(i);
    float b = clouds_random(i + vec2(1.0, 0.0));
    float c = clouds_random(i + vec2(0.0, 1.0));
    float d = clouds_random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}


float clouds_fbm ( in vec2 _pos) {
  int num_octaves = 5;
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(5.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), sin(0.5), cos(0.50));
    for (int i = 0; i < num_octaves; ++i) {
        v += a * clouds_noise(_pos);
        _pos = rot * _pos * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

void clouds(vec2 pos, float u_time, peakamp audio, out vec3 color) {

    vec2 q = vec2(0.);
    q.x = clouds_fbm( pos + 0.00*u_time);
    q.y = clouds_fbm( pos + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = clouds_fbm( pos + 5.0 * q + vec2(1.7,9.2)+ 0.15 * u_time);
    r.y = clouds_fbm( pos + 5.0 * q + vec2(8.3,2.8)+ 0.126 * u_time);

    float f = clouds_fbm(pos+r);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    color = vec3((f*f*f+.6*f*f+.5*f)*color);
}
#endif
/* CLOUDS END */

/* T420BABE_SHARP_HEART BEGIN */
#ifndef T420BABE_SHARP_HEART
void say_nothing_none(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  clouds(pos, u_time, audio, color);
  // color.g *= abs(audio.lowpass);
  // // color.g /= abs(audio.bandpass) * 10.0;
  // color.r *= abs(audio.lowpass) * 2.0;
  // // color.b *= audio.highpass * 2.5;
  // color.b *= abs(tan(u_time * 0.5));
  // // color.r *= abs(audio.bandpass) * 0.5;

  // color.g *= abs(audio.lowpass);
  // color.r *= abs(audio.bandpass) * 2.0;
  // color.b += abs(audio.notch) * 0.2;

  color.g = abs(audio.lowpass) * 0.5;
  color.r *= abs(audio.bandpass) * 2.0;
  color.b += abs(audio.notch) * 0.2;

  // color.g *= abs(audio.lowpass) * 0.5;
  // color.r *= abs(audio.bandpass) * 2.0;
  // color.b = abs(audio.notch) * 0.2;

  // color.g *= abs(audio.lowpass) * 0.5;
  // color.b *= abs(audio.bandpass) * 2.0;
  // color.r = abs(audio.notch) * 0.35;

  // color.g *= abs(audio.lowpass) * 0.5;
  // color.r *= abs(audio.bandpass) * 2.0;
  // color.b = abs(audio.notch) * 0.3;

  // color.g *= 0.5 * 0.5;
  // color.r *= abs(audio.bandpass) * 2.0;
  // color.b = abs(audio.notch) * 0.3;

}
#endif
/* T420BABE_SHARP_HEART END */

// Permutation polynomial: (34x^2 + x) mod 289
vec3 permute(vec3 x) {
  return mod((34.0 * x + 1.0) * x, 289.0);
}


// Cellular noise, returning F1 and F2 in a vec2.
// Standard 3x3 search window for good F1 and F2 values
vec2 cellular(vec2 P) {
#define K 0.142857142857 // 1/7
#define Ko 0.428571428571 // 3/7
#define jitter 0.0 // Less gives more regular pattern
	vec2 Pi = mod(floor(P), 289.0);
 	vec2 Pf = fract(P);
	vec3 oi = vec3(-1.0, 0.0, 1.0);
	vec3 of = vec3(-0.5, 0.5, 1.5);
	vec3 px = permute(Pi.x + oi);
	vec3 p = permute(px.x + Pi.y + oi); // p11, p12, p13
	vec3 ox = fract(p*K) - Ko;
	vec3 oy = mod(floor(p*K),7.0)*K - Ko;
	vec3 dx = Pf.x + 0.5 + jitter*ox;
	vec3 dy = Pf.y - of + jitter*oy;
	vec3 d1 = dx * dx + dy * dy; // d11, d12 and d13, squared
	p = permute(px.y + Pi.y + oi); // p21, p22, p23
	ox = fract(p*K) - Ko;
	oy = mod(floor(p*K),7.0)*K - Ko;
	dx = Pf.x - 0.5 + jitter*ox;
	dy = Pf.y - of + jitter*oy;
	vec3 d2 = dx * dx + dy * dy; // d21, d22 and d23, squared
	p = permute(px.z + Pi.y + oi); // p31, p32, p33
	ox = fract(p*K) - Ko;
	oy = mod(floor(p*K),7.0)*K - Ko;
	dx = Pf.x - 1.5 + jitter*ox;
	dy = Pf.y - of + jitter*oy;
	vec3 d3 = dx * dx + dy * dy; // d31, d32 and d33, squared
	// Sort out the two smallest distances (F1, F2)
	vec3 d1a = min(d1, d2);
	d2 = max(d1, d2); // Swap to keep candidates for F2
	d2 = min(d2, d3); // neither F1 nor F2 are now in d3
	d1 = min(d1a, d2); // F1 is now in d1
	d2 = max(d1a, d2); // Swap to keep candidates for F2
	d1.xy = (d1.x < d1.y) ? d1.xy : d1.yx; // Swap if smaller
	d1.xz = (d1.x < d1.z) ? d1.xz : d1.zx; // F1 is in d1.x
	d1.yz = min(d1.yz, d2.yz); // F2 is now not in d2.yz
	d1.y = min(d1.y, d1.z); // nor in  d1.z
	d1.y = min(d1.y, d2.x); // F2 is in d1.y, we're done.
	return sqrt(d1.xy);
}

varying vec2 v_texcoord;
float cellular_2d(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  float n = 1.0;
  vec2 _pos = pos + 0.5;
  vec2 F = cellular(_pos);
  float facets = 0.01 + (F.y - F.x);
  float dots = smoothstep(0.01, 0.1, F.x);
  // n = facets * dots;
  n = facets * abs(atan(u_time));
  return n;
}

float hexagon_web(vec2 pos) {
  pos = abs(pos * 2.0);
  return max(abs(pos.x), pos.x * 1.866025 + fract(pos.x) * 0.5);
}

void gaze_13(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;


  vec3 n_color;
  float n = cellular_2d(2.5 * pos, u_time, audio, n_color);
  say_nothing_none(9.5 * pos, u_time, audio, color);

  float hex = hexagon_web(pos);
  color.r *= hex;


  // color += 0.1;
  // color /= n + 0.15;
  // vec3 damier_color = damier(1.75 * pos, u_time, audio);
  // damier_color *= abs(audio.notch);
  // // color *= clamp(damier_color, 2.5, 10.0);
  // // color.b += 0.1;
  // color.r *= damier_color.r;
  // // color.b *= damier_color.b * 1.1;
  // // color += 0.05;

  // color = 1.5 - color;

}

#endif
