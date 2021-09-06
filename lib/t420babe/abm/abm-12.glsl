#ifndef T4B_ABM_12
#define T4B_ABM_12

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "lib/pxl/00-pxl.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

float abm_12_rays_audio(vec2 st, int N, peakamp audio) {
    // st.y -= 0.7;
    // st.x +=1.2;
    return log(atan(st.x,st.y) * audio.notch * 1.01 /TWO_PI*float(N)) * audio.notch;
}

vec4 abm_12_05(vec3 p3, float time, peakamp audio) {
  // audio.bandpass  *= 1.0;
  // audio.highpass  *= 1.0;
  // audio.lowpass   *= 1.0;
  // audio.notch     *= 10.5;
  vec3 color = vec3(1.0);
  vec2 rhom_p = p3.xy * 2.0;
  rhom_p.y -= 1.0;
  rhom_p.y *= 2.0;
  vec2 rays_p = p3.xy * 3.0;
  // rhom_p.x += 0.5;
  // rhom_p = rotate2d(time * audio.notch * 10.0) * rhom_p;
  // rhom_p = rotate2d(sin(time) * 3.14 / 1.0) * rhom_p.yz;
  float rhombus = rhombus_sdf(rhom_p, 1.0);
  float hex = hexagon_sdf(rays_p, wrap_time(time * 0.5, 15.0) + 7.0, audio.notch * 40.0 + 1.0);
  rays_p.y += 1.0;
  float rays = abm_12_rays_audio(rays_p, 20, audio);
  float bri = sharp(hex) - sin(rays);
  bri *= audio.notch;
  // bri /= (rhombus) * 1.0;
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
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

vec4 abm_12_11(vec3 p3, float time, peakamp audio) {
  // p3 *= 0.9;
  // audio.notch     *= 1.5;
  // audio.bandpass  *= 1.5;
  // audio.lowpass   *= 1.5;
  // audio.highpass  *= 1.5;

  // audio.notch     *= 0.7;
  // audio.bandpass  *= 0.7;
  // audio.lowpass   *= 0.7;
  // audio.highpass  *= 0.7;

  vec3 color = vec3(1.0);

  vec2 rhom_p = p3.xy * 2.0;
  rhom_p.y -= 1.0;
  rhom_p.y *= 2.0;
  rhom_p = rotate2d(time * audio.notch * 10.0) * rhom_p;
  vec2 rays_p = -p3.xy * 2.0;
  // rays_p.y -= 0.5;

  float rhombus = rhombus_sdf(rhom_p, 1.0);

  float hex = hexagon_sdf(rhom_p, 10.0, audio.notch * 20.0);

  // float rays = abm_12_rays_audio(-p3.xy, 10, audio);
  float rays = abm_12_rays_audio(rays_p, 10, audio);

  float bri = sharp(hex) * sin(rays);
  bri *= audio.notch;

  // verse
  bri /= (rhombus) * 1.0;

  // main
 // bri /= (rhombus) * 1.0 * audio.notch;
  // bri /= (hex) * 1.0;

  // color = 1.0 - color;

  // color = vec3(bri);
  color.r *= bri;
  color.b *= bri;
  color.g *= bri;

  color.r *= audio.highpass;
  color.b *= audio.notch;
  color.g *= audio.lowpass;

  color.r *= 2.0;
  color.g *= 2.0;
  color.b *= 2.0;

  // color.r *= abs(sin(time)) + 0.05;
  // color.g *= abs(cos(time)) + 0.05;
  // color.b *= abs(tan(time)) + 0.05;
  color = color.bgr;
  // color = color.gbr;
  // color = color.grb;

  return vec4(color, bri);

  // gl_FragColor = vec4(color, bri);
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}

void abm_12(vec3 p3, float time, peakamp audio) {
  audio.bandpass  *= 0.1;
  audio.highpass  *= 0.1;
  audio.lowpass   *= 0.1;
  audio.notch     *= 0.1;
  vec3 color = vec3(1.0);
  vec4 color_05 = abm_12_05(p3, time, audio);
  vec4 color_11 = abm_12_11(p3, time, audio);

  float tr = wrap_time(time * 1.0, 1.0);
  color = mix(color_11.rgb, color_05.rgb, tr *audio.notch);
  float bri_mix = mix(color_11.a, color_11.a, tr);


  gl_FragColor = vec4(color, bri_mix);
  gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
}
#endif
