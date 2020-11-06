// autocmd BufWritePost * execute '!git add % && git commit -m %'`
// #ifndef T420BABE_DOPPLER
// #include "./lib/t420babe/doppler.glsl"
// #endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

// #ifndef BOS_TURBULENCE
// #include "./lib/bos/turbulence.glsl"
// #endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// Permutation polynomial: (34x^2 + x) mod 289
vec4 permute(vec4 x) {
  return mod((34.0 * x + audio.bandpass) * x, 289.0);
}

vec2 cellular2x2(vec2 P) {

  float K = 0.142857142857;      // 1/7
  float K2 = 0.0;    // K/2
  float jitter = 0.01;

  vec2 Pi = mod((P), 289.0);
  vec2 Pf = tan(P * P);

  vec4 Pfx = Pf.x + vec4(-0.5, -1.5, -0.5, -1.5);
  vec4 Pfy = Pf.y + vec4(-0.5, -0.5, -1.5, -1.5);

  vec4 p = permute(Pi.x + vec4(0.0, 1.0, 0.0, 1.0));
  p = permute(p + Pi.y + vec4(0.0, 0.0, 1.0, 1.0));

  // vec4 ox = mod(p, abs(2.0 * audio.notch)) * abs(tan(u_time) + 0.0) + K2;
  vec4 ox = mod(p, abs(2.0 * audio.lowpass)) * (audio.notch);
  // vec4 oy = mod(floor(p * K), 1.0) * K  + K2;
  vec4 oy = mod(floor(p * K), 1.0) * K  + K2;

  vec4 dx = Pfx + jitter * ox;
  vec4 dy = Pfy + jitter * oy;

  // d11, d12, d21 and d22, squared
  vec4 d = dx * dx + dy * dy;

  // Sort out the two smallest distances
  #if 1
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

    return sqrt(d.xy);
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

#ifdef GL_OES_standard_derivatives
#extension GL_OES_standard_derivatives : enable
#endif
float aastep(float threshold, float value) {
    #ifdef GL_OES_standard_derivatives
    float afwidth = 0.7 * length(vec2(dFdx(value), dFdy(value)));
    return smoothstep(threshold-afwidth, threshold+afwidth, value);
    #else
    return step(threshold, value);
    #endif
}

float rect_sdf(vec2 st, vec2 s) {
    st = st*2.-1.;
    return max( abs(st.x/s.x),
                abs(st.y/s.y) );
}

float cross_sdf(vec2 st, float s) {
    vec2 size = vec2(.25, s);
    return min( rect_sdf(st.xy,size.xy),
                rect_sdf(st.xy,size.yx));
}

float circle_sdf(vec2 st) {
    return length(st-.5)*2.;
}
vec2 rotate(vec2 pos, float a, float offset_value) {
  pos = mat2(cos(a), -sin(a), sin(a), cos(a)) * (pos - offset_value);
  return pos + offset_value;
}

// 809fde9, main.frag green rooster with the sun sofia's theme
void doppler_green_rooster(vec2 pos, float u_time, peakamp audio, out vec3 color) {

  // pos.x += 0.40;
  // pos.y += 0.50;
  color = vec3(1.0, 0.1234, 0.34);
  float pct = aastep(pos.y, -pos.y) * sin(u_time);
  pct *= cross_sdf(rotate(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass * 2.5;
	color.b *= audio.notch;
  color.g += audio.lowpass;
}


void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec2 st = pos;
  // pos = pos.yx;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(1.0);
  vec3 color_bg = vec3(1.0);

  float inv = -1.0;
  float zoom = 70.0 * inv;
  // pos.y += 0.20 * inv;
  // pos.y -= 0.20;
  pos *= zoom;

  vec2 F = cellular2x2(pos * 1.0);

  vec2 pos_tmp = pos - 0.0;
  float time = mod(u_time, 60.0 * 6.0) + 666.0;
  float a = dot(pos_tmp, pos_tmp) / time * 0.07;
  // float n = step( abs( atan(a * 3.1415 * 5.0) ), F.x * sin(audio.notch * 0.10));
  float n = step( abs( log2(a * 3.1415 * 5.0) ), F.x * abs(audio.notch * 0.40));

  color = vec3(n);
  color *= abs(sin(audio.bandpass));
  // color.g /= abs(audio.notch);
  // color.r /= abs(audio.notch);
  // color /= abs(audio.notch);
  color /= abs(audio.notch);
  color /= abs(audio.notch);

  // color_bg = vec3(1.0, 1.0, 1.0);

  // ~30s
  color_bg = vec3(abs(tan(abs(sin(u_time)))), abs(cos(2.0 * audio.bandpass)) * 1.5, abs(sin(audio.highpass)));

  vec2 pos_bg = pos;
  pos_bg = (pos / zoom) * 0.5;
  pos_bg.y += 0.5;
  pos_bg.x += 0.5;
  vec3 color_doppler = vec3(1.0, 1.0, 1.0);
  doppler_green_rooster(pos_bg, u_time, audio, color_doppler);

  // color_doppler.g = 0.4;
  // color_bg = color_doppler.brr;

  color_bg *= color;
  color = color_bg;
  // // Color 0
  // color.b =  n;
  // color.r *= abs(sin(n * tan(u_time * 1.0)));
  // color.g *= abs(sin(n * tan(u_time * 1.0)));

  // // Color 1
  // float color_time = mod(u_time, 10.0);
  // color.b =  abs(audio.highpass) * 3.5 * n;
  // color.r *= abs(sin(n * abs(cos((PI / 4.0) * color_time * (audio.bandpass) + PI / 2.0))));
  // color.g /= abs(sin(n * abs(cos((PI / 4.0) * color_time * (audio.bandpass) + PI / 2.0))));
  // color.g *= abs(cos(n * abs(sin((PI / 4.0) * color_time * (audio.bandpass) ))));

  gl_FragColor = vec4(color, 1.0);
}
