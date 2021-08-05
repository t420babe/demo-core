#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


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

vec3 damier(vec2 pos, float u_time) {
  vec3 color = vec3(1.0);
  color *= 7.0;
  // vec3 color = vec3(abs(audio.notch) * 1.5, 1.0, 1.0);
  // vec3 color = vec3(1.0, abs(audio.notch) * 1.5, 1.0);

  float zoom = 1.0;
  pos *= zoom;
  pos.y += 0.5;
  pos.x += 0.5;
  color -= vec3(circle(pos + vec2(0.,0.1), 1.000)+
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
  _pos = _pos.xx * 5.5;
  int num_octaves = 5;
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(5.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), sin(0.5), cos(0.50));
    for (int i = 0; i < num_octaves; ++i) {
        v += a * clouds_noise(_pos);
        _pos = rot * _pos * 2.5 + shift;
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

  color.g = abs(audio.lowpass) * 0.2;
  color.r *= abs(audio.bandpass) * 0.8;
  // color.r += 0.09;
  color.b += abs(audio.notch) * 0.4;

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

vec2 cellular(vec3 P) {
#define K 0.142857142857 // 1/7
#define Ko 0.428571428571 // 1/2-K/2
#define K2 0.020408163265306 // 1/(7*7)
#define Kz 0.166666666667 // 1/6
#define Kzo 0.416666666667 // 1/2-1/6*2
#define jitter 1.0 // smaller jitter gives more regular pattern

	vec3 Pi = mod(floor(P), 289.0);
 	vec3 Pf = fract(P) - 0.5;

	vec3 Pfx = Pf.x + vec3(1.0, 0.0, -1.0);
	vec3 Pfy = Pf.y + vec3(1.0, 0.0, -1.0);
	vec3 Pfz = Pf.z + vec3(1.0, 0.0, -1.0);

	vec3 p = permute(Pi.x + vec3(-1.0, 0.0, 1.0));
	vec3 p1 = permute(p + Pi.y - 1.0);
	vec3 p2 = permute(p + Pi.y);
	vec3 p3 = permute(p + Pi.y + 1.0);

	vec3 p11 = permute(p1 + Pi.z - 1.0);
	vec3 p12 = permute(p1 + Pi.z);
	vec3 p13 = permute(p1 + Pi.z + 1.0);

	vec3 p21 = permute(p2 + Pi.z - 1.0);
	vec3 p22 = permute(p2 + Pi.z);
	vec3 p23 = permute(p2 + Pi.z + 1.0);

	vec3 p31 = permute(p3 + Pi.z - 1.0);
	vec3 p32 = permute(p3 + Pi.z);
	vec3 p33 = permute(p3 + Pi.z + 1.0);

	vec3 ox11 = fract(p11*K) - Ko;
	vec3 oy11 = mod(floor(p11*K), 7.0)*K - Ko;
	vec3 oz11 = floor(p11*K2)*Kz - Kzo; // p11 < 289 guaranteed

	vec3 ox12 = fract(p12*K) - Ko;
	vec3 oy12 = mod(floor(p12*K), 7.0)*K - Ko;
	vec3 oz12 = floor(p12*K2)*Kz - Kzo;

	vec3 ox13 = fract(p13*K) - Ko;
	vec3 oy13 = mod(floor(p13*K), 7.0)*K - Ko;
	vec3 oz13 = floor(p13*K2)*Kz - Kzo;

	vec3 ox21 = fract(p21*K) - Ko;
	vec3 oy21 = mod(floor(p21*K), 7.0)*K - Ko;
	vec3 oz21 = floor(p21*K2)*Kz - Kzo;

	vec3 ox22 = fract(p22*K) - Ko;
	vec3 oy22 = mod(floor(p22*K), 7.0)*K - Ko;
	vec3 oz22 = floor(p22*K2)*Kz - Kzo;

	vec3 ox23 = fract(p23*K) - Ko;
	vec3 oy23 = mod(floor(p23*K), 7.0)*K - Ko;
	vec3 oz23 = floor(p23*K2)*Kz - Kzo;

	vec3 ox31 = fract(p31*K) - Ko;
	vec3 oy31 = mod(floor(p31*K), 7.0)*K - Ko;
	vec3 oz31 = floor(p31*K2)*Kz - Kzo;

	vec3 ox32 = fract(p32*K) - Ko;
	vec3 oy32 = mod(floor(p32*K), 7.0)*K - Ko;
	vec3 oz32 = floor(p32*K2)*Kz - Kzo;

	vec3 ox33 = fract(p33*K) - Ko;
	vec3 oy33 = mod(floor(p33*K), 7.0)*K - Ko;
	vec3 oz33 = floor(p33*K2)*Kz - Kzo;

	vec3 dx11 = Pfx + jitter*ox11;
	vec3 dy11 = Pfy.x + jitter*oy11;
	vec3 dz11 = Pfz.x + jitter*oz11;

	vec3 dx12 = Pfx + jitter*ox12;
	vec3 dy12 = Pfy.x + jitter*oy12;
	vec3 dz12 = Pfz.y + jitter*oz12;

	vec3 dx13 = Pfx + jitter*ox13;
	vec3 dy13 = Pfy.x + jitter*oy13;
	vec3 dz13 = Pfz.z + jitter*oz13;

	vec3 dx21 = Pfx + jitter*ox21;
	vec3 dy21 = Pfy.y + jitter*oy21;
	vec3 dz21 = Pfz.x + jitter*oz21;

	vec3 dx22 = Pfx + jitter*ox22;
	vec3 dy22 = Pfy.y + jitter*oy22;
	vec3 dz22 = Pfz.y + jitter*oz22;

	vec3 dx23 = Pfx + jitter*ox23;
	vec3 dy23 = Pfy.y + jitter*oy23;
	vec3 dz23 = Pfz.z + jitter*oz23;

	vec3 dx31 = Pfx + jitter*ox31;
	vec3 dy31 = Pfy.z + jitter*oy31;
	vec3 dz31 = Pfz.x + jitter*oz31;

	vec3 dx32 = Pfx + jitter*ox32;
	vec3 dy32 = Pfy.z + jitter*oy32;
	vec3 dz32 = Pfz.y + jitter*oz32;

	vec3 dx33 = Pfx + jitter*ox33;
	vec3 dy33 = Pfy.z + jitter*oy33;
	vec3 dz33 = Pfz.z + jitter*oz33;

	vec3 d11 = dx11 * dx11 + dy11 * dy11 + dz11 * dz11;
	vec3 d12 = dx12 * dx12 + dy12 * dy12 + dz12 * dz12;
	vec3 d13 = dx13 * dx13 + dy13 * dy13 + dz13 * dz13;
	vec3 d21 = dx21 * dx21 + dy21 * dy21 + dz21 * dz21;
	vec3 d22 = dx22 * dx22 + dy22 * dy22 + dz22 * dz22;
	vec3 d23 = dx23 * dx23 + dy23 * dy23 + dz23 * dz23;
	vec3 d31 = dx31 * dx31 + dy31 * dy31 + dz31 * dz31;
	vec3 d32 = dx32 * dx32 + dy32 * dy32 + dz32 * dz32;
	vec3 d33 = dx33 * dx33 + dy33 * dy33 + dz33 * dz33;

	// Sort out the two smallest distances (F1, F2)
#if 0
	// Cheat and sort out only F1
	vec3 d1 = min(min(d11,d12), d13);
	vec3 d2 = min(min(d21,d22), d23);
	vec3 d3 = min(min(d31,d32), d33);
	vec3 d = min(min(d1,d2), d3);
	d.x = min(min(d.x,d.y),d.z);
	return sqrt(d.xx); // F1 duplicated, no F2 computed
#else
	// Do it right and sort out both F1 and F2
	vec3 d1a = min(d11, d12);
	d12 = max(d11, d12);
	d11 = min(d1a, d13); // Smallest now not in d12 or d13
	d13 = max(d1a, d13);
	d12 = min(d12, d13); // 2nd smallest now not in d13
	vec3 d2a = min(d21, d22);
	d22 = max(d21, d22);
	d21 = min(d2a, d23); // Smallest now not in d22 or d23
	d23 = max(d2a, d23);
	d22 = min(d22, d23); // 2nd smallest now not in d23
	vec3 d3a = min(d31, d32);
	d32 = max(d31, d32);
	d31 = min(d3a, d33); // Smallest now not in d32 or d33
	d33 = max(d3a, d33);
	d32 = min(d32, d33); // 2nd smallest now not in d33
	vec3 da = min(d11, d21);
	d21 = max(d11, d21);
	d11 = min(da, d31); // Smallest now in d11
	d31 = max(da, d31); // 2nd smallest now not in d31
	d11.xy = (d11.x < d11.y) ? d11.xy : d11.yx;
	d11.xz = (d11.x < d11.z) ? d11.xz : d11.zx; // d11.x now smallest
	d12 = min(d12, d21); // 2nd smallest now not in d21
	d12 = min(d12, d22); // nor in d22
	d12 = min(d12, d31); // nor in d31
	d12 = min(d12, d32); // nor in d32
	d11.yz = min(d11.yz,d12.xy); // nor in d12.yz
	d11.y = min(d11.y,d12.z); // Only two more to go
	d11.y = min(d11.y,d11.z); // Done! (Phew!)
	return sqrt(d11.xy); // F1, F2
#endif
}

float cellular_3d(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  vec3 pos3d = vec3(pos, sin(pos.x * pos.y));
	vec2 F = cellular(pos3d);
	float n = F.y-F.x;
  return n;
}

float flip(float p0, float p1) {
  return mix(p0, 1.0 - p0, p1);
}

float triangle_0(vec2 st) {
    // float y = flip(1.0, st.y);
    // st = vec2(st.x, y);
    // st.y -= 1.2;
    st = (st*1.-0.) * 5.0;
    st.y -= 0.1;
    st.x -= 0.0;
    float r = max(abs(st.x) * 0.866025 + st.y * 0.5, -st.y * 0.5);
    return r;
}

vec2 rotate(vec2 pos, float theta) {
    pos = mat2(cos(theta), -sin(theta), sin(theta), cos(theta))*(pos);
    return pos;
}

float random (in vec2 pos) {
    return fract( sin( dot( pos, vec2(12.9898, 78.233) ) ) * 43758.5453123);
}

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }

// Value noise by Inigo Quilez - iq/2013, https://www.shadertoy.com/view/lsf3WH
float noise(vec2 pos) {

  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f * f * (3.0 - 2.0 * f);
  return mix(
      mix( random( i + vec2(0.0, 0.0) ), random( i + vec2(1.0, 0.0) ), u.x),
      mix( random( i + vec2(0.0, 1.0) ), random( i + vec2(1.0, 1.0) ), u.x),
      u.y);
}

// Lava lamp algorithm
float snoise(vec2 v) {
  // (3.0-sqrt(3.0))/6.0, 0.5*(sqrt(3.0)-1.0), -1.0 + 2.0 * C.x, 1.0 / 41.0
  const vec4 C = vec4(0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439);
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 )) + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // pos = rotate(pos, 135.07);
  pos *= 5.6;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);

  float tri = triangle_0(pos);
  float circ = circle_1(pos, 0.5);

  float sn = snoise(pos);

  vec3 n_color;
  float n = cellular_3d(4.0 * pos, u_time, audio, n_color);
  say_nothing_none(3.0 * pos, u_time, audio, color);
  color *= sn - 2.1;
  // color /= n + 0.00;
  // color.r /= n + 0.00;
  // color.g /= n + 0.10;

  // color.r = tri;
  // color.g /= tri;
  // color.b *= circ;
  // color = vec3(n);
  
  color = vec3(0.45) - color;
  // Bartok
  // color.r /= 1.0 * abs(sin(circ - tri));
  // color.r /= 1.0 + abs(sin(u_time * 0.5));
  // color.r /= 1.0 + abs(sin(audio.notch * 2.0));
  color.r /= tri * audio.notch;
  color.b /= tri * audio.notch;
  // color.g /= 1.0 * circ;
  if (audio.bandpass > 0.50) {
    color.g /= (audio.bandpass) * 1.0;
  }
  // color.g = clamp(color.g, 0.0, 0.9);
  color.b *= 0.9 * abs(tan((circ) - fract(tri)));
  // color.b *= 0.9 * abs(tan(fract(circ) - fract(tri)));
  color = color.brg;

  // vec3 damier_color = damier(1.75 * pos, u_time);
  // color *= clamp(damier_color, 2.5, 10.0);
  // color *= damier_color;
  // color += 0.05;
  // if (audio.highpass > 0.6) {
  //   color.r = audio.highpass;
  // }

  gl_FragColor = vec4(color, 1.0);
}
