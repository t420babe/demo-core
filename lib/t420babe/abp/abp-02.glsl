#ifndef T4B_ABP_02
#define T4B_ABP_02

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef PXL_CIRCLE
#include "lib/pxl/circle-sdf.glsl"
#endif

#ifndef COMMON_PERMUTE
#include "lib/common/permute.glsl"
#endif

#ifndef COMMON_NOISE
#include "lib/common/noise.glsl"
#endif

#ifdef GL_ES
precision mediump float;
#endif

// Forked from: https://www.shadertoy.com/view/Ndt3z7

float spinning_cirlces_illusion(vec2 st, float time, peakamp audio){
  // float f_smooth = 0.020;
  float f_smooth = 0.05 * audio.notch;
  float rate_time = 0.15;

  vec2 center = vec2(0.5);
  st -= center;

  st = rotate2d((rate_time * time)) * st;
  float circle = 0.0;
  st += center;

  float radius = audio.lowpass * 2.0;

  for(int i = 0; i < 20; i++){
    float r = 0.15;

    float new_center_x = r * cos(float(i) * PI);
    float new_center_y = r * sin(float(i) * PI);
    vec2 new_center = vec2(cos(new_center_x), sin(new_center_y));

    st -= center;
    st = rotate2d(time * rate_time) * st;

    // circle += plot(st, r, 0.005);
    vec2 travelling_center = vec2(sin(time));
    new_center += travelling_center - 0.5;

    circle += circle_outline(st, new_center, radius, f_smooth); //circle centered at 0,0 since already translated
    // Untranslate coords 
    st += center;
  }

  return circle;
}

void abp_02(vec3 p3, float time, peakamp audio) {
  vec2 st = p3.xy * 2.0;
  st += 0.5;
  vec2 xy = st;
  // st = fract(st) + 0.1; //wrap arouncd 1 to create tiles

  // float warp = fbm(xy*cellular_noise(st, 5.));
  // vec2 warp = rotate2d(0.3 * fbm(xy * cellular_noise(st, 5.0) ) ) * st; //rotate
  vec2 warp = rotate2d(0.3 * time) * st; //rotate

  vec3 color = vec3(0);

  // color += circle;
  color += spinning_cirlces_illusion(st, time, audio);

  gl_FragColor = vec4(color, 1.0);
}

#endif

