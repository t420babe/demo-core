#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform sampler2D u_tex0;


// Zonnestaal - MOWE Remix
vec3 my_mix(peakamp audio) {
  vec3 c0 = vec3(0.760704, 0.94902, 0.0);
  vec3 c1 = vec3(0.94902 ,0.0, 0.760704);
  float f = audio.bandpass;
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}

float sind(float a) { return sin(a * PI180); }
float cosd(float a) { return cos(a * PI180); }
float added(vec2 sh, float sa, float ca, vec2 c, float d, peakamp audio) {
  return audio.bandpass + 0.25 * tan((sh.x * sa + sh.y * ca + c.x) * d) * audio.notch + 0.25 * log((sh.x * ca - sh.y * sa + c.y) * d);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  pos.y -= 0.35;
  pos.x -= 1.79;
  vec2 tmp_pos = pos;
  pos.x = -tmp_pos.y;
  pos.y = -tmp_pos.x;
  pos.y = -pos.y;
  pos /= 7.0;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);

  float threshold = clamp(0.5, 0.0, 1.0);
  float ratio = u_resolution.y / u_resolution.x;

  vec2 dst_coord = vec2(pos.x - 0.5, pos.y * 0.5) * 2.0;
  vec2 src_coord = vec2(pos.x - 1.0, pos.y);
  vec2 rotation_center = vec2(0.5);
  vec2 shift = dst_coord - rotation_center;

  float dot_size = 10.0;
  float angle = 45.0;

  float raster_pattern = added(shift, sind(angle), cosd(angle), rotation_center, PI / dot_size * 680.0, audio);
  vec4 src_PIxel = texture2D(u_tex0, src_coord);

  float avg = 0.2125 * src_PIxel.r + 0.7154 * src_PIxel.g + 0.07154 * src_PIxel.b;
  float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
  vec3 gray_color = vec3(gray);
  vec3 color = my_mix(audio);

  gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);


}

