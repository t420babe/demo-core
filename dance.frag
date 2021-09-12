#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_STRUCTS
#include "./structs.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./audio-circle.aa.glsl"
#endif

#ifndef T420BABE_COUCH_3I
#include "./couch-3i.glsl"
#endif

#ifndef T420BABE_RAINBOW_SCALES
#include "./rainbow-scales.glsl"
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
vec3 my_mix() {
  vec3 c0 = vec3(0.760704, 0.94902, 0.0);
  vec3 c1 = vec3(0.94902 ,0.0, 0.760704);
  // float f = abs(sin(u_time)) * u_highpass;
  float f = abs(u_bandpass);
  // vec3 color = mix(c0, c1, f);
  vec3 color = (1.0 - f) * c0 + f * c1;
  return color;
}

float PI = 3.1415926535897932384626433832795;
float PI180 = float(PI / 180.0);

float sind(float a) { return sin(a * PI180); }
float cosd(float a) { return cos(a * PI180); }
float added(vec2 sh, float sa, float ca, vec2 c, float d) {
  return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  // vec3 color = vec3(1.0);
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = my_mix();

  float threshold = clamp(0.6, 0.0, 1.0);

  if (pos.x < 0.0) {
    if (pos.y < 0.0) {

      float ratio = u_resolution.y / u_resolution.x;

      // vec2 dst_coord = vec2(pos.x - 0.5, pos.y * 0.5) * 2.0;
      vec2 dst_coord = vec2(pos.x, pos.y);
      // vec2 src_coord = vec2(pos.x - 0.5, pos.y * 0.5) * 2.0;
      // vec2 src_coord = vec2(pos.x - 1.0, pos.y);
      vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
      vec2 rotation_center = vec2(0.0);
      vec2 shift = dst_coord - rotation_center;

      float dot_size = 6.0;
      float angle = 45.0;

      float raster_pattern = added(shift, sind(angle), cosd(angle), rotation_center, PI / dot_size * 680.0);
      vec4 src_pixel = texture2D(u_tex0, src_coord);

      float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
      vec3 gray_color = vec3(gray);
      vec3 color = my_mix();

      // gray = rater_pattern;
      // gl_FragColor = vec4(gray, gray, gray, 1.0);
      // gl_FragColor = vec4(color.r * abs(u_lowpass) * 1.5, gray * u_bandpass * 2.0, gray * u_notch * 2.0, 1.0);
      gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b * abs(sin(u_time)), gray * u_notch * 2.0, 1.0);
      // gl_FragColor = vec4(gray * u_bandpass * 2.0, gray * u_notch * 2.0, color.b * abs(u_lowpass) * 1.3, 1.0);
      // gl_FragColor = vec4(gray * u_bandpass * 2.0, gray * u_lowpass, gray * u_notch * 2.0, 1.0);

    } else {
      pos = vec2(pos.x, pos.y);
      vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
      vec4 src_pixel = texture2D(u_tex0, src_coord);
      vec3 c3i = couch3i(pos, u_time, audio, color);
      float raster_pattern = c3i.g;
      float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
      gl_FragColor = vec4(color.b, gray * u_bandpass * 2.0, gray * u_notch * 2.0, 1.0);


      // gl_FragColor = texture2D(u_tex0, pos);
    }
  } else {
    if (pos.y < 0.0) {
      pos = vec2(pos.x, pos.y);
      vec2 src_coord_1 = vec2(pos.x - 0.8, pos.y - 1.0);
      // vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);

      vec4 src_pixel = texture2D(u_tex0, src_coord_1);
      vec3 rainbow = rainbow_scales_hbg_is_mio(pos, u_time, audio);
      float raster_pattern = rainbow.b;
      float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);

      // gl_FragColor = vec4(color.b, gray * u_bandpass * 2.0, gray * u_notch * 2.0, 1.0);
      // gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);
      gl_FragColor = vec4(src_pixel.r * u_bandpass * 2.0, rainbow.r, gray * u_notch * 2.0, 1.0);
    } else {
      vec2 cch_pos = vec2(pos.x - 0.75, pos.y - 0.5);
      // vec3 cch = x_box(cch_pos, u_time, audio, color);
      vec3 cch = purple_circle_oh_yes_he_is_mio(cch_pos, u_time, audio, color);
      pos = vec2(pos.x, pos.y);
      vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
      vec4 src_pixel = texture2D(u_tex0, src_coord);

      float raster_pattern = cch.r;
      float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
      gl_FragColor = vec4(src_pixel.b * u_bandpass * 2.0, cch.g, src_pixel.g * u_notch * 2.0, 1.0);

    }
  }

}

// void was_aligitator() {
//       pos = vec2(pos.x, pos.y);
//       vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
//       vec4 src_pixel = texture2D(u_tex0, src_coord);
//       vec3 hypno = color;
//       alligator(pos, u_time, audio, hypno);
//       // vec3 result = hypnoxyz + (1.0 - src_pixel.a) * src_pixel.xyz;
//
//       float avg = 0.2125 * src_pixel.r + 0.0154 * src_pixel.g + 0.07154 * src_pixel.b;
//       float raster_pattern = hypno.r;
//       float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
//       vec3 result = src_pixel.xyz + (1.0 - 0.997) * gray;
//
//       // gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);
//       // gl_FragColor = vec4(result.r * u_bandpass, color.b * u_lowpass, result.g * u_notch * 2.0, 1.0);
//       gl_FragColor = vec4(color.r, result.b * u_bandpass, result.g * u_notch * 2.0, 1.0);
//       // gl_FragColor = vec4(result.r * u_lowpass, gray * u_bandpass * 2.0, result.g * u_notch * 2.0, 1.0);
//       // gl_FragColor = vec4(src_pixel.r, gray * u_bandpass * 2.0, gray * u_notch * 2.0, 1.0);
//       // gl_FragColor = vec4(gray * color.r, gray * u_bandpass * 2.0, gray, 1.0);
//       // gl_FragColor = vec4(hypno.r, src_pixel.b, src_pixel.g, 1.0);
//       // gl_FragColor = vec4(hypno.r, src_pixel.b, gray * u_bandpass * 2.0, 1.0);
//       // gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);
// }
