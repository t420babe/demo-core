// Love at First Sight by TEEMID
#ifndef T4B_BL_10
#define T4B_BL_10

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "lib/pxl/00-pxl.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

vec4 arrival_10_08a(vec3 p3, float time, peakamp audio) {
  audio.bandpass  *= 2.0;
  audio.highpass  *= 5.0;
  audio.lowpass   *= 2.0;
  audio.notch     *= 10.0;
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 2.0;
  // rhom_p.x += 0.5;
  // rhom_p = rotate2d(time * 20.0) * rhom_p;
  rhom_p *= rotate2d(tan(time) * 3.14 / 1.0);
  // float flower_size = 6.5 * audio.lowpass;
  float flower_size = 2.5 * audio.notch;
  // float flower_size = 6.5 * audio.highpass;
  float flower = flower_sdf(vec2(rhom_p.x + flower_size / 2.0, rhom_p.y + flower_size / 2.0) / flower_size, 100);
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rhom_p, wrap_time(time * 0.5, 15.0) + 5.0, audio.highpass * 100.0 + 1.0);
  vec2 rays_p = rhom_p;
  rays_p.y += 1.0;
  float rays = rays_audio(rays_p, 20, audio);
  float bri = sharp(flower) * sin(hex);
  bri /= (rhombus) * 1.0;
  // color = 0.5 - color;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  // color = color.bgr;
  // color *= flash_add(color, time, 10.0);
  // color = color.gbr;
  color = color.grb;
  // color = rgb2hsv(color);

  return vec4(color, bri);

  // gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}


vec4 arrival_10_08b(vec3 p3, float time, peakamp audio) {
  audio.bandpass  *= 2.0;
  audio.highpass  *= 5.0;
  audio.lowpass   *= 2.0;
  audio.notch     *= 10.0;
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 2.0;
  // rhom_p.x += 0.5;
  // rhom_p = rotate2d(time * 20.0) * rhom_p;
  rhom_p *= rotate2d(tan(time) * 3.14 / 1.0);
  // float flower_size = 6.5 * audio.lowpass;
  float flower_size = 2.5 * audio.notch;
  // float flower_size = 6.5 * audio.highpass;
  float flower = flower_sdf(vec2(rhom_p.x + flower_size / 2.0, rhom_p.y + flower_size / 2.0) / flower_size, 100);
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rhom_p, wrap_time(time * 0.5, 15.0) + 5.0, audio.highpass * 100.0 + 1.0);
  vec2 rays_p = rhom_p;
  rays_p.y += 1.0;
  float rays = rays_audio(rays_p, 20, audio);
  float bri = sharp(flower) * sin(hex);
  bri /= tan(rhombus * 1.0);
  // color = 0.5 - color;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  // color = color.bgr;
  // color *= flash_add(color, time, 10.0);
  // color = color.gbr;
  color = color.grb;
  // color = rgb2hsv(color);

  return vec4(color, bri);

  // gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

vec4 arrival_10_05(vec3 p3, float time, peakamp audio) {
  audio.bandpass  *= 2.0;
  audio.highpass  *= 2.0;
  audio.lowpass   *= 2.0;
  audio.notch     *= 10.5;
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 2.0;
  // rhom_p.x += 0.5;
  // rhom_p = rotate2d(time * 20.0) * rhom_p;
  // rhom_p *= rotate2d(tan(time) * 3.14 / 1.0);
  float flower = flower_sdf(vec2(rhom_p.x + 2.5, rhom_p.y + 2.5) / 5.0, int(4.0 * audio.notch));
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rhom_p, wrap_time(time * 0.5, 15.0) + 5.0, audio.notch * 40.0 + 1.0);
  vec2 rays_p = rhom_p;
  rays_p.y += 1.0;
  float rays = rays_audio(rays_p, 20, audio);
  float bri = sharp(flower) - sin(hex);
  bri /= (rhombus) * 1.0;
  // color = 1.0 - color;
  color = vec3(bri * audio.highpass, bri * audio.notch, bri * audio.lowpass);
  color.r *= abs(sin(time));
  color.g *= abs(cos(time));
  color.b *= abs(tan(time));
  color = color.bgr;
  // color *= flash_add(color, time, 10.0);
  // color = color.gbr;
  // color = color.grb;

  return vec4(color, bri);

  // gl_FragColor = vec4(color, bri);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

void arrival_10(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  vec4 color_05 = arrival_10_05(p3, time, audio);
  vec4 color_08 = arrival_10_08b(p3, time, audio);

  float tr = wrap_time(time * 1.0, 1.0);
  color = mix(color_08.gbr, color_05.gbr, tr *audio.notch);
  float bri_mix = mix(color_05.a, color_05.a, 0.5);


  gl_FragColor = vec4(color, bri_mix);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

#endif
