#ifdef GL_ES
precision mediump float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif


#ifndef T420BABE
#include "./lib/t420babe/00-t420babe.glsl"
#endif

#ifndef COMMON_COMMON
#include "./common/00-common.glsl"
#endif

#ifndef PXL
#include "./pxl/00-pxl.glsl"
#endif

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef UNIFORMS
#define UNIFORMS
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#endif


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

float PI180 = float(PI / 180.0);

float sind(float a) { return sin(a * PI180); }
float cosd(float a) { return cos(a * PI180); }
float added(vec2 sh, float sa, float ca, vec2 c, float d) {
  return 0.5 + 0.25 * cos((sh.x * sa + sh.y * ca + c.x) * d) + 0.25 * cos((sh.x * ca - sh.y * sa + c.y) * d);
}

// float okay(float ratio, vec2 pos, ) {
//       // float ratio = 1.0;
//
//       // vec2 dst_coord = vec2(pos.x - 0.5, pos.y * 0.5) * 2.0;
//       vec2 dst_coord = vec2(pos.x, pos.y);
//       // vec2 src_coord = vec2(pos.x - 0.5, pos.y * 0.5) * 2.0;
//       // vec2 src_coord = vec2(pos.x - 1.0, pos.y);
//       vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
//       vec2 rotation_center = vec2(0.0);
//       vec2 shift = dst_coord - rotation_center;
//
//       float dot_size = 15.0;
//       float angle = 45.0;
//
//       float raster_pattern = added(shift, sind(angle), cosd(angle), rotation_center, PI / dot_size * 680.0);
//       return raster_pattern;
// }

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

      float dot_size = 5.0;
      float angle = 45.0;

      float raster_pattern = added(shift, sind(angle), cosd(angle), rotation_center, PI / dot_size * 680.0);
      vec4 src_pixel = texture2D(u_tex0, src_coord);

      float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
      vec3 gray_color = vec3(gray);
      vec3 color = my_mix();

      // gray = rater_pattern;
      // gl_FragColor = vec4(gray, gray, gray, 1.0);
      gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);
      // gl_FragColor = vec4(gray * u_bandpass * 2.0, gray * u_lowpass, gray * u_notch * 2.0, 1.0);

    } else {
      gl_FragColor = texture2D(u_tex0, pos);
    }
  } else {
    if (pos.y < 0.0) {
      pos = vec2(pos.x, pos.y);
      vec2 src_coord_1 = vec2(pos.x - 1.0, pos.y - 1.0);
      // vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);

      vec4 src_pixel = texture2D(u_tex0, src_coord_1);
      vec3 rainbow = rainbow_scales(pos, u_time);
      float raster_pattern = rainbow.r;
      float avg = 0.2125 * src_pixel.r + 0.7154 * src_pixel.g + 0.07154 * src_pixel.b;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);

      // gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);
      gl_FragColor = vec4(color.b, gray * u_bandpass * 2.0, gray * u_notch * 2.0, 1.0);
      // gl_FragColor = vec4(src_pixel.r, rainbow.b, src_pixel.g, 1.0);
    } else {
      pos = vec2(pos.x, pos.y);
      vec2 src_coord = vec2(pos.x - 1.0, pos.y - 1.0);
      vec4 src_pixel = texture2D(u_tex0, src_coord);
      // float result = src_pixel.a;
      vec3 hypno = vec3(0.0);
      alligator(pos, u_time, audio, hypno);
      // vec3 result = hypnoxyz + (1.0 - src_pixel.a) * src_pixel.xyz;

      float avg = 0.2125 * src_pixel.r + 0.0154 * src_pixel.g + 0.07154 * src_pixel.b;
      float raster_pattern = hypno.r;
      float gray = (raster_pattern * threshold + avg - threshold) / ( 1.0 - threshold);
      vec3 result = src_pixel.xyz + (1.0 - 0.99) * gray;

      // gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);
      gl_FragColor = vec4(result.r * u_bandpass, color.b * u_lowpass, result.g * u_notch * 2.0, 1.0);
      // gl_FragColor = vec4(src_pixel.r, gray * u_bandpass * 2.0, gray * u_notch * 2.0, 1.0);
      // gl_FragColor = vec4(gray * color.r, gray * u_bandpass * 2.0, gray, 1.0);
      // gl_FragColor = vec4(hypno.r, src_pixel.b, src_pixel.g, 1.0);
      // gl_FragColor = vec4(hypno.r, src_pixel.b, gray * u_bandpass * 2.0, 1.0);
      // gl_FragColor = vec4(gray * u_bandpass * 2.0, color.b, gray * u_notch * 2.0, 1.0);

    }
  }

}
