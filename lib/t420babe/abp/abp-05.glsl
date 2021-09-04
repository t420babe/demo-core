#ifndef T4B_ABP_05
#define T4B_ABP_05

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

mat2 abp_05_scale(vec2 _abp_05_scale) {
  return mat2(_abp_05_scale.x, 0.0, 0.0, _abp_05_scale.y);
}

// Overload for scalar 
mat2 abp_05_scale(float _abp_05_scale) {
  return mat2(_abp_05_scale, 0.0, 0.0, _abp_05_scale);
}

float spinning_cirlces_illusion(vec2 st, float time, float time_abp_05_scale, float offset, float smoothing_factor){
  // Translate to center of screen (assumes normalized st coords)
  vec2 center = vec2(0.5);
 // Translate coords - remember origin in in the btm left
  st -= center;
  st = rotate2d((time)) * st;
  // float circle = (0.);
  // Circle centered at 0,0 since already translated
  float circle = circle_outline(st, vec2(0.0), 0.25, 0.005);
  // Untranslate coords 
  st += center;

  // int t = 12;
  for(int i = 0; i < 20; i++){
    // float r = 0.25;
    // float r = 0.5;
    float r = wrap_time(time * 0.3, 0.5);
    // st = abp_05_scale(1.5)*st;
    float new_center_x = r * cos(float(i) * TWO_PI / 18.);
    float new_center_y = r * sin(float(i) * TWO_PI / 18.);
 // Relative to translated coord sys (dividing with numbers with various common factors leads to more symmetric or chaotic ring resonance)
    vec2 new_center = vec2(new_center_x, new_center_y);
    // Translate coords - remember origin in in the btm left
    st -= center;
    st = rotate2d(time * time_abp_05_scale) * st;
    // circle += plot(st, r);
    vec2 travelling_center = vec2(0.0);

    circle += circle_outline(st, new_center, 0.25, smoothing_factor); //circle centered at 0,0 since already translated
    // Untranslate coords 
    st += center;
  }

  return circle;
}

void abp_05(vec3 p3, float time, peakamp audio) {
  vec2 st = p3.xy;
  st += 0.5;
  vec2 xy = st;
  // st = fract(st); //wrap arouncd 1 to create tiles

  // float warp = fbm(xy*cellular_noise(st, 5.));
  // vec2 warp = rotate2d(0.3 * fbm(xy * cellular_noise(st, 5.0) ) ) * st; //rotate
  vec2 warp = rotate2d(0.3 * time) * st; //rotate
  // float circle = circle_outline(warp, vec2(0.5);
  float circle = circle(warp, vec2(0.5), 0.25, 0.135);

  vec3 color = vec3(0);

  // color += circle;
  color += spinning_cirlces_illusion(st, time, 0.15, fbm(xy * cellular_noise(st, 5.0) * sin(time)), 0.005);

  gl_FragColor = vec4(color, 1.0);
}

#endif
