#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_STRUCTS
#include "./lib/common/structs.glsl"
#endif

// #ifndef PULSE_X_MAX
// #include "./lib/t420babe/pusle-x-max.glsl"
// #endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.aa.glsl"
#endif

#ifndef T420BABE_COUCH_3I
#include "./lib/t420babe/couch/couch-3i.glsl"
#endif

#ifndef T420BABE_RAINBOW_SCALES
#include "./lib/t420babe/rainbow-scales.glsl"
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

uniform sampler2D u_tex0;

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
  vec3 c0 = vec3(0.760704, 0.94902, 0.0);
  vec3 c1 = vec3(0.94902 ,0.0, 0.760704);
  // float f = abs(sin(u_time)) * u_highpass;
  float f = abs(u_bandpass);
  // vec3 color = mix(c0, c1, f);
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}

// float PI = 3.1415926535897932384626433832795;
float PI180 = float(PI / 180.0);

float sind(float a) { return sin(a * PI180); }
float cosd(float a) { return cos(a * PI180); }
float added(vec2 sh, float sa, float ca, vec2 c, float d) {
  return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
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

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = my_mix();

  float threshold = clamp(0.6, 0.0, 1.0);

  float size = 5.5;
  color -= SHARP(wbl_hexagon_now(pos * audio.bandpass * 4.0, size, audio));
  vec3 cch = color;

  // vec2 cch_pos = vec2(pos.x, pos.y);
  // vec3 cch = x_box(cch_pos, u_time, audio, color);
  // vec3 cch = purple_circle_oh_yes_he_is_mio(cch_pos, u_time, audio, color);
  // vec3 cch = orange_circle_bright_purple_bg(cch_pos, u_time, audio, color);
  pos = vec2(pos.x, pos.y);
  vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
  vec4 src_pixel = texture2D(u_tex0, src_coord);

  float raster_pattern = cch.r;
  float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
  float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
  gl_FragColor = vec4(src_pixel.b * u_bandpass * 2.0, cch.g, src_pixel.g * u_notch * 2.0, 1.0);
}
