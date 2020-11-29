// imaginary friends (ov) - Morgan Page Remix by Deadmau5
// T4B NOTE: Need to change num_rays on beat
#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

// #ifndef PULSE_X_MAX
// #include "./lib/t420babe/pusle-x-max.glsl"
// #endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif

#ifndef T420BABE_COUCH_3I
#include "./lib/t420babe/couch/couch-3i.glsl"
#endif

#ifndef T420BABE_RAINBOW_SCALES
#include "./lib/t420babe/rainbow-scales.glsl"
#endif

#ifndef T420BABE_RIDGE_20
#include "./lib/t420babe/ridge/ridge-20.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_RAYS
#include "./lib/pxl/rays-sdf.glsl"
#endif


uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform sampler2D u_tex0;

vec2 square_position(vec2 pos) {
  vec2 tmp_pos = pos;
  tmp_pos.y *= u_resolution.y / u_resolution.x;
  return tmp_pos;
}

void x_box(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float audio_multiplier = audio.bandpass;

  vec3 colorA = vec3(0.149,0.141,0.912);
  vec3 colorB = vec3(1.000,0.833,0.224);

  pos *=0.005;
  float pct = plot(pos, pos.x, audio_multiplier * 0.01) * audio_multiplier;

  vec2 pos_1 = vec2(pos.x, -pos.y);
  pct += plot(pos_1, pos.x, audio_multiplier * 0.01) * audio_multiplier;
  pct = sharp(pct);
  color =  0.0+pct *  color + pct * vec3(0.8989, 0.2234, 0.0);
  color.b = color.x * audio_multiplier * 7.25;
}

float triangle_0main(vec2 st) {
  st = (st*2.-1.) * 1.5;
  return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.x * 0.5);
}

// Zonnestaal - MOWE Remix
vec3 my_mix() {
  vec3 c1 = vec3(0.060704, 0.04902, 0.0);
  vec3 c0 = vec3(0.04902 ,0.0, 0.760704);
  // float f = abs(sin(u_time)) * u_highpass;
  float f = fract(abs(u_bandpass));
  // vec3 color = mix(c0, c1, f);
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}

// float PI = 3.1415926535897932384626433832795;
float PI180 = float(PI / 180.0);

float sind(float a) { return tan(a * PI180); }
float cosd(float a) { return fract(a * PI180); }
float added(vec2 sh, float sa, float ca, vec2 c, float d) {
  return 0.5 + 0.25 * fract((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

float wbl_hexagon_now(vec2 pos, float size, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 1.0;
  // if (audio.notch * 100.0 > 100.0) {
  // if (audio.bandpass > 0.9) {
  // if (audio.bandpass > 0.5) {
  // if (audio.notch > 0.5) {
  if (audio.notch > 0.4) {
    // if (full_max > 100.0) {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.5);
  }  else {
    hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.0);
  }
  return hexagon;
  }

  float triangle_now(vec2 st, peakamp audio) {
    st = (st * 2.0)*2.;
    float t1 =  max(abs(st.x) * 0.066025 + st.y * 0.5, -st.y * 0.5);
    return t1 * 15.0 * audio.notch;
  }

  mat2 mat_rotate2d(float angle){
    return mat2(tan(angle),sin(angle), cos(angle),-sin(angle));
  }

  void kungs_ifsb(vec2 pos, float u_time, peakamp audio, out vec3 color) {
    vec2 sq_pos = square_position(pos);
    r20_ridge_main(pos, u_time, audio, color);
  }

  void main() {
    vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
    peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
    vec3 color = my_mix();
    vec2 sq_pos = square_position(pos);
    r20_ridge_main_built(sq_pos, u_time, audio, color);

    vec3 purp_circle =  vec3(0.0);
    // 0:17 5 -> 50
    // 1:17 50 -> 5
    // 1:47 5 -> 50
    // 2:17 50 -> 5
    float rayz = rays_audio(pos, 5, audio);
    color += rayz;
    purple_circle_oh_yes_he_is_mio(pos, u_time, audio, purp_circle);
    color -= purp_circle;

    gl_FragColor = vec4(color, 1.0);
  }
