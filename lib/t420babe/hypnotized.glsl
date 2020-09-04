#ifndef T420BABE_HYPNOTIZED
#define T420BABE_HYPNOTIZED

#ifndef COMMON_COMMON
#include "./lib/common/common.glsl"
#endif

#ifndef PXL_PXL
#include "./lib/pxl/00-pxl.glsl"
#endif


float hypno_triangle(vec2 st) {
    st = (st*2.-1.) * 1.5;
    return max(abs(st.x) * 0.866025 + st.y * 0.5, -st.x * 0.5);
}

// 88c657b, 20:07
void hypnotized_by_the_light(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch, 0.14117647058);

  float pct_circle = sharp(circle_1(pos * 1.1, 5.0 * audio.notch));
  float pct_tri_0 = sharp(hypno_triangle(pos + 0.5));
  float pct_tri_1 = sharp(hypno_triangle(pos));
  float pct_tri_2 = sharp(hypno_triangle(vec2(pos.x + 0.5, pos.y)));
  float pct_tri_3 = sharp(hypno_triangle(vec2(pos.x + 1.0, pos.y)));

  float pct_tri_4 = sharp(hypno_triangle(vec2(pos.x, pos.y + 1.0)));
  float pct_tri_5 = sharp(hypno_triangle(vec2(pos.x + 0.5, pos.y + 1.0)));
  float pct_tri_6 = sharp(hypno_triangle(vec2(pos + 1.0)));

  color += vec3(pct_circle * color);
  color -= vec3(pct_tri_0 * color.gbr);
  color += 0.1;
  color += vec3(pct_tri_1 * color);
  color += vec3(pct_tri_2 * color);
  color += vec3(pct_tri_3 * color);
  color += vec3(pct_tri_4 * color);
  color += vec3(pct_tri_5 * color);
  color += vec3(pct_tri_6 * color);
}
#endif
